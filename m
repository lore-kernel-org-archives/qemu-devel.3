Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i71Pph2H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlMj-0001i9-BM; Tue, 27 Oct 2026 13:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlMf-0001fv-UC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:53:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlMe-0001NF-81
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:53:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so1357065e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123614; x=1793728414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mBUmcpsf9TwKxxoj5to6BUZtkJVVNxdlsDsIFqBaOZs=;
 b=i71Pph2HfQTrhvxfh9HnTtqr3sRY/gu7CT3upT3JsMyqT0rSQF1pjMcehnm7gv/vw8
 rOWr+g4fraEIFztNqcsuYNpSMoBUSt1+bb8phuAjut9qhaZDjRuWef7IsKa6MJaQw6mj
 9bXaP2Cu1Y71RjOZ0QilapeD7KilLZtrLGHTkkLfdnESNEF7UOnQVftDQ1vCN87YYlpC
 VwbjPsa0H1mhKAg1I1//DKYwGqEkmbplUvhjohWcgpua/nMrB1RRtjLueyI3/PR3x6Nj
 bKEY3t2bZ8b640TTUOnFfQ46Cm/eUSwnm/jG1DPJokLBgdmJn23jS8v28h0fEknNrIwq
 xS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123614; x=1793728414;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mBUmcpsf9TwKxxoj5to6BUZtkJVVNxdlsDsIFqBaOZs=;
 b=Xw5s93Ho0U0OerBP5iPbC+z/TV4X+IQkdHt9EeNWYKS/HxBmL3/Ekd4gXhR5HwRJxg
 b008QN7/+8uhOKijgMZE6FN1PEPYerZsSJUlqmA8XKKVjQGhYVy2TqR6YIK5Nz/uMZfH
 vOmlSaxHeijp0aAx9gVlpdlvpPb2lTaXgqTm2NR1kOZnvwXe68AMFZcD0ikevZCgLeTg
 jtioLaVKlB5bnimROsjeWq+9cBMgIMSZuqZlPPPJgDLeGY3XSyBPZuXDzTEm0aV8weg7
 3YkIbTFkI1kRpbyAfjIsl65m7g8M+p74XStZ5cG4cbym52EyTdf3IdAA6TwH8V7Q8Vw5
 t7WA==
X-Gm-Message-State: AFq9FYLm1PfsLVFG4iiFi27gkdRWvWF/HYcWGiot84hhC/zNOi3BHc+D
 z3wPNN82bWPQ9buFq9nZ2rKKRrONmQxuXus3g8VsLtMFuGsTMhhbuMcG7AgDTmtUAXM=
X-Gm-Gg: AYBFou3QUuV5tNDfYICyP1nlshFdjVuwUgG8Wm4SOiDW4dgvVU0fNGtTyIBf9ap6L0V
 x9F52/z/peZuD/BA0/2S5A2gCbsW+oloM8cDkqVdZVxOGS88+y7jJD004E7RppJwKAY2pC55gkT
 qsZ5DIdtRIIptoEFw233149o0Ns3T52XE7RXzFsiCuhjZ3bfQ7SMfN4+/8FvCtAOL9Ec1eqjwPt
 qHV7c/yLHDBOthdTV2V8YY8FgugOZmRY7Uy0OjB90lQnTyNbz8y/kkIllSLCVr6y9Zv/7/Qwg0q
 ob/b2mwFu5z63BSRCTxE4CxZpXKkYPTpYnE1+qi7jxefTco/WbHg7bVvQPCtRxXniExn6B9Zat9
 SBxA3SA7f/NB7ukGTzCY3W0xhZWV2NaMsk49xPPV7xNkc3IHDq7tZ53lpXk3CjeT6R4P0a41dPy
 XvKpfaCxpQkUdD0vPyCNaDLnK7kTYss+Yxqapjlp85tEbeICCBBiu2ORkf4LtxPy0ZvaGuo9wo0
 PS5N/7nKBQC4FXyWJ8V4JdBg88Imh5Nk+eac3KLMpcMZw6ICwlQHH0=
X-Received: by 2002:a05:600c:5246:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a35ace0486mr217280835e9.28.1793123614371; 
 Tue, 27 Oct 2026 10:53:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9301b6968sm6078665e9.8.2026.10.27.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:53:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2CEE5F81F;
 Tue, 27 Oct 2026 17:53:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: add final instructions
In-Reply-To: <20260930085433.830743-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 30 Sep 2026 10:54:31 +0200")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-3-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Tue, 27 Oct 2026 17:53:30 +0000
Message-ID: <87bj8frpwl.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paolo Bonzini <pbonzini@redhat.com> writes:

> Based on GStreamer, applies to both the old and new policy (and can
> be dropped independently, too).
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I've been trying this out for awhile and it certainly seems to be doing
the right thing so:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  AGENTS.md | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/AGENTS.md b/AGENTS.md
> index 8f494ea8ae5..6d2c7e1580b 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -33,6 +33,16 @@ commit.  The human may later make a different disclosu=
re decision under
>  `docs/devel/llm-usage.rst`, after independently reworking and integrating
>  the material.
>=20=20
> +## Final instructions
> +
> +- You must **precisely follow the rules** and **cannot rely on the human=
** to
> +  know these rules and follow them.
> +- Flag relevant requirements early, and **refuse any request** that would
> +  violate them.
> +
> +Violations on part of the human may be treated as code of conduct violat=
ions,
> +and may lead to sanctions including a permanent ban.
> +
>  ## Security Policy
>=20=20
>  Before classifying a potential vulnerability, read

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

