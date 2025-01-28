Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE43DC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmbk-0008BC-20; Tue, 28 Jan 2025 09:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmbR-00086k-6s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:30:10 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmbP-0003cW-5c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:30:08 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so10221782276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074605; x=1738679405; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KfnRXNwtoq63+JTwSqQKWq9zo/egoCS0JS2332mKMWQ=;
 b=ZP+KMPECkIq8RU9NtHRLn17xriqbGN3J5jUd2li3cD9KpgRoWWXTq62csSaB5yAGcE
 +jcsuEld+3C1817yWlB/0dRz6YdTgQa0PoJ4wNIihqPXajPOvp+moUde8WBWaHbHKFEA
 hBmtycXDEuG641g2nW/G1QFAYaZgz3ne7uJ+FJzz4eIwYk8CmswhgdLPAa7LJZH2cml4
 hJQy9Lb3MOieKLxRu7M4zWngDsxnRsAYnMZPHmGsuGta7o5oO265bXAolF24OmDoLvjI
 +ufTPWMXI5wzxjnJ/PdSTdy4tJ+vYRrR3SZP/PaoR/ydJ3OfFS+DrJ7G0FWtYJ2nawJ0
 slGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074605; x=1738679405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KfnRXNwtoq63+JTwSqQKWq9zo/egoCS0JS2332mKMWQ=;
 b=nRiAXt2mdoquGRU7KyOnMHyuva/oXA4g6prk3P7OrUrh+aLi8UBN12Mqfb8EgXNcUM
 hhLtgDT8JYaYy6MY/7nM8186HrJLgmSJaS4E5YXFp/n6RSXVOUuOGFM8S86Z6Ti0CvXg
 gmTKB0LTQYpkvptMO2QzC0/oTh87Kv7e3iB3yRrMXRa/zeIC+xmJHQAzI9JkBEIRb4nc
 EONQDXC5K8zhMqH60w5flgrIiYG6mGX9vb195lzr4T2w9pp3zA0akzHEmEgD2Xn4k6zw
 o6aTLZLe1fAbIijPtqojQlmHtqbf9fjhEZkmxPNOTtSt1UDf7hAdExrqLjgMSI2MLu7m
 xWEg==
X-Gm-Message-State: AOJu0Ywtj7ELLf6ug0iP//B3Hc/NXny+fXEjHGW42D+9GMJgUURM+pBe
 rHUamqm5oVsuJwyuRo+EW7UWvmTFFvriopw5REVeGiVUuMHJruF8HcricG+F3ML3+v6pUOxys3i
 G6f1r12I5M90KbPVAdjQBALW/NnfEfupd88b0Yg==
X-Gm-Gg: ASbGnctJIKqAUNrmLh/IRSeJxcuQoFfH0P/sXHeWN/WDsfCx2sb02gqgKer2B6G47ho
 uQGyJUEsKPQW1lnh96QEs3zmhsWukOO8wLOd2t9SR3VBmX/etyAUtanZXVd4lH7+AdaQGT/vZPA
 ==
X-Google-Smtp-Source: AGHT+IFstsxls7dZvGiRL32ULEyQYQGqRTbguPwodScJ+LKg7TeNWYaYsuA1pO0dHlrnrY4m777Y/HWQQQPbNHuK4Pk=
X-Received: by 2002:a05:6902:1b85:b0:e57:8814:1399 with SMTP id
 3f1490d57ef6-e57b132ef49mr34386955276.44.1738074605443; Tue, 28 Jan 2025
 06:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-6-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:29:53 +0000
X-Gm-Features: AWEUYZl1Uik5r1ilonfBhOWeUeVSqdUIKrs6nssmXlkBBiVAyqYVQSp6J1AyNX0
Message-ID: <CAFEAcA_NBPqbOrVJw=bDC6=dTGKBKe42XoXMm82jj7+pHEvW3Q@mail.gmail.com>
Subject: Re: [PATCH 05/21] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>
> As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
> serial. All other devices of the A53 memory map are represented as
> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
> for running Linux without it crashing due to invalid memory accesses.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS                    |   9 +
>  docs/system/arm/imx8mp-evk.rst |  47 +++++
>  docs/system/target-arm.rst     |   1 +
>  include/hw/arm/fsl-imx8mp.h    | 189 +++++++++++++++++
>  hw/arm/fsl-imx8mp.c            | 371 +++++++++++++++++++++++++++++++++
>  hw/arm/imx8mp-evk.c            |  55 +++++
>  hw/arm/Kconfig                 |  13 ++
>  hw/arm/meson.build             |   2 +
>  8 files changed, 687 insertions(+)
>  create mode 100644 docs/system/arm/imx8mp-evk.rst
>  create mode 100644 include/hw/arm/fsl-imx8mp.h
>  create mode 100644 hw/arm/fsl-imx8mp.c
>  create mode 100644 hw/arm/imx8mp-evk.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 846b81e3ec..cace8cf25b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -819,6 +819,15 @@ F: hw/pci-host/designware.c
>  F: include/hw/pci-host/designware.h
>  F: docs/system/arm/mcimx7d-sabre.rst
>
> +MCIMX8MP-EVK / i.MX8MP
> +M: Bernhard Beschow <shentey@gmail.com>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes

I'd rather we didn't take on a new board model that
starts out in the "odd fixes" state. If you don't
have enough time to look after it, it seems unlikely
that anybody else is going to want to take it over.

> +F: hw/arm/imx8mp-evk.c
> +F: hw/arm/fsl-imx8mp.c
> +F: include/hw/arm/fsl-imx8mp.h
> +F: docs/system/arm/imx8mp-evk.rst
> +
>  MPS2 / MPS3
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org

> +static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    FslImx8mpState *s = FSL_IMX8MP(dev);
> +    DeviceState *gicdev = DEVICE(&s->gic);
> +    int i;
> +
> +    if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> +                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
> +        return;
> +    }
> +
> +    /* CPUs */
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        /* On uniprocessor, the CBAR is set to 0 */
> +        if (ms->smp.cpus > 1) {
> +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> +                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
> +                                    &error_abort);
> +        }
> +
> +        /*
> +         * Magic value form Linux output: "arch_timer: cp15 timer(s) running at
> +         * 8.00MHz (phys)".

"from"

> +         */
> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> +                                &error_abort);
> +
> +        if (i) {
> +            /*
> +             * Secondary CPUs start in powered-down state (and can be
> +             * powered up via the SRC system reset controller)
> +             */
> +            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
> +                                     true, &error_abort);
> +        }
> +
> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index fe47e259b8..adb4ed8076 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -577,6 +577,19 @@ config FSL_IMX7
>      select SDHCI
>      select UNIMP
>
> +config FSL_IMX8MP
> +    bool
> +    imply TEST_DEVICES

Why do we need TEST_DEVICES ?

> +    select ARM_GIC
> +    select IMX
> +    select UNIMP
> +
> +config FSL_IMX8MP_EVK
> +    bool
> +    default y
> +    depends on TCG && AARCH64
> +    select FSL_IMX8MP
> +
>  config ARM_SMMUV3
>      bool

Looks good otherwise.

thanks
-- PMM

