### Slide 1 — From Imagery to Actionable Intelligence

**Subtitle:** Accelerating satellite data exploitation for faster military decisions (Defense)

* **Context & Problem:** High-frequency satellite imagery (IMINT) streams exceed manual processing limits. This data-to-intelligence gap creates a bottleneck, preventing real-time reporting and resulting in high decision latency.
* **Why Prioritized:** Objective is to accelerate the **OODA loop** (Observe-Orient-Decide-Act). Minimizing the time between raw data acquisition and structured intelligence is a prerequisite for maintaining operational initiative in command centers.
* **Solution & Rationale:** Implementation of a **Multimodal RAG + ReAct** architecture. Hybrid model approach: **GPT-4V** for high-reasoning MVP validation and **Apache 2.0 Open Source models** for secure, sovereign **on-premise** production.
* **Architecture:** Asynchronous pipeline using **ViT encoders** for semantic feature extraction. **ReAct agentic loops** orchestrate contextual retrieval and cross-reference detections with tactical databases to synthesize deterministic reports.
Raw Telemetry $\rightarrow$ ViT Encoding $\rightarrow$ Vector Persistence $\rightarrow$ RAG Retrieval $\rightarrow$ ReAct Reasoning $\rightarrow$ ISR Report.
* **Technologies:** Multimodal LLMs (GPT-4V / Apache 2.0 OS), LangChain, Python, Gitlab CI/CD, Vector DB.
* **Value / ROI:** Achieved a **20% reduction in report generation latency** and a 15% increase in total operational exploitation capacity per analyst.
* **Investment:** 1-month scoping and project launch phase. Focused on **automated report generation** and architectural alignment within an Agile (Scrum) framework.

### Slide 2 — Optimizing Battlefield Logistics Decisions

**Subtitle:** AI-driven allocation under complex operational constraints (Defense)

* **Context & Problem:** High fleet mobility in multiple theaters makes manual logistics deployment a bottleneck. The complexity of resource allocation (spare parts, maintenance, asset readiness) under unstable operational environments prevents optimal mission preparation.
* **Why Prioritized:** Strategic showcase for the **Paris Air Show**. The objective is to demonstrate operational superiority by ensuring the "right stocks, in the right place, at the right time," shrinking the logistical footprint while maximizing fleet availability.
* **Solution & Rationale:** Implementation of a **Hybrid Operations Research (OR) + Machine Learning** framework. Optimization algorithms handle deterministic constraints (rules-driven asset allocation), while ML/Deep Learning models manage predictive maintenance and early fault detection to mitigate operational uncertainty.
* **Architecture:** Integration of multi-source operational data $\rightarrow$ Predictive analysis via **LightGBM** (asset health/failure probabilities) $\rightarrow$ Constraint-based modeling and solving via **OR-Tools** $\rightarrow$ Real-time mission success probability calculation $\rightarrow$ Optimized Deployment Plan.
Constraints $\rightarrow$ LightGBM (Predictive) $\rightarrow$ OR-Tools Solver $\rightarrow$ EKS/Azure $\rightarrow$ Optimized Plan.
* **Technologies:** Machine Learning (LightGBM), **Symbolic AI** (asset ranking), Optimization Algorithms (**OR-Tools**), EKS (Kubernetes), Azure, Gitlab CI.
* **Value / ROI:** Achieved a **15% reduction in allocation errors**. Significant decrease in preparation workload and logistical costs through automated, rules-driven asset alignment with evolving mission timelines.
* **Investment:** 6-month industrialization phase. Focus on high-resilience deployment (TrustNest Restricted) and the integration of predictive failure models into the decision loop.

### Slide 3 — Spatial Localization of Blade Defects

**Subtitle:** 3D-to-2D registration for automated engine inspection (Aerospace)

