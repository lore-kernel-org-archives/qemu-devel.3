Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397EFC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRG2-0006Ue-Aw; Thu, 04 Jul 2024 14:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRFs-0006Jj-VI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:32:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRFq-0003af-FA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:32:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so6043155e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720117943; x=1720722743; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7TOCBq5LD8HAiR5C6PVsdvrLvb43CV73KIzSvyIMYDc=;
 b=exVkO/g7Ke/VHVT8p19q8wdrwbL9IexSNzes4WSX7uYElBY35lGBLSZ1FgJ1mYL7PB
 FOMizN3C73LxQ4F5kmXnvXoQlS2lNm4xddM/nyzuGwpgtnV8uxkGens8KjODQgoW16j3
 9NBFaiKy9End/JtHsdKIRaLG4Z46tIxGMHBVHToMO/Am97boL2HIRS1froSReprsHtvg
 axHkAPVLDUOMx+1SD3s6imERrR3DOp6+CMNg4yM38PWU058pDWFuEnQktHALGZYEC8/g
 5P7iTO5TqhX24+CxKkkEDzzH02HHumZiTgNjsdMBMvpL31a1RI1UdoTxCSrxquOe20u6
 jDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720117943; x=1720722743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TOCBq5LD8HAiR5C6PVsdvrLvb43CV73KIzSvyIMYDc=;
 b=nPa5d8aI27EP95t9fBB5DSCQriaHqF0YiBFOiB5vRpTQOxuZia+Nk4DeAOTyD5hbhF
 H7DB07IgYKS2sRQ/KLVRdWsIeMFK1UIjNvLcJO77iZXkAOcW5HPnYtS7/Cyy6g5Od3dJ
 cjU//V0PCNbCMXGBm+tx4vhkb9grW0tEsk5IEZVHPanLMkQ0EoyjaNG4XHQPyIkSv3dS
 sBpzr/SwfhFyKgJ1FVF5ALK1K2rq4sbX3gxEe0xAjiPzdxGUoghKlCcP9llHTWbs4Sih
 PVAZJ2kgNnsO09/NDW1gMfRsMSYdDN6uT6+ENEDc0RdCmjw/7Tp9pgFO+6htwb0dSpuV
 cgGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ+O1jMokvXnfXQxTKER1l6CwaDdSFZMtQJ96ewX4lg9rgNau5P2nEx+fa4A3Oz8S4FynM3U8OaWRQAGMIidNV1OWG6BE=
X-Gm-Message-State: AOJu0YycqLlvj8A+WplCyPOWpswHDoBZHHnJUJUkFOruMDjhgkgrhruK
 TxZ3fClsNivlcb6IiaQnMTalqfOlnXDCj19nW7A4fkbxQzL9O1pqsuNozkGDZoA=
X-Google-Smtp-Source: AGHT+IGaHWUkZN74ZL0dcLxAa3LPmFWkrCi3Q1+pUxT1pvQRQxVtmPpImcCotXYB0QVRGpPAz8u1Pg==
X-Received: by 2002:a05:600c:3388:b0:425:796b:3813 with SMTP id
 5b1f17b1804b1-4264a456313mr15371245e9.28.1720117943439; 
 Thu, 04 Jul 2024 11:32:23 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f2391sm33787885e9.25.2024.07.04.11.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:32:23 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:32:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 12/19] hw/arm/smmu: Support nesting in
 smmuv3_range_inval()
Message-ID: <20240704183236.GI1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-13-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-13-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 01, 2024 at 11:02:34AM +0000, Mostafa Saleh wrote:
> With nesting, we would need to invalidate IPAs without
> over-invalidating stage-1 IOVAs. This can be done by
> distinguishing IPAs in the TLBs by having ASID=-1.
> To achieve that, rework the invalidation for IPAs to have a
> separate function, while for IOVA invalidation ASID=-1 means
> invalidate for all ASIDs.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 47 ++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c              | 23 ++++++++++++------
>  hw/arm/trace-events          |  2 +-
>  include/hw/arm/smmu-common.h |  3 ++-
>  4 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 71afd486ba..5bf9eadeff 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -195,6 +195,25 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>             ((entry->iova & ~info->mask) == info->iova);
>  }
>  
> +static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
> +                                             gpointer user_data)
> +{
> +    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
> +    IOMMUTLBEntry *entry = &iter->entry;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
> +    SMMUIOTLBKey iotlb_key = *(SMMUIOTLBKey *)key;
> +
> +    if (info->asid >= 0) {

Should this test SMMU_IOTLB_ASID(iotlb_key) instead?

> +        /* This is a stage-1 address. */
> +        return false;
> +    }
> +    if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
> +        return false;
> +    }
> +    return ((info->iova & ~entry->addr_mask) == entry->iova) ||
> +           ((entry->iova & ~info->mask) == info->iova);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> @@ -223,6 +242,34 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                                  &info);
>  }
>  
> +/*
> + * Similar to smmu_iotlb_inv_iova(), but for Stage-2, ASID is always -1,
> + * in Stage-1 invalidation ASID = -1, means don't care.
> + */
> +void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> +                        uint64_t num_pages, uint8_t ttl)
> +{
> +    uint8_t granule = tg ? tg * 2 + 10 : 12;
> +    int asid = -1;
> +
> +   if (ttl && (num_pages == 1)) {
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
> +
> +        if (g_hash_table_remove(s->iotlb, &key)) {
> +            return;
> +        }
> +    }
> +
> +    SMMUIOTLBPageInvInfo info = {
> +        .iova = ipa,
> +        .vmid = vmid,
> +        .mask = (num_pages * 1 << granule) - 1};

Since multiplication takes precedence over shift this looks strange.
We could just remove "* 1" here and in smmu_iotlb_inv_iova() to avoid the
confusion?

Thanks,
Jean

> +
> +    g_hash_table_foreach_remove(s->iotlb,
> +                                smmu_hash_remove_by_vmid_ipa,
> +                                &info);
> +}
> +
>  void smmu_iotlb_inv_asid(SMMUState *s, int asid)
>  {
>      trace_smmu_iotlb_inv_asid(asid);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 86f95c1e40..e5ecd93258 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1136,7 +1136,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>      }
>  }
>  
> -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1161,9 +1161,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
>      }
>  
>      if (!tg) {
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
> +        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> +        if (stage == SMMU_STAGE_1) {
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> +        } else {
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
> +        }
>          return;
>      }
>  
> @@ -1179,9 +1183,14 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
>          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
>  
>          num_pages = (mask + 1) >> granule;
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
> +        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
> +                                 ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> +        if (stage == SMMU_STAGE_1) {
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> +        } else {
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
> +        }
>          addr += mask + 1;
>      }
>  }
> @@ -1340,7 +1349,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> @@ -1365,7 +1374,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
>              break;
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 09ccd39548..7d9c1703da 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -46,7 +46,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
>  smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> -smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
> +smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
>  smmuv3_cmdq_tlbi_nh(void) ""
>  smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index cf0fd3ec74..de032fdfd1 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -216,7 +216,8 @@ void smmu_iotlb_inv_asid(SMMUState *s, int asid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> -
> +void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> +                        uint64_t num_pages, uint8_t ttl);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

