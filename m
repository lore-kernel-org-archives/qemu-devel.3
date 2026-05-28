Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D6ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWKB-0005vO-00; Thu, 28 May 2026 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWK9-0005ta-3Z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWK7-00070y-1G
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779957758;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HV8/bNOx0u+eqWzR4k6B1Lnh7yn9bwlRGpeAYgvObmg=;
 b=RyX3UJX/HWFxw5epC78X0bckwpvWvba8Xn7Z+Vws2V6v4X2He93c3VkA+GiaUhfLgY9XMJ
 oWX13yZn3V5mxFYhLk0lESsR6MRxAIBg+pphYLaG643Tb+Epb1WPU8ulj3iWqjjyZxwSok
 MXEDc1uAyIWlCIbDIJ4uk1Ad01OK/uo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-aSFOxK-pPdOrbwFhWuIsDw-1; Thu, 28 May 2026 04:42:36 -0400
X-MC-Unique: aSFOxK-pPdOrbwFhWuIsDw-1
X-Mimecast-MFC-AGG-ID: aSFOxK-pPdOrbwFhWuIsDw_1779957755
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso10064659f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779957755; x=1780562555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV8/bNOx0u+eqWzR4k6B1Lnh7yn9bwlRGpeAYgvObmg=;
 b=YuE5Yt+ikbC33/54V86iZZMR0mvJKlvCPQL9NCcmnG47TrpSrWEetzG1iZc6kY9Rc2
 8iEiZDPeGQfvp7rNU2VVmbVfWFqNxAyTcRW9uqAbbl9fip9dlF45IvROQ2F4ePp1PnDV
 BPdzvnbER7T33eBjb3q02mxGtgbgkDHiBuTgXg3PdiqvRtSrTdyikZQ2FNg3c3UbyUnS
 kzzmhRQPMTzF59TTfb9mPMN/xlTuD4tUZ1nlbh607gaqZa/De16GCOUqblSJ/ou6QyNd
 zUzJKOrfWxdIy13hW3f+HzEaHvTztNgm0vsdEfRIqDkMu3PJi7jvsvMIoueW2Npxlo3n
 WejA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6Cr4AXoi+XVZaRIHOklbyWjlu1EnMWRzy0CHbLdmjy/4jWKkRqiKsDKuvEoRwlJrt4fsQngwfIqFx@nongnu.org
X-Gm-Message-State: AOJu0YxNARhnwlSmaJlRJOgGc6JP5ouyP9EKve5ToXe40tszDcBJj/la
 dg264LzJEM46nb04Rt6Kza6d8yLV+Y5hkk4E7Zbgx/pJXXZGnBD8ZxjrI7abpMrILZmybBy588f
 OoSLY+AEXojaztjMIMxOdGqEatAhdYaOKXYY09TUmqWlbs/gSQ5FtDpOo
X-Gm-Gg: Acq92OFwMib7wS9URyJNSHTwP0N6SzwrE1bQNHzvcSnK0t6QofcgRPkWphAxpvWNyXW
 O9Gd1gqFoCYjVJaPLGA0B8INJsAU6l25YRdlJuRKMU/zFlK6OjXA9Nd49jd2gCwR5XMVWYt6ThP
 akx70495pr3MgqTLy1LF7/H09lIR5XtX7YJ1bB1AHNJ4Uowhhyu07QnSHJ1rbQxQzk2UH8UoJLo
 wuGWvMt/Z7D5ZhlUsB9PZhtt6pRtdymu4PddfWOwhc1beYb4P2b56WcDab/edhQJB50cvEY9LcP
 QVNex33T6ZKY6IhRZXHNTa6IH7YznNgNBLNpWw5nRC/KIv30I25+E6ifA+TX6NX0SGZR0nXVrq8
 17mRDgmNrF+su40/qRop5VpJ2q/IaSoCWpLGwYwykp7EVEF0kULuQltfu75g2iMCnSaPLLMw94j
 iWl1M8
X-Received: by 2002:a05:600c:1f87:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-490424ad9abmr425606075e9.12.1779957755336; 
 Thu, 28 May 2026 01:42:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1f87:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-490424ad9abmr425605735e9.12.1779957754984; 
 Thu, 28 May 2026 01:42:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm25597885e9.11.2026.05.28.01.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 01:42:34 -0700 (PDT)
Message-ID: <37caa2b8-b9bf-4006-8fa4-b417e8881fbd@redhat.com>
Date: Thu, 28 May 2026 10:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-9-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260527221631.612026-9-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/28/26 12:16 AM, Nathan Chen wrote:
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
> ---
>  hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>  hw/core/machine.c |  5 +++++
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 97ac893d86..4e630b6403 100644
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
>          "device assignment before enabling.");
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
also I think the set value sould be <= host range, to make it consistent
with the rest, no?

Eric
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


