# Project Templates

This directory contains the canonical project template used for scaffolding new AgentOS projects.

## Structure

\\\
templates/
└── project_template/
    ├── README.md               # Project homepage
    ├── PROJECT_MANIFEST.md     # Project identity and governance
    ├── PROJECT_MEMORY.md       # Project-level memory
    ├── ENGINEERING_JOURNAL.md  # Session journal
    ├── DECISION_LOG.md         # Decision tracking
    ├── ISSUES.md               # Issue tracking
    ├── HANDOFF.md              # Session handoff
    └── NEXT_SESSION.md         # Next session instructions
\\\"

## Usage

Copy the template for each new project:

\\\ash
cp -r templates/project_template/ Project_01_your-project/
\\\

Or use the scaffolding script:

\\\ash
bash scripts/create_project.sh "your-project"
\\\

## Important

The template files contain embedded explanations and instructions. Customize them for each project but keep the structure intact. Do not modify the originals in this directory — they are the canonical copies for all future projects.
