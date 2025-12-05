Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1559D2E039
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRR6c-0002s1-Tk; Fri, 05 Dec 2025 03:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRR6a-0002rd-B4; Fri, 05 Dec 2025 03:23:56 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRR6X-0003B5-9H; Fri, 05 Dec 2025 03:23:56 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXn2OMljJpxkgSAw--.572S2;
 Fri, 05 Dec 2025 16:23:40 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX7eqCljJpvLwJAA--.4322S2;
 Fri, 05 Dec 2025 16:23:37 +0800 (CST)
Message-ID: <d9547948-6a69-46ca-8837-329ffd1b5f9f@phytium.com.cn>
Date: Fri, 5 Dec 2025 16:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 16/21] hw/arm/smmuv3: Implement SMMU_S_INIT register
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151351.4130239-1-tangtao1634@phytium.com.cn>
 <421fdc65-c21d-4606-a241-28341955104a@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <421fdc65-c21d-4606-a241-28341955104a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX7eqCljJpvLwJAA--.4322S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWkwma4FjAALsm
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XF1fuw18CFWUJFy7CryfWFg_yoW3GFy8pr
 WkGF15KFWUAw4fu3W2kw4kAFyUZw1kK3W7Cr98Ga4ava4Yyry0qr4qgw4Y9F1DCr48A3y2
 qr4YgFsruw1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/12/4 22:33, Eric Auger wrote:
>
> On 10/12/25 5:13 PM, Tao Tang wrote:
>> Implement read/write handlers for the SMMU_S_INIT secure-only
>> register.
>>
>> Writing to this register provides a mechanism for software to perform a
>> global invalidation of ALL caches within the SMMU. This includes the
>> IOTLBs and Configuration Caches across all security states.
>>
>> This feature is critical for secure hypervisors like Hafnium, which
>> use it as a final step in their SMMU initialization sequence. It
>> provides a reliable, architecturally defined method to ensure a clean
>> and known-good cache state before enabling translations.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c     | 33 +++++++++++++++++++++++++++++++++
>>   hw/arm/trace-events |  1 +
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 100caeeb35..432de88610 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -354,6 +354,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>>   
>>   }
>>   
>> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
>> +{
>> +    trace_smmuv3_invalidate_all_caches();
>> +    SMMUState *bs = &s->smmu_state;
>> +
>> +    /* Clear all cached configs including STE and CD */
>> +    if (bs->configs) {
>> +        g_hash_table_remove_all(bs->configs);
>> +    }
>> +
>> +    /* Invalidate all SMMU IOTLB entries */
>> +    smmu_inv_notifiers_all(&s->smmu_state);
>> +    smmu_iotlb_inv_all(bs);
>> +}
>> +
>>   static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                                                    SMMUTransCfg *cfg,
>>                                                    SMMUEventInfo *event,
>> @@ -1969,6 +1984,21 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>   
>>           bank->eventq_irq_cfg2 = data;
>>           return MEMTX_OK;
>> +    case (A_S_INIT & 0xfff):
> why do we apply & 0xfff ?



Let me clarify what I was trying to do with the `(A_S_INIT & 0xfff)` 
case, and then ask your opinion on how to clean this up.

According to the SMMUv3 spec , registers with the same function across 
different security states (Non-secure, Realm, Root) share the same 
*relative* offset within their 4KB bank window. In the MMIO handlers we 
first decode the bank from the high bits of the offset (to get 
`reg_sec_sid`), and then do:

     uint32_t reg_offset = offset & 0xfff;

     switch (reg_offset) {
         ...
     }

So the `switch` is really operating on the per-bank 4KB-relative offset, 
and the banked registers can share the same `case` logic while 
`reg_sec_sid` selects which bank structure we actually touch.

Most of the `A_*` macros (e.g. `A_CR0`) are already defined as these 
relative offsets (just the low 12 bits), so they fit naturally in this 
scheme and we can simply write `case A_CR0:`.

`A_S_INIT`, however, is still defined as an *absolute* offset that 
already includes the secure-bank base. Since the `switch` is matching on 
`reg_offset = offset & 0xfff`, I ended up writing:

     case (A_S_INIT & 0xfff):

