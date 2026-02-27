Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B86FEFB5E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzsl-0006T2-5i; Fri, 27 Feb 2026 10:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvzsi-0006SZ-La; Fri, 27 Feb 2026 10:35:56 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvzsd-0000Gi-BB; Fri, 27 Feb 2026 10:35:56 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3TNDNuaFpwr6XAA--.17962S2;
 Fri, 27 Feb 2026 23:35:41 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwCn_erMuaFpybgdAA--.36961S2;
 Fri, 27 Feb 2026 23:35:40 +0800 (CST)
Message-ID: <726216f7-03a9-4fd1-b8ef-a4e61e91888e@phytium.com.cn>
Date: Fri, 27 Feb 2026 23:35:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 08/31] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-9-tangtao1634@phytium.com.cn>
 <0ace6596-fba6-48dd-b0af-e0444565a5ae@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <0ace6596-fba6-48dd-b0af-e0444565a5ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCn_erMuaFpybgdAA--.36961S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWmguFMsVgAMsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw1kCF48Ww4DCr17CF1xXwb_yoW5ZrWxpa
 ykGF98KrW8GF1fKF43Xw47ZFyaq395Jw4UJr17KFn5Arn8Ar12qr4jqwn0gr9rCrWrJr12
 9F17XF4kuF1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

On 2026/2/26 04:55, Pierrick Bouvier wrote:
> On 2/21/26 2:02 AM, Tao Tang wrote:
>> As a preliminary step towards a multi-security-state configuration
>> cache, introduce MemTxAttrs and AddressSpace * members to the
>> SMMUTransCfg struct. The goal is to cache these attributes so that
>> internal functions can use them directly.
>>
>> To facilitate this, hw/arm/arm-security.h is now included in
>> smmu-common.h. This is a notable change, as it marks the first time
>> these Arm CPU-specific security space definitions are used outside of
>> cpu.h, making them more generally available for device models.
>>
>> The decode helpers (smmu_get_ste, smmu_get_cd, smmu_find_ste,
>> smmuv3_get_config) are updated to use these new attributes for memory
>> accesses. This ensures that reads of SMMU structures from memory, such
>> as the Stream Table, use the correct security context.
>>
>> For the special case of smmuv3-accel.c, we only support the NS-only path
>> for now. Therefore, we initialize a minimal cfg with sec_sid, txattrs,
>> and as for the NS-only accel path.
>>
>> For now, the configuration cache lookup key remains unchanged and is
>> still based solely on the SMMUDevice pointer. The new attributes are
>> populated during a cache miss in smmuv3_get_config. And some paths still
>> rely on the NS-only address_space_memory, for example smmuv3_notify_iova
>> and get_pte(). These will be progressively converted in follow-up 
>> commits
>> to use an AddressSpace selected according to SEC_SID.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 19 ++++++++++++++++++
>>   hw/arm/smmuv3-accel.c        | 12 +++++++++++-
>>   hw/arm/smmuv3-internal.h     |  3 ++-
>>   hw/arm/smmuv3.c              | 38 ++++++++++++++++++++++--------------
>>   include/hw/arm/smmu-common.h | 12 ++++++++++++
>>   5 files changed, 67 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 3baba2a4c8e..b320aec8c60 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,25 @@
>>   #include "hw/arm/smmu-common.h"
>>   #include "smmu-internal.h"
>>   +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_SID_S:
>> +        return ARMSS_Secure;
>> +    case SMMU_SEC_SID_NS:
>> +    default:
>> +        return ARMSS_NonSecure;
>> +    }
>> +}
>> +
>
> Would that be possible to add all switch values, and use 
> g_assert_not_reached() for SMMU_SEC_SID_NUM.
> This way, when adding SMMU_SEC_SID_R, we'll be directly blocked at 
> compilation because case is missing.
>

Thanks for the suggestion.


I'll refactor it like below：

     switch (sec_sid) {
     case SMMU_SEC_SID_S:
         return ARMSS_Secure;
     case SMMU_SEC_SID_NS:
         return ARMSS_NonSecure;
     case SMMU_SEC_SID_NUM:
         g_assert_not_reached();
     }
     g_assert_not_reached();


> Regards,
> Pierrick


Thanks,

Tao


