Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A08EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6QQ-0000OT-7g; Wed, 17 Jul 2024 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6QO-0000ND-B9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6QI-0007MI-1j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721229508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cu/WCS2ayhdK6sXC0CRJmzcm+Ya3b9AwenbiJkBP6eo=;
 b=WqQVxGv0YY9YdoP7YbeFX6+kheCGTiDNrVOE77a9UO6Ugr+eINYB5l60HBWruoQIHNRx9N
 wkFzCvT0VJXqLzr6VyAv786HNnt2rLG9ToQDMjTqEQxt56gUT/HWsizwKLhNfawkeZc4tK
 QftUna0wzv88uzZE/2xQ6ZgzFIxpd8Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-R00GR8UuP62Uml8pkJQuIw-1; Wed, 17 Jul 2024 11:18:27 -0400
X-MC-Unique: R00GR8UuP62Uml8pkJQuIw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-664fc7c4e51so17794187b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721229507; x=1721834307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cu/WCS2ayhdK6sXC0CRJmzcm+Ya3b9AwenbiJkBP6eo=;
 b=kBC+PtXZMJhOr5wKMB9Vs0GM4lpqstDgEalzd+pUTm2G063obxOw0q8Zzo7Px18NCU
 xJSuPExYTNQMe7/PKSMSBmPb4LL243peBW5i28GEvCeoarviWVdmZcpREN4k95nCcaYA
 cOpg2FbAWnD6vzxg1dC1YStsabCLix8Akb6pcHr4qUbFOG0qM8JUOTDpdjJSF4YQV3sv
 Fs9Kbsv+vpCMSom7p1rbCb2w4RtrZvvC7rr0SKXibQKtN+bSDc2eomvbgSa2WGs8G2Qm
 5qR/U9OF1DxQ+pUFMVWStJ3Bwj5UEqIHZzM/f1S3ZtTQ2+XDe2fdAiPp4SWUYw0z/Bij
 CRBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1WOMco3eD6uJURNiyMi7g/I4tRR8jSm7bBiGiHx14KCNzai/x1+mBgbM49XHKeTnnkac7Wop8wOZ6SQ2U4/tIJUeb3ic=
X-Gm-Message-State: AOJu0YxHHrD8KEEi/oEEDprqEKMhIwgIntFZDtq8EAw8us0sfZ/FZvFh
 VbJKDsivcPf6I/rUr4KyAmy7x/tedrAESF2wTqE9StrzBu6X7ycJaUNsMIJnXA7WVVSOQIqy9zh
 Eeg4Xg8EcN0OG/ugT9+M2oBB0wNll9t9psCWdLf2Zko0XAvfPVOvj
X-Received: by 2002:a05:690c:4985:b0:649:4256:9d49 with SMTP id
 00721157ae682-665005732ddmr26385737b3.42.1721229506743; 
 Wed, 17 Jul 2024 08:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx8QA0kSAITa2r0UZ10MjsK1q63Zi6ZChdXXdK5Ug+KR75IAB5QwC1ifqDCgxQpawGE6LMoQ==
X-Received: by 2002:a05:690c:4985:b0:649:4256:9d49 with SMTP id
 00721157ae682-665005732ddmr26385457b3.42.1721229506336; 
 Wed, 17 Jul 2024 08:18:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c6f54asm414432785a.121.2024.07.17.08.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:18:25 -0700 (PDT)
