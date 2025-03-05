Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374C0C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps3p-0004S8-90; Wed, 05 Mar 2025 11:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tps3m-0004ON-TF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tps3k-0006yo-Us
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741193848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro/uAiz8KrtRiLEIDDBY59Jsc1UsZOMUjifs8ibsjpo=;
 b=D7wVl320Sk46FYsJTsU4bGokw9qyFozD2Tke6/QacScAJoc+7c4J5BBZONbwvExvfV4wwS
 XIY1BbRhbaaVp43ypSEeSjktd7BK+6Jw0xya83y5Oi5XTe3KjcM7tjxGHp2Vfjp4nI0gJ2
 /bLeKUnDfjqTEfmH+eILDj7r0xuZVAc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-FPbbOMpJPqmrYgsmHBTUhw-1; Wed, 05 Mar 2025 11:56:20 -0500
X-MC-Unique: FPbbOMpJPqmrYgsmHBTUhw-1
X-Mimecast-MFC-AGG-ID: FPbbOMpJPqmrYgsmHBTUhw_1741193779
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39104223bb5so1892469f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193779; x=1741798579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ro/uAiz8KrtRiLEIDDBY59Jsc1UsZOMUjifs8ibsjpo=;
 b=E859K9IE596NR+77YG1vI85YuFUV7faWIn52faz+ErexpMznJ/gpusngRInsJPUgrv
 tyhA+SnFNWNDxGxyR30v7drmpVlu9AJ57leekv4KstP5bNkm9/uvu3InuT+jmIf6digp
 /NQOGNsXeoTgd9877N5gdcvHf2JR08oPrEKgkzjVz73JtyehpTNxmi7Abs8QpQAkIRY5
 toy2ca1FHIRklUusLjmzXB/bDW/m6FKJQsxnkcQcdrpmbA3EK08U135zCixR5CpSncKM
 zu433HO5QTNWiESXLE0eazbMUq2KkGGHtyeiqQccvcqmfqEDtXuafVUr88Hb612aSZVn
 qALw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRD7LBVdEuov8jIQYu5jFQTTueg1NNPCrYsWfMgNHoHkor42KlO0Xgt23CLTMIgtqjRJiJOoQFvQkh@nongnu.org
X-Gm-Message-State: AOJu0Yzw8yCDsyrlMCSqv5MmK67RIy/w3NwHwFa87IwJzEOnqrBFVssC
 b3q4vqlasZrq8w0sJW1VSZ7E/YZNUebRR1ku0GW0DBaZ9XmSuVcNPl2lpCagVTI7uRT8E/ZbxZH
 W8xPiLrDxRqafj0AiauyqHzxrK4QOJQriwZ4CAMvvKKtORSZfup+a
X-Gm-Gg: ASbGncv1LIy8jgvj7yAIzpPCs5Mf546QZC9E46zJS0KFI2TQtz6NMRcAXW1yxMoV7rm
 HO3XxFP38IQDyRxL+V9vW3Rcfl2i86YNvTGmVuEIdCncueL/+ehLbgUHjpaDWlA6ZvHic7XEF1B
 IbJzXtOIP1Ro+Vb5IDobaClrF9q+i7EGuTEBi6SqSkDPa1uXpdmnLw3PC8O8tqbIawY7rNBbMcn
 pYFYVPBARvGeLmNW5U7OXcgvNdfyh1yYGkjxE4iTyfvvuuokdPx2j/DezcvSuMl3bmYZftO/dWj
 PXdpIoXCsS/IA7KBE5cqXL4WC78LY88+MbAlUAf03+pnx9DBm0KfDNHpHqw0w5E=
X-Received: by 2002:a5d:6d8a:0:b0:391:1f9:c599 with SMTP id
 ffacd0b85a97d-3911f726350mr2699719f8f.4.1741193778910; 
 Wed, 05 Mar 2025 08:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTpwqaUb2e3nPekDRpsPyGFA/nWmzMgzDpUc6iXlFAdVOR3hmIQriKoj0HQf60C4gkVunWLw==
X-Received: by 2002:a5d:6d8a:0:b0:391:1f9:c599 with SMTP id
 ffacd0b85a97d-3911f726350mr2699704f8f.4.1741193778536; 
 Wed, 05 Mar 2025 08:56:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292eeasm22539525e9.16.2025.03.05.08.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:56:17 -0800 (PST)
