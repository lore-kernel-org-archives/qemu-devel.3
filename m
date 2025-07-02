Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921C0C8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnVU-00009b-9R; Tue, 01 Jul 2025 22:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uWnVR-00008q-Ji
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:47:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uWnVG-0006sg-P0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:47:29 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxCeGsnWRoRfggAQ--.30561S3;
 Wed, 02 Jul 2025 10:47:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxdOSonWRo3SUGAA--.34892S3;
 Wed, 02 Jul 2025 10:47:08 +0800 (CST)
Subject: Re: [PATCH v3 6/9] hw/loongarch: Implement avec controller imput and
 output pins
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-7-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <751fa17c-a3f9-4117-67b3-e2c2df9d796c@loongson.cn>
Date: Wed, 2 Jul 2025 10:45:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250627030138.2482055-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOSonWRo3SUGAA--.34892S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryfZF1xKw45Ww4xKF4rZwc_yoWrGF1Upr
 WUuFn5Kr1UXFZ7Xws2gw15u3Z8Zrn3GFyIqa1a9rWSkF4DGw10gr48J3yavFyDA3ykZ3Wj
 qFn5Za13Xa17J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcDDG
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2025/6/27 上午11:01, Song Gao wrote:
> the AVEC controller supports 256*256 irqs input, all the irqs connect CPU INT_AVEC irq
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c | 21 +++++++++++++++++++++
>   hw/loongarch/virt.c      | 11 +++++++++--
>   target/loongarch/cpu.h   |  3 ++-
>   3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index 253bab5461..c686ac9483 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -38,7 +38,12 @@ static const MemoryRegionOps loongarch_avec_ops = {
>   
>   static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>   {
> +    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
>       LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList  *id_list;
> +    int i;
>   
>       Error *local_err = NULL;
>       lac->parent_realize(dev, &local_err);
> @@ -47,6 +52,22 @@ static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    assert(mc->possible_cpu_arch_ids);
> +    id_list = mc->possible_cpu_arch_ids(machine);
> +    s->num_cpu = id_list->len;
> +    s->cpu = g_new(AVECCore, s->num_cpu);
> +    if (s->cpu == NULL) {
> +        error_setg(errp, "Memory allocation for AVECCore fail");
> +        return;
> +    }
> +
> +    for (i = 0; i < s->num_cpu; i++) {
> +        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
> +        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
> +        qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
> +    }
> +    qdev_init_gpio_in(dev, NULL, NR_VECTORS * s->num_cpu);
This line can be removed, it is not necessary to config so many gpio 
lines with number NR_VECTORS * s->num_cpu.

Regards
Bibo Mao
> +
>       return;
>   }
>   
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6fb08740c2..1d4e62b1cf 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -381,7 +381,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>       }
>   }
>   
> -static void virt_irq_init(LoongArchVirtMachineState *lvms)
> +static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
>   {
>       DeviceState *pch_pic, *pch_msi;
>       DeviceState *ipi, *extioi, *avec;
> @@ -471,6 +471,13 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
>           memory_region_add_subregion(get_system_memory(), VIRT_AVEC_BASE,
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
> +        CPUState *cpu_state;
> +        DeviceState *cpudev;
> +        for (int cpu = 0; cpu < ms->smp.cpus; cpu++) {
> +            cpu_state = qemu_get_cpu(cpu);
> +            cpudev = DEVICE(cpu_state);
> +            qdev_connect_gpio_out(avec, cpu, qdev_get_gpio_in(cpudev, INT_AVEC));
> +        }
>       }
>   
>       /* Create EXTIOI device */
> @@ -839,7 +846,7 @@ static void virt_init(MachineState *machine)
>       }
>   
>       /* Initialize the IO interrupt subsystem */
> -    virt_irq_init(lvms);
> +    virt_irq_init(lvms, machine);
>       lvms->machine_done.notify = virt_done;
>       qemu_add_machine_init_done_notifier(&lvms->machine_done);
>        /* connect powerdown request */
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 208d3e0cd3..556e9dabb9 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -217,9 +217,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
>   extern const char * const regnames[32];
>   extern const char * const fregnames[32];
>   
> -#define N_IRQS      13
> +#define N_IRQS      15
>   #define IRQ_TIMER   11
>   #define IRQ_IPI     12
> +#define INT_AVEC    14
>   
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
>   #define LOONGARCH_MTLB         64   /* 64 MTLB */
> 


