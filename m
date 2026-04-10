Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52385E99052
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6ja-0005yX-CB; Fri, 10 Apr 2026 03:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6jZ-0005yH-Bn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6jW-0004Tr-J4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775807813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1g0itLpK4atu/TRh/SFG6m5vAPx388SgzqIeaV3NV0=;
 b=gXDuEWi6B9NXhfJIz4tgM3bU85qivjfXfyB/kkcXy+K8LH5gP+C4ea2UG8Q3SDmVmHnXm6
 Dk0d7Xgof+oUaE9JJCH3u547lNqIMzMwQ0luNXmkf7wJRmag+1Ktdce+Otre9va2LnYfey
 e82sDPp3oIDZJetlr5bZNYhxWXyiP/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Sz_TybYhNPG0uf1wwcB00Q-1; Fri, 10 Apr 2026 03:56:51 -0400
X-MC-Unique: Sz_TybYhNPG0uf1wwcB00Q-1
X-Mimecast-MFC-AGG-ID: Sz_TybYhNPG0uf1wwcB00Q_1775807810
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cff5bc312so1320939f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775807810; x=1776412610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1g0itLpK4atu/TRh/SFG6m5vAPx388SgzqIeaV3NV0=;
 b=PklC9f+Wr7vnw/fU19Uc5ngB7tU/d00jEUjNR4y3JycvA2dmQnrFoNPgsV8tC5n9+E
 Z7An9+KDRuuUj7Y6xaILeacLYYgp9/HUFDIiCbfuP0cq3ukh/zP4mNqeCmT3pkIMLbFK
 KwYoDJ/Iw5P9J/Xf/JBNbiYbI4L6UkFILr7bZ63kqIH4aYjPAOg4daHDrHV/3n2w4t5x
 eyCeBt2Gp2vXuc8o6kgZU060IA4pHfqZ4mE4M6V0jWOPl4q4ii14u6q0gcRCe0QKag/r
 5RxZ6PxVGThshh1bKJ7l71ucqsw1QE9Tn+Hgylkl2rEFapwdxjF32lLDoyP+K6HxjOcp
 g1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ9ObW3HMJGC25HvP6UEsjMZmFbmhFAILY1PoBZafEGpZoYSjSf0VZowCcZrQcPjbylC84/v16JTIr@nongnu.org
X-Gm-Message-State: AOJu0YzbIIzxKFOgbFwa1lpu2NahP7bAgldvD+ounz1+fIYE4jeR51FO
 DGn8da557XnqzQF4mxr+F1btU29+KNqIM6z+GAeqaE+jYzI8u8GkD5SO7FNXPkBbYei4h7M7mEV
 z+OQ03PzsvTSrB7Mp6YwZ6lsJUHqxe/DWyJIAyoS5BxfiCNVcB31VO14d
X-Gm-Gg: AeBDievYKanAYUhN8zXbVtwn+bIAPQFubtq1dAiFZuuxumERZLqvrs9wzzgZ8jG9DCx
 V5w0iRR9CGHeSmqmmH41D/8uTfkL+3Zx072D1nqEMZvsfo9epqoMMgQGwwL+OjYsnYwc/Vzpj1Y
 pkISZAD4rbmZjD2BiT7/eIyy+ONNGTEcaH/UcsmyJJ4X+V2PltwJrtn2V5xL1Y0u/I3I4D7Z6s+
 CUF0YnmCZ6aYhurCQlk/HI/eX6qAGU8Qfgf3o7YbMvivgvT6s3r73IePf7CrZPtUTJaosWIxzpT
 /lq4pxZZykYiY4LfTFizIkmM+zm+qbGDnHyhmD+zg3yRG5e5KdGgro/U/5dlD+UU7Z5iY5d1yaR
 Eu/aUytl9GQQp2yKghMRYxUvugOcDCw2AoCVS0+CP2aykZ7bXNojpWGA3stMlQsr0RIbmdA==
X-Received: by 2002:a05:600c:8907:b0:485:445a:87d1 with SMTP id
 5b1f17b1804b1-488d67d2cc5mr16435985e9.8.1775807810237; 
 Fri, 10 Apr 2026 00:56:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:485:445a:87d1 with SMTP id
 5b1f17b1804b1-488d67d2cc5mr16435775e9.8.1775807809783; 
 Fri, 10 Apr 2026 00:56:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ed50sm14465405e9.15.2026.04.10.00.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:56:49 -0700 (PDT)
Message-ID: <24339c4e-0654-445e-8ed4-bbe192c83523@redhat.com>
Date: Fri, 10 Apr 2026 09:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-8-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Allow accelerated SMMUv3 SSID size property to be derived from host
> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
> retrieving SSID size from IDR1. When the auto SSID size is resolved
> to a non-zero value, PASID capability is advertised to the vIOMMU
> and accelerated use cases such as Shared Virtual Addressing (SVA)
> are supported.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 14 ++++++++++++--
>  hw/arm/smmuv3.c       | 11 +++++------
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9e7ec6a930..03393fd7ba 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -56,6 +56,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>                                 FIELD_EX32(info->idr[3], IDR3, RIL));
>      }
>  
> +    /* Update SSIDSIZE if auto from info */
> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
> +        /* Store for get_viommu_flags() to determine PASID support */
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -828,7 +835,9 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs = opaque;
>      SMMUv3State *s = ARM_SMMUV3(bs);
>  
> -    if (s->ssidsize > SSID_SIZE_MODE_0) {
> +    if (s->ssidsize > SSID_SIZE_MODE_0 ||
> +        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
maybe worth adding a short static inline helper pasid_is_supported(s)?

Eric
> +         FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) {
>          flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -952,7 +961,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>      smmuv3_accel_as_init(s);
>  
>      if (s->ats == ON_OFF_AUTO_AUTO ||
> -        s->ril == ON_OFF_AUTO_AUTO) {
> +        s->ril == ON_OFF_AUTO_AUTO ||
> +        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 74cc81ae32..67c499d22b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -627,7 +627,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>      }
>  
>      /* Multiple context descriptors require SubstreamID support */
> -    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
> +    if ((s->ssidsize == SSID_SIZE_MODE_0 ||
> +         (s->ssidsize == SSID_SIZE_MODE_AUTO &&
> +          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
> +        STE_S1CDMAX(ste) != 0) {
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
>                  "Configure ssidsize > 0 (requires accel=on)\n");
> @@ -1973,10 +1976,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      }
>  #endif
>  
> -    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
> -        error_setg(errp, "ssidsize auto mode is not supported");
> -        return false;
> -    }
>      if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>          error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
>                     "OAS; other OasMode values are not supported");
> @@ -2197,7 +2196,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "Valid range is 0-20, where 0 disables SubstreamID support. "
>          "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support. ssidsize=auto is not supported.");
> +        "PASID support.");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,