Message-ID: <2f807f62-3a4e-4403-bad1-18f09fb5c1f8@redhat.com>
Date: Wed, 17 Jul 2024 17:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/18] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-9-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-9-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 7/15/24 10:45, Mostafa Saleh wrote:
> According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
> In "5.2 Stream Table Entry":
>  [51:6] S1ContextPtr
>  If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
>  stage 2 and the programmed value must be within the range of the IAS.
>
> In "5.4.1 CD notes":
>  The translation table walks performed from TTB0 or TTB1 are always performed
>  in IPA space if stage 2 translations are enabled.
>
> This patch implements translation of the S1 context descriptor pointer and
> TTBx base addresses through the S2 stage (IPA -> PA)
>
> smmuv3_do_translate() is updated to have one arg which is translation
> class, this is useful to:
>  - Decide wether a translation is stage-2 only or use the STE config.
>  - Populate the class in case of faults, WALK_EABT is left unchanged
>    for stage-1 as it is always IN, while stage-2 would match the
>    used class (TT, IN, CD), this will change slightly when the ptw
>    supports nested translation as it can also issue TT event with
>    class IN.
>
> In case for stage-2 only translation, used in the context of nested
> translation, the stage and asid are saved and restored before and
> after calling smmu_translate().
>
> Translating CD or TTBx can fail for the following reasons:
> 1) Large address size: This is described in
>    (3.4.3 Address sizes of SMMU-originated accesses)
>    - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
>      C_BAD_STE or Translation fault, we implement the latter as it
>      requires no extra code.
>    - For TTBx, if larger than the effective stage 1 output address size, it
>      triggers C_BAD_CD.
>
> 2) Faults from PTWs (7.3 Event records)
>    - F_ADDR_SIZE: large address size after first level causes stage 2 Address
>      Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
>    - F_PERMISSION: Same as an address translation. However, when
>      CLASS == CD, the access is implicitly Data and a read.
>    - F_ACCESS: Same as an address translation.
>    - F_TRANSLATION: Same as an address translation.
>    - F_WALK_EABT: Same as an address translation.
>   These are already implemented in the PTW logic, so no extra handling
>   required.
>
> As in CD and TTBx translation context, the iova is not known, setting
> the InputAddr was removed from "smmuv3_do_translate" and set after
> from "smmuv3_translate" with the new function "smmuv3_fixup_event"
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 120 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 103 insertions(+), 17 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 3f2dfada44..73d5a25705 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>  
>  }
>  
> +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> +                                                 SMMUTransCfg *cfg,
> +                                                 SMMUEventInfo *event,
> +                                                 IOMMUAccessFlags flag,
> +                                                 SMMUTLBEntry **out_entry,
> +                                                 SMMUTranslationClass class);
>  /* @ssid > 0 not supported yet */
> -static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
> -                       CD *buf, SMMUEventInfo *event)
> +static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
> +                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
>  {
>      dma_addr_t addr = STE_CTXPTR(ste);
>      int ret, i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      trace_smmuv3_get_cd(addr);
> +
> +    if (cfg->stage == SMMU_NESTED) {
> +        status = smmuv3_do_translate(s, addr, cfg, event,
> +                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
> +
> +        /* Same PTW faults are reported but with CLASS = CD. */
> +        if (status != SMMU_TRANS_SUCCESS) {
> +            return -EINVAL;
> +        }
> +
> +        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
> +    }
> +
>      /* TODO: guarantee 64-bit single-copy atomicity */
>      ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>                            MEMTXATTRS_UNSPECIFIED);
> @@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>      return 0;
>  }
>  
> -static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> +static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> +                     CD *cd, SMMUEventInfo *event)
>  {
>      int ret = -EINVAL;
>      int i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>          goto bad_cd;
> @@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>  
>          tt->tsz = tsz;
>          tt->ttb = CD_TTB(cd, i);
> +
>          if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
>              goto bad_cd;
>          }
> +
> +        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
> +        if (cfg->stage == SMMU_NESTED) {
> +            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
> +                                         &entry, SMMU_CLASS_TT);
> +            /*
> +             * Same PTW faults are reported but with CLASS = TT.
> +             * If TTBx is larger than the effective stage 1 output addres
> +             * size, it reports C_BAD_CD, which is handled by the above case.
> +             */
> +            if (status != SMMU_TRANS_SUCCESS) {
> +                return -EINVAL;
> +            }
> +            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
> +        }
> +
>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> @@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return 0;
>      }
>  
> -    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
> +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
>      if (ret) {
>          return ret;
>      }
>  
> -    return decode_cd(cfg, &cd, event);
> +    return decode_cd(s, cfg, &cd, event);
>  }
>  
>  /**
> @@ -832,58 +873,80 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
>                                                   SMMUEventInfo *event,
>                                                   IOMMUAccessFlags flag,
> -                                                 SMMUTLBEntry **out_entry)
> +                                                 SMMUTLBEntry **out_entry,
> +                                                 SMMUTranslationClass class)
>  {
>      SMMUPTWEventInfo ptw_info = {};
>      SMMUState *bs = ARM_SMMU(s);
>      SMMUTLBEntry *cached_entry = NULL;
> +    int asid, stage;
> +    bool desc_s2_translation = class != SMMU_CLASS_IN;
> +
> +    /*
> +     * The function uses the argument class to identify which stage is used:
> +     * - CLASS = IN: Means an input translation, determine the stage from STE.
> +     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
> +     *   translated using the stage-2.
> +     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
> +     *   and it would be translated using the stage-2.
> +     * For the last 2 cases instead of having intrusive changes in the common
> +     * logic, we modify the cfg to be a stage-2 translation only in case of
> +     * nested, and then restore it after.
> +     */
> +    if (desc_s2_translation) {
> +        asid = cfg->asid;
> +        stage = cfg->stage;
> +        cfg->asid = -1;
> +        cfg->stage = SMMU_STAGE_2;
> +    }
>  
>      cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
> +
> +    if (desc_s2_translation) {
> +        cfg->asid = asid;
> +        cfg->stage = stage;
> +    }
> +
>      if (!cached_entry) {
>          /* All faults from PTW has S2 field. */
>          event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
>              event->type = SMMU_EVT_F_WALK_EABT;
> -            event->u.f_walk_eabt.addr = addr;
>              event->u.f_walk_eabt.rnw = flag & 0x1;
>              event->u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
> -                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
> +                                          class : SMMU_CLASS_TT;
>              event->u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event->type = SMMU_EVT_F_TRANSLATION;
> -                event->u.f_translation.addr = addr;
>                  event->u.f_translation.addr2 = ptw_info.addr;
> -                event->u.f_translation.class = SMMU_CLASS_IN;
> +                event->u.f_translation.class = class;
>                  event->u.f_translation.rnw = flag & 0x1;
>              }
>              break;
>          case SMMU_PTW_ERR_ADDR_SIZE:
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event->type = SMMU_EVT_F_ADDR_SIZE;
> -                event->u.f_addr_size.addr = addr;
>                  event->u.f_addr_size.addr2 = ptw_info.addr;
> -                event->u.f_addr_size.class = SMMU_CLASS_IN;
> +                event->u.f_addr_size.class = class;
>                  event->u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
>          case SMMU_PTW_ERR_ACCESS:
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event->type = SMMU_EVT_F_ACCESS;
> -                event->u.f_access.addr = addr;
>                  event->u.f_access.addr2 = ptw_info.addr;
> -                event->u.f_access.class = SMMU_CLASS_IN;
> +                event->u.f_access.class = class;
>                  event->u.f_access.rnw = flag & 0x1;
>              }
>              break;
>          case SMMU_PTW_ERR_PERMISSION:
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event->type = SMMU_EVT_F_PERMISSION;
> -                event->u.f_permission.addr = addr;
>                  event->u.f_permission.addr2 = ptw_info.addr;
> -                event->u.f_permission.class = SMMU_CLASS_IN;
> +                event->u.f_permission.class = class;
>                  event->u.f_permission.rnw = flag & 0x1;
>              }
>              break;
> @@ -896,6 +959,27 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>      return SMMU_TRANS_SUCCESS;
>  }
>  
> +/*
> + * Sets the InputAddr for an SMMU_TRANS_ERROR, as it can't be
> + * set from all contexts, as smmuv3_get_config() can return
> + * translation faults in case of nested translation (for CD
> + * and TTBx). But in that case the iova is not known.
> + */
> +static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
> +{
> +    switch (event->type) {
> +    case SMMU_EVT_F_WALK_EABT:
> +    case SMMU_EVT_F_TRANSLATION:
> +    case SMMU_EVT_F_ADDR_SIZE:
> +    case SMMU_EVT_F_ACCESS:
> +    case SMMU_EVT_F_PERMISSION:
> +        event->u.f_walk_eabt.addr = iova;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>  /* Entry point to SMMU, does everything. */
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag, int iommu_idx)
> @@ -944,7 +1028,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
> +    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
> +                                 &cached_entry, SMMU_CLASS_IN);
>  
>  epilogue:
>      qemu_mutex_unlock(&s->mutex);
> @@ -975,6 +1060,7 @@ epilogue:
>                                       entry.perm);
>          break;
>      case SMMU_TRANS_ERROR:
> +        smmuv3_fixup_event(&event, addr);
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s translation failed for iova=0x%"PRIx64" (%s)\n",
>                        mr->parent_obj.name, addr, smmu_event_string(event.type));


