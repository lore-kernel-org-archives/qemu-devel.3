Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB951CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrh4L-0007QR-Ub; Tue, 02 Apr 2024 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rrh4K-0007Q4-MU
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rrh4F-0004Fm-8z
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712075577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yw8zARGlNB86RJHmiZdvdBtE3fxoCD4NVqbTrx7r520=;
 b=Kw1m8DxeyeYHTaHNi0Q4NVZ6qaeEovAijrIogfo5Q0ht1Zi72m2huzwaZL4oPAjmNZrlql
 wGswteUCB+n2R0IfzJCOg0ABEkHTEtOAH40pC+uyVGUVg6wzKN1NtwB5sNdmnFm5CMAbqZ
 36SHMf9eKaGlxb/t9pFq7VTyi36sZZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-hX6uOTuVOZux97yNPPC-AA-1; Tue, 02 Apr 2024 12:32:55 -0400
X-MC-Unique: hX6uOTuVOZux97yNPPC-AA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3436eadd01cso396333f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712075574; x=1712680374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yw8zARGlNB86RJHmiZdvdBtE3fxoCD4NVqbTrx7r520=;
 b=kgR6mjG494b5OuYgdQ1aFi6y7O2ceUuwbn8RIRKJkScHdxUxTRU7PIpilFyyntKXem
 1kNy8g6x2oagBlTD5lU/FpsisXIlk/O7dKDWZRoZ6aYEFzD7kkMaV/mc5yw7cFHQL1Xd
 rCnP/W5wKpvMinVigIOjH+iYY7TYYatMTRS/V9I8Sp/uMAvemrkub/phb6pLE7CiZmp6
 1OTYnRxG7RnuTJkXGXmd/G2QEWZG8rs9JBCLz1ky/E1UO64d448D0BfZx/WxRhM63bLW
 9YEYMFaXo05cAi+aJffnIcjENfFOCJSD7O2BnEesOrIue01cW4cEgHWqiIwVYzUeeh6S
 Mm3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWROcc66njyRUiF5N6RglcbyMDyjlcK4+mSYwBvaBUOxptGYWR7rKeBthvi6V9haN2HvNF8cKVccURSRqtvWOtsjZFvu5A=
X-Gm-Message-State: AOJu0YwvLQk7RXn2na6nTfI2Y/3IvPQ4ewR6GeXZJ+J8pcJ1rE0A5Pqt
 Gwv5ncJUJ8atM4ZMbsKMCsjB9OuCsTo+z3fCOX0PaSd+NPg3/HLLCXgyUdSCyO9xK1CMGNxLuOH
 3CGNdyvUw3EEjJD4v+HdSCAeNimbwhSAUKW5EXUy673sAEc6opRtG
X-Received: by 2002:adf:e891:0:b0:33e:6495:3273 with SMTP id
 d17-20020adfe891000000b0033e64953273mr9905503wrm.4.1712075574602; 
 Tue, 02 Apr 2024 09:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfehPapGiOCPhLL3TwKYB2ERAM2/IoKwUbiT5G4fEjubvAzAukPs27MYcyHpt9nug64L7alA==
X-Received: by 2002:adf:e891:0:b0:33e:6495:3273 with SMTP id
 d17-20020adfe891000000b0033e64953273mr9905486wrm.4.1712075574158; 
 Tue, 02 Apr 2024 09:32:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033e786abf84sm14572954wrm.54.2024.04.02.09.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 09:32:53 -0700 (PDT)
