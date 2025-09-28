Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C33ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 04:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2jJ3-0004Wc-Fx; Sun, 28 Sep 2025 00:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v2jIz-0004WI-Di; Sun, 28 Sep 2025 00:46:38 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v2jIn-0001pw-HS; Sun, 28 Sep 2025 00:46:37 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3D22Ovdhot3lTCQ--.674S2;
 Sun, 28 Sep 2025 12:46:06 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXu+iMvdhoJgYqAA--.21722S2;
 Sun, 28 Sep 2025 12:46:04 +0800 (CST)
Message-ID: <9ca98192-e5a4-44d7-a539-c577bf88d7e1@phytium.com.cn>
Date: Sun, 28 Sep 2025 12:46:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] hw/arm/smmuv3: Introduce secure registers and
 commands
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-4-tangtao1634@phytium.com.cn>
 <7161c00c-c519-4e90-9dca-99bcf7518d40@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <7161c00c-c519-4e90-9dca-99bcf7518d40@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXu+iMvdhoJgYqAA--.21722S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWjYPT4BqwAAsa
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr4rJF45CF4DtrW5trW5Jrb_yoW7JFWfpr
 40yF4rC3ykJF4xWw1xKa15Ar13Kr4kAFW7CrnrKry2va4UurySyFy8tFy5GFWkWF9YyF4U
 JFnrZ34fu3yayrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Eric,

On 2025/9/27 18:29, Eric Auger wrote:
> Hi Tao,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> The Arm SMMUv3 architecture defines a set of registers and commands for
>> managing secure transactions and context.
>>
>> This patch introduces the definitions for these secure registers and
>> commands within the SMMUv3 device model internal header.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h | 72 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 71a3c0c02c..3820157eaa 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -38,7 +38,7 @@ typedef enum SMMUTranslationClass {
>>       SMMU_CLASS_IN,
>>   } SMMUTranslationClass;
>>   
>> -/* MMIO Registers */
>> +/* MMIO Registers. The offsets are shared by Non-secure/Realm/Root states. */
> s/The offsets are shared/Shared ?


Thanks for your review. I'll modify it in the next version:

-/* MMIO Registers */
+/* MMIO Registers. Shared by Non-secure/Realm/Root states. */


>>   
>>   REG32(IDR0,                0x0)
>>       FIELD(IDR0, S2P,         0 , 1)
>> @@ -121,6 +121,7 @@ REG32(CR0,                 0x20)
>>       FIELD(CR0, CMDQEN,        3, 1)
>>   
>>   #define SMMU_CR0_RESERVED 0xFFFFFA20
>> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>>   
>>   
>>   REG32(CR0ACK,              0x24)
>> @@ -180,6 +181,75 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>>   
>>   #define A_IDREGS           0xfd0
>>   
>> +/* Secure registers. The offsets are begin with SMMU_SECURE_BASE_OFFSET */
> Start of secure-only registers? At least it deserves some reworking.


Agreed. "Start of secure-only registers" is much clearer. And 
SMMU_SECURE_REG_START may be much better?  I'll update the comment in v3.

/* Start of secure-only registers */
#define SMMU_SECURE_REG_START 0x8000


>> +#define SMMU_SECURE_BASE_OFFSET  0x8000
>> +
>> +REG32(S_IDR0,               0x8000)
>> +REG32(S_IDR1,               0x8004)
>> +    FIELD(S_IDR1, S_SIDSIZE,          0 , 6)
>> +    FIELD(S_IDR1, SEL2,               29, 1)
>> +    FIELD(S_IDR1, SECURE_IMPL,        31, 1)
>> +
>> +REG32(S_IDR2,               0x8008)
>> +REG32(S_IDR3,               0x800c)
>> +REG32(S_IDR4,               0x8010)
>> +
>> +REG32(S_CR0,                0x8020)
>> +    FIELD(S_CR0, SMMUEN,      0, 1)
>> +    FIELD(S_CR0, EVENTQEN,    2, 1)
>> +    FIELD(S_CR0, CMDQEN,      3, 1)
>> +
>> +REG32(S_CR0ACK,             0x8024)
>> +REG32(S_CR1,                0x8028)
>> +REG32(S_CR2,                0x802c)
>> +
>> +REG32(S_INIT,               0x803c)
>> +    FIELD(S_INIT, INV_ALL,    0, 1)
>> +/* Alias for the S_INIT offset to match in the dispatcher switch */
> what is the S_INIT_ALIAS purpose? At this stage of the reading I don't
> understand above comment. This it does not match any actual reg, I would
> move this defintion in the patch that actually uses it.


