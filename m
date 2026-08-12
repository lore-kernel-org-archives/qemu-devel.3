Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB487C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 02:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtydl-0006M6-Qq; Tue, 11 Aug 2026 22:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wtydj-0006Lt-I3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 22:24:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wtydg-0000Wu-Fp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 22:24:23 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxf9NM2XtqKGkAAA--.1279S3;
 Wed, 12 Aug 2026 10:24:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxPs9L2XtqEnkBAA--.10095S2;
 Wed, 12 Aug 2026 10:24:13 +0800 (CST)
Subject: Re: [PATCH v3 3/4] Add dintc kvm_irqchip_in_kernel support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260525084645.3328690-1-gaosong@loongson.cn>
 <20260525084645.3328690-4-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e88aeae0-7082-dfba-a812-e85dccdf7691@loongson.cn>
Date: Wed, 12 Aug 2026 10:23:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260525084645.3328690-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs9L2XtqEnkBAA--.10095S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyrGF15tFykCr15tr1xCrX_yoW7Xr4fpr
 W7uFn8Kr48JrnrWrnxJasxuFs3Wrs2934IgFyakFySkF4xXryrWw40grnxXFy7Gw1UW3W0
 vrnY9a1j9F1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.791,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/5/25 下午4:46, Song Gao wrote:
> Function kvm_dintc_realize() is added if kvm_irqchip_in_kernel is
> set. It is to create and initialize DINTC device in kernel mode.
> and use kvm_irqchip_send_msi() to send  msi to kernel.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_dintc.c         | 13 +++++++++
>   hw/intc/loongarch_dintc_kvm.c     | 48 +++++++++++++++++++++++++++++++
>   hw/intc/meson.build               |  2 ++
>   include/hw/intc/loongarch_dintc.h | 10 +++++++
>   4 files changed, 73 insertions(+)
>   create mode 100644 hw/intc/loongarch_dintc_kvm.c
> 
> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
> index c42a919df4..b8bd7ae015 100644
> --- a/hw/intc/loongarch_dintc.c
> +++ b/hw/intc/loongarch_dintc.c
> @@ -53,6 +53,15 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
>       cs = cpu_by_arch_id(cpu_num);
>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>   
> +    if (kvm_irqchip_in_kernel()) {
> +        MSIMessage msg;
> +
> +        msg.address = msg_addr;
> +        msg.data = val;
> +        kvm_irqchip_send_msi(kvm_state, msg);
> +        return;
> +    }
> +
>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
>                            RUN_ON_CPU_HOST_INT(irq_num));
>       qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
> @@ -95,6 +104,10 @@ static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
>           qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
>       }
>   
> +    if (kvm_irqchip_in_kernel()) {
> +        kvm_dintc_realize(dev, errp);
> +    }
> +
>       return;
>   }
>   
> diff --git a/hw/intc/loongarch_dintc_kvm.c b/hw/intc/loongarch_dintc_kvm.c
> new file mode 100644
> index 0000000000..1137bcd9a6
> --- /dev/null
> +++ b/hw/intc/loongarch_dintc_kvm.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * LoongArch DINTC interrupt kvm support
> + *
> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> + */

one small nit: Copyright (C) 2026
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> +
> +#include "qemu/osdep.h"
> +#include "hw/intc/loongarch_dintc.h"
> +#include "linux/kvm.h"
> +#include "qapi/error.h"
> +#include "system/kvm.h"
> +
> +void kvm_dintc_realize(DeviceState *dev, Error **errp)
> +{
> +    LoongArchDINTCState *lds = LOONGARCH_DINTC(dev);
> +    int ret;
> +
> +    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_DMSINTC, false);
> +    if (ret < 0) {
> +        fprintf(stderr, "create KVM_DEV_TYPE_LOONGARCH_AVEC failed: %s\n",
> +               strerror(-ret));
> +        abort();
> +    }
> +    lds->dev_fd = ret;
> +
> +    /* init dintc config */
> +    lds->msg_addr_base = VIRT_DINTC_BASE;
> +    lds->msg_addr_size = VIRT_DINTC_SIZE;
> +
> +    ret = kvm_device_access(lds->dev_fd, KVM_DEV_LOONGARCH_DMSINTC_GRP_CTRL,
> +                            KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE,
> +                            &lds->msg_addr_base, true, NULL);
> +    if (ret < 0) {
> +        fprintf(stderr, "KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_BASE failed: %s\n",
> +                strerror(ret));
> +        abort();
> +    }
> +
> +    ret = kvm_device_access(lds->dev_fd, KVM_DEV_LOONGARCH_DMSINTC_GRP_CTRL,
> +                            KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE,
> +                            &lds->msg_addr_size, true, NULL);
> +    if (ret < 0) {
> +        fprintf(stderr, "KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_SIZE failed: %s\n",
> +                strerror(ret));
> +        abort();
> +    }
> +}
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index fac2d228f9..48e5fa352a 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -88,3 +88,5 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extio
>   specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
>                  if_true: files('loongarch_extioi_kvm.c'))
>   specific_ss.add(when: 'CONFIG_LOONGARCH_DINTC', if_true: files('loongarch_dintc.c'))
> +specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_DINTC'],
> +               if_true: files('loongarch_dintc_kvm.c'))
> diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
> index 1f4f65705a..95a7879e26 100644
> --- a/include/hw/intc/loongarch_dintc.h
> +++ b/include/hw/intc/loongarch_dintc.h
> @@ -9,8 +9,13 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/loongarch/virt.h"
>   #include "system/memory.h"
> +#include "hw/pci-host/ls7a.h"
>   
>   #define NR_VECTORS     256
> +#define IRQ_BIT_BASE    5
> +#define IRQ_BIT_LEN     8
> +#define CPU_BIT_BASE   13
> +#define CPU_BIT_LEN     8
>   
>   #define TYPE_LOONGARCH_DINTC "loongarch_dintc"
>   OBJECT_DECLARE_TYPE(LoongArchDINTCState, LoongArchDINTCClass, LOONGARCH_DINTC)
> @@ -25,7 +30,10 @@ struct LoongArchDINTCState {
>       SysBusDevice parent_obj;
>       MemoryRegion dintc_mmio;
>       DINTCCore *cpu;
> +    int dev_fd;
>       uint32_t num_cpu;
> +    uint64_t msg_addr_base;
> +    uint64_t msg_addr_size;
>   };
>   
>   struct LoongArchDINTCClass {
> @@ -34,3 +42,5 @@ struct LoongArchDINTCClass {
>       DeviceRealize parent_realize;
>       DeviceUnrealize parent_unrealize;
>   };
> +
> +void kvm_dintc_realize(DeviceState *dev, Error **errp);
> 


