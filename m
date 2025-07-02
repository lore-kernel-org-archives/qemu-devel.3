Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ABBC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrm6-0008Hl-4I; Wed, 02 Jul 2025 03:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uWrly-0008H6-Dy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:20:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uWrln-0005A9-IL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:20:47 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxfeHE3WRorA8hAQ--.31302S3;
 Wed, 02 Jul 2025 15:20:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxocLB3WRob2kGAA--.36347S3;
 Wed, 02 Jul 2025 15:20:36 +0800 (CST)
Subject: Re: [PATCH v3 8/9] target/loongarch: CPU enable msg interrupts.
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-9-gaosong@loongson.cn>
 <1da1b106-0fc0-584d-db64-9f695b5cd4da@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <94d55513-127b-9785-f836-f9164a9edd10@loongson.cn>
Date: Wed, 2 Jul 2025 15:23:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1da1b106-0fc0-584d-db64-9f695b5cd4da@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxocLB3WRob2kGAA--.36347S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1Dtr1ktF1kuF13Kr47WrX_yoW5Xr4kpr
 1kCFWUJrWUGryvq3WxJ3W5JryDZr4UKws2gw4xXFyUAFyUXr1jgFy0qrnFgFyUAr4rur40
 vr1rZryUZF15XwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

在 2025/7/2 上午11:20, Bibo Mao 写道:
>
>
> On 2025/6/27 上午11:01, Song Gao wrote:
>> when loongarch cpu set irq is INT_AVEC, we need set CSR_ESTAT.MSGINT bit
>> and CSR_ECFG.MSGINT bit.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu-csr.h |  6 ++++--
>>   target/loongarch/cpu.c     | 10 ++++++++++
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index 4792677086..6ec13d13d1 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -34,11 +34,13 @@ FIELD(CSR_MISC, ALCL, 12, 4)
>>   FIELD(CSR_MISC, DWPL, 16, 3)
>>     #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
>> -FIELD(CSR_ECFG, LIE, 0, 13)
>> +FIELD(CSR_ECFG, LIE, 0, 15)        /*bit 15 is msg interrupt enabled */
>> +FIELD(CSR_ECFG, MSGINT, 14, 1)
>>   FIELD(CSR_ECFG, VS, 16, 3)
>>     #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
>> -FIELD(CSR_ESTAT, IS, 0, 13)
>> +FIELD(CSR_ESTAT, IS, 0, 15)        /*bit 15 is msg interrupt enabled */
>> +FIELD(CSR_ESTAT, MSGINT, 14, 1)
>>   FIELD(CSR_ESTAT, ECODE, 16, 6)
>>   FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
>>   diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index bde9f917fc..c5924bb94f 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -127,6 +127,16 @@ void loongarch_cpu_set_irq(void *opaque, int 
>> irq, int level)
>>           return;
>>       }
>>   +    /* do INTC_AVEC irqs */
>> +    if (irq == INT_AVEC) {
>> +        for (int i = 256; i >= 0; i--) {
>> +            if (test_bit(i, &(env->CSR_MSGIS[i / 64]))) {
>> +                env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, 
>> CSR_ESTAT, MSGINT, 1);
>> +                env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, 
>> MSGINT, 1);
>> +            }
>> +        }
>> +    }
> I think it can be simplified as follows:
>   /* do INTC_AVEC irqs */
>   if (irq == INT_AVEC) {
>       env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
>       env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 1);
>   }
>
Got it.  I will corrrect it on v3 .  thanks for your suggestions and 
comments.

Thanks.
Song Gao
> Regards
> Bibo Mao
>> +
>>       if (kvm_enabled()) {
>>           kvm_loongarch_set_interrupt(cpu, irq, level);
>>       } else if (tcg_enabled()) {
>>


