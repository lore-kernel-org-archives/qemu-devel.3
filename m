Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C5C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 11:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Njj-0001t6-TX; Thu, 17 Apr 2025 07:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u5NjA-0001ot-9m
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:48:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u5Nj1-0004xH-B3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:48:16 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxrOJy6gBotPLAAA--.18398S3;
 Thu, 17 Apr 2025 19:48:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxPcVs6gBo+teHAA--.7002S3;
 Thu, 17 Apr 2025 19:48:01 +0800 (CST)
Subject: Re: [PATCH v2 6/6] target/loongarch: Move function
 loongarch_tlb_search to directory tcg
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250417035143.268248-1-maobibo@loongson.cn>
 <20250417035143.268248-7-maobibo@loongson.cn>
 <33b477b3-6579-4c6e-afb2-d54fa4e13141@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <a649db09-63f0-35eb-e540-8036f722e072@loongson.cn>
Date: Thu, 17 Apr 2025 19:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <33b477b3-6579-4c6e-afb2-d54fa4e13141@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcVs6gBo+teHAA--.7002S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47ArykKrWfXFW8uw4rZwc_yoW5tw4fpr
 yxAr1UJryUJrykJr1UJr1UJFyUJr1UJw1UJF13JF18Cr1UJr1jqr1UXr1qgF1UJ3y8Jr1j
 qr1UJr1UZF1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.272,
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



On 2025/4/17 下午6:01, Philippe Mathieu-Daudé wrote:
> On 17/4/25 05:51, Bibo Mao wrote:
>> Function loongarch_tlb_search() and loongarch_map_tlb_entry() works
>> only in TCG mode, move these functions to directory tcg.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu_helper.c     | 153 ------------------------------
>>   target/loongarch/internals.h      |  14 ++-
>>   target/loongarch/tcg/tlb_helper.c | 144 ++++++++++++++++++++++++++++
>>   3 files changed, 156 insertions(+), 155 deletions(-)
> 
> 
>> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
>> index 9fdc3059d8..f85927860b 100644
>> --- a/target/loongarch/internals.h
>> +++ b/target/loongarch/internals.h
>> @@ -54,8 +54,6 @@ uint64_t 
>> cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
>>   uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>>                                                  uint64_t value);
>> -bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>> -                          int *index);
>>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>                            int *prot, target_ulong address,
>>                            MMUAccessType access_type, int mmu_idx, int 
>> is_debug);
>> @@ -67,6 +65,18 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState 
>> *cpu, vaddr addr);
>>   bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>                               MMUAccessType access_type, int mmu_idx,
>>                               bool probe, uintptr_t retaddr);
>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>> *physical,
>> +                                int *prot, target_ulong address,
>> +                                MMUAccessType access_type, int mmu_idx);
>> +#else
>> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
>> +                                              hwaddr *physical,
>> +                                              int *prot, target_ulong 
>> address,
>> +                                              MMUAccessType access_type,
>> +                                              int mmu_idx)
>> +{
>> +    return TLBRET_NOMATCH;
>> +}
>>   #endif
> 
> I wonder if we shouldn't move these declarations to
> target/loongarch/tcg/tcg_loongarch.h. Can be done as
> future cleanup, so:
Sure, will move these declarations to file 
target/loongarch/tcg/tcg_loongarch.h in next version, it is not hurry to 
merge
now.

Regards
Bibo Mao
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>   #endif /* !CONFIG_USER_ONLY */


