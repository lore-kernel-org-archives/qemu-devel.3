Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CC8EA4E29
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 16:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx5gH-0004Tg-Kd; Mon, 02 Mar 2026 10:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx5gB-0004Sv-Un
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx5g7-0004EL-RI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772467166;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3/CZEFxVbjIE1rLAvD90qcp7mn3FJg8ZBqDSwwY81I=;
 b=dUX34E0xqn+mGK9w8+JKzUf4ldYn+yL6OzEfpkjGD+WD35GRQlzrX2SuQC4NpFnZgaEFLI
 rhpK3wUCD9qEhytDCiFDYS1epAEqKb+5G2uOM5E2CtDaDozrejUkPNQYZgfrGFq2JkraVU
 Ie8JxuS09EHsI64pnxd6vRxKVCm2DUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-PuXTKgJDPnawubSQoo4vnQ-1; Mon, 02 Mar 2026 10:59:24 -0500
X-MC-Unique: PuXTKgJDPnawubSQoo4vnQ-1
X-Mimecast-MFC-AGG-ID: PuXTKgJDPnawubSQoo4vnQ_1772467164
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a24db6ecso55971555e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 07:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467164; x=1773071964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3/CZEFxVbjIE1rLAvD90qcp7mn3FJg8ZBqDSwwY81I=;
 b=h/Z6rZw5xOc9dxsgxgGsFiSJEW0lmp0iXgeQGh/6i1mI0ldkFXx616pxUnmpOIjRE5
 QKp4CNY3F6/MN5KMyNL6p1WOCgo6/65HhA/OLOVzmOUnjfoYa0XqeM3bSxOS0Q8zWuYh
 caqYqAWkFF43U1cug2RHw0nt9kzpCLVu0VTKnd6Sr4EGjEixaUbKMU8EsAC5thvfVz6z
 a+7dbI46n/adWNfD9ot+7zGjz43goqHVmxpXi2rLre4Q5XpdApoEC+3EFLLKY1x5PhCq
 VCF8kjaWplIBrHmzaCO/QrC02y5eZk96UGfq7BAPoL5MkDoL17ARcI53L9y5/Jsix73t
 Nn/Q==
X-Gm-Message-State: AOJu0Yx8bHbPlSaXqzuDxyVFog/xe1XsgijwqKIdJjedTQdLCN/FD7D+
 Up7zHTSJyvPxVlDfh+pTAGnjygrGxLSs61Y4cMckvSq5jIOMSjKkl43JpqmU0z/FFMHbwYK8Nhz
 4C5tyE2UgoaKyLuxMyCviOvW3K/mJDAxzIiHeloe0hdjpHJmk6u9PI+SY
X-Gm-Gg: ATEYQzzUkdiUGEj1tivuqJeQxF4IqCZUFh9rQUQlxuvRw5xcVvo23cBN3fh7GFlNWqM
 yq+eTSlwcc/hJLb05yJF/B1olmraFDn3KhGeobA16hQzs2UBJBioBifto+WzN1miiMUpRPIUOI9
 tk9KrYzHxbk9HZ3F8bZqSHCQMVPTlfVCZTfAtoYwPZWjHxHG0R7vuU3zDyLorBqYwnnhA7jW9OP
 i3EjRgJueCsrXyDwHWY6goczMBXV6QfLi/i40MLYzqIzUi8dcyDeyJefg1+BXm6uDxv7GIwg/sc
 etkGytmuAvZZeZpGlCKUMb0JNew4Ev8VVDf8Rm8W39/spqnjgs7NdsDAbPE41uMGzVZTH4kRUeD
 Hk2jlP4Jg0K7PTqqXzTfz/n21GLYb9OMMtKhGkUUEjSe4Z59h3yciA9uXU1MW0XMV8lEh7Q==
