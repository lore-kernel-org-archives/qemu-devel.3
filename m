Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdfh-0007Jb-M0; Tue, 27 Oct 2026 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xLdff-0007JR-60
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:40:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xLdfc-0000zy-SZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:40:42 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxYdGSceBqU8MZAA--.10002S3;
 Tue, 27 Oct 2026 17:40:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxmM2RceBql6AwAA--.34995S2;
 Tue, 27 Oct 2026 17:40:33 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Replace sys_state with vm_level
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20261026095922.241092-1-maobibo@loongson.cn>
 <b66ae368-b2ea-4ade-90ef-3150253bbab4@oss.qualcomm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3e99f47c-e629-8e8e-6f65-56255b1fd072@loongson.cn>
Date: Tue, 27 Oct 2026 17:41:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b66ae368-b2ea-4ade-90ef-3150253bbab4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxmM2RceBql6AwAA--.34995S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryfWry8tr43GrWUJr1DJwc_yoW8Gw1fpr
 9Yy3yS9rW0gwn3J3ZrKFyDWF98Wr42g3ZrGr90qasYyFW5JryYgF18XrWj9F4DArW8WF1r
 Aan8trsrZFW7JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.712,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/26 下午6:09, Philippe Mathieu-Daudé wrote:
> On 26/10/26 10:59, Bibo Mao wrote:
>> Int type vm_level is more meaningful than pointer type sys_state,
>> and it is easy to get current mode from value of vm_level.
>>
>> Here replace sys_state with vm_level, and use vm_level directly.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu.h | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> 
>> -    CPUSysState sys_states[1];
>> +    CPUSysState sys_states[VM_LEVELS];
>>       uint32_t cpucfg[21];
>>       uint32_t pv_features;
>>       uint64_t vendor_id;
>> @@ -440,7 +440,7 @@ typedef struct CPUArchState {
>>       AddressSpace *address_space_iocsr;
>>       uint32_t mp_state;
>>   #endif
>> -    CPUSysState *sys_state;
>> +    int vm_level;
>>       unsigned int irq_nr;
>>   } CPULoongArchState;
>> @@ -510,12 +510,14 @@ struct LoongArchCPUClass {
>>   static inline CPUSysState *env_sys(CPULoongArchState *env)
>>   {
>> -    return env->sys_state;
>> +    return env->sys_states + env->vm_level;
> 
> Correct but easier to reason as:
> 
>        return env->sys_states[env->vm_level];
Sure, will change in this way with next version.

Regards
Bibo Mao
> 
> With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
>>   }


