Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5E5D12D65
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnS3-0000vn-0j; Wed, 03 Dec 2025 09:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnS0-0000us-Ap; Wed, 03 Dec 2025 09:03:24 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnRx-0002k1-Fz; Wed, 03 Dec 2025 09:03:23 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3_5sgQzBpM5r4Ag--.2141S2;
 Wed, 03 Dec 2025 22:03:12 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwA3juseQzBp5lEJAA--.3622S2;
 Wed, 03 Dec 2025 22:03:11 +0800 (CST)
Message-ID: <e80c6fbc-47a4-490a-8615-be2ee122eb94@phytium.com.cn>
Date: Wed, 3 Dec 2025 22:03:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 09/21] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-10-tangtao1634@phytium.com.cn>
 <096dabf7-3ae3-4739-86f5-d3c76a96432a@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <096dabf7-3ae3-4739-86f5-d3c76a96432a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3juseQzBp5lEJAA--.3622S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQABsp
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw1DJw15GrW7Kw1Uuw45Wrg_yoWxKF4xpr
 Z7JFn8tw4rtFyI9FZIqw4qva4Sv39YgF1DGrW7KF95CFn0vrn7ZryUKw15C34Dury8JFs2
 vF47WF43urn0yrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 2025/12/2 22:03, Eric Auger wrote:
>
> On 10/12/25 5:06 PM, Tao Tang wrote:
>> As a preliminary step towards a multi-security-state configuration
>> cache, introduce MemTxAttrs and AddressSpace * members to the
>> SMMUTransCfg struct. The goal is to cache these attributes so that
>> internal DMA calls (dma_memory_read/write) can use them directly.
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
>> For now, the configuration cache lookup key remains unchanged and is
>> still based solely on the SMMUDevice pointer. The new attributes are
>> populated during a cache miss in smmuv3_get_config.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 19 ++++++++++++++++++
>>   hw/arm/smmuv3.c              | 38 ++++++++++++++++++++++--------------
>>   include/hw/arm/smmu-common.h |  6 ++++++
>>   3 files changed, 48 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 24db448683..82308f0e33 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,25 @@
>>   #include "hw/arm/smmu-common.h"
>>   #include "smmu-internal.h"
>>   
>> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_SID_S:
>> +        return ARMSS_Secure;
>> +    case SMMU_SEC_SID_NS:
>> +    default:
>> +        return ARMSS_NonSecure;
>> +    }
>> +}
>> +
>> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
>> +{
>> +    return (MemTxAttrs) {
>> +        .secure = sec_sid > SMMU_SEC_SID_NS ? 1 : 0,
>> +        .space = smmu_get_security_space(sec_sid),
>> +    };
>> +}
>> +
>>   /* Global state for secure address space availability */
>>   bool arm_secure_as_available;
>>   
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index a87ae36e8b..351bbf1ae9 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -333,14 +333,13 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>   }
>>   
>>   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>> -                        SMMUEventInfo *event)
>> +                        SMMUEventInfo *event, SMMUTransCfg *cfg)
>>   {
>>       int ret, i;
>>   
>>       trace_smmuv3_get_ste(addr);
>>       /* TODO: guarantee 64-bit single-copy atomicity */
>> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
>>       if (ret != MEMTX_OK) {
>>           qemu_log_mask(LOG_GUEST_ERROR,
>>                         "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
>> @@ -385,8 +384,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>>       }
>>   
>>       /* TODO: guarantee 64-bit single-copy atomicity */
>> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
>>       if (ret != MEMTX_OK) {
>>           qemu_log_mask(LOG_GUEST_ERROR,
>>                         "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
>> @@ -639,18 +637,19 @@ bad_ste:
>>    * @sid: stream ID
>>    * @ste: returned stream table entry
>>    * @event: handle to an event info
>> + * @cfg: translation configuration cache
>>    *
>>    * Supports linear and 2-level stream table
>>    * Return 0 on success, -EINVAL otherwise
>>    */
>>   static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>> -                         SMMUEventInfo *event)
>> +                         SMMUEventInfo *event, SMMUTransCfg *cfg)
>>   {
>>       dma_addr_t addr, strtab_base;
>>       uint32_t log2size;
>>       int strtab_size_shift;
>>       int ret;
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUSecSID sec_sid = cfg->sec_sid;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>   
>>       trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
>> @@ -678,8 +677,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>           l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
>>           l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
>>           /* TODO: guarantee 64-bit single-copy atomicity */
>> -        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
>> -                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
>> +        ret = dma_memory_read(cfg->as, l1ptr, &l1std, sizeof(l1std),
>> +                              cfg->txattrs);
>>           if (ret != MEMTX_OK) {
>>               qemu_log_mask(LOG_GUEST_ERROR,
>>                             "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
>> @@ -721,7 +720,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>           addr = strtab_base + sid * sizeof(*ste);
>>       }
>>   
>> -    if (smmu_get_ste(s, addr, ste, event)) {
>> +    if (smmu_get_ste(s, addr, ste, event, cfg)) {
>>           return -EINVAL;
>>       }
>>   
>> @@ -850,7 +849,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>       /* ASID defaults to -1 (if s1 is not supported). */
>>       cfg->asid = -1;
>>   
>> -    ret = smmu_find_ste(s, sid, &ste, event);
>> +    ret = smmu_find_ste(s, sid, &ste, event, cfg);
>>       if (ret) {
>>           return ret;
>>       }
>> @@ -884,7 +883,8 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>    * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
>>    * by the SMMUDevice handle.
>>    */
>> -static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>> +                                       SMMUSecSID sec_sid)
>>   {
>>       SMMUv3State *s = sdev->smmu;
>>       SMMUState *bc = &s->smmu_state;
>> @@ -904,7 +904,15 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>>                               100 * sdev->cfg_cache_hits /
>>                               (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>>           cfg = g_new0(SMMUTransCfg, 1);
>> -        cfg->sec_sid = SMMU_SEC_SID_NS;
>> +        cfg->sec_sid = sec_sid;
>> +        cfg->txattrs = smmu_get_txattrs(sec_sid);
>> +        cfg->as = smmu_get_address_space(sec_sid);
>> +        if (!cfg->as) {
>> +            /* Can't get AddressSpace, free cfg and return. */
>> +            g_free(cfg);
>> +            cfg = NULL;
>> +            return cfg;
> don't you want to report an error in that case. Which type?

Thanks for your review!

Honestly I’m not actually sure there is an architecturally correct event 
type for this case.

Here smmu_get_address_space(sec_sid) returning NULL means the machine 
didn’t provide an AddressSpace for SMMU-originated DMA in that security 
context, which feels like a QEMU board/integration bug rather than 
something the SMMU spec defines an event for (the existing events are 
all driven by STE/CD and transaction attributes). Synthesizing something 
like F_STREAM_DISABLED would therefore be misleading from the guest’s 
point of view.

Maybe we could use g_assert() hard failure here? But I also look forward 
to different opinions.

Yours,

Tao


