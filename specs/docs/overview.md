# Lorky - A homework and revision assistant for kids

Lorky is a helpful homework and revision assistant helping kids do their homework and revise their school materials. Lorky's purpose is to idententify gaps in kids knowledge or understanding of assinged learning topics and help them bridge the gaps. Lorky uses assigned school materials, youtube and wikipedia to ground itself in truths. Lorky helps kids focus on the learning objectives set out by their teachers. Lorky works across all topics from languages, math, history, geography etc, each time shifting modes to best suite the topic and subject. 

## How it works
Lorky works by first assessing the childs understanding of a selected topic and then progressivly starts narrowing down the areas of gaps and then presents underlying information and learning for the child to absorve, then finally looping back to assess if the child aquired the new information. 

Lorky allows kids to speak their answers and questions and Lorky answers them using voice. There is also an option to type in questions and answers. 

Lorky is not allowed to do the child's homework or directly answer questions. It may only locate the information the child needs to understand and present the information at its source for the child to read it for themselves and answer the question. 

Lorky tailors its information and language to the age of the child to make topics easy to understand and familiar. 

## What it does
Things Lorky may do:
- quizz the child on vocab, spelling, comprehension of languages, verbs etc
- remember what mistakes the child made, remember the mistake and loop back to verify learning at a later point
- assess the childs understanding and depth of knowledge by asking probing questions and listening to answers about a particular topic and then present information to fill those gaps by pulling in information from school materials, youtube and wikipedia
- create a math worksheet on a particular math topic and validate the answers
- tell a joke related to the topic being studied as a reward for providing the correct answer
- Go back to earlier topics and re-validate the child still remembers the information
- Go back to previously incorrectly answered questions and re-validate correct understanding
- Figure out what the learning objective is given the study material and build a learning objective list for a particular subject to focus on
- Sees there is homeworks assigned and asks the child if it needs help
- Scans and parses school materials, including images, video transcripts, scanned images and performs OCR on handwritten notes to create a database of information to revise from
- Connects directly to goole classroom to access school materials for the given grade

### Initial Session Flow
- The child signs up using Google login and authenticates into Google Classroom, granting Lorky access to school materials (PDF, DOCX, slides, webpages from links). The system will request read access to all sources and files. For assignments without files, Lorky will follow links if present; otherwise, it will ask the child to upload materials.
- The initial menu will ask what subject the child wants to focus on.
- If there is assigned homework for that subject, Lorky will ask if the child wants to do that first.
- Otherwise, the child can provide an objective for the session for the subject, or Lorky can suggest revising older topics.

### Core Learning Loop & Adaptive Tutoring
- Depending on the subject, Lorky adapts its approach. There will be specific subject agents with custom prompts for each subject, and an orchestrating agent will switch into the correct agent mode.
- For topics requiring subject matter understanding, open-ended questions guided by a learning objective are first posed to the child.
- Lorky may ask more questions to identify knowledge gaps within the topic.
- The system then presents its findings and outlines the information to be served to the child to fill those gaps, acting as a private tutor.
- Learning objectives drive the questions and the information presented based on the child's answers.
- Information priority: School-provided materials first, followed by Wikipedia and YouTube. Lorky always quotes sources, providing direct links to passages within the chat window.
- The loop-back mechanism is a quick quiz to assess understanding of the information presented to address the knowledge gap.

### Interaction Methods
- The child indicates voice input by holding down the spacebar. This voice input is transcribed into text and sent to Lorky.
- All voice input should be transcribed in real-time using an LLM or transcription service.
- Lorky will use voice exclusively during the session to ask and answer questions, not for interface navigation or interaction.
- Responses should be near real-time.
- Responses to text input are delivered as text; responses to voice input are delivered as voice.

### Homework Assistance & Guardrails
- Lorky reads and understands homework assignments from Google Classroom.
- Lorky will prevent itself from directly answering homework questions, regardless of how they are posed by the child.
- Lorky can rephrase homework questions into more understandable examples or re-ask them in different ways to assess the child's comprehension.

### Content Management & Personalization
- Lorky supports PDF, DOCX, slide presentations, and webpages from links.
- The child's grade level (inferred from Google Classroom) will indicate their age, and the system will adapt its language accordingly to make topics easy to understand and familiar.
- Materials are pulled directly from Google Classroom via API.

### Progress Tracking & Memory
- For each subject, Lorky maintains a history of: all questions asked, all answers provided, correctness of answers, and specific parts of answers that were insufficient, storing this information in memory. Lorky stores the full transcript of questions and answers as text.
- Lorky will use this memory for future interactions, including suggesting revision of older topics.
- The child or parent can explicitly instruct Lorky to perform revision. When doing revision, Lorky will randomly cover objectives for the subject for the year, focusing on related topics, especially those poorly understood in the past to identify if understanding has improved.
- There is no parent/teacher reporting functionality in the initial scope.

### Math & Problem-Solving Specifics
- Lorky infers learning objectives from recently assigned coursework or when prompted to cover a particular topic. Learning objectives explicitly stated within school materials will also be extracted. Inferred objectives are stored to a file, and a list of objectives for the subject for the year is maintained.
- Lorky can pull examples from assigned materials and generate new problems based on existing worksheets.
- Lorky internally validates questions or problems by first solving them itself to ensure they evaluate to the expected answer. The step-by-step solution is stored temporarily during this validation but discarded after the question is answered, with only the question and answer stored in conversation history.
- Lorky will then present the problem to the child, and validate their answer.
- If the child's thinking or answer is incorrect, Lorky will indicate the error and ask the child to correct it, without providing the solution directly.


