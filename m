Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E978FC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmgd-0003hv-8e; Tue, 28 Jan 2025 09:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmga-0003hG-QO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:35:28 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmgZ-0004of-5F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:35:28 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so9569317276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074926; x=1738679726; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDbZzhgXIddCbAed15y8FhY2UG9TovmqYlE6jiN2G/s=;
 b=K0MVsoY6UPte6b2nB8DkiJlkpDH84/tcoDZYBLAjTC14Mjt5HUIOCBBDXg0osWfXNt
 mh0OOG4ncGNBL6trM2WSRdqImCenxA+uVYRIpvF0Aa7ZwsCJ+71zm/GR4fUoCj/d0si9
 xJqqdXJYr4PM8v+QA5iCUmRGdfGxMWzoxnOZCOPbtKMzYTmJ3hI/qd2bjEw9jtzpqwyu
 8eztJ9eHcayc11aKsU+jp8Sh+pv5YgB9PSwTxuFqMyR6Jbk/XgyvEUXNDcomj0cOLtPc
 KEOMAg2ZQyEYH9ad4Og89g4r2LuKWVhT8x6QIrqdToV34Jcej/jozRVfsckH6Luh6QKK
 Tv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074926; x=1738679726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDbZzhgXIddCbAed15y8FhY2UG9TovmqYlE6jiN2G/s=;
 b=fT7YBnqkkFjoR1vnTbiq1te7KdD8DSkJ0hggaASjasDFkePNi/pkz8usk8Lw5IY74r
 7f6xFc68a7n+ZhtPN+YwbYOYXrsoedJnjQFgKHzU6KytucTanN+AbH058862P1Ohdsn2
 bNWdUxYz3ETy5iG5lnwRdo9E08pV+VAzOZrlDnKuNcT6SoRtOaWBdI+1M7V0Nu8LnLnd
 3y1l8hrjxx2ArSYt3uOqQl4/i2Ny/J1n+VfxzgaqoISfpXd3gfnaz82GWllKOURCr3iq
 wcWUBHKgSBWvS5wRCZPfGqcwXpv3/By4+pwwgZWQf6vaNZrz0z/cAdXkwSWl+hb/7LRN
 GLqw==
X-Gm-Message-State: AOJu0YzZCL9yEFOZScUL7gDt27Y2xjnOMO2CxBy+RzTmgs5s4lXowHsi
 kD1A0snZRKjncK2It/WTVkv1drTE4xXxQ9PJZgWCvandTswrrx/WIqzwjLpRGtY4G0b4r/SLpsC
 79UxAkRJ36yDJpCrMreGMhTIiYsbL815QxOyWAQ==
X-Gm-Gg: ASbGncsZemE0XkbVHYfj0/YWC76mcYWUDmeOdLaI0YBHs6OU9q+ghZ83uiO+3pfKN2j
 BvZfxk26x5OszxOPF84jTMbT+XDNKa+yYRZ87w6Wwmjv+TRn9AWLJCTDBp5hyK8GY6VaVeMHluA
 ==
X-Google-Smtp-Source: AGHT+IF2hePQPy7+LLnOlAI+oLOSUwjTWiLhuKkywDxDVxooe/o3UfOwVQYboDtgJduMe5Q47oEuGAkKo+WKym/010M=
X-Received: by 2002:a05:6902:2683:b0:e4d:25c6:c3b2 with SMTP id
 3f1490d57ef6-e57b103cb9cmr33760637276.7.1738074925814; Tue, 28 Jan 2025
 06:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-7-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-7-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:35:14 +0000
