import numpy as np
import pandas as pd
import pywt
from pycaret.classification import *

# =============================================
# 1. Génération de données (Signal + Panne)
# =============================================
def generate_maintenance_data(n_points=1000):
    np.random.seed(42)
    time = np.linspace(0, 100, n_points)
    
    # Signal de base (vibration normale) + Bruit
    signal = np.sin(time) + np.random.normal(0, 0.2, n_points)
    
    # Injection de pannes (augmentation de l'amplitude/fréquence)
    target = np.zeros(n_points)
    fault_indices = np.random.choice(range(n_points), size=50, replace=False)
    for idx in fault_indices:
        signal[idx:idx+5] += np.random.normal(2, 0.5) # Choc
        target[idx:idx+5] = 1
        
    return pd.DataFrame({'timestamp': time, 'vibration': signal, 'failure': target})

# =============================================
# 2. Feature Engineering (Ondelettes)
# =============================================
def add_wavelet_features(df, column='vibration'):
    """Extrait l'énergie des coefficients de détail (Haute fréquence)"""
    # Utilisation de Daubechies 4
    wavelet = 'db4'
    
    def get_wavelet_energy(x):
        # Décomposition niveau 1 : cA (approximation), cD (détail)
        cA, cD = pywt.dwt(x, wavelet)
        return np.sum(np.square(cD)) # Énergie du détail

    # Application sur une fenêtre glissante de 10 points
    df['wavelet_energy'] = df[column].rolling(window=10).apply(get_wavelet_energy)
    return df.dropna()

# =============================================
# 3. Pipeline AutoML
# =============================================
# Préparation
raw_data = generate_maintenance_data()
data_with_features = add_wavelet_features(raw_data)

# Setup PyCaret
# fix_imbalance=True car les pannes sont rares
s = setup(data=data_with_features, 
          target='failure', 
          ignore_features=['timestamp'],
          fix_imbalance=True, 
          session_id=123)

# Comparaison et entraînement du meilleur modèle
print("Comparaison des modèles en cours...")
best_model = compare_models(sort='Recall') # Priorité au Rappel pour la maintenance

# Finalisation et explicabilité
final_model = finalize_model(best_model)
evaluate_model(final_model)

# Sauvegarde
save_model(final_model, 'maintenance_wavelet_model')