as a shortcut to adapt an absolute macro to the “relative” decode. 
S_INIT is also a secure-only register, so there is no NS twin that I 
could reuse as the shared low-12-bit macro. In practice that makes 
S_INIT a one-off special case in the current code, which is why the `& 
0xfff` sticks out.


I agree this looks more like a hack than a clean design, so I’d like to 
rework it in the next version. I see a couple of possible directions and 
would appreciate your view on which one is preferable:

1) Stop using NS macros as the canonical case labels and list all 
bank-specific variants explicitly.

    Instead of relying on a single “NS” macro for the shared low-12-bit 
offset, we could have:

        switch (reg_offset) {
        case A_STRTAB_BASE_CFG:
        case A_S_STRTAB_BASE_CFG:
            ...
            break;
        }

    This makes the banked nature explicit in the `switch` and avoids 
relying on NS as the “reference” definition. The bank selection would 
still be driven by `reg_sec_sid`, but the case labels themselves would 
be per-bank macros where that makes sense.

2) Go back to the v2 [1] idea and introduce a dedicated S_INIT-relative 
alias macro.

    As I had in v2, we could define a separate macro that encodes only 
the relative offset, e.g. something like:

         REG32(S_INIT,               0x803c)
             FIELD(S_INIT, INV_ALL,    0, 1)
         /* Alias for the S_INIT offset to match in the dispatcher switch */
         #define A_S_INIT_ALIAS         0x3c


    and then the decode would simply use:

        switch (reg_offset) {
        case A_S_INIT_ALIAS:
            ...
            break;
        }

    This keeps the “absolute” constant for the secure MMIO layout (if we 
still find that useful elsewhere), but makes the decode logic work 
entirely in terms of relative offsets and removes the inline.

3) Keep the current implementation and add some comment about it.


Which option would you prefer? Any other thoughts or suggestions would 
be greatly appreciated.


[1] 
https://lore.kernel.org/qemu-devel/7161c00c-c519-4e90-9dca-99bcf7518d40@redhat.com/



>> +        if (data & R_S_INIT_INV_ALL_MASK) {
>> +            int cr0_smmuen = smmu_enabled(s, reg_sec_sid);
>> +            int s_cr0_smmuen = smmuv3_get_cr0ack_smmuen(s, reg_sec_sid);
>> +            if (cr0_smmuen || s_cr0_smmuen) {
> use smmuv3_is_smmu_enabled()?


Yes using smmuv3_is_smmu_enabled is a better choice. And I'll check both 
CR0.SMMUEN and S_CR0.SMMUEN in V4. As I found *any SMMU_(*_)CR0.SMMUEN 
== 1* descriptions in 6.3.62 SMMU_S_INIT ARM IHI 0070 G.b:

 > If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any 
SMMU_(*_)CR0.SMMUEN == 1,
 >     or an Update of any SMMUEN to 1 is in progress ........ , is 
CONSTRAINED UNPREDICTABLE......


Thanks for your review.


Yours,

Tao

>> +                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
>> +                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
>> +                              "CR0.SMMUEN=%d or S_CR0.SMMUEN=%d is set\n",
>> +                              cr0_smmuen, s_cr0_smmuen);
>> +                return MEMTX_OK;
>> +            }
>> +            smmuv3_invalidate_all_caches(s);
>> +        }
>> +        /* Synchronous emulation: invalidation completed instantly. */
>> +        return MEMTX_OK;
>>       default:
>>           qemu_log_mask(LOG_UNIMP,
>>                         "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
>> @@ -2172,6 +2202,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>>       case A_EVENTQ_CONS:
>>           *data = bank->eventq.cons;
>>           return MEMTX_OK;
>> +    case (A_S_INIT & 0xfff):
>> +        *data = 0;
>> +        return MEMTX_OK;
>>       default:
>>           *data = 0;
>>           qemu_log_mask(LOG_UNIMP,
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 434d6abfc2..0e7ad8fee3 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -64,6 +64,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>>   smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>>   smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>>   smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>> +smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
>>   smmu_reset_exit(void) ""
>>   
>>   # strongarm.c
> Thanks
>
> Eric


