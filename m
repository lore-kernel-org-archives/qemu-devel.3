Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33831C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rruwn-0001fw-QY; Wed, 03 Apr 2024 03:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rruwl-0001fC-Vy
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 03:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rruwj-0002q4-Iq
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 03:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712128928;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQMAPqdBr/7tnh1nh05R9iTAilwmxSV62hdh4PxEnU0=;
 b=cbFGQ6ua8RX62h9UG1vwITKKIcq/YH2SLo1MEbWnocANP5RJkUcCDPXpr1S16bsqcaJ8+Y
 D0yWtImOVnhs2Tw63+k+Qr3wYz8jPtiVrg/tV5geojJzw3UllnW05awG26YUKO7UqD5Qj9
 LdpIbH7ImAvjZMaio6QnibatRJPGSWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-vSrNuSXXMIeERMAhT18ieQ-1; Wed, 03 Apr 2024 03:22:06 -0400
X-MC-Unique: vSrNuSXXMIeERMAhT18ieQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34368c5cadfso794493f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 00:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712128925; x=1712733725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQMAPqdBr/7tnh1nh05R9iTAilwmxSV62hdh4PxEnU0=;
 b=iqhWByVP/11OdPRbWuplMp7Jjo7YH2+cQzHbbHeYPo732x4IBU+w8rWlKLiD7ysov6
 lNGq/36zulCkHoXpKeO+FzmtT8SZW6Ok/JPdpdkzfokg2NcwB5cd6gG7ij5otOtLXnKq
 SjtRWWtYOl6uVQDAQcSBzcPxd5JijM73Vvxtm06PvvFZ8ugUWWH6rbUypU3vJKtFkpd/
 sglBTrBIXHsxczR9ZDVn5MFaHXP52vaR9/s0Dj72/VvwjzAHwrHFowonJziMhGc5Svex
 HU8q43X2E7Z+gjLSI+wLnmL6h1tMjN+ke0KbnWAZ9C7YgeYlDcx8rZYMCpJH4dAd1J6N
 NoQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6x0GcNUNtVHT7JhgalNRXoiiUD/8w3XrvLpqWpRnVaiECHmSaspTfT23bUDcuIQMM+Oaz6XDROa+JoGyPjzRghRWdKM0=
X-Gm-Message-State: AOJu0YxSfTydVzU3Yz18VuDqEz7JBUhvMXroRlEPFIBm0D+STS5+t0KR
 GT/Kh9yiKHnqfM4/2uhOEJUDMOXzXhgzhqZmTtZbIbNzudMGNMkXo/mP5R9aXfRZMfegIj6cYHo
 Op130eAP84qWB/aZLyZhdTwNZ2fHSBMnlZAbgpDTkV5QKsw+kRizo
X-Received: by 2002:a5d:6487:0:b0:343:77d3:5ee2 with SMTP id
 o7-20020a5d6487000000b0034377d35ee2mr2593922wri.35.1712128925475; 
 Wed, 03 Apr 2024 00:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGIHzv4Yp4JSTQsXjBt33QtfikgYenLqqQUNgppJ7zcXDYMT9930AeBLaW2A/40e+FonnbzA==
X-Received: by 2002:a5d:6487:0:b0:343:77d3:5ee2 with SMTP id
 o7-20020a5d6487000000b0034377d35ee2mr2593905wri.35.1712128925007; 
 Wed, 03 Apr 2024 00:22:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bp29-20020a5d5a9d000000b00341d28586afsm16561933wrb.2.2024.04.03.00.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 00:22:04 -0700 (PDT)
Message-ID: <b7e46df1-5c4b-4cbe-86b3-03a57c138076@redhat.com>
Date: Wed, 3 Apr 2024 09:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/12] hw/arm/smmu: Add stage to TLB
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-4-smostafa@google.com>
 <b2588763-1fc3-4259-8666-f1a663ef2937@redhat.com>
 <ZgxSqi9G_WxGYJj-@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZgxSqi9G_WxGYJj-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 4/2/24 20:47, Mostafa Saleh wrote:
