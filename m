Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42487606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MkuwSACV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMThh-0002Yd-PN; Thu, 29 Oct 2026 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMThg-0002YL-13
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:14:16 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMThd-0008S3-E1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:14:14 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b10ac6ab7bso22380307b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294052; cv=none;
 d=google.com; s=arc-20260327;
 b=ox11P5Y78xkEXm6usUH92Q6ls5fa1WSz0SdK9oLjNclN1mOMbw4aZ3jWsd2QR2Kgcq
 l5c2I5mM7o0Ou446Z4ht+9lXFXuDcr8nB9Vb45T1z6LpDX5lXul/dbbmBl+vfLIuJO5G
 UdxWijre0plMUSdEJ3eKdIyk9f0ko+ATT9rhNF8HCjArZpEDDXrkmmNoy/OuzeUBd2Mr
 mcErcXP9x9r7OKT80kNfXDDeNdsy6if21Zg/Rx2KfMzwOox2vtCOYOZWlnhYYqDxCu7U
 cuFFTd/HnpELpDMTui4iBArNc8oXe0fwBc1dXvkQKO3KQMw7YqpziES3+5J2ge7FH7cZ
 y5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OZltaCfsq/DctB9nKAoelIK+foBX9/OFav7sH4VV7Ps=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=pQ7E9YjIRXNILN8wdG0PONMD2Dm2LDeUb6uJecnmLhDzHmHg/UPJOzRB8E4DSR9lcl
 fcMvdK8fGwmaMeboYhBVb+W2DrjrwxGY/Gk2VmfaOagLTJ8/wV3U8BwwBmBZ+VcqxjQV
 BNKbYU3tb0hVe5RULg8SZi5oRfOPiEFuBbEWD9rPmyqZ+BNH4sLiYbi6IAtAJ73A/Xs+
 8rBgwOsQ7cb7wOYCRgx31kBXMLTp+U8fyQRxZJN8mjiDlGRNiI87vkHnkB35RBaY2PUl
 +4JSubtekH/NnBFaDkm7pHZnCk66oxeMkjwcCjCgwiexEV/F6B9BJM8SQ73yytgQWOXS
 5u0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793294052; x=1793898852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZltaCfsq/DctB9nKAoelIK+foBX9/OFav7sH4VV7Ps=;
 b=MkuwSACVX8UYnAqXhpohCjTQkuHeVmCX6U/E71lViXcIfyrx2NLjoDQLaUBQoHRksR
 t+mnLkOnm0sCTT9LxtCyJYnR2SGp9bsISUDC3W0/9o0Vja0aJ9JjXlD9TjBAUtGzR+p+
 Mdtu5/3ykNDk7l2kciYbbCXsYron8nqdb1TP0+jgvu3oDkscRDEw0AM6HfquVyq5vThj
 W3wF3GujoxILhA1bAmKep+mJxon25Xa5aOs8w/h8JAykuTphSXNEHGAQyftRd7WEJMlx
 GdZupX3N5pd4KsXXck4VdkCiz00rsyPtC1chj7X14wjymjUSMfa1ZPCwCPYG5Td/2CJD
 X2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294052; x=1793898852;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZltaCfsq/DctB9nKAoelIK+foBX9/OFav7sH4VV7Ps=;
 b=qCqGyED56BoI+xuJ0XcdH/ZS7saB8HcbmT0Pz1koCA64+CSt1Nl2R9NUGzR+djxuXH
 HkrPRm02cF/fIU0jVQZg9cluq+oh9ykfbp/+vcdi0yqhN3nlMp0wkd1WOHpz0KmxdPbL
 fBcVfOjKuGzDw0Nmro54WFApkcehpXjVqT50/7yx21JHOVbAfQh1SwO57gH/o6gTqlc8
 2AkX3poWN9UIrf1PlO/7j5gzFMf3TdZ+RKuxCX20eIQJ5Nd5XnZu1ktafwnGXVnDYvQ0
 dkYCId2kqBZEcgFXSnBgRpma5iGeY9UgPyVR1oiLh5XIlUzCknBgTx7II2lAyQXSxIy1
 jLKw==
