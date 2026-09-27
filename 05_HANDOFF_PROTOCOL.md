# 05 — Handoff Protocol

**Purpose**: Define how an AI agent ends a session, records its state, and prepares for the next session. Enable deterministic session recovery.

---

**Table of Contents**
- Concept
- When to Hand Off
- Handoff Process
- State Recording
- Decision Recording
- Task Recording
- Recovery Process
- Example Handoff
- Recovery Checklist
- FAQ
- Summary

---

## Concept

Every AI session ends. When it does, the agent's context vanishes — along with everything it learned, decided, and partially completed during the session. Without a structured handoff, the next session starts from zero: the new agent has no idea what was done, what was decided, or what comes next.

The Handoff Protocol solves this by capturing the session's state in a machine-readable format before the agent exits. The next agent reads the handoff and resumes exactly where the previous agent left off.

## When to Hand Off

A handoff is required in these situations:

- **End of session**: The AI has completed its work for this session
- **Context window pressure**: The AI is running low on context and needs to checkpoint
- **Task interruption**: A higher-priority task interrupts the current work
- **Complex multi-step work**: Between major phases of a long task
- **Blocker encountered**: A dependency is unavailable; the session pauses

A handoff is NOT required for:

- Immediate continuations (the same session continues)
- Trivial changes (single-file edits with no decisions)
- Read-only exploration (no state changed)

## Handoff Process

\\\mermaid
sequenceDiagram
    participant A as AI Agent
    participant W as Workspace
    participant N as Next AI Agent

    A->>W: Complete current task
    A->>W: Update PROJECT_MEMORY with changes
    A->>W: Log decisions in DECISION_LOG
    A->>W: Write ENGINEERING_JOURNAL entry
    A->>W: Write HANDOFF.md
    A->>W: Write NEXT_SESSION.md
    Note over A: Session ends. Context lost.

    N->>W: Read HANDOFF.md
    N->>W: Read NEXT_SESSION.md
    N->>W: Read PROJECT_MEMORY
    Note over N: State recovered. Work resumes.
\\\

### Step-by-Step

**Step 1: Complete the Current Task**
Finish the in-progress work to a stable state. If not completable, document the partial state.

**Step 2: Update PROJECT_MEMORY.md**
Update architecture sections, constraints, and dependencies that changed during the session.

**Step 3: Log Decisions in DECISION_LOG.md**
Every decision made during the session gets an entry with date, context, decision, rationale, alternatives, trade-offs, and status.

**Step 4: Write ENGINEERING_JOURNAL.md**
Add a journal entry summarizing what was done, what was learned, and any notable observations.

**Step 5: Write HANDOFF.md**
Create the recovery snapshot.

**Step 6: Write NEXT_SESSION.md**
Write prioritized instructions for the next session.

## State Recording

\HANDOFF.md\ captures the following state:

| Field | Description | Required |
|-------|-------------|----------|
| Session ID | Unique identifier | Yes |
| Timestamp | When the handoff was written | Yes |
| Project | Which project was active | Yes |
| Current task | What was being worked on | Yes |
| Status | completed, partial, blocked | Yes |
| File changes | Files modified, created, deleted | Yes |
| Key decisions | References to DECISION_LOG entries | Yes |
| Open questions | Unresolved questions | No |
| Blocker | If blocked, why | Conditional |
| Context notes | Anything the next AI should know | No |

## Decision Recording

Every decision made during the session goes into \DECISION_LOG.md\. Each entry includes:

\\\markdown
## DEC-2026-07-06-001

- **Date**: 2026-07-06
- **Context**: Needed to choose a database for the user service
- **Decision**: Use PostgreSQL 16
- **Rationale**: Best fit for relational data with complex queries
- **Alternatives considered**: MongoDB (schema-less, but team lacks expertise), SQLite (too limited for production)
- **Trade-offs**: Schema migrations required; stronger consistency guarantees
- **Status**: Active
\\\

## Task Recording

\NEXT_SESSION.md\ captures the forward-looking state:

\\\markdown
# Next Session Instructions

## Priority 1
- Implement the user authentication endpoint
- See HANDOFF.md for current state

## Priority 2
- Add integration tests for the auth flow
- Dependencies for testing are already installed

## Priority 3
- Write API documentation
- Use the OpenAPI template from Global Memory
\\\

## Recovery Process

When the next AI agent starts a session, it follows this recovery path:

\\\mermaid
flowchart LR
    A[Start session] --> B[Read 00 + 01 + 06]
    B --> C[Read PROJECT_MANIFEST]
    C --> D[Read HANDOFF.md]
    D --> E{What is status?}
    E -->|completed| F[Read NEXT_SESSION.md]
    E -->|partial| G[Continue current task]
    E -->|blocked| H[Resolve blocker or pivot]
    F --> I[Begin Priority 1 task]
    G --> I
    H --> I
    I --> J[Work]
    J --> K[Write handoff at end]
\\\"

## Example Handoff

\\\markdown
# Handoff

## Session
- **Session ID**: sess_20260706_001
- **Timestamp**: 2026-07-06 14:30 UTC
- **Project**: Project_01_user-service
- **AI Agent**: Claude Code

## Current State
- **Task**: Implement user registration endpoint
- **Status**: Partial (endpoint implemented, tests failing)
- **Branch**: feat/user-registration

## Changes Made
- Modified: src/routes/auth.ts
- Created: src/controllers/UserController.ts
- Created: tests/unit/UserController.test.ts

## Key Decisions
- See DECISION_LOG.md: DEC-2026-07-06-001
- Chose bcrypt for password hashing over argon2

## Open Questions
- Should rate limiting be per-IP or per-user?
- Is email verification required at MVP stage?

## Blocker
- Integration test environment not set up
- Blocked on: DevOps to provide test DB credentials

## Context Notes
- The project uses Express middleware for auth
- Password validation rules are in Global Memory
\\\

## Recovery Checklist

The next AI agent uses this checklist to verify recovery:

\\\
- [ ] Read HANDOFF.md
- [ ] Read PROJECT_MEMORY.md (for current architecture)
- [ ] Understood task status (completed / partial / blocked)
- [ ] Reviewed recent DECISION_LOG entries
- [ ] Checked NEXT_SESSION.md for priorities
- [ ] Verified no stale context from previous session
- [ ] Confirmed current branch matches HANDOFF
- [ ] Ready to begin work
\\\

## FAQ

**Q: What if the AI crashes mid-session without writing a handoff?**  
The last available handoff is stale but better than nothing. The next AI reads HANDOFF.md and PROJECT_MEMORY.md and uses git diff to determine what changed since the last handoff.

**Q: Can a single session span multiple handoffs?**  
Yes — for very long sessions, write intermediate handoffs at natural checkpoints (feature complete, test pass, blocker encountered).

**Q: How do I know the handoff is correct?**  
The AI should verify its handoff by reviewing git status and diff to ensure the files listed in "Changes Made" are accurate.

**Q: Should human developers write handoffs too?**  
Yes — every developer should write a handoff when switching context. AI and human developers benefit equally from the protocol.

**Q: What if the next AI agent is different (e.g., Claude → Codex)?**  
The handoff format is tool-agnostic. Any AI agent that reads Markdown can process the handoff.

## Summary

The Handoff Protocol enables deterministic session recovery. Every session ends by writing state (HANDOFF.md), decisions (DECISION_LOG.md), tasks (NEXT_SESSION.md), and journal (ENGINEERING_JOURNAL.md). The next session reads the handoff and resumes exactly where the previous session left off. No context is lost.
