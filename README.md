# AgentOS Core

**A Production-Ready Operating System for AI Coding Agents**

Stop Context Pollution. Build AI Projects That Scale.

---

## Why AgentOS

Every AI coding session has a fundamental problem: context pollution. Each new session starts with a blank slate. Past decisions disappear. Engineering choices are lost. Standards drift across projects. The AI has no memory, no workspace discipline, and no consistent methodology.

AgentOS solves this by providing a structured operating system for AI agents — a deterministic framework that governs how agents read, write, remember, and hand off work. It is not a collection of Markdown templates. It is a complete workspace architecture with:

- **Context Engineering** — explicit context layers that prevent prompt pollution and preserve session fidelity.
- **Persistent Memory** — cross-session memory that survives context window resets.
- **Workspace Control Plane** — a manifest-driven governance layer that enforces project structure, naming, and reading order.
- **Decision Layer** — every design choice is logged with rationale, alternatives, and trade-offs.
- **AI Handoff Protocol** — deterministic session recovery so no session starts from zero.

## Who Should Use AgentOS

| Role | Why |
|------|-----|
| Claude Code / Codex users | Maintain long-running, coherent AI workflows |
| Cursor / Windsurf users | Enforce project-wide context across sessions |
| MCP developers | Build composable AI toolchains with deterministic memory |
| AI-first engineers | Treat AI as a reliable engineering team member |
| Indie hackers / founders | Scale AI-assisted development without context debt |

## Features

- **Context Isolation** — each project gets its own sealed context boundary. No cross-contamination.
- **Global Memory Layer** — shared standards, conventions, and reusable knowledge. Updated intentionally.
- **Project Memory Layer** — per-project architecture, decisions, and session state.
- **Deterministic Reading Order** — the AI always reads the right files in the right sequence.
- **Session Handoff Protocol** — end every session with a machine-readable state snapshot for instant recovery.
- **Decision Logging** — every non-trivial choice is captured with rationale, alternatives, and outcome.
- **Template System** — opinionated project templates with embedded guidance for the AI.
- **Workspace Manifest** — a single source of truth for the entire workspace topology.

## Architecture

\\\mermaid
graph TB
    subgraph Workspace
        WM[00_WORKSPACE_MANIFEST.md]
        GM[02_GLOBAL_MEMORY.md]
        EP[03_ENGINEERING_PRINCIPLES.md]
    end

    subgraph "Project Layer"
        PM[PROJECT_MANIFEST.md]
        PR[PROJECT_MEMORY.md]
        EJ[ENGINEERING_JOURNAL.md]
        DL[DECISION_LOG.md]
        HO[HANDOFF.md]
    end

    subgraph "AI Agent"
        CE[01_CONTEXT_ENGINE.md]
        NP[04_NEW_PROJECT_PROTOCOL.md]
        HP[05_HANDOFF_PROTOCOL.md]
        AR[06_AGENT_RULES.md]
    end

    WM --> CE
    CE --> PM
    GM --> PM
    EP --> PM
    PM --> PR
    PR --> EJ
    PR --> DL
    PR --> HO

    NP --> CE
    HP --> CE
    AR --> CE

    style WM fill:#1a1a2e,stroke:#e94560,color:#fff
    style CE fill:#16213e,stroke:#0f3460,color:#fff
    style PR fill:#0f3460,stroke:#0f3460,color:#fff
\\\

### Architecture Layers

**Layer 1: Workspace Control Plane** — Global workspace configuration, standards, and shared memory. Lives at the workspace root and governs all projects.

**Layer 2: Context Engine** — The AI reads contextual configuration first. This layer defines how the AI sees the workspace, what it should prioritize, and how it should interpret project-level documents.

**Layer 3: Project Control Plane** — Per-project governance. Each project has a manifest, memory, decision log, and handoff state. Projects are isolated from each other.

**Layer 4: Memory Layer** — Two-tiered memory: Global (cross-project standards) and Project (architecture, decisions, session state). Memory is written intentionally, not accumulated passively.

**Layer 5: Session Layer** — Deterministic session start and handoff. Every session begins from a known state and ends with a recovery checkpoint.

## Folder Structure

