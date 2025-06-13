Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBBC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ5uC-0001Qx-Gu; Fri, 13 Jun 2025 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ5uA-0001QW-Gg
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:01:18 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ5u8-0000Li-1S
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:01:18 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7115e32802bso10701977b3.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749826874; x=1750431674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SCp9bRUq6HErDfdRql2xhMRzUsM0i/NuDhdVGDHpGag=;
 b=rkBInI2+VjUuTCwu8iwhDkLkkliLesuVZwap24jWqeZsztYlGBmf2i1ohDnkwy4hj6
 1DebjPwOWPWtXUzmlailrwWs+6ePg5vSstDoVVvvk8boe03YKAPBc5MBVm7z1pIbTWlb
 IYC1SMQNhvAPev7jFNITgnpAJ836qxdZFGpNJs966EU5R8xYCy2FdMFMri1Jvze8ZRQF
 e5+6nDfKNYxV7d4HStNwNDxwA3FUEgA5FIUffOx9KVm1W3GiSShVrgU7NVsGvVrfCyiW
 9g1pFmQgKrMjLYy5Ove7Tn/sXjdhOQiRBebAOBXKFTAeCLxO7thZXXAVLu/th4vmypnW
 EDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749826874; x=1750431674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SCp9bRUq6HErDfdRql2xhMRzUsM0i/NuDhdVGDHpGag=;
 b=Rg2OOmaHNfA08m2V20pyv04PsF1Jb8HcQKILyAVzeovdC2qed3BmLZPqK20ax1Dt7x
 b6DsX1B105NwgacA97vBIxo04Rmm3Rm5nRVoozJORRjG6RmnwetePgUeuBgCiGGO/xHR
 6DI+02V2YHQ3uAAAN+vOfZ0l4yNyS6pQ9TmcHVBiTVbhmt34GJXeKShiK9n/r97GOcuF
 vNwtLvZTzykT+7r+phZhoRIT7MDUB5QpwIVhtETjIViFQydbMJUX5g2PqGpOdn2xKScR
 7iLM07tNB+jWc6dCli4Rv+yWaEwcYqZTluQD+rGwq1bGqKPUJ9eRTafpIqJaoGmAAyKq
 etfA==
X-Gm-Message-State: AOJu0YxLoB3J+aAI++yVJ1wqCLWxzLJjwPB/DQXA1uUWnN+LiieKe05a
 yFvvInXfmr+yw9nS2AuNmSumu/dTJBgpXFel4lvgNZL182Cl+TAKv9pDAc0iYcXAdTLNXsqiN28
 2UHtuVSUqWCHbnWlhWA5tM8KAvn3Q2fX9e3mwMcMXVw==
X-Gm-Gg: ASbGncvGYhPuaqtXkurcLknHZRZQulfVotsUqYS/F8fLW2n9TQc2tc/EZqFcKXdhcsV
 3MDkjU5GyajOo9Q6fibe8rmMZ+mW4AfaMpV4TmQoE5DnKOYrl9I7eKRIiLrSz9yU5I3YHnDsxuR
 70wrwEjqpKKqbOYQzZQ4nba96qraF8Uaw44BgQSFnHkPlU
X-Google-Smtp-Source: AGHT+IHThK8rQwEUGWRJ+Je69vN5AatLR8Og/jPM1sfrJy5ED+557OwTLTzi7N5bkhfMwKinQBBYi9RrCyET1Tsx6Wo=
X-Received: by 2002:a05:690c:6184:b0:70e:142d:9c56 with SMTP id
 00721157ae682-711637d033cmr54327897b3.26.1749826872843; Fri, 13 Jun 2025
 08:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250510042043.2056265-1-jcksn@duck.com>
 <8C3C084A-FAB6-42E4-BCC7-6BEC6B1D4C15.1@smtp-inbound1.duck.com>
In-Reply-To: <8C3C084A-FAB6-42E4-BCC7-6BEC6B1D4C15.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 16:01:01 +0100
X-Gm-Features: AX0GCFuc26u65B31uBDvFetjioY_qTPIOta6X2WYN_LW--xHz9cN8cxKLsv34so
Message-ID: <CAFEAcA96fap_EJiFtX6a_PFmWeP1OPZGABueAyE_=JQwFi-spA@mail.gmail.com>
Subject: Re: [PATCH 1/6] MAX78000: Add MAX78000FTHR Machine
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org, alistair@alistair.me
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

On Sat, 10 May 2025 at 07:57, <jcksn@duck.com> wrote:
>
> This patch adds support for the MAX78000FTHR machine.
>
> The MAX78000FTHR contains a MAX78000 and a RISC-V core. This patch
> implements only the MAX78000, which is Cortex-M4 based.
> Details can be found at:
> https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>

