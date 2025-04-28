Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3339C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F7R-0006Tb-1B; Sun, 27 Apr 2025 23:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9F7P-0006T4-AP
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:25:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9F7M-0006g2-Qs
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:25:18 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxjawY9Q5oEPXHAA--.36292S3;
 Mon, 28 Apr 2025 11:25:12 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBx3MQW9Q5oRWCaAA--.57306S3;
 Mon, 28 Apr 2025 11:25:10 +0800 (CST)
Subject: Re: [PATCH v2 13/16] hw/intc/loongarch_pch: Use unified trace event
 for memory region ops
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-14-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6d720428-deda-a755-8dcf-4ebe6507e8dc@loongson.cn>
Date: Mon, 28 Apr 2025 11:27:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-14-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBx3MQW9Q5oRWCaAA--.57306S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFW7WF43uw1fGryDJrW8uFX_yoWrtFy3pr
 Z3ZrnxtFs5tF1qqrykZw15XF1xJF1Ig34a9asIkryI9w4DZwn8WFykJr97XF4j934DJrWY
 qan5GFyYqa1DWagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 CztUUUUU=
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
> Add trace event trace_loongarch_pch_pic_read(), replaces the following
> three events:
>    trace_loongarch_pch_pic_low_readw()
>    trace_loongarch_pch_pic_high_readw()
>    trace_loongarch_pch_pic_readb()
> The similiar with write trace event.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 24 ++++++------------------
>   hw/intc/trace-events        |  8 ++------
>   2 files changed, 8 insertions(+), 24 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thankss.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index bc4dd697d2..ff1e5992bd 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -200,12 +200,15 @@ static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
>           break;
>       }
>   
> +    trace_loongarch_pch_pic_read(size, addr, val);
>       return val;
>   }
>   
>   static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
>                                       uint64_t value, unsigned size)
>   {
> +    trace_loongarch_pch_pic_write(size, addr, value);
> +
>       switch (size) {
>       case 1:
>           pch_pic_write(opaque, addr, value, 0xFF);
> @@ -230,55 +233,40 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
>   static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>                                               unsigned size)
>   {
> -    uint64_t val;
> -
> -    val = loongarch_pch_pic_read(opaque, addr, size);
> -    trace_loongarch_pch_pic_low_readw(size, addr, val);
> -    return val;
> +    return loongarch_pch_pic_read(opaque, addr, size);
>   }
>   
>   static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>                                            uint64_t value, unsigned size)
>   {
> -    trace_loongarch_pch_pic_low_writew(size, addr, value);
>       loongarch_pch_pic_write(opaque, addr, value, size);
>   }
>   
>   static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
>                                           unsigned size)
>   {
> -    uint64_t val;
> -
>       addr += PCH_PIC_INT_STATUS;
> -    val = loongarch_pch_pic_read(opaque, addr, size);
> -    trace_loongarch_pch_pic_high_readw(size, addr, val);
> -    return val;
> +    return loongarch_pch_pic_read(opaque, addr, size);
>   }
>   
>   static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
>                                        uint64_t value, unsigned size)
>   {
>       addr += PCH_PIC_INT_STATUS;
> -    trace_loongarch_pch_pic_high_writew(size, addr, value);
>       loongarch_pch_pic_write(opaque, addr, value, size);
>   }
>   
>   static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
>                                           unsigned size)
>   {
> -    uint64_t val;
> -
>       addr += PCH_PIC_ROUTE_ENTRY;
> -    val = loongarch_pch_pic_read(opaque, addr, size);
> -    trace_loongarch_pch_pic_readb(size, addr, val);
> -    return val;
> +    return loongarch_pch_pic_read(opaque, addr, size);
>   }
>   
>   static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
>                                        uint64_t data, unsigned size)
>   {
>       addr += PCH_PIC_ROUTE_ENTRY;
> -    trace_loongarch_pch_pic_writeb(size, addr, data);
>       loongarch_pch_pic_write(opaque, addr, data, size);
>   }
>   
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 0ba9a02e73..334aa6a97b 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -314,12 +314,8 @@ loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x
>   loongson_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
>   # loongarch_pch_pic.c
>   loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
> -loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> -loongarch_pch_pic_low_writew(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> -loongarch_pch_pic_high_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> -loongarch_pch_pic_high_writew(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> -loongarch_pch_pic_readb(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> -loongarch_pch_pic_writeb(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> +loongarch_pch_pic_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
> +loongarch_pch_pic_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
>   
>   # loongarch_pch_msi.c
>   loongarch_msi_set_irq(int irq_num) "set msi irq %d"


