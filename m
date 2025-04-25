Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED74C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Dmf-0006AS-MT; Fri, 25 Apr 2025 03:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u8DmZ-00069T-PI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:47:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u8DmW-0004g3-AD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:47:35 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxHHINPgtox+nFAA--.460S3;
 Fri, 25 Apr 2025 15:47:26 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxLcUKPgtots2UAA--.40769S3;
 Fri, 25 Apr 2025 15:47:24 +0800 (CST)
Subject: Re: [PATCH v2 01/16] hw/intc/loongarch_pch: Modify name of some
 registers
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <aed3b063-41a2-4b57-8bb8-654f52b00a66@loongson.cn>
Date: Fri, 25 Apr 2025 15:50:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxLcUKPgtots2UAA--.40769S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw1kKFyDtF43CrWDtr13trc_yoWxCr4Upr
 W5AFW2yF4DJFW7GF4xZw15A3ZrJFn7Ar9IgwsIgFy8AF1rJ34kuFyDXwn7KF1UK3yUJry5
 WFsxua9I9FsrtrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.215, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
> For some registers with width 8 bytes, its name is something like
> PCH_PIC_INT_ID_LO and PCH_PIC_INT_ID_HI. From hardware manual,
> register name is PCH_PIC_INT_ID instead. Here name PCH_PIC_INT_ID
> is used, and PCH_PIC_INT_ID + 4 is used for PCH_PIC_INT_ID_HI.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c            | 50 +++++++++++++-------------
>   hw/loongarch/virt.c                    |  2 +-
>   include/hw/intc/loongarch_pic_common.h | 27 +++++---------
>   3 files changed, 36 insertions(+), 43 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index acd75ccb0c..2b90ccd1ff 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -79,10 +79,10 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>       uint32_t offset = addr & 0xfff;
>   
>       switch (offset) {
> -    case PCH_PIC_INT_ID_LO:
> +    case PCH_PIC_INT_ID:
>           val = PCH_PIC_INT_ID_VAL;
>           break;
> -    case PCH_PIC_INT_ID_HI:
> +    case PCH_PIC_INT_ID + 4:
>           /*
>            * With 7A1000 manual
>            *   bit  0-15 pch irqchip version
> @@ -90,28 +90,29 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>            */
>           val = deposit32(PCH_PIC_INT_ID_VER, 16, 16, s->irq_num - 1);
>           break;
> -    case PCH_PIC_INT_MASK_LO:
> +    case PCH_PIC_INT_MASK:
>           val = (uint32_t)s->int_mask;
>           break;
> -    case PCH_PIC_INT_MASK_HI:
> +    case PCH_PIC_INT_MASK + 4:
>           val = s->int_mask >> 32;
>           break;
> -    case PCH_PIC_INT_EDGE_LO:
> +    case PCH_PIC_INT_EDGE:
>           val = (uint32_t)s->intedge;
>           break;
> -    case PCH_PIC_INT_EDGE_HI:
> +    case PCH_PIC_INT_EDGE + 4:
>           val = s->intedge >> 32;
>           break;
> -    case PCH_PIC_HTMSI_EN_LO:
> +    case PCH_PIC_HTMSI_EN:
>           val = (uint32_t)s->htmsi_en;
>           break;
> -    case PCH_PIC_HTMSI_EN_HI:
> +    case PCH_PIC_HTMSI_EN + 4:
>           val = s->htmsi_en >> 32;
>           break;
> -    case PCH_PIC_AUTO_CTRL0_LO:
> -    case PCH_PIC_AUTO_CTRL0_HI:
> -    case PCH_PIC_AUTO_CTRL1_LO:
> -    case PCH_PIC_AUTO_CTRL1_HI:
> +    case PCH_PIC_AUTO_CTRL0:
> +    case PCH_PIC_AUTO_CTRL0 + 4:
> +    case PCH_PIC_AUTO_CTRL1:
> +    case PCH_PIC_AUTO_CTRL1 + 4:
> +        /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
>           break;
>       default:
>           break;
> @@ -140,7 +141,7 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>       trace_loongarch_pch_pic_low_writew(size, addr, data);
>   
>       switch (offset) {
> -    case PCH_PIC_INT_MASK_LO:
> +    case PCH_PIC_INT_MASK:
>           old = s->int_mask;
>           s->int_mask = get_writew_val(old, data, 0);
>           old_valid = (uint32_t)old;
> @@ -151,7 +152,7 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>               pch_pic_update_irq(s, (~old_valid & data), 0);
>           }
>           break;
> -    case PCH_PIC_INT_MASK_HI:
> +    case PCH_PIC_INT_MASK + 4:
>           old = s->int_mask;
>           s->int_mask = get_writew_val(old, data, 1);
>           old_valid = (uint32_t)(old >> 32);
> @@ -164,20 +165,20 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>               pch_pic_update_irq(s, int_mask << 32, 0);
>           }
>           break;
> -    case PCH_PIC_INT_EDGE_LO:
> +    case PCH_PIC_INT_EDGE:
>           s->intedge = get_writew_val(s->intedge, data, 0);
>           break;
> -    case PCH_PIC_INT_EDGE_HI:
> +    case PCH_PIC_INT_EDGE + 4:
>           s->intedge = get_writew_val(s->intedge, data, 1);
>           break;
> -    case PCH_PIC_INT_CLEAR_LO:
> +    case PCH_PIC_INT_CLEAR:
>           if (s->intedge & data) {
>               s->intirr &= (~data);
>               pch_pic_update_irq(s, data, 0);
>               s->intisr &= (~data);
>           }
>           break;
> -    case PCH_PIC_INT_CLEAR_HI:
> +    case PCH_PIC_INT_CLEAR + 4:
>           value <<= 32;
>           if (s->intedge & value) {
>               s->intirr &= (~value);
> @@ -185,16 +186,17 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>               s->intisr &= (~value);
>           }
>           break;
> -    case PCH_PIC_HTMSI_EN_LO:
> +    case PCH_PIC_HTMSI_EN:
>           s->htmsi_en = get_writew_val(s->htmsi_en, data, 0);
>           break;
> -    case PCH_PIC_HTMSI_EN_HI:
> +    case PCH_PIC_HTMSI_EN + 4:
>           s->htmsi_en = get_writew_val(s->htmsi_en, data, 1);
>           break;
> -    case PCH_PIC_AUTO_CTRL0_LO:
> -    case PCH_PIC_AUTO_CTRL0_HI:
> -    case PCH_PIC_AUTO_CTRL1_LO:
> -    case PCH_PIC_AUTO_CTRL1_HI:
> +    case PCH_PIC_AUTO_CTRL0:
> +    case PCH_PIC_AUTO_CTRL0 + 4:
> +    case PCH_PIC_AUTO_CTRL1:
> +    case PCH_PIC_AUTO_CTRL1 + 4:
> +        /* discard auto_ctrl access */
>           break;
>       default:
>           break;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e25864214f..8c0cc98c72 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -432,7 +432,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>                               VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY_OFFSET,
>                               sysbus_mmio_get_region(d, 1));
>       memory_region_add_subregion(get_system_memory(),
> -                            VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS_LO,
> +                            VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS,
>                               sysbus_mmio_get_region(d, 2));
>   
>       /* Connect pch_pic irqs to extioi */
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index 43cce48978..c04471b08d 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -12,28 +12,19 @@
>   
>   #define PCH_PIC_INT_ID_VAL              0x7000000UL
>   #define PCH_PIC_INT_ID_VER              0x1UL
> -#define PCH_PIC_INT_ID_LO               0x00
> -#define PCH_PIC_INT_ID_HI               0x04
> -#define PCH_PIC_INT_MASK_LO             0x20
> -#define PCH_PIC_INT_MASK_HI             0x24
> -#define PCH_PIC_HTMSI_EN_LO             0x40
> -#define PCH_PIC_HTMSI_EN_HI             0x44
> -#define PCH_PIC_INT_EDGE_LO             0x60
> -#define PCH_PIC_INT_EDGE_HI             0x64
> -#define PCH_PIC_INT_CLEAR_LO            0x80
> -#define PCH_PIC_INT_CLEAR_HI            0x84
> -#define PCH_PIC_AUTO_CTRL0_LO           0xc0
> -#define PCH_PIC_AUTO_CTRL0_HI           0xc4
> -#define PCH_PIC_AUTO_CTRL1_LO           0xe0
> -#define PCH_PIC_AUTO_CTRL1_HI           0xe4
> +#define PCH_PIC_INT_ID                  0x00
> +#define PCH_PIC_INT_MASK                0x20
> +#define PCH_PIC_HTMSI_EN                0x40
> +#define PCH_PIC_INT_EDGE                0x60
> +#define PCH_PIC_INT_CLEAR               0x80
> +#define PCH_PIC_AUTO_CTRL0              0xc0
> +#define PCH_PIC_AUTO_CTRL1              0xe0
>   #define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
>   #define PCH_PIC_ROUTE_ENTRY_END         0x13f
>   #define PCH_PIC_HTMSI_VEC_OFFSET        0x200
>   #define PCH_PIC_HTMSI_VEC_END           0x23f
> -#define PCH_PIC_INT_STATUS_LO           0x3a0
> -#define PCH_PIC_INT_STATUS_HI           0x3a4
> -#define PCH_PIC_INT_POL_LO              0x3e0
> -#define PCH_PIC_INT_POL_HI              0x3e4
> +#define PCH_PIC_INT_STATUS              0x3a0
> +#define PCH_PIC_INT_POL                 0x3e0
>   
>   #define STATUS_LO_START                 0
>   #define STATUS_HI_START                 0x4


