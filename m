Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC2DC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6JH-0000tU-M4; Fri, 13 Jun 2025 11:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6JG-0000tG-6N
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:27:14 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6JD-0004Zt-Nt
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:27:13 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-710fe491842so15733537b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749828430; x=1750433230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8L42yl4yqoFqTsJVse2TNFcKacgfztiIpHl6869N/X4=;
 b=xvKYBKo5phAejwZyDKxDBFAeYqwlj3KNjLfNFuHSEdyFtZiZSKd3ihJ8l8Yvnq+89z
 8p0/5a5WKr6/ek40cnSJVdj64TyLk5qix1WdtbEfgcSOjvTD9TouQ59MPgZNE5fxp/ky
 G1hGXdLYMOs0QN5IwSSI7wX603pEOHgnNzw6TlwfTaFr91ZiuFFsXumNo+1+ZfGBoYJQ
 PF3ZbUPPcJY9w2gJ4Q881AsYI87BhHLf0RAWN9DZgYoninkuSzLOcucK+Lo+td7qm51V
 IkoqE8oHbHzt83GuHiGXH3Mb3vnDKyM3/PB/k8PYLLzc/SzK+YP6i6w1Kvm5X2MwZqix
 4Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749828430; x=1750433230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8L42yl4yqoFqTsJVse2TNFcKacgfztiIpHl6869N/X4=;
 b=jutv7WI5dWrgucCs7yfdUPEx0q2Kkgbd/xSCGtySlHrJgYEV5KSBpqv9B8/KT/36R1
 Y9F09q0j9R0KJiAMTgdzzsCNYv7Yr7Q+uK5HAylHXINsAEvOy/T49qfQyGNsmn0Sj8aS
 M+yOSF5zFBZV3xvSHsX/rhkDihnU7WP9C/a+zBnW74Nrdn8TONBBqmxc1vDiHyRsaVlx
 6emfAKg+zl2O/tvJL+BQS50Wyptf6n9cDW9jsQt4Xt64XlxYPoP5eXWtEiVSSDo3mOLa
 nnjdjo6p4ol5Bq+5OOmx9MsnX02amMeFawCN1wPk0DUk0FynRMYMor8R3hjtuz1NR1fe
 ldwQ==
X-Gm-Message-State: AOJu0YzTtyu/QcqhwCHbaAZNaHEyBoXXPLBKyNvoMM3kaJ+L/HNnhrs4
 3Lu2bMWdxoyA9cGYKm4AQ1Ma+JU64s80Tlv4VElYEAmVRiNB/PlCwC9HYhOLW9zh/6b5kCxzurl
 k9B5s8t2tEoDboE01M0mmFfj2izLxYJ/elXK2jkc1hQ==
X-Gm-Gg: ASbGncumMo+at4yHqiL2xPmcTTPnHfn7qgV+pEWqO6xrIinjkgofLXB2W8UCR8AXjZF
 tTlgYKZj9DeI4/68vk/koagCw1OwcB24gM/0UGTzWkYcPgoNzq6Tec+xfVvtP0N4fHvUhnLUkby
 qgvxcQrHM3LTQfzDjKkhhKV8Mo9OK0VylFaypK1yI+ZVLJ
X-Google-Smtp-Source: AGHT+IEFN185//AQlgKIkrPjRc6/vb23WA5hsMkE4O7bjOMR3gwqI3ECt31vPRgNikR4bHe5UyqnapIP63bzZVbZ/F0=
X-Received: by 2002:a05:690c:700e:b0:703:b5ae:a3da with SMTP id
 00721157ae682-7116382e416mr53431327b3.32.1749828430445; Fri, 13 Jun 2025
 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250510042043.2056265-1-jcksn@duck.com>
 <6804E8E6-60B9-40EB-B745-A581491C5DA9.1@smtp-inbound1.duck.com>
