Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD607C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrh4T-0007Ra-Ko; Tue, 02 Apr 2024 12:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rrh4N-0007Qz-6p
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rrh4H-0004Ga-Q5
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712075580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Gp+AYX+B6a3r3r9M6DCYa1jM7O40RntXsTDxZxHxz8=;
 b=IVZGETkCq+OvJGHMRCyOq+fNzpMcup2xG3sIuqIR056i9wui+eCOTPe0TIOufrlPgfDiiZ
 lao30oQ8tCpI1pjkjM9lOE2xZsxPHjnf4r52YeBejqO1NyoqOLDR42g3COtnwTbepvkLUr
 K5omqiro1DOme8TyR1ovO0rYPi5XLAk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-PQt6S7YhOsiKc1VZ8BDywg-1; Tue, 02 Apr 2024 12:32:59 -0400
X-MC-Unique: PQt6S7YhOsiKc1VZ8BDywg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ec604d3b3so3390206f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712075577; x=1712680377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Gp+AYX+B6a3r3r9M6DCYa1jM7O40RntXsTDxZxHxz8=;
 b=H7GaBBv5fiAndyDZ2vsbr67BvUEaQBh4YYG3iMgjxq29nkkf2bb5OSS6ck/mPj80X6
 4uizVmX7+VjTNOk4HhuiDCgtosRcwhRfPaXJb6VmpyrBZBgnHoZO3gmbDgwtrU4mbBcH
 hLlorEoQ67Gfqlq+Kd8FPVpa1qM0Eefkt0+vbaYE046ZIXiG/gqE/KuzLCheJlUiWKnV
 YEFMYjvgceX1R/q0hivFCepixrks3ULjXYCydGgWRvzEl1wXx6FR0cjPCLzYKqirvUgB
 apXnr2YNt2ZTsFUB708lmpPrtbHtoZAXdLG/5xGFXBRoblB7+h4rWyNCq3dHY+1vMBXp
 wAPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd0hfHnWCPnsB+vL+xn1Li0rLZC7cf7KujatTUlnb/EMXN2HymISlQF9l4whwoY7G7AWnsCsN10g8EGU9NVynxfVCwrtQ=
X-Gm-Message-State: AOJu0YzX437su/IHLzmjrKivXd0N9G+SYUnN/buCAeq6KuzfuWNi7F46
 PfX3ah3GxaSLmyWy7cM5rgampQkE4PExCVDemSNWygvpJWYTirgfIMPy1CmkDdkrUqNi6IkvUzc
 cnAT90BSd7uIY7pKfsDs1i3PkUM4LXZnRhPmPVyx8fZMeFAsU75MV
X-Received: by 2002:a5d:6741:0:b0:33e:bf11:a007 with SMTP id
 l1-20020a5d6741000000b0033ebf11a007mr196192wrw.31.1712075577724; 
 Tue, 02 Apr 2024 09:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFspZly6Vsx6agtFxvSgfbdIX7wJHVDXqXK0y25VfafAChM+uRveDGY8bDvWcQlPBgT5zgfMA==
X-Received: by 2002:a5d:6741:0:b0:33e:bf11:a007 with SMTP id
 l1-20020a5d6741000000b0033ebf11a007mr196178wrw.31.1712075577416; 
 Tue, 02 Apr 2024 09:32:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bt30-20020a056000081e00b0034183537986sm14882027wrb.23.2024.04.02.09.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 09:32:55 -0700 (PDT)
