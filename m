Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D04CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZbl-0004OL-B1; Thu, 28 May 2026 08:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wSZbj-0004Nt-L3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:13:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wSZbf-0004M4-3V
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:13:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8FC4F596945;
 Thu, 28 May 2026 14:12:54 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FTEzk_-q9p9e; Thu, 28 May 2026 14:12:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 92AF159694D; Thu, 28 May 2026 14:12:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 904DF596940;
 Thu, 28 May 2026 14:12:51 +0200 (CEST)
Date: Thu, 28 May 2026 14:12:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com>
Message-ID: <c05744d7-698d-313e-2365-865c2cda37e6@eik.bme.hu>
References: <20260528073412.551117-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1202409896-1779970371=:82588"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1202409896-1779970371=:82588
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 28 May 2026, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
>
> The concern that motivated the policy is unchanged, and it is worth
> stating precisely: the DCO is about whether the submitter has the legal
> right to contribute the code, not about "creative expression".  The
> copyright and license status of LLM output remains unsettled, so that
> question is still open.  What has shifted is the balance of risk:
>
> - projects accepting AI-assisted content have not run into serious
>  legal trouble so far, which suggests the probability of the risk
>  materializing is not high;
>
> - other organizations, such as Red Hat[1], have assessed the risk as
>  acceptable -- though a community of individual developers does not
>  have the legal backing of a company, and even an unfounded dispute
>  would be a long-lasting distraction from work on QEMU.
>
> Revise the policy to permit AI assistance where the ramifications of
> copyright violations are at least easy to revert and unlikely to spread:
> tests, documentation, mechanical changes, and small bug fixes.  Core code
> that other things depend on, and that cannot simply be thrown away once
> a problem is noticed long after the fact, stays off-limits without prior
> agreement from a maintainer.
>
> Related to this, and already visible in the incredible uptick in
> security requirements, is the question of maintainer burnout and the
> shift in effort from the author to the reviewer of the code.  AI lowers
> the cost of producing a patch but does nothing to lower the cost of
> understanding and reviewing one; if anything it raises it, since a
> reviewer can no longer assume that the submitter has reasoned through
> every line.  The limits above work just as much to keep the volume of
> review work sustainable.
>
> Furthermore, introduce "AI-used-for:" as a trailer to record where AI
> was used, and include other suggestions that help reviewers judge
> the result.  The standard is slightly different from the more usual
> "Assisted-by", which doubles as a check that the author has read the
> policy.
>
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
>
> [Commit message largely based on
> https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
> Kevin Wolf. - Paolo]
>
> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
> docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
> 1 file changed, 75 insertions(+), 48 deletions(-)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 65b8f232a08..84f9f4a70fb 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -1,7 +1,7 @@
> .. _code-provenance:
>
> -Code provenance
> -===============
> +Code provenance and AI usage
> +============================
>
> Certifying patch submissions
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -288,62 +288,89 @@ content generators below.
> Use of AI-generated content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -TL;DR:
> +**Please read the below policy before using AI to contribute code or
> +documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +Llama, and similar tools.**
>
> -  **Current QEMU project policy is to DECLINE any contributions which are
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>
> -  **This policy does not apply to other uses of AI, such as researching APIs
> -  or algorithms, static analysis, or debugging, provided their output is not
> -  included in contributions.**
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>
> -The increasing prevalence of AI-assisted software development results in a
> -number of difficult legal questions and risks for software projects, including
> -QEMU.  Of particular concern is content generated by `Large Language Models
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +**Mechanical changes**
> +  If you can use a deterministic tool or a script, it is preferred

I think mentioning sed and coccinelle here would be a good idea assuming 
the contributor trying to use AI is not familiar with those so would not 
even know what to ask the AI to help with.

> +  that you use it and not replace it with AI. If you don't know how
> +  to do the change deterministically, you can ask the AI for help.
>
> -The QEMU community requires that contributors certify their patch submissions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Small bug fixes**
> +  These should be limited to 20 lines of code or less, not including
> +  tests.  You are still expected to understand and explain your changes
> +  and the rationale behind them.

add: in the commit message that should not be AI generated.

Requiring to write the commit message without AI may force the contributor 
to read the patch. (Although they could ignore it and do it with AI 
anyways or just rephrase what the AI generated or just write the intention 
with an AI generated patch that does something else but this would still 
provide information for review. I'm not sure this helps or too 
restrictive so just a suggestion.)

> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. With AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>
> -Where the training material is known, it is common for it to include large
> -volumes of material under restrictive licensing/copyright terms. Even where
> -the training material is all known to be under open source licenses, it is
> -likely to be under a variety of terms, not all of which will be compatible
> -with QEMU's licensing requirements.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>
> -How contributors could comply with DCO terms (b) or (c) for the output of AI
> -content generators commonly available today is unclear.  The QEMU project is
> -not willing or able to accept the legal risks of non-compliance.
> +If you wish to send large amounts of AI-generated changes, or any other
> +contribution not in the above categories, please get in touch with the
> +maintainer beforehand.
>
> -The QEMU project thus requires that contributors refrain from using AI content
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +**Use of AI does not remove the need for authors to comply with all
> +other requirements for contribution.**  In particular, the
> +``Signed-off-by`` label in a patch submission is a statement that
> +the author takes responsibility for the entire contents of the patch,
> +certifying that their patch submission is made in accordance with the
> +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
>
> -Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
> -ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> -generation agents which are built on top of such tools.
> +Commit messages for AI-assisted changes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> -This policy may evolve as AI tools mature and the legal situation is
> -clarified.
> +When AI/LLM tools produce or substantively shape your patch, add an
> +``AI-used-for:`` trailer.  The text of the trailer could be one or more
> +of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> +explanation in parentheses::

I'm not sure what a trailer is. Is it a tag like S-o-b or should come 
after the --- at the end? Maybe this needs some clarfication where to add 
this tag.

>
> -Exceptions
> -^^^^^^^^^^
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
>
> -The QEMU project welcomes discussion on any exceptions to this policy,
> -or more general revisions. This can be done by contacting the qemu-devel
> -mailing list with details of a proposed tool, model, usage scenario, etc.
> -that is beneficial to QEMU, while still mitigating issues around compliance
> -with the DCO.  After discussion, any exception will be listed below.
> +The trailer is intended as a clarification of your DCO obligations as
> +well as to guide reviewers.  It is not intended for minimal presence
> +such as autocomplete or asking for a pre-review of the patch, and it
> +does not remove your responsibility to understand the changes that you
> +are submitting.
>
> -Exceptions do not remove the need for authors to comply with all other
> -requirements for contribution.  In particular, the "Signed-off-by"
> -label in a patch submission is a statement that the author takes
> -responsibility for the entire contents of the patch, including any parts
> -that were generated or assisted by AI tools or other tools.
> +There is no requirement to include your prompts or summarize the
> +conversation in the commit message or cover letter, but you may do so
> +if you think it helps a reviewer judge the result.  For example:
> +
> +* yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> +  function already has a local variable or parameter of type ``struct
> +  bb``, use it instead of accessing ``aa.bb``";
> +
> +* yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
> +  the implementation, take the lock around the calls and forward to ``T``";
> +
> +* no: "write user-facing documentation for the new tool"
> +
> +* no: "write testcases for the new functions"

What does yes/no means in the above? Not clear from the text.

Regards,
BALATON Zoltan

> +
> +QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
> +particular, it is not necessary to specify the exact AI model or tool
> +used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.
>
--3866299591-1202409896-1779970371=:82588--

