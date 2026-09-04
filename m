Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6066DC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VRX-0000u7-29; Fri, 04 Sep 2026 11:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x2VRQ-0000tW-ED; Fri, 04 Sep 2026 11:02:57 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x2VRO-0008Hy-Ah; Fri, 04 Sep 2026 11:02:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDX0amR3ZpqIhk6AQ--.42388S2; 
 Fri, 04 Sep 2026 23:02:41 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.39])
 by mail (Coremail) with SMTP id AQAAf8DwfXOQ3Zpqy_C6AA--.4119S2;
 Fri, 04 Sep 2026 23:02:40 +0800 (CST)
Message-ID: <1a789512-1ddd-4e42-8f41-44e9ab91585e@phytium.com.cn>
Date: Fri, 4 Sep 2026 23:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 06/28] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
 <apbaH93DHhCUx4K0@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <apbaH93DHhCUx4K0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwfXOQ3Zpqy_C6AA--.4119S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWqZyskIbAABsZ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGw43Kw1kZr13KF18ur1Dtrb_yoW5AF1xpa
 ykCF90kr4kKFyxW3s3XF47ua45Wa95GF4UGr9Fkr95ur1qvrn3Zr4jkw1F9r9rury8Jw4I
 vF12qrZ3uFn8JrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Mostafa,

On 2026/9/1 21:58, Mostafa Saleh wrote:
> On Fri, Aug 14, 2026 at 12:24:42AM +0800, Tao Tang wrote:
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
>>
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
> So that would be used instead of MEMTXATTRS_UNSPECIFIED previously
> used. I am not sure if some other fields need to be set also as
> memory, requester_id, address_type?
>
> If not, maybe it is worth adding a comment.

This is intentional. These are SMMU-originated accesses(3.4.3 Address 
sizes of SMMU-originated accesses), so they do not inherit the client 
transaction's requester ID, PASID, or PCI address type.

Only the security state is made explicit here. I leave MemTxAttrs.memory 
clear to preserve the existing QEMU access behavior. In QEMU that bit is 
a RAM-only access filter: setting it would reject accesses to non-RAM 
MemoryRegions. It does not represent the full architectural 
Normal-memory cacheability and shareability attributes.

I will add a comment to make this explicit.

Thanks,
Tao


