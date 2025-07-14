Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F34C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFoX-0007jq-81; Mon, 14 Jul 2025 05:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ubFmx-0006Hs-4u
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:48:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ubFmt-0006QF-Qm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:47:58 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxPOJG0nRonSgpAQ--.44995S3;
 Mon, 14 Jul 2025 17:47:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxQMJD0nRoHacWAA--.53240S3;
 Mon, 14 Jul 2025 17:47:50 +0800 (CST)
Subject: Re: [PATCH v5 09/11] target/loongarch: CPU enable msg interrupts.
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250711085915.3042395-1-gaosong@loongson.cn>
 <20250711085915.3042395-10-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9753737d-390a-502c-fed8-24af055380db@loongson.cn>
Date: Mon, 14 Jul 2025 17:46:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250711085915.3042395-10-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxQMJD0nRoHacWAA--.53240S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1xJr18AF1DXFyrWF4DAwc_yoW8uF4fpw
 nrCFyvkrWrKrZFy3Z7J3Z8Gwnxur4fKrs29a13GFy2kF13Xw1jgrykt3s7KFyDC3s5urWI
 vF1Fyry8u3W5J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.992,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/7/11 下午4:59, Song Gao wrote:
> when loongarch cpu set irq is INT_AVEC, we need set CSR_ESTAT.MSGINT bit.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h |  6 ++++--
>   target/loongarch/cpu.c     | 10 +++++++++-
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 4792677086..6ec13d13d1 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -34,11 +34,13 @@ FIELD(CSR_MISC, ALCL, 12, 4)
>   FIELD(CSR_MISC, DWPL, 16, 3)
>   
>   #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
> -FIELD(CSR_ECFG, LIE, 0, 13)
> +FIELD(CSR_ECFG, LIE, 0, 15)        /*bit 15 is msg interrupt enabled */
> +FIELD(CSR_ECFG, MSGINT, 14, 1)
>   FIELD(CSR_ECFG, VS, 16, 3)
>   
>   #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
> -FIELD(CSR_ESTAT, IS, 0, 13)
> +FIELD(CSR_ESTAT, IS, 0, 15)        /*bit 15 is msg interrupt enabled */
> +FIELD(CSR_ESTAT, MSGINT, 14, 1)
>   FIELD(CSR_ESTAT, ECODE, 16, 6)
>   FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index abad84c054..9e21ed1d07 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -130,7 +130,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>       if (kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
> -        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> +        /* do INTC_AVEC irqs */
> +        if (irq == INT_AVEC) {
> +            irq = find_first_bit(env->CSR_MSGIS, 256);
> +            if (irq < 256) {
> +                env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
> +            }
Why is there such checking for bitmap? Can the original sentence work?
   env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);

This piece of code is a little strange.

Regards
Bibo Mao
> +        } else {
> +            env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> +        }
>           if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
>               cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>           } else {
> 