## Core Data Entities

The following core data entities form the foundation of Lorky's educational system, each serving specific purposes in the learning process:

### User
**Purpose**: Represents the child learner using Lorky, storing essential identity and demographic information needed for personalization and progress tracking.

**Key Attributes**: 
- User ID, Google authentication credentials, name, email
- Grade level (inferred from Google Classroom), age, language preferences
- Account creation date, last active session

**Why it exists**: Lorky needs to know who it's teaching to adapt language complexity, track learning progress over time, and maintain continuity across sessions. The grade level is particularly important as it determines the appropriate complexity of content and language used.

### Subject
**Purpose**: Defines the academic disciplines Lorky can teach (Math, English, History, Geography, etc.) and their specific pedagogical requirements.

**Key Attributes**:
- Subject ID, name, description
- Grade level appropriateness, curriculum standards
- Associated learning objectives and topics

**Why it exists**: Different subjects require different teaching approaches, content sources, and assessment methods. The specification mentions "shifting modes to best suit the topic and subject" - this entity enables that adaptive behavior by defining subject-specific characteristics and requirements.

### Learning Objective
**Purpose**: Represents specific educational goals that drive Lorky's questioning strategy, content selection, and assessment methods.

**Key Attributes**:
- Objective ID, title, description, grade level
- Subject association, source (inferred from materials or explicitly extracted)
- Creation date, academic year

**Why it exists**: The specification states "Learning objectives drive the questions and the information presented based on the child's answers." These objectives serve as the pedagogical framework that guides Lorky's adaptive tutoring approach. They can be either inferred from coursework or explicitly extracted from school materials, and are maintained per subject per year to create a structured curriculum map.

### Topic
**Purpose**: Represents specific areas within a subject that can be taught, assessed, and have knowledge gaps identified.

**Key Attributes**:
- Topic ID, title, description, subject association
- Difficulty level, prerequisites, related learning objectives
- Content sources and assessment methods

**Why it exists**: Provides granular organization of content within subjects, enabling targeted gap identification and focused learning. Topics serve as the bridge between high-level subjects and specific learning activities, allowing Lorky to narrow down areas of misunderstanding and present relevant information to fill knowledge gaps.

### Session
**Purpose**: Represents a continuous learning interaction between the child and Lorky, providing context and continuity for the educational conversation.

**Key Attributes**:
- Session ID, user ID, subject ID, session type
- Start/end times, status, learning objectives covered
- Session context (homework assistance, revision, objective-based learning)

**Why it exists**: Provides structured context for learning interactions, tracking what type of learning is happening and maintaining continuity across the conversation. Different session types (homework, revision, objective-based) trigger different Lorky behaviors and approaches.

### Question
**Purpose**: Represents educational queries posed by Lorky to assess the child's understanding and identify knowledge gaps.

**Key Attributes**:
- Question ID, question text, question type
- Associated learning objective, difficulty level, subject context
- Session association, timestamp

**Why it exists**: The specification emphasizes Lorky's role in "assessing the child's understanding" through targeted questioning. Questions are pedagogically structured for learning assessment, linked to specific learning objectives, and designed to progressively narrow down areas of knowledge gaps.

### Answer
**Purpose**: Represents the child's responses to Lorky's questions, including correctness assessment and detailed analysis of understanding.

**Key Attributes**:
- Answer ID, question ID, user's answer text
- Correctness assessment, correctness score, insufficient parts
- Feedback provided, timestamp, revision attempts

**Why it exists**: Enables gap identification and progress tracking as specified: "remember what mistakes the child made." Answers include educational assessment beyond simple right/wrong, tracking specific areas of weakness for targeted remediation and supporting detailed feedback for learning improvement.

### Knowledge Gap
**Purpose**: Represents identified areas where the child lacks understanding or has misconceptions about a topic.

**Key Attributes**:
- Gap ID, user ID, topic ID, learning objective ID
- Gap type, severity level, description
- Identification date, status (identified, addressed, resolved)
- Related questions and answers that revealed the gap

**Why it exists**: The specification's core purpose is to "identify gaps in kids' knowledge" and help bridge them. Knowledge gaps are educationally specific learning deficiencies that drive Lorky's information presentation strategy and revision scheduling. They include severity and type for prioritized remediation and track resolution status for progress monitoring.

### Mistake
**Purpose**: Represents specific learning errors that need revisiting and correction through spaced repetition and targeted practice.

**Key Attributes**:
- Mistake ID, user ID, question ID, topic ID
- Mistake type, description, first occurrence date
- Last occurrence date, revision attempts, resolution status
- Related learning objective, difficulty level

**Why it exists**: The specification emphasizes "remember what mistakes the child made, remember the mistake and loop back to verify learning at a later point." Mistakes are tracked for spaced repetition learning, enabling Lorky to revisit previously incorrect answers and assess whether understanding has improved. This supports the revision strategy of focusing on areas with lots of mistakes in the past.

## Entity Relationships

These entities work together to create Lorky's adaptive learning system:

- **User** engages in **Sessions** focused on specific **Subjects**
- **Sessions** contain **Questions** and **Answers** related to **Topics** and **Learning Objectives**
- **Answers** reveal **Knowledge Gaps** and **Mistakes** that drive future learning
- **Learning Objectives** guide the selection of **Questions** and content presentation
- **Mistakes** trigger revision sessions that revisit **Topics** and **Learning Objectives**
- **Knowledge Gaps** determine what information Lorky presents to fill understanding deficiencies

This interconnected structure enables Lorky to provide personalized, adaptive tutoring that identifies and addresses individual learning needs while maintaining educational continuity and progress tracking.