X-Received: by 2002:a05:600c:46c4:b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-483c9c2143emr215824225e9.29.1772467163534; 
 Mon, 02 Mar 2026 07:59:23 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-483c9c2143emr215823625e9.29.1772467162924; 
 Mon, 02 Mar 2026 07:59:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb318fsm208849095e9.6.2026.03.02.07.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 07:59:22 -0800 (PST)
Message-ID: <85538690-ab6c-4d2d-9287-10d9c8a5fc03@redhat.com>
Date: Mon, 2 Mar 2026 16:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 08/31] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6288fb9e-9ddc-459d-bb7d-28242f83f9c2@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/27/26 4:20 PM, Tao Tang wrote:
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
>>> For the special case of smmuv3-accel.c, we only support the NS-only
>>> path
>>> for now. Therefore, we initialize a minimal cfg with sec_sid, txattrs,
>>> and as for the NS-only accel path.
>>>
>>> For now, the configuration cache lookup key remains unchanged and is
>>> still based solely on the SMMUDevice pointer. The new attributes are
>>> populated during a cache miss in smmuv3_get_config. And some paths
>>> still
>>> rely on the NS-only address_space_memory, for example
>>> smmuv3_notify_iova
>>> and get_pte(). These will be progressively converted in follow-up
>>> commits
>>> to use an AddressSpace selected according to SEC_SID.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmu-common.c         | 19 ++++++++++++++++++
>>>   hw/arm/smmuv3-accel.c        | 12 +++++++++++-
>>>   hw/arm/smmuv3-internal.h     |  3 ++-
>>>   hw/arm/smmuv3.c              | 38
>>> ++++++++++++++++++++++--------------
>>>   include/hw/arm/smmu-common.h | 12 ++++++++++++
>>>   5 files changed, 67 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 3baba2a4c8e..b320aec8c60 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -30,6 +30,25 @@
>>>   #include "hw/arm/smmu-common.h"
>>>   #include "smmu-internal.h"
>>>   +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
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
>>>   AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID
>>> sec_sid)
>>>   {
>>>       switch (sec_sid) {
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index fdcb15005ea..9a41391826b 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -244,6 +244,16 @@ bool smmuv3_accel_install_ste(SMMUv3State *s,
>>> SMMUDevice *sdev, int sid,
>>>       const char *type;
>>>       STE ste;
>>>       SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
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
>>>         if (!accel || !accel->viommu) {
>>>           return true;
>>> @@ -259,7 +269,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s,
>>> SMMUDevice *sdev, int sid,
>>>           return false;
>>>       }
>>>   -    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
>>> +    if (smmu_find_ste(sdev->smmu, sid, &ste, &event, &cfg)) {
>>>           /* No STE found, nothing to install */
>>>           return true;
>>>       }
>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>> index a1071f7b689..6d29b9027f0 100644
>>> --- a/hw/arm/smmuv3-internal.h
>>> +++ b/hw/arm/smmuv3-internal.h
>>> @@ -363,7 +363,8 @@ typedef struct SMMUEventInfo {
>>>       } while (0)
>>>     void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
>>> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event);
>>> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event,
>>> +                  SMMUTransCfg *cfg);
>>>     static inline int oas2bits(int oas_field)
>>>   {
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 3438adcecd2..2192bec2368 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -347,14 +347,13 @@ static void smmuv3_reset(SMMUv3State *s)
>>>   }
>>>     static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>>> -                        SMMUEventInfo *event)
>>> +                        SMMUEventInfo *event, SMMUTransCfg *cfg)
>>>   {
>>>       int ret, i;
>>>         trace_smmuv3_get_ste(addr);
>>>       /* TODO: guarantee 64-bit single-copy atomicity */
>>> -    ret = dma_memory_read(&address_space_memory, addr, buf,
>>> sizeof(*buf),
>>> -                          MEMTXATTRS_UNSPECIFIED);
>>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf),
>>> cfg->txattrs);
>>>       if (ret != MEMTX_OK) {
>>>           qemu_log_mask(LOG_GUEST_ERROR,
>>>                         "Cannot fetch pte at address=0x%"PRIx64"\n",
>>> addr);
>>> @@ -399,8 +398,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste,
>>> SMMUTransCfg *cfg,
>>>       }
>>>         /* TODO: guarantee 64-bit single-copy atomicity */
>>> -    ret = dma_memory_read(&address_space_memory, addr, buf,
>>> sizeof(*buf),
>>> -                          MEMTXATTRS_UNSPECIFIED);
>>> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf),
>>> cfg->txattrs);
>>>       if (ret != MEMTX_OK) {
>>>           qemu_log_mask(LOG_GUEST_ERROR,
>>>                         "Cannot fetch pte at address=0x%"PRIx64"\n",
>>> addr);
>>> @@ -655,17 +653,19 @@ bad_ste:
>>>    * @sid: stream ID
>>>    * @ste: returned stream table entry
>>>    * @event: handle to an event info
>>> + * @cfg: translation configuration cache
>>>    *
>>>    * Supports linear and 2-level stream table
>>>    * Return 0 on success, -EINVAL otherwise
>>>    */
>>> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event)
>>> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>> SMMUEventInfo *event,
>>> +                  SMMUTransCfg *cfg)
>>>   {
>>>       dma_addr_t addr, strtab_base;
>>>       uint32_t log2size;
>>>       int strtab_size_shift;
>>>       int ret;
>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>> +    SMMUSecSID sec_sid = cfg->sec_sid;
>>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>         trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
>>> @@ -693,8 +693,8 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
>>> STE *ste, SMMUEventInfo *event)
>>>           l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
>>>           l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset *
>>> sizeof(l1std));
>>>           /* TODO: guarantee 64-bit single-copy atomicity */
>>> -        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
>>> -                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
>>> +        ret = dma_memory_read(cfg->as, l1ptr, &l1std, sizeof(l1std),
>>> +                              cfg->txattrs);
>>>           if (ret != MEMTX_OK) {
>>>               qemu_log_mask(LOG_GUEST_ERROR,
>>>                             "Could not read L1PTR at 0X%"PRIx64"\n",
>>> l1ptr);
>>> @@ -736,7 +736,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
>>> STE *ste, SMMUEventInfo *event)
>>>           addr = strtab_base + sid * sizeof(*ste);
>>>       }
>>>   -    if (smmu_get_ste(s, addr, ste, event)) {
>>> +    if (smmu_get_ste(s, addr, ste, event, cfg)) {
>>>           return -EINVAL;
>>>       }
>>>   @@ -865,7 +865,7 @@ static int
>>> smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>>       /* ASID defaults to -1 (if s1 is not supported). */
>>>       cfg->asid = -1;
>>>   -    ret = smmu_find_ste(s, sid, &ste, event);
>>> +    ret = smmu_find_ste(s, sid, &ste, event, cfg);
>>>       if (ret) {
>>>           return ret;
>>>       }
>>> @@ -899,7 +899,8 @@ static int
>>> smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>>    * decoding under the form of an SMMUTransCfg struct. The hash
>>> table is indexed
>>>    * by the SMMUDevice handle.
>>>    */
>>> -static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev,
>>> SMMUEventInfo *event)
>>> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev,
>>> SMMUEventInfo *event,
>>> +                                       SMMUSecSID sec_sid)
>>>   {
>>>       SMMUv3State *s = sdev->smmu;
>>>       SMMUState *bc = &s->smmu_state;
>>> @@ -919,7 +920,14 @@ static SMMUTransCfg
>>> *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>>>                               100 * sdev->cfg_cache_hits /
>>>                               (sdev->cfg_cache_hits +
>>> sdev->cfg_cache_misses));
>>>           cfg = g_new0(SMMUTransCfg, 1);
>>> -        cfg->sec_sid = SMMU_SEC_SID_NS;
>>> +        cfg->sec_sid = sec_sid;
>>> +        cfg->txattrs = smmu_get_txattrs(sec_sid);
>>> +        cfg->as = smmu_get_address_space(bc, sec_sid);
>>> +        cfg->ns_as = (sec_sid > SMMU_SEC_SID_NS)
>>> +                     ? smmu_get_address_space(bc, SMMU_SEC_SID_NS)
>>> +                     : cfg->as;
>>> +        /* AddressSpace must be available, assert if not. */
>>> +        g_assert(cfg->as && cfg->ns_as);
>>>             if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>>>               g_hash_table_insert(bc->configs, sdev, cfg);
>>> @@ -1101,7 +1109,7 @@ static IOMMUTLBEntry
>>> smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>           goto epilogue;
>>>       }
>>>   -    cfg = smmuv3_get_config(sdev, &event);
>>> +    cfg = smmuv3_get_config(sdev, &event, sec_sid);
>>>       if (!cfg) {
>>>           status = SMMU_TRANS_ERROR;
>>>           goto epilogue;
>>> @@ -1183,7 +1191,7 @@ static void
>>> smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>       SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>       SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>>                                  .inval_ste_allowed = true};
>>> -    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>>> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>>>       IOMMUTLBEvent event;
>>>       uint8_t granule;
>>>   diff --git a/include/hw/arm/smmu-common.h
>>> b/include/hw/arm/smmu-common.h
>>> index b3ca55effc5..7944e8d1b64 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -22,6 +22,7 @@
>>>   #include "hw/core/sysbus.h"
>>>   #include "hw/pci/pci.h"
>>>   #include "qom/object.h"
>>> +#include "hw/arm/arm-security.h"
>>>     #define SMMU_PCI_BUS_MAX                    256
>>>   #define SMMU_PCI_DEVFN_MAX                  256
>>> @@ -47,6 +48,9 @@ typedef enum SMMUSecSID {
>>>       SMMU_SEC_SID_NUM,
>>>   } SMMUSecSID;
>>>   +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
>>> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
>>> +
>>>   /*
>>>    * Page table walk error types
>>>    */
>>> @@ -124,6 +128,14 @@ typedef struct SMMUTransCfg {
>>>       SMMUTransTableInfo tt[2];
>>>       /* Used by stage-2 only. */
>>>       struct SMMUS2Cfg s2cfg;
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
>>>   } SMMUTransCfg;
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
> as/txattrs) was tied to the architectural semantics: a transaction
> being "secure" does not automatically mean the walk can access Secure
> PAS. Whether the walk can touch Secure PAS (or is effectively
> constrained to Non-secure PAS) is determined by the STE/CD fields and
> the page-table attributes at each level; in an RME setup we would also
> add GPC checks. So, if the combined state ends up forcing Non-secure
> PAS, the intent was to reuse a preselected NS address space rather
> than re-deriving it repeatedly during the walk.
>
> That said, I agree that keeping as/txattrs (and ns_as) inside
> SMMUTransCfg is debatable, and it also blurs “decoded translation
> config” versus “per-walk execution context”. Eric previously suggested
> caching as and MemTxAttrs in v2 to streamline the hot path: 
I was rather suggesting splitting the patch to ease the review ;-)
>
> https://lore.kernel.org/qemu-devel/4b90afba-d708-4628-a087-c16829ee0512@redhat.com/
>
>
>
> But given your feedback, I’m leaning toward your alternative. In
> particular, with your recent commit (53b54a8 "add memory regions as
> property for an SMMU instance"), selecting the appropriate
> AddressSpace is very cheap. So I think it’s reasonable to refactor
> now: pass SMMUState where it’s missing (e.g. in smmu_ptw_64_s2) and
> compute AddressSpace/MemTxAttrs on-demand based on the current walk
> state, instead of caching them in SMMUTransCfg. 
>
SMMUTransCfg is rather supposed to cache info that were grabbed from
STE/CD with smmuv3_decode_config(). sec_sid rather is a property of the
DMA initiator [28/31] and thus does not relate to the SMMUTransConfig I
think. So I agree with Pierrick.

Thanks

Eric

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