In-Reply-To: <6804E8E6-60B9-40EB-B745-A581491C5DA9.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 16:26:59 +0100
X-Gm-Features: AX0GCFsp2uoRdVFqzBlblcqVozNfjuEczHeMSPBf6LEyZfkBP-rA379fRg6HhGE
Message-ID: <CAFEAcA-3VcaRVsihWrqzCDGmhstJ7Ecs-zJVyMnOK=W-3KUWyg@mail.gmail.com>
Subject: Re: [PATCH 2/6] MAX78000: ICC Implementation
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org, alistair@alistair.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sat, 10 May 2025 at 07:58, <jcksn@duck.com> wrote:
>
> This patch implements the Instruction Cache Controller for the MAX78000 SOC
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                 |  1 +
>  hw/arm/max78000_soc.c          | 20 ++++++--
>  hw/misc/Kconfig                |  3 ++
>  hw/misc/max78000_icc.c         | 89 ++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build            |  1 +
>  include/hw/arm/max78000_soc.h  |  6 +++
>  include/hw/misc/max78000_icc.h | 34 +++++++++++++
>  7 files changed, 150 insertions(+), 4 deletions(-)
>  create mode 100644 hw/misc/max78000_icc.c
>  create mode 100644 include/hw/misc/max78000_icc.h

