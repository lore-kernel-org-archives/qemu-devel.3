Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95978F01825
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySbF-0002aG-Vq; Fri, 06 Mar 2026 05:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vySb8-0002ZT-Gx; Fri, 06 Mar 2026 05:39:58 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vySb6-0006E4-07; Fri, 06 Mar 2026 05:39:58 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnvdHvrqppu2m0AA--.49472S2;
 Fri, 06 Mar 2026 18:39:43 +0800 (CST)
Received: from [10.31.91.115] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3DuztrqppV3QfAA--.39956S2;
 Fri, 06 Mar 2026 18:39:41 +0800 (CST)
Message-ID: <57126277-be72-4c95-b4da-184b862bd2bc@phytium.com.cn>
Date: Fri, 6 Mar 2026 18:39:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v4 14/31] hw/arm/smmu-common: Implement secure state
 handling in ptw
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101649.2993830-1-tangtao1634@phytium.com.cn>
 <0b346363-9450-4397-8e1b-cfd46b45ed9c@redhat.com>
In-Reply-To: <0b346363-9450-4397-8e1b-cfd46b45ed9c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwC3DuztrqppV3QfAA--.39956S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWmp8qEHpgAAsw
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw4UKw4UAr1xWw1kAr17GFg_yoWxCFy8pr
 W8GFn0yrs3tFyIyws2qr4jv3W3J3ykKF4DGrZ7GFn3C3W5tr1kJr9FkrW5uFWDZF1rXa18
 Z34UKrs7uw4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 2026/3/3 17:41, Eric Auger wrote:
> Hi Tao,
>
> On 2/21/26 11:16 AM, Tao Tang wrote:
>> Enhance the page table walker to correctly handle secure and non-secure
>> memory accesses. This change introduces logic to select the appropriate
>> address space and enforce architectural security policies during walks.
>>
>> The page table walker now correctly processes Secure Stage 1
>> translations. Key changes include:
>>
>> - The get_pte function now uses the security context to fetch table
>> entries from either the Secure or Non-secure address space.
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
>> Note: We do not yet support secure stage 2 translations. So ns_as member
>> in SMMUTransCfg is used to cache non-secure AS instead of refactoring
>> smmu_ptw_64_s2 to pass SMMUState context.
>>
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c | 50 ++++++++++++++++++++++++++++++++++++++++----
>>   hw/arm/smmuv3.c      |  1 +
>>   2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index a732303b28b..84e71df6767 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -406,15 +406,16 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>>   /**
>>    * get_pte - Get the content of a page table entry located at
>>    * @base_addr[@index]
>> + * @as: AddressSpace to read from
> while at it let's properly document all parameters in the doc comment.


I'll doc attrs in V5.

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
>> @@ -538,6 +539,9 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>       SMMUStage stage = cfg->stage;
>>       SMMUTransTableInfo *tt = select_tt(cfg, iova);
>>       uint8_t level, granule_sz, inputsize, stride;
>> +    int nscfg, current_ns, new_nstable;
>> +    bool sid_is_ns = cfg->sec_sid == SMMU_SEC_SID_NS;
>> +    bool forced_ns = false;  /* Once true, NSTable is ignored */
>>   
>>       if (!tt || tt->disabled) {
>>           info->type = SMMU_PTW_ERR_TRANSLATION;
>> @@ -552,6 +556,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>   
>>       baseaddr = extract64(tt->ttb, 0, cfg->oas);
>>       baseaddr &= ~indexmask;
>> +    nscfg = tt->nscfg;
>> +    forced_ns = sid_is_ns || nscfg;
> do you really need this forced_ns
> can't you simply set current_ns = sid_is_ns || nscfg
> with first value of nscfg set to tt->nscfg and next level ones set to
> aptable is !current_ns


You're right. forced_ns could be simplified.


>>   
>>       while (level < VMSA_LEVELS) {
>>           uint64_t subpage_size = 1ULL << level_shift(level, granule_sz); @@ -560,8 +566,17 @@ static int 
>> smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg, uint64_t pte, gpa; 
>> dma_addr_t pte_addr = baseaddr + offset * sizeof(pte); uint8_t ap; + 
>> AddressSpace *pte_as; + MemTxAttrs pte_attrs; - if (get_pte(baseaddr, 
>> offset, &pte, info)) { + /* + * Start in NS for Non-secure streams or 
>> CD.NSCFGx == 1. + * Once walk is in NS, NSTable is ignored on 
>> subsequent levels. + */ + current_ns = forced_ns || nscfg; + pte_as = 
>> current_ns ? &bs->memory_as : &bs->secure_memory_as;
>> +        pte_attrs = current_ns ? MEMTXATTRS_UNSPECIFIED : cfg->txattrs;
>> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>>                   goto error;
>>           }
>>           trace_smmu_ptw_level(stage, level, iova, subpage_size,
>> @@ -586,6 +601,23 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
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
>> +            if (!forced_ns) {
>> +                new_nstable = PTE_NSTABLE(pte);
>> +                if (new_nstable) {
>> +                    forced_ns = true;
>> +                    nscfg = 1;
>> +                } else {
>> +                    nscfg = 0;
>> +                }
>> +            }
>>               level++;
>>               continue;
>>           } else if (is_page_pte(pte, level)) {
>> @@ -628,6 +660,13 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>>               goto error;
>>           }
>>   
>> +        if (current_ns) {
>> +            tlbe->sec_sid = SMMU_SEC_SID_NS;
>> +        } else {
>> +            tlbe->sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
>> +        }
>> +        tlbe->entry.target_as = (tlbe->sec_sid == SMMU_SEC_SID_S)
>> +                                ? &bs->secure_memory_as : &bs->memory_as;
> So I understand you need to set the target_as depending on sec_sid but
> not sure why need to store the sec_sid in the tlbe?


I will directly use a local sec_sid instead to generate target_as and 
drop sec_sid in tlbe as the previous thread mentioned.


>>           tlbe->entry.translated_addr = gpa;
>>           tlbe->entry.iova = iova & ~mask;
>>           tlbe->entry.addr_mask = mask;
>> @@ -697,7 +736,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>           uint8_t s2ap;
>>   
>> -        if (get_pte(baseaddr, offset, &pte, info)) {
>> +        if (get_pte(baseaddr, offset, &pte, info, cfg->ns_as,
>> +                    MEMTXATTRS_UNSPECIFIED)) {
>>                   goto error;
>>           }
>>           trace_smmu_ptw_level(stage, level, ipa, subpage_size,
>> @@ -750,6 +790,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>               goto error_ipa;
>>           }
>>   
>> +        tlbe->sec_sid = SMMU_SEC_SID_NS;
>> +        tlbe->entry.target_as = cfg->ns_as;
> Shouldn't you handle STE.NSCFG in case STE belongs to the secure stream
> table (ns_sid=secure) and stage 1 is disabled?
>
> Also shall we handle SMMU_IDR1.ATTR_PERMS_OVR?


I indeed ignored all Secure-related handling in stage-2, as I originally 
planned to implement those parts in the upcoming S_IDR1.SEL2 feature series.


But the senario you mentioned seems to unrelated to SEL2 feature afer I 
rechecked the manual. So I'll implement it in V5 with handling 
SMMU_IDR1.ATTR_PERMS_OVR.


Best regards,

Tao


