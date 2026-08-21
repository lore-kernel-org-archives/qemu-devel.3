Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9573EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRj8-0004gz-11; Fri, 21 Aug 2026 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRj2-0004gC-Rz; Fri, 21 Aug 2026 12:04:12 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRiz-0008AC-2D; Fri, 21 Aug 2026 12:04:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDXgMj0dohqVngHAQ--.18206S2; 
 Sat, 22 Aug 2026 00:04:04 +0800 (CST)
Received: from [192.168.2.8] (unknown [113.246.117.12])
 by mail (Coremail) with SMTP id AQAAf8DwF3PvdohqOsdhAA--.12470S2;
 Sat, 22 Aug 2026 00:03:59 +0800 (CST)
Message-ID: <808b3330-25ac-457d-b3f8-8085a167bc53@phytium.com.cn>
Date: Sat, 22 Aug 2026 00:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 02/28] hw/arm/smmuv3: Introduce banked registers for
 SMMUv3 state
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-2-tangtao1634@phytium.com.cn>
 <aogf8EmOJ_JEGKWl@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aogf8EmOJ_JEGKWl@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwF3PvdohqOsdhAA--.12470S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWqHVcgGNAAGsO
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGr4UuFyrWw4UXw4fAw4xJFb_yoW5XrWUpa
 9xJ3ZYkw1FqFn8XFsxAF4xAF12gaySqr17Jryaq3W3AF1Ykr1Sgw4UKrWruay7Arn8G3Wv
 gF1Yg3yDAw4kAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jim,

On 8/21/2026 5:52 PM, Jim MacArthur wrote:
> On Fri, Aug 14, 2026 at 12:24:07AM +0800, Tao Tang wrote:
>> Rework the SMMUv3 state management by introducing a banked register
>> structure. This is a purely mechanical refactoring with no functional
>> changes.
>>
>> To support multiple security states, a new enum, SMMUSecSID, is
>> introduced to identify each state, sticking to the spec terminology.
>>
>> A new structure, SMMUv3RegBank, is then defined to hold the state
>> for a single security context. The main SMMUv3State now contains an
>> array of these banks, indexed by SMMUSecSID. This avoids the need for
>> separate fields for non-secure and future secure registers.
>>
>> All existing code, which handles only the Non-secure state, is updated
>> to access its state via s->bank[SMMU_SEC_SID_NS]. A local bank helper
>> pointer is used where it improves readability.
>>
>> Function signatures and logic remain untouched in this commit to
>> isolate the structural changes and simplify review. This is the
>> foundational step for building multi-security-state support.
>>
>>   static void smmuv3_reset(SMMUv3State *s)
>>   {
>> -    s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>> -    s->cmdq.prod = 0;
>> -    s->cmdq.cons = 0;
>> -    s->cmdq.entry_size = sizeof(struct Cmd);
>> -    s->eventq.base = deposit64(s->eventq.base, 0, 5, SMMU_EVENTQS);
>> -    s->eventq.prod = 0;
>> -    s->eventq.cons = 0;
>> -    s->eventq.entry_size = sizeof(struct Evt);
>> -
>> -    s->features = 0;
>> -    s->sid_split = 0;
>> -    s->cr[0] = 0;
>> -    s->cr0ack = 0;
>> -    s->irq_ctrl = 0;
>> -    s->gerror = 0;
>> -    s->gerrorn = 0;
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
>> +
>> +    bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
>> +    bank->cmdq.prod = 0;
>> +    bank->cmdq.cons = 0;
>> +    bank->cmdq.entry_size = sizeof(struct Cmd);
>> +    bank->eventq.base = deposit64(bank->eventq.base, 0, 5, SMMU_EVENTQS);
>> +    bank->eventq.prod = 0;
>> +    bank->eventq.cons = 0;
>> +    bank->eventq.entry_size = sizeof(struct Evt);
>> +
>> +    bank->features = 0;
>> +    bank->sid_split = 0;
>> +    bank->cr[0] = 0;
>> +    bank->cr0ack = 0;
>> +    bank->irq_ctrl = 0;
>> +    bank->gerror = 0;
>> +    bank->gerrorn = 0;
>> +    bank->gbpa = SMMU_GBPA_RESET_VAL;
>> +
>> +    s->aidr = 0x1;
>>       s->statusr = 0;
>> -    s->gbpa = SMMU_GBPA_RESET_VAL;
>>   }
> Why reset s->aidr here? It should be read-only and set in smmuv3_init_id_regs.


Good catch, this is redundant since AIDR is initialized in 
smmuv3_init_id_regs(). I'll remove it in the next revision.


>
> It won't do any harm and the reset of this patch looks correct, so:
>
> Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


Thanks,

Tao