* **Context & Problem:** Boroscopic images exhibit high perspective distortion, preventing accurate mapping of 2D detections to 3D CAD models. Manual localization is insufficient for precise structural integrity assessment.
* **Why Prioritized:** Required for high-fidelity damage tracking. Determining exact 3D coordinates is mandatory to monitor defect evolution and validate repair tolerances in turbine blade lifecycles.
* **Solution & Rationale:** 3D-to-2D registration PoC using boroscopic RGB-D data. Evaluation of **Geometric (ICP + PnP)** vs. **Neural (FoundationPose)** pipelines. Integration of **MAPIE** to provide rigorous uncertainty quantification for the estimated 6D pose.
* **Architecture:** Modular 4-Work Package (WP) structure. The pipeline estimates the camera pose relative to the mesh and projects 2D pixels into 3D space, followed by a statistical validation layer.
Boroscopic RGB-D → WP1: Pre-processing → WP2: Pose (ICP+PnP / FoundationPose) → WP3: 3D Mapping → WP4: MAPIE Uncertainty Scoring.
* **Technologies:** FoundationPose, ICP, PnP, MAPIE, PyTorch3D, Trimesh, Open3D.
* **Value / ROI:** Millimeter-level localization accuracy with quantified confidence intervals. Transition from qualitative checks to deterministic 3D spatial data.
* **Investment:** 4-month PoC | 4 Work Packages.

### Slide 4 — Sovereign Edge AI for Vehicle Diagnostics

**Subtitle:** Secure LLM deployment for confidential automotive data (Automotive & Energy)

* **Context & Problem:** Automated interpretation of multi-protocol vehicle telemetry (**CAN / OBD-II**) under strict confidentiality. Cloud-based analysis is prohibited due to industrial IP risks and data privacy mandates.
* **Why Prioritized:** Absolute **Digital Sovereignty**. Secure, air-gapped diagnostic capabilities are required for sensitive industrial missions where zero cloud access is permitted.
* **Solution & Rationale:** Local LLM deployment using **Ollama/Phi-3**. A hybrid decoding pipeline translates raw hexadecimal frames and OBD-II PID codes into semantic tokens for privacy-preserving reasoning.
* **Architecture:** Real-time ingestion of CAN/OBD frames via a **Python-CAN** and **OBD parser**. Data is indexed in **ChromaDB** for local RAG, allowing the model to perform diagnostic inference without external connectivity.
CAN & OBD Bus → Python Parser → Local LLM (Ollama) + ChromaDB → Secure Diagnosis.
* **Technologies:** Ollama, Phi-3, ChromaDB, Python-CAN, Python-OBD, FastAPI, Docker.
* **Value / ROI:** **Zero data leakage**. Real-time vehicle diagnostics with 100% on-premise execution, securing industrial opportunities in highly restricted environments.
* **Investment:** 3 months | Edge AI.


### Slide 5 — Scaling Industrial Impact Analysis with Graphs

**Subtitle:** Managing complex dependencies at production scale (Aerospace)

* **Context & Problem:** Change impact analysis across multiple Bills of Materials (**xBOM**) is hindered by rigid relational database structures. Navigating deep recursive dependencies (10M+ nodes) causes significant performance bottlenecks.
* **Why Prioritized:** Risk of production line blockage. Rapidly calculating the ripple effect of a technical change is critical to maintaining industrial flow and preventing costly configuration errors.
* **Solution & Rationale:** Migration to a **Graph Database** (ArangoDB) model. This natively handles complex industrial ontologies and many-to-many relationships, enabling real-time traversal of massive dependency trees.
* **Architecture:** High-speed ingestion of xBOM data via **Polars** for parallelized ETL. Data is modeled into **ArangoDB**, where **AQL** (ArangoDB Query Language) performs recursive impact analysis, served via a **FastAPI** backend.
xBOM Data → Polars Ingestion → ArangoDB (AQL) → FastAPI → Impact Report.
* **Technologies:** ArangoDB, Polars, FastAPI, Docker, AQL.
* **Value / ROI:** **-20% impact analysis time**. Full automation of configuration delta calculations and significant reduction in manual cross-referencing errors.
* **Investment:** 5-month development cycle | High-scale Data Engineering.


### Slide 6 — Industrializing AI at Scale

**Subtitle:** Engineering reliable and auditable GenAI systems (AI Factory)