X-Gm-Features: AWEUYZmvaKfiikR68ibuXrx2iaQ62ZYQ-2HsxLCFCdtX9sVh8QxAIi0uPUrUEW8
Message-ID: <CAFEAcA8Ox+CjVVgPWciFOPv748tvCSOHpcQn_ihwCXAvSNnk8Q@mail.gmail.com>
Subject: Re: [PATCH 06/21] hw/arm/fsl-imx8mp: Implement clock tree
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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
> Fixes quite a few stack traces during the Linux boot process. Also provides the
> clocks for devices added later, e.g. enet1.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS                    |   2 +
>  docs/system/arm/imx8mp-evk.rst |   1 +
>  include/hw/arm/fsl-imx8mp.h    |   3 +
>  include/hw/misc/imx8mp_ccm.h   |  97 ++++++++++
>  hw/arm/fsl-imx8mp.c            |  20 +++
>  hw/misc/imx8mp_ccm.c           | 315 +++++++++++++++++++++++++++++++++
>  hw/misc/meson.build            |   1 +
>  7 files changed, 439 insertions(+)
>  create mode 100644 include/hw/misc/imx8mp_ccm.h
>  create mode 100644 hw/misc/imx8mp_ccm.c
> diff --git a/include/hw/misc/imx8mp_ccm.h b/include/hw/misc/imx8mp_ccm.h
> new file mode 100644
> index 0000000000..2378c157de
> --- /dev/null
> +++ b/include/hw/misc/imx8mp_ccm.h
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
> + *
> + * i.MX8MP CCM, ANALOG IP blocks emulation code
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef IMX8MP_CCM_H
> +#define IMX8MP_CCM_H
> +
> +#include "hw/misc/imx_ccm.h"
> +#include "qom/object.h"
> +
> +enum IMX8MPAnalogRegisters {
> +    ANALOG_AUDIO_PLL1_GEN_CTRL = 0x000 / 4,
> +    ANALOG_AUDIO_PLL1_FDIV_CTL0 = 0x004 / 4,
> +    ANALOG_AUDIO_PLL1_FDIV_CTL1 = 0x008 / 4,
> +    ANALOG_AUDIO_PLL1_SSCG_CTRL = 0x00c / 4,
> +    ANALOG_AUDIO_PLL1_MNIT_CTRL = 0x010 / 4,
> +    ANALOG_AUDIO_PLL2_GEN_CTRL = 0x014 / 4,
> +    ANALOG_AUDIO_PLL2_FDIV_CTL0 = 0x018 / 4,
> +    ANALOG_AUDIO_PLL2_FDIV_CTL1 = 0x01c / 4,
> +    ANALOG_AUDIO_PLL2_SSCG_CTRL = 0x020 / 4,
> +    ANALOG_AUDIO_PLL2_MNIT_CTRL = 0x024 / 4,
> +    ANALOG_VIDEO_PLL1_GEN_CTRL = 0x028 / 4,
> +    ANALOG_VIDEO_PLL1_FDIV_CTL0 = 0x02c / 4,
> +    ANALOG_VIDEO_PLL1_FDIV_CTL1 = 0x030 / 4,
> +    ANALOG_VIDEO_PLL1_SSCG_CTRL = 0x034 / 4,
> +    ANALOG_VIDEO_PLL1_MNIT_CTRL = 0x038 / 4,
> +    ANALOG_DRAM_PLL_GEN_CTRL = 0x050 / 4,
> +    ANALOG_DRAM_PLL_FDIV_CTL0 = 0x054 / 4,
> +    ANALOG_DRAM_PLL_FDIV_CTL1 = 0x058 / 4,
> +    ANALOG_DRAM_PLL_SSCG_CTRL = 0x05c / 4,
> +    ANALOG_DRAM_PLL_MNIT_CTRL = 0x060 / 4,
> +    ANALOG_GPU_PLL_GEN_CTRL = 0x064 / 4,
> +    ANALOG_GPU_PLL_FDIV_CTL0 = 0x068 / 4,
> +    ANALOG_GPU_PLL_LOCKD_CTRL = 0x06c / 4,
> +    ANALOG_GPU_PLL_MNIT_CTRL = 0x070 / 4,
> +    ANALOG_VPU_PLL_GEN_CTRL = 0x074 / 4,
> +    ANALOG_VPU_PLL_FDIV_CTL0 = 0x078 / 4,
> +    ANALOG_VPU_PLL_LOCKD_CTRL = 0x07c / 4,
> +    ANALOG_VPU_PLL_MNIT_CTRL = 0x080 / 4,
> +    ANALOG_ARM_PLL_GEN_CTRL = 0x084 / 4,
> +    ANALOG_ARM_PLL_FDIV_CTL0 = 0x088 / 4,
> +    ANALOG_ARM_PLL_LOCKD_CTRL = 0x08c / 4,
> +    ANALOG_ARM_PLL_MNIT_CTRL = 0x090 / 4,
> +    ANALOG_SYS_PLL1_GEN_CTRL = 0x094 / 4,
> +    ANALOG_SYS_PLL1_FDIV_CTL0 = 0x098 / 4,
> +    ANALOG_SYS_PLL1_LOCKD_CTRL = 0x09c / 4,
> +    ANALOG_SYS_PLL1_MNIT_CTRL = 0x100 / 4,
> +    ANALOG_SYS_PLL2_GEN_CTRL = 0x104 / 4,
> +    ANALOG_SYS_PLL2_FDIV_CTL0 = 0x108 / 4,
> +    ANALOG_SYS_PLL2_LOCKD_CTRL = 0x10c / 4,
> +    ANALOG_SYS_PLL2_MNIT_CTRL = 0x110 / 4,
> +    ANALOG_SYS_PLL3_GEN_CTRL = 0x114 / 4,
> +    ANALOG_SYS_PLL3_FDIV_CTL0 = 0x118 / 4,
> +    ANALOG_SYS_PLL3_LOCKD_CTRL = 0x11c / 4,
> +    ANALOG_SYS_PLL3_MNIT_CTRL = 0x120 / 4,
> +    ANALOG_OSC_MISC_CFG = 0x124 / 4,
> +    ANALOG_ANAMIX_PLL_MNIT_CTL = 0x128 / 4,
> +
> +    ANALOG_DIGPROG = 0x800 / 4,
> +    ANALOG_MAX,
> +};
> +
> +enum IMX8MPCCMRegisters {
> +    CCM_MAX = 0xc6fc / sizeof(uint32_t) + 1,
> +};
> +
> +#define TYPE_IMX8MP_CCM "imx8mp.ccm"
> +OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPCCMState, IMX8MP_CCM)
> +
> +struct IMX8MPCCMState {
> +    IMXCCMState parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t ccm[CCM_MAX];
> +};
> +
> +
> +#define TYPE_IMX8MP_ANALOG "imx8mp.analog"
> +OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPAnalogState, IMX8MP_ANALOG)
> +
> +struct IMX8MPAnalogState {
> +    IMXCCMState parent_obj;
> +
> +    struct {
> +        MemoryRegion container;
> +        MemoryRegion analog;
> +    } mmio;
> +
> +    uint32_t analog[ANALOG_MAX];
> +};
> +
> +#endif /* IMX8MP_CCM_H */

This seems to be implementing two separate devices in a single
source file. Generally we prefer one device per file. Is
there a reason they can't be split?

thanks
-- PMM