My initial idea was to use this alias to handle banked registers. Since 
secure/realm/root registers share the same lower address offset 
with non-secure, this alias allowed me to use a single case for all in 
the MMIO dispatcher.

However, I agree with you that this approach is not clear and could be 
confusing. In the v3 patch, I will remove the alias in patch #03 and use 
case (A_S_INIT & 0xfff) directly in patch #09, which is much more 
straightforward.

     uint32_t reg_offset = offset & 0xfff;
     switch (reg_offset) {

     case (A_S_INIT & 0xfff):

         ......

     }


Thanks,

Tao


>> +#define A_S_INIT_ALIAS         0x3c
>> +
>> +REG32(S_GBPA,               0x8044)
>> +    FIELD(S_GBPA, ABORT,     20, 1)
>> +    FIELD(S_GBPA, UPDATE,    31, 1)
>> +
>> +REG32(S_IRQ_CTRL,           0x8050)
>> +    FIELD(S_IRQ_CTRL, GERROR_IRQEN,    0, 1)
>> +    FIELD(S_IRQ_CTRL, EVENTQ_IRQEN,    2, 1)
>> +
>> +REG32(S_IRQ_CTRLACK,        0x8054)
>> +
>> +REG32(S_GERROR,             0x8060)
>> +    FIELD(S_GERROR, CMDQ_ERR,          0, 1)
>> +
>> +#define SMMU_GERROR_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
>> +#define SMMU_GERROR_IRQ_CFG2_RESERVED   0x000000000000003F
>> +
>> +#define SMMU_STRTAB_BASE_RESERVED       0x40FFFFFFFFFFFFC0
>> +#define SMMU_QUEUE_BASE_RESERVED        0x40FFFFFFFFFFFFFF
>> +#define SMMU_EVENTQ_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
>> +
>> +REG32(S_GERRORN,            0x8064)
>> +REG64(S_GERROR_IRQ_CFG0,    0x8068)
>> +REG32(S_GERROR_IRQ_CFG1,    0x8070)
>> +REG32(S_GERROR_IRQ_CFG2,    0x8074)
>> +REG64(S_STRTAB_BASE,        0x8080)
>> +REG32(S_STRTAB_BASE_CFG,    0x8088)
>> +    FIELD(S_STRTAB_BASE_CFG, LOG2SIZE, 0, 6)
>> +    FIELD(S_STRTAB_BASE_CFG, SPLIT,    6, 5)
>> +    FIELD(S_STRTAB_BASE_CFG, FMT,     16, 2)
>> +
>> +REG64(S_CMDQ_BASE,          0x8090)
>> +REG32(S_CMDQ_PROD,          0x8098)
>> +REG32(S_CMDQ_CONS,          0x809c)
>> +    FIELD(S_CMDQ_CONS, ERR,           24, 7)
>> +
>> +REG64(S_EVENTQ_BASE,        0x80a0)
>> +REG32(S_EVENTQ_PROD,        0x80a8)
>> +REG32(S_EVENTQ_CONS,        0x80ac)
>> +REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
>> +REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
>> +REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
>> +
>>   static inline int smmu_enabled(SMMUv3State *s)
>>   {
>>       return FIELD_EX32(s->cr[0], CR0, SMMUEN);
> Besides other definitions look good to me
>
> Thanks
>
> Eric


