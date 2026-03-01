Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74B8FD0066
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 13:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwh6K-0001G0-SY; Sun, 01 Mar 2026 08:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwh6H-0001FI-Fo; Sun, 01 Mar 2026 08:44:49 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwh6E-0004Pa-Sj; Sun, 01 Mar 2026 08:44:49 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnrprFQqRpmVimBw--.3462S2;
 Sun, 01 Mar 2026 21:44:37 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwC3DevDQqRp9i0eAA--.37346S2;
 Sun, 01 Mar 2026 21:44:35 +0800 (CST)
Message-ID: <3287a12c-da1a-463f-b635-37aea5ba8c6d@phytium.com.cn>
Date: Sun, 1 Mar 2026 21:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 04/31] hw/arm/smmuv3: Introduce banked registers for
 SMMUv3 state
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-5-tangtao1634@phytium.com.cn>
 <aaGsS9ldIqXZqhpk@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGsS9ldIqXZqhpk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3DevDQqRp9i0eAA--.37346S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAADsX
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF47Gryfur4UAry8tr4ruFg_yoWrur47pr
 sxJ3W3Gr18GF17urnrJw4UCF13tw4rtrn5Gry5Kas5A3ZYyr1xtr1jkw1rCa4DJryUWFy7
 ZF4UtrnxGr43ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Mostafa,

On 2026/2/27 PM10:38, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:02:23PM +0800, Tao Tang wrote:
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
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> There are a few warning from scripts/checkpatch.pl, plus some other
> nits I mentioned, otherwise:
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
>
>
>> ---
>>   hw/arm/smmuv3-accel.c        |  42 +++--
>>   hw/arm/smmuv3-internal.h     |  24 ++-
>>   hw/arm/smmuv3.c              | 345 +++++++++++++++++++----------------
>>   include/hw/arm/smmu-common.h |   6 +
>>   include/hw/arm/smmuv3.h      |  30 ++-
>>   5 files changed, 257 insertions(+), 190 deletions(-)
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>>   
>> @@ -687,22 +689,24 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>           return;
>>       }
>>   
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> Sometimes you have:
> SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> Others
> SMMUv3RegBank *bk = smmuv3_bank(s, SMMU_SEC_SID_NS);
>
> It would be helpful if naming is consistent.


Apologies for not switching to plain text only in Thunderbird in the 
previous reply email, which made the formatting look a bit strange.


I'll unify this definition across all affected places in V5, and also 
fix style warnings you mentioned previously.


>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> @@ -94,7 +99,14 @@ struct SMMUv3Class {
>>   #define TYPE_ARM_SMMUV3   "arm-smmuv3"
>>   OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
>>   
>> -#define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
>> -#define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
>> +#define STAGE1_SUPPORTED(s) \
>> +    FIELD_EX32((s)->bank[SMMU_SEC_SID_NS].idr[0], IDR0, S1P)
>> +#define STAGE2_SUPPORTED(s) \
>> +    FIELD_EX32((s)->bank[SMMU_SEC_SID_NS].idr[0], IDR0, S2P)
>> +
>> +static inline SMMUv3RegBank *smmuv3_bank(SMMUv3State *s, SMMUSecSID sec_sid)
>> +{
>> +    return &s->bank[sec_sid];
>> +}
>>
> If this is a macro you can use in other cases as in state structs as
> it currently inlined in:
> VMSTATE_UINT32(bank[SMMU_SEC_SID_NS].irq_ctrl, SMMUv3State),


My understanding is that VMSTATE_* wants an offsetof() ( VMSTATE_UINT32 
-> VMSTATE_INT32_V -> VMSTATE_SINGLE -> VMSTATE_SINGLE_TEST -> 
vmstate_offset_value ->offsetof ), so maybe we could not directly reuse 
the runtime helper there. At runtime, smmuv3_bank() needs a real 
`SMMUv3State *s` to compute the actual address of the selected bank 
(`&s->bank[sec_sid]`), which is different from a compile-time field offset.

A small compromise that works for both is to define a field-path macro 
and then take its address in smmuv3_bank():


```C

/* Field-path macro (offsetof-friendly) */
#define SMMUV3_BANK_F(_sid) bank[(_sid)]
#define SMMUV3_NS_BANK_F    SMMUV3_BANK_F(SMMU_SEC_SID_NS)

static inline SMMUv3RegBank *smmuv3_bank(SMMUv3State *s, SMMUSecSID sec_sid)
{
     return &s->SMMUV3_BANK_F(sec_sid);
}

/* VMSTATE uses the field-path macro directly */
VMSTATE_UINT32(SMMUV3_NS_BANK_F.irq_ctrl, SMMUv3State);

...

```


How do you think about it?


>
> Thanks,
> Mostafa
>

Thanks for your review.

Tao


