Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B64CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsZF-0001B7-9O; Thu, 07 May 2026 02:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wKsZ9-00019C-BG
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wKsZ4-0006oo-AP
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:33 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax_8AvNvxpSWQHAA--.204S3;
 Thu, 07 May 2026 14:50:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx2+AtNvxpVR18AA--.39693S3;
 Thu, 07 May 2026 14:50:21 +0800 (CST)
Subject: Re: [PATCH 4/4] Add dintc kvm_irqchip_in_kernel support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-5-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c61c7dcc-78a8-699d-abca-012cd833b7fa@loongson.cn>
Date: Thu, 7 May 2026 14:47:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260427070029.1059386-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx2+AtNvxpVR18AA--.39693S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyrGF15tFykCr15uF4kAFc_yoW7GF1Dpr
 W7uFn8Kr48ArnrGFnxJasxuF4fWrsa934IgFyakFySkF4xXryrWw40grnxXFy7Gw1DW340
 vrnYga1j9F17J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1MK
 ZJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
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



On 2026/4/27 下午3:00, Song Gao wrote:
> Function kvm_dintc_realize() is added if kvm_irqchip_in_kernel is
> set. It is to create and initialize DINTC device in kernel mode.
> and use kvm_irqchip_send_msi() to send  msi to kernel.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
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
> index 96742df090..015c1e67e4 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -82,3 +82,5 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extio
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


