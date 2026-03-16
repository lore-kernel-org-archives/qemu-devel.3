Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5EAF013C6
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22j7-0005D0-7M; Mon, 16 Mar 2026 03:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22j1-0005CT-BH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22iy-0005V2-R3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773647450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQ6D+52PhGl+9F963RTM1/1xRkegmqXg1YPd7A5BGqw=;
 b=QN6+7pMwR/nA20HVgTKEN4D0m+7AcNqox4PF8qjuFIkq5r/TKthawlqP2l9zKDMjKHwTZF
 AiYEkCyePl/SSv/XLWDH2+dwgNiASUjQP0J1MQ8bDj+zrqHuxQ3Q2Cv0NvIulGS4lgmaQh
 V7WCxXAVX/J/5rPkJ6U8e9Ty3E3K408=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-994tNCkSNEqcml4Kezh7Dw-1; Mon, 16 Mar 2026 03:50:49 -0400
X-MC-Unique: 994tNCkSNEqcml4Kezh7Dw-1
X-Mimecast-MFC-AGG-ID: 994tNCkSNEqcml4Kezh7Dw_1773647448
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b42cd4becso577619f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773647447; x=1774252247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQ6D+52PhGl+9F963RTM1/1xRkegmqXg1YPd7A5BGqw=;
 b=htdmhL6A41gK9v1JD3cqlfVqn1x1SUX8DRl5QfITBR4GVAkr7wqLUBBuM68Oa5FWrd
 Mpf+M5sUoBWZkCwiIkHb1v13kqrk3vMKhUAm67WKUbCCDVAXzIFeymYTSse4O7DEvBnL
 aPV0Xg+gmcy0rkmeeAsTnbwCpdURrWn8fS2jHKWqa/U5Lk7xmnD9hszALGls0iJJINbi
 TDGXcdz/toK1zgI/c1FVirZbvVdO4B4GwlSHTzpgqaVi5HrU0KGBV+TGOyhQe/4i8KFU
 Y3dCINXbXcUqmGx+ILmTEufLvjvNOuZDHvf0Gkzr6Mcmf5CqypRROw65hMj4XewgEoMG
 H0Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWREV8Je1LmZrSlt6hfDDzgJ4/03P5jSSudhXbbZpSq1Cy6raCcW00heO2SFWgbAU5C3CqM+YV+nCzD@nongnu.org
X-Gm-Message-State: AOJu0Yyi9yrS8fBzeBNozFjt88k1uC53ENLBZFG0cVZ+hPCiNHVI8Uj2
 fPrNX7deYJZuoJVAFttl811YHBw+JajR0kKBmtpw/R+/mmLuVDAwxjj5aj//8TIKrEzVTu11Ou9
 ZM25EGXAHSTIxt2jbpw2vC9Tvx87pqyxg7omw3XW9pMAVmwH3dl7V+tsY
X-Gm-Gg: ATEYQzzD3itgak3BWGCQmxP5a1v7c5wDBeOiPJ0pCKKleMu5cowESS6xTAgSViqe2Id
 Eqs4AKSicun5djiRznQrxrt5vnUQTTU9B2KxzMAjrZdyOPw5h5S8tlq4uEXl1wXvysNAgLJp6xo
 cxUhMaRcu4kUDAzXHnujODRwXjcSfLhJfWoHRBMhNqLRNb7jdeKnD9cMzA2zAbZDvRcYCTjUP24
 gH0DXwJL3V0xceDMl7aef0oqKJV4+NDQmPJh3jR8jfjH67NUIGXXD+A2RZPEVogDp5tPxYp2Ps7
 Ie/iGds+U6axz1mQjef6SEIy/RZkIZdtrN1ZAtIsfARiJ1M2LbYWdC5zTr/ezttDViwzpmIvDdP
 tO7QEwSZ3anGIPfjl7Yjq5NkMp5JAsDP+qfQi92JFAPGIf8v6t27XkpcQBcx6NFiIPVgaGw==
X-Received: by 2002:a05:6000:186c:b0:43b:47cd:8f71 with SMTP id
 ffacd0b85a97d-43b47cd9109mr399308f8f.25.1773647447473; 
 Mon, 16 Mar 2026 00:50:47 -0700 (PDT)
X-Received: by 2002:a05:6000:186c:b0:43b:47cd:8f71 with SMTP id
 ffacd0b85a97d-43b47cd9109mr399267f8f.25.1773647446976; 
 Mon, 16 Mar 2026 00:50:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b41ff92a6sm12391072f8f.11.2026.03.16.00.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:50:46 -0700 (PDT)
Message-ID: <b708f800-c2e4-4da7-907c-3602f0d1378a@redhat.com>
Date: Mon, 16 Mar 2026 08:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-6-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-6-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/12/26 10:03 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> Setting 'auto' will use the default value, i.e. 0 in IDR1. A future
> patch will implement resolution of 'auto' value to match the host SMMUv3
> SSIDSIZE value.

At the moment we need to reject auto setting as it is not supported

>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 17 +++++++++++++++--
>  hw/arm/smmuv3.c         | 16 ++++++----------
>  include/hw/arm/smmuv3.h |  3 ++-
>  3 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 6f44fd3469..ab037df7ac 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -803,7 +803,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs = opaque;
>      SMMUv3State *s = ARM_SMMUV3(bs);
>  
> -    if (s->ssidsize) {
> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
>          flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -818,6 +818,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>  };
>  
> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
> +{
> +    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
> +    /* SSID_SIZE_MODE_AUTO = 0 */
> +    if (mode == SSID_SIZE_MODE_AUTO) {
> +        return 0;
> +    }
> +    return mode - 1;  /* Enum values are offset by 1 from actual values */
> +}
> +
>  void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>      if (!s->accel) {
> @@ -847,7 +857,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>       * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
>       * has enabled it.
>       */
> -    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
> +    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               ssidsize_mode_to_value(s->ssidsize));
> +    }
>  }
>  
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index acbd9d3ffe..8b0121c0ed 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
>  #include "migration/blocker.h"
>  #include "migration/vmstate.h"
>  #include "hw/core/qdev-properties.h"
> @@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>      }
>  
>      /* Multiple context descriptors require SubstreamID support */
> -    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
> +    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
>                  "Configure ssidsize > 0 (requires accel=on)\n");
> @@ -1984,7 +1985,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> -        if (s->ssidsize) {
> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>              error_setg(errp, "ssidsize can only be set if accel=on");
>              return false;
>          }
> @@ -2002,11 +2003,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
> -                   SMMU_SSID_MAX_BITS);
> -        return false;
> -    }
>  
>      return true;
>  }
> @@ -2135,7 +2131,8 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> +                              SSID_SIZE_MODE_0),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2173,8 +2170,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "Valid range is 0-20, where 0 disables SubstreamID support. "
> -        "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support.");
> +        "A value greater than 0 is required to enable PASID support.");
Why removing "Defaults to 0"?
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index c35e599bbc..ddf472493d 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -21,6 +21,7 @@
>  
>  #include "hw/arm/smmu-common.h"
>  #include "qom/object.h"
> +#include "qapi/qapi-types-misc-arm.h"
>  
>  #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
>  
> @@ -72,7 +73,7 @@ struct SMMUv3State {
>      OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
> -    uint8_t ssidsize;
> +    SsidSizeMode ssidsize;
>  };
>  
>  typedef enum {
Thanks

Eric


