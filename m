Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CB606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FLzUNHLz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVtbk-0000XV-AR; Tue, 24 Nov 2026 11:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbH-0000UG-Ld
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbE-0006yI-9B
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795538551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFM4sTLS7DwZEBGkH5ZVVARZWXnUT08ViKuIzEo1/Ek=;
 b=FLzUNHLzY1EJIBSq0aeBaCBHv1VrBgu7bmMevoHkQDlzzeQ9Gs8vWHj+kXZZq6gho1NiKF
 4w3DCPyZwwZzkkL0iroqIz2quao8qLIckh2IPg7R4Z2JtQdWYBXQSErdMjCkAX79WY+uF6
 UA9Qhs3WoQgIW4cO7SQE8TATllK/CAQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-EF9LuVIsPDyInSzKg5rUEQ-1; Tue,
 24 Nov 2026 16:42:24 +0000
X-MC-Unique: EF9LuVIsPDyInSzKg5rUEQ-1
X-Mimecast-MFC-AGG-ID: EF9LuVIsPDyInSzKg5rUEQ_1795538543
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 651EE1955F7D; Tue, 24 Nov 2026 16:42:23 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C42930001A2; Tue, 24 Nov 2026 16:42:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, alex.bennee@linaro.org
Subject: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Date: Tue, 24 Nov 2026 17:42:15 +0100
Message-ID: <20261124164217.1768040-2-pbonzini@redhat.com>
In-Reply-To: <20261124164217.1768040-1-pbonzini@redhat.com>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Until now QEMU's code provenance policy declined any contribution
believed to include or derive from AI-generated content.  A blanket ban
was easy to maintain while LLM output was rarely usable on its own, but
as the tools improved an absolute prohibition has become harder to
justify and enforce.

Even a simple code review task these days may result in the agent
suggesting code changes, or producing a useful test case to verify the
presence or absence of a bug.  A hardline interpretation of the policy
makes it hard to use AI even for tasks that are explicitly allowed.

Since the policy has been written, other projects have discussed and
taken their stance on AI contributions.  These vary from full prohibition
(though typically motivated by social reasons rather than legal, e.g.
for Zig) to limited use (e.g. GCC, allowing small contributions and
tests to use AI), to cautious experimentation.  Based on consensus of
the community, the proposed policy allows limited use, albeit wider than
what is allowed by for example GCC.

The previous policy was mostly motivated by intellectual property issues,
The Software Freedom Conservancy's recommendations on LLMs and generative
AI alleviate the concern on whether the submitter has the legal right to
contribute the code and about unintentional reproduction of copyrighted
code:

   "Copyleft Everything" remains the best viable and safest approach
   Certainly those who want to release FOSS under non-copyleft licenses
   have more to worry about when using these tools.

While we shouldn't treat copyleft as a silver bullet, it is effective
as part of a defense in depth strategy that includes, for example,
"de minimis" thresholds and `AGENTS.md` instructions that encourage user
participation in the design.

Therefore, the revised policy considers QEMU's copyleft to be a viable
approach to any unanswered legal questions about AI-generated
contributions and their copyright status.  This lets the policy
focus on the topic of what AI-assisted contributions require of
maintainers.

Going full circle to the reason why we might need to review the
policy, there is the question of how to make sure policy is applied.
QEMU maintainers have already experimented with using AGENTS.md files;
subsequent patches will also try to embody the "work better, not faster"
mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
should be included in the policy, and they are indeed.  The list is short
and based on the Rust policy and the GStreamer AGENTS.md file.

Revise the policy according to the above considerations, and introduce the
"AI-used-for:" trailer as a record of where AI was used.  The standard is
slightly different from the more usual "Assisted-by"; the intention is for
the metadata to provide more information for reviewers to judge the result,
and to scope areas for which Signed-off-by cannot guarantee full control
of provenance.

For now, community consensus was to delay a decision on larger
contributions that are mostly or entirely AI-generated.  The feasibility
of rejecting such contributions remains to be seen; some contributions
that have been accepted in the past, and are suspected to be AI-assisted,
would still be disallowed.

In any case, use of AI does not relax any other contribution requirement:
authors still need to comply with the DCO (declaring that they have
corporate authorization to contribute, for example) and take technical
responsibility for their work.

