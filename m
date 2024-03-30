Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0538CD1288
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 14:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqa0Z-00028X-JP; Sat, 30 Mar 2024 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqa0Y-00027m-1D
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:48:34 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqa0W-0006xT-AQ
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:48:33 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513e89d0816so3164857e87.0
 for <qemu-devel@nongnu.org>; Sat, 30 Mar 2024 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711810110; x=1712414910; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wLcvsATfM2+/owsmomcHUczf3j2FECJ4z6goPaJVor0=;
 b=lNULilppURZoij4XHF+rvLFzyg/48b2+8wfLL2X/pMYYN8kzSZr3b95SddkI9yKymO
 OKAT011e5EiAAc36LTaOLHlYjetK0Fum3cvprGwd0lhwqDaMpLXRaWfyk4KwBF+VQ81v
 sIrX1/ye+07ztjgSaRODXgdcLAYKxhnhOQjXsPYMaIGgk9gc/5lV5Qe1GYNBapLodE9h
 frXZKWMH4ChoVTmRD9DoKvuzA5ZYKIivgvq2/1Ce5ULyBK0Y1mnRo6w6JMu0btZ42spJ
 6OtsjE+OtjQ80OwL6/xYvfSDHP+j0aLU5KihmtTz8L/6SE93gJoVG5tuyViNlPtOwtxy
 oR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711810110; x=1712414910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLcvsATfM2+/owsmomcHUczf3j2FECJ4z6goPaJVor0=;
 b=HpBb7/bQGWAoGGdzt1AQwOyJ7fCJGHN1L8P04o4FQBaR318q0HnmYBZ1ACULOi5dnx
 brn3aJYD0WQ2gRnF0PBAKU6JIZAdMsCc7ttYAYGp7Ec8udXbkm8qXgyHwVczjeCyi9kw
 4TUMTDClLASAzxrUfhelTaDyba1ByyTXGqiBkzjOSZuxzLLcruXCUhf3QuDbDJ0PQV0v
 iqnrdvXbtx5wKt8Fh3Dl81Apd/qK1ci+pbEEOKKwQfd+T9pkgOcya58J/5PvxyUDs8hd
 jxFFMQsS0qo/BpglfHCQirU1EFWtkpPe2DJUKKmhBYIOVpZbbCBPWe/BpzX9Mbd/6lSj
 VTKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBTvvy2rABE72Hu9gikwWiWrSz8ySykZHxMWNinIItUst010Jci8NuXK3wfV/GDxdDPNWiBkwzmi388mBL5mTbWo6atkg=
X-Gm-Message-State: AOJu0YzB9u6sse3CrcD6IMPnThAX6rklofUd+Nq8fyvqPLfn9kEkVOTw
 fBXyES99QfofXNGBgKA1GS8Qum7WN9xt22O5lWMkaxNBqnC/ySAf5bqC57kfHT/ifBLQk3k+VnT
 UdS3gwDqNv1B+QMjxGviBO52iS52Wj6Qbm2m02g==
X-Google-Smtp-Source: AGHT+IFfCPt1typDmdbXBezJVueXRp7Jh1EbHD2NYG31rmdhGh5SBHS75EggXIhXdpb5zgW+OIZ1+DovglgMmJT8Ysk=
X-Received: by 2002:ac2:5f86:0:b0:513:cb7a:7cf7 with SMTP id
 r6-20020ac25f86000000b00513cb7a7cf7mr3133868lfe.63.1711810110296; Sat, 30 Mar
 2024 07:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-18-ruanjinjie@huawei.com>
 <CAFEAcA_p6i5KNcQW3NLZY=kwUXuUPXM+8ncC8T-gPNVUWJ6CHA@mail.gmail.com>
 <8263a597-298d-158e-524a-21ac906363b4@huawei.com>
In-Reply-To: <8263a597-298d-158e-524a-21ac906363b4@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Mar 2024 14:48:19 +0000
Message-ID: <CAFEAcA8E8iLmO=qrgeNOM=cLY14RyqpY6NjOdtwRPY8wbVz7uw@mail.gmail.com>
Subject: Re: [PATCH v10 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 30 Mar 2024 at 02:44, Jinjie Ruan via <qemu-arm@nongnu.org> wrote:
>
>
>
> On 2024/3/28 22:50, Peter Maydell wrote:
> > The NMI bit also exists only in the AP1R0 bit, not in every AP
> > register. So you can check it before the for() loop, something like this:
> >
> >     if (cs->gic->nmi_support) {
> >         /*
> >          * If an NMI is active this takes precedence over anything else
> >          * for priority purposes; the NMI bit is only in the AP1R0 bit.
> >          * We return here the effective priority of the NMI, which is
> >          * either 0x0 or 0x80. Callers will need to check NMI again for
> >          * purposes of either setting the RPR register bits or for
> >          * prioritization of NMI vs non-NMI.
> >          */
> >         prio = 0;
> >         if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
> >             return 0;
> >         }
> >         if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
> >             return (cs->gic->gicd_ctlr & GICD_CTLR_DS) ? 0 : 0x80;
> >         }
> >     }
> >
> > Then in icc_rpr_read() we can pretty much directly write the same
> > logic that the pseudocode uses to determine whether to set the RPR
> > NMI bits, after the point where we do the shifting of the prio for
> > the NS view:
> >
> >     if (cs->gic->nmi_support) {
> >         /* NMI info is reported in the high bits of RPR */
> >         if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
> >             if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
> >                 prio |= ICC_RPR_EL1_NMI;
>
> It seems ICC_RPR_EL1_NSNMI in pseudocode:
>
> // GICv3.3
> if HaveNMIExt() then
>     if HaveEL(EL3) && (IsNonSecure() || IsRealm()) then
>         pPriority<63> = ICC_AP1R_EL1NS<63>;
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> else
>     pPriority<63> = ICC_AP1R_EL1S<63>;
>     pPriority<62> = ICC_AP1R_EL1NS<63>;

I'm not sure what you have in mind here? For QEMU,
ICC_AP1R_EL1NS<63> is the ICC_AP1R_EL1_NMI bit in the
icc_apr[GICV3_G1NS][0] value, and ICC_RPR_EL1_NMI is bit 63,
so the C code seems to me to match up with the pseudocode line
that you highlight.

thanks
-- PMM