Hi; thanks for this patchset, and sorry it's taken me so
long to get to reviewing it. Mostly it looks in good
shape, but I have some review comments, which I'll give
below (and on some of the other patches).

A minor note on email patchseries formatting: something odd
seems to have happened with your cover letter. Patches in a
series are supposed to be followups to the cover letter, but
in this case each patch email has a header
 In-reply-to: 20250510042043.2056265-1-jcksn@duck.com
but that doesn't match the message-id of the cover letter mail
(which was
 16B81215-B460-4A49-910E-E5FB479837C8.1@smtp-inbound1.duck.com
).

It looks like something has rewritten the message-ID header
between when git generated it and it got to the mailing list.
I don't know if that's something you can fix at your end.
(Otherwise I guess you could work around it by sending the cover
letter first, finding out what message-ID it got given, and then
generating the patch emails with the --in-reply-to=<identifier>
option of git send-email so they come out as replies to the
cover letter. But that seems a bit of a faff :-/ )

> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> new file mode 100644
> index 0000000000..64578438bd
> --- /dev/null
> +++ b/hw/arm/max78000_soc.c
> @@ -0,0 +1,184 @@
> +/*
> + * MAX78000 SOC
> + *
> + * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Implementation based on stm32f205

This comment is a good place to add the URL of the user guide.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "system/address-spaces.h"
> +#include "system/system.h"
> +#include "hw/arm/max78000_soc.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +
> +static void max78000_soc_initfn(Object *obj)
> +{
> +    MAX78000State *s = MAX78000_SOC(obj);
> +
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
> +}
> +
> +static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    MAX78000State *s = MAX78000_SOC(dev_soc);
> +    MemoryRegion *system_memory = get_system_memory();
> +    DeviceState *armv7m;
> +    Error *err = NULL;
> +
> +    /*
> +     * We use s->refclk internally and only define it with qdev_init_clock_in()
> +     * so it is correctly parented and not leaked on an init/deinit; it is not
> +     * intended as an externally exposed clock.
> +     */
> +    if (clock_has_source(s->refclk)) {
> +        error_setg(errp, "refclk clock must not be wired up by the board code");
> +        return;
> +    }
> +
> +    if (!clock_has_source(s->sysclk)) {
> +        error_setg(errp, "sysclk clock must be wired up by the board code");
> +        return;
> +    }
> +
> +    /*
> +     * TODO: ideally we should model the SoC RCC and its ability to
> +     * change the sysclk frequency and define different sysclk sources.
> +     */

The MAX78000 doesn't have an RCC...

> +
> +    /* The refclk always runs at frequency HCLK / 8 */

Is this actually true for the MAX78000? I couldn't figure out
from the datasheet what it does for the systick refclk.

> +    clock_set_mul_div(s->refclk, 8, 1);
> +    clock_set_source(s->refclk, s->sysclk);
> +
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "MAX78000.flash",
> +                           FLASH_SIZE, &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
> +
> +    memory_region_init_ram(&s->sram, NULL, "MAX78000.sram", SRAM_SIZE,
> +                           &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
> +
> +    armv7m = DEVICE(&s->armv7m);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 134);

The datasheet seems a little confused here, because
it says there are 134 interrupts including the 15 system
exceptions, but the interrupt vector table it lists then
only goes from 0 to 119 despite including the system exceptions.
So if we believe table 5-1 then there are 104 external
interrupts (numbered from 16 to 119 in that table).

If we believe the "total number of entries including the
15 system exceptions in 134" text above the table, then
there are 120 external exceptions, numbered 16 to 135,
of which 120 to 135 don't appear in the table and would
presumably be unused.

The num-irq property is the number of external interrupts
(not including the CPU-internal ones). So 134 seems definitely
the wrong value, and the correct number is probably either
104 or 120.

If you have the real hardware and the enthusiasm then you
can check by writing to the NVIC_ISERn register bank until
you find the point where you can't write 1 bits and read
them back any more (i.e. until you find the RAZ/WI bits
corresponding to "interrupt number not implemented").
Otherwise, it's not a big deal if we don't actually
get this value correct, but it would in that case be worth
a comment noting that the datasheet is unclear and we've
made our best guess at the value.

> +    qdev_prop_set_uint8(armv7m, "num-prio-bits", 3);
> +    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> +    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(system_memory), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    create_unimplemented_device("globalControl",    0x40000000, 0x400);
> +    create_unimplemented_device("systemInterface",  0x40000400, 0x400);
> +    create_unimplemented_device("functionControl",  0x40000800, 0x3400);

Table 3-3 says the end address is 0x4000_0bff, so the size should be 0x400,
not 0x3400.

> +    create_unimplemented_device("watchdogTimer0",   0x40003000, 0x400);
> +    create_unimplemented_device("dynamicVoltScale", 0x40003c00, 0x800);