Message-ID: <a55764ff-5e44-4057-af0f-3beb9ae1c0c1@redhat.com>
Date: Wed, 5 Mar 2025 17:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/smmu: Introduce smmu_configs_inv_sid_range()
 helper
Content-Language: en-US
To: JianChunfu <jansef.jian@hj-micro.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250228031438.3916-1-jansef.jian@hj-micro.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250228031438.3916-1-jansef.jian@hj-micro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


Hi,

On 2/28/25 4:14 AM, JianChunfu wrote:
> Use a similar terminology smmu_hash_remove_by_sid_range() as the one
> being used for other hash table matching functions since
> smmuv3_invalidate_ste() name is not self explanatory, and introduce a
> helper that invokes the g_hash_table_foreach_remove.
>
> No functional change intended.
>
> Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> v3: - Modify the commit msg
>     - Rename the trace funtion
> v2: - move smmuv3_invalidate_ste() to smmu_hash_remove_by_sid_range()
>     - add function smmu_configs_inv_sid_range()
> v1: - Rename smmuv3_invalidate_ste to smmuv3_hash_remove_by_sid_range
> ---
>  hw/arm/smmu-common.c         | 21 +++++++++++++++++++++
>  hw/arm/smmu-internal.h       |  5 -----
>  hw/arm/smmuv3.c              | 19 ++-----------------
>  hw/arm/trace-events          |  3 ++-
>  include/hw/arm/smmu-common.h |  6 ++++++
>  5 files changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3f8272875..bad3b3b0b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -225,6 +225,27 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>             ((entry->iova & ~info->mask) == info->iova);
>  }
>  
> +static gboolean
> +smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
> +{
> +    SMMUDevice *sdev = (SMMUDevice *)key;
> +    uint32_t sid = smmu_get_sid(sdev);
> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> +
> +    if (sid < sid_range->start || sid > sid_range->end) {
> +        return false;
> +    }
> +    trace_smmu_config_cache_inv(sid);
> +    return true;
> +}
> +
> +void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
> +{
> +    trace_smmu_configs_inv_sid_range(sid_range.start, sid_range.end);
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
> +                                &sid_range);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index 843bebb18..d143d296f 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -141,9 +141,4 @@ typedef struct SMMUIOTLBPageInvInfo {
>      uint64_t mask;
>  } SMMUIOTLBPageInvInfo;
>  
> -typedef struct SMMUSIDRange {
> -    uint32_t start;
> -    uint32_t end;
> -} SMMUSIDRange;
> -
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4c49b5a88..1c55bc56d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -903,7 +903,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>  
> -    trace_smmuv3_config_cache_inv(smmu_get_sid(sdev));
> +    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
>      g_hash_table_remove(bc->configs, sdev);
>  }
>  
> @@ -1277,20 +1277,6 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>      }
>  }
>  
> -static gboolean
> -smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
> -{
> -    SMMUDevice *sdev = (SMMUDevice *)key;
> -    uint32_t sid = smmu_get_sid(sdev);
> -    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> -
> -    if (sid < sid_range->start || sid > sid_range->end) {
> -        return false;
> -    }
> -    trace_smmuv3_config_cache_inv(sid);
> -    return true;
> -}
> -
>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1373,8 +1359,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> -            g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
> -                                        &sid_range);
> +            smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
>          case SMMU_CMD_CFGI_CD:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index c64ad344b..e96f9ae47 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -15,6 +15,8 @@ smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
>  smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> +smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
> +smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>  smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
>  smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> @@ -52,7 +54,6 @@ smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
>  smmuv3_cmdq_tlbi_nsnh(void) ""
>  smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> -smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index e5ad55bba..e5e2d0929 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -142,6 +142,11 @@ typedef struct SMMUIOTLBKey {
>      uint8_t level;
>  } SMMUIOTLBKey;
>  
> +typedef struct SMMUSIDRange {
> +    uint32_t start;
> +    uint32_t end;
> +} SMMUSIDRange;
> +
>  struct SMMUState {
>      /* <private> */
>      SysBusDevice  dev;
> @@ -219,6 +224,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                          uint64_t num_pages, uint8_t ttl);
> +void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  


