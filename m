Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EEEC369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9EvC-0008Ul-D1; Sun, 27 Apr 2025 23:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9Ev4-0008UX-HJ
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:12:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9Ev1-0005F4-Ng
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:12:34 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx12kU8g5or_LHAA--.3603S3;
 Mon, 28 Apr 2025 11:12:20 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxbsUS8g5oclmaAA--.62031S3;
 Mon, 28 Apr 2025 11:12:20 +0800 (CST)
Subject: Re: [PATCH v2 05/16] hw/intc/loongarch_pch: Use relative address in
 MemoryRegionOps
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-6-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <44555821-5129-849e-ebed-fce807d86166@loongson.cn>
Date: Mon, 28 Apr 2025 11:14:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxbsUS8g5oclmaAA--.62031S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1UJFW8ArWUGryxJF1kWFX_yoWrCrW7pr
 ZIyFy7KFW7tanFgFsrA34DZas7W3Z7G342g390ka4FkrWDZrykXa4DA34DK3Wjk347ArWr
 XFs8Gw1a9a9rXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
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
> Parameter address for read and write callback in MemoryRegionOps is
> relative offset with base address of this MemoryRegionOps. It can
> be directly used as offset and offset calculation can be removed.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 7043b8b9f4..93f7ceb6b9 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -76,9 +76,8 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = addr & 0xfff;
>   
> -    switch (offset) {
> +    switch (addr) {
>       case PCH_PIC_INT_ID:
>           val = s->id.data & UINT_MAX;
>           break;
> @@ -129,13 +128,12 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>                                            uint64_t value, unsigned size)
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> -    uint32_t offset, old_valid, data = (uint32_t)value;
> +    uint32_t old_valid, data = (uint32_t)value;
>       uint64_t old, int_mask;
> -    offset = addr & 0xfff;
>   
>       trace_loongarch_pch_pic_low_writew(size, addr, data);
>   
> -    switch (offset) {
> +    switch (addr) {
>       case PCH_PIC_INT_MASK:
>           old = s->int_mask;
>           s->int_mask = get_writew_val(old, data, 0);
> @@ -203,9 +201,9 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = addr + PCH_PIC_INT_STATUS;
>   
> -    switch (offset) {
> +    addr += PCH_PIC_INT_STATUS;
> +    switch (addr) {
>       case PCH_PIC_INT_STATUS:
>           val = (uint32_t)(s->intisr & (~s->int_mask));
>           break;
> @@ -230,12 +228,12 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
>                                        uint64_t value, unsigned size)
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> -    uint32_t offset, data = (uint32_t)value;
> -    offset = addr + PCH_PIC_INT_STATUS;
> +    uint32_t data = (uint32_t)value;
>   
> +    addr += PCH_PIC_INT_STATUS;
>       trace_loongarch_pch_pic_high_writew(size, addr, data);
>   
> -    switch (offset) {
> +    switch (addr) {
>       case PCH_PIC_INT_STATUS:
>           s->intisr = get_writew_val(s->intisr, data, 0);
>           break;
> @@ -258,18 +256,18 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
>       int64_t offset_tmp;
>   
> -    switch (offset) {
> +    addr += PCH_PIC_ROUTE_ENTRY;
> +    switch (addr) {
>       case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> -        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
> +        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               val = s->htmsi_vector[offset_tmp];
>           }
>           break;
>       case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> -        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
> +        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               val = s->route_entry[offset_tmp];
>           }
> @@ -287,19 +285,19 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       int32_t offset_tmp;
> -    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
>   
> +    addr += PCH_PIC_ROUTE_ENTRY;
>       trace_loongarch_pch_pic_writeb(size, addr, data);
>   
> -    switch (offset) {
> +    switch (addr) {
>       case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> -        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
> +        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               s->htmsi_vector[offset_tmp] = (uint8_t)(data & 0xff);
>           }
>           break;
>       case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> -        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
> +        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
>           if (offset_tmp >= 0 && offset_tmp < 64) {
>               s->route_entry[offset_tmp] = (uint8_t)(data & 0xff);
>           }


