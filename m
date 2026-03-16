Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BAAF013C6
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22nj-0006pl-9B; Mon, 16 Mar 2026 03:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22ng-0006oS-2f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22ne-0006Jd-FW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773647741;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PeeLSUTnAoO6YAoVbJz/XwOBZH+v7FeEB0QnOJ5V9Sw=;
 b=Lj7sB1jcSckR+KqhzMIisvreRcb/zPSI4Yw/pk1VPo698ly6D45TsMgnTdvGaE7iSytbR4
 daPyuimhDpGu8AH2hCVInQirA/xsihizX2JvNZoV7wCHPd6c1F16eMNuBbfEr6xNe1tCRp
 hBalToHRWgbS/CvCWE4iHsEAPULe8uU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-9QzRAhX7NJOCwF_1jYN2cg-1; Mon, 16 Mar 2026 03:55:39 -0400
X-MC-Unique: 9QzRAhX7NJOCwF_1jYN2cg-1
X-Mimecast-MFC-AGG-ID: 9QzRAhX7NJOCwF_1jYN2cg_1773647739
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so31467545e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773647738; x=1774252538;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeeLSUTnAoO6YAoVbJz/XwOBZH+v7FeEB0QnOJ5V9Sw=;
 b=Jx1cuy7xwAcaeeWF2oStLAOJwtbe/FSBWwZEbtMMHMbi5cnnSysTlZ1W5rkG3ZHzhG
 cObwOT/YzVRAJ0Fs+vYzwtZZGcdssX9pAVbJdmgTu0tMkLRhsp7FKDZMVbklgIRNyy1T
 XkU8secpMvs7S/OywbZg4+1/9e5Rjs5wgTdd4hASx5UvYZRhSGpmAwyF/adc5kLGKuir
 0RGJfr/fHQc2ZvxtbPvrfMZPoJdi4lzbJedznsnJULkyS6y0lwjFEjC5te108qzCWJbp
 F6waqnjQTTFvfiMlSc8VusduhL3pYuckMB8lJPjja0W/6qm8LuZ4+YRZdht+75W5P+0Q
 98ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4q6EEoTDk8eH6XAJw1b/nJ5k/jMriaSfnjeloU9CcJlWFxno4tlKMAjb8vYBjQAc7Pk1YcHEJ6c5@nongnu.org
X-Gm-Message-State: AOJu0YyCkJHcqLPmGT23zypxfM2OJ/dJ3hv0/3I7O+njm6yb4x2FiCVA
 Y0WohXQ1W2cZHrlLdPgj8oq/NtrpgbUxfJkAuPJ5gnlakbeoAj0DH/HvU14EzuDdW1usv+xl3ej
 FN+pyworzYB8mLDqpOoYBYNycVK4dI+XjvQLAV2u0kwiY1/wHMNG3x5tW
X-Gm-Gg: ATEYQzxGmfjJcdi9Lkxd2bEn6UUqHWt9wpdQ0LkP4n6GExYfA4LprX4f/6mWa5uTdjF
 IN6nyu2vNtqWPbdOFsy5FGJMEEC8DiANJ0eBdDh0IzmjceFnudNWkHfNeeEzU1IF0IeOqI0wBhc
 t/UnsfWXNTpQIsT1BbHtlHCIYE4i8BukD7VUp9V1ttC0vh9IskRdRu4ZW5KNLIBSAJS7DdMJ86y
 7PhKyjwVUjX7lMq808OyOPs+Ib3F7Ni08i8/HFVXwfF4PNEJ4ZIgxCHerNT5ahrwhd41Fm4Xy9q
 5GvIzLUHL1+kfOWGYEJk5/DbZ/1xz1qhqYmkBVp+TtNGL9s7GwgryrnW/ma9dzX5YpmGFiIKfOa
 5zBZIIMHxt+/mdQAQSgbeqJlP8UU7fK4ywxzct9b3bTVr22Efc0fmgUF89NaqGoKDKnO2Vw==
X-Received: by 2002:a05:600c:1d0f:b0:485:309c:2984 with SMTP id
 5b1f17b1804b1-485566d2dfbmr198824315e9.13.1773647738528; 
 Mon, 16 Mar 2026 00:55:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0f:b0:485:309c:2984 with SMTP id
 5b1f17b1804b1-485566d2dfbmr198823975e9.13.1773647738009; 
 Mon, 16 Mar 2026 00:55:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66e3f8sm403329515e9.14.2026.03.16.00.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:55:37 -0700 (PDT)
Message-ID: <2a807700-f887-4abb-b6cf-fa122e65b98d@redhat.com>
Date: Mon, 16 Mar 2026 08:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
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
 <20260312210328.2016191-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-8-nathanc@nvidia.com>
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
> Change accel SMMUv3 OAS property from uint8_t to OasMode. Setting
> 'auto' will use the default value of 44 set in smmuv3_init_id_regs().
> A future patch will implement resolution of 'auto' value to match
> the host SMMUv3 OAS value.
Same I think we don't want auto mode to be selectable at the moment.
Because then you will change the semantic of the auto mode, returning
the host value and not 44 anymore.

Eric
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 2 +-
>  hw/arm/smmuv3.c         | 9 +++++----
>  include/hw/arm/smmuv3.h | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index ab037df7ac..5073f74b8b 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -849,7 +849,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      }
>  
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
> -    if (s->oas == SMMU_OAS_48BIT) {
> +    if (s->oas == OAS_MODE_48) {
>          s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>      }
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 8b0121c0ed..9faa9c8dfb 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1981,7 +1981,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> -        if (s->oas != SMMU_OAS_44BIT) {
> +        if (s->oas > OAS_MODE_44) {
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> @@ -1999,8 +1999,9 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> -    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
> -        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +    if (s->oas != OAS_MODE_AUTO && s->oas != OAS_MODE_44 &&
> +        s->oas != OAS_MODE_48) {
> +        error_setg(errp, "OAS can only be set to auto, 44 bits, or 48 bits");
>          return false;
>      }
>  
> @@ -2130,7 +2131,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_0),
>  };
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ddf472493d..82f18eb090 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -72,7 +72,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      OnOffAuto ril;
>      OnOffAuto ats;
> -    uint8_t oas;
> +    OasMode oas;
>      SsidSizeMode ssidsize;
>  };
>  


