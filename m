Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D7C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 03:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujmg-00009g-Pt; Tue, 18 Mar 2025 23:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tujmf-000090-53
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tujmd-0003rs-8z
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:56 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax3eIJNdpnJI+cAA--.28855S3;
 Wed, 19 Mar 2025 11:07:53 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzMQINdpnnu1SAA--.41517S3;
 Wed, 19 Mar 2025 11:07:53 +0800 (CST)
Subject: Re: [PATCH 1/5] hw/intc/loongarch_ipi: Add reset support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250307071346.2260062-1-maobibo@loongson.cn>
 <20250307071346.2260062-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <15f802ae-38a8-af5c-25a9-72bd60de23cf@loongson.cn>
Date: Wed, 19 Mar 2025 11:10:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250307071346.2260062-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzMQINdpnnu1SAA--.41517S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4fCrWfZFyrCFWkuFW8KrX_yoW5GFWDpF
 W7Z3WFkr48Ar9rArsxXas8XFs8WFn3uF12vF4SgryrCFs8Xryjqw10kF9xXFy8C3y5AFWY
 q3Z3K3WjgF47JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUU
 UUU==
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
> Add reset support with ipi object, register reset callback and clear
> internal registers when virt machine resets.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_ipi.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/intc/loongarch_ipi.h |  1 +
>   2 files changed, 30 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index b10641dd03..f12c0549f3 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -93,6 +93,32 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void loongarch_ipi_reset_hold(Object *obj, ResetType type)
> +{
> +    int i;
> +    LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(obj);
> +    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(obj);
> +    IPICore *core;
> +
> +    if (lic->parent_phases.hold) {
> +        lic->parent_phases.hold(obj, type);
> +    }
> +
> +    for (i = 0; i < lics->num_cpu; i++) {
> +        core = lics->cpu + i;
> +        /* IPI with targeted CPU available however not present */
> +        if (!core->cpu) {
> +            continue;
> +        }
> +
> +        core->status = 0;
> +        core->en = 0;
> +        core->set = 0;
> +        core->clear = 0;
> +        memset(core->buf, 0, sizeof(core->buf));
> +    }
> +}
> +
>   static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>   {
> @@ -145,10 +171,13 @@ static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
>       LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>       LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       device_class_set_parent_realize(dc, loongarch_ipi_realize,
>                                       &lic->parent_realize);
> +    resettable_class_set_parent_phases(rc, NULL, loongarch_ipi_reset_hold,
> +                                       NULL, &lic->parent_phases);
>       licc->get_iocsr_as = get_iocsr_as;
>       licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
>       hc->plug = loongarch_ipi_cpu_plug;
> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
> index 923bf21ecb..a7c6bf85d3 100644
> --- a/include/hw/intc/loongarch_ipi.h
> +++ b/include/hw/intc/loongarch_ipi.h
> @@ -21,6 +21,7 @@ struct LoongarchIPIState {
>   struct LoongarchIPIClass {
>       LoongsonIPICommonClass parent_class;
>       DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
>   };
>   
>   #endif


