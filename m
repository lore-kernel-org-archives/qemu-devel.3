Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4017AC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3W3a-00013H-Lo; Mon, 07 Sep 2026 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x3W3Y-000138-Jn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:54:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x3W3W-0006Cb-J4
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:54:28 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8DxUNHQiZ5qzWkJAA--.27101S3;
 Mon, 07 Sep 2026 17:54:24 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxf8_PiZ5qXXkcAA--.62145S2;
 Mon, 07 Sep 2026 17:54:24 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/intc/loongarch_pch_pic: Add pic interrupt status
 display
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260827075310.1389232-1-maobibo@loongson.cn>
 <20260827075310.1389232-3-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <6b629875-c187-894d-d3a6-03533cde4363@loongson.cn>
Date: Mon, 7 Sep 2026 17:52:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260827075310.1389232-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxf8_PiZ5qXXkcAA--.62145S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyxKrW5tw15AF4kAw4UWrX_yoW5ZFWDpF
 WDuFnxJr4DKFsrXr93Z345ZF1FqF1xur1Sg3ZxA34xCFZ5Ar1DXa40yrW7uFyUK3ykGr12
 gws5KF1Y9a1DGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
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


> When irqchip in kernel is enabled, the register status of pch_pic irqchip
> is in KVM kernel. Here add interrupt status display in user side in order
> to debug pch_pic irqchip driver.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index e87c7497c1..34090514ec 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -9,6 +9,7 @@
>   #include "qemu/bitops.h"
>   #include "qemu/log.h"
>   #include "hw/core/irq.h"
> +#include "hw/intc/intc.h"
>   #include "hw/intc/loongarch_pch_pic.h"
>   #include "system/kvm.h"
>   #include "trace.h"
> @@ -331,11 +332,43 @@ static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
>       return 0;
>   }
>   
> +static void loongarch_pic_print_info(InterruptStatsProvider *obj, GString *buf)
> +{
> +    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
> +    uint64_t *vector;
> +
> +    loongarch_pic_pre_save(s);
> +    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
> +
> +    g_string_append_printf(buf, "  mask     0x%016"PRIx64" msi_en 0x%016"PRIx64
> +                                " edge 0x%016"PRIx64" clr    0x%016"PRIx64"\n",
> +                                s->int_mask, s->htmsi_en, s->intedge,
> +                                s->intclr);
> +
> +    g_string_append_printf(buf, "  last_irr 0x%016"PRIx64" irr    0x%016"PRIx64
> +                                " isr  0x%016"PRIx64" polary 0x%016"PRIx64"\n",
> +                                s->last_intirr, s->intirr, s->intisr,
> +                                s->int_polarity);
> +
> +    vector = (uint64_t *)s->htmsi_vector;
> +    g_string_append_printf(buf, "  MSI map  0x%016"PRIx64" 0x%016"PRIx64
> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                *vector, *(vector + 1), *(vector + 2),
> +                                *(vector + 3));
> +
> +    vector += 4;
> +    g_string_append_printf(buf, "           0x%016"PRIx64" 0x%016"PRIx64
> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                *vector, *(vector + 1), *(vector + 2),
> +                                *(vector + 3));
> +}
> +
>   static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
>       LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
> +    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
> @@ -344,6 +377,7 @@ static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
>                                       &lpc->parent_realize);
>       lpcc->pre_save = loongarch_pic_pre_save;
>       lpcc->post_load = loongarch_pic_post_load;
> +    ic->print_info = loongarch_pic_print_info;
>   }
>   
>   static const TypeInfo loongarch_pic_types[] = {
> @@ -353,6 +387,10 @@ static const TypeInfo loongarch_pic_types[] = {
>           .instance_size      = sizeof(LoongarchPICState),
>           .class_size         = sizeof(LoongarchPICClass),
>           .class_init         = loongarch_pic_class_init,
> +        .interfaces         = (const InterfaceInfo[]) {
> +            { TYPE_INTERRUPT_STATS_PROVIDER },
> +            { }
> +        },
>       }
>   };
>   

Reviewed-by: Xianglai Li<lixianglai@loongson.cn>