\\\
AgentOS/
├── README.md                  # Product homepage (this file)
├── QUICKSTART.md              # 5-minute setup guide
├── INSTALL.md                 # Detailed installation
├── CHANGELOG.md               # Version history
├── LICENSE                    # License terms
│
├── 00_WORKSPACE_MANIFEST.md   # Workspace governance
├── 01_CONTEXT_ENGINE.md       # Context engineering framework
├── 02_GLOBAL_MEMORY.md        # Cross-project memory layer
├── 03_ENGINEERING_PRINCIPLES.md # Engineering philosophy
├── 04_NEW_PROJECT_PROTOCOL.md # Project initialization protocol
├── 05_HANDOFF_PROTOCOL.md     # Session handoff and recovery
├── 06_AGENT_RULES.md          # Agent behavioral contract
│
├── templates/                 # Project scaffolding
│   ├── README.md
│   └── project_template/
│       ├── README.md
│       ├── PROJECT_MANIFEST.md
│       ├── PROJECT_MEMORY.md
│       ├── ENGINEERING_JOURNAL.md
│       ├── DECISION_LOG.md
│       ├── ISSUES.md
│       ├── HANDOFF.md
│       └── NEXT_SESSION.md
│
├── examples/                  # Reference implementations
│   ├── WebApp/
│   ├── PythonPackage/
│   └── CLI/
│
└── scripts/                   # Automation helpers
    ├── create_project.sh
    └── create_project.bat
\\\"

## Quick Start (3 minutes)

\\\ash
# 1. Copy AgentOS into your workspace
cp -r AgentOS /your-workspace/

# 2. Initialize a new project
cd /your-workspace
bash AgentOS/scripts/create_project.sh "my-web-app"

# 3. Start an AI session
cat AgentOS/00_WORKSPACE_MANIFEST.md AgentOS/01_CONTEXT_ENGINE.md AgentOS/06_AGENT_RULES.md
\\\

For the full quick start guide, see [QUICKSTART.md](./QUICKSTART.md).

## How It Works

### The Session Lifecycle

\\\mermaid
sequenceDiagram
    participant D as Developer
    participant W as Workspace
    participant A as AI Agent

    D->>W: Create/modify project files
    D->>A: Start AI session
    A->>W: Read WORKSPACE_MANIFEST
    A->>W: Read CONTEXT_ENGINE
    A->>W: Read AGENT_RULES
    A->>W: Read PROJECT_MANIFEST
    A->>W: Read PROJECT_MEMORY
    A->>W: Read HANDOFF (if exists)
    Note over A: Context assembled
    A->>W: Execute engineering tasks
    A->>W: Write DECISION_LOG
    A->>W: Write ENGINEERING_JOURNAL
    A->>W: Write HANDOFF
    A->>D: Session complete
\\\"

### Decision Flow

1. The AI always reads the workspace manifest first
2. The context engine configures the AI's reading strategy
3. Project manifest provides the project's current state
4. Project memory provides architectural context
5. Handoff document provides last session's state
6. The AI works, then writes decisions, journal, and handoff
7. Next session reads the handoff for instant recovery

## FAQ

**Q: Is AgentOS tied to a specific AI tool?**
No. AgentOS works with Claude Code, Codex, Cursor, Windsurf, Gemini CLI, and any AI agent that reads text files. It is tool-agnostic.

**Q: Can I use AgentOS with existing projects?**
Yes. Add the workspace manifest and context engine to your existing root. Create a PROJECT_MANIFEST.md for each project you want under AgentOS governance. Zero migration required.

**Q: How is AgentOS different from a .cursorrules or CLAUDE.md file?**
Cursor rules and CLAUDE.md are per-tool config files. AgentOS is a workspace architecture — a multi-file, layered framework with memory, handoff protocols, and project isolation. It composes with those files, not replaces them.

**Q: Does AgentOS add overhead?**
The first session takes 30–60 seconds to read the core documents. Subsequent sessions are faster because memory persists. The overhead is recouped the first time you recover a session that would otherwise start from zero.

**Q: What if the AI ignores the rules?**
AgentOS is designed for visibility and accountability. The handoff document captures what happened. The decision log captures why. If the AI deviates, the next session can detect and correct it.

## Roadmap

| Version | Focus |
|---------|-------|
| Core v1.0 (this) | Workspace architecture, context engine, memory layer, handoff protocol |
| Pro v1.0 | MCP server integration, automated context compression, workspace analytics |
| Pro v1.1 | Multi-agent orchestration, real-time memory sync, dashboard |

## License

AgentOS Core is available under a commercial license. See [LICENSE](./LICENSE).

---

**AgentOS** — A Production-Ready Operating System for AI Coding Agents.