> Hi Eric,
>
> On Tue, Apr 02, 2024 at 07:15:20PM +0200, Eric Auger wrote:
>> Hi Mostafa,
>>
>> On 3/25/24 11:13, Mostafa Saleh wrote:
>>> TLBs for nesting will be extended to be combined, a new index is added
>>> "stage", with 2 valid values:
>>>  - SMMU_STAGE_1: Meaning this translates VA to PADDR, this entry can
>>>    be cached from fully nested configuration or from stage-1 only.
>>>    We don't support separate cached entries (VA to IPA)
>>>
>>>  - SMMU_STAGE_2: Meaning this translates IPA to PADDR, cached from
>>>    stage-2 only configuration.
>>>
>>> For TLB invalidation:
>>>  - by VA: Invalidate TLBs tagged with SMMU_STAGE_1
>>>  - by IPA: Invalidate TLBs tagged with SMMU_STAGE_2
>>>  - All: Will invalidate both, this is communicated to the TLB as
>>>    SMMU_NESTED which is (SMMU_STAGE_1 | SMMU_STAGE_2) which uses
>>>    it as a mask.
>> I don't really get why you need this extra stage field in the key. Why
>> aren't the asid and vmid tags enough?
>>
> Looking again, I think we can do it with ASID and VMID only, but that
> requires some rework in the invalidation path.
>
> With nested SMMUs, we can cache entries from:
> - Stage-1 (or nested): Tagged with VMID and ASID
> - Stage-2: Tagged with VMID only (ASID = -1)
>
> That should be enough for caching/lookup, but for invalidation, we
> should be able to invalidate IPAs which are cached from stage-2.
>
> At the moment, we represent ASIDs with < 0 as a wildcard for
> invalidation or stage-2 and they were mutually exclusive.
>
> An example is:
> - CMD_TLBI_NH_VAA: Invalidate stage-1 for a VMID, all ASIDs (we use ASID = -1)
> - CMD_TLBI_NH_VA: Invalidate stage-1 for a VMID, an ASID  ( > 0)
> - CMD_TLBI_S2_IPA: Invalidate stage-2 for a VMID (we use ASID = -1)
>
> We need to distinguish between case 1) and 3) otherwise we over invalidate.
OK I see your point when passing the asid param to smmuv3_range_inval()
in smmuv3_range_inval().
Well if you can have separate functions for handling S1 and S2 cases
while keeping the current key that may be interesting. It may be clearer
now we have extended support. This can also help in debugging/tracing.
>
> Similarly, CMD_TLBI_NH_ALL(invalidate all stage-1 by VMID) and
> CMD_TLBI_S12_VMALL(invalidate both stages by VMID).
>
> I guess we can add variants of these functions that operate on ASIDs
> (>= 0) or (< 0) which is basically stage-1 or stage-2.
worth to try indeed.

Thanks

