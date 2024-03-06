Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525EC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhfyR-0007Ru-6F; Tue, 05 Mar 2024 20:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rhfyO-0007Rm-VP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:21:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rhfyN-00010Q-7I
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:21:32 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxF+gVxedl9fUUAA--.32413S3;
 Wed, 06 Mar 2024 09:21:26 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXRMSxedl3e5OAA--.13470S3; 
 Wed, 06 Mar 2024 09:21:24 +0800 (CST)
Subject: Re: [PATCH v3] target/loongarch: Add TCG macro in structure
 CPUArchState
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240305062644.1564155-1-maobibo@loongson.cn>
 <31e8832d-d853-412d-8f98-c4b91febd450@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3a24d9c3-2f50-3187-2095-fe161e5a0341@loongson.cn>
Date: Wed, 6 Mar 2024 09:21:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <31e8832d-d853-412d-8f98-c4b91febd450@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXRMSxedl3e5OAA--.13470S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1kAr45GF4kAFy7Gr4rZwc_yoW8WryDpr
 y8Ar1UKFyUtrn5Jr1DXw1UZFyUAr4UJ34Ut3WUJF1jyr15Jr1Yqr1UXryqgF1UGw4kGw1j
 qr4UJF1UZF1UJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.98,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/3/5 下午11:45, Richard Henderson wrote:
> On 3/4/24 20:26, Bibo Mao wrote:
>> +#ifdef CONFIG_TCG
>>   static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                      int *prot, target_ulong address,
>>                                      int access_type, int index, int 
>> mmu_idx)
>> @@ -154,6 +155,14 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>       return TLBRET_NOMATCH;
>>   }
>> +#else
>> +static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>> +                                 int *prot, target_ulong address,
>> +                                 MMUAccessType access_type, int mmu_idx)
>> +{
>> +    return TLBRET_NOMATCH;
>> +}
>> +#endif
> 
> You may find that debugging with gdbstub or the qemu monitor easier with 
> a routine that walks page tables for loongarch_cpu_get_phys_page_debug.  
> For kvm, the existing code is insufficient anyway, because you'd need to 
> emulate a hardware page table walk, not use env->tlb[], which would not 
> be populated.
> 
> This can be improved later.
Sure, will add page table walk emulation code later in function 
loongarch_cpu_get_phys_page_debug(). And thanks for your guidance.

Regards
Bibo Mao
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


