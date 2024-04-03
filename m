Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36D4CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxKz-0005Ix-7A; Wed, 03 Apr 2024 05:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rrxKx-0005IR-9h
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:55:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rrxKu-00053p-SB
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:55:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4156ae9db55so52955e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712138115; x=1712742915; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=086VbEH9Ymt3do3GK9NK93tI4tMl5SVd0Mb7jAbl81E=;
 b=wpyTwmiK6R6L3bg+tqn2DVU5iCc+/92LVhx65PlS3g7o7WrizACmxaoLt/WJ/+wNap
 Fh/f81eep8xucpxyaT5c96szxOlu8lZ2g4c5rdJ1Tob0RFvakYN98/s0SQbh9A3mMNcX
 mwjS0msXNc+Qd1/MbiL5J+uWmZ5ZXOCPsgWMghIIYN/yhl2E31oZgyBdUqEXPPBk5LND
 o+BFWXvaW/2I+9plc+F76fBQftLZBQ0QEnKMG+iQBHg/EpDR4g5gHSS/vVa+SSNlpvk9
 +s/BbzfcOaOPJqzitZfKke9cVsJjJNoO+fOdRlLh6CsZs6ZUA/xbf0DUYPx5d0Pa94MK
 E+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712138115; x=1712742915;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=086VbEH9Ymt3do3GK9NK93tI4tMl5SVd0Mb7jAbl81E=;
 b=URsDCcIqzoxMryZ7sB8UsdXwKPmD5ZuAAtuqdVouUYYviVo7lydYaMwMIsdTpmVsks
 Mue5+B+Qd8OKs3ZPgs2ZngavXV9qNKTW3zbWZBm7XHsngoY2ZwVnqwwQKwrX/zdEjBfu
 LRAI66LzJTf68c/JO0nrXdG+ybiAIF3X2rs6edSpOsmd94YODb+7ievcHmgk+aRgaIsE
 +4bHFyKvrqWtOsHFp+gBnI/RtuYIos5uMiZwfvv3BW3iUeBXMAlPb3ciO53CMa/VlMLt
 NwW/A63OMbpYIlj9+N9gIzkB8SzHRirgW5QrF0ke4mADTWWFVD3aq23ruqighUPaPN8p
 WvUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn/y/LaEXWBZMn380Rw8KxnNi+E4SnaTfxWUDVUI61LpakVgLdeadPkOtUytXKcgLBcAvH9bdClTHjUrG4XCpZUxErdzo=
X-Gm-Message-State: AOJu0Yyw08ZrkxIdG+8U/8QwNRJfLoylhdkdBGzKDGfprLhF5VndkmH4
 2ArcDJgX6YyqrQhZHCkFNd1lQOXIhArZGhPb+8NWC/MA9GLnA0N00bePK4hArQ==
X-Google-Smtp-Source: AGHT+IF9+n0BLfR18MlETjA+PSYQTgOWDw5tx43myfu3vScVpCY8wgzD0WIMfxwRPDm20mjgen2FCg==
X-Received: by 2002:a05:600c:1d86:b0:414:866e:4437 with SMTP id
 p6-20020a05600c1d8600b00414866e4437mr128891wms.1.1712138114835; 
 Wed, 03 Apr 2024 02:55:14 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c1d9300b0041624db414esm708108wms.35.2024.04.03.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 02:55:14 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:55:10 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org
Subject: Re: [RFC PATCH 03/12] hw/arm/smmu: Add stage to TLB
Message-ID: <Zg0nfmnLFRcDgF4x@google.com>
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-4-smostafa@google.com>
 <b2588763-1fc3-4259-8666-f1a663ef2937@redhat.com>
 <ZgxSqi9G_WxGYJj-@google.com>
 <b7e46df1-5c4b-4cbe-86b3-03a57c138076@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e46df1-5c4b-4cbe-86b3-03a57c138076@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Apr 03, 2024 at 09:22:03AM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/2/24 20:47, Mostafa Saleh wrote:
