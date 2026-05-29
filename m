Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0279CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEq-0002z4-Ap; Fri, 29 May 2026 06:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEo-0002yU-T5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEj-00014C-R5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so78948355e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049680; x=1780654480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VIw3YmXx5HJytkVxeDA1OLVA6u9Y15TcNLpyHWAKcQ=;
 b=dhFeoCynVr4wAVynU0BPTh3lI7AVhmqMMNS2aehYHPj99D7GGAhOETD2opEpdkwq9V
 dUz6dHye8X3xiT92eXby+SeQ5s7a0UIl8BXBNxEq/mmlTCTuSsxLiqDcUZBeKFcEjx/V
 HlWbuXUGfpg3dGINUIBYAWG1BPunmZpJmO8ViGfZwn3JK22Dp1GW9W1MjIksenNB9NHI
 46ZLEMCC2jARzf7U4G3uhZgQ+/DY0P4h3TRRtyg9VDIZYdpQebYt35uExH6EuNiF4Hrf
 75IoqcZuoVkoO/O0WnPG+14sbgDorxwidN0BjqHOHbBaVbgAAuYWk1fBb1agG1l8EvGA
 om9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049680; x=1780654480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VIw3YmXx5HJytkVxeDA1OLVA6u9Y15TcNLpyHWAKcQ=;
 b=AWVZ/2nXdxBpoSwHFFbGvcZEXeyAMg//yaSMb1jsjAbE+Ngl3odKknxRd6gu7qqLeM
 T+vMVubxcXV8g9tCT7/xRDJ1Xm2aYor31NguJmefLUWHdwqoilPwlBqr68/OQEDmeKQt
 X9xPiL2lkoY2jJIuOdILQ+vvtpO17XWRzkjaslctA1jgwVIa1q8OGtgkD0X4SvzvY/H/
 a5Oy/kKCZ84S5ovqF3CUslKxmiPddzZspZLlM6EJSHme7KcvN3wmrXi9FkXaUsPVPnXT
 trMgTbYpp2I9K4d/71+z3CXN9Dsi/hADDWs6NuE2vNO40s77cPJu86Yjvp87EM2NUrgD
 igbg==
X-Gm-Message-State: AOJu0YzyrASBzb9ZhAMn5INfDdXch2rB9/WHjZOP0sTLjH+7cmSr3lT7
 aGxpKqwqA5CASi9zP4CIvbaXPmyXnP9eljXX1ykFiFXQMFX6ouUGOmWhQ2FkMCJ5Eqg=
X-Gm-Gg: Acq92OHXAIaRZTcOGzvD2OjeWIYej2Lp3Nx5LFzC2ARTrBrbhjoE7EHzMKIYzUjmYoR
 lS5RaeaYZ+948uZj13uiZ4oePPOzPMiJJgVUBtp/Rmam5+Pprr8dSIfhY98pjQtWaNPHtC5ubDh
 9/OzOMKTlIzIYLLU4i+pNmwu5hecfswwM4e9JyatBdcd+W0IiL0EegZLgQaZmGbRXmsGor8BIBs
 rZCEVn2kmHlPQ0kkwsO4kIbU9GqI3ov3KP4laELno66Zh1gFR/b1RJcqAc41hL6ZSpQpurpbwIR
 cC3dsBx7AAz0JXa+eNmpGCqHzeHXaYtNW8t5vdRpCaqEiEJm1D9Efijpjaozw8IjBl9nyUbQGvn
 +Vs+M9Kd6MHngbRseEZJEcJ7TwZO3JIkhkRhciI8NSyaON9MrSG3Y9bLzc+C00eRdNP+E4H0Nuj
 sQGgpnGrwon73f3WT+XpOLu5LUpFeBKENrlQ==
X-Received: by 2002:a05:600c:3f14:b0:490:9699:4428 with SMTP id
 5b1f17b1804b1-4909c0c2d66mr42709545e9.26.1780049679835; 
 Fri, 29 May 2026 03:14:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm63839815e9.13.2026.05.29.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C0F8C5FA5C;
 Fri, 29 May 2026 11:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v4 01/12] docs/devel: relax policy on AI-generated
 contributions
Date: Fri, 29 May 2026 11:14:26 +0100
Message-ID: <20260529101437.410181-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Until now QEMU's code provenance policy declined any contribution
believed to include or derive from AI-generated content.  A blanket ban
was easy to maintain while LLM output was rarely usable on its own, but
as the tools improved an absolute prohibition has become harder to
justify.

The concern that motivated the policy is unchanged, and it is worth
stating precisely: the DCO is about whether the submitter has the legal
right to contribute the code, not about "creative expression".  The
copyright and license status of LLM output remains unsettled, so that
question is still open.  What has shifted is the balance of risk:

- projects accepting AI-assisted content have not run into serious
  legal trouble so far, which suggests the probability of the risk
  materializing is not high;

- other organizations, such as Red Hat[1], have assessed the risk as
  acceptable -- though a community of individual developers does not
  have the legal backing of a company, and even an unfounded dispute
  would be a long-lasting distraction from work on QEMU.

Revise the policy to permit AI assistance where the ramifications of
copyright violations are at least easy to revert and unlikely to spread:
tests, documentation, mechanical changes, and small bug fixes.  Core code
that other things depend on, and that cannot simply be thrown away once
a problem is noticed long after the fact, stays off-limits without prior
agreement from a maintainer.

