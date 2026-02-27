Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6012103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5uu-0000nq-Rg; Fri, 27 Feb 2026 17:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5uo-0000mh-Su
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:02:30 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5um-0005W5-Be
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:02:30 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso18001235ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229746; x=1772834546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y9sp0/JzOhL4IYezj/NIeqisTxzSea44/cDA2bqR6yE=;
 b=jc15Dfw9qiZ+lRuKkbRb3s0+eaTPQGaa0g4rEkFt6Wb/NYn/ufzShJbiKGOaNd7CBg
 uGzkXIeFAl2xsg3DaTyhe+Rzgpu3o5K0jws/o7K9lBgZerQb0Jb8GpUfh0cxPMV1EbbL
 K994EgTQHizDQ6di1HPr4LTZlkQ11uqREcSO4bu3ECwMzvMcMc1O5nxqFZS6+Y8x1KGv
 fs1i3lt+PsoULbM4KEmgyN2ZOhZHoewwrM+WhmpM6eB+w948NI5ZNlBGpepweKUbFTLv
 iS9fCWdaqFnhV2wSShwQiyLAV0VM9AgerU+Wb5rSEaUdZPydWjVru9qsNoFhrfQOU/4N
 ZB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229746; x=1772834546;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9sp0/JzOhL4IYezj/NIeqisTxzSea44/cDA2bqR6yE=;
 b=WWYT9Rs0PNjIVhemgTWEv53rUxwc90mvli5Rg1z+glmcAmrhPizFo82TfwIIZgUuJG
 z8sKUjMExri4PjTsCcQas5fy0i8GxweC5ODV8ZYVnlkdV4Mv1HjToS3pBnWeLmye9F7h
 sYbqH7PMBT2vib7JzSUX3xurZ/uOPQz3OAgYv21I7Ad3bFYozkf+kA9A475pHD/xtiko
 TsCOAZQB8Jsm2Q6EHkvdDyoV8pRxmq6MyV/4OTU1TybCwQ4j8tTkzTsdh1FJ3Y7+txe2
 ZSWAwV7VmZtJC7g8hQG164CSQFt7BUP5t0NX7u3zM1gbxsdcwofOz6mNgdzim0F7brsB
 oPeQ==
X-Gm-Message-State: AOJu0YzdNzguFd1tCoQDm4tStG4b5Cy1qQk4V2N+WIiMINLkqwDgE3bO
 O/h00kyuJBc62yKl3s1Y1NkL5zgckG+aiugOODRcOg1yeWPQNlOtM4Ow03SoDs0Qhyk=
X-Gm-Gg: ATEYQzx6MIIaBZLlIg9wcF4H6rkr2uy4ynKtgI/1kopsqTEE0Zm3QaM4r6G4rjLqMKn
 hfK0KIF1/5STjkiXqRZHf1pnuDnwQFGn4YRlM7T/vpPtj/KD2DloNjgMoJufJBy/JzEXXr6CJbK
 UURsZ8ZfBuE4/Ie76y6dH488zOOhiRNHNlX/lNm+6cIWoM0VO3hK3GzpcwY5u8aEdyJA8uTc1J7
 hgKjWChutaGInOI10vv3B3jPIcmlfpMi++qbMOZ/ORgpAMaevdye4ioDXntx4UymjA39Dwaqdvl
 JUVEuHxNeIkmHyVbkmenET9EQN7WR5070WyoRzEO+Bonlw/QluEwBqbUtxOgRPu7XTL54UDyR7N
 eWE6gzAj+lSUTdOYkAl+d3hApTfF+2L3XlOCNk2QTmEgFQ7vd9SJJi+4GUBCSGBh9HlgotUrAaK
 RMGCznoI24BxeLg3bTlUvpK5g2aIIbAf9mugENwGT1tunNGkRXDiLgsRlnrc/toTziJhS5
X-Received: by 2002:a17:903:41cb:b0:2ad:ba04:40ca with SMTP id
 d9443c01a7336-2ae2e419430mr42316735ad.25.1772229745615; 
 Fri, 27 Feb 2026 14:02:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6a0432sm98368445ad.52.2026.02.27.14.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:02:25 -0800 (PST)
Message-ID: <6057721c-1fca-45bf-acd2-f5990e8aea68@linaro.org>
Date: Fri, 27 Feb 2026 14:02:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 08/31] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-9-tangtao1634@phytium.com.cn>
 <e39d683f-5f0a-4528-bbbb-811dfaa37d69@linaro.org>
 <6288fb9e-9ddc-459d-bb7d-28242f83f9c2@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <6288fb9e-9ddc-459d-bb7d-28242f83f9c2@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/27/26 7:20 AM, Tao Tang wrote:
