Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E496CC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZJV-0003hE-99; Thu, 30 Jan 2025 13:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZJ9-0003Zq-9k
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:30:35 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZJ6-000336-JC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:30:30 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5acbbfc4e7so1606326276.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261827; x=1738866627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mg4LEiro5KxWJqAmrHuaVCe59h2CM9JFO3fkDS05W30=;
 b=FrnzHzAnyrKh7AalHlmPgQlHdkSca5wYv08IZKYr9YXp4YlV92Pz7IOiVP2dfP56/O
 OMGeLiLymXQuZsuNwMIEzG2Rn2ohB4Yc7iaDEQ73ymPp+pL8cXFDX6uzIFKegYfvbaDJ
 Z+jusqSYcGaPXQSiIF5SmJLxCAsnREhzjBeWNB9zcFgpEIxmwotyv59T18SMR4imInR6
 pM7LK75wjEenWs4vOZ3Xz1CzrQzJLV2UrUCR2kb8CeJiDeVG+o4dAyjHxHO4YrGZTXGt
 OeAdH/c4uhIgrclbXTgZmVUS2LL5ah40uZhuDC9a9BMVLnZKsxjWf8Iy1aFbybFih4N8
 ebEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261827; x=1738866627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mg4LEiro5KxWJqAmrHuaVCe59h2CM9JFO3fkDS05W30=;
 b=sXg6mZ1sx3y5PdSip0OBPYObze+uM0GO+PVrj36/5wherYZfNcMLWVY33KzVBCr5xw
 GjApYP9W9P2BgMdqvbFgO4jqdDYcFAP+3YdTSE3xBZw9cC8YoI/pTXAi0jwF+flv5957
 XKFriv+GzbXMUUPI8rL/XqBtz9GYNpNpwpdq6D1Dphl8jmCRcVHRKKISYJ6R2RB/XZBb
 WdliLpDr6sS2+e2mUhGj6GNIV7IGzSNX3cYOnoHomI10lOuqNveDPupYBfV87CmqcSQ8
 SZS61C3AeKXVYUKoXXzLRbVVZC6H8hMCkihNZZamEZZu/XFxGKxtluIcSMUMQeAZCC7o
 ThEQ==
X-Gm-Message-State: AOJu0YzlrzZs3b8RhlvalkNtoMmTQ1IAFpJe/tIzzOMGAnSkXgIYVBBw
 5s3U983Ej3o/eVMk/n4gzdmEf4AekPUkLCTbYhNzmY2dtl41nm0jKJExhXFLOBWpbq+ctFBWwIV
 tfgkgLkSXILGdrLKlH0c2iBULKRspB0yChNdm2Q==
X-Gm-Gg: ASbGncvExFTtCyT8TsT7HAfoTuRmNcr010K9960MVvMXDQMewUcY1MH7Xusn7/QSHbl
 t8vNGjn87rwbMJmBD2LvmYvhYVK11HBHfH+bG2eK9pYfhc07etYPK/Tz3JgYEAQtgC4IC0jxMzw
 ==
X-Google-Smtp-Source: AGHT+IHdlFVhb0TdbFF0jcsJvjwIxV7fOkyrvAUpEZ0OxfBFbmqInsLAiM5Zm7/6a2677XQYVeRsNJbxmHK6grlQOd0=
X-Received: by 2002:a05:6902:2192:b0:e49:5f2d:e742 with SMTP id
 3f1490d57ef6-e58a4a93a3dmr6595607276.6.1738261826980; Thu, 30 Jan 2025
 10:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-3-philmd@linaro.org>
In-Reply-To: <20250130182441.40480-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2025 18:30:15 +0000
X-Gm-Features: AWEUYZltD4g_TgCGrKhgv7BOBgVqKreBIEfV1QHL2qPf8SseN_6qHaVzJf2N3fQ
Message-ID: <CAFEAcA__VjxHZpFqhnYYU+gV2hg7V-pwq_2ZZSVBQDheSmTvDw@mail.gmail.com>
Subject: Re: [PATCH 2/8] hw/arm/exynos4210: Explicit number of GIC external
 IRQs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 30 Jan 2025 at 18:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
> to make that explicit.
>
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/exynos4210.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 99b05a175d6..75d6e4d1ab9 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -103,6 +103,14 @@
>  #define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
>  #define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
>
> +/*
> + * The Cortex-A9MP may have anything from 0 to 224 external interrupt
> + * IRQ lines (with another 32 internal). We default to 64+32, which
> + * is the number provided by the Cortex-A9MP test chip in the
> + * Realview PBX-A9 and Versatile Express A9 development boards.
> + */

This isn't the A9MP test chip or the vexpress or realview
board, though. We should be setting this to whatever the
exynos4210's GIC is actually configured with, or else saying
we don't know what the right value is but this is the
one QEMU has always used (i.e. probably a TODO comment). Those
Arm devboards are irrelevant either way.

> +#define GIC_EXT_IRQS 64
> +
>  enum ExtGicId {
>      EXT_GIC_ID_MDMA_LCD0 =3D 66,
>      EXT_GIC_ID_PDMA0,
> @@ -588,6 +596,8 @@ static void exynos4210_realize(DeviceState *socdev, E=
rror **errp)
>
>      /* Private memory region and Internal GIC */
>      qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cpu", EXYNOS4210_NCP=
US);
> +    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-irq",
> +                         GIC_EXT_IRQS + GIC_INTERNAL);
>      busdev =3D SYS_BUS_DEVICE(&s->a9mpcore);
>      sysbus_realize(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);

thanks
-- PMM

