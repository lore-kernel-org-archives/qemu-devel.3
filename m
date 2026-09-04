Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD44C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VJL-0006ou-98; Fri, 04 Sep 2026 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x2VJI-0006oM-9X; Fri, 04 Sep 2026 10:54:32 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x2VJ8-0006KO-Mw; Fri, 04 Sep 2026 10:54:32 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBna7OU25pqIRY6AQ--.42156S2; 
 Fri, 04 Sep 2026 22:54:12 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.39])
 by mail (Coremail) with SMTP id AQAAf8DwwHST25pqT++6AA--.64174S2;
 Fri, 04 Sep 2026 22:54:12 +0800 (CST)
Message-ID: <2a6ae5cc-9e6e-4d5b-93f7-c2ecc0faa25c@phytium.com.cn>
Date: Fri, 4 Sep 2026 22:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 06/28] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
 <e4dd7318-e498-46eb-8af7-ce138c3f0caf@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <e4dd7318-e498-46eb-8af7-ce138c3f0caf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwwHST25pqT++6AA--.64174S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWqZyskIbAAAsY
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr4kCr1fZr1xJFW3XF47urg_yoWrGw1xpa
 y8GFs0kr4kKFyS9rZ3Xrsrua45ua95Gr1UGry7Kas3Ar1Yvr1fZr12kw1Y9FWDWr15Jrs2
 vry0gr43uF1DJrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Eric,

On 2026/8/27 17:07, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:24 PM, Tao Tang wrote:
>> Introduce helpers that derive MemTxAttrs and select an AddressSpace from
>> SEC_SID, then pass SEC_SID through the Stream Table and Context Descriptor
>> fetch paths. This makes reads of SMMU configuration structures use the
>> corresponding Non-secure or Secure memory context.
>>
>> To support these helpers, include hw/arm/arm-security.h from smmu-common.h,
>> making the Arm security-space definitions available to the common SMMU code.
>>
>> The accelerated path remains Non-secure-only and therefore passes
>> SMMU_SEC_SID_NS explicitly.
>> For now, the configuration cache lookup key remains based solely on the
>> SMMUDevice pointer. It is extended with SEC_SID in a later commit. Other
>> SEC_SID-sensitive memory accesses that still use the Non-secure address
>> space are converted in follow-up commits.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 30 +++++++++++++++++++++----
>>   hw/arm/smmuv3-accel.c        |  2 +-
>>   hw/arm/smmuv3-internal.h     |  3 ++-
>>   hw/arm/smmuv3.c              | 43 ++++++++++++++++++++++--------------
>>   include/hw/arm/smmu-common.h | 10 +++++++++
> Please use
> [diff]
>          orderFile = scripts/git.orderfile
> in your .gitconfig to have headers output first in the patch.


I have configured scripts/git.orderfile for the v6 export.


>
>>   5 files changed, 65 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 54a6a9f4d62..89e1e2826d4 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,27 @@
>>   #include "hw/arm/smmu-common.h"
>>   #include "smmu-internal.h"
>>   
>> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_SID_S:
>> +        return ARMSS_Secure;
>> +    case SMMU_SEC_SID_NS:
>> +        return ARMSS_NonSecure;
>> +    case SMMU_SEC_SID_NUM:
>> +        g_assert_not_reached();
>> +    }
>> +    g_assert_not_reached();
>> +}
>> +
>> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
>> +{
>> +    return (MemTxAttrs) {
>> +        .secure = smmu_sec_sid_is_secure(sec_sid) ? 1 : 0,
>> +        .space = smmu_get_security_space(sec_sid),
>> +    };
>> +}
>> +
>>   AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
>>   {
>>       switch (sec_sid) {
>> @@ -588,6 +609,7 @@ error:
>>   /**
>>    * smmu_ptw_64_s2 - VMSAv8-64 Walk of the page tables for a given ipa
>>    * for stage-2.
>> + * @bs: smmu state which includes TLB instance
>>    * @cfg: translation config
>>    * @ipa: ipa to translate
>>    * @perm: access type
>> @@ -599,7 +621,7 @@ error:
>>    * Upon success, @tlbe is filled with translated_addr and entry
>>    * permission rights.
>>    */
>> -static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>> +static int smmu_ptw_64_s2(SMMUState *bs, SMMUTransCfg *cfg,
>>                             dma_addr_t ipa, IOMMUAccessFlags perm,
>>                             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>>   {
>> @@ -636,7 +658,6 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>           uint64_t pte, gpa;
>>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>           uint8_t s2ap;
>> -
> unwanted change


I'll drop this line.

>>           if (get_pte(baseaddr, offset, &pte, info)) {
>>                   goto error;
>>           }
>> @@ -690,6 +711,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>               goto error_ipa;
>>           }
>>   
>> +        tlbe->entry.target_as = &bs->memory_as;
> I don't understand why we do that change in this patch (also there is no
> sumetrical change in smmu_ptw_64_s1)? It does not seem to relate to the
> commit title/desc

Agreed. The S2 bs/target_as changes are not part of the 
configuration-fetch plumbing and should not be in this patch.

I'll move this change to the later PTW patch, where get_pte() is changed 
to take an AddressSpace and MemTxAttrs.

Thanks,
Tao




