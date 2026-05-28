Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C40DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWf9-0002eF-Tm; Thu, 28 May 2026 05:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSWf7-0002dt-PO
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:04:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSWf5-0003sl-33
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:04:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so7694527f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779959057; x=1780563857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFf0K7ygG6JskBLR4RA2iatNdH4Qzn/VQULyCibVPXo=;
 b=Qo+P5BEkYljv796afEJQbTCPaw5jJUse6pD5W4jz96Z+o8L3KatFsXTzwoz11ecWLj
 uhd4jb0lsb66a6G98Rw1Zy8eOIS9VJpkd7ghG3oX7VZbNB9orTALBa8QUSg4YP8odQQC
 1+j1vACp7Q6K7UgGCnRvFAoFBs3apDFzDr89WwEg7rqXm7KpdEoZL5KZZ1c8jn/fj8rI
 5iKeGn77mr7k+X+cxb38cSSbTbwkU7C9qTFHgF4XKmA0wNS0zH4dc/LsC5D2636z+GTs
 a309OCvqWBKOUoUYFm8wuqAE7rCEi5HSlXujO3xdJ3vp5YIKhhISha8XZ0ddEU1Psllb
 ybkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779959057; x=1780563857;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFf0K7ygG6JskBLR4RA2iatNdH4Qzn/VQULyCibVPXo=;
 b=NyIfbZL0IMtMRsrI1bOQLxpHxOoBt/FGDkoc5wcaPLY4g3wqA5zzqDd4rUiDnhiotZ
 tp62vXcx0a2ZCD3KwJtag8pe8BVM3qZX7OolRDeJz6oeXn1DK5MnuPj+sjcqCje6YvTG
 YmKfsTIF2/xJSTTiuczZMQqAaBreoH/2d+2Z0162cJ/r5jh0BXe0+iraXY7GA3P2RACh
 uPWH9VNFPmLCkeJK7p1pziRaq6Vkyp4qewRpUzITIbNigrgxVubW4j+kJSiHPVw/Rncc
 1Usx/ZzHtgdjfv0r2Cw0d0F9/0pSYPzDyknm9D1T/J9wQ5yogoSJ06u9Bsy7ElDi2LBb
 /3ww==
X-Gm-Message-State: AOJu0Yw8IN4LGkJOIMr9HJmZ/JzfYcOnmadrhT+nLqQVq8mO5QgPiUT5
 UdXhXktGlzbnqDr+8QoiC/EaFstGJHDQRcAGSFFUeJ7Bz1i2FCNSLF6j/2ZFLtVJY5RczmWZDVu
 aE433
X-Gm-Gg: Acq92OG/igksEMC3cK7BDfs3Dq15NOi+gjZEg2sx8Lh8YuuUCsaJY1VN04+2Qt2jASW
 7liXivLzU/7Bv6L+WoFWowEItxvsyx3tGdKbQV+YXSxVCeHinM5GLVhJX6Es+nZrRubWBhJWBBy
 8ZavlRPP3pHMtqfoZtdTRZ83I5qnPru+aer8Vsky1HZ3eLDzGkyloCrOsZCy6FzhtysJatXsCEI
 vfsgE7tdsDpP2p91kIdof1hpgWUR08zeRU5m66+OzwzdwU31GwmLq8dchF/yeaLvdu+CAMy8e85
 vZgl3imbDPz2Zq3Ko/2rT7DlkLZWoPPMi9G1twV93+Q32xBi98rGoK+jX0zg4sRf/Qib4zq5/fM
 2/mL/6utpZ0rVJyrysSIGb7UDK3vOopCA59Q80iS5cr9qA720mJ9DYr7Ub8S1+3Tk/BJOePOJX5
 ON+kxU9FNqquMQoiffuIYywbhQzKjUVZNPCg==
X-Received: by 2002:a5d:64e4:0:b0:45d:3a84:709c with SMTP id
 ffacd0b85a97d-45eb38d45e6mr44913889f8f.31.1779959056613; 
 Thu, 28 May 2026 02:04:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a07sm11323221f8f.19.2026.05.28.02.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 02:04:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC3645F886;
 Thu, 28 May 2026 10:04:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Alistair Francis <alistair.francis@wdc.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Paolo Bonzini
 <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 28 May 2026 09:34:12 +0200")
References: <20260528073412.551117-1-pbonzini@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 28 May 2026 10:04:14 +0100
Message-ID: <87tsrrx5v5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

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
>   legal trouble so far, which suggests the probability of the risk
>   materializing is not high;
>
> - other organizations, such as Red Hat[1], have assessed the risk as
>   acceptable -- though a community of individual developers does not
>   have the legal backing of a company, and even an unfounded dispute
>   would be a long-lasting distraction from work on QEMU.
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
>  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>  Kevin Wolf. - Paolo]
>
> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-sourc=
e-navigating-legal-issues
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-m=
st@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 48 deletions(-)
>

Some purely cosmetic clean-ups:

  - use warning block to highlight the please read
  - code-block:: none to stop weird syntax hilighting of tags
  - re-flow the example prompts instead of raw bullets

--8<---------------cut here---------------start------------->8---
modified   =EF=80=96 docs/devel/code-provenance.rst
@@ -288,9 +288,11 @@ content generators below.
 Use of AI-generated content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-**Please read the below policy before using AI to contribute code or
-documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
-Llama, and similar tools.**
+.. warning::
+
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU. This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.
=20
 The increasing prevalence of AI-assisted software development,
 and especially the use of content generated by `Large Language Models
@@ -339,7 +341,9 @@ Commit messages for AI-assisted changes
 When AI/LLM tools produce or substantively shape your patch, add an
 ``AI-used-for:`` trailer.  The text of the trailer could be one or more
 of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
-explanation in parentheses::
+explanation in parentheses:
+
+.. code-block:: none
=20
      AI-used-for: tests, docs
      AI-used-for: code
@@ -357,16 +361,23 @@ There is no requirement to include your prompts or su=
mmarize the
 conversation in the commit message or cover letter, but you may do so
 if you think it helps a reviewer judge the result.  For example:
=20
-* yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
-  function already has a local variable or parameter of type ``struct
-  bb``, use it instead of accessing ``aa.bb``";
+**Helpful prompts**
+  These describe concrete constraints or instructions, making it easy for a
+  reviewer to see how the tool's output was guided:
+
+  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
+    function already has a local variable or parameter of type ``struct
+    bb``, use it instead of accessing ``aa.bb``"
+
+  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
+    the implementation, take the lock around the calls and forward to ``T`=
`"
=20
-* yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
-  the implementation, take the lock around the calls and forward to ``T``";
+**Unhelpful prompts**
+  These are too generic to provide meaningful context:
=20
-* no: "write user-facing documentation for the new tool"
+  * "write user-facing documentation for the new tool"
=20
-* no: "write testcases for the new functions"
+  * "write testcases for the new functions"
=20
 QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
 particular, it is not necessary to specify the exact AI model or tool
--8<---------------cut here---------------end--------------->8---


> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index 65b8f232a08..84f9f4a70fb 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -1,7 +1,7 @@
>  .. _code-provenance:
>=20=20
> -Code provenance
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Code provenance and AI usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20=20
>  Certifying patch submissions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -288,62 +288,89 @@ content generators below.
>  Use of AI-generated content
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20=20
> -TL;DR:
> +**Please read the below policy before using AI to contribute code or
> +documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +Llama, and similar tools.**
>=20=20
> -  **Current QEMU project policy is to DECLINE any contributions which are
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>=20=20
> -  **This policy does not apply to other uses of AI, such as researching =
APIs
> -  or algorithms, static analysis, or debugging, provided their output is=
 not
> -  included in contributions.**
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>=20=20
> -The increasing prevalence of AI-assisted software development results in=
 a
> -number of difficult legal questions and risks for software projects, inc=
luding
> -QEMU.  Of particular concern is content generated by `Large Language Mod=
els
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +**Mechanical changes**
> +  If you can use a deterministic tool or a script, it is preferred
> +  that you use it and not replace it with AI. If you don't know how
> +  to do the change deterministically, you can ask the AI for help.
>=20=20
> -The QEMU community requires that contributors certify their patch submis=
sions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Small bug fixes**
> +  These should be limited to 20 lines of code or less, not including
> +  tests.  You are still expected to understand and explain your changes
> +  and the rationale behind them.
>=20=20
> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. W=
ith AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>=20=20
> -Where the training material is known, it is common for it to include lar=
ge
> -volumes of material under restrictive licensing/copyright terms. Even wh=
ere
> -the training material is all known to be under open source licenses, it =
is
> -likely to be under a variety of terms, not all of which will be compatib=
le
> -with QEMU's licensing requirements.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>=20=20
> -How contributors could comply with DCO terms (b) or (c) for the output o=
f AI
> -content generators commonly available today is unclear.  The QEMU projec=
t is
> -not willing or able to accept the legal risks of non-compliance.
> +If you wish to send large amounts of AI-generated changes, or any other
> +contribution not in the above categories, please get in touch with the
> +maintainer beforehand.
>=20=20
> -The QEMU project thus requires that contributors refrain from using AI c=
ontent
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +**Use of AI does not remove the need for authors to comply with all
> +other requirements for contribution.**  In particular, the
> +``Signed-off-by`` label in a patch submission is a statement that
> +the author takes responsibility for the entire contents of the patch,
> +certifying that their patch submission is made in accordance with the
> +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
>=20=20
> -Examples of tools impacted by this policy includes GitHub's CoPilot, Ope=
nAI's
> -ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> -generation agents which are built on top of such tools.
> +Commit messages for AI-assisted changes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20=20
> -This policy may evolve as AI tools mature and the legal situation is
> -clarified.
> +When AI/LLM tools produce or substantively shape your patch, add an
> +``AI-used-for:`` trailer.  The text of the trailer could be one or more
> +of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> +explanation in parentheses::
>=20=20
> -Exceptions
> -^^^^^^^^^^
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
>=20=20
> -The QEMU project welcomes discussion on any exceptions to this policy,
> -or more general revisions. This can be done by contacting the qemu-devel
> -mailing list with details of a proposed tool, model, usage scenario, etc.
> -that is beneficial to QEMU, while still mitigating issues around complia=
nce
> -with the DCO.  After discussion, any exception will be listed below.
> +The trailer is intended as a clarification of your DCO obligations as
> +well as to guide reviewers.  It is not intended for minimal presence
> +such as autocomplete or asking for a pre-review of the patch, and it
> +does not remove your responsibility to understand the changes that you
> +are submitting.
>=20=20
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
> +  the implementation, take the lock around the calls and forward to ``T`=
`";
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

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

