Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F268CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWBR-0001Ih-6x; Mon, 08 Jun 2026 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWWBN-0001He-SL
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWWBM-0005og-4G
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780910526;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PCRIJ/nkoZvJQPHHr6M0TIXThbK7yCd5/htQLuMB6k=;
 b=ImoVGsXibtd/2nfl84F3RkYj9av7v6Uec3FOUzzo6s9PkktaLvNeif3ypLgZOf/pUyGS4x
 gL9zrdgd7q+5ZYqLfDs1vO758MYvHFleJ3ektttwgDHGEmBgzbS+x2o5l1hcXqlqkAcxiK
 nZMpPSOoLmZMpWTTAGycrO2AS5tB8nk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-1ULwQ7IbNRaSQG1iXXRLOQ-1; Mon, 08 Jun 2026 05:22:04 -0400
X-MC-Unique: 1ULwQ7IbNRaSQG1iXXRLOQ-1
X-Mimecast-MFC-AGG-ID: 1ULwQ7IbNRaSQG1iXXRLOQ_1780910524
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f654so3063621a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910524; x=1781515324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PCRIJ/nkoZvJQPHHr6M0TIXThbK7yCd5/htQLuMB6k=;
 b=aesZ0l9LxbC6FiLhtJwuvkYACg27QiU6MzLkrfjs5QPvKpW9D0rrX+Vpz6yXStnkdq
 ZuL5QuqUSYRcXZVFsmXaNBEsiK5htlT24M7tdTrJ5tm6oogDBuyKkDXdHHxLAnQjZeve
 LL5OXLutzkjJSlT0ylO1jTgyEyMyKgzJWvQ2mDTHZVdNiQ3qsMy2XCecG9MJNTv7aX24
 khepqeBF+glsvaGgnHJc/quXfkYlU+D+PjRg3sS/Iy5hC+NBVk3GD7nKNkniMYLlTkGZ
 QU8MJwgCnQVRv2UgG0MczLG1quEC2PTI3UXsEUvNdaAfd6GrUzqeK2xpSVRPwYn3dhU/
 Ppgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lDMkts4nRZTLR9jD1ZxD1zomdM8VW1IjeRVcAP5JNH7Rbzr3wbr2NzxTN7WtOahUcEAkMkZ2UbrGO@nongnu.org
X-Gm-Message-State: AOJu0YzyYdLDceiFym6Kmv7eORN2vMRF/Nq1xg5xH5sYb8fADUNLaRds
 mLBqQAUHToR6IerAvE9CsTg2k6mOpXI3AwtVVK6q4QEV2BsPqOACOZ4JxQ+hXO2jgm12ZR+dcz4
 DOinv4SjBlxr1/0PtLYrEmggGTEgpCS3gOcL4ocP8ToYJai5kGU9o9ckQ
X-Gm-Gg: Acq92OFh/nQt114xB59LamyrUGGhZ64qXBH2dz1pPzlbRKPOJB+qkv/6GUALrd4b6a8
 thyXPZ0XQY+LQ80Rb7JksMTIqbuWc/AdNrYPu2/q2w2weM4ftsXa03T9Rqv9fL6OF7ey+VTh1/x
 KEPy8hwrlF+H4n7JizXVa2lVc7paCcWwtyt2kx1mCquw/2yBpMEgVrXLyhchWNNhJKckUWG042M
 gFXz2XfYZMzav0A7lzPtnJxFZisE36TVGv4Ch2vst4XFq8Q3Mv621mkOrTuYaXHwhaQ4EBJx7DR
 4AvhRgi6zDdCy2CR0IX6o/ybQHcXla79i5JMKfKPcafVlS+NZtcw6E+6cY95SJCZKd3o3aZCge8
 MhdYxS8DbPvoC8P2QILJXEoQt+r3Etd4yGZbPO/JhY9nOB9VG5aVrsLPURR1s9mS90idraBa4EC
 N1AYt3
X-Received: by 2002:a05:6402:3807:b0:66f:2ea5:c269 with SMTP id
 4fb4d7f45d1cf-68fa503900cmr6856022a12.15.1780910523578; 
 Mon, 08 Jun 2026 02:22:03 -0700 (PDT)
X-Received: by 2002:a05:6402:3807:b0:66f:2ea5:c269 with SMTP id
 4fb4d7f45d1cf-68fa503900cmr6855998a12.15.1780910522925; 
 Mon, 08 Jun 2026 02:22:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6915a637180sm2871162a12.26.2026.06.08.02.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:22:02 -0700 (PDT)
Message-ID: <01c228d2-96ca-4b71-9546-4944ed6e8910@redhat.com>
Date: Mon, 8 Jun 2026 11:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
 <20260605001712.1823737-9-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260605001712.1823737-9-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/5/26 2:17 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
> to match the host IOMMU properties when accel=on.
>
> If accel=off and these property values are set to auto, the default
> property values defined in smmuv3_init_id_regs() for OAS and RIL will
> remain unchanged, while SSIDSIZE and ATS values will remain initialized
> at 0.
>
> Introduce a new compat for the changed defaults.
>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>  hw/core/machine.c |  5 +++++
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 89289ab6d2..83fa6468fd 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
> +    /*
> +     * AUTO values for accel=off will resolve to:
> +     * ril: on
> +     * ats: off
> +     * oas: 44
> +     * ssidsize: 0
> +     */
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> -                              SSID_SIZE_MODE_0),
> +                              SSID_SIZE_MODE_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2164,22 +2171,22 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "enabling.");
>      object_class_property_set_description(klass, "ril",
>          "Enable/disable range invalidation support (for accel=on). "
> -        "Valid values are on, off, and auto. Defaults to on. "
> +        "Valid values are on, off, and auto. Defaults to auto. "
>          "Any attempt to turn it 'on' while the host does not support "
>          "it would fail.");
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). "
> -        "Valid values are on, off, and auto. Defaults to off. "
> +        "Valid values are on, off, and auto. Defaults to auto. "
>          "Please ensure host platform supports ATS before setting it "
>          "to on.");
>      object_class_property_set_description(klass, "oas",
>          "Set Output Address Size in bits (for accel=on). "
> -        "Valid values are 44, 48, and auto. Defaults to 44 bits."
> +        "Valid values are 44, 48, and auto. Defaults to auto."
>          "Please ensure the value does not exceed the maximum "
>          "Output Address Size supported by the host platform.");
>      object_class_property_set_description(klass, "ssidsize",
>          "Set number of bits used to represent SubstreamIDs (SSIDs). "
> -        "Valid values are 0-20 and auto. Defaults to 0. "
> +        "Valid values are 0-20 and auto. Defaults to auto. "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "A value of 0 disables SubstreamID support. A value greater "
>          "than 0 is required to enable PASID support."
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63baff859f..3339da99ee 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,9 +38,14 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
> +#include "hw/arm/smmuv3.h"
>  
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
> +    { TYPE_ARM_SMMUV3, "ats", "off" },
> +    { TYPE_ARM_SMMUV3, "ril", "on" },
> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
> +    { TYPE_ARM_SMMUV3, "oas", "44" },
>  };
>  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>  