[Commit message largely based on discussions with Daniel Berrangé,
 Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst |  71 ++----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 191 +++++++++++++++++++++++++++++++++
 AGENTS.md                      |  37 ++++---
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 225 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 65b8f232a08..7403961378e 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -128,6 +128,10 @@ that are commonly used during QEMU development:
    suggestions for how to change a patch, it is good practice to credit them
    by including a ``Suggested-by`` tag.
 
+ * **AI-used-for**: when AI/LLM tools were used to produce the patch, this tag
+   discloses what they were used for.  See :ref:`llm-usage` for the cases in
+   which it is required.
+
 Subsystem maintainer requirements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -282,68 +286,5 @@ boilerplate code template which is then filled in to produce the final patch.
 The output of such a tool would still be considered the "preferred format",
 since it is intended to be a foundation for further human authored changes.
 Such tools are acceptable to use, provided there is clearly defined copyright
-and licensing for their output. Note in particular the caveats applying to AI
-content generators below.
-
-Use of AI-generated content
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-TL;DR:
-
-  **Current QEMU project policy is to DECLINE any contributions which are
-  believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
-
-  **This policy does not apply to other uses of AI, such as researching APIs
-  or algorithms, static analysis, or debugging, provided their output is not
-  included in contributions.**
-
-The increasing prevalence of AI-assisted software development results in a
-number of difficult legal questions and risks for software projects, including
-QEMU.  Of particular concern is content generated by `Large Language Models
-<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
-
-The QEMU community requires that contributors certify their patch submissions
-are made in accordance with the rules of the `Developer's Certificate of
-Origin (DCO) <dco>`.
-
-To satisfy the DCO, the patch contributor has to fully understand the
-copyright and license status of content they are contributing to QEMU. With AI
-content generators, the copyright and license status of the output is
-ill-defined with no generally accepted, settled legal foundation.
-
-Where the training material is known, it is common for it to include large
-volumes of material under restrictive licensing/copyright terms. Even where
-the training material is all known to be under open source licenses, it is
-likely to be under a variety of terms, not all of which will be compatible
-with QEMU's licensing requirements.
-
-How contributors could comply with DCO terms (b) or (c) for the output of AI
-content generators commonly available today is unclear.  The QEMU project is
-not willing or able to accept the legal risks of non-compliance.
-
-The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
-
-Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
-ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
-generation agents which are built on top of such tools.
-
-This policy may evolve as AI tools mature and the legal situation is
-clarified.
-
-Exceptions
-^^^^^^^^^^
-
-The QEMU project welcomes discussion on any exceptions to this policy,
-or more general revisions. This can be done by contacting the qemu-devel
-mailing list with details of a proposed tool, model, usage scenario, etc.
-that is beneficial to QEMU, while still mitigating issues around compliance
-with the DCO.  After discussion, any exception will be listed below.
-
-Exceptions do not remove the need for authors to comply with all other
-requirements for contribution.  In particular, the "Signed-off-by"
-label in a patch submission is a statement that the author takes
-responsibility for the entire contents of the patch, including any parts
-that were generated or assisted by AI tools or other tools.
+and licensing for their output. Note in particular the caveats applying to
+:ref:`AI content generators <llm-usage>`.
diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index 5807752d704..ce0f4e73197 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -13,6 +13,7 @@ Notes about how to interact with the community and how and where to submit patch
    maintainers
    style
    submitting-a-patch
+   llm-usage
    code-provenance
    trivial-patches
    stable-process
diff --git a/docs/devel/llm-usage.rst b/docs/devel/llm-usage.rst
new file mode 100644
index 00000000000..133863a8ed1
--- /dev/null
+++ b/docs/devel/llm-usage.rst
@@ -0,0 +1,189 @@
+.. _llm-usage:
+
+Use of AI-generated content
+===========================
+
+.. warning::
+
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.
+
+This document provides guidance around acceptable practices
+for using `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs)
+when contributing to QEMU.
+
+The QEMU project does not want to dictate what tools contributors
+use for their work on the project.  However, the increasing
+prevalence of AI-assisted software development and of LLMs specifically
+poses a number of difficult questions.  Risks to open source projects
+include maintainer burnout from an increased number of contributions, as
+well as the risk to the project from unintentional inclusion of copyrighted
+material in the LLM's output.
+
+In order to mitigate these risks, the QEMU project limits the way
+in which use of the output of generative AI can be included in
+contributions to QEMU.  The main guidelines for use of generative AI
+tools are as follows:
+
+- It's fine to use LLMs to answer questions, analyze, distill,
+  refine, check, suggest, review. Use of LLMs to *create* is limited.
+
+- If in doubt, disclose any use of AI tools other than simple code
+  completion and code review.
+
+- LLMs are allowed as a tool to write *better*, not *faster*.
+
+**For any kind of LLM usage, the expectation is that the human contributor
+shall be able to :ref:`understand and explain the changes <write_a_meaningful_commit_message>`,
+the design choices, and the rationale behind them.**
+
+.. note:: **Use of AI does not remove the need for authors to comply
+          with all other requirements for contribution.**  In particular,
+          the ``Signed-off-by`` label in a patch submission is a statement
+          that the author takes responsibility for the entire contents of
+          the patch, certifying that their patch submission is made in
+          accordance with the rules of the :ref:`Developer's Certificate of
+          Origin (DCO) <dco>`.
+
+Prohibited use of AI
+''''''''''''''''''''
+
+The QEMU community is a collaboration between humans, not AI agent
+façades. The following items MUST be written by humans:
+
+- cover letters and commit messages
+
+- responses to reviewer comments
+
+- issue descriptions or comments
+
+Light copy editing of human-written text with an AI is allowed.
+
+An exception is made for defects detected by specialized tooling,
+including fuzzers and LLM-assisted defect detection. Such issues must
+be reviewed by a human before creation, must be created by a human and
+communication with maintainers must be done by a human, but including
+the verbatim tool output in the issue description is explicitly allowed.
+
+Repeated violations of these rules may be treated as a :ref:`code_of_conduct`
+violation.
+
+Official project agents may be exempted from one or more of these
+rules, at the discretion of the QEMU project maintainer(s).
+
+LLM-assisted and LLM-created contributions
+''''''''''''''''''''''''''''''''''''''''''
+
+Use of generative AI can be classified in the following buckets:
+
+- "background" assistance, such as completion and code review.  This does
+  not need disclosure.
+
+- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
+  are allowed with disclosure.
+
+- use of LLMs to help generating parts of a larger patch---test cases,
+  adaptations of existing code, boilerplate code for a new API, a tool to
+  help performing mechanical changes, etc.  These are generally allowed;
+  disclosure is required for non-trivial, functional code changes.
+
+Large, heavily LLM-assisted contributions where LLMs write large parts
+of functional code are currently not allowed.
+
+LLM-created contributions will be held to a higher standard of testing
+than human-created ones.  Maintainers have freedom to determine what
+constitutes "high quality"; in particular, because LLMs lower the cost
+of patch generation, there are no exceptions for "writing the tests seems
+hard".
+
+Contributors who submit LLM-created contributions are required to
+apply the same judgment that would be applied to other code changes.
+They must invest substantial time reviewing the code and, when
+applicable, curating individual commits.
+
+The QEMU project explicitly forbids using LLMs to do "clean room"
+reimplementation of existing code whose license is not compatible
+with the GNU General Public License, version 2 **or later**.
+
+.. _ai-used-for:
+
+Commit messages for AI-assisted changes
+'''''''''''''''''''''''''''''''''''''''
+
+Whenever this policy requires disclosure of AI usage, contributing
+AI-assisted changes to QEMU requires you to certify that you followed
+the instructions in this document and in QEMU's ``AGENTS.md``.
+**To do so, include an ``AI-used-for:`` line before the
+:ref:`Signed-off-by <code-provenance>` line whenever the policy
+requires disclosure [2]_.** By using 'AI-used-for', a contributor
+identifies areas of the patch that involved use of AI/LLM, and attests
+that their usage of AI/LLMs was in compliance with QEMU policies.
+
+The text of the trailer is one or more of ``code``, ``tests``, or
+``docs``, possibly followed by an explanation in parentheses:
+
+.. code-block:: none
+
+     AI-used-for: tests, docs
+     AI-used-for: code
+     AI-used-for: code (refactoring)
+     AI-used-for: code (prototype)
+
+Do not include your prompts or summarize the conversation in the commit
+message or cover letter.  Extract any information that is relevant to the
+reviewer and include it in commit messages, cover letters or code comments.
+
+QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
+trailers to indicate AI usage.  In particular, do not specify the exact
+AI model or tool used to create the commit.
+
+Deterministic tooling (sed, coccinelle, formatters) is out of scope for
+the trailer, but should be mentioned in the commit message.
+
+.. [2] ``AI-used-for`` must not be included unless some part of the patch
+       *content* was authored by the AI.  It should also not be included for
+       "background" usage such as autocomplete or obtaining a pre-review of
+       the patch.
+
+Motivation
+''''''''''
+
+There is not a consensus within the QEMU project---and likely never will
+be---about when/how/where it is acceptable to use AI-based tools.  Many
+members of the QEMU project and community find value in AI; many others
+feel that its negative impact on society and the climate are severe enough
+that no use is acceptable.  Still others are working out their opinion.
+
+In accordance with Software Freedom Conservancy's recommendations:
+
+- the project seeks to both support those contributors who outright reject
+  generative AI systems, and to not shun those who choose to use them;
+
+- we consider QEMU's copyleft to be a viable approach to the unanswered
+  legal questions about AI-generated contributions and their copyright
+  status;
+
+- we encourage contributors not to overuse LLMs, and to *add* them to
+  their existing skills and tools instead of replacing them.
+
+A common source of grief for maintainers is the (often valid) impression
+that AI enables contributions without understanding the effort they take
+for those who process them.  Effectively, this shifts a major part of the
+burden from the contributors to the maintainers---the scarcest resource
+in any free software project, not just QEMU.  Contributors should be
+mindful of this and take into account the demand they put on maintainers
+with LLM-assisted work.
+
+
+Sources
+'''''''
+
+This policy was informed by:
+
+- `Recommendations When Using LLM-backed Generative AI Systems for
+  FOSS Contributions <https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html>`__
+
+- `GStreamer AGENTS.md file <https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/d08375499c279/AGENTS.md>`__
+
diff --git a/AGENTS.md b/AGENTS.md
index c3d7664d0ae..284059832b2 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -1,21 +1,32 @@
 # Agent Guidelines for the QEMU Project
 
