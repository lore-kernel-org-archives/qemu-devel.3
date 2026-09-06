Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A4EC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3F0o-00055M-BQ; Sun, 06 Sep 2026 11:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3F0n-000557-3a; Sun, 06 Sep 2026 11:42:29 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3F0l-0008Kq-Cg; Sun, 06 Sep 2026 11:42:28 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwB3f1PgiZ1qMdagBQ--.4343S2;
 Sun, 06 Sep 2026 23:42:24 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.116.29])
 by mail (Coremail) with SMTP id AQAAf8DwSnPfiZ1q7fzGAA--.16612S2;
 Sun, 06 Sep 2026 23:42:23 +0800 (CST)
Message-ID: <e3ef0d36-58dd-406a-8e46-d01d0379ddf4@phytium.com.cn>
Date: Sun, 6 Sep 2026 23:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 11/28] hw/arm/smmu-common: Implement secure state
 handling in ptw
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
 <apbctpZhmRAzRia1@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <apbctpZhmRAzRia1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwSnPfiZ1q7fzGAA--.16612S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWqcbcoCZAABs4
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4xAF1Utry3Xr1xKry3Arb_yoWrGFyrpa
 97GFZIgw4ktFyIvrs2vr4UZ3W5A395Ga15GrZrGF9Yk3Z8tr18AF1jk345KFZ0gr1rGay0
 v3Wj9rZxWF4jv3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

Hi Mostafa,

On 2026/9/1 22:09, Mostafa Saleh wrote:
> On Fri, Aug 14, 2026 at 12:25:08AM +0800, Tao Tang wrote:
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
>>   {
>>       dma_addr_t addr = *table_addr;
>>       SMMUTLBEntry *cached_entry;
>> @@ -501,7 +502,7 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>>       asid = cfg->asid;
>>       cfg->stage = SMMU_STAGE_2;
>>       cfg->asid = -1;
>> -    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
>> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info, sec_sid);
> Should we have an assertion instead as it is not possible to reach
> this path with the secure bit?
>
> Thanks,
> Mostafa


Thanks for the suggestion! Eric suggested avoiding the extra sec_sid 
plumbing while Secure stage 2 is unsupported, so in v6 I want to remove 
the sec_sid parameter from translate_table_addr_ipa() and explicitly 
pass SMMU_SEC_SID_NS to smmu_translate() inside the helper. Since 
decode_ste() already returns C_BAD_STE for Secure STEs with stage 2 
enabled, including nested translation, could we omit this assertion for 
now? What do you think?

Best regards,
Tao