Size doesn't match listed end address in table 3-3 ?

> +    create_unimplemented_device("SIMO",             0x40004400, 0x400);
> +    create_unimplemented_device("trimSystemInit",   0x40005400, 0x400);
> +    create_unimplemented_device("generalCtrlFunc",  0x40005800, 0xc00);

Ditto

> +    create_unimplemented_device("wakeupTimer",      0x40006400, 0x400);
> +    create_unimplemented_device("powerSequencer",   0x40006800, 0x400);
> +    create_unimplemented_device("miscControl",      0x40006c00, 0x800);

Ditto. I stopped checking the sizes here but you should probably
look at the rest.

> +
> +    create_unimplemented_device("aes",              0x40007400, 0x400);
> +    create_unimplemented_device("aesKey",           0x40007800, 0x800);
> +
> +    create_unimplemented_device("gpio0",            0x40008000, 0x1000);
> +    create_unimplemented_device("gpio1",            0x40009000, 0x1000);
> +
> +    create_unimplemented_device("parallelCamInter", 0x4000e000, 0x1000);
> +    create_unimplemented_device("CRC",              0x4000f000, 0x1000);
> +
> +    create_unimplemented_device("timer0",           0x40010000, 0x1000);
> +    create_unimplemented_device("timer1",           0x40011000, 0x1000);
> +    create_unimplemented_device("timer2",           0x40012000, 0x1000);
> +    create_unimplemented_device("timer3",           0x40013000, 0x1000);
> +
> +    create_unimplemented_device("i2c0",             0x4001d000, 0x1000);
> +    create_unimplemented_device("i2c1",             0x4001e000, 0x1000);
> +    create_unimplemented_device("i2c2",             0x4001f000, 0x1000);
> +
> +    create_unimplemented_device("standardDMA",      0x40028000, 0x1000);
> +    create_unimplemented_device("flashController0", 0x40029000, 0x400);
> +
> +    create_unimplemented_device("icc0",             0x4002a000, 0x800);
> +    create_unimplemented_device("icc1",             0x4002a800, 0x800);
> +
> +    create_unimplemented_device("adc",              0x40034000, 0x1000);
> +    create_unimplemented_device("pulseTrainEngine", 0x4003c000, 0xa0);
> +    create_unimplemented_device("oneWireMaster",    0x4003d000, 0x1000);
> +    create_unimplemented_device("semaphore",        0x4003e000, 0x1000);
> +
> +    create_unimplemented_device("uart0",            0x40042000, 0x1000);
> +    create_unimplemented_device("uart1",            0x40043000, 0x1000);
> +    create_unimplemented_device("uart2",            0x40044000, 0x1000);
> +
> +    create_unimplemented_device("spi1",             0x40046000, 0x2000);
> +    create_unimplemented_device("trng",             0x4004d000, 0x1000);
> +    create_unimplemented_device("i2s",              0x40060000, 0x1000);
> +    create_unimplemented_device("lowPowerControl",  0x40080000, 0x400);
> +    create_unimplemented_device("gpio2",            0x40080400, 0x200);
> +    create_unimplemented_device("lowPowWatchdogTi", 0x40080800, 0x400);

You don't need to just cut off the name string like this, there's
no fixed length to it. "Ti" is rather non-obvious (and the point
of these strings is to show them to the user if the guest tries
to access the missing device). Either write Timer or else just say
"lowPowerWatchdog". Similarly with some of the other names.

> +
> +    create_unimplemented_device("lowPowerTimer5",   0x40081000, 0x400);
> +    create_unimplemented_device("lowPowerUART0",    0x40081400, 0x400);
> +    create_unimplemented_device("lowPowerCompar",   0x40088000, 0x400);
> +
> +    create_unimplemented_device("spi0",             0x400be000, 0x400);
> +
> +    /*
> +     * The MAX78000 user guide's base address map lists the CNN TX FIFO as
> +     * beginning at 0x400c0400 and ending at 0x400c0400. Given that CNN_FIFO
> +     * is listed as having data accessible up to offset 0x1000, the user
> +     * guide is likely incorrect.
> +     */
> +    create_unimplemented_device("cnnTxFIFO",        0x400c0400, 0x2000);
> +
> +    create_unimplemented_device("cnnGlobalControl", 0x50000000, 0x10000);
> +    create_unimplemented_device("cnnx16quad0",      0x50100000, 0x40000);
> +    create_unimplemented_device("cnnx16quad1",      0x50500000, 0x40000);
> +    create_unimplemented_device("cnnx16quad2",      0x50900000, 0x40000);
> +    create_unimplemented_device("cnnx16quad3",      0x50d00000, 0x40000);
> +
> +}

thanks
-- PMM