Eric
>
> Another case I can think of which is not implemented in QEMU is
> global entries, where we would like to look up entries for all ASIDs
> (-1), but that’s not a problem for now.
>
> I don’t have a strong opinion, I can try to do it this way.
>
> Thanks,
> Mostafa
>
>> Eric
>>> This briefly described in the user manual (ARM IHI 0070 F.b) in
>>> "16.2.1 Caching combined structures".
>>>
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>  hw/arm/smmu-common.c         | 27 +++++++++++++++++----------
>>>  hw/arm/smmu-internal.h       |  2 ++
>>>  hw/arm/smmuv3.c              |  5 +++--
>>>  hw/arm/trace-events          |  3 ++-
>>>  include/hw/arm/smmu-common.h |  8 ++++++--
>>>  5 files changed, 30 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 20630eb670..677dcf9a13 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -38,7 +38,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>>>  
>>>      /* Jenkins hash */
>>>      a = b = c = JHASH_INITVAL + sizeof(*key);
>>> -    a += key->asid + key->vmid + key->level + key->tg;
>>> +    a += key->asid + key->vmid + key->level + key->tg + key->stage;
>>>      b += extract64(key->iova, 0, 32);
>>>      c += extract64(key->iova, 32, 32);
>>>  
>>> @@ -54,14 +54,14 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>>>  
>>>      return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
>>>             (k1->level == k2->level) && (k1->tg == k2->tg) &&
>>> -           (k1->vmid == k2->vmid);
>>> +           (k1->vmid == k2->vmid) && (k1->stage == k2->stage);
>>>  }
>>>  
>>>  SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
>>> -                                uint8_t tg, uint8_t level)
>>> +                                uint8_t tg, uint8_t level, SMMUStage stage)
>>>  {
>>>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
>>> -                        .tg = tg, .level = level};
>>> +                        .tg = tg, .level = level, .stage = stage};
>>>  
>>>      return key;
>>>  }
>>> @@ -81,7 +81,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>>>          SMMUIOTLBKey key;
>>>  
>>>          key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
>>> -                                 iova & ~mask, tg, level);
>>> +                                 iova & ~mask, tg, level,
>>> +                                 SMMU_STAGE_TO_TLB_TAG(cfg->stage));
>>>          entry = g_hash_table_lookup(bs->iotlb, &key);
>>>          if (entry) {
>>>              break;
>>> @@ -109,15 +110,16 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>>>  {
>>>      SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
>>>      uint8_t tg = (new->granule - 10) / 2;
>>> +    SMMUStage stage_tag = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
>>>  
>>>      if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
>>>          smmu_iotlb_inv_all(bs);
>>>      }
>>>  
>>>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>>> -                              tg, new->level);
>>> +                              tg, new->level, stage_tag);
>>>      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>>> -                            tg, new->level);
>>> +                            tg, new->level, stage_tag);
>>>      g_hash_table_insert(bs->iotlb, key, new);
>>>  }
>>>  
>>> @@ -159,18 +161,22 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>>>      if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
>>>          return false;
>>>      }
>>> +    if (!(info->stage & SMMU_IOTLB_STAGE(iotlb_key))) {
>>> +        return false;
>>> +    }
>>>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
>>>             ((entry->iova & ~info->mask) == info->iova);
>>>  }
>>>  
>>>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>>> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
>>> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
>>> +                         SMMUStage stage)
>>>  {
>>>      /* if tg is not set we use 4KB range invalidation */
>>>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>>>  
>>>      if (ttl && (num_pages == 1) && (asid >= 0)) {
>>> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
>>> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl, stage);
>>>  
>>>          if (g_hash_table_remove(s->iotlb, &key)) {
>>>              return;
>>> @@ -184,6 +190,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>>>      SMMUIOTLBPageInvInfo info = {
>>>          .asid = asid, .iova = iova,
>>>          .vmid = vmid,
>>> +        .stage = stage,
>>>          .mask = (num_pages * 1 << granule) - 1};
>>>  
>>>      g_hash_table_foreach_remove(s->iotlb,
>>> @@ -597,7 +604,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>>>      if (cached_entry) {
>>>          if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
>>>              info->type = SMMU_PTW_ERR_PERMISSION;
>>> -            info->stage = cfg->stage;
>>> +            info->stage = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
>>>              return NULL;
>>>          }
>>>          return cached_entry;
>>> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
>>> index 843bebb185..6caa0ddf21 100644
>>> --- a/hw/arm/smmu-internal.h
>>> +++ b/hw/arm/smmu-internal.h
>>> @@ -133,12 +133,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
>>>  
>>>  #define SMMU_IOTLB_ASID(key) ((key).asid)
>>>  #define SMMU_IOTLB_VMID(key) ((key).vmid)
>>> +#define SMMU_IOTLB_STAGE(key) ((key).stage)
>>>  
>>>  typedef struct SMMUIOTLBPageInvInfo {
>>>      int asid;
>>>      int vmid;
>>>      uint64_t iova;
>>>      uint64_t mask;
>>> +    SMMUStage stage;
>>>  } SMMUIOTLBPageInvInfo;
>>>  
>>>  typedef struct SMMUSIDRange {
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index f081ff0cc4..b27bf297e1 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1087,7 +1087,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
>>>      if (!tg) {
>>>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
>>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
>>> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
>>> +        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, SMMU_NESTED);
>>>          return;
>>>      }
>>>  
>>> @@ -1105,7 +1105,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
>>>          num_pages = (mask + 1) >> granule;
>>>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
>>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
>>> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
>>> +        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>>> +                            num_pages, ttl, SMMU_NESTED);
>>>          addr += mask + 1;
>>>      }
>>>  }
>>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>>> index cc12924a84..3000c3bf14 100644
>>> --- a/hw/arm/trace-events
>>> +++ b/hw/arm/trace-events
>>> @@ -14,10 +14,11 @@ smmu_iotlb_inv_all(void) "IOTLB invalidate all"
>>>  smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
>>>  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
>>>  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>>> +smmu_iotlb_inv_stage(int stage) "Stage invalidate stage=%d"
>>>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>>>  smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
>>>  smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
>>> -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
>>> +smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, int stage) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d stage=%d"
>>>  
>>>  # smmuv3.c
>>>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
>>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>>> index 876e78975c..695d6d10ad 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -37,6 +37,8 @@
>>>  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
>>>                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
>>>  
>>> +#define SMMU_STAGE_TO_TLB_TAG(stage)        (((stage) == SMMU_NESTED) ? \
>>> +                                             SMMU_STAGE_1 : (stage))
>>>  /*
>>>   * Page table walk error types
>>>   */
>>> @@ -136,6 +138,7 @@ typedef struct SMMUIOTLBKey {
>>>      uint16_t vmid;
>>>      uint8_t tg;
>>>      uint8_t level;
>>> +    SMMUStage stage;
>>>  } SMMUIOTLBKey;
>>>  
>>>  struct SMMUState {
>>> @@ -203,12 +206,13 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>>>                                  SMMUTransTableInfo *tt, hwaddr iova);
>>>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>>>  SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
>>> -                                uint8_t tg, uint8_t level);
>>> +                                uint8_t tg, uint8_t level, SMMUStage stage);
>>>  void smmu_iotlb_inv_all(SMMUState *s);
>>>  void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
>>>  void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
>>>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>>> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
>>> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
>>> +                         SMMUStage stage);
>>>  
>>>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>>>  void smmu_inv_notifiers_all(SMMUState *s);


