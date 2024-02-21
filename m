Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C1CC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqR2-0003z7-6V; Wed, 21 Feb 2024 12:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqQy-0003y2-Vy
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:31:05 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqQj-0001yv-2c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:31:04 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso7087581a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708536644; x=1709141444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sGD50sVu3CFlDs4SMrbA/+esZxp8nCcncxRA7tspcPM=;
 b=vOjryKzW22WexknjMxHz9xHnFOhwp9jk7Kgb8HRFb3YIbXeCCXoy2IeFcg6BzASOpB
 kmy1mooyqgfZIKd474OG2W1UI/WNGVw+sxVEU3iJtJVWfUY6FJ0peo5pINpcIu15KAM2
 b/jX13tS5JsuIdopyp2L053+dpw/5M1FX0mrnyGWYynYZRX/iQsioz82zPAHtZV2lHqI
 WYcW4f4kQW+lW9JsDRQ6ZHdBbdC0ieJySKXse+pjWE159vxaTxS2ueJJHpVawkr+L4qM
 Qebb0LikKEeaxyqS3XasfKyvzhk7FXJVqqMcbQybDzEpc7FuHeXXJsLVfDRfCZEGsSNw
 onFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536644; x=1709141444;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGD50sVu3CFlDs4SMrbA/+esZxp8nCcncxRA7tspcPM=;
 b=Wnz9gAH1/Njl2SQsoqze95eoesFxGoH0hyVVnBad7P4rOg/LeZfCgLn4+5O/gWQXPl
 HogxVOpTjQsszlRNH4yQ0Cb0/ZX5LSbNMM/hbOL9Z8jd3ESCU2+67FdvHkJhs3VO9HlL
 7o0FfO6nFbGeZLNAVlRJ4MDhfng8xSj//8HFYQU3EkT/UlPW0c+Yf7UXMzVAV26GTZWq
 Fe0WkW31hVuaYljj2NOb97xSK6v1TD49YVJtyrh2OZA4Yk/MTeC5tTmmef6LMofUhcwk
 T9T5D68gJrsuKUL1gmHPaiQ99km91ex0B5paypgkV4fvMN0qLwA2g/G21K6mhbBhi31k
 tdZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZSYBBkjg2zxhmFVTtH3ZUxZTtv19anS6oK6Oor1p1fMiseUl36+muIARwqw9RLmVoPtPjzSqnE4TIy+fpGdppg047zAY=
X-Gm-Message-State: AOJu0YzPw333TMH46iGQIPwdx12ukCjdHv7PTdCT5a2iMOOucsurgcSy
 Y7ZoIgXdm1EaPSQ8KjEfGCBTA7ZgluJA+Qoi765EJiZWh+mkX4FglLe2uOAZykA=
X-Google-Smtp-Source: AGHT+IEnC7o+F8NShHK0e2v8E173wbviavgo26RuYr6AFyvH8MyqmMoGzH4/O83cYnbG6LF90yrHXQ==
X-Received: by 2002:a50:ec95:0:b0:564:caed:75a4 with SMTP id
 e21-20020a50ec95000000b00564caed75a4mr1039229edr.41.1708536644359; 
 Wed, 21 Feb 2024 09:30:44 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05640243c400b00560c6ff443esm4697358edc.66.2024.02.21.09.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:30:43 -0800 (PST)
Message-ID: <edaea1af-b42e-438e-8f82-8c1fbe95f874@linaro.org>
Date: Wed, 21 Feb 2024 18:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] meson: Enable -Wvla
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-4-thuth@redhat.com>
 <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
 <e38c7fa5-8dc8-4e7a-a4a9-06a88206b325@linaro.org>
In-Reply-To: <e38c7fa5-8dc8-4e7a-a4a9-06a88206b325@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 21/2/24 18:27, Philippe Mathieu-Daudé wrote:

