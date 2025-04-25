Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF90C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8DwY-0001bb-K8; Fri, 25 Apr 2025 03:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u8DwV-0001aj-CP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u8DwS-0005sR-Hz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:57:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxGHF0QAtoaOvFAA--.2255S3;
 Fri, 25 Apr 2025 15:57:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxPsdxQAtoANGUAA--.47085S3;
 Fri, 25 Apr 2025 15:57:39 +0800 (CST)
Subject: Re: [PATCH v2 02/16] hw/intc/loongarch_pch: Modify register name
 PCH_PIC_xxx_OFFSET with PCH_PIC_xxx
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e157eb7c-7e95-9984-51ae-33bdcbb267be@loongson.cn>
Date: Fri, 25 Apr 2025 16:00:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxPsdxQAtoANGUAA--.47085S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4DCr17Zw1DAr1UGry8WFX_yoWrAw43pF
 9xAFy2vr47tFZ7Wrn7J3yDZw1xWFn2k342g39I9FyxArW5XryDXa4jy34DKa4UK34kA3yr
 XFsxGw4Y9a9rXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
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
> Macro PCH_PIC_HTMSI_VEC_OFFSET and PCH_PIC_ROUTE_ENTRY_OFFSET is renamed
> as PCH_PIC_HTMSI_VEC and PCH_PIC_ROUTE_ENTRY separately, it is easier to
> understand.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c            | 20 ++++++++++----------
>   hw/loongarch/virt.c                    |  2 +-
>   include/hw/intc/loongarch_pic_common.h |  4 ++--
>   3 files changed, 13 insertions(+), 13 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 2b90ccd1ff..4c845ba5e9 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -263,18 +263,18 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
> +    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
>       int64_t offset_tmp;
>   
>       switch (offset) {
> -    case PCH_PIC_HTMSI_VEC_OFFSET ... PCH_PIC_HTMSI_VEC_END:
> -        offset_tmp = offset - PCH_PIC_HTMSI_VEC_OFFSET;
> +    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> +        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               val = s->htmsi_vector[offset_tmp];
>           }
>           break;
> -    case PCH_PIC_ROUTE_ENTRY_OFFSET ... PCH_PIC_ROUTE_ENTRY_END:
> -        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY_OFFSET;
> +    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> +        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               val = s->route_entry[offset_tmp];
>           }
> @@ -292,19 +292,19 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       int32_t offset_tmp;
> -    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
> +    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
>   
>       trace_loongarch_pch_pic_writeb(size, addr, data);
>   
>       switch (offset) {
> -    case PCH_PIC_HTMSI_VEC_OFFSET ... PCH_PIC_HTMSI_VEC_END:
> -        offset_tmp = offset - PCH_PIC_HTMSI_VEC_OFFSET;
> +    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> +        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               s->htmsi_vector[offset_tmp] = (uint8_t)(data & 0xff);
>           }
>           break;
> -    case PCH_PIC_ROUTE_ENTRY_OFFSET ... PCH_PIC_ROUTE_ENTRY_END:
> -        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY_OFFSET;
> +    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> +        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               s->route_entry[offset_tmp] = (uint8_t)(data & 0xff);
>           }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 8c0cc98c72..1f1cca667e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -429,7 +429,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>       memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
>                               sysbus_mmio_get_region(d, 0));
>       memory_region_add_subregion(get_system_memory(),
> -                            VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY_OFFSET,
> +                            VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY,
>                               sysbus_mmio_get_region(d, 1));
>       memory_region_add_subregion(get_system_memory(),
>                               VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS,
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index c04471b08d..b33bebb129 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -19,9 +19,9 @@
>   #define PCH_PIC_INT_CLEAR               0x80
>   #define PCH_PIC_AUTO_CTRL0              0xc0
>   #define PCH_PIC_AUTO_CTRL1              0xe0
> -#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
> +#define PCH_PIC_ROUTE_ENTRY             0x100
>   #define PCH_PIC_ROUTE_ENTRY_END         0x13f
> -#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
> +#define PCH_PIC_HTMSI_VEC               0x200
>   #define PCH_PIC_HTMSI_VEC_END           0x23f
>   #define PCH_PIC_INT_STATUS              0x3a0
>   #define PCH_PIC_INT_POL                 0x3e0


