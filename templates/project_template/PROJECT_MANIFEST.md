# PROJECT_MANIFEST

**Purpose**: This is the single source of truth for project identity, goals, and constraints.
It is the first project-level document the AI reads.

---

## Identity

- **Project Name**:
- **Project Number**:
- **Date Created**:
- **Status**: (Active / Archived / Deprecated)

## Mission

One paragraph explaining what this project builds and why it exists.

## Goals

- Goal 1
- Goal 2
- Goal 3

## Non-Goals

- Non-goal 1
- Non-goal 2

## Tech Stack

| Technology | Version | Purpose |
|-----------|---------|---------|
| Language | e.g., Node 20 | Runtime |
| Framework | e.g., Express | HTTP server |
| Database | e.g., PostgreSQL 16 | Primary store |

## Key Constraints

- Constraint 1 (e.g., "Must support 10K concurrent users")
- Constraint 2 (e.g., "Must comply with SOC 2")

## Dependencies

### Internal Dependencies

- Project_XX_name — what it provides

### External Dependencies

- Service / library — version — purpose

## Contracts

- API contract location
- Data flow diagrams location

## References

- Relevant Global Memory sections
- External documentation links

## Reading Order for This Project

```
1. PROJECT_MANIFEST.md (this)
2. PROJECT_MEMORY.md
3. DECISION_LOG.md (for context on past decisions)
4. HANDOFF.md (if resuming)
5. NEXT_SESSION.md (if resuming)
```
