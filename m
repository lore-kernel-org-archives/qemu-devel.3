Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D121CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyuv-00072P-IL; Mon, 01 Sep 2025 03:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyuq-000718-6o
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyuk-0004Zh-Io
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756711514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QhQEtQVZ6QY0fnSyPDlS+P0H7oesNSIlKd0gxuIqwoU=;
 b=CPMZz7Kpjxdv8V7RpUQVnCfcUhQpymcO5pLu6swaEmWYBvGG2opVqfCIW6Y96YV7k/1EC6
 FE7RpF1T9Zz4uNCo0o7mBV8ERx18PTMgN/b572aAsaVhSyFnVsh8h/1qZDZpESpylkhYHT
 iAQBjVmW43Sc7Xz7nVBa780ZdcDfyXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-HySj3Hh8Mmy6BP04hokHjg-1; Mon, 01 Sep 2025 03:25:13 -0400
X-MC-Unique: HySj3Hh8Mmy6BP04hokHjg-1
X-Mimecast-MFC-AGG-ID: HySj3Hh8Mmy6BP04hokHjg_1756711512
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a15f10f31so38330855e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756711512; x=1757316312;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhQEtQVZ6QY0fnSyPDlS+P0H7oesNSIlKd0gxuIqwoU=;
 b=YJGG6V1MFXHqhns/z/Op+eAMMJjrvEHEJLcDx0rT1NlqSVssKbk3KLQSGUUa0THdyr
 0wQXjd5ffDRg9zoyppZ2WoxhaCiunkxg1h0wMZlKhDaOu5RmPJYLWmDpZhA3CFB8b+Cb
 ae52PYKNLapEixTZpW6q4wNhdTYacbiOryEqgXUAnMJ3G+vx5tpP11+C9xUHDcDg9VTW
 EW4kEZwZIj3GzTgEdkW08qnprscWFt7TvdHGdpk0tI/8QCgltY29iGuR4T0m6yXbEfqD
 XpRhS+l3vuNCeFn82YSP+2Vsg7fzMEmooHTZYGRxckMXdmfkKhrJ3t2iac1dVia8GYJw
 Lv2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoyb1H19tnHagu0/Ih6yTGFcA9UbA4Lk1nTIR442WwjKDYSU5P+HxblpWy3p00Etwx7WkU367PILvP@nongnu.org
X-Gm-Message-State: AOJu0YzwKXyhCr4HjUbb3otad6BRyr/9UAJqmbRzEwt5zABxUPM1MwWk
 J+B+SYH00XFFz84nhpxAb+hP8VS3gALp7J59LpwBWPGaTqyWnfwIOR2l3ljcNdDqsOmFC2BCpQT
 nSYfJ5O7SQbeA5rAad9ISCki964H1aHuvOL8e2WPJNeCdTQV9DrEVkYMj
X-Gm-Gg: ASbGncswNyoQ3Xweg7ctrsvZBmqj6bVNf7MEAsY012W6KYjxxGhgyDYswsupF07y1WM
 x8Irl2FSD2PWfI0V5qKBEYH1C6h/BfCEnaOp4yOa53VP7TWy4eWfF0bxYdpOmAyw34Ks08CmDGR
 UJ1IHzo/qVXsFsG7zyntEGkBa4hiwX6bkBwGjuSvSIlsr7RZyJF1qVXzxl//KRuSMGyXIQ52O53
 iOxDqsd+PQiWYIUKxlWN93VX+HkwVGxzoa+V+2rY2K8Z2v8fm3HVEA9sV56RY2UFTrUlRVH/Fgs
 7QX2KHUYFr5ianZjS58Gu62u3CHCpkxuIDDADqEMt+po6tGD0rujgCeYePjVh1Et4uey3Hj67DJ
 TiRE=
X-Received: by 2002:a05:600c:17d8:b0:456:1146:5c01 with SMTP id
 5b1f17b1804b1-45b84c586e8mr39363775e9.12.1756711512024; 
 Mon, 01 Sep 2025 00:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLxidT8TcYctEY6wHcxS9YeJ8levnmB24bAnrHhY7KDymsr3SSl9DAw5x/K4VH5dEKFgU7g==
X-Received: by 2002:a05:600c:17d8:b0:456:1146:5c01 with SMTP id
 5b1f17b1804b1-45b84c586e8mr39363565e9.12.1756711511582; 
 Mon, 01 Sep 2025 00:25:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d204asm14048634f8f.24.2025.09.01.00.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:25:10 -0700 (PDT)
Message-ID: <e867b3af-c2fc-4776-8c47-bff7114e29f8@redhat.com>
Date: Mon, 1 Sep 2025 09:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/ppc: Add a test machine for the IBM PPE42 CPU
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250826201920.335308-1-milesg@linux.ibm.com>
 <20250826201920.335308-4-milesg@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250826201920.335308-4-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/25 22:17, Glenn Miles wrote:
