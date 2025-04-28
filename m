Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71F1C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F8G-000730-29; Sun, 27 Apr 2025 23:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9F8D-0006zl-7Y
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:26:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9F8B-0006lg-1W
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:26:08 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxvnJK9Q5oIvXHAA--.4134S3;
 Mon, 28 Apr 2025 11:26:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxXsVG9Q5ow2CaAA--.59162S3;
 Mon, 28 Apr 2025 11:25:59 +0800 (CST)
Subject: Re: [PATCH v2 14/16] hw/intc/loongarch_pch: Rename memory region
 iomem32_low with iomem
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-15-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <07914af2-5b8b-bb7e-330a-61384ff4d6a6@loongson.cn>
Date: Mon, 28 Apr 2025 11:28:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-15-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxXsVG9Q5ow2CaAA--.59162S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4fuw1rtFW8XrW7Jr4xuFX_yoW5tr1fpr
 ZrZFnIgF4kJFnrZFykZ345XFn7Jrn2934I9FnIkryxCrnrArn0gF1kJr9FgFyjk3yDGryj
 qFWrGa4Yqa1DGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.279, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/3/24 ÏÂÎç5:37, Bibo Mao Ð´µÀ:
> Rename memory region iomem32_low with iomem, also change ops name
> as follows:
>    loongarch_pch_pic_reg32_low_ops  --> loongarch_pch_pic_ops
>    loongarch_pch_pic_low_readw      --> loongarch_pch_pic_read
>    loongarch_pch_pic_low_writew     --> loongarch_pch_pic_write
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c            | 26 +++++++-------------------
>   include/hw/intc/loongarch_pic_common.h |  2 +-
>   2 files changed, 8 insertions(+), 20 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks,
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index ff1e5992bd..db0d8ce7ac 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -230,18 +230,6 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
>       }
>   }
>   
> -static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
> -                                            unsigned size)
> -{
> -    return loongarch_pch_pic_read(opaque, addr, size);
> -}
> -
> -static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
> -                                         uint64_t value, unsigned size)
> -{
> -    loongarch_pch_pic_write(opaque, addr, value, size);
> -}
> -
>   static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
>                                           unsigned size)
>   {
> @@ -270,9 +258,9 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
>       loongarch_pch_pic_write(opaque, addr, data, size);
>   }
>   
> -static const MemoryRegionOps loongarch_pch_pic_reg32_low_ops = {
> -    .read = loongarch_pch_pic_low_readw,
> -    .write = loongarch_pch_pic_low_writew,
> +static const MemoryRegionOps loongarch_pch_pic_ops = {
> +    .read = loongarch_pch_pic_read,
> +    .write = loongarch_pch_pic_write,
>       .valid = {
>           .min_access_size = 4,
>           .max_access_size = 8,
> @@ -356,15 +344,15 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
>   
>       qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
>       qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
> -    memory_region_init_io(&s->iomem32_low, OBJECT(dev),
> -                          &loongarch_pch_pic_reg32_low_ops,
> -                          s, PCH_PIC_NAME(.reg32_part1), 0x100);
> +    memory_region_init_io(&s->iomem, OBJECT(dev),
> +                          &loongarch_pch_pic_ops,
> +                          s, TYPE_LOONGARCH_PIC, 0x100);
>       memory_region_init_io(&s->iomem8, OBJECT(dev), &loongarch_pch_pic_reg8_ops,
>                             s, PCH_PIC_NAME(.reg8), 0x2a0);
>       memory_region_init_io(&s->iomem32_high, OBJECT(dev),
>                             &loongarch_pch_pic_reg32_high_ops,
>                             s, PCH_PIC_NAME(.reg32_part2), 0xc60);
> -    sysbus_init_mmio(sbd, &s->iomem32_low);
> +    sysbus_init_mmio(sbd, &s->iomem);
>       sysbus_init_mmio(sbd, &s->iomem8);
>       sysbus_init_mmio(sbd, &s->iomem32_high);
>   
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index fb848da4b8..ab8ffff780 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -65,7 +65,7 @@ struct LoongArchPICCommonState {
>       uint8_t route_entry[64];  /* 0x100 - 0x138 */
>       uint8_t htmsi_vector[64]; /* 0x200 - 0x238 */
>   
> -    MemoryRegion iomem32_low;
> +    MemoryRegion iomem;
>       MemoryRegion iomem32_high;
>       MemoryRegion iomem8;
>       unsigned int irq_num;


