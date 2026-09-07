Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E382BC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3W2x-0000bi-0y; Mon, 07 Sep 2026 05:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x3W2u-0000bB-MH
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:53:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x3W2s-0006BE-2J
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:53:48 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8CxKvCmiZ5qtGkJAA--.26924S3;
 Mon, 07 Sep 2026 17:53:42 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJAxX8+liZ5qP3kcAA--.61014S2;
 Mon, 07 Sep 2026 17:53:41 +0800 (CST)
Subject: Re: [PATCH 1/3] hw/intc/loongarch_ipi: Add ipi interrupt status
 display
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260827075310.1389232-1-maobibo@loongson.cn>
 <20260827075310.1389232-2-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <fd9ee272-bdc0-8f2a-63f3-d2ab1798cfbb@loongson.cn>
Date: Mon, 7 Sep 2026 17:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260827075310.1389232-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxX8+liZ5qP3kcAA--.61014S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFWUCF1Dury8Cr48Gw18tFc_yoW5Ar43pF
 W3uF45Gr48AFsrGrZxXa4aqFn8Gr1xuFy29F4I9348AFWDXrn0qa4IkrZxXFyUCw48G3WY
 qw1fGF1q9a1UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
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


> When irqchip in kernel is enabled, the register status of ipi irqchip is
> in KVM kernel. Here add interrupt status display in user side in order to
> debug irqchip driver.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_ipi.c | 42 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 5d8b8c96df..28d816e3f5 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -9,6 +9,7 @@
>   #include "qemu/error-report.h"
>   #include "hw/core/boards.h"
>   #include "qapi/error.h"
> +#include "hw/intc/intc.h"
>   #include "hw/intc/loongarch_ipi.h"
>   #include "hw/core/qdev-properties.h"
>   #include "system/kvm.h"
> @@ -193,8 +194,47 @@ static int loongarch_ipi_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> +static void loongarch_ipi_print_info(InterruptStatsProvider *obj, GString *buf)
> +{
> +    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(obj);
> +    int i, j;
> +    IPICore *core;
> +    uint64_t mbx;
> +    unsigned long pos;
> +
> +    loongarch_ipi_pre_save(lics);
> +
> +    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
> +    for (i = 0; i < lics->num_cpu; i++) {
> +        core = lics->cpu + i;
> +        /* IPI with targeted CPU available however not present */
> +        if (!core->cpu) {
> +            continue;
> +        }
> +
> +        g_string_append_printf(buf, "  CPU %-3u status=0x%x en=0x%x\n",
> +                                    i, core->status, core->en);
> +
> +        pos = find_first_bit((unsigned long *)core->buf, IPI_MBX_NUM * 64);
> +        /* All zero in mailbox */
> +        if (pos == (IPI_MBX_NUM * 64)) {
> +            continue;
> +        }
> +
> +        for (j = 0; j < IPI_MBX_NUM; j++) {
> +            mbx = *(uint64_t *)&core->buf[2 * j];
> +            if (mbx) {
> +                g_string_append_printf(buf, "  MBX[%-1u] 0x%016"PRIx64, j, mbx);
> +            }
> +        }
> +
> +        g_string_append_c(buf, '\n');
> +    }
> +}
> +
>   static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
>   {
> +    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>       LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>       LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
> @@ -211,6 +251,7 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
>       hc->unplug = loongarch_ipi_cpu_unplug;
>       licc->pre_save = loongarch_ipi_pre_save;
>       licc->post_load = loongarch_ipi_post_load;
> +    ic->print_info = loongarch_ipi_print_info;
>   }
>   
>   static const TypeInfo loongarch_ipi_types[] = {
> @@ -222,6 +263,7 @@ static const TypeInfo loongarch_ipi_types[] = {
>           .class_init         = loongarch_ipi_class_init,
>           .interfaces         = (const InterfaceInfo[]) {
>               { TYPE_HOTPLUG_HANDLER },
> +            { TYPE_INTERRUPT_STATS_PROVIDER },
>               { }
>           },
>       }

Reviewed-by: Xianglai Li<lixianglai@loongson.cn>