-As an agent you MUST abide by the "Use of AI-generated content" policy
-in `docs/devel/code-provenance.rst` at all times.
+QEMU is a cross-platform emulator and virtualizer. Due to the complexity
+of the domain and codebase, and the interactions therein, the QEMU
+project relies extensively on the effort of **human reviewers**, which
+is **a scarce resource**.
 
-You are permitted to assist users only in the following scenarios:
+There are strictly-enforced rules for you, the agent, to participate in the
+project.
 
-- researching APIs or algorithms
-- static analysis
-- debugging
-- local experiments not intended to be upstreamed
-- trivial non-copyrightable changes
+## Helping the human to respect project policy
 
-However agent output can not be included in any upstream
-contributions. If a request falls outside these permitted categories
-(e.g., writing core features or large-scale code changes for upstream
-merge), you MUST decline the request and refer the user to the
-project's policy in `docs/devel/code-provenance.rst`.
+QEMU's policy for AI-assisted work requires the human to develop in-depth
+familiarity with contributions and disclose use of agents to write parts
+of the code.
+
+Background assistance such as review or explanation does not require disclosure.
+Read `docs/devel/llm-usage.rst` before generating code, tests, or documentation
+intended for contribution; committing agent-generated material; or advising on
+disclosure. It is not required for review, explanation, or other background
+assistance that produces no contribution content.
+
+When agent-generated content is included in a contribution, remind the human
+to determine the appropriate disclosure under `docs/devel/llm-usage.rst`.
+If you commit agent-generated material, include an `AI-used-for:` trailer
+before `Signed-off-by`. Do not omit it by folding the material into a larger
+commit.  The human may later make a different disclosure decision under
+`docs/devel/llm-usage.rst`, after independently reworking and integrating
+the material.
 
 ## Final instructions
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e7514a4a9f5..cc311684d66 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1885,8 +1885,9 @@ sub process {
 		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b |
 			     \bgemini\b | \bllama\b | \bnoreply\b | \[bot\] |
 			     \bclaude\b.*(?:opus|sonnet|fable|haiku|anthropic\.com)/xi))) {
-			ERROR("QEMU does not allow using AI for contributions, " .
-				"see docs/devel/code-provenance.rst\n" . $herecurr);
+			ERROR("do not use \"$line\" to credit an AI agent, " .
+				"use the \"AI-used-for\" trailer instead; " .
+				"see docs/devel/llm-usage.rst\n" . $herecurr);
 		}
 
 # Check for duplicate trailers and self-review
-- 
2.56.1