> Hi Pierrick,
> 
> On 2026/2/26 04:52, Pierrick Bouvier wrote:
>> On 2/21/26 2:02 AM, Tao Tang wrote:
>>> As a preliminary step towards a multi-security-state configuration
>>> cache, introduce MemTxAttrs and AddressSpace * members to the
>>> SMMUTransCfg struct. The goal is to cache these attributes so that
>>> internal functions can use them directly.
>>>
>>> To facilitate this, hw/arm/arm-security.h is now included in
>>> smmu-common.h. This is a notable change, as it marks the first time
>>> these Arm CPU-specific security space definitions are used outside of
>>> cpu.h, making them more generally available for device models.
>>>
>>> The decode helpers (smmu_get_ste, smmu_get_cd, smmu_find_ste,
>>> smmuv3_get_config) are updated to use these new attributes for memory
>>> accesses. This ensures that reads of SMMU structures from memory, such
>>> as the Stream Table, use the correct security context.
>>>
>>> For the special case of smmuv3-accel.c, we only support the NS-only path
>>> for now. Therefore, we initialize a minimal cfg with sec_sid, txattrs,
>>> and as for the NS-only accel path.
>>>
>>> For now, the configuration cache lookup key remains unchanged and is
>>> still based solely on the SMMUDevice pointer. The new attributes are
>>> populated during a cache miss in smmuv3_get_config. And some paths still
>>> rely on the NS-only address_space_memory, for example smmuv3_notify_iova
>>> and get_pte(). These will be progressively converted in follow-up
>>> commits
>>> to use an AddressSpace selected according to SEC_SID.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>    hw/arm/smmu-common.c         | 19 ++++++++++++++++++
>>>    hw/arm/smmuv3-accel.c        | 12 +++++++++++-
>>>    hw/arm/smmuv3-internal.h     |  3 ++-
>>>    hw/arm/smmuv3.c              | 38 ++++++++++++++++++++++--------------
>>>    include/hw/arm/smmu-common.h | 12 ++++++++++++
>>>    5 files changed, 67 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 3baba2a4c8e..b320aec8c60 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -30,6 +30,25 @@
>>>    #include "hw/arm/smmu-common.h"
>>>    #include "smmu-internal.h"
>>>    +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>>> +{
>>> +    switch (sec_sid) {
>>> +    case SMMU_SEC_SID_S:
>>> +        return ARMSS_Secure;
>>> +    case SMMU_SEC_SID_NS:
>>> +    default:
>>> +        return ARMSS_NonSecure;
>>> +    }
>>> +}
>>> +
>>> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
>>> +{
>>> +    return (MemTxAttrs) {
>>> +        .secure = sec_sid > SMMU_SEC_SID_NS ? 1 : 0,
>>> +        .space = smmu_get_security_space(sec_sid),
>>> +    };
>>> +}
>>> +
>>>    AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
>>>    {
>>>        switch (sec_sid) {
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index fdcb15005ea..9a41391826b 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -244,6 +244,16 @@ bool smmuv3_accel_install_ste(SMMUv3State *s,
>>> SMMUDevice *sdev, int sid,
>>>        const char *type;
>>>        STE ste;
>>>        SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>> +    /*
>>> +     * smmu_find_ste() requires a SMMUTransCfg to provide address
>>> space and
>>> +     * transaction attributes for DMA reads. Only NS state is
>>> supported here.
>>> +     */
>>> +    SMMUState *bc = &s->smmu_state;
>>> +    SMMUTransCfg cfg = {
>>> +        .sec_sid = sec_sid,
>>> +        .txattrs = smmu_get_txattrs(sec_sid),
>>> +        .as = smmu_get_address_space(bc, sec_sid),
>>> +    };
>>>          if (!accel || !accel->viommu) {
>>>            return true;
>>> @@ -259,7 +269,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s,
>>> SMMUDevice *sdev, int sid,
>>>            return false;
>>>        }
>>>    -    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
>>> +    if (smmu_find_ste(sdev->smmu, sid, &ste, &event, &cfg)) {
>>>            /* No STE found, nothing to install */
>>>            return true;
>>>        }
>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>> index a1071f7b689..6d29b9027f0 100644
>>> --- a/hw/arm/smmuv3-internal.h
>>> +++ b/hw/arm/smmuv3-internal.h
>>> @@ -363,7 +363,8 @@ typedef struct SMMUEventInfo {
>>>        } while (0)
>>>      void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
>>> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event);
>>> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event,
>>> +                  SMMUTransCfg *cfg);
>>>      static inline int oas2bits(int oas_field)
>>>    {
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 3438adcecd2..2192bec2368 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -347,14 +347,13 @@ static void smmuv3_reset(SMMUv3State *s)
>>>    }
>>>      static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>>> -                        SMMUEventInfo *event)
>>> +                        SMMUEventInfo *event, SMMUTransCfg *cfg)
>>>    {
>>>        int ret, i;
>>>          trace_smmuv3_get_ste(addr);
>>>        /* TODO: guarantee 64-bit single-copy atomicity */
>>> -    ret = dma_memory_read(&address_space_memory, addr, buf,
>>> sizeof(*buf),
>>> -                          MEMTXATTRS_UNSPECIFIED);
>>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf),
>>> cfg->txattrs);
>>>        if (ret != MEMTX_OK) {
>>>            qemu_log_mask(LOG_GUEST_ERROR,
>>>                          "Cannot fetch pte at address=0x%"PRIx64"\n",
>>> addr);
>>> @@ -399,8 +398,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste,
>>> SMMUTransCfg *cfg,
>>>        }
>>>          /* TODO: guarantee 64-bit single-copy atomicity */
>>> -    ret = dma_memory_read(&address_space_memory, addr, buf,
>>> sizeof(*buf),
>>> -                          MEMTXATTRS_UNSPECIFIED);
>>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf),
>>> cfg->txattrs);
>>>        if (ret != MEMTX_OK) {
>>>            qemu_log_mask(LOG_GUEST_ERROR,
>>>                          "Cannot fetch pte at address=0x%"PRIx64"\n",
>>> addr);
>>> @@ -655,17 +653,19 @@ bad_ste:
>>>     * @sid: stream ID
>>>     * @ste: returned stream table entry
>>>     * @event: handle to an event info
>>> + * @cfg: translation configuration cache
>>>     *
>>>     * Supports linear and 2-level stream table
>>>     * Return 0 on success, -EINVAL otherwise
>>>     */
>>> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event)
>>> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event,
>>> +                  SMMUTransCfg *cfg)
>>>    {
>>>        dma_addr_t addr, strtab_base;
>>>        uint32_t log2size;
>>>        int strtab_size_shift;
>>>        int ret;
>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>> +    SMMUSecSID sec_sid = cfg->sec_sid;
>>>        SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>          trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
>>> @@ -693,8 +693,8 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
>>> STE *ste, SMMUEventInfo *event)
>>>            l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
>>>            l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset *
>>> sizeof(l1std));
>>>            /* TODO: guarantee 64-bit single-copy atomicity */
>>> -        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
>>> -                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
>>> +        ret = dma_memory_read(cfg->as, l1ptr, &l1std, sizeof(l1std),
>>> +                              cfg->txattrs);
>>>            if (ret != MEMTX_OK) {
>>>                qemu_log_mask(LOG_GUEST_ERROR,
>>>                              "Could not read L1PTR at 0X%"PRIx64"\n",
>>> l1ptr);
>>> @@ -736,7 +736,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
>>> STE *ste, SMMUEventInfo *event)
>>>            addr = strtab_base + sid * sizeof(*ste);
>>>        }
>>>    -    if (smmu_get_ste(s, addr, ste, event)) {
>>> +    if (smmu_get_ste(s, addr, ste, event, cfg)) {
>>>            return -EINVAL;
>>>        }
>>>    @@ -865,7 +865,7 @@ static int
>>> smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>>        /* ASID defaults to -1 (if s1 is not supported). */
>>>        cfg->asid = -1;
>>>    -    ret = smmu_find_ste(s, sid, &ste, event);
>>> +    ret = smmu_find_ste(s, sid, &ste, event, cfg);
>>>        if (ret) {
>>>            return ret;
>>>        }
>>> @@ -899,7 +899,8 @@ static int smmuv3_decode_config(IOMMUMemoryRegion
>>> *mr, SMMUTransCfg *cfg,
>>>     * decoding under the form of an SMMUTransCfg struct. The hash
>>> table is indexed
>>>     * by the SMMUDevice handle.
>>>     */
>>> -static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev,
>>> SMMUEventInfo *event)
>>> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev,
>>> SMMUEventInfo *event,
>>> +                                       SMMUSecSID sec_sid)
>>>    {
>>>        SMMUv3State *s = sdev->smmu;
>>>        SMMUState *bc = &s->smmu_state;
>>> @@ -919,7 +920,14 @@ static SMMUTransCfg
>>> *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>>>                                100 * sdev->cfg_cache_hits /
>>>                                (sdev->cfg_cache_hits +
>>> sdev->cfg_cache_misses));
>>>            cfg = g_new0(SMMUTransCfg, 1);
>>> -        cfg->sec_sid = SMMU_SEC_SID_NS;
>>> +        cfg->sec_sid = sec_sid;
>>> +        cfg->txattrs = smmu_get_txattrs(sec_sid);
>>> +        cfg->as = smmu_get_address_space(bc, sec_sid);
>>> +        cfg->ns_as = (sec_sid > SMMU_SEC_SID_NS)
>>> +                     ? smmu_get_address_space(bc, SMMU_SEC_SID_NS)
>>> +                     : cfg->as;
>>> +        /* AddressSpace must be available, assert if not. */
>>> +        g_assert(cfg->as && cfg->ns_as);
>>>              if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>>>                g_hash_table_insert(bc->configs, sdev, cfg);
>>> @@ -1101,7 +1109,7 @@ static IOMMUTLBEntry
>>> smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>            goto epilogue;
>>>        }
>>>    -    cfg = smmuv3_get_config(sdev, &event);
>>> +    cfg = smmuv3_get_config(sdev, &event, sec_sid);
>>>        if (!cfg) {
>>>            status = SMMU_TRANS_ERROR;
>>>            goto epilogue;
>>> @@ -1183,7 +1191,7 @@ static void
>>> smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>        SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>        SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>>                                   .inval_ste_allowed = true};
>>> -    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>>> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>>>        IOMMUTLBEvent event;
>>>        uint8_t granule;
>>>    diff --git a/include/hw/arm/smmu-common.h
>>> b/include/hw/arm/smmu-common.h
>>> index b3ca55effc5..7944e8d1b64 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -22,6 +22,7 @@
>>>    #include "hw/core/sysbus.h"
>>>    #include "hw/pci/pci.h"
>>>    #include "qom/object.h"
>>> +#include "hw/arm/arm-security.h"
>>>      #define SMMU_PCI_BUS_MAX                    256
>>>    #define SMMU_PCI_DEVFN_MAX                  256
>>> @@ -47,6 +48,9 @@ typedef enum SMMUSecSID {
>>>        SMMU_SEC_SID_NUM,
>>>    } SMMUSecSID;
>>>    +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
>>> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
>>> +
>>>    /*
>>>     * Page table walk error types
>>>     */
>>> @@ -124,6 +128,14 @@ typedef struct SMMUTransCfg {
>>>        SMMUTransTableInfo tt[2];
>>>        /* Used by stage-2 only. */
>>>        struct SMMUS2Cfg s2cfg;
>>> +    MemTxAttrs txattrs;        /* cached transaction attributes */
>>> +    /*
>>> +     * Cached AS related to the SEC_SID, which will be statically
>>> marked, and
>>> +     * in future RME support it will be implemented as a dynamic
>>> switch.
>>> +     */
>>> +    AddressSpace *as;
>>> +    /* Cached NS AS. It will be used if previous SEC_SID !=
>>> SMMU_SEC_SID_NS. */
>>> +    AddressSpace *ns_as;
>>>    } SMMUTransCfg;
>>>
>>
>> As an alternative, you can simply pass SMMUState where it's missing
>> (like smmu_ptw_64_s2) and call smmu_get_address_space from there.
>> It will avoid having to keep this in cfg.
>>
>> Maybe there is another reason I missed?
> 
> 
> My original motivation for having an extra ns_as (and caching
> as/txattrs) was tied to the architectural semantics: a transaction being
> "secure" does not automatically mean the walk can access Secure PAS.
> Whether the walk can touch Secure PAS (or is effectively constrained to
> Non-secure PAS) is determined by the STE/CD fields and the page-table
> attributes at each level; in an RME setup we would also add GPC checks.
> So, if the combined state ends up forcing Non-secure PAS, the intent was
> to reuse a preselected NS address space rather than re-deriving it
> repeatedly during the walk.
> 
> That said, I agree that keeping as/txattrs (and ns_as) inside
> SMMUTransCfg is debatable, and it also blurs “decoded translation
> config” versus “per-walk execution context”. Eric previously suggested
> caching as and MemTxAttrs in v2 to streamline the hot path:
> 
> https://lore.kernel.org/qemu-devel/4b90afba-d708-4628-a087-c16829ee0512@redhat.com/
> 
> 
> But given your feedback, I’m leaning toward your alternative. In
> particular, with your recent commit (53b54a8 "add memory regions as
> property for an SMMU instance"), selecting the appropriate AddressSpace
> is very cheap. So I think it’s reasonable to refactor now: pass
> SMMUState where it’s missing (e.g. in smmu_ptw_64_s2) and compute
> AddressSpace/MemTxAttrs on-demand based on the current walk state,
> instead of caching them in SMMUTransCfg.
> 

It's indeed trivial to derive address space from cfg->sec_sid, and 
clearer since we'll always provide a sec_sid to access it, so I don't 
see any good reason left to cache it.

Eric, would you be ok with it?

> 
> I’ll rework the patch accordingly, and I’d also very much welcome any
> further comments or suggestions from others.
> 
> 
>>
>> Regards,
>> Pierrick
> 
> 
> Thanks,
> 
> Tao
> 