* **Context & Problem:** Transitioning from stochastic PoCs to production-grade services often accumulates technical debt. Scaling requires addressing non-deterministic model behaviors and the lack of type-safety in agentic workflows.
* **Why Prioritized:** **Industrial Compliance & Digital Sovereignty**. Requirement for auditable AI lifecycles to ensure secure and resilient GenAI deployments under enterprise-grade loads.
* **Solution & Rationale:** Engineering framework based on **SOLID** principles and **TDD**. Implementation of **Agentic DevOps**: using **PydanticAI** for schema-enforced, type-safe reasoning and **OpenHands** within **Docker** sandboxes to automate development and deployment tasks.
* **Architecture:** Containerized stack where **OpenHands** manages autonomous tasks. Logic built with **PydanticAI** for runtime validation of model outputs. High-performance inference via **vLLM** on **Kubernetes**, monitored by **Arize Phoenix** and **DeepEval** for RAG quality and alignment.
* *Flow:* CI/CD → OpenHands + PydanticAI (Docker) → vLLM (K8s) → Arize Phoenix / DeepEval.


* **Technologies:** PydanticAI, OpenHands, Kubernetes, vLLM, Docker, Arize Phoenix, DeepEval, GitLab CI.
* **Value / ROI:** Significant reduction in **Time-to-Market**. Long-term operational sustainability through standardized architectures and technical mentorship.
* **Investment:** 6-month Lead Architect mandate.


### Slide 7 — Driving AI Value Through Automated Governance

**Subtitle:** Real-time ROI tracking for strategic decision-making (AI Factory)

* **Context & Problem:** Strategic financial steering was hindered by manual, Excel-based ROI tracking. This process proved too slow and prone to errors to effectively secure 2026 budgets for industrial AI initiatives.
* **Why Prioritized:** Strategic necessity for data-driven financial governance. Precise, real-time tracking is required to justify investment value and performance for sensitive **On-premise AI** projects.
* **Solution & Rationale:** Implementation of a high-velocity **"Small Data"** architecture. Using **DuckDB** for optimized analytical performance without the overhead of massive clusters, coupled with **PydanticAI** agents to validate data integrity.
* **Architecture:** Ingestion of heterogeneous financial and operational sources via **Mage-ai** pipelines. Data is structured in **DuckDB** for rapid querying, while **PydanticAI** agents automate compliance and anomaly detection before surfacing KPIs via **Datasette**.
* *Flow:* Sources → Mage-ai Pipelines → DuckDB → PydanticAI Validation Agents → Dashboard.


* **Technologies:** Mage-ai, PydanticAI, DuckDB, Datasette, Python.
* **Value / ROI:** **-15% weekly management time** through automation. Delivery of reliable, real-time business KPIs for budget optimization and executive steering.
* **Investment:** 3-month development cycle.


### Slide 8 — Accelerated Dynamics for Robotic Autonomy

**Subtitle:** Real-time VLA orchestration for autonomous vehicle control (Physics / AI Factory)

* **Context & Problem:** Integrating **Vision-Language-Action (VLA)** policies into robotic hardware often introduces prohibitive latency. Traditional middleware overhead prevents the fluid execution of natural language instructions in dynamic environments.
* **Why Prioritized:** High-stakes R&D for autonomous control. The objective is to achieve low-latency, end-to-end robotic autonomy where high-level linguistic commands are translated into precise physical actions in real-time.
* **Solution & Rationale:** Orchestration via **dora-rs** for its high-performance, **zero-copy** communication capabilities. This is paired with a **SmolVLA** policy (LeRobot) to maintain a small memory footprint while ensuring rapid inference on edge hardware.
* **Architecture:** Hierarchical control loop where the **VLA-Brain** processes multi-modal inputs. The system interfaces with the **Genesis Physics Engine** for high-fidelity simulation, utilizing **dora-rs** for efficient message passing between the control terminal and the physical actuators.
* *Flow:* Control Input → VLA-Brain (SmolVLA) → Simulator (Genesis) → Real-time Visualizer (MJPEG).


* **Technologies:** dora-rs, Genesis Physics Engine, PyTorch, LeRobot (SmolVLA), Docker, `uv` (Package Management).
* **Value / ROI:** Achieved a stable closed-loop control pipeline at **20Hz (50ms latency)**. Established a modular, reproducible deployment framework via `uv`, drastically reducing the environment setup time for robotic fleets.
* **Investment:** Agile R&D Project | Full-stack Robotics & AI.

