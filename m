Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED33EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EQb-0005SA-WE; Fri, 25 Apr 2025 04:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u8EQY-0005Qc-St
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:28:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u8EQW-0000si-1O
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:28:54 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxG6y5RwtoP_DFAA--.33604S3;
 Fri, 25 Apr 2025 16:28:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxu2RwtoedqUAA--.58220S3;
 Fri, 25 Apr 2025 16:28:41 +0800 (CST)
Subject: Re: [PATCH v2 03/16] hw/intc/loongarch_pch: Remove some duplicate
 macro
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6831bc3e-b681-00a8-18b4-6903d5faffa5@loongson.cn>
Date: Fri, 25 Apr 2025 16:31:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxu2RwtoedqUAA--.58220S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr48Zryrtw4DKryUur4UGFX_yoW5Aw18pF
 ZxAFWagF4DGry7XFn2ya45Zrn7J3ZrWr9F9anIkryrGrs8X34xWF1kJ3yagF1UK3y3Jryv
 gFsxua4a9F4UXFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
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
> The meaning of macro definition STATUS_LO_START is simliar with
> PCH_PIC_INT_STATUS, only that offset is different, the same for
> macro POL_LO_START. Now remove these duplicated macro definitions.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c            | 20 ++++++++++----------
>   include/hw/intc/loongarch_pic_common.h |  5 -----
>   2 files changed, 10 insertions(+), 15 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 4c845ba5e9..a2d9930ac9 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -208,19 +208,19 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = addr & 0xfff;
> +    uint32_t offset = addr + PCH_PIC_INT_STATUS;
>   
>       switch (offset) {
> -    case STATUS_LO_START:
> +    case PCH_PIC_INT_STATUS:
>           val = (uint32_t)(s->intisr & (~s->int_mask));
>           break;
> -    case STATUS_HI_START:
> +    case PCH_PIC_INT_STATUS + 4:
>           val = (s->intisr & (~s->int_mask)) >> 32;
>           break;
> -    case POL_LO_START:
> +    case PCH_PIC_INT_POL:
>           val = (uint32_t)s->int_polarity;
>           break;
> -    case POL_HI_START:
> +    case PCH_PIC_INT_POL + 4:
>           val = s->int_polarity >> 32;
>           break;
>       default:
> @@ -236,21 +236,21 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint32_t offset, data = (uint32_t)value;
> -    offset = addr & 0xfff;
> +    offset = addr + PCH_PIC_INT_STATUS;
>   
>       trace_loongarch_pch_pic_high_writew(size, addr, data);
>   
>       switch (offset) {
> -    case STATUS_LO_START:
> +    case PCH_PIC_INT_STATUS:
>           s->intisr = get_writew_val(s->intisr, data, 0);
>           break;
> -    case STATUS_HI_START:
> +    case PCH_PIC_INT_STATUS + 4:
>           s->intisr = get_writew_val(s->intisr, data, 1);
>           break;
> -    case POL_LO_START:
> +    case PCH_PIC_INT_POL:
>           s->int_polarity = get_writew_val(s->int_polarity, data, 0);
>           break;
> -    case POL_HI_START:
> +    case PCH_PIC_INT_POL + 4:
>           s->int_polarity = get_writew_val(s->int_polarity, data, 1);
>           break;
>       default:
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index b33bebb129..ef6edc15bf 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -26,11 +26,6 @@
>   #define PCH_PIC_INT_STATUS              0x3a0
>   #define PCH_PIC_INT_POL                 0x3e0
>   
> -#define STATUS_LO_START                 0
> -#define STATUS_HI_START                 0x4
> -#define POL_LO_START                    0x40
> -#define POL_HI_START                    0x44
> -
>   #define TYPE_LOONGARCH_PIC_COMMON "loongarch_pic_common"
>   OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
>                       LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)