> > Hi Eric,
> >
> > On Tue, Apr 02, 2024 at 07:15:20PM +0200, Eric Auger wrote:
> >> Hi Mostafa,
> >>
> >> On 3/25/24 11:13, Mostafa Saleh wrote:
> >>> TLBs for nesting will be extended to be combined, a new index is added
> >>> "stage", with 2 valid values:
> >>>  - SMMU_STAGE_1: Meaning this translates VA to PADDR, this entry can
> >>>    be cached from fully nested configuration or from stage-1 only.
> >>>    We don't support separate cached entries (VA to IPA)
> >>>
> >>>  - SMMU_STAGE_2: Meaning this translates IPA to PADDR, cached from
> >>>    stage-2 only configuration.
> >>>
> >>> For TLB invalidation:
> >>>  - by VA: Invalidate TLBs tagged with SMMU_STAGE_1
> >>>  - by IPA: Invalidate TLBs tagged with SMMU_STAGE_2
> >>>  - All: Will invalidate both, this is communicated to the TLB as
> >>>    SMMU_NESTED which is (SMMU_STAGE_1 | SMMU_STAGE_2) which uses
> >>>    it as a mask.
> >> I don't really get why you need this extra stage field in the key. Why
> >> aren't the asid and vmid tags enough?
> >>
> > Looking again, I think we can do it with ASID and VMID only, but that
> > requires some rework in the invalidation path.
> >
> > With nested SMMUs, we can cache entries from:
> > - Stage-1 (or nested): Tagged with VMID and ASID
> > - Stage-2: Tagged with VMID only (ASID = -1)
> >
> > That should be enough for caching/lookup, but for invalidation, we
> > should be able to invalidate IPAs which are cached from stage-2.
> >
> > At the moment, we represent ASIDs with < 0 as a wildcard for
> > invalidation or stage-2 and they were mutually exclusive.
> >
> > An example is:
> > - CMD_TLBI_NH_VAA: Invalidate stage-1 for a VMID, all ASIDs (we use ASID = -1)
> > - CMD_TLBI_NH_VA: Invalidate stage-1 for a VMID, an ASID  ( > 0)
> > - CMD_TLBI_S2_IPA: Invalidate stage-2 for a VMID (we use ASID = -1)
> >
> > We need to distinguish between case 1) and 3) otherwise we over invalidate.
> OK I see your point when passing the asid param to smmuv3_range_inval()
> in smmuv3_range_inval().
> Well if you can have separate functions for handling S1 and S2 cases
> while keeping the current key that may be interesting. It may be clearer
> now we have extended support. This can also help in debugging/tracing.
> >
> > Similarly, CMD_TLBI_NH_ALL(invalidate all stage-1 by VMID) and
> > CMD_TLBI_S12_VMALL(invalidate both stages by VMID).
> >
> > I guess we can add variants of these functions that operate on ASIDs
> > (>= 0) or (< 0) which is basically stage-1 or stage-2.
> worth to try indeed.

I will switch to that in V2.

Thanks,
Mostafa