Message-ID: <5d17019b-f24d-4dbb-8a3a-7c4ff739d50d@redhat.com>
Date: Tue, 2 Apr 2024 18:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] hw/arm/smmu: Split smmuv3_translate()
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-3-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240325101442.1306300-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/25/24 11:13, Mostafa Saleh wrote:
> smmuv3_translate() does everything from STE/CD parsing to TLB lookup
> and PTW.
>
> Soon, when nesting is supported, stage-1 data (tt, CD) needs to be
> translated using stage-2.
>
> Split smmuv3_translate() to 3 functions:
>
> - smmu_translate(): in smmu-common.c, which does the TLB lookup, PTW,
>   TLB insertion, all the functions are already there, this just puts
>   them together.
>   This also simplifies the code as it consolidates event generation
>   in case of TLB lookup permission failure or in TT selection.
>
> - smmuv3_do_translate(): in smmuv3.c, Calls smmu_translate() and does
>   the event population in case of errors.
>
>  - smmuv3_translate(), now calls smmuv3_do_translate() for
>    translation while the rest is the same.
>
> Also, add stage in trace_smmuv3_translate_success()
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         |  59 ++++++++++++
>  hw/arm/smmuv3.c              | 175 +++++++++++++----------------------
>  hw/arm/trace-events          |   2 +-
>  include/hw/arm/smmu-common.h |   5 +
>  4 files changed, 130 insertions(+), 111 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3a7c350aca..20630eb670 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -554,6 +554,65 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>      g_assert_not_reached();
>  }
>  
> +SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> +                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
> +{
> +    uint64_t page_mask, aligned_addr;
> +    SMMUTLBEntry *cached_entry = NULL;
> +    SMMUTransTableInfo *tt;
> +    int status;
> +
> +    /*
> +     * Combined attributes used for TLB lookup, as only one stage is supported,
> +     * it will hold attributes based on the enabled stage.
> +     */
> +    SMMUTransTableInfo tt_combined;
> +
> +    if (cfg->stage == SMMU_STAGE_1) {
> +        /* Select stage1 translation table. */
> +        tt = select_tt(cfg, addr);
> +        if (!tt) {
> +            info->type = SMMU_PTW_ERR_TRANSLATION;
> +            info->stage = SMMU_STAGE_1;
> +            return NULL;
> +        }
> +        tt_combined.granule_sz = tt->granule_sz;
> +        tt_combined.tsz = tt->tsz;
> +
> +    } else {
> +        /* Stage2. */
> +        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
> +        tt_combined.tsz = cfg->s2cfg.tsz;
> +    }
> +
> +    /*
> +     * TLB lookup looks for granule and input size for a translation stage,
> +     * as only one stage is supported right now, choose the right values
> +     * from the configuration.
> +     */
> +    page_mask = (1ULL << tt_combined.granule_sz) - 1;
> +    aligned_addr = addr & ~page_mask;
> +
> +    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
> +    if (cached_entry) {
> +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> +            info->type = SMMU_PTW_ERR_PERMISSION;
> +            info->stage = cfg->stage;
> +            return NULL;
> +        }
> +        return cached_entry;
> +    }
> +
> +    cached_entry = g_new0(SMMUTLBEntry, 1);
> +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> +    if (status) {
> +            g_free(cached_entry);
> +            return NULL;
> +    }
> +    smmu_iotlb_insert(bs, cfg, cached_entry);
> +    return cached_entry;
> +}
> +
>  /**
>   * The bus number is used for lookup when SID based invalidation occurs.
>   * In that case we lazily populate the SMMUPciBus array from the bus hash
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 50e5a72d54..f081ff0cc4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -827,6 +827,67 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      g_hash_table_remove(bc->configs, sdev);
>  }
>  
> +/* Do translation with TLB lookup. */
> +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> +                                                 SMMUTransCfg *cfg,
> +                                                 SMMUEventInfo *event,
> +                                                 IOMMUAccessFlags flag,
> +                                                 SMMUTLBEntry **out_entry)
> +{
> +    SMMUPTWEventInfo ptw_info = {};
> +    SMMUState *bs = ARM_SMMU(s);
> +    SMMUTLBEntry *cached_entry = NULL;
> +
> +    cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
> +    if (!cached_entry) {
> +        /* All faults from PTW has S2 field. */
> +        event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
> +        switch (ptw_info.type) {
> +        case SMMU_PTW_ERR_WALK_EABT:
> +            event->type = SMMU_EVT_F_WALK_EABT;
> +            event->u.f_walk_eabt.addr = addr;
> +            event->u.f_walk_eabt.rnw = flag & 0x1;
> +            event->u.f_walk_eabt.class = 0x1;
> +            event->u.f_walk_eabt.addr2 = ptw_info.addr;
> +            break;
> +        case SMMU_PTW_ERR_TRANSLATION:
> +            if (PTW_RECORD_FAULT(cfg)) {
> +                event->type = SMMU_EVT_F_TRANSLATION;
> +                event->u.f_translation.addr = addr;
> +                event->u.f_translation.rnw = flag & 0x1;
> +            }
> +            break;
> +        case SMMU_PTW_ERR_ADDR_SIZE:
> +            if (PTW_RECORD_FAULT(cfg)) {
> +                event->type = SMMU_EVT_F_ADDR_SIZE;
> +                event->u.f_addr_size.addr = addr;
> +                event->u.f_addr_size.rnw = flag & 0x1;
> +            }
> +            break;
> +        case SMMU_PTW_ERR_ACCESS:
> +            if (PTW_RECORD_FAULT(cfg)) {
> +                event->type = SMMU_EVT_F_ACCESS;
> +                event->u.f_access.addr = addr;
> +                event->u.f_access.rnw = flag & 0x1;
> +            }
> +            break;
> +        case SMMU_PTW_ERR_PERMISSION:
> +            if (PTW_RECORD_FAULT(cfg)) {
> +                event->type = SMMU_EVT_F_PERMISSION;
> +                event->u.f_permission.addr = addr;
> +                event->u.f_permission.rnw = flag & 0x1;
> +            }
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        return SMMU_TRANS_ERROR;
> +    }
> +    *out_entry = cached_entry;
> +    return SMMU_TRANS_SUCCESS;
> +}
> +
> +/* Entry point to SMMU, does everything. */
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag, int iommu_idx)
>  {
> @@ -836,12 +897,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>                             .sid = sid,
>                             .inval_ste_allowed = false};
> -    SMMUPTWEventInfo ptw_info = {};
>      SMMUTranslationStatus status;
> -    SMMUState *bs = ARM_SMMU(s);
> -    uint64_t page_mask, aligned_addr;
> -    SMMUTLBEntry *cached_entry = NULL;
> -    SMMUTransTableInfo *tt;
>      SMMUTransCfg *cfg = NULL;
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
> @@ -850,11 +906,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          .addr_mask = ~(hwaddr)0,
>          .perm = IOMMU_NONE,
>      };
> -    /*
> -     * Combined attributes used for TLB lookup, as only one stage is supported,
> -     * it will hold attributes based on the enabled stage.
> -     */
> -    SMMUTransTableInfo tt_combined;
> +    SMMUTLBEntry *cached_entry = NULL;
>  
>      qemu_mutex_lock(&s->mutex);
>  
> @@ -883,105 +935,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    if (cfg->stage == SMMU_STAGE_1) {
> -        /* Select stage1 translation table. */
> -        tt = select_tt(cfg, addr);
> -        if (!tt) {
> -            if (cfg->record_faults) {
> -                event.type = SMMU_EVT_F_TRANSLATION;
> -                event.u.f_translation.addr = addr;
> -                event.u.f_translation.rnw = flag & 0x1;
> -            }
> -            status = SMMU_TRANS_ERROR;
> -            goto epilogue;
> -        }
> -        tt_combined.granule_sz = tt->granule_sz;
> -        tt_combined.tsz = tt->tsz;
> -
> -    } else {
> -        /* Stage2. */
> -        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
> -        tt_combined.tsz = cfg->s2cfg.tsz;
> -    }
> -    /*
> -     * TLB lookup looks for granule and input size for a translation stage,
> -     * as only one stage is supported right now, choose the right values
> -     * from the configuration.
> -     */
> -    page_mask = (1ULL << tt_combined.granule_sz) - 1;
> -    aligned_addr = addr & ~page_mask;
> -
> -    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
> -    if (cached_entry) {
> -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> -            status = SMMU_TRANS_ERROR;
> -            /*
> -             * We know that the TLB only contains either stage-1 or stage-2 as
> -             * nesting is not supported. So it is sufficient to check the
> -             * translation stage to know the TLB stage for now.
> -             */
> -            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
> -            if (PTW_RECORD_FAULT(cfg)) {
> -                event.type = SMMU_EVT_F_PERMISSION;
> -                event.u.f_permission.addr = addr;
> -                event.u.f_permission.rnw = flag & 0x1;
> -            }
> -        } else {
> -            status = SMMU_TRANS_SUCCESS;
> -        }
> -        goto epilogue;
> -    }
> -
> -    cached_entry = g_new0(SMMUTLBEntry, 1);
> -
> -    if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
> -        /* All faults from PTW has S2 field. */
> -        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
> -        g_free(cached_entry);
> -        switch (ptw_info.type) {
> -        case SMMU_PTW_ERR_WALK_EABT:
> -            event.type = SMMU_EVT_F_WALK_EABT;
> -            event.u.f_walk_eabt.addr = addr;
> -            event.u.f_walk_eabt.rnw = flag & 0x1;
> -            event.u.f_walk_eabt.class = 0x1;
> -            event.u.f_walk_eabt.addr2 = ptw_info.addr;
> -            break;
> -        case SMMU_PTW_ERR_TRANSLATION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> -                event.type = SMMU_EVT_F_TRANSLATION;
> -                event.u.f_translation.addr = addr;
> -                event.u.f_translation.rnw = flag & 0x1;
> -            }
> -            break;
> -        case SMMU_PTW_ERR_ADDR_SIZE:
> -            if (PTW_RECORD_FAULT(cfg)) {
> -                event.type = SMMU_EVT_F_ADDR_SIZE;
> -                event.u.f_addr_size.addr = addr;
> -                event.u.f_addr_size.rnw = flag & 0x1;
> -            }
> -            break;
> -        case SMMU_PTW_ERR_ACCESS:
> -            if (PTW_RECORD_FAULT(cfg)) {
> -                event.type = SMMU_EVT_F_ACCESS;
> -                event.u.f_access.addr = addr;
> -                event.u.f_access.rnw = flag & 0x1;
> -            }
> -            break;
> -        case SMMU_PTW_ERR_PERMISSION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> -                event.type = SMMU_EVT_F_PERMISSION;
> -                event.u.f_permission.addr = addr;
> -                event.u.f_permission.rnw = flag & 0x1;
> -            }
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> -        status = SMMU_TRANS_ERROR;
> -    } else {
> -        smmu_iotlb_insert(bs, cfg, cached_entry);
> -        status = SMMU_TRANS_SUCCESS;
> -    }
> +    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
>  
>  epilogue:
>      qemu_mutex_unlock(&s->mutex);
> @@ -992,7 +946,8 @@ epilogue:
>                                      (addr & cached_entry->entry.addr_mask);
>          entry.addr_mask = cached_entry->entry.addr_mask;
>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
> -                                       entry.translated_addr, entry.perm);
> +                                       entry.translated_addr, entry.perm,
> +                                       cfg->stage);
>          break;
>      case SMMU_TRANS_DISABLE:
>          entry.perm = flag;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f1a54a02df..cc12924a84 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -37,7 +37,7 @@ smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
>  smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
>  smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x STE bypass iova:0x%"PRIx64" is_write=%d"
>  smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x abort on iova:0x%"PRIx64" is_write=%d"
> -smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
> +smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm, int stage) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x stage=%d"
>  smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index b3c881f0ee..876e78975c 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -183,6 +183,11 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>               SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
>  
> +
> +/* smmu_translate - Look for a translation in TLB, if not, do a PTW. */
I would add a comment saying it returns NULL in case of translation
error. Indeed at first sight I thought in case of hit and err_permission
it would still return the TLBentry.

Otherwise it looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> +SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> +                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info);
> +
>  /**
>   * select_tt - compute which translation table shall be used according to
>   * the input iova and translation config and return the TT specific info


