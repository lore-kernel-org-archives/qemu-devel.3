Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FC6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB8v-0006hO-M7; Wed, 12 Feb 2025 06:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiB8r-0006g8-6B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiB8h-0001cz-OI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739360564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5cZ9t4FYWXwmoq53uv/VVUxI26N3+GUHywGfa3ipXzg=;
 b=Q+F8yjSs/2MQkEFOPDlDWaoyLAo0CMNvwsMxtLOgsXNXPtLDoDZ/VbmYiP2F5mjWxjZoBn
 EaV5Xtp7uziX0ZlE4uThoccQti3oNFDIpdfzqhgN1dsmYZ468tVyhpvjVO38YABGO0e/tO
 aGW9AOEwB5UBdcbYEu+O4Oo9tVzGk4Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ltArgU3jM-S1NEmGZ5YF0w-1; Wed, 12 Feb 2025 06:42:42 -0500
X-MC-Unique: ltArgU3jM-S1NEmGZ5YF0w-1
X-Mimecast-MFC-AGG-ID: ltArgU3jM-S1NEmGZ5YF0w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935e09897so29100515e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360561; x=1739965361;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cZ9t4FYWXwmoq53uv/VVUxI26N3+GUHywGfa3ipXzg=;
 b=Dxqcpbg0GFq/M3i3SkGx+8uu9MEAjKqVozD6HF3VxRs5wn6R0kwdqBoki3br2KdiUp
 6jxhhQf1ywhVtdylfB37zSf4yr0Dh7hzlTCd5whLlgByBbKwa0Mu4PpU9ManEMhGJffK
 OcSZYbyNX3w7PFc6sv4xuuxQCHsAHNWnlGo05IrODwZf+K4PYHtfWHFP5jfJ4DzIK0U9
 +v3Ny/ItGVzOICpIIblhTwcrQCgHPGypCchrdnE00iiaKttSxqGPfq1vIyBMXv++XXSO
 sQcCEChxi1Gma49GO7CyxuPJJFWHdiJZtcze0ZXZNjGI/72PvlU45PFO+IIOT7111rLD
 aMOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDRR/9FrTautmt3awbkSJB8UFWvsqjSMf2iR6VhReUdZlBK54ktZC3YAvgJpXlQaI//0er43A6Fhzm@nongnu.org
X-Gm-Message-State: AOJu0YxWn+IXqbZrhAHcANLN7GTWeNvPQdzd9g+7uXAIr+4lnbrmYXIx
 piaGh0x84uDgFNcwtwlywaVaAKKI3h/Q/0JtUYb+4HDcEhoy2PESnMSAfmSvoWSy9Zty+aTAkg1
 ZGugW7VY43x7N5tqIRZHjPrNlgM8hFrvknLxvvDqp8JASc6qvs5C1
X-Gm-Gg: ASbGncve9cwLBYbP6Qhp6ThdLBZo0er31+RvseyI84rvWj2QmwlSSr55R3taxcsvJRX
 KK+ZlH/EgUgEVVbS9MmNX0V/OMD7KerrK6Bd3xvsMp5Gt73LaFAV9XNTq84Rr2r8IC1Vppjh+ZP
 7oGIdNqRhmh87jsNeJOi+RvWRPijnv+sybB84b5vCdliNsbSXPvD8c/l2d6+B+b4mniOeIYo/pL
 fTroXaXtaDjzFieu7MmOpP3qyQ1bjH0kWaccBFacp7kYxiXVruAc1KVbIE2dexc/NVnBHojirdJ
 ST2hVfz2dpV5tKSG7ZfX02pQablgf67Vmw==
X-Received: by 2002:a05:600c:3b15:b0:439:4b9e:45fc with SMTP id
 5b1f17b1804b1-4395815f6cbmr29646385e9.4.1739360561060; 
 Wed, 12 Feb 2025 03:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY3fJsmlNEt7mixRqBNzb39guCbNw/oVc5BIH+LtJoGdqGG1388mcSe3Wgp/p4xOzMLaHUHg==
X-Received: by 2002:a05:600c:3b15:b0:439:4b9e:45fc with SMTP id
 5b1f17b1804b1-4395815f6cbmr29646145e9.4.1739360560614; 
 Wed, 12 Feb 2025 03:42:40 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394dc1bed2sm38047195e9.0.2025.02.12.03.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:42:40 -0800 (PST)