> 
> Thanks
> 
> Eric
> >
> > Another case I can think of which is not implemented in QEMU is
> > global entries, where we would like to look up entries for all ASIDs
> > (-1), but that’s not a problem for now.
> >
> > I don’t have a strong opinion, I can try to do it this way.
> >
> > Thanks,
> > Mostafa
> >
> >> Eric
> >>> This briefly described in the user manual (ARM IHI 0070 F.b) in
> >>> "16.2.1 Caching combined structures".
> >>>
> >>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> >>> ---
> >>>  hw/arm/smmu-common.c         | 27 +++++++++++++++++----------
> >>>  hw/arm/smmu-internal.h       |  2 ++
> >>>  hw/arm/smmuv3.c              |  5 +++--
> >>>  hw/arm/trace-events          |  3 ++-
> >>>  include/hw/arm/smmu-common.h |  8 ++++++--
> >>>  5 files changed, 30 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> >>> index 20630eb670..677dcf9a13 100644
> >>> --- a/hw/arm/smmu-common.c
> >>> +++ b/hw/arm/smmu-common.c
> >>> @@ -38,7 +38,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
> >>>  
> >>>      /* Jenkins hash */
> >>>      a = b = c = JHASH_INITVAL + sizeof(*key);
> >>> -    a += key->asid + key->vmid + key->level + key->tg;
> >>> +    a += key->asid + key->vmid + key->level + key->tg + key->stage;
> >>>      b += extract64(key->iova, 0, 32);
> >>>      c += extract64(key->iova, 32, 32);
> >>>  
> >>> @@ -54,14 +54,14 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
> >>>  
> >>>      return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
> >>>             (k1->level == k2->level) && (k1->tg == k2->tg) &&
> >>> -           (k1->vmid == k2->vmid);
> >>> +           (k1->vmid == k2->vmid) && (k1->stage == k2->stage);
> >>>  }
> >>>  
> >>>  SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> >>> -                                uint8_t tg, uint8_t level)
> >>> +                                uint8_t tg, uint8_t level, SMMUStage stage)
> >>>  {
> >>>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> >>> -                        .tg = tg, .level = level};
> >>> +                        .tg = tg, .level = level, .stage = stage};
> >>>  
> >>>      return key;
> >>>  }
> >>> @@ -81,7 +81,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >>>          SMMUIOTLBKey key;
> >>>  
> >>>          key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
> >>> -                                 iova & ~mask, tg, level);
> >>> +                                 iova & ~mask, tg, level,
> >>> +                                 SMMU_STAGE_TO_TLB_TAG(cfg->stage));
> >>>          entry = g_hash_table_lookup(bs->iotlb, &key);
> >>>          if (entry) {
> >>>              break;
> >>> @@ -109,15 +110,16 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
> >>>  {
> >>>      SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
> >>>      uint8_t tg = (new->granule - 10) / 2;
> >>> +    SMMUStage stage_tag = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
> >>>  
> >>>      if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
> >>>          smmu_iotlb_inv_all(bs);
> >>>      }
> >>>  
> >>>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> >>> -                              tg, new->level);
> >>> +                              tg, new->level, stage_tag);
> >>>      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> >>> -                            tg, new->level);
> >>> +                            tg, new->level, stage_tag);
> >>>      g_hash_table_insert(bs->iotlb, key, new);
> >>>  }
> >>>  
> >>> @@ -159,18 +161,22 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> >>>      if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
> >>>          return false;
> >>>      }
> >>> +    if (!(info->stage & SMMU_IOTLB_STAGE(iotlb_key))) {
> >>> +        return false;
> >>> +    }
> >>>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
> >>>             ((entry->iova & ~info->mask) == info->iova);
> >>>  }
> >>>  
> >>>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >>> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
> >>> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> >>> +                         SMMUStage stage)
> >>>  {
> >>>      /* if tg is not set we use 4KB range invalidation */
> >>>      uint8_t granule = tg ? tg * 2 + 10 : 12;
> >>>  
> >>>      if (ttl && (num_pages == 1) && (asid >= 0)) {
> >>> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
> >>> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl, stage);
> >>>  
> >>>          if (g_hash_table_remove(s->iotlb, &key)) {
> >>>              return;
> >>> @@ -184,6 +190,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >>>      SMMUIOTLBPageInvInfo info = {
> >>>          .asid = asid, .iova = iova,
> >>>          .vmid = vmid,
> >>> +        .stage = stage,
> >>>          .mask = (num_pages * 1 << granule) - 1};
> >>>  
> >>>      g_hash_table_foreach_remove(s->iotlb,
> >>> @@ -597,7 +604,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> >>>      if (cached_entry) {
> >>>          if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> >>>              info->type = SMMU_PTW_ERR_PERMISSION;
> >>> -            info->stage = cfg->stage;
> >>> +            info->stage = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
> >>>              return NULL;
> >>>          }
> >>>          return cached_entry;
> >>> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> >>> index 843bebb185..6caa0ddf21 100644
> >>> --- a/hw/arm/smmu-internal.h
> >>> +++ b/hw/arm/smmu-internal.h
> >>> @@ -133,12 +133,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
> >>>  
> >>>  #define SMMU_IOTLB_ASID(key) ((key).asid)
> >>>  #define SMMU_IOTLB_VMID(key) ((key).vmid)
> >>> +#define SMMU_IOTLB_STAGE(key) ((key).stage)
> >>>  
> >>>  typedef struct SMMUIOTLBPageInvInfo {
> >>>      int asid;
> >>>      int vmid;
> >>>      uint64_t iova;
> >>>      uint64_t mask;
> >>> +    SMMUStage stage;
> >>>  } SMMUIOTLBPageInvInfo;
> >>>  
> >>>  typedef struct SMMUSIDRange {
> >>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> >>> index f081ff0cc4..b27bf297e1 100644
> >>> --- a/hw/arm/smmuv3.c
> >>> +++ b/hw/arm/smmuv3.c
> >>> @@ -1087,7 +1087,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> >>>      if (!tg) {
> >>>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
> >>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> >>> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> >>> +        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, SMMU_NESTED);
> >>>          return;
> >>>      }
> >>>  
> >>> @@ -1105,7 +1105,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> >>>          num_pages = (mask + 1) >> granule;
> >>>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
> >>>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> >>> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> >>> +        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
> >>> +                            num_pages, ttl, SMMU_NESTED);
> >>>          addr += mask + 1;
> >>>      }
> >>>  }
> >>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> >>> index cc12924a84..3000c3bf14 100644
> >>> --- a/hw/arm/trace-events
> >>> +++ b/hw/arm/trace-events
> >>> @@ -14,10 +14,11 @@ smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> >>>  smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> >>>  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> >>>  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> >>> +smmu_iotlb_inv_stage(int stage) "Stage invalidate stage=%d"
> >>>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> >>>  smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> >>>  smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> >>> -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> >>> +smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, int stage) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d stage=%d"
> >>>  
> >>>  # smmuv3.c
> >>>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> >>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> >>> index 876e78975c..695d6d10ad 100644
> >>> --- a/include/hw/arm/smmu-common.h
> >>> +++ b/include/hw/arm/smmu-common.h
> >>> @@ -37,6 +37,8 @@
> >>>  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
> >>>                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
> >>>  
> >>> +#define SMMU_STAGE_TO_TLB_TAG(stage)        (((stage) == SMMU_NESTED) ? \
> >>> +                                             SMMU_STAGE_1 : (stage))
> >>>  /*
> >>>   * Page table walk error types
> >>>   */
> >>> @@ -136,6 +138,7 @@ typedef struct SMMUIOTLBKey {
> >>>      uint16_t vmid;
> >>>      uint8_t tg;
> >>>      uint8_t level;
> >>> +    SMMUStage stage;
> >>>  } SMMUIOTLBKey;
> >>>  
> >>>  struct SMMUState {
> >>> @@ -203,12 +206,13 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >>>                                  SMMUTransTableInfo *tt, hwaddr iova);
> >>>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> >>>  SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> >>> -                                uint8_t tg, uint8_t level);
> >>> +                                uint8_t tg, uint8_t level, SMMUStage stage);
> >>>  void smmu_iotlb_inv_all(SMMUState *s);
> >>>  void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
> >>>  void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
> >>>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >>> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
> >>> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> >>> +                         SMMUStage stage);
> >>>  
> >>>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
> >>>  void smmu_inv_notifiers_all(SMMUState *s);
> 

