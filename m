Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2069ECA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuS5v-0005He-Pu; Fri, 05 Sep 2025 04:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uuS5t-0005Gt-Ah
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:46:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uuS5n-0008Nm-JD
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:46:53 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxB9Fyo7poyAEHAA--.14686S3;
 Fri, 05 Sep 2025 16:46:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxZORvo7po2cV_AA--.9260S3;
 Fri, 05 Sep 2025 16:46:41 +0800 (CST)
Subject: Re: [PATCH v6 04/11] loongarch: add a advance interrupt controller
 device
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-5-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f8880d9b-d2b2-3882-0ca6-6e95c0826660@loongson.cn>
Date: Fri, 5 Sep 2025 16:44:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZORvo7po2cV_AA--.9260S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyDGF13Cw45Xw4rurW5twc_yoW7XryrpF
 9xuF45GF4UXF47XrZxt3sxCFn8Jrs7Wry2vF1a9ryxArZ3Gry8Xw1kKr9rZFW8G3ykA340
 qFnYka15ZF47JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/9/4 下午8:18, Song Gao wrote:
> Add Loongarch  advance interrupt controller device base Definition.
Two space here with "Loongarch  advance", maybe advanced is better.

Otherwise looks good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/Kconfig                  |  3 ++
>   hw/intc/loongarch_avec.c         | 68 ++++++++++++++++++++++++++++++++
>   hw/intc/meson.build              |  1 +
>   hw/loongarch/Kconfig             |  1 +
>   include/hw/intc/loongarch_avec.h | 35 ++++++++++++++++
>   5 files changed, 108 insertions(+)
>   create mode 100644 hw/intc/loongarch_avec.c
>   create mode 100644 include/hw/intc/loongarch_avec.h
> 
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 7547528f2c..b9266dc269 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -109,3 +109,6 @@ config LOONGARCH_PCH_MSI
>   
>   config LOONGARCH_EXTIOI
>       bool
> +
> +config LOONGARCH_AVEC
> +    bool
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> new file mode 100644
> index 0000000000..5a3e7ecc03
> --- /dev/null
> +++ b/hw/intc/loongarch_avec.c
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU Loongson  Advance interrupt controller.
> + *
> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "hw/intc/loongarch_pch_msi.h"
> +#include "hw/intc/loongarch_pch_pic.h"
> +#include "hw/intc/loongarch_avec.h"
> +#include "hw/pci/msi.h"
> +#include "hw/misc/unimp.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +#include "hw/qdev-properties.h"
> +
> +
> +static void loongarch_avec_realize(DeviceState *dev, Error **errp)
> +{
> +    LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
> +
> +    Error *local_err = NULL;
> +    lac->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    return;
> +}
> +
> +static void loongarch_avec_unrealize(DeviceState *dev)
> +{
> +    return;
> +}
> +
> +static void loongarch_avec_init(Object *obj)
> +{
> +    return;
> +}
> +
> +static void loongarch_avec_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    LoongArchAVECClass *lac = LOONGARCH_AVEC_CLASS(klass);
> +
> +    dc->unrealize = loongarch_avec_unrealize;
> +    device_class_set_parent_realize(dc, loongarch_avec_realize,
> +                                    &lac->parent_realize);
> +}
> +
> +static const TypeInfo loongarch_avec_info = {
> +    .name          = TYPE_LOONGARCH_AVEC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(LoongArchAVECState),
> +    .instance_init = loongarch_avec_init,
> +    .class_init    = loongarch_avec_class_init,
> +};
> +
> +static void loongarch_avec_register_types(void)
> +{
> +    type_register_static(&loongarch_avec_info);
> +}
> +
> +type_init(loongarch_avec_register_types)
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 3137521a4a..cf2c47cd53 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -80,3 +80,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_
>   specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
>   specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
>                  if_true: files('loongarch_extioi_kvm.c'))
> +specific_ss.add(when: 'CONFIG_LOONGARCH_AVEC', if_true: files('loongarch_avec.c'))
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index bb2838b7b5..1bf240b1e2 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -15,6 +15,7 @@ config LOONGARCH_VIRT
>       select LOONGARCH_PCH_PIC
>       select LOONGARCH_PCH_MSI
>       select LOONGARCH_EXTIOI
> +    select LOONGARCH_AVEC
>       select LS7A_RTC
>       select SMBIOS
>       select ACPI_CPU_HOTPLUG
> diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
> new file mode 100644
> index 0000000000..92e2ca9590
> --- /dev/null
> +++ b/include/hw/intc/loongarch_avec.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * LoongArch  Advance interrupt controller definitions
> + *
> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> + */
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "hw/loongarch/virt.h"
> +
> +
> +#define NR_VECTORS     256
> +
> +#define TYPE_LOONGARCH_AVEC "loongarch_avec"
> +OBJECT_DECLARE_TYPE(LoongArchAVECState, LoongArchAVECClass, LOONGARCH_AVEC)
> +
> +typedef struct AVECCore {
> +    CPUState *cpu;
> +    qemu_irq parent_irq;
> +    uint64_t arch_id;
> +} AVECCore;
> +
> +struct LoongArchAVECState {
> +    SysBusDevice parent_obj;
> +    AVECCore *cpu;
> +    uint32_t num_cpu;
> +};
> +
> +struct LoongArchAVECClass {
> +    SysBusDeviceClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +    DeviceUnrealize parent_unrealize;
> +};
> 


