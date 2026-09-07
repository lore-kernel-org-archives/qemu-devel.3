Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEDDC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3W48-0001Oj-5C; Mon, 07 Sep 2026 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x3W44-0001O3-8o
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:55:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x3W42-0006Dq-8F
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:55:00 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8Axj9HuiZ5q2WkJAA--.27297S3;
 Mon, 07 Sep 2026 17:54:54 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJDxBc3uiZ5qbHkcAA--.33134S2;
 Mon, 07 Sep 2026 17:54:54 +0800 (CST)
Subject: Re: [PATCH 3/3] hw/intc/loongarch_extioi: Add extioi interrupt status
 display
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260827075310.1389232-1-maobibo@loongson.cn>
 <20260827075310.1389232-4-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <46594048-28ea-88ad-19fb-130a67d628c2@loongson.cn>
Date: Mon, 7 Sep 2026 17:53:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260827075310.1389232-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxBc3uiZ5qbHkcAA--.33134S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4DCFWUKry5AFW3GrW5twc_yoWrJFWkpF
 45uF13Wr4UGanxJr9xWa1UZF1rtr4fuw1aqF9Fv348uFW8Gr1Dua4vvrZrXFW8Cw4kK3Wv
 9wn5trWY9F4DArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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


> When irqchip in kernel is enabled, the register status of extioi irqchip
> is in KVM kernel. Here add interrupt status display in user side in order
> to debug extioi irqchip driver.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_extioi.c | 58 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index 2999740269..06f2aa7b14 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -10,6 +10,7 @@
>   #include "qemu/log.h"
>   #include "qapi/error.h"
>   #include "hw/core/irq.h"
> +#include "hw/intc/intc.h"
>   #include "hw/loongarch/virt.h"
>   #include "system/address-spaces.h"
>   #include "system/kvm.h"
> @@ -420,11 +421,63 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> +static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
> +                                        GString *buf)
> +{
> +    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
> +    uint64_t *val;
> +    unsigned long irq;
> +    ExtIOICore *core;
> +    int i;
> +
> +    vmstate_extioi_pre_save(s);
> +    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
> +
> +    val = (uint64_t *)s->isr;
> +    g_string_append_printf(buf, "  ISR     0x%016"PRIx64" 0x%016"PRIx64
> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                *val, *(val + 1), *(val + 2), *(val + 3));
> +    val = (uint64_t *)s->enable;
> +    g_string_append_printf(buf, "  ENABLE  0x%016"PRIx64" 0x%016"PRIx64
> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                *val, *(val + 1), *(val + 2), *(val + 3));
> +    val = (uint64_t *)s->ipmap;
> +    g_string_append_printf(buf, "  IPMAP   0x%016"PRIx64"\n", *val);
> +
> +    val = (uint64_t *)s->coremap;
> +    for (i = 0; i < EXTIOI_IRQS; i += 32) {
> +        g_string_append_printf(buf, "  COREMAP 0x%016"PRIx64" 0x%016"PRIx64
> +                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                    *val, *(val + 1), *(val + 2), *(val + 3));
> +        val += 4;
> +    }
> +
> +    core = s->cpu;
> +    for (i = 0; i < s->num_cpu; i++, core++) {
> +        if (!core->cpu) {
> +            continue;
> +        }
> +
> +        irq = find_first_bit((unsigned long *)core->coreisr, EXTIOI_IRQS);
> +        /* No pending IRQ */
> +        if (irq == EXTIOI_IRQS) {
> +            continue;
> +        }
> +
> +        val = (uint64_t *)core->coreisr;
> +        g_string_append_printf(buf, "  CPU[%d] ISR 0x%016"PRIx64" 0x%016"PRIx64
> +                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                    i, *val, *(val + 1), *(val + 2),
> +                                    *(val + 3));
> +    }
> +}
> +
>   static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
>       LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
> +    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       device_class_set_parent_realize(dc, loongarch_extioi_realize,
> @@ -433,6 +486,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
>                                          NULL, &lec->parent_phases);
>       lecc->pre_save  = vmstate_extioi_pre_save;
>       lecc->post_load = vmstate_extioi_post_load;
> +    ic->print_info = loongarch_extioi_print_info;
>   }
>   
>   static const TypeInfo loongarch_extioi_types[] = {
> @@ -442,6 +496,10 @@ static const TypeInfo loongarch_extioi_types[] = {
>           .instance_size = sizeof(LoongArchExtIOIState),
>           .class_size    = sizeof(LoongArchExtIOIClass),
>           .class_init    = loongarch_extioi_class_init,
> +        .interfaces         = (const InterfaceInfo[]) {
> +            { TYPE_INTERRUPT_STATS_PROVIDER },
> +            { }
> +        },
>       }
>   };
>   
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>


