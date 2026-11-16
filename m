Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC45606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D0aT8Z3x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xStBf-0007dh-43; Mon, 16 Nov 2026 04:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStBU-0007UC-Ly
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:39:32 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStBS-0007ib-Le
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:39:32 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db0791748so939422d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:39:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794821969; cv=none;
 d=google.com; s=arc-20260327;
 b=O1Do5oOHSfbLWJZ0n1I5mA5x3O7puvxyMpSsn9MPzwoXV0FzRiZ9y3+czic8yUWSo6
 Q77Dh2K5nYBrENIDSi2Hkds4Asi+T9ou5JUMSEeSzV+oCmLRdMqDc8ksE5fl/AyOd1cm
 uJj1YreJmv6lUilZGn5L4Jip+1wX9Iv0pRWO9ZuYFgg47ux1EhMk8J/xIHmIimyBWj/E
 9oSJ0bLPHHEvbQkifSnuB8aNE++XksMA+gktMl4kfFzwLAF0/eliy8ztaRYyp/myQlzy
 grCizdTlsEjizdoLA8NphOT7Xkwv7ESEnnoIiqGjAenuWakUUK0vVhPijFBUKsDN59/7
 T2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y0CCCDmrkaACLJwcZ4fedUr0rieWoTSauijnC1Ky1us=;
 fh=OlIsXiW4bzwVFXZelGQqaYszKezmJxjLqPXicD6K1S0=;
 b=qKak1Zo4YCP0TyTeilt4WvzfvqLzOWWm5O910yCKDYEZ3A6M09hpEptNBTGomKBq3i
 fB9V3kCnLq1K7VOrcvMuLDrLSP0w7qghjgQACAO6rnlysDL/Wq9iua6y+aacr9osUVsh
 gn52ybE2nTIzzMMLQlrHDPB2KuK3KKGvbGHqIEJ2PGLTkhjI04v1t4t9OMJ7kBz7Q8KQ
 2eXVZ6IgjKO1Dc2V5rC8vVJNyIiERTt6nYgFSLB9wPrqowrpSB1qBvK1IUm1FqgAHK/y
 NYGPbqMV/p5fW90V/Z0YXNFLKQaNQhYTPHpWCwkKrs1MpDWwFxDgMpcRTpXRdifGCSLX
 YsRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794821969; x=1795426769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y0CCCDmrkaACLJwcZ4fedUr0rieWoTSauijnC1Ky1us=;
 b=D0aT8Z3xnKCykBAu3GQHIv5e6o2AkbtwUYs5Sw0mtUc7DCLf0cExvG0fj5+X826VDL
 Z5rPBp/kpXGCwOhWwxXWgRH4xOQqBe/xGPXgd0KCRB7SCDLYNu7018NkxsKLBqBWpbj5
 rn1WKaPLeiKmqgQskxXI46jzZjC19kJz5VboPB8JDY+y6tBu+EkFyNuc9OefAV0iGq7r
 TbmkFpeLfi/v8/YdFksYum5Q+WR0gbvX83ZW01SPcs2V9jpMcyOQDTg/Fz21oguLCSpn
 RRvMmaw1xva4yufQxtv3HiXrQZ8pFUuzV041SWfI4l3n0qlDcImLME19X6HNhXxfzrlX
 TpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821969; x=1795426769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y0CCCDmrkaACLJwcZ4fedUr0rieWoTSauijnC1Ky1us=;
 b=2JlC1guZC/L+WqcCboMNjsgkI5pDh+osPXvIChXK8QPLpjaZptipOihuhDiX+l8IF5
 QhywGqA6KyvC6SwfusFWKEC38ZB7e903mkZFAqWx8SB2//9wc1M5FLRhaCRKIe/PdcBE
 opOAn5snJfSbY05xWLomNo/Cr++QvLfqdK64U+CA3KkaHRPYXlYJuePWhhRe6R1c7Q6X
 +sj2knGjjCHy1ZDg4es8Onl6TYFL9GkMRF+V7g74gdDamROyYAmkVjKMdeB2VI34Msvf
 CjMdaoBQr55aUYafEXIX/dag5qfh5m9V+Ehe/lnlilkLzHSEGLzvDFEF6OgLj+YO+lsK
 gIWg==
