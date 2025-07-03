Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52592C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMb0-0002rw-9z; Thu, 03 Jul 2025 12:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMay-0002r4-VP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:15:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMat-0001rf-Ve
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:15:32 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70f147b5a52so46556437b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559326; x=1752164126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Poj0fGA3brK8qz/97lbZAKU719l5CrCEvP5wqOMoU0I=;
 b=bKAy5A4Oz95tfe+f1EcuWv1IzbBWsVtN8oSEpp1UmmN/ppqYtvIdmcZWGr0+ADhDfK
 3AAYNG87w0AiqhM/KzvkLIKHwkWadgzz2v3rQ3FNqrAygriStkIB4beqSqd1iRPCUwPn
 i/D1/H1h3CJ61XrqFFve8XJCFMmIjJzZvTUJQBdRf1ElfOTnHwMh0ThITh48YjR1g6kv
 yOpQXJTtx+eMlA3RKdZa2s4xZcfOmW7ZUqRxz4X0waguMr4Fm/BnzU2wd7glTgs+tUtD
 eQTupQJLaSnrmtIBoVR+uvGr8tOttMrYeipaTTftLIJSWU/5/NaSjepmdoz9fjJXwhwY
 CDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559326; x=1752164126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Poj0fGA3brK8qz/97lbZAKU719l5CrCEvP5wqOMoU0I=;
 b=ZV5p4ncJvx88Q23TXIXrx+JG0m1erpchDcRhrVGhkq+mnAugdqVfQuoFdaAtl2G2/f
 s+wf5ADdx1b5PHkt7BBxFQOYKmxyOHE28dDC2ojEK1psbBm8heUc0ICkuqHLExBsJRIL
 G2l7ll1VrwSLGvvtp00+Il+JjBtBqqsB+oyZUN2YS12QRi3fn/Zdg1QMFCVLNJkL3HRs
 WxNkfga17bRdblLd3FryTvwIn5w+o4TbyMhm5BFEzcCYh6nftXNEvTzedE2Xbmp5AASy
 6ptONFa9Xph5aRf5kd5FaL+2VwwYP2D40KZ2/8bIMRR8rIHdbtamrPfyoMIz65Zv4j7F
 aC+Q==
X-Gm-Message-State: AOJu0YxQhNqcabGqwOiwNPCvJoUD6DfrulOmfkK6uiWi2GeeFehAQA77
 JzFJzeQTFInR7Uv0tlPOnKWt17/S0kwRQnuGGufHM/7HMPsAbwfz748iTSvuvD3XgSue0WWizL6
 HPnb7/AxqTSvhlCiB9FP6c82mlw1QYO7i/a34RBLlqQ==
X-Gm-Gg: ASbGncvgAjrPTDywZeSB6eQYiuuHQxeJcAQpM/5E2RBIB5cJoDgT06uF1fYdRV6Fa9Q
 91HoF0KSlKbE96w9LooGCAb6GLS5WqJYFeZcV0qedD8UD+iGnHDL51Zkq2vjatdwhN5MScPvwS3
 3QnjdNIBCJWP2Xo1hcv41OQ3TQ1PwfFrjmM2Oavqc6kUkv
X-Google-Smtp-Source: AGHT+IFFW5IM/RT9vRjsWXY8eDnF88VSs5tgc2DQiek7a8GuwLIuBTrZPub4a3suPFL9BuEomKZIgWl4HG1WcGvR9nc=
X-Received: by 2002:a05:690c:fcf:b0:710:e7ad:9d49 with SMTP id
 00721157ae682-71658ff8fdcmr69631557b3.13.1751559325717; Thu, 03 Jul 2025
 09:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-6-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-6-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:15:14 +0100
X-Gm-Features: Ac12FXzcb2oF7iL4eMfkCz6a00dHxZzENzASVkRxjOxWDfljUTrew96r0eh0Vc8
Message-ID: <CAFEAcA-8tNHmZSzZx5VqSMVm+uUU7AE_ioM5Tom2RtGeNMCwBQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] MAX78000: Add UART to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds UART to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
>  include/hw/arm/max78000_soc.h |  3 +++
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 8d8d2dce61..7217924191 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -18,6 +18,10 @@
>  #include "hw/misc/unimp.h"
>
>  static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
> +static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
> +                                              0x40044000};
> +
> +static const int max78000_uart_irq[] = {14, 15, 34};
>
>  static void max78000_soc_initfn(Object *obj)
>  {
> @@ -30,6 +34,11 @@ static void max78000_soc_initfn(Object *obj)
>          object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
>      }
>
> +    for (i = 0; i < MAX78000_NUM_UART; i++) {
> +        object_initialize_child(obj, "uart[*]", &s->uart[i],
> +                                TYPE_MAX78000_UART);


As with the earlier patch, give each object a unique name.

> +    }
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }
>
> @@ -38,6 +47,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      MAX78000State *s = MAX78000_SOC(dev_soc);
>      MemoryRegion *system_memory = get_system_memory();
>      DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
>      Error *err = NULL;
>      int i;
>
> @@ -88,6 +98,20 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
>      }
>
> +    for (i = 0; i < MAX78000_NUM_UART; i++) {
> +        dev = DEVICE(&(s->uart[i]));
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +        dev->id = g_strdup_printf("uart%d", i);

This looks odd -- the SoC code shouldn't need to reach in and
set anything directly in the DeviceState struct.

> +
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
> +        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
> +                                                       max78000_uart_irq[i]));
> +    }
> +
>      create_unimplemented_device("globalControl",        0x40000000, 0x400);
>      create_unimplemented_device("systemInterface",      0x40000400, 0x400);
>      create_unimplemented_device("functionControl",      0x40000800, 0x400);

thanks
-- PMM

