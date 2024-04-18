Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01860C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 14:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxT2J-00080J-MI; Thu, 18 Apr 2024 10:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxT25-0007wV-Fx
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxT21-0006Ct-UT
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713451592;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt1H6YHE3uANqLlb5H/WW66779er0jWqNwBP9uLtL1s=;
 b=Rztj//AWBwRDP/Vcnudne1dyBrmZb4J7FS1Uu1DLe1lRv8sDoVCKVW5GXA+N5YOgSdSlqp
 SQJZofVOmgImA4305pG32MQLckQOyZ+acU6YF5tNFCCbNnzyvHKHdKG8W6j+hWuYH9V+lP
 D8dTBfyz/5u9t+zuQyyqsSgcDaSuFkg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-rPUmb8PiNpulUdTzPPDWJw-1; Thu, 18 Apr 2024 10:46:30 -0400
X-MC-Unique: rPUmb8PiNpulUdTzPPDWJw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56865619070so417799a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 07:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713451590; x=1714056390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tt1H6YHE3uANqLlb5H/WW66779er0jWqNwBP9uLtL1s=;
 b=Z8sMPpgQyVNL69Js3I8R7mD4trTpjUwMGE4kjj8u+Zx8KFie479XYTbRnt3xY7fOhV
 k+Q6FsSWVVu8DyXY86ajw0+nPlsyYv5cV3FnjDOs3iI484oPrklfreKduTNWncSOh6U+
 PAAUmrlW2oGtwo3XvYAmUeflTkQiE60pSTwfb1Ylem6JbqdE8WAJwt5IAiIfFxPDMIEs
 dK30JMQ1fOAEpYSaAetrrMZ+R7u9kj3Z09gptMaF/gtiyi1oCQsQ1vcYIPYxNSWCxaHD
 JvdwK21+aebHAvnF8H1UKTqwqRjAKWFtC8A0Brm6a2rcpaFGiLWdTt47XvfpOYJUM5Fb
 WPig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrQpCgYb4rVoPZPBIzXCinh15eQq5shsswbA4w4SmrynukOCvVipDP2BL3msDDbbLuPyh1pcetrJ67DTQOP4nHVJD9xkw=
X-Gm-Message-State: AOJu0Yy7TxQ0Jug77TH+5LJDRyLyFIwQ6WpDoXxdieDCkr4BfpgP/ZK7
 EBlvTi3VmF/E4mYAZhl55SwRTAfcfXTlbLU/HtFKtrznNiIkCi3VbB8gN139bWM4eClaJSQj/9z
 DNHdHrX4ykqxjmfaapyNnpXz7K2z9eovmMyRs/NNawtgdAqa+tLcD
X-Received: by 2002:a17:906:415a:b0:a55:66d2:95dc with SMTP id
 l26-20020a170906415a00b00a5566d295dcmr1844842ejk.48.1713451589803; 
 Thu, 18 Apr 2024 07:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMgYJ4G7jqPGfhbSTYYA7iozDB97Cx2FI91E6YZHzVQjKxJz+K7sqZZ+wq+zAjkR9Qq0yErQ==
X-Received: by 2002:a17:906:415a:b0:a55:66d2:95dc with SMTP id
 l26-20020a170906415a00b00a5566d295dcmr1844824ejk.48.1713451589375; 
 Thu, 18 Apr 2024 07:46:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a17090627ce00b00a525669000csm989065ejc.154.2024.04.18.07.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 07:46:29 -0700 (PDT)
Message-ID: <7053fa09-a942-45b0-b8e8-5003107a6f32@redhat.com>
Date: Thu, 18 Apr 2024 16:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/13] hw/arm/smmu: Support nesting in
 smmuv3_range_inval()
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-7-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-7-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On 4/8/24 16:08, Mostafa Saleh wrote:
> With nesting, we would need to invalidate IPAs without
> over-invalidating stage-1 IOVAs. This can be done by
> distinguishing IPAs in the TLBs by having ASID=-1.
> To achieve that, rework the invalidation for IPAs to have a
> separate function, while for IOVA invalidation ASID=-1 means
> invalidate for all ASIDs.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 47 ++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c              | 23 ++++++++++++------
>  hw/arm/trace-events          |  2 +-
>  include/hw/arm/smmu-common.h |  3 ++-
>  4 files changed, 66 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 2cf27b490b..8b9e59b24b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -184,6 +184,25 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
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
> +    /* This is a stage-1 address. */
> +    if (info->asid >= 0) {
nit: I am rather used to have the comment associated to the condition
after the condition check
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
> @@ -212,6 +231,34 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
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
> index a7cf543acc..17bbd43c13 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1095,7 +1095,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>      }
>  }
>  
> -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1120,9 +1120,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
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
> @@ -1138,9 +1142,14 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
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
> @@ -1299,7 +1308,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> @@ -1324,7 +1333,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
>              break;
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 5f23f0b963..f5c361d96e 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -46,7 +46,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
>  smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> -smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
> +smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
>  smmuv3_cmdq_tlbi_nh(void) ""
>  smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 03ff0f02ba..df166d8477 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -230,7 +230,8 @@ void smmu_iotlb_inv_asid(SMMUState *s, int asid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> -
> +void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> +                        uint64_t num_pages, uint8_t ttl);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);

Besides looks good to me
smmu_hash_remove_by_vmid_ipa
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>  


