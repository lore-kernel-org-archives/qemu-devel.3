Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9521DF013C4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22XE-0001cE-IB; Mon, 16 Mar 2026 03:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22XD-0001bi-0g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22XA-00038W-If
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773646719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShzI3cCB9Q9Hx/QBVoUzeWtJLlufzDo93XBXZ1v0NHI=;
 b=Afb2CY+TQL0TJQ08TQbGEk4bidx2uAPnQg/GUhNV/DkALdpkXvgNWFGRyLWFmFzVL577aB
 lVWG27anvkgIbTl1emgsBtmU84TEs66QRG1RJqB07qe3wNC7ZdSz1NlkUxNYsEKgYpxUG4
 mbtVsOGHKI05NcfIDASJSeV66mag5jE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-AtXp_Zd9MQOGmVoHSyut4Q-1; Mon, 16 Mar 2026 03:38:38 -0400
X-MC-Unique: AtXp_Zd9MQOGmVoHSyut4Q-1
X-Mimecast-MFC-AGG-ID: AtXp_Zd9MQOGmVoHSyut4Q_1773646717
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b42eee946so499744f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773646717; x=1774251517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShzI3cCB9Q9Hx/QBVoUzeWtJLlufzDo93XBXZ1v0NHI=;
 b=Z9zKquU0+ka1oj9ZFHAbpduq1WVADHiysOSokev3Cb2YGIscYHucRKX0IZk2baoI7p
 KC0ZBFJ95/dtN9WdWJK92HOP3zwTCncdZ7UbYTFEN6FHW6+PfzTvBiU/iR7RjTydNDbT
 cjjydIRVTGy7y7sxOzPLjVNzreZZtYgXb1MlW+KDENfL7OWVb0zrPfahrsLbAAauHqqd
 3WdulTX7WT92yhMvM8War/Mx6lZskyG5RGqKmbbmdDehgioxdUqEN4Lix7Zd3yis1iR1
 BJMUnC/K2GbGkQZl6MnlOKoWBGaaqasfZnCzUrNGVJzLHJP1kVWnXAIl4wXGu8FuNDJg
 zWLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFGQlVLwMUJREB5oyUwmm4HXVdUdubRvndIRPxgD0wQekfjSO6FivCbQBD2al6B7Q2qCO3rEQPza/Z@nongnu.org
X-Gm-Message-State: AOJu0Yy0q8RDnBErL6MK4QpvwtF58+4DJG03smIeYlX26w1Zr3kUi/c6
 zKMAmQRo9/YaLLeuXyT5UJoRenkec6/XjLzEf3KHkGyInUSrkodQU/irQ9R35v3exBHUjfzcVng
 ovXrw6a8EoOanUiO3yAH2K5lyWMK6t9GilAnBptjUcskgt/bN+mUZNh6erKmYz/WV
X-Gm-Gg: ATEYQzx2oNGnBhiTyfCyc+dxpl6hwGu45VIn4FKYmoqrWH/geavvwo48q4tZNrrfCM7
 QvgpSRCfsKoimHI2GNd9Rr8frOCGlVk/3uMU6Du3i0UXjHYRyguMx7fuIop+lU3CYVKu8B1DMMk
 by5SobzxXKte9wnvtuM7QfoiV86p0eqNtPMs2QuLsUni1dsLEoO9q+G5rPkWiHyuu5l+J4LqmCS
 XB4sBc0cMqfatLC3aSyIy+lCcn9G/D90HlAgUBPbBvUzV9lgvgplfM7GLheFcg5HF4ejSmE7uZQ
 +/In45yMSgSvkRU08N1po3XuqTpBCmTboidwQe+wbsjjuZAOFEXUCg0J6dBWbxKW7UeNzUxgWP3
 Jrtl+j0xDl3cjunq4oPKY5E06WTs96ODiw0ZMx5F2df/A9YbpQ21gumjyS9h8AqyZKPhhFA==
X-Received: by 2002:a05:6000:1a8e:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-439fe1addc8mr27618891f8f.26.1773646716796; 
 Mon, 16 Mar 2026 00:38:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8e:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-439fe1addc8mr27618832f8f.26.1773646716332; 
 Mon, 16 Mar 2026 00:38:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b419270efsm9524780f8f.16.2026.03.16.00.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:38:35 -0700 (PDT)
Message-ID: <8b7b4803-81fe-4c30-a36f-7141df641964@redhat.com>
Date: Mon, 16 Mar 2026 08:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
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
 <20260312210328.2016191-3-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-3-nathanc@nvidia.com>
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

Hi Nathan,

On 3/12/26 10:03 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Change accel SMMUv3 ATS property from bool to OnOffAuto. Setting 'auto'
> will result in the default value being used, i.e. 0 in IDR0 which
> translates to 'off'. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 ATS support.

 i.e. 0 in IDR0 which translates to 'off': this is unclear to me what you want to say.

I would clearly state here that at the moment the auto value is not implemented. This is just to get the property right and do not break JSON/QMP when getting the auto mode introduced. Also I think you want to enforce that in the code, ie. the end user is not trying to set to AUTO.

Thanks

Eric

>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 8 ++++++--
>  hw/arm/smmuv3.c          | 9 +++++++--
>  hw/arm/virt-acpi-build.c | 2 +-
>  include/hw/arm/smmuv3.h  | 4 +++-
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index fe78ce69a5..5d14abe307 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -827,8 +827,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>  
> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
> +    /* Only override ATS if user explicitly set ON or OFF */
> +    if (s->ats == ON_OFF_AUTO_ON) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
> +    }
>  
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>      if (s->oas == SMMU_OAS_48BIT) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 068108e49b..862ca945d5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>      smmuv3_accel_idr_override(s);
>  }
>  
> +bool smmuv3_ats_enabled(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
> +}
> +
>  static void smmuv3_reset(SMMUv3State *s)
>  {
>      s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
> @@ -1971,7 +1976,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ril can only be disabled if accel=on");
>              return false;
>          }
> -        if (s->ats) {
> +        if (s->ats == ON_OFF_AUTO_ON) {
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> @@ -2128,7 +2133,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>  };
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 719d2f994e..591cfc993c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>  
>      bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>      sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> -    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
> +    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
>      pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>      sbdev = SYS_BUS_DEVICE(obj);
>      sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 26b2fc42fd..ce51a5b9b4 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -70,7 +70,7 @@ struct SMMUv3State {
>      uint64_t msi_gpa;
>      Error *migration_blocker;
>      bool ril;
> -    bool ats;
> +    OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;
>  };
> @@ -91,6 +91,8 @@ struct SMMUv3Class {
>      ResettablePhases parent_phases;
>  };
>  
> +bool smmuv3_ats_enabled(struct SMMUv3State *s);
> +
>  #define TYPE_ARM_SMMUV3   "arm-smmuv3"
>  OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
>  