Message-ID: <bdc6bcf5-a937-4320-ac6e-6476523712e8@redhat.com>
Date: Tue, 2 Apr 2024 18:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] hw/arm/smmu: Use enum for SMMU stage
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-2-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240325101442.1306300-2-smostafa@google.com>
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
> Currently, translation stage is represented as an int, where 1 is stage-1 and
> 2 is stage-2, when nested is added, 3 would be confusing to represent nesting,
> so we use an enum instead.
>
> While keeping the same values, this is useful for:
>  - Doing tricks with bit masks, where BIT(0) is stage-1 and BIT(1) is
>    stage-2 and both is nested.
>  - Tracing, as stage is printed as int.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         | 14 +++++++-------
>  hw/arm/smmuv3.c              | 15 ++++++++-------
>  include/hw/arm/smmu-common.h | 11 +++++++++--
>  3 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 4caedb4998..3a7c350aca 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -304,7 +304,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                            SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
>      dma_addr_t baseaddr, indexmask;
> -    int stage = cfg->stage;
> +    SMMUStage stage = cfg->stage;
>      SMMUTransTableInfo *tt = select_tt(cfg, iova);
>      uint8_t level, granule_sz, inputsize, stride;
>  
> @@ -392,7 +392,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>      info->type = SMMU_PTW_ERR_TRANSLATION;
>  
>  error:
> -    info->stage = 1;
> +    info->stage = SMMU_STAGE_1;
>      tlbe->entry.perm = IOMMU_NONE;
>      return -EINVAL;
>  }
> @@ -415,7 +415,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>                            dma_addr_t ipa, IOMMUAccessFlags perm,
>                            SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
> -    const int stage = 2;
> +    const SMMUStage stage = SMMU_STAGE_2;
>      int granule_sz = cfg->s2cfg.granule_sz;
>      /* ARM DDI0487I.a: Table D8-7. */
>      int inputsize = 64 - cfg->s2cfg.tsz;
> @@ -513,7 +513,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>      info->type = SMMU_PTW_ERR_TRANSLATION;
>  
>  error:
> -    info->stage = 2;
> +    info->stage = SMMU_STAGE_2;
>      tlbe->entry.perm = IOMMU_NONE;
>      return -EINVAL;
>  }
> @@ -532,9 +532,9 @@ error:
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>               SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
> -    if (cfg->stage == 1) {
> +    if (cfg->stage == SMMU_STAGE_1) {
>          return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> -    } else if (cfg->stage == 2) {
> +    } else if (cfg->stage == SMMU_STAGE_2) {
>          /*
>           * If bypassing stage 1(or unimplemented), the input address is passed
>           * directly to stage 2 as IPA. If the input address of a transaction
> @@ -543,7 +543,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>           */
>          if (iova >= (1ULL << cfg->oas)) {
>              info->type = SMMU_PTW_ERR_ADDR_SIZE;
> -            info->stage = 1;
> +            info->stage = SMMU_STAGE_1;
>              tlbe->entry.perm = IOMMU_NONE;
>              return -EINVAL;
>          }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9eb56a70f3..50e5a72d54 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -34,7 +34,8 @@
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
>  
> -#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == 1) ? (cfg)->record_faults : \
> +#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
> +                                 (cfg)->record_faults : \
>                                   (cfg)->s2cfg.record_faults)
>  
>  /**
> @@ -402,7 +403,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
>  
>  static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>  {
> -    cfg->stage = 2;
> +    cfg->stage = SMMU_STAGE_2;
>  
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
> @@ -678,7 +679,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>  
>      /* we support only those at the moment */
>      cfg->aa64 = true;
> -    cfg->stage = 1;
> +    cfg->stage = SMMU_STAGE_1;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
>      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> @@ -762,7 +763,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return ret;
>      }
>  
> -    if (cfg->aborted || cfg->bypassed || (cfg->stage == 2)) {
> +    if (cfg->aborted || cfg->bypassed || (cfg->stage == SMMU_STAGE_2)) {
>          return 0;
>      }
>  
> @@ -882,7 +883,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    if (cfg->stage == 1) {
> +    if (cfg->stage == SMMU_STAGE_1) {
>          /* Select stage1 translation table. */
>          tt = select_tt(cfg, addr);
>          if (!tt) {
> @@ -919,7 +920,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>               * nesting is not supported. So it is sufficient to check the
>               * translation stage to know the TLB stage for now.
>               */
> -            event.u.f_walk_eabt.s2 = (cfg->stage == 2);
> +            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_PERMISSION;
>                  event.u.f_permission.addr = addr;
> @@ -935,7 +936,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>  
>      if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
>          /* All faults from PTW has S2 field. */
> -        event.u.f_walk_eabt.s2 = (ptw_info.stage == 2);
> +        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
>          g_free(cached_entry);
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 5ec2e6c1a4..b3c881f0ee 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -49,8 +49,15 @@ typedef enum {
>      SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
>  } SMMUPTWEventType;
>  
> +/* SMMU Stage */
> +typedef enum {
> +    SMMU_STAGE_1 = 1,
> +    SMMU_STAGE_2,
> +    SMMU_NESTED,
> +} SMMUStage;
> +
>  typedef struct SMMUPTWEventInfo {
> -    int stage;
> +    SMMUStage stage;
>      SMMUPTWEventType type;
>      dma_addr_t addr; /* fetched address that induced an abort, if any */
>  } SMMUPTWEventInfo;
> @@ -88,7 +95,7 @@ typedef struct SMMUS2Cfg {
>   */
>  typedef struct SMMUTransCfg {
>      /* Shared fields between stage-1 and stage-2. */
> -    int stage;                 /* translation stage */
> +    SMMUStage stage;           /* translation stage */
>      bool disabled;             /* smmu is disabled */
>      bool bypassed;             /* translation is bypassed */
>      bool aborted;              /* translation is aborted */


