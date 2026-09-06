Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F37FC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ExI-0004Cv-8r; Sun, 06 Sep 2026 11:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3ExD-0004CZ-F9; Sun, 06 Sep 2026 11:38:48 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3Ex9-00074c-PL; Sun, 06 Sep 2026 11:38:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBnbFD2iJ1qrM6gBQ--.4705S2;
 Sun, 06 Sep 2026 23:38:30 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.116.29])
 by mail (Coremail) with SMTP id AQAAf8Dwn3PziJ1q2O7GAA--.17462S2;
 Sun, 06 Sep 2026 23:38:28 +0800 (CST)
Message-ID: <59d39fd3-e6b4-4156-bc16-b8434e3c19e4@phytium.com.cn>
Date: Sun, 6 Sep 2026 23:38:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 11/28] hw/arm/smmu-common: Implement secure state
 handling in ptw
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
 <e41fdd64-7cb5-4cf4-9529-e1ae5e6b4c63@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <e41fdd64-7cb5-4cf4-9529-e1ae5e6b4c63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dwn3PziJ1q2O7GAA--.17462S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWqcbcoCZAAAs5
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfGr17Zw4fCFyxJw15Xr13urg_yoW8JFy5Xo
 WSkr4aq3W09w13C3Wjkw18Ja9rZF9Yqw4Fqr4rCwsI9anrJ345GFyUJw4rXa9aqa4UXrs7
 Gas5Jw40vF10yFn5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 2026/8/27 23:13, Eric Auger wrote:
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
>> Enhance the page table walker to correctly handle secure and non-secure
>> memory accesses. This change introduces logic to select the appropriate
>> address space and enforce architectural security policies during walks.
>>
>> The page table walker now correctly processes Secure Stage 1
>> translations. Key changes include:
>>
>> - The get_pte() function now uses the effective security state to fetch
>> page-table entries from either the Secure or Non-secure address space,
>> with explicit transaction attributes matching that address space.
>>
>> - The stage 1 walker tracks the security state, respecting the NSCFG
>> and NSTable attributes. It correctly handles the hierarchical security
>> model: if a table descriptor in a secure walk has NSTable=1, all
>> subsequent lookups for that walk are forced into the Non-secure space.
>> This is a one-way transition, as specified by the architecture.
>>
>> - The final TLB entry is tagged with the correct output address space,
>> ensuring proper memory isolation.
>>
>> Note: We do not yet support secure stage 2 translations. This patch
>> only implements Secure stage 1 page-table walks. Baseline propagation
>> of the incoming NS attribute for stage 1 bypass is handled separately
>> in this series with ATTR_PERMS_OVR == 0. Full ATTR_PERMS_OVR support
>> is left for a separate series.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 73 +++++++++++++++++++++++++++++-------
>>   hw/arm/smmuv3.c              | 19 ++++++----
>>   include/hw/arm/smmu-common.h |  7 ++--
>>   3 files changed, 74 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 63c36329a98..317cfafded2 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -408,13 +408,13 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>>    * @base_addr[@index]
>>    */
>>   static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
>> -                   SMMUPTWEventInfo *info)
>> +                   SMMUPTWEventInfo *info, AddressSpace *as, MemTxAttrs attrs)
>>   {
>>       int ret;
>>       dma_addr_t addr = baseaddr + index * sizeof(*pte);
>>   
>>       /* TODO: guarantee 64-bit single-copy atomicity */
>> -    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
>> +    ret = ldq_le_dma(as, addr, pte, attrs);
>>   
>>       if (ret != MEMTX_OK) {
>>           info->type = SMMU_PTW_ERR_WALK_EABT;
>> @@ -488,7 +488,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>>   static inline int translate_table_addr_ipa(SMMUState *bs,
>>                                              dma_addr_t *table_addr,
>>                                              SMMUTransCfg *cfg,
>> -                                           SMMUPTWEventInfo *info)
>> +                                           SMMUPTWEventInfo *info,
>> +                                           SMMUSecSID sec_sid)
> do we need that change given secure S2 is not implemented yet. Can't we
> focus on secure S1 first?


Yes. Since decode_ste() rejects Secure STEs with stage 2 enabled, 
reaching the nested path implies that the original sec_sid is 
Non-secure. I will keep translate_table_addr_ipa unchanged and use 
Non-secure explicitly inside this function.


>>   {
>>       dma_addr_t addr = *table_addr;
>>       SMMUTLBEntry *cached_entry;
>> @@ -501,7 +502,7 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>>       asid = cfg->asid;
>>       cfg->stage = SMMU_STAGE_2;
>>       cfg->asid = -1;
>> -    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
>> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info, sec_sid);
>>       cfg->asid = asid;
>>       cfg->stage = SMMU_NESTED;
>>   
>> @@ -524,6 +525,7 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>>    * @perm: access type
>>    * @tlbe: SMMUTLBEntry (out)
>>    * @info: handle to an error info
>> + * @sec_sid: StreamID Security state
>>    *
>>    * Return 0 on success, < 0 on error. In case of error, @info is filled
>>    * and tlbe->perm is set to IOMMU_NONE.
>> @@ -532,12 +534,16 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>>    */
>>   static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>                             dma_addr_t iova, IOMMUAccessFlags perm,
>> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
>> +                          SMMUSecSID sec_sid)
>>   {
>>       dma_addr_t baseaddr, indexmask;
>>       SMMUStage stage = cfg->stage;
>>       SMMUTransTableInfo *tt = select_tt(cfg, iova);
>>       uint8_t level, granule_sz, inputsize, stride;
>> +    int nscfg, current_ns, new_nstable;
>> +    bool sid_is_ns = sec_sid == SMMU_SEC_SID_NS;
> prefer !smmu_sec_sid_is_secure()?


Agreed.

>> +    SMMUSecSID table_sec_sid;
>>   
>>       if (!tt || tt->disabled) {
>>           info->type = SMMU_PTW_ERR_TRANSLATION;
>> @@ -552,6 +558,7 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>   
>>       baseaddr = extract64(tt->ttb, 0, cfg->oas);
>>       baseaddr &= ~indexmask;
>> +    nscfg = tt->nscfg;
>>   
>>       while (level < VMSA_LEVELS) {
>>           uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
>> @@ -560,8 +567,19 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>           uint64_t pte, gpa;
>>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>           uint8_t ap;
>> +        AddressSpace *pte_as;
>> +        MemTxAttrs pte_attrs;
>> +        SMMUSecSID cur_sec_sid;
>>   
>> -        if (get_pte(baseaddr, offset, &pte, info)) {
>> +        /*
>> +         * Start in NS for Non-secure streams or CD.NSCFGx == 1.
> May I suggest something like:
>
> at starting level we start fetching CD/TTBx in NS if non-secure SIDs of
> if CD.NSCFGx == 1. Once we start fetching in NS space, then we continue
> the PTW in next levels in NS space.


I'll change it in V6.

>> +         * Once walk is in NS, NSTable is ignored on subsequent levels.
>> +         */
>> +        current_ns = sid_is_ns || nscfg;
>> +        table_sec_sid = current_ns ? SMMU_SEC_SID_NS : sec_sid;
>> +        pte_as = smmu_get_address_space(bs, table_sec_sid);
>> +        pte_attrs = smmu_get_txattrs(table_sec_sid);
>> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>>                   goto error;
>>           }
>>           trace_smmu_ptw_level(stage, level, iova, subpage_size,
>> @@ -582,10 +600,25 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>               }
>>               baseaddr = get_table_pte_address(pte, granule_sz);
>>               if (cfg->stage == SMMU_NESTED) {
>> -                if (translate_table_addr_ipa(bs, &baseaddr, cfg, info)) {
>> +                if (translate_table_addr_ipa(bs, &baseaddr, cfg,
>> +                                             info, table_sec_sid)) {
>>                       goto error;
>>                   }
>>               }
>> +
>> +            /*
>> +             * NSTable can switch the walk to NS only while the current walk
>> +             * level is Secure. Once switched to NS, NSTable is ignored according
>> +             * to hierarchical control of Secure/Non-secure accesses:
>> +             * (IHI 0070G.b)13.4.1 Stage 1 page permissions and
>> +             * (DDI 0487H.a)D8.4.2 Control of Secure or Non-secure memory access
>> +             */
> above suggested comment may be sufficient
>> +            if (!current_ns) {
>> +                new_nstable = PTE_NSTABLE(pte);
> not sure you need new_nstable local variable
>> +                nscfg = new_nstable ? 1 : 0;
> and I think you can directly assign nscfg to PTE_NSTABLE(pte), no?


I'll update it as you suggested.


>> +            } else {
>> +                nscfg = 1;
>> +            }
>>               level++;
>>               continue;
>>           } else if (is_page_pte(pte, level)) {
>> @@ -628,6 +661,12 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>               goto error;
>>           }
>>   
>> +        if (current_ns) {
>> +            cur_sec_sid = SMMU_SEC_SID_NS;
>> +        } else {
>> +            cur_sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
>> +        }
>> +        tlbe->entry.target_as = smmu_get_address_space(bs, cur_sec_sid);
>>           tlbe->entry.translated_addr = gpa;
>>           tlbe->entry.iova = iova & ~mask;
>>           tlbe->entry.addr_mask = mask;
>> @@ -697,7 +736,10 @@ static int smmu_ptw_64_s2(SMMUState *bs, SMMUTransCfg *cfg,
>>           uint64_t pte, gpa;
>>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>           uint8_t s2ap;
>> -        if (get_pte(baseaddr, offset, &pte, info)) {
>> +        AddressSpace *pte_as = &bs->memory_as;
>> +        MemTxAttrs pte_attrs = MEMTXATTRS_UNSPECIFIED;
> same question here, why do we care about smmu_ptw_64_s() atm


The caller in smmu_ptw_64_s2() still needs updating because get_pte() is 
shared by both walkers and its interface changes in this patch.

I'll pass &bs->memory_as and MEMTXATTRS_UNSPECIFIED directly, without 
the extra local variables. The AddressSpace needs to come from the SMMU 
instance, so the bs parameter is still needed. I'll also move the 
associated S2 plumbing from the config-helper patch into this patch  as 
mentioned in #6 patch.


>> +
>> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>>                   goto error;
>>           }
>>           trace_smmu_ptw_level(stage, level, ipa, subpage_size,
>> @@ -792,7 +834,7 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>>   }
>>   
>>   /**
>> - * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>> + * smmu_ptw - Walk the page tables for an IOVA, according to @cfg and @sec_sid
>>    *
>>    * @bs: smmu state which includes TLB instance
>>    * @cfg: translation configuration
>> @@ -800,18 +842,20 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>>    * @perm: tentative access type
>>    * @tlbe: returned entry
>>    * @info: ptw event handle
>> + * @sec_sid: StreamID Security state
>>    *
>>    * return 0 on success
>>    */
>>   int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>> -             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>> +             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
>> +             SMMUSecSID sec_sid)
>>   {
>>       int ret;
>>       SMMUTLBEntry tlbe_s2;
>>       dma_addr_t ipa;
>>   
>>       if (cfg->stage == SMMU_STAGE_1) {
>> -        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
>> +        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info, sec_sid);
>>       } else if (cfg->stage == SMMU_STAGE_2) {
>>           /*
>>            * If bypassing stage 1(or unimplemented), the input address is passed
>> @@ -830,7 +874,7 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>>       }
>>   
>>       /* SMMU_NESTED. */
>> -    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
>> +    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info, sec_sid);
>>       if (ret) {
>>           return ret;
>>       }
>> @@ -846,7 +890,8 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>>   }
>>   
>>   SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>> -                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
>> +                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info,
>> +                             SMMUSecSID sec_sid)
>>   {
>>       SMMUTLBEntry *cached_entry = NULL;
>>       SMMUTransTableInfo *tt;
>> @@ -888,7 +933,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>>       }
>>   
>>       cached_entry = g_new0(SMMUTLBEntry, 1);
>> -    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info);
>> +    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info, sec_sid);
>>       if (status) {
>>               g_free(cached_entry);
>>               return NULL;
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 6b34f76f11b..cc5d3ab696c 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -394,7 +394,8 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                                                    SMMUEventInfo *event,
>>                                                    IOMMUAccessFlags flag,
>>                                                    SMMUTLBEntry **out_entry,
>> -                                                 SMMUTranslationClass class);
>> +                                                 SMMUTranslationClass class,
>> +                                                 SMMUSecSID sec_sid);
>>   /* @ssid > 0 not supported yet */
>>   static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>>                          uint32_t ssid, CD *buf, SMMUEventInfo *event,
>> @@ -411,7 +412,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>>   
>>       if (cfg->stage == SMMU_NESTED) {
>>           status = smmuv3_do_translate(s, addr, cfg, event,
>> -                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
>> +                                     IOMMU_RO, &entry, SMMU_CLASS_CD, sec_sid);
>>   
>>           /* Same PTW faults are reported but with CLASS = CD. */
>>           if (status != SMMU_TRANS_SUCCESS) {
>> @@ -796,7 +797,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event,
>>   }
>>   
>>   static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>> -                     CD *cd, SMMUEventInfo *event)
>> +                     CD *cd, SMMUEventInfo *event, SMMUSecSID sec_sid)
>>   {
>>       int ret = -EINVAL;
>>       int i;
>> @@ -869,7 +870,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>>           /* Translate the TTBx, from IPA to PA if nesting is enabled. */
>>           if (cfg->stage == SMMU_NESTED) {
>>               status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
>> -                                         &entry, SMMU_CLASS_TT);
>> +                                         &entry, SMMU_CLASS_TT, sec_sid);
> in the context secure S2 is not supported, can sec_sid be set here? In
> other words, do we really need to add sed_sid arg to decode_cd() at that
> stage or can we just invoke with ns and add a comment?


I'll handle decode_cd() the same way as translate_table_addr_ipa(), 
keeping its signature unchanged and using SMMU_SEC_SID_NS explicitly 
inside it.


Best regards,

Tao