Related to this, and already visible in the incredible uptick in
security requirements, is the question of maintainer burnout and the
shift in effort from the author to the reviewer of the code.  AI lowers
the cost of producing a patch but does nothing to lower the cost of
understanding and reviewing one; if anything it raises it, since a
reviewer can no longer assume that the submitter has reasoned through
every line.  The limits above work just as much to keep the volume of
review work sustainable.

Furthermore, introduce "AI-used-for:" as a trailer to record where AI
was used, and include other suggestions that help reviewers judge
the result.  The standard is slightly different from the more usual
"Assisted-by", which doubles as a check that the author has read the
policy.

In any case, use of AI does not relax any other contribution requirement:
authors still comply with the DCO and take responsibility for the whole
patch via Signed-off-by.

[Commit message largely based on
 https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
 Kevin Wolf. - Paolo]

[1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues

Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>
Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260528073412.551117-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
 - add warning emphasis to policy
 - add Documentation to list of acceptable uses
 - make clear maintainers have discretion to accept/reject large AI changes
 - make it clear a human should write the commit message
 - rephrase "presence" to "usage"
 - make helpful/unhelpful prompts clearer
---
 docs/devel/code-provenance.rst | 172 +++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 61 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 65b8f232a08..3085c2e99dc 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -1,7 +1,7 @@
 .. _code-provenance:
 
-Code provenance
-===============
+Code provenance and AI usage
+============================
 
 Certifying patch submissions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -288,62 +288,112 @@ content generators below.
 Use of AI-generated content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
+.. warning::
+
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU. This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.
+
+The increasing prevalence of AI-assisted software development,
+and especially the use of content generated by `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
+poses a number of difficult questions.
+
+Risks to open source projects include maintainer burnout from an
+increased number of contributions, as well as the risk to the project
+from unintentional inclusion of copyrighted material in the LLM's output.
+In order to mitigate these risks, the QEMU project currently allows
+using AI/LLM tools to produce patches in a limited set of scenarios:
+
+**Mechanical changes**
+  If you can use a deterministic tool or a script, it is preferred
+  that you use it and not replace it with AI. If you don't know how
+  to do the change deterministically, you can ask the AI for help.
+
+**Small bug fixes**
+  These should be limited to 20 lines of code or less, not including
+  tests. You are still expected to understand and explain your changes
+  and the rationale behind them.
+
+**Tests**
+  Note that you must still confirm that each test actually exercises
+  the intended behavior including, for regression tests, that it
+  fails without the code under test and passes for the right reason.
+
+**Documentation**
+  Updates to documentation can be driven by an AI tool. However it is
+  essential the result is carefully reviewed before submission. LLMs
+  can write nicely worded and plausible prose that is still incorrect.
+
+These boundaries do not apply to other uses of AI, such as researching
+APIs or algorithms, static analysis, or debugging, provided the model's
+output is not included in contributions.
+
+If you wish to send large amounts of AI-generated changes, or any other
+contribution not in the above categories, please get in touch with the
+maintainer beforehand. It is at the discretion of the relevant
+maintainers if they would review and accept such contributions.
+
+**Use of AI does not remove the need for authors to comply with all
+other requirements for contribution.**  In particular, the
+``Signed-off-by`` label in a patch submission is a statement that
+the author takes responsibility for the entire contents of the patch,
+certifying that their patch submission is made in accordance with the
+rules of the `Developer's Certificate of Origin (DCO) <dco>`.
+
+Commit messages for AI-assisted changes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+AI tools **should not be used to write commit messages**. The act of
+summarising and explaining the reasoning for the changes is an
+important demonstration of the human authors understanding of the
+commit.
+
+When AI/LLM tools produce or substantively shape your patch, add an
+``AI-used-for:`` trailer along with the sign-offs and other metadata
+at the bottom of the commit message. The text of the trailer could be
+one or more of ``code``, ``tests``, ``docs``, ``research``, possibly
+followed by an explanation in parentheses:
+
+.. code-block:: none
+
+     AI-used-for: tests, docs
+     AI-used-for: code
+     AI-used-for: code (refactoring)
+     AI-used-for: code (prototype)
+     AI-used-for: research
+
+The trailer is intended as a clarification of your DCO obligations as
+well as to guide reviewers. It is not intended for minimal usage such
+as autocomplete or asking for a pre-review of the patch, and it does
+not remove your responsibility to understand the changes that you are
+submitting.
+
+There is no requirement to include your prompts or summarize the
+conversation in the commit message or cover letter, but you may do so
+if you think it helps a reviewer judge the result. For example:
+
+**Helpful prompts**
+  These describe concrete constraints or instructions, making it easy for a
+  reviewer to see how the tool's output was guided:
+
+  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
+    function already has a local variable or parameter of type ``struct
+    bb``, use it instead of accessing ``aa.bb``"
+
+  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
+    the implementation, take the lock around the calls and forward to ``T``"
+
+**Unhelpful prompts**
+  These are too generic to provide meaningful context:
+
+  * "write user-facing documentation for the new tool"
+
+  * "write testcases for the new functions"
+
+QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
+particular, it is not necessary to specify the exact AI model or tool
+used to create the commit.
+
+Deterministic tooling (sed, coccinelle, formatters) is out of scope for
+the trailer, but should be mentioned in the commit message.
-- 
2.47.3


