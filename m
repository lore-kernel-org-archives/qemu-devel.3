Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E0AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raW4V-000342-U9; Thu, 15 Feb 2024 02:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raW4U-00033i-0o
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raW4S-0006g0-8J
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707981730;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTPYKsLPweiGLixPJw7Ynw2sWN+4bAfBkl5lH6yS+wU=;
 b=FIqG1b37EAhiBQabJNTOuSaaM7tFJ+3TSl6vQbuGuhcf8+8UjsTJH7zdYuv/ol8ljoCavE
 7nVViR4MZ04W3Ycla0AGBGvoJcPnkfOIsav8rqmyGJsoMOFbEhXxb8T2X7k3FoQtf6Snp+
 fX7UPG8uIkNZUDYa9wlG4CJJFysiz1A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-lMKyp5tDPGi8-kljFybgBA-1; Thu, 15 Feb 2024 02:22:08 -0500
X-MC-Unique: lMKyp5tDPGi8-kljFybgBA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42793cd9d33so6336061cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707981728; x=1708586528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTPYKsLPweiGLixPJw7Ynw2sWN+4bAfBkl5lH6yS+wU=;
 b=t1UJQMlZDb6e2eUlkicEZXxYsAVMvD+/GeKrz96o5q9oYK4Z2YNnz16XeA+cpRveGC
 OgTY3r9J+cx2RYpj2cyRxL9tH/rplKXviz/EszCtXm5mHuqx02o51ppn3n8edlriX7R5
 knQZUkh14us91Vq5wFO+Jijee853DNK1+Y+PMx4eASk+NLxeQU5Vf/y3wlFUvlsKGm7G
 QPg6SjTrWIoJOI+gxtryY3D5HRH0N+JvDJ7JT9vN6xcaqXDBZPzmquqJqBFyuOTe6Szm
 pOT8n/+Swg4QelpBghQjU9D/l1/AyKpCZkUpSesla7gKedJBsLEskGf33UI0c/q4vDGd
 PX/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYT+y+wiS8sYWtrbVvqZ2OWdH0ypROw04Il/qEigpVzsHWYi364MESpSB0/oorMwZ9UacEiUEmtBOqrMG9we4pIYNaIsA=
X-Gm-Message-State: AOJu0Yxra7rnBLbtg1qoCBiEBfswcptto377e3jJWyk2b37RUTdB83SR
 ihZWP9bCQNkvGumpK5dpIOdFiyHF7da5ahZ2xiFT6NZ01xfvmA5zw/WN7u+VlK5kqGtCjYQ3/E/
 r/rPSN4R7or35REUK1Oz7Nx+ftOO6lBAxLt+UtVAHl0VtgWyfzf+r
X-Received: by 2002:a05:622a:16:b0:42c:75b9:b67f with SMTP id
 x22-20020a05622a001600b0042c75b9b67fmr1126596qtw.31.1707981728006; 
 Wed, 14 Feb 2024 23:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC3ErOjzUeM69VlieR9qMGqqqPQUNkwNC0GHCA3xHDolgWJ/QEPsycz1/+zRsbKtj731g2Rw==
X-Received: by 2002:a05:622a:16:b0:42c:75b9:b67f with SMTP id
 x22-20020a05622a001600b0042c75b9b67fmr1126590qtw.31.1707981727738; 
 Wed, 14 Feb 2024 23:22:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 b1-20020ac85bc1000000b0042c5715b8d1sm332188qtb.76.2024.02.14.23.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:22:07 -0800 (PST)
Message-ID: <522cfa0b-050a-4a93-acf5-62dfe71c8185@redhat.com>
Date: Thu, 15 Feb 2024 08:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/smmuv3: add support for stage 1 access fault
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20240213082211.3330400-1-luc.michel@amd.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213082211.3330400-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Luc,
On 2/13/24 09:22, Luc Michel wrote:
> An access fault is raised when the Access Flag is not set in the
> looked-up PTE and the AFFD field is not set in the corresponding context
> descriptor. This was already implemented for stage 2. Implement it for
> stage 1 as well.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>
> v2: drop erroneous submodule modification
>
> ---
>
>  hw/arm/smmuv3-internal.h     |  1 +
>  include/hw/arm/smmu-common.h |  1 +
>  hw/arm/smmu-common.c         | 10 ++++++++++
>  hw/arm/smmuv3.c              |  1 +
>  4 files changed, 13 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index e987bc4686b..e4dd11e1e62 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -622,10 +622,11 @@ static inline int pa_range(STE *ste)
>  #define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
>  #define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
>  #define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
>  #define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
>  #define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
> +#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
>  #define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
>  #define CD_HD(x)         extract32((x)->word[1], 10 , 1)
>  #define CD_HA(x)         extract32((x)->word[1], 11 , 1)
>  #define CD_S(x)          extract32((x)->word[1], 12, 1)
>  #define CD_R(x)          extract32((x)->word[1], 13, 1)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index fd8d772da11..5ec2e6c1a43 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -90,10 +90,11 @@ typedef struct SMMUTransCfg {
>      /* Shared fields between stage-1 and stage-2. */
>      int stage;                 /* translation stage */
>      bool disabled;             /* smmu is disabled */
>      bool bypassed;             /* translation is bypassed */
>      bool aborted;              /* translation is aborted */
> +    bool affd;                 /* AF fault disable */
>      uint32_t iotlb_hits;       /* counts IOTLB hits */
>      uint32_t iotlb_misses;     /* counts IOTLB misses*/
>      /* Used by stage-1 only. */
>      bool aa64;                 /* arch64 or aarch32 translation table */
>      bool record_faults;        /* record fault events */
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 9a8ac45431a..09ff72e55f5 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -362,10 +362,20 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                                          &block_size);
>              trace_smmu_ptw_block_pte(stage, level, baseaddr,
>                                       pte_addr, pte, iova, gpa,
>                                       block_size >> 20);
>          }
> +
> +        /*
> +         * If AFFD and PTE.AF are 0 => fault. (5.4. Context Descriptor)
> +         * An Access fault takes priority over a Permission fault.
nit: you may precise that this holds because HTTU is not currently supported
> +         */
> +        if (!PTE_AF(pte) && !cfg->affd) {
> +            info->type = SMMU_PTW_ERR_ACCESS;
> +            goto error;
> +        }
> +
>          ap = PTE_AP(pte);
>          if (is_permission_fault(ap, perm)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
>              goto error;
>          }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 68eeef3e1d4..c416b8c0030 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -682,10 +682,11 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
>      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
>      cfg->tbi = CD_TBI(cd);
>      cfg->asid = CD_ASID(cd);
> +    cfg->affd = CD_AFFD(cd);
>  
>      trace_smmuv3_decode_cd(cfg->oas);
>  
>      /* decode data dependent on TT */
>      for (i = 0; i <= 1; i++) {
Besides, looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


