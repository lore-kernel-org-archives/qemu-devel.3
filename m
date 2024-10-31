Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C582D767E1
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Xr2-0006f7-QW; Thu, 31 Oct 2024 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Xr0-0006eg-Ib
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:16:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Xqy-00017G-PE
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:16:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e467c3996so875214b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730391415; x=1730996215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VfZ7/Ord9Q8h0h5GU2lWOt3rg0jcM9+XNU9aSGGnko0=;
 b=sVwI83tQ5afKJSZEZ7MyQsR/dvd8tMpLEeiNXrUNTzKT/vq6UiEAikJIim6chOEnJH
 KcU15aF0TMwYOXTBa9CBEkQ8NpVYZwDoS7eDottTwFIdXicDtcuLJy9IWHoWYZ1zSRRc
 P9jMsYj9381vro3opJhXt6IAVkvvKrif+qSyUfnlPG+Pg8VnLaJlfF99WPo2UCiWjBvZ
 HVZR6sWlmtyDPbtzAu6BMZk4yAJpsg+86WWalT+xEcNK7xqZfZwv1xPPRQ9D+I8K3dCJ
 0RzBZ+Y/RyHPfk2LGiOUZf7+xliLmUURsPJbonudoF879gh+aJ5gv10I7VK32GGYpref
 RAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730391415; x=1730996215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfZ7/Ord9Q8h0h5GU2lWOt3rg0jcM9+XNU9aSGGnko0=;
 b=wu/idPVweJLnJmKLmHfmg0Ue3NvWcBp1L03ryR/A39kgecuccAFSZ4O/6fs+QV76mN
 cAkpdT/PGfOXtsIUBVWukvVfytfwtjPdnjSMFQ2ARdn7gK8WTDjlJgawBE+I6qHCTPMo
 /nv7ckfJFuyfW0LuIjYQmVjBBu3re3Z0gBZ02h6Mp6SrBDsKLrN8I5ocQHeqZc4uTWBg
 X5H+Y0X/lXgDpuyWrHCgzfEQ5oYhgMBMcxy9mror1T0yfQA1NbTeYufidCRwf1q7J6Av
 BKSMlnNYv+ll7pRgvWj1giROLCzp/Y1VsxBZkjyJn4hEE+/YpmFoERMOv8XX9IHoRJ2b
 nRFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU2d3WQ/2Yn3iSlKaDlJUq+cr4YItCScj86myf7RTxcVnUNdVZOAtq59NvMuBkhLR2Oy6/BYvQtiBl@nongnu.org
X-Gm-Message-State: AOJu0YwlTYf5jJboeIZkagNzmsv/AOaX8pJQygKkmhrGLjt7eQsPc1nM
 TBNo8jN/C2DED8ix1A6paO/4w+Zvp4vvJwxoxqBTV1KVHdk3Xshk9PgGkw87EBA=
X-Google-Smtp-Source: AGHT+IEayCxP5ugVBphu7BQy5CmKCeLHz5VpBQuu/3NXPn+8JyhyDvvyZGO3mJZkP+hiO1nKI5FrzQ==
X-Received: by 2002:a05:6a00:18a0:b0:71e:786c:3fa9 with SMTP id
 d2e1a72fcca58-72062a5d8e2mr30563372b3a.0.1730391414719; 
 Thu, 31 Oct 2024 09:16:54 -0700 (PDT)
Received: from [10.0.12.195] ([190.210.133.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc313888sm1292215b3a.185.2024.10.31.09.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 09:16:54 -0700 (PDT)
Message-ID: <971b47d0-949b-4454-884b-28ec070f9365@linaro.org>
Date: Thu, 31 Oct 2024 13:16:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Add reset interface for virt-machine
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241031065418.3111892-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241031065418.3111892-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x430.google.com
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

Cc'ing Peter who is working on the Reset API.

On 31/10/24 03:54, Bibo Mao wrote:
> With generic cpu reset interface, pc register is entry of FLASH for
> UEFI BIOS. However with direct kernel booting requirement, there is
> little different, pc register of primary cpu is entry address of ELF
> file.
> 
> At the same time with requirement of cpu hotplug, hot-added CPU should
> register reset interface for this cpu object. Now reset callback is
> not registered for hot-added CPU.
> 
> With this patch reset callback for CPU is register when CPU instance
> is created, and reset interface is added for virt-machine board. In
> reset interface of virt-machine, reset for direct kernel booting
> requirement is called.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c         |  9 +--------
>   hw/loongarch/virt.c         | 14 ++++++++++++++
>   include/hw/loongarch/boot.h |  1 +
>   target/loongarch/cpu.c      | 10 ++++++++++
>   4 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index cb668703bd..cbb4e3737d 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -216,12 +216,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       return kernel_entry;
>   }
>   
> -static void reset_load_elf(void *opaque)
> +void reset_load_elf(void *opaque)
>   {
>       LoongArchCPU *cpu = opaque;
>       CPULoongArchState *env = &cpu->env;
>   
> -    cpu_reset(CPU(cpu));
>       if (env->load_elf) {
>   	if (cpu == LOONGARCH_CPU(first_cpu)) {
>               env->gpr[4] = env->boot_info->a0;
> @@ -320,12 +319,6 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> -    int i;
> -
> -    /* register reset function */
> -    for (i = 0; i < ms->smp.cpus; i++) {
> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
> -    }
>   
>       info->kernel_filename = ms->kernel_filename;
>       info->kernel_cmdline = ms->kernel_cmdline;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 9a635d1d3d..80680d178c 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1434,6 +1434,19 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>       }
>   }
>   
> +static void virt_reset(MachineState *machine, ResetType type)
> +{
> +    CPUState *cs;
> +
> +    /* Reset all devices including CPU devices */
> +    qemu_devices_reset(type);
> +
> +    /* Reset PC and register context for kernel direct booting method */
> +    CPU_FOREACH(cs) {
> +        reset_load_elf(LOONGARCH_CPU(cs));
> +    }
> +}
> +
>   static void virt_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1457,6 +1470,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>       mc->auto_enable_numa_with_memdev = true;
>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>       mc->default_nic = "virtio-net-pci";
> +    mc->reset = virt_reset;
>       hc->plug = virt_device_plug_cb;
>       hc->pre_plug = virt_device_pre_plug;
>       hc->unplug_request = virt_device_unplug_request;
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index b3b870df1f..c7020ec9bb 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -115,5 +115,6 @@ struct memmap_entry {
>   };
>   
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
> +void reset_load_elf(void *opaque);
>   
>   #endif /* HW_LOONGARCH_BOOT_H */
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 7212fb5f8f..f7f8fcc024 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -592,6 +592,13 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>       info->print_insn = print_insn_loongarch;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void loongarch_cpu_reset_cb(void *opaque)
> +{
> +    cpu_reset((CPUState *) opaque);
> +}
> +#endif
> +
>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> @@ -607,6 +614,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>       loongarch_cpu_register_gdb_regs_for_features(cs);
>   
>       cpu_reset(cs);
> +#ifndef CONFIG_USER_ONLY
> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);
> +#endif
>       qemu_init_vcpu(cs);
>   
>       lacc->parent_realize(dev, errp);
> 
> base-commit: 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29


