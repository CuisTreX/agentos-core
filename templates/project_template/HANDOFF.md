# HANDOFF

**Purpose**: Capture the session state for deterministic recovery by the next session.
Written at the end of every session.

---

## Session

- **Session ID**: (sess_YYYYMMDD_NNN)
- **Timestamp**: (YYYY-MM-DD HH:MM UTC)
- **Project**: (Project_NN_name)
- **AI Agent**: (agent name / version)

## Current State

- **Task**: (what was being worked on)
- **Status**: (Completed / Partial / Blocked)
- **Branch**: (git branch name)

## Changes Made

- Modified: (path/to/file)
- Created: (path/to/file)
- Deleted: (path/to/file)

## Key Decisions

- See DECISION_LOG.md: DEC-YYYY-MM-DD-NNN — brief description

## Open Questions

- Question 1 — context for the next session

## Blocker

- (describe blocker, if any)
- (what is needed to unblock)

## Context Notes

Anything the next AI agent should know:
- Current assumptions
- Partial progress details
- Environment configuration
- Files that were being reviewed

---

*Template: Copy this structure, fill in the fields, and replace all placeholders.*
