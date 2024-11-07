Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF2D43349
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90hE-00039D-Js; Thu, 07 Nov 2024 06:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90hC-00038o-5l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:29:02 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90hA-0005sb-8G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:29:01 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cedea84d77so1276710a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978938; x=1731583738; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fvDbOuzxcH4Yk5PQkYll5ZKK5+d21c09viG/a/xAwww=;
 b=VL52RhzeZNKi01CTWow43RsSRorgmw8/RAV/WVWHq0QnYzT7IJKcehnLupjvkPUI/N
 24RxxqOnSHTadswDQ/lPmHz3mqp3XpcHJhXlkuPRVKIUpCU+utOBLTZ66SW+l2unfiWw
 dkca5OC/q6jHWnbevfSuNDSdH00BpqmC/5mq73UAoRveOvEfQwUoeR5oTU4iBYq9SuX3
 cZa1OH56108M6TOoQMRu4/MOb882o7L/mErxVmPWIY5r593xeNVZEqOm4jMuqY7P+dcq
 OTPJciUhDTI0p1yBrRXi4f5LRL8ERSZXFyb+43MlqpqRcOeKEYfNypjDfeYkAcQkS1pW
 W3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978938; x=1731583738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvDbOuzxcH4Yk5PQkYll5ZKK5+d21c09viG/a/xAwww=;
 b=H6Qgw18c8tqebjtLbgnfs2IPoN/dE5VT23FItraCPPJgRIROkTEjuYYhxG9owye72e
 I90bWmSr7tBPtZAub+a3RL+GcMyU0PKBNkCYpHKvfWvdeLikAq52g7Arn/aeZ/ARkWd2
 MiGQNcxd5eYHa745nelsOpyYQ0jeU2xx5gGCCjdPQ07+lUjy6prPDZSn7GftP2v3rbQ5
 AQl6Sv5B32NE9WzWHAFn2FZIndRDAy44JhuhjYH6YifbdB1f7n2mPJ9pxzeClvmJrgIy
 Do5UaKFqyMtzTh8eTuhbhghn1RU/COKWqO6lhBrR49UlwM/KJtxB8I+96OENwFWaZnvf
 8GPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLXm7kZlZA5tq9I5cAA6opNGK/VOTwUtu6rQcbLoIDVPm1eflzPhCAK2ZRWQLMuwJ/gAAOLgS9XHpe@nongnu.org
X-Gm-Message-State: AOJu0YyUg700GWUMP/a+49O3O2CXtev9YAJrq7eRVq0otgaypUpNqDJN
 654rdTOtc2AFESD4sJM+MAh06bY5lLMphtDi7+wRe8ykjY/pxBIHEFvJyGIQYNFB8R3YdTEQuXO
 CCjX5MJPnRGi7spkpY1Y1JhZqWIANo9Qv3JoD5A==
X-Google-Smtp-Source: AGHT+IEAZZsvQ2/IRimFlk3+CUQM+7q1Epjvpv2YmZ1WZYTQrhK/welu2/K4EshOtafPTLn5Kk7Fiuwsdb+D0gHL7yk=
X-Received: by 2002:a05:6402:2347:b0:5cf:505:c12f with SMTP id
 4fb4d7f45d1cf-5cf05a048e3mr683428a12.21.1730978937929; Thu, 07 Nov 2024
 03:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20241031065418.3111892-1-maobibo@loongson.cn>
In-Reply-To: <20241031065418.3111892-1-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 11:28:46 +0000
Message-ID: <CAFEAcA_4PabxEui-wbztw+nDpHsoAJNi-HWJU4opax54HgAo5w@mail.gmail.com>
Subject: Re: [PATCH] hw/loongarch/virt: Add reset interface for virt-machine
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 31 Oct 2024 at 06:55, Bibo Mao <maobibo@loongson.cn> wrote:
>
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
>  hw/loongarch/boot.c         |  9 +--------
>  hw/loongarch/virt.c         | 14 ++++++++++++++
>  include/hw/loongarch/boot.h |  1 +
>  target/loongarch/cpu.c      | 10 ++++++++++
>  4 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index cb668703bd..cbb4e3737d 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -216,12 +216,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>      return kernel_entry;
>  }
>
> -static void reset_load_elf(void *opaque)
> +void reset_load_elf(void *opaque)
>  {
>      LoongArchCPU *cpu = opaque;
>      CPULoongArchState *env = &cpu->env;
>
> -    cpu_reset(CPU(cpu));
>      if (env->load_elf) {
>         if (cpu == LOONGARCH_CPU(first_cpu)) {
>              env->gpr[4] = env->boot_info->a0;
> @@ -320,12 +319,6 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>  void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>  {
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> -    int i;
> -
> -    /* register reset function */
> -    for (i = 0; i < ms->smp.cpus; i++) {
> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
> -    }
>
>      info->kernel_filename = ms->kernel_filename;
>      info->kernel_cmdline = ms->kernel_cmdline;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 9a635d1d3d..80680d178c 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1434,6 +1434,19 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>      }
>  }
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
>  static void virt_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1457,6 +1470,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>      mc->auto_enable_numa_with_memdev = true;
>      mc->get_hotplug_handler = virt_get_hotplug_handler;
>      mc->default_nic = "virtio-net-pci";
> +    mc->reset = virt_reset;
>      hc->plug = virt_device_plug_cb;
>      hc->pre_plug = virt_device_pre_plug;
>      hc->unplug_request = virt_device_unplug_request;
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index b3b870df1f..c7020ec9bb 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -115,5 +115,6 @@ struct memmap_entry {
>  };
>
>  void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
> +void reset_load_elf(void *opaque);
>
>  #endif /* HW_LOONGARCH_BOOT_H */
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 7212fb5f8f..f7f8fcc024 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -592,6 +592,13 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>      info->print_insn = print_insn_loongarch;
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void loongarch_cpu_reset_cb(void *opaque)
> +{
> +    cpu_reset((CPUState *) opaque);
> +}
> +#endif
> +
>  static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -607,6 +614,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>      loongarch_cpu_register_gdb_regs_for_features(cs);
>
>      cpu_reset(cs);
> +#ifndef CONFIG_USER_ONLY
> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);
> +#endif

Please don't add new uses of qemu_register_reset().
I know that CPU reset is currently rather awkward (because
we don't automatically-reset CPU objects the way we do most
device objects), but generally what should happen is that
the machine model should arrange to reset the CPU objects
it creates. (Which is what it looks like the code you're
removing in this patch was doing already.)

thanks
-- PMM

