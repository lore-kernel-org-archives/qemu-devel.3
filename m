Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB6CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVMO-0003b4-RE; Thu, 28 May 2026 03:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVMN-0003as-36
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:40:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVMK-0003ND-Ef
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:40:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so131929635e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779954050; x=1780558850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heN/iNXXjrx0Z59Rls7bTFSXyDr5Jf1C11mFRHK8PsE=;
 b=wz/2QaYDoAnhP7lMp+4hLuYjKjuOSbSCjHHHcgAYDqBiV8aTtXr/balQZikCtH9lCL
 Q28oK1VVeFXqkiMv0ptveFExg5Sxa5/A257bCN8s/aATDmLOdyFM34FK1TwtkhVbC+hG
 P0UNQni7FaEf3i9ud13vT2kVYlv5ig4FI6peHL0uEag+GgogGLiQfkCRxqx9e9PxZeXH
 9cBsgMS3Jx6KBc0jc7E3lB3HwABEZCK6l+AUiLCz+CP+Aht8skBqp70sV3I519OXCWBO
 H50zWlw5Ppd0IzXZzVHfVpL4afEQuRTh5VUOXKB6kuJ1BizxDsb74F51dspI9xf/jibW
 gHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779954050; x=1780558850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heN/iNXXjrx0Z59Rls7bTFSXyDr5Jf1C11mFRHK8PsE=;
 b=XGh8z8oj0ZerMeKLE/VEBf4LPi0uy1jL1U9TJ7skTCjR9y4N7BClOQdRxE7b30ONcn
 FPK3pqkwgsedj3Zf780i1p6ZZF/dZOPL11Wh0w+/xQj5XoDnP10OxT/zt2zfNQA+Zxbh
 7MfT2sieDbBFass16GDW2LgTlho4WmFBiIfOcHjrX0jO88c4NvvyyOvQbVtAqOvXGNFb
 orYe5Jzbw2nCrh5N17mPKVyPMKxVl6SNJbNmbcvg+SaWNxyCKr9vhbpvjuoCouudLdlU
 /syB93je9bijwqd4KA0baKrL8ZI++PMBmhqc5qBQPbQkN5FCBU5d+SKjgBvyBQp0VIpX
 zGVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EulpIbWG4MsBKw4CE4aKbXV5fqZZQVM0dbnZUaMtra/gLxLLxEmUoEkppJqJtBBPgraEOseOORWzJ@nongnu.org
X-Gm-Message-State: AOJu0YwWoMsF9IjgAG1iCc2x0PR7jjrBFJzOcQ0TABqh+cWMGgpzvO4M
 ytmeAtgpbPajT/CEDKTLfwBnh2Z7Y6MAeP99YbccWtnbDDPXTlSufkYEK6iuParu/K8=
X-Gm-Gg: Acq92OFoOStn4G05cXo6xZboXVqYmlTx2ozeuz6b6YRyObmB/+Bcquj4ifOW7p+T9kd
 u5SsGe3OOlwqSVZSnNvvMItayM2a4g1s0UT+LXprBdf0OFw33RpSv6h91AlCYSOjM/zdJhhKIiw
 xCXcEAHYkbDLGphTQIKjODG285MjIA4jrlUEJ3Fo5UTyeNrp2Z/ukiYWSD60nvVMnp+sCbj+aVx
 +ZkftpLO5Bap6Zf34O17FUVRDdknVyRQjeDJnERIJEgllQ2tC870+ue4DiSAk3E5a1kfjDXU8gJ
 DUkFKcfwhBO9Ef7CuaUCGQFdqg8T84QlpY7lOaBKyNyiJJXkkFSNXFHecQ016Zj0PmgdPrLl+cP
 46nYOYLtBDdwkyTO61AJmwmR0v0e/Vceyj6v37Vi7jiQqdcCE9Z03XDYo0/XgPiR5k9QAemLxY0
 D0X+v1kj9ElrZ0WB6enSeryM2MkcnCsuugUq17ZVC9XpJZbjDPxTNYVTJu4xSyY5sX3eR/VHkI0
 kGZ
X-Received: by 2002:a05:600c:35c9:b0:490:45bb:8dd8 with SMTP id
 5b1f17b1804b1-49045bb8e65mr433490625e9.25.1779954050230; 
 Thu, 28 May 2026 00:40:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909235f8c3sm22310085e9.2.2026.05.28.00.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:40:49 -0700 (PDT)
Message-ID: <6574cb8f-250b-403a-be99-c116a6814075@linaro.org>
Date: Thu, 28 May 2026 09:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <bonzini@gnu.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Hi Paolo,

On 28/5/26 09:34, Paolo Bonzini wrote:
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
>    legal trouble so far, which suggests the probability of the risk
>    materializing is not high;
> 
> - other organizations, such as Red Hat[1], have assessed the risk as
>    acceptable -- though a community of individual developers does not
>    have the legal backing of a company, and even an unfounded dispute
>    would be a long-lasting distraction from work on QEMU.
> 
> Revise the policy to permit AI assistance where the ramifications of
> copyright violations are at least easy to revert and unlikely to spread:
> tests, documentation,

Here you mention documentation, ...

> mechanical changes, and small bug fixes.  Core code
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
>   https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>   Kevin Wolf. - Paolo]
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
>   docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
>   1 file changed, 75 insertions(+), 48 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 65b8f232a08..84f9f4a70fb 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -1,7 +1,7 @@
>   .. _code-provenance:
>   
> -Code provenance
> -===============
> +Code provenance and AI usage
> +============================
>   
>   Certifying patch submissions
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -288,62 +288,89 @@ content generators below.
>   Use of AI-generated content
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>   
> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. With AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>   

... however it is not listed in the "limited set of scenarios" ...

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
>   
> -Exceptions
> -^^^^^^^^^^
> +     AI-used-for: tests, docs

... still being listed as exception here.

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
> +
> +QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
> +particular, it is not necessary to specify the exact AI model or tool
> +used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.


