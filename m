Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A22CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSadF-0007zQ-6t; Thu, 28 May 2026 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSadC-0007z0-8b
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:18:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSad6-00081v-4c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:18:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4FE66EA7;
 Thu, 28 May 2026 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779974306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqoK0yHxANAFUsIIcBzQs+9C7H9VnAC+b+rKf+b0Z8M=;
 b=2W0EKcn3M67x+7yf2whN0RyflII+axS5Lm0bDvXkoxUoDk4z/DkK92gn4mt7CuUngW87ex
 hQoBBFNrLo0j6j0SumeN7wlv2tANJpKXUG69ndWuvH3yHNhDiK9SJO/jm7XGntXZTJvuHu
 FXe6BioIksaJkOtZHMKJ1lxpMSgpxrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779974306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqoK0yHxANAFUsIIcBzQs+9C7H9VnAC+b+rKf+b0Z8M=;
 b=2zon/qVH2TxEJYs2JjMqCU2UEaLvbfK6ciDml5GTaijFCglqpD9/RKudF7hWrgm3o+BVXv
 PiWuX4jpGvOx5XDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779974305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqoK0yHxANAFUsIIcBzQs+9C7H9VnAC+b+rKf+b0Z8M=;
 b=Y840cMDD1RuJ0B6Kqn1PE+ur+AIVlgHLw9OYoOhTdCAe+SVzxG2m8TINFRzEYqtUUl1yLj
 aw+nHTOhVvbpUELbLdk9y9qVbvgDHTjtcgfTh7mntABh8qtP9TcfDe1eV5iHJUWoZpwxt4
 nBL/EXrCI8fQKVmjA6zYP8NIR3GXvuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779974305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqoK0yHxANAFUsIIcBzQs+9C7H9VnAC+b+rKf+b0Z8M=;
 b=3DVUkBaIzKu32UcOdKdHbDSWrMc1lbc203VBr11LsieRdTQlmeWqb86pI4WhC59Bw4WVAd
 eAC9j/gDLIBWKlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FE515ADDD;
 Thu, 28 May 2026 13:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 04KBNKBAGGpMNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 May 2026 13:18:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis
 <alistair.francis@wdc.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com>
References: <20260528073412.551117-1-pbonzini@redhat.com>
Date: Thu, 28 May 2026 10:18:22 -0300
Message-ID: <8733zbvfj5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, wdc.com:email,
 wikipedia.org:url, bsdimp.com:email, imap1.dmz-prg2.suse.org:helo,
 gnu.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> +such as autocomplete or asking for a pre-review of the patch,

I'm not sure I understand this sentence. Maybe:

"It is not intended to list minimal usage such as..."

unless you mean something else.

> and it
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

