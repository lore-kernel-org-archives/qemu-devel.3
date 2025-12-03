Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7374ED15D86
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQomS-0007BE-6E; Wed, 03 Dec 2025 10:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQomP-0007A6-Mr; Wed, 03 Dec 2025 10:28:33 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQomN-0003lV-HG; Wed, 03 Dec 2025 10:28:33 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDX31MYVzBplfcrAQ--.57783S2;
 Wed, 03 Dec 2025 23:28:24 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwCX8O0XVzBpaVQJAA--.18357S2;
 Wed, 03 Dec 2025 23:28:23 +0800 (CST)
Message-ID: <2b350edb-8637-474a-80ab-9f8e5ce3ea74@phytium.com.cn>
Date: Wed, 3 Dec 2025 23:28:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 13/21] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151244.4129572-1-tangtao1634@phytium.com.cn>
 <1798040a-dd6c-4f6d-b03b-8e2e96b7cf55@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <1798040a-dd6c-4f6d-b03b-8e2e96b7cf55@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8O0XVzBpaVQJAA--.18357S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQAEss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF4rZrWDXryruFW8CFyDZFb_yoWrCryDpF
 WktF4Yyr4vyF17Zrn3uF17Z3ZIvw1kWryUJr43Wr95tas5trykXF4vkayFkrZrZry8Jrs2
 va4vqr45GF13WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/12/3 00:08, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:12 PM, Tao Tang wrote:
>> To prevent aliasing between secure and non-secure translations for the
>> same address space, the IOTLB lookup key must incorporate the security
>> state of the transaction. This commit expands SMMUIOTLBKey with the
>> SEC_SID, plumbs the new argument through common helpers, and ensures
>> that secure and non-secure TLB entries are treated as distinct
>> entities within the cache.
>>
>> As a final step, this patch ensures the target address space
>> (target_as) from a cached IOTLB entry is correctly propagated to the
>> final translation result. Previously, the result defaulted to the
>> non-secure address space, nullifying the benefits of the
>> security-aware cache key.
>>
>> This change provides robust management for secure TLB entries,
>> preventing TLB pollution between security worlds and allowing for proper
>> initialization by secure software.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn
>> ---
>>   hw/arm/smmu-common.c         | 25 ++++++++++++---------
>>   hw/arm/smmuv3.c              | 42 +++++++++++++++++++++---------------
>>   hw/arm/trace-events          |  2 +-
>>   include/hw/arm/smmu-common.h |  9 +++++---
>>   4 files changed, 47 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index a092bb5a8d..4131a31ae0 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -86,7 +86,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>>   
>>       /* Jenkins hash */
>>       a = b = c = JHASH_INITVAL + sizeof(*key);
>> -    a += key->asid + key->vmid + key->level + key->tg;
>> +    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
>>       b += extract64(key->iova, 0, 32);
>>       c += extract64(key->iova, 32, 32);
>>   
>> @@ -102,14 +102,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>>   
>>       return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
>>              (k1->level == k2->level) && (k1->tg == k2->tg) &&
>> -           (k1->vmid == k2->vmid);
>> +           (k1->vmid == k2->vmid) && (k1->sec_sid == k2->sec_sid);
>>   }
>>   
>>   SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>> -                                uint8_t tg, uint8_t level)
>> +                                uint8_t tg, uint8_t level,
>> +                                SMMUSecSID sec_sid)
>>   {
>>       SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
>> -                        .tg = tg, .level = level};
>> +                        .tg = tg, .level = level, .sec_sid = sec_sid};
>>   
>>       return key;
>>   }
>> @@ -131,7 +132,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>>           SMMUIOTLBKey key;
>>   
>>           key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
>> -                                 iova & ~mask, tg, level);
>> +                                 iova & ~mask, tg, level, cfg->sec_sid);
>>           entry = g_hash_table_lookup(bs->iotlb, &key);
>>           if (entry) {
>>               break;
>> @@ -195,7 +196,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>>       }
>>   
>>       *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>> -                              tg, new->level);
>> +                              tg, new->level, cfg->sec_sid);
>>       trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>>                               tg, new->level);
>>       g_hash_table_insert(bs->iotlb, key, new);
>> @@ -314,13 +315,15 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
>>   }
>>   
>>   void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
>> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
>> +                         SMMUSecSID sec_sid)
>>   {
>>       /* if tg is not set we use 4KB range invalidation */
>>       uint8_t granule = tg ? tg * 2 + 10 : 12;
>>   
>>       if (ttl && (num_pages == 1) && (asid >= 0)) {
>> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
>> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
>> +                                              tg, ttl, sec_sid);
> what about the other invalidation commands?
>
> I see CMD_TLBI_NH_ASID(VMID, ASID), NH_ALL are selective depending on
> the cmd queue it is issued from?
>
> Thanks
>
> Eric
>

Thanks for the pointer. I’m going to extend the security-state plumbing 
you highlighted so that all TLBI commands honor the queue’s security 
domain in the next version, refactoring relative smmu_iotlb_inv_* and 
smmu_hash_* functions for example.


Thanks,

Tao


