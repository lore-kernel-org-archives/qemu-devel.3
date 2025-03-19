Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FAFC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 03:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujmU-00005q-0j; Tue, 18 Mar 2025 23:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tujmR-00005Y-5L
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tujmO-0003pm-E1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxaeD1NNpnGI+cAA--.4061S3;
 Wed, 19 Mar 2025 11:07:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxLcXyNNpni+1SAA--.39626S3;
 Wed, 19 Mar 2025 11:07:32 +0800 (CST)
Subject: Re: [PATCH 5/5] hw/intc/loongarch_pch: Replace legacy reset callback
 with new api
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250307071346.2260062-1-maobibo@loongson.cn>
 <20250307071346.2260062-6-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f3dae409-73f8-2f3f-d604-b55e09250515@loongson.cn>
Date: Wed, 19 Mar 2025 11:09:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250307071346.2260062-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxLcXyNNpni+1SAA--.39626S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr48tr4ftFW5uw4fuF4rWFX_yoW5Xw1kpF
 ZrZF1SyF4UJr1DXrs3XasxZF1xWFs3ur129F1ak348CrsxJryrXw1DGry7XFWjk398Jryj
 qrZ3Kw1Yv3WUJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.526, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/3/7 ÏÂÎç3:13, Bibo Mao Ð´µÀ:
> Replace legacy reset callback register device_class_set_legacy_reset()
> with new function resettable_class_set_parent_phases(). With new API,
> it will call reset callback of parent object.
>
> The internal state has been cleared in parent object
> LOONGARCH_PIC_COMMON, here parent_phases.hold() is directly called.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c         | 26 ++++++++------------------
>   include/hw/intc/loongarch_pch_pic.h |  1 +
>   2 files changed, 9 insertions(+), 18 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index acd75ccb0c..32b7275996 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -354,25 +354,13 @@ static const MemoryRegionOps loongarch_pch_pic_reg8_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -static void loongarch_pch_pic_reset(DeviceState *d)
> +static void loongarch_pic_reset_hold(Object *obj, ResetType type)
>   {
> -    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(d);
> -    int i;
> -
> -    s->int_mask = -1;
> -    s->htmsi_en = 0x0;
> -    s->intedge  = 0x0;
> -    s->intclr   = 0x0;
> -    s->auto_crtl0 = 0x0;
> -    s->auto_crtl1 = 0x0;
> -    for (i = 0; i < 64; i++) {
> -        s->route_entry[i] = 0x1;
> -        s->htmsi_vector[i] = 0x0;
> +    LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(obj);
> +
> +    if (lpc->parent_phases.hold) {
> +        lpc->parent_phases.hold(obj, type);
>       }
> -    s->intirr = 0x0;
> -    s->intisr = 0x0;
> -    s->last_intirr = 0x0;
> -    s->int_polarity = 0x0;
>   }
>   
>   static void loongarch_pic_realize(DeviceState *dev, Error **errp)
> @@ -408,8 +396,10 @@ static void loongarch_pic_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
> -    device_class_set_legacy_reset(dc, loongarch_pch_pic_reset);
> +    resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
> +                                       NULL, &lpc->parent_phases);
>       device_class_set_parent_realize(dc, loongarch_pic_realize,
>                                       &lpc->parent_realize);
>   }
> diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
> index 481cc58aed..839a59a43b 100644
> --- a/include/hw/intc/loongarch_pch_pic.h
> +++ b/include/hw/intc/loongarch_pch_pic.h
> @@ -22,6 +22,7 @@ struct LoongarchPICClass {
>       LoongArchPICCommonClass parent_class;
>   
>       DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
>   };
>   
>   #endif /* HW_LOONGARCH_PCH_PIC_H */