We generally prefer to split into two patches,
one for "just add the new device" and then a separate
one for "instantiate the new device in the SoC".
(This device is quite small, but for larger ones it
helps to keep the patchsize down.)

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1c365d1115..3f23af3244 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -367,6 +367,7 @@ config ALLWINNER_R40
>  config MAX78000_SOC
>      bool
>      select ARM_V7M
> +    select MAX78000_ICC
>
>  config RASPI
>      bool
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 64578438bd..4d598bddd4 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -16,12 +16,19 @@
>  #include "hw/qdev-clock.h"
>  #include "hw/misc/unimp.h"
>
> +static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
> +
>  static void max78000_soc_initfn(Object *obj)
>  {
>      MAX78000State *s = MAX78000_SOC(obj);
> +    int i;
>
>      object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
>
> +    for (i = 0; i < MAX78000_NUM_ICC; i++) {
> +        object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
> +    }
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>      s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
>  }
> @@ -30,8 +37,9 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>  {
>      MAX78000State *s = MAX78000_SOC(dev_soc);
>      MemoryRegion *system_memory = get_system_memory();
> -    DeviceState *armv7m;
> +    DeviceState *dev, *armv7m;
>      Error *err = NULL;
> +    int i;
>
>      /*
>       * We use s->refclk internally and only define it with qdev_init_clock_in()
> @@ -87,6 +95,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>
> +    for (i = 0; i < MAX78000_NUM_ICC; i++) {
> +        dev = DEVICE(&(s->icc[i]));
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);

You want just sysbus_realize() here. There are two patterns:
 - when creating a device via qdev_new() or something similar,
   realize it with a *_realize_and_unref() function
 - when initializing an object in place with object_initialize_child(),
   realize it with a *_realize() function

(This is because object_initialize_child() has already arranged
for the only reference to the child device to be held by the
parent via the child<> property, so we don't want to deref it
again.)

> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
> +    }
> +
> +
>      create_unimplemented_device("globalControl",    0x40000000, 0x400);
>      create_unimplemented_device("systemInterface",  0x40000400, 0x400);
>      create_unimplemented_device("functionControl",  0x40000800, 0x3400);
> @@ -120,9 +135,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      create_unimplemented_device("standardDMA",      0x40028000, 0x1000);
>      create_unimplemented_device("flashController0", 0x40029000, 0x400);
>
> -    create_unimplemented_device("icc0",             0x4002a000, 0x800);
> -    create_unimplemented_device("icc1",             0x4002a800, 0x800);
> -
>      create_unimplemented_device("adc",              0x40034000, 0x1000);
>      create_unimplemented_device("pulseTrainEngine", 0x4003c000, 0xa0);
>      create_unimplemented_device("oneWireMaster",    0x4003d000, 0x1000);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index ec0fa5aa9f..781bcf74cc 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -47,6 +47,9 @@ config A9SCU
>  config ARM11SCU
>      bool
>
> +config MAX78000_ICC
> +    bool
> +
>  config MOS6522
>      bool
>
> diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
> new file mode 100644
> index 0000000000..3eacf6bd1b
> --- /dev/null
> +++ b/hw/misc/max78000_icc.c
> @@ -0,0 +1,89 @@
> +/*
> + * MAX78000 Instruction Cache
> + *
> + * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/max78000_icc.h"
> +
> +
> +static uint64_t max78000_icc_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Max78000IccState *s = opaque;
> +    switch (addr) {
> +        case ICC_INFO:{
> +            return s->info;
> +        }

Your switch case indentation seems a bit odd. Our usual
style puts the "case" at the same indent level as "switch".

Also, you don't need braces on cases unless they are
required to define the scope of a local variable.
So none of these need them.

> +        case ICC_SZ:{
> +            return s->sz;
> +        }
> +        case ICC_CTRL:{
> +            return s->ctrl;
> +        }
> +        case ICC_INVALIDATE:{
> +            return s->invalidate;
> +        }

ICCn_INVALIDATE is write-only; it doesn't need a state
field in the device state struct. It doesn't need a
case in the read function, we can let that drop into
the default case.

> +        default:{
> +            return 0;

For "there is no register at this offset", use:

    default:
        qemu_log_mask(LOG_GUEST_ERROR,
                      "%s: bad offset 0x%" HWADDR_PRIx "\n",
                      __func__, addr);
        return 0;

(Similarly for write.)

> +        }
> +    }
> +}
> +
> +static void max78000_icc_write(void *opaque, hwaddr addr,
> +                    uint64_t val64, unsigned int size)
> +{
> +    Max78000IccState *s = opaque;
> +
> +    switch (addr) {
> +        case ICC_CTRL:{
> +        s->ctrl = 0x10000 + (val64 & 1);

I prefer "|" over "+" for this kind of thing, as we are
assembling bit fields, not doing arithmetic.

> +        break;
> +        }
> +        case ICC_INVALIDATE:{
> +        s->ctrl = s->ctrl | 0x80;

What is this doing? The datasheet says bit 7 in ICCn_CTRL
is reserved.

> +        }

A default case logging the guest error would be good.

> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_exti_ops = {
> +    .read = max78000_icc_read,
> +    .write = max78000_icc_write,

I think we should also specify
       .valid.min_access_size = 4,
       .valid.max_access_size = 4,

which will mean the guest gets an exception if it tries
to do a byte read to these 32-bit registers.  Otherwise
we would have to put in extra complexity to handle the
byte and halfword access cases. (QEMU can try to
synthesize these for you but its default is not
necessarily what you need for all devices.)

> +    .endianness = DEVICE_NATIVE_ENDIAN,

We're trying to reduce the use of DEVICE_NATIVE_ENDIAN,
so use DEVICE_LITTLE_ENDIAN here, please. (For an Arm
machine type, the two are the same thing.)

> +};
> +
> +static void max78000_icc_init(Object *obj)
> +{
> +    Max78000IccState *s = MAX78000_ICC(obj);
> +    s->info = 0;
> +    s->sz = 0x10000010;
> +    s->ctrl = 0x10000;
> +    s->invalidate = 0;

These look like reset values. Reset of registers needs to
be done in a reset method, not in init.

> +
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
> +                        TYPE_MAX78000_ICC, 0x800);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +}

You also need to support migration, which means having
a VMStateDescription that defines what the guest-visible
state of your device is, and setting dc->vmsd to point to it
in your device's class init. For more info see
https://www.qemu.org/docs/master/devel/migration/main.html
and look at other devices in the source tree for examples.

thanks
-- PMM

