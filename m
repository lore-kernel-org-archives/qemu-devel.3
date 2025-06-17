Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62857C71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 03:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMrd-0000tV-DJ; Mon, 16 Jun 2025 23:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uRMra-0000tI-Tk
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:19:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uRMrX-00066h-7Y
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:19:54 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxlmnM3lBolx0YAQ--.55604S3;
 Tue, 17 Jun 2025 11:19:40 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxLsfE3lBoatkdAQ--.29444S3;
 Tue, 17 Jun 2025 11:19:35 +0800 (CST)
Subject: Re: [PATCH v3 00/13] hw/loongarch/virt: Add kernel irqchip support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
References: <20250606063033.2557365-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3a3608d2-30b0-dbcb-27d0-c19bb141f933@loongson.cn>
Date: Tue, 17 Jun 2025 11:22:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250606063033.2557365-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxLsfE3lBoatkdAQ--.29444S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1DCFWkuw48KF17Ar4DWrX_yoWrJw4kpr
 WUuw1Y9r48Gry7Jrnay345uF98WFn7Wr4a93WakFyfCrW3tF1vvF18t3sxXFyUKw18G34q
 qF4rWw1jg3WDAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcrWF
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.129, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/6/6 ÏÂÎç2:30, Bibo Mao Ð´µÀ:
> If kernel irqchip is set such as kvm_irqchip_in_kernel() return true, there
> is special operations with irqchips in such fields:
>    1. During irqchip object realization, kvm_create_device() is used here
>       to create irqchip in KVM kernel.
>    2. Add pre_save and post_load function, where register states can be
>       get and set from KVM kernel.
>    3. With reset function, register and software state is initialized
>       in qemu user space and set to KVM kernel with ioctl command.
>    4. Interrupt injection to kernel, IRQ line interrupt is injected with
>       API kvm_set_irq() and MSI interrupt is injected with API
>       kvm_irqchip_send_msi().
>
> ---
> v2 ... v3:
>    1. Implement reset function with kernel irqchip device, initialize the
>       registers and set to KVM kernel.
>    2. Use register offset address rather base address in function
>       kvm_pch_pic_save_load().
>    3. Rename kvm_xxx_save_load() with kvm_xxx_access().
>    4. Rename kvm_xxx_pre_save() with kvm_xxx_get(), kvm_xxx_post_load()
>       with kvm_xxx_put().
>    5. Macro KVM_IRQCHIP_NUM_PINS defined in UAPI header file is used
>       kvm_loongarch_init_irq_routing(), which means the maxinium irq line
>       number.
>
> v1 ... v2:
>    1. Remove property irqchip-in-kernel with irqchip device driver, use
>       global API kvm_irqchip_in_kernel() directly.
>    2. Do not create memory map region if kernel irqchip is set.
>    3. Modify copy and paste typo issue in kvm_arch_irqchip_create().
>    4. Do not emulate MISC_FUNC_REG IOCSR register if kernel irqchip is
>       set since it access EXTIOI memory region, this register need be
>       emulated in kernel.
>
> Bibo Mao (13):
>    hw/intc/loongarch_extioi: Add kernel irqchip realize function
>    hw/intc/loongarch_extioi: Add kernel irqchip save and restore function
>    hw/intc/loongarch_ipi: Add kernel irqchip realize function
>    hw/intc/loongson_ipi: Add load and save interface with ipi_common
>      class
>    hw/intc/loongarch_ipi: Add kernel irqchip save and restore function
>    hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
>    hw/intc/loongarch_pch: Add kernel irqchip realize function
>    hw/intc/loongarch_pch: Add kernel irqchip save and restore function
>    hw/intc/loongarch_pch: Inject irq line interrupt to kernel
>    hw/loongarch/virt: Add reset support for kernel irqchip
>    target/loongarch: Report error with split kernel_irqchip option
>    hw/loongarch/virt: Disable emulation with IOCSR misc register
>    hw/loongarch/virt: Add kernel irqchip support
hi,

This series looks good to me. I will apply to loongarch.nexts
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Son Gao
>   hw/intc/loongarch_extioi.c             |  49 ++++++---
>   hw/intc/loongarch_extioi_kvm.c         | 140 +++++++++++++++++++++++++
>   hw/intc/loongarch_ipi.c                |  29 +++++
>   hw/intc/loongarch_ipi_kvm.c            |  85 +++++++++++++++
>   hw/intc/loongarch_pch_msi.c            |  10 ++
>   hw/intc/loongarch_pch_pic.c            |  45 +++++++-
>   hw/intc/loongarch_pic_kvm.c            |  89 ++++++++++++++++
>   hw/intc/loongson_ipi_common.c          |  33 ++++++
>   hw/intc/meson.build                    |   6 ++
>   hw/loongarch/virt.c                    |  65 +++++++-----
>   include/hw/intc/loongarch_extioi.h     |   5 +
>   include/hw/intc/loongarch_ipi.h        |   5 +
>   include/hw/intc/loongarch_pch_pic.h    |   5 +
>   include/hw/intc/loongarch_pic_common.h |   1 +
>   include/hw/intc/loongson_ipi_common.h  |   2 +
>   target/loongarch/cpu.h                 |   1 +
>   target/loongarch/kvm/kvm.c             |  23 +++-
>   17 files changed, 552 insertions(+), 41 deletions(-)
>   create mode 100644 hw/intc/loongarch_extioi_kvm.c
>   create mode 100644 hw/intc/loongarch_ipi_kvm.c
>   create mode 100644 hw/intc/loongarch_pic_kvm.c
>
>
> base-commit: 09be8a511a2e278b45729d7b065d30c68dd699d0