Message-ID: <125a3dac-8ef9-4748-a3ce-f8fb97d8cb59@redhat.com>
Date: Wed, 12 Feb 2025 12:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] hw/intc/xilinx_intc: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250212112413.37553-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/intc/xilinx_intc.c                    | 60 ++++++++++++++++++------
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  3 ++
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/riscv/microblaze-v-generic.c          |  1 +
>   5 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
> index 6930f83907a..523402b688c 100644
> --- a/hw/intc/xilinx_intc.c
> +++ b/hw/intc/xilinx_intc.c
> @@ -3,6 +3,9 @@
>    *
>    * Copyright (c) 2009 Edgar E. Iglesias.
>    *
> + * https://docs.amd.com/v/u/en-US/xps_intc
> + * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
> + *
>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>    * of this software and associated documentation files (the "Software"), to deal
>    * in the Software without restriction, including without limitation the rights
> @@ -23,10 +26,12 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qapi/error.h"
>   #include "hw/sysbus.h"
>   #include "qemu/module.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>   #include "qom/object.h"
>   
>   #define D(x)
> @@ -49,6 +54,7 @@ struct XpsIntc
>   {
>       SysBusDevice parent_obj;
>   
> +    EndianMode model_endianness;
>       MemoryRegion mmio;
>       qemu_irq parent_irq;
>   
> @@ -140,18 +146,29 @@ static void pic_write(void *opaque, hwaddr addr,
>       update_irq(p);
>   }
>   
> -static const MemoryRegionOps pic_ops = {
> -    .read = pic_read,
> -    .write = pic_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .impl = {
> -        .min_access_size = 4,
> -        .max_access_size = 4,
> +static const MemoryRegionOps pic_ops[2] = {
> +    [0 ... 1] = {

Hmm, ok, so here we have now an assumption that ENDIAN_MODE_BIG and 
ENDIAN_MODE_LITTLE match 0 and 1, which would not work anymore when using 0 
as unspecified... a little bit ugly ... so maybe instead of changing pic_ops 
into an array ....

> +        .read = pic_read,
> +        .write = pic_write,
> +        .endianness = DEVICE_BIG_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            /*
> +             * All XPS INTC registers are accessed through the PLB interface.
> +             * The base address for these registers is provided by the
> +             * configuration parameter, C_BASEADDR. Each register is 32 bits
> +             * although some bits may be unused and is accessed on a 4-byte
> +             * boundary offset from the base address.
> +             */
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
>       },
> -    .valid = {
> -        .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
> +    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
>   static void irq_handler(void *opaque, int irq, int level)
> @@ -174,13 +191,27 @@ static void xilinx_intc_init(Object *obj)
>   
>       qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
>       sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq);
> -
> -    memory_region_init_io(&p->mmio, obj, &pic_ops, p, "xlnx.xps-intc",
> -                          R_MAX * 4);
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
>   }
>   
> +static void xilinx_intc_realize(DeviceState *dev, Error **errp)
> +{
> +    XpsIntc *p = XILINX_INTC(dev);
> +
> +    if (p->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
> +        error_setg(errp, TYPE_XILINX_INTC " property 'endianness'"
> +                         " must be set to 'big' or 'little'");
> +        return;
> +    }

... would it be possible to patch in the right value for pic_ops.endianness
here instead?

  Thomas

> +    memory_region_init_io(&p->mmio, OBJECT(dev),
> +                          &pic_ops[p->model_endianness],
> +                          p, "xlnx.xps-intc",
> +                          R_MAX * 4);
> +}
> +
>   static const Property xilinx_intc_properties[] = {
> +    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XpsIntc, model_endianness),
>       DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
>   };
>   
> @@ -188,6 +219,7 @@ static void xilinx_intc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> +    dc->realize = xilinx_intc_realize;
>       device_class_set_props(dc, xilinx_intc_properties);
>   }
>   
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 8b44be75a22..55398cc67d1 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -111,6 +111,7 @@ petalogix_ml605_init(MachineState *machine)
>   
>   
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
>       qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 2c0d8c34cd2..15cabe11777 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
>       MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       MemoryRegion *sysmem = get_system_memory();
> +    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
> +                                              : ENDIAN_MODE_LITTLE;
>   
>       cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>       object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
> @@ -95,6 +97,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>                             64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
>   
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_enum(dev, "endianness", endianness);
>       qdev_prop_set_uint32(dev, "kind-of-intr",
>                            1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 23238119273..df8f9644829 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -217,6 +217,7 @@ static void virtex_init(MachineState *machine)
>   
>       cpu_irq = qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT);
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
>       qdev_prop_set_uint32(dev, "kind-of-intr", 0);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
> index 26788a1824a..ebdd461ae98 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -79,6 +79,7 @@ static void mb_v_generic_init(MachineState *machine)
>       memory_region_add_subregion(sysmem, ddr_base, phys_ram);
>   
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
>       qdev_prop_set_uint32(dev, "kind-of-intr",
>                            1 << UARTLITE_IRQ);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);