> Clément, ResetData::entry isn't used, so we can simplify removing
> the whole ResetData structure, but I'm not sure this is intended:
> 
> -- >8 --
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 4873b59b6c..1ff6b5d63d 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -68,14 +68,6 @@
>   #define LEON3_APB_PNP_OFFSET (0x800FF000)
>   #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
> 
> -typedef struct ResetData {
> -    struct CPUResetData {
> -        int id;
> -        SPARCCPU *cpu;
> -    } info[MAX_CPUS];
> -    uint32_t entry;             /* save kernel entry in case of reset */
> -} ResetData;
> -
>   static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
>   {
>       stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> @@ -148,17 +140,14 @@ static void write_bootloader(void *ptr, hwaddr 
> kernel_addr)
> 
>   static void leon3_cpu_reset(void *opaque)
>   {
> -    struct CPUResetData *info = (struct CPUResetData *) opaque;
> -    int id = info->id;
> -    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
> -    CPUState *cpu = CPU(s->info[id].cpu);
> +    CPUState *cpu = opaque;
>       CPUSPARCState *env = cpu_env(cpu);
> 
>       cpu_reset(cpu);
> 
>       cpu->halted = cpu->cpu_index != 0;
> -    env->pc = s->entry;
> -    env->npc = s->entry + 4;
> +    env->pc = LEON3_PROM_OFFSET;
> +    env->npc = LEON3_PROM_OFFSET + 4;
>   }
> 
>   static void leon3_cache_control_int(CPUSPARCState *env)
> @@ -259,7 +248,7 @@ static void leon3_generic_hw_init(MachineState 
> *machine)
>       ram_addr_t ram_size = machine->ram_size;
>       const char *bios_name = machine->firmware ?: LEON3_PROM_FILENAME;
>       const char *kernel_filename = machine->kernel_filename;
> -    SPARCCPU *cpu;
> +    SPARCCPU *cpu[MAX_CPUS];
>       CPUSPARCState   *env;
>       MemoryRegion *address_space_mem = get_system_memory();
>       MemoryRegion *prom = g_new(MemoryRegion, 1);
> @@ -267,28 +256,22 @@ static void leon3_generic_hw_init(MachineState 
> *machine)
>       char       *filename;
>       int         bios_size;
>       int         prom_size;
> -    ResetData  *reset_info;
>       DeviceState *dev, *irqmpdev;
>       int i;
>       AHBPnp *ahb_pnp;
>       APBPnp *apb_pnp;
> 
> -    reset_info = g_malloc0(sizeof(ResetData));
> -
>       for (i = 0; i < machine->smp.cpus; i++) {
>           /* Init CPU */
> -        cpu = SPARC_CPU(object_new(machine->cpu_type));
> -        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, 
> "start_cpu", 1);
> -        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
> -        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> -        env = &cpu->env;
> +        cpu[i] = SPARC_CPU(object_new(machine->cpu_type));
> +        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_start_cpu, 
> "start_cpu", 1);
> +        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_set_pil_in, 
> "pil", 1);
> +        qdev_realize(DEVICE(cpu[i]), NULL, &error_fatal);
> +        env = &cpu[i]->env;
> 
>           cpu_sparc_set_id(env, i);
> 
> -        /* Reset data */
> -        reset_info->info[i].id = i;
> -        reset_info->info[i].cpu = cpu;
> -        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
> +        qemu_register_reset(leon3_cpu_reset, cpu[i]);

           qemu_register_reset(leon3_cpu_reset, CPU(cpu[i]));

>       }
> 
>       ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
> @@ -312,13 +295,12 @@ static void leon3_generic_hw_init(MachineState 
> *machine)
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
> 
>       for (i = 0; i < machine->smp.cpus; i++) {
> -        cpu = reset_info->info[i].cpu;
> -        env = &cpu->env;
> +        env = &cpu[i]->env;
>           qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
> -                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                    qdev_get_gpio_in_named(DEVICE(cpu[i]),
> 
> "start_cpu", 0));
>           qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
> -                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                    qdev_get_gpio_in_named(DEVICE(cpu[i]),
>                                                              "pil", 0));
>           env->irq_manager = irqmpdev;
>           env->qemu_irq_ack = leon3_irq_manager;
> @@ -396,11 +378,6 @@ static void leon3_generic_hw_init(MachineState 
> *machine)
>                * bootloader.
>                */
>               write_bootloader(memory_region_get_ram_ptr(prom), entry);
> -            reset_info->entry = LEON3_PROM_OFFSET;
> -            for (i = 0; i < machine->smp.cpus; i++) {
> -                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
> -                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
> -            }
>           }
>       }
> ---
> 
> Regards,
> 
> Phil.


