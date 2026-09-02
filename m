Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6924C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mFw-0003mu-6R; Wed, 02 Sep 2026 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x1mFk-0003m4-As; Wed, 02 Sep 2026 10:47:55 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x1mFh-0002k2-Hk; Wed, 02 Sep 2026 10:47:52 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3NKwLN5hqNzszAQ--.37955S2; 
 Wed, 02 Sep 2026 22:47:39 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.164])
 by mail (Coremail) with SMTP id AQAAf8DwSnMKN5hqPtiqAA--.44477S2;
 Wed, 02 Sep 2026 22:47:38 +0800 (CST)
Message-ID: <e1da85f7-2301-4792-8cb3-eca88be05d39@phytium.com.cn>
Date: Wed, 2 Sep 2026 22:47:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v5 05/28] hw/arm/smmu-common: Add security-aware address
 space selector
To: eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
 <94e049b6-f144-4494-a089-2bef2251ca07@oss.qualcomm.com>
 <612d54f3-929a-45bc-9c7c-1e3cbfcd71eb@redhat.com>
In-Reply-To: <612d54f3-929a-45bc-9c7c-1e3cbfcd71eb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwSnMKN5hqPtiqAA--.44477S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWqXJ8sGbwABs7
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw1UtFyUJr47tFW3Cw45ZFb_yoW5GF18pa
 n7CFZ8Jr18KF1I9r92qFnIvFyUu395Gr15Gry7WryDCw1Dtrn3Ar1UKw4Y9r9rurn5Jr42
 yFy2vF4fWF15JrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 2026/8/27 16:20, Eric Auger wrote:
> Hi Tao, Pierrick,
>
> On 8/21/26 12:17 AM, Pierrick Bouvier wrote:
>> On 8/13/2026 9:24 AM, Tao Tang wrote:
>>> Introduce SMMU_SEC_SID_S to represent SEC_SID == 1, meaning Secure. And
>>> then provide smmu_get_address_space, a SMMU instance-based address space
>>> selector. The helper returns the per-device memory or secure-memory
>>> AddressSpace selected by SEC_SID.
>>>
>>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmu-common.c         | 15 +++++++++++++++
>>>   include/hw/arm/smmu-common.h |  3 +++
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 8e40ba603d3..54a6a9f4d62 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -30,6 +30,21 @@
>>>   #include "hw/arm/smmu-common.h"
>>>   #include "smmu-internal.h"
>>>   
>>> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
>>> +{
>>> +    switch (sec_sid) {
>>> +    case SMMU_SEC_SID_NS:
>>> +        return &s->memory_as;
>>> +    case SMMU_SEC_SID_S:
>>> +        g_assert(s->secure_memory);
>>> +        g_assert(s->secure_memory_as.root);
>> This second assert is not needed as we know it was initialized in realize.
> agreed, with that removed


Agreed. I'll remove the second assertion in the next revision.

Thanks for the review.

Tao


> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>
> Thanks
>
> Eric
>>> +        return &s->secure_memory_as;
>>> +    case SMMU_SEC_SID_NUM:
>>> +        g_assert_not_reached();
>>> +    }
>>> +    g_assert_not_reached();
>>> +}
>>> +
>>>   /* IOTLB Management */
>>>   
>>>   static guint smmu_iotlb_key_hash(gconstpointer v)
>>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>>> index 6ea40f6b074..9d6e2d3038f 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -43,6 +43,7 @@
>>>   /* StreamID Security state */
>>>   typedef enum SMMUSecSID {
>>>       SMMU_SEC_SID_NS = 0,
>>> +    SMMU_SEC_SID_S,
>>>       SMMU_SEC_SID_NUM,
>>>   } SMMUSecSID;
>>>   
>>> @@ -188,6 +189,8 @@ struct SMMUBaseClass {
>>>   #define TYPE_ARM_SMMU "arm-smmu"
>>>   OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>>>   
>>> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid);
>>> +
>>>   /* Return the SMMUPciBus handle associated to a PCI bus number */
>>>   SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>>>   
>> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>>