> Adds a test machine for the IBM PPE42 processor, including a
> DEC, FIT, WDT and 1MB of ram.
> 
> The purpose of this machine is only to provide a generic platform
> for testing instructions of the recently  added PPE42 processor
> model which is used extensively in the IBM Power9, Power10 and
> future Power server processors.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
> 
> Changes from previous version
> - Added ppe42_machine.c to MAINTAINERS file with self as maintainer
> 
>   MAINTAINERS            |  6 ++++
>   hw/ppc/Kconfig         |  9 ++++++
>   hw/ppc/meson.build     |  2 ++
>   hw/ppc/ppc_booke.c     |  7 ++++-
>   hw/ppc/ppe42_machine.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/ppc.h   |  1 +
>   6 files changed, 93 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/ppe42_machine.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..52fa303e0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1531,6 +1531,12 @@ F: include/hw/pci-host/grackle.h
>   F: pc-bios/qemu_vga.ndrv
>   F: tests/functional/test_ppc_mac.py
>   
> +PPE42
> +M: Glenn Miles <milesg@linux.ibm.com>
> +L: qemu-ppc@nongnu.org
> +S: Odd Fixes
> +F: hw/ppc/ppe42_machine.c
> +
>   PReP
>   M: Hervé Poussineau <hpoussin@reactos.org>
>   L: qemu-ppc@nongnu.org
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index ced6bbc740..3fdea5919c 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -44,6 +44,15 @@ config POWERNV
>       select SSI_M25P80
>       select PNV_SPI
>   
> +config PPC405
> +    bool
> +    default y
> +    depends on PPC
> +    select M48T59
> +    select PFLASH_CFI02
> +    select PPC4XX
> +    select SERIAL
> +
>   config PPC440
>       bool
>       default y
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 9893f8adeb..170b90ae7d 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -57,6 +57,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_n1_chiplet.c',
>   ))
>   # PowerPC 4xx boards
> +ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> +  'ppe42_machine.c'))
>   ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
>     'ppc440_bamboo.c',
>     'ppc440_uc.c'))
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 3872ae2822..13403a56b1 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -352,7 +352,12 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
>       booke_timer = g_new0(booke_timer_t, 1);
>   
>       cpu->env.tb_env = tb_env;
> -    tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
> +    if (flags & PPC_TIMER_PPE) {

PPC_TIMER_PPE definition should be introduced in its own patch.


> +        /* PPE's use a modified version of the booke behavior */
> +        tb_env->flags = flags | PPC_DECR_UNDERFLOW_TRIGGERED;
> +    } else {
> +        tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
> +    }
>   
>       tb_env->tb_freq    = freq;
>       tb_env->decr_freq  = freq;
> diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
> new file mode 100644
> index 0000000000..0bc295da28
> --- /dev/null
> +++ b/hw/ppc/ppe42_machine.c
> @@ -0,0 +1,69 @@
> +
> +/*
> + * Test Machine for the IBM PPE42 processor
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "system/address-spaces.h"
> +#include "hw/boards.h"
> +#include "hw/ppc/ppc.h"
> +#include "system/system.h"
> +#include "system/reset.h"
> +#include "system/kvm.h"
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    PowerPCCPU *cpu = opaque;
> +
> +    cpu_reset(CPU(cpu));

There are no register settings ? Just asking

> +}
> +
> +static void ppe42_machine_init(MachineState *machine)
> +{
> +    PowerPCCPU *cpu;
> +    CPUPPCState *env;
> +
> +    if (kvm_enabled()) {
> +        error_report("machine %s does not support the KVM accelerator",
> +                     MACHINE_GET_CLASS(machine)->name);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* init CPU */
> +    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));

I would introduce a specific MachineState for the ppe42 Machine:

   struct Ppe42MachineState {
     /* Private */
     MachineState parent_obj;
     /* Public */

     PowerPCCPU cpu;
   };

and use qdev_realize() too.


> +    env = &cpu->env;
> +    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_PPE42) {
> +        error_report("Incompatible CPU, only PPE42 bus supported");

Can't we define valid_cpu_types instead ?

> +        exit(1);
> +    }
> +
> +    qemu_register_reset(main_cpu_reset, cpu);
> +
> +    /* This sets the decrementer timebase */
> +    ppc_booke_timers_init(cpu, 37500000, PPC_TIMER_PPE);
> +
> +    /* RAM */
> +    if (machine->ram_size > 2 * GiB) {

2GB RAM ? really ?

> +        error_report("RAM size more than 2 GiB is not supported");
> +        exit(1);
> +    }
> +    memory_region_add_subregion(get_system_memory(), 0xfff80000, machine->ram);
> +}
> +
> +
> +static void ppe42_machine_class_init(MachineClass *mc)
> +{
> +    mc->desc = "PPE42 Test Machine";
> +    mc->init = ppe42_machine_init;
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("PPE42XM");
> +    mc->default_ram_id = "ram";
> +    mc->default_ram_size = 1 * MiB;
> +}
> +
> +DEFINE_MACHINE("ppe42_machine", ppe42_machine_class_init)
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 8a14d623f8..cb51d704c6 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -52,6 +52,7 @@ struct ppc_tb_t {
>   #define PPC_DECR_UNDERFLOW_LEVEL     (1 << 4) /* Decr interrupt active when
>                                                  * the most significant bit is 1.
>                                                  */
> +#define PPC_TIMER_PPE                (1 << 5) /* Enable PPE support */
>   
>   uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
>   void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);