X-Gm-Message-State: AFq9FYI1wZ7xK9tqrbf/pHHIGzGC22ZrXucMYb+e+20eSKAgxSMn/tYT
 FsNmZEvxmT60GAForvc8nRHqB0PVsp4TTXDEk1o7CQbVHNyDlUqbOemMS2pMT30NP6F9lbAPfd/
 llTVLWYR6mD7xRNES3NwntOIt2rpHJnDkMX7QS2dq8g==
X-Gm-Gg: AYBFou0+jkQEYWpmqKshHMvUumOYgDbG5NCzR5vOmUmZqm/zdCzkKqbeY4Y6sPn8L0l
 ncegmJthq4aY7tKO54IxX+jimqDPxgpvh//q5qHB26MQG0yhw8MfHhP60YnR23JCM/bP+C6kwcg
 zT5JVc1u52OWU9JlOFHHaCKRumnnueIrw2VnJe+m+0knRZcQJ7ArrXsgo1Rt/HAQERRVXqvWZ4C
 02FtnNGxcWpaUXidM8p5coed/sN8QPrWb05hy2lCUNoAVXXhN6Fe2LH7dDbwjUfmn4pBMmBEa02
 6Gcac2rICYC6cZ53v//F0RZzsCb6BuFOFr4Pl5uRmdjPhd4h2DW5H6HRQltFnruqMiO7KXfsE24
 27C++W4AmwGsFK4hQR4pg3yXNGIMc1P/gY66w0dg09KZ35wfzpdV1aA52ic7tLDv8+BiSrysShv
 vPQX65iJDi0w5c9ADEHlmZ
X-Received: by 2002:a05:690c:60c7:b0:8b1:58f8:9137 with SMTP id
 00721157ae682-8b1b5d62e29mr36563187b3.57.1793294051790; Thu, 29 Oct 2026
 10:14:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
 <1016C70E-8B1C-4F3F-A19E-59D7A0E66A33@unpredictable.fr>
In-Reply-To: <1016C70E-8B1C-4F3F-A19E-59D7A0E66A33@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 17:13:59 +0000
X-Gm-Features: AclHuK-cMpbWtQzPWK7m8kOfbNLNEPGbtlHca-h7tugsFMt84qz1hwQJpmBBSZc
Message-ID: <CAFEAcA8Ywq6MZxO5jt4AKay8wjWGLQYxnJ1rMkFjzoF1ppUJ3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 17:02, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 29. Oct 2026, at 15:27, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 27 Oct 2026 at 12:03, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >>
> >> v2:
> >> - remove GIC_ISPENDR workaround: currently under further investigation
> >> - simplify SME save/restore patch
> >> - rework the CPU reset strategy, with also taking care of the GIC CPU =
interface registers.
> >>
> >> v1:
> >>
> >> - workaround for presumed Hypervisor.framework issue
> >> - save/restore SME state only when SME is on for the CPU
> >> - add ID_AA64PFR0_EL1.GIC sync to advertise the system register interf=
ace
> >
> > I've applied patches 1-4 to target-arm.next; 5 and 6 I left comments on=
.
> >
> > What's the status with the apple-gfx compile failures on macos 27?
> > (issue #4486)
>
> Hi,
>
> I think we should just disable building apple-gfx by default for now.
>
> It=E2=80=99s private API as of macOS 27, and as long as a decision on whe=
ther
> to keep that reverse-engineered device model isn=E2=80=99t made yet...

That makes sense to me; we've had the vmapple machine disabled by default
for a long time, and that I'm guessing that was the biggest reason to use
apple-gfx.

Do you think we should deprecate the "vmapple" machine type, or do
you hope to resurrect it still?

thanks
-- PMM