X-Forwarded-Encrypted: i=1;
 AL+hErESBSi2is5lsEUe0jk5jPSrC0dEcZYqjxyj41wtAgYC9jcqu7vtexFpy/3i4iga6zqx3qKlOM0HA8M3@nongnu.org
X-Gm-Message-State: APuU4Z+xiSSszgce082VfMKbw5LQrmP/sfEiIetfdeM4o2eIvXaCMpUT
 BxU1HU6V9tC2h+GQX0w4d9Kj4ZdEbW/x0VEdqRBIxmW2urgy+dheg+TsUIJ1YOV00p5g7fUFEMr
 WI3y2iDN+lGjttNx+7spDcTbOJ/Z+201P7ri2xxo1rQ==
X-Gm-Gg: AZFdTZfOQeBqtx6qrtMn1d5KGCAYRY53BCE4z8BglqGbLvF6WF/PrgeNgGdYpNYJYeX
 z6koxuSI6i1C9NscXruZ9YMzG5wATxYwwfgVB4XdUR5OJ32tOKhLJHucd8fR42BDQRuyqJk7Omr
 gsfgarPRqOEY5e0DlJo6f55u4TH5Wg+nDB+4EiaQ391LrlFsYehAC9ZxwBhfIg5gABTweTLI5cv
 BQqJvJp1cEo96hxnBD8nfJx0fZp+15fIRCZbyVFoxEpqhnZPozZDbssYRl+1+05lY3SE7q6Csqp
 9VNBN4I7aFge2pPYBsA0KhSdZX/OjXn+YWJf7spJEV0/jzIQ/1jnEeiV9DG/WfsLKsLPQWQ7LTH
 Jtj0xwhEY0iEWMtguIaTiGS8MxNvDezgpJH6ccnYeZfu68Yq30vFWA99XcvfvkY/hcn9ZJ3kIYm
 f3Y107LS/0sxhMFnkudAFs
X-Received: by 2002:a05:690e:118a:b0:67d:b753:f6ff with SMTP id
 956f58d0204a3-67db753fd90mr1175955d50.32.1794821968867; Mon, 16 Nov 2026
 01:39:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109143410.3279305-1-bin.meng@processmission.com>
 <CAFEAcA-yqrPWXngq-pR5F2Eg9qSN=7f+AJThw9SzFtCF-pj7+w@mail.gmail.com>
 <7f1575516a34fa20a587727add826566ddda5c8d.camel@alistair23.me>
In-Reply-To: <7f1575516a34fa20a587727add826566ddda5c8d.camel@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 09:39:15 +0000
X-Gm-Features: AclHuK9zNsmV1LUaAxEn7YyqhUzQQKJPQXadGywGC7Nb5vLNRCz3-VsVB6pXy0I
Message-ID: <CAFEAcA_Uw_Kc8JBfaHtCT7JZGVuLZY8Urj0Espp8XUq-DLjRbQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence: Honor subword lanes in the GEM
 registers
To: Alistair <alistair@alistair23.me>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 04:11, Alistair <alistair@alistair23.me> wrote:
>
> On Fri, 2026-11-13 at 10:00 +0000, Peter Maydell wrote:
> > On Mon, 9 Nov 2026 at 14:34, Bin Meng <bin.meng@processmission.com>
> > wrote:
> > >
> > > The GEM MMIO callbacks ignored the low address bits and access
> > > size.
> > > Byte reads therefore always returned lane zero, causing guest
> > > driver
> > > that reads the station address byte by byte to turn four unique MAC
> > > addresses into the same value. Partial writes had the corresponding
> > > lane-selection problem.
> > >
> > > Extract the requested little-endian read lane and merge partial
> > > writes
> > > with the current register value. Preserve the existing read-clear
> > > and
> > > write-clear behavior and dynamic queue pointer readback.
> > >
> > > With this change, reset the TX queue pointers only when a write
> > > covers
> > > TX-enable and leaves it clear, and only start a PHY operation when
> > > a
> > > write covers the OP/ST fields in the PHY maintenance register.
> > >
> > > Fixes: e9f186e514a7 ("cadence_gem: initial version of device
> > > model")
> > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >
> > This device is used by both arm and riscv machines. Alistair,
> > do you plan to take it via the riscv queue?
>
> I just sent a PR for 11.2, so I'm happy for this to go via the ARM tree

OK, I've applied it to target-arm.next.

-- PMM

