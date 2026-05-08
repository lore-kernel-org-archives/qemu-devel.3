Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF3BCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJcb-0002Bb-Pk; Fri, 08 May 2026 07:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLJcQ-0002Aj-NG
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLJcO-00019N-EG
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778240621;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBD9knJHkMz8/JyNYM52rxDLrY54P+wCS4aKrgv6IkE=;
 b=d2ojw3jNwTvXMGS/Q2ZPLz/K9s+N7iDu74eoHhuGKxPJ8AgJWzn+UDcUhMPaSbONGjPbej
 ZQzAJJXSmMCWsqtB+3nM+6X+luhzc9X9gCKxpasznm4jXuia3ZO4Xu9TpFWT9ARP8MXGRP
 PmXKbD+q4gcr/sYJa/MWVD/MVXGcMOU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-3DUJmUdnPvqpkVDUrwkSqQ-1; Fri, 08 May 2026 07:43:37 -0400
X-MC-Unique: 3DUJmUdnPvqpkVDUrwkSqQ-1
X-Mimecast-MFC-AGG-ID: 3DUJmUdnPvqpkVDUrwkSqQ_1778240617
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso1189822f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 04:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778240617; x=1778845417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBD9knJHkMz8/JyNYM52rxDLrY54P+wCS4aKrgv6IkE=;
 b=UgKOXKF/4oZd0rV4rqNnJgobWsRnmERCN/FXKMtE4yjL17d2TZK/VgOivQHthF8rsI
 tVKu+oaTj3wfgRfuRG9Sy6fCT1Z9XTF9zBsoMUhzw1JeGkrmvE1tVBkVViXOVNjoCVPM
 3Ovjaymifu8uutogqYi2YO4TrFQE75MBjz+gi3PtTEcTyrGUOmm4s5Yl8k7B7yljHssg
 /umdrRB+Welkw6xTKWWFcCqkEDXB8YPXqY0/YZ2f5H9+UzfuAZvBxOqYyq70WN7R0E23
 8ZDPxPvlW5udgs0+Ybk/CHEvhvjOK6vsJXYnfD/IYIxQsiBkgU+c6TaCnlyMIW5D9gvF
 4Wjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WcmtKtl/LJ4/3p+1J1RMqjTTPs/xLh8Rh2RcwetIcjjqXTYyAYZ1kt0FfDLEEOSsJQpaWzGMy9qtx@nongnu.org
X-Gm-Message-State: AOJu0YwyvV5xxwOqug3DPAyvGZI9g22P3IGk+7x6rFRvajTERbV+LbEh
 OR35F1khzWWUaTEc0w/QlAK5rCaKXrr3NCBTqhTj8zmDXR/HdDISyMSFMzXMEC5yTBwV3A5y8h7
 jvOHsa5EJbRAp/clr9GGQSONb5n+RQl3PY5JHDw2swTtkBFQqorvH7mAy
X-Gm-Gg: Acq92OEueJjFXwFNSBJCx+0gavoSGSWrj85ZHYulfYry2bl9Govw+f/9WQlrv4MPUOW
 gfTNPQts0H9wnaZzkcSTjBI9ZtlGFjyYl1Nmct6eUyewPjukgFnyxQT3ckyQmT8pLetGnkwRs49
 sbdEBmbcSU29JVKoFaUUT2kxcUrC/Piye3RaKqPnhqqTcrMXgae3zCdjhF4/o7AQ8bAdrqAbmOs
 mL4mgObJzFJxUaio42r3HNkJttllR/wPqVmRfnRr7WOyVUTsqXePOeJA3vtyfL9dB4h436NCw/p
 wYedKdc1o7M0YclsQ7G010ofnw0XwzZzw5V3VLEgTWs3/gYWuxFWgYk4BpqhpUnl5/rLc8RKeHP
 eUS3L+5IA6x7heVMlCIxnpEYPi/KmainCKQO0g/+HRmCKJ9mg7aJVyCfD0j4ZRhUHtBwCAFMwMI
 TNIPUF
X-Received: by 2002:a05:6000:2dc6:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-4515cc31e43mr20239263f8f.34.1778240616632; 
 Fri, 08 May 2026 04:43:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-4515cc31e43mr20239205f8f.34.1778240616155; 
 Fri, 08 May 2026 04:43:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45492271510sm4846129f8f.37.2026.05.08.04.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 04:43:34 -0700 (PDT)
Message-ID: <013dad83-1775-47a9-b9c1-9375316fd0a5@redhat.com>
Date: Fri, 8 May 2026 13:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-5-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260422204335.23116-5-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/22/26 10:43 PM, Nathan Chen wrote:
> Allow accelerated SMMUv3 SSID size property to be derived from host
> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
> retrieving SSID size from IDR1. When the auto SSID size is resolved
> to a non-zero value, PASID capability is advertised to the vIOMMU
> and accelerated use cases such as Shared Virtual Addressing (SVA)
> are supported.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 18 ++++++++++++++++--
>  hw/arm/smmuv3.c       | 20 ++++++++++----------
>  2 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 98c2cdcb5e..d13d15a11d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -62,6 +62,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>                                 FIELD_EX32(info->idr[3], IDR3, RIL));
>      }
>  
> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
> +        /* Store for get_viommu_flags() to determine PASID support */
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -822,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static inline bool smmuv3_pasid_supported(SMMUv3State *s)
> +{
> +    return s->ssidsize > SSID_SIZE_MODE_0 ||
> +           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
> +            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
> +}
> +
>  static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>  {
>      /*
> @@ -834,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs = opaque;
>      SMMUv3State *s = ARM_SMMUV3(bs);
>  
> -    if (s->ssidsize > SSID_SIZE_MODE_0) {
> +    if (smmuv3_pasid_supported(s)) {
>          flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -974,7 +987,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>      smmuv3_accel_as_init(s);
>  
>      if (s->ats == ON_OFF_AUTO_AUTO ||
> -        s->ril == ON_OFF_AUTO_AUTO) {
> +        s->ril == ON_OFF_AUTO_AUTO ||
> +        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b7aa4122eb..07025245e2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
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
> @@ -1972,10 +1975,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
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
> @@ -1996,7 +1995,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              return false;
>          }
>          if (s->ssidsize > SSID_SIZE_MODE_0) {
> -            error_setg(errp, "ssidsize can only be set if accel=on");
> +            error_setg(errp, "ssidsize can only be greater than 0 "
> +                       "bits if accel=on");
>              return false;
>          }
>          return true;
> @@ -2177,11 +2177,11 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
>          "supported.");
>      object_class_property_set_description(klass, "ssidsize",
> -        "Number of bits used to represent SubstreamIDs (SSIDs). "
> +        "Set number of bits used to represent SubstreamIDs (SSIDs). "
> +        "Valid values are 0-20 and auto. Defaults to 0. "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
> -        "Valid range is 0-20, where 0 disables SubstreamID support. "
> -        "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support. ssidsize=auto is not supported.");
> +        "A value of 0 disables SubstreamID support. A value greater "
> +        "than 0 is required to enable PASID support.");
if 'auto', the host smmu value is used.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric

>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,


