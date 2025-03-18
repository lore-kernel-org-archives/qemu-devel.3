Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389CCC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufAt-0000A9-GW; Tue, 18 Mar 2025 18:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tufAo-000057-RV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tufAm-0002SZ-JU
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742335950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEhrFKgP48Gy7fx3ihbzsQSbAPz2a8Wl63jdqBT7ISE=;
 b=EoelEsXNjSuEfvZ449GzDgtwGKztIVeND/mV862n6ElNC2XWFs/Q1xTfTZ7/CmZgmlQdF1
 IOCTq3/eaXMK0vn6VOgaRZUBTvjZ7tU+RLtalbCwN51q9fYW6oVUB4C4SKhnwMgHqjW3CC
 b+ZuPvNOIO4hh+72D4x+oydh71rfKHY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-td0Ki9bnNjCKTKgjtUhnLw-1; Tue, 18 Mar 2025 18:12:28 -0400
X-MC-Unique: td0Ki9bnNjCKTKgjtUhnLw-1
X-Mimecast-MFC-AGG-ID: td0Ki9bnNjCKTKgjtUhnLw_1742335948
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d44dc8a9b4so67444775ab.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742335948; x=1742940748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEhrFKgP48Gy7fx3ihbzsQSbAPz2a8Wl63jdqBT7ISE=;
 b=ug1IljnKh8JaPEdpy7kzIT43ep2fMEx2Ff3NFMsjm08RD0SPHRZsyaOeZ+8dvLOPYx
 PxyMt48M6gAWfUvcLBCBdQVOzeVt2lhqr7lgCMJ94GKqsCbGwSnEPXXFrGrLeqk8+mKo
 y6SXce4+qlFFFhAm6+e5auMQDOC4hkA2rvyGI5yTF00Dt3GXUmSpl5Gp1AQQqP27m81p
 HxK9btaoX/C5kLLFCaom4+GLGC4UO7U5js0R4n5219yh4hFvzaX2lxvmCi9MhEmmOXpM
 rIe13aQaXDPIp7O5+v9ISpSFn7o6YWNrfQDxb+Qwcs6//MhxDI4b4GSNpUnKZAdVygop
 xNDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfZT7ABWhwfVpe5oaQvyjYGLior2A0s6unWp8AyPlJnnHbKAlUM9AL9w4XiKIjZs/4lSf/rpSHcsS9@nongnu.org
X-Gm-Message-State: AOJu0Yzo/fpbiqWeCSPwd4ca5QyE7pjFrofopH9jBg1FRWtGkn/XLyBH
 0cwcZ7sPxlZFTZZGlji2MoX1rvL691O2Hzbg7yaeHMRzEVWTbqAMOHkQR24xN+rKbb9kvojnpGe
 bywKfDk0CX3EgIeyBrNCFEE8873GNpFgfdIb+GeD25z8Fx0XbjzAq
X-Gm-Gg: ASbGncv2h+1QjlFaRCWciFgwIR4hwEQXbl6+ypP1cJ60zz2lUNcS3IxNJ1vTwHYaOYn
 le8b1uD20ttDchQZuDk5XbwPaIIa3y2Rw9uxrkdpex1phF/h2JKHanmGAlg3tojEAGQsHMOwnRy
 CcSxjnmrKoptGEF0I5YSiRWKbdDj4TUlcgIDYpakS24czqwAJ8AJ8EEOm+I2Pwj1Pp17enKC6No
 52JYQlv6WcsnQ1Qa11Sri0fhI+D7oNQRCMj8c3psNDlkQFIwUmyPDoc3mGTuUtJjf0HpArdheI8
 CpbHxCuzsP9v9CGW
X-Received: by 2002:a05:6e02:1707:b0:3d4:6dd2:3989 with SMTP id
 e9e14a558f8ab-3d586bf08d9mr5041715ab.20.1742335948188; 
 Tue, 18 Mar 2025 15:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5GnTwif262ir3qT8G/KIxogaymACwUvx1dZohNklQhH0OU+KT12y1GLyn7j1HmQssViLjmg==
X-Received: by 2002:a05:6e02:1707:b0:3d4:6dd2:3989 with SMTP id
 e9e14a558f8ab-3d586bf08d9mr5041455ab.20.1742335947833; 
 Tue, 18 Mar 2025 15:12:27 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263701cebsm2920594173.27.2025.03.18.15.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:12:27 -0700 (PDT)
Message-ID: <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
Date: Tue, 18 Mar 2025 18:12:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Shameer,

Hi!

On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> User must associate a pxb-pcie root bus to smmuv3-accel
> and that is set as the primary-bus for the smmu dev.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c327661636..1471b65374 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -9,6 +9,21 @@
>   #include "qemu/osdep.h"
>   
>   #include "hw/arm/smmuv3-accel.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
> +{
> +    DeviceState *d = opaque;
> +
> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
> +            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
> +                                     &error_abort);
> +        }
> +    }
> +    return 0;
> +}
>   
>   static void smmu_accel_realize(DeviceState *d, Error **errp)
>   {
> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       Error *local_err = NULL;
>   
> +    object_child_foreach_recursive(object_get_root(),
> +                                   smmuv3_accel_pxb_pcie_bus, d);
> +
>       object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
>       c->parent_realize(d, &local_err);
>       if (local_err) {
> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
>       device_class_set_parent_realize(dc, smmu_accel_realize,
>                                       &c->parent_realize);
>       dc->hotpluggable = false;
> +    dc->bus_type = TYPE_PCIE_BUS;
>   }
>   
>   static const TypeInfo smmuv3_accel_type_info = {

I am not seeing the need for a pxb-pcie bus(switch) introduced for each 'accel'.
Isn't the IORT able to define different SMMUs for different RIDs?   if so, itsn't that sufficient
to associate (define) an SMMU<->RID association without introducing a pxb-pcie?
and again, I'm not sure how that improves/enables the device<->SMMU associativity?

Feel free to enlighten me where I may have mis-read/interpreted the IORT & SMMUv3 specs.

Thanks,
- Don


