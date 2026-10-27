Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C644606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DQ0+KM+L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlUU-0003ZG-E8; Tue, 27 Oct 2026 14:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlUF-0003YR-4U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:01:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlUD-0002JU-0C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:01:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso1000325e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793124083; x=1793728883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1pJMkL5LbRA7+b3zo03kKDm+u16D80247M1e3FD9EJ0=;
 b=DQ0+KM+LQs26TkSqJFIDBmjjIE5DxTVsf4CbHG1xCZAi4wtWbaKUsJBMnMmCCZ+51D
 LpTljo0Y3uaPQRWuMXTUoGtJmLJZP0QM5D5OoEChf4ZRUJH3zqfqH7fzJTPkfbMJXl9X
 TW9G2xhPSrdBi4rk6wCLatdDhCh8XdD+USJDJaxATdG784eMXKqhKe/KM/14qpREBJi0
 EkA9qIaDtpnvITxcLRNdBbf2pBnVkmqFMgDRqMhTMV+nfaCZHs7WENkltGLxtGXTyPaf
 EwWSsqO6/Q4aBCCVYifsN3IdtjZjEe+XtJf1gdf5QmivILOtXAPWL/HQ3HiAqmqlD12p
 5ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124083; x=1793728883;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pJMkL5LbRA7+b3zo03kKDm+u16D80247M1e3FD9EJ0=;
 b=vesYKB9cvcg1I2hAx76mGzxlp56S4ESw92KRwGxS75Ri8zR3VvfgzDy9ZD5yqS2+vy
 vO7XextLs/THQUMaOWNER//qpIZQ2pzhk+Ko3QffXmPc/m5ZQSxyBtXPoV8zd4f2yw50
 hTlNKgIWPqOlmweNBuis7ArRvGHLq6bT1alQRJ8HTYrrIqBeG+Da4muOkluz4x6anAlI
 ki7XjKG2a/7ufkX8pT7yoej2sbfhudUp/n+gD5QjWCQKa51eLKD7zdE831YrVTOBKgJG
 +PRnF1etO3a+t0mocXKo/jsX7a4Cob3KLPEyCsxEWGt57BGBKLDSISmguINXa2S3Q09O
 kJNQ==
X-Gm-Message-State: AFq9FYJDd9F8RokVnrxIdRDidhIsrhY5HOQ6G/Pb0zGElbgw+7rUQhw2
 4qKOU4x/No/weIpBA++G6kPF2yIlprMwtjMuiS0Zd9IIAXdMGwdQzzS+0Y9f2mZdofU=
X-Gm-Gg: AYBFou2rcHu/KG/HjN5z4qkJTnfbaKw/M8M5AZmEE+rIEyybe+EVIa/8fsrN55s+E8z
 2JlO93skKyFygiztXmrrADSiM0JYDV3CT/1TIYSnYn+ARWUb65CGH5EoYNZTFlxCsqcfHuU9LLQ
 USfA13tSyKowL8utxhngcQAsmkH4TWdLjTiXDf6wYZLEfp6O4hqVnalMPWCnvBwUQkWAmS7mFwg
 ZESHvGp89qBZei75KVnXJYLJbmtFkqBaPGs7cegcTfoiUshyBgcQO9JmJqrg4oo4uxwdk/IrFhf
 WB/7/ti9zWtcM10eOqqG5vgiF+VzNVI2IMCBR8NCAWUSf+pksZI3epxrZ1dhOIFIEDVOzFw3mEQ
 +zHCe2WrJH9y21Vcotj6KykA1hh/ESgw3AlzZolDsf7hkwGA7Wp3al+EIYd3ugzDpK6RIQBUhqQ
 C+KxFwWednZ2Mck061ExAxJH3ThVptyzo6PRuKNH3JpGDFgnhglXxT+FOtuJcRRXjMuVagf/CBA
 stOddpoXfbYrYt93Lvlw0j2BVAVK2X1DRsFgGybTSKuCsPh3sgg5lG0rNJbgZq7OnVc6OximxLZ
X-Received: by 2002:a05:600c:3b02:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4a35acb234emr208829675e9.20.1793124082665; 
 Tue, 27 Oct 2026 11:01:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92bd50b05sm7951045e9.12.2026.10.27.11.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:01:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EE095F81F;
 Tue, 27 Oct 2026 18:01:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260930085433.830743-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 30 Sep 2026 10:54:30 +0200")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Tue, 27 Oct 2026 18:01:20 +0000
Message-ID: <87zevzqaz3.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paolo Bonzini <pbonzini@redhat.com> writes:

> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify and enforce.
<snip>
> +LLM-assisted and LLM-created contributions
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use of generative AI can be classified in the following four buckets:
> +
> +- "background" assistance, such as completion and code review.  This does
> +  not need disclosure.
> +
> +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of cod=
e)
> +  are allowed with disclosure.  Splitting a submission in multiple parts
> +  is **not** a valid way to bypass this rule; repeated, frequent posting
> +  of such fixes must follow the rule for full contributions.
> +
> +- use of LLMs to help generating parts of a larger patch---test cases,
> +  adaptations of existing code, boilerplate code for a new API, a tool to
> +  help performing mechanical changes, etc.  These are generally allowed;
> +  disclosure is highly recommended for non-trivial, functional code.

Personally I'm happy with the next bit but if there is still
disagreement about the wording could we merged the policy updates up to
this point and defer larger contributions until we see what the
practical effects are on the list?

> +- large, heavily LLM-assisted contributions where LLMs write large parts
> +  of functional code.  These are only allowed if *pre-arranged*,
> +  *high-quality* and *well-tested*.
> +
> +The last case (*"LLM-created contribution"*) is the one that requires
> +a more careful approach.  In particular:
> +
> +- "Pre-arranged" means that a maintainer has communicated ahead of time,
> +  for example on `IRC or the QEMU mailing
> +  list <https://www.qemu.org/contribute/>`__, that they are willing
> +  to review an LLM-created contribution.
> +
> +- "High-quality" means that the contributor must apply the same judgment
> +  that would be applied to other code changes.  Contributors must invest
> +  substantial time reviewing their contributions, curating them, and
> +  understanding them in depth.
> +
> +- "Well-tested" means the LLM-created contributions will be held to a
> +  higher standard than human-created ones, because LLMs make it easier
> +  to write tests.  There are no exceptions for "writing the tests seems
> +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>=
`__.
> +
> +.. note::
> +    Pre-arrangement ensures maintainers have bandwidth for review before=
 a
> +    contributor invests effort in creating a large change.  This is not
> +    a new concept in QEMU: maintainers have always encouraged early
> +    alignment on mailing lists or IRC prior to major architecture or
> +    subsystem refactoring.
> +
> +    Maintainers have freedom to determine what constitutes "high quality=
".
> +    Because LLMs lower the cost of patch generation, maintainers may dem=
and
> +    significantly larger revisions than for purely human-written code.
<snip>

But for my part have a:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

