Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82838C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLbF-0006iT-3l; Tue, 04 Feb 2025 11:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLb5-0006ZW-VM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:16:24 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLb3-0007g6-VK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:16:23 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e46ac799015so5364483276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738685780; x=1739290580; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cN5v5WX4Jvg+QKU02xZK5mgsO2zG9IePeE/6vqvKS7M=;
 b=JaMew2qRauw2GeINZ4QYghpxiyk/ndVpNQZ0xssOoCcWMtY+R1FuBMG92VMJVkPdEn
 pvhx1q5yA7nsESMia4cCYwMIyKzM0F5uy83OfZy3uDSbTcDdga3FTx74SU0H09w8lz5Y
 /l7X+u3XHeUH+PE76i5Zua5vnJHQtbd0Xub38Vzn5/UcYfdZSHjVoVSlr6p13FW0Uik1
 CZyhej751odirMeFunpSZm3IYT2xHb43lbKJdeg6rXqDfRtQn6AThxQmresAL8Z9aUvR
 acVpKK2GLqsLoja4+xgamUtl7qUwGp2UXBtNbovHeDYr+xzyTHrfRi0Q4uy47D2q5URo
 X50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685780; x=1739290580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cN5v5WX4Jvg+QKU02xZK5mgsO2zG9IePeE/6vqvKS7M=;
 b=P0wzzJBmGePZ/qryuqE9Wu5BVR9tpkZtEFR046DBChIHFZ8D6k11YMDHKyMPSPJb11
 Dn1HT534FiZzW9a6geAq0a/dU+Pacld0Y7RRkP8QGpo1Z22rEWFwxHQaFs+lxoF49utn
 dhs6Z+YayAVo/BGMdvGKcNTsS97VcVdRP/KD2rigj+Yv1uR0wnmQaPDL/+cvwAIdS64D
 Qlc54c55UP+5Bu9vPAfvyt0/bMulOnf+2InrKh+AvE0Fd/hs9rTshDtEb7E4Shc4DrG4
 C3sefIRCMhJlKdNrSiMpjfBO2rA31lVELRWEkArep3uOYTFSyiShwkF/uCzOtWv1WHZz
 FfKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX64k+dy81ecHQZuhtcg3svdEXK1TZCFB2/VefoHPRJ0SL/PfmiAAB3hu+umYE9zAS1Vh5/+VzKB9XZ@nongnu.org
X-Gm-Message-State: AOJu0YwJ5BxFF5NbA5i19Wwr99Ln7rTULtH1h88kkRWwaGpVwtLBWJnG
 +9X+7jSfseNcwabxzB0C0SK/H7o02acJqzwhVOdE9gqY8e7TRFZO/hSOOmncwDwu9QijEDBY3wd
 G1V8FSXimeL/AgI0exdZhTmDkRrXFt2s8JqZNrg==
X-Gm-Gg: ASbGncvL2WeKUMzq+CR0BfP79WDC8ST9vKqLoEkRBiHR4rbr5TU85dIoGBL3yc74eep
 65BAALQ5Y/OfJUnF2z9p1XqOkApn6QNaFo1074dLi0qper/mtq9QMChC/hfizNg6xLQJx06pGIA
 ==
X-Google-Smtp-Source: AGHT+IHyRA3uq3x7aCAAYP7L/06eXDB/ObRucobfOuKwIajZTgOYNYvrExmr8+JC4D4M/mvrOn8lCCUnlc4r9W0j1II=
X-Received: by 2002:a05:6902:118d:b0:e30:ebdf:9643 with SMTP id
 3f1490d57ef6-e58a4a9a3ecmr20690911276.8.1738685780466; Tue, 04 Feb 2025
 08:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-2-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-2-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:16:08 +0000
X-Gm-Features: AWEUYZluLquo9Dd8GO82kC-rfniy6KI9xmm5PPwFTxxCAO4yfjSDlj6XtvJirJo
Message-ID: <CAFEAcA_LO0N2vkyx30gLKY9EyVzsA7xZ+Z2oJrvgJ8_XHVw_eQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] docs/system/arm: Add Description for NPCM8XX SoC
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
> Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.

This should go at the end of the series, once you've added
the new machine types it documents.

> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  docs/system/arm/nuvoton.rst | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
> index 05059378e5..0a1916fb99 100644
> --- a/docs/system/arm/nuvoton.rst
> +++ b/docs/system/arm/nuvoton.rst
> @@ -1,12 +1,13 @@
>  Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
>  =====================================================================================================

You should add the names of the new boards in the title.

> -The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
> +The `Nuvoton iBMC`_ chips are a family of ARM-based SoCs that are
>  designed to be used as Baseboard Management Controllers (BMCs) in various
> -servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
> -assortment of peripherals targeted for either Enterprise or Data Center /
> -Hyperscale applications. The former is a superset of the latter, so NPCM750 has
> -all the peripherals of NPCM730 and more.
> +servers. Currently there are two families: NPCM7XX series and
> +NPCM8XX series. NPCM7XX series feature one or two ARM Cortex-A9 CPU cores,
> +while NPCM8XX feature 4 ARM Cortex-A35 CPU cores. Both series contain a
> +different assortment of peripherals targeted for either Enterprise or Data
> +Center / Hyperscale applications.

The correct capitalization for "Arm" is "Arm".

>
>  .. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
>
> @@ -27,6 +28,8 @@ There are also two more SoCs, NPCM710 and NPCM705, which are single-core
>  variants of NPCM750 and NPCM730, respectively. These are currently not
>  supported by QEMU.
>
> +The NPCM8xx SoC is the successor of the NPCM7xx SoC.

There should be a bullet-point list below here which
lists the new machine types.

> +
>  Supported devices
>  -----------------
>
> @@ -62,6 +65,8 @@ Missing devices
>     * System Wake-up Control (SWC)
>     * Shared memory (SHM)
>     * eSPI slave interface
> +   * Block-tranfer interface (8XX only)

Typo: "transfer"

> +   * Virtual UART (8XX only)
>
>   * Ethernet controller (GMAC)
>   * USB device (USBD)
> @@ -76,6 +81,11 @@ Missing devices
>   * Video capture
>   * Encoding compression engine
>   * Security features
> + * I3C buses (8XX only)
> + * Temperator sensor interface (8XX only)

Typo: "Temperature"

> + * Virtual UART (8XX only)
> + * Flash monitor (8XX only)
> + * JTAG master (8XX only)

thanks
-- PMM

