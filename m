Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3ECC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mIs-0004T6-Sv; Wed, 02 Sep 2026 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x1mIn-0004ST-Jh; Wed, 02 Sep 2026 10:51:01 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x1mIl-00037o-Oq; Wed, 02 Sep 2026 10:51:01 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCHu5TQN5hqi7dHBQ--.14759S2; 
 Wed, 02 Sep 2026 22:50:56 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.164])
 by mail (Coremail) with SMTP id AQAAf8DwoHLON5hqNeSqAA--.42408S2;
 Wed, 02 Sep 2026 22:50:55 +0800 (CST)
Message-ID: <a6282710-c96c-443f-81cf-94554d8f4286@phytium.com.cn>
Date: Wed, 2 Sep 2026 22:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 12/28] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
 <968e73e9-f0f6-4c37-b698-76b2bc1b9a73@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <968e73e9-f0f6-4c37-b698-76b2bc1b9a73@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwoHLON5hqNeSqAA--.42408S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWqXJ8sGbwACs4
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF4xJrWkWr1DCry8ArWDurg_yoW5GrWfpF
 nxAFnxXF18GF1xCr1SyF1UZF1qgw4ktr18Xry7Gr95Xrn0yrykJr1Utr1rKryDGry8Jr17
 Xr1UXF1DGr1jyrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 2026/8/28 00:56, Eric Auger wrote:
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
>> To prevent aliasing between translations controlled through the Secure and
>> Non-secure programming interfaces, the IOTLB lookup key must incorporate
>> SEC_SID.
>>
>> This commit:
>> - expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
>> - extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
>> - updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
>>    smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
>>    smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
>> - plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
>> - enhances trace events to include SEC_SID for better debugging
>>
>> This ensures that IOTLB entries decoded through the Secure and Non-secure
>> programming interfaces are distinct, preventing cache aliasing across
>> SEC_SID namespaces.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 110 +++++++++++++++++++++++------------
>>   hw/arm/smmu-internal.h       |   2 +
>>   hw/arm/smmuv3.c              |  47 ++++++++++-----
>>   hw/arm/trace-events          |  20 +++----
>>   include/hw/arm/smmu-common.h |  32 +++++++---
>>   5 files changed, 140 insertions(+), 71 deletions(-)
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index cc5d3ab696c..087112ba4b6 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -634,6 +634,17 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>           goto bad_ste;
>>       }
>>   
>> +    /*
>> +     * Keep the SEC_SID-to-StreamWorld approximation used by the IOTLB key
>> +     * one-to-one until the other Secure translation regimes are modeled.
>> +     */
> sorry but I don't understand the above comment. Also why are we talking
> about IOTLB here whereas it is not used in this function?
> also you already put a comment in smmu-common.h
>> +    if (sec_sid == SMMU_SEC_SID_S && STE_CFG_S1_TRANSLATE(config) &&
> use smmu_sec_sid_is_secure()


I'll drop this comment from decode_ste() and use 
smmu_sec_sid_is_secure() here.

Thanks.

Tao


>
> Besides looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Thanks
>
> Eric
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------


