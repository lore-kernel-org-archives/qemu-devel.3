Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 12:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwLkQ-0002Qh-Hb; Mon, 15 Apr 2024 08:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwLkK-0002Q9-5q
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwLkE-0002Ct-8W
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713185252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzsPjwJyeBjZM/FtbGa5+lsek7Ow9bow3tFCBz6qNSw=;
 b=V4WvNeIj16aHbd+DOBaQpjn6pjVq7z4Y51QVLhMqBde8reoEx46VKxHGXpMpJMitrtjZZe
 4yU36P3ijbFWQFT5Hf0A5tPBKhQk+GSX5MQPpi+A3zR+M1g1AIT/fY8Rh3gKJ61uMXhhja
 tC1xRONFhmJchc9imiEYyUCD6MTkv6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-sy-3sa5JOuW-14gSLPnE1w-1; Mon, 15 Apr 2024 08:47:31 -0400
X-MC-Unique: sy-3sa5JOuW-14gSLPnE1w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4147de378b9so15053405e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 05:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185250; x=1713790050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzsPjwJyeBjZM/FtbGa5+lsek7Ow9bow3tFCBz6qNSw=;
 b=US8GYebdJ0fdDp1L141wARuOnn+Iftw9OOr3Orwznyv61TKByH+thEacpkD/5kOHdz
 DIrgmHvaYofcyNOD7F53wUp8eWQEB37+42K/MKYLVrZznjKPTdw7HIIcOcvw2UfGCAjd
 JaL+LSjWmMWh3r9o4P3hKQDTGVFL7JrX8Qk7I6p+AT1nKLZsBtu0rCxqC+u64tLvGlu6
 6UV5mJ2sg940pnF28yVg9wtdjHs5ayCHBY5maeT/DQjJ/aHgGF3m6u5v4GOfMtnGC9t5
 tHyojgX5FfEHnQpKw2vxPfnoAw3mBLvHM57KLhJRhjevS6HjuM6JE4t+efgG5r4mwfiE
 vOfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN0Z2LuK1F/7wAw1k30n68HSsjzz5pClndVDYrAUiRs18o8lQpwXi7IIDQPY+gHCUE6NGpusEYuJKHPGhtR7rcCeC3R/4=
X-Gm-Message-State: AOJu0YxYCFGfVPLpXFxQTAIcKlrT7v+GY1FFnB05lzUN/v7jKsGbli/B
 PQ2Ud2w79NCZ/HUSZUeAW186RSdBLy32j8y7sH3TSxezCkGJfhEqabTryhkD9OzNwwaiIe6LylW
 +xqRajgBOjNAe3+ID1E3mEq1BgbfJ+n+KhkuKzFreoSssmZbcJpn4
X-Received: by 2002:a05:600c:1549:b0:416:af4d:e3dc with SMTP id
 f9-20020a05600c154900b00416af4de3dcmr9679506wmg.12.1713185250109; 
 Mon, 15 Apr 2024 05:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOm1LJ+Zxpmzn1w2v4VTp6zR6xI52E0B+9dJpyObPnM7v/Q+2r+OU7pdeCvw1r03WHV05s7A==
X-Received: by 2002:a05:600c:1549:b0:416:af4d:e3dc with SMTP id
 f9-20020a05600c154900b00416af4de3dcmr9679492wmg.12.1713185249703; 
 Mon, 15 Apr 2024 05:47:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a05600c34c400b004186cb8298fsm2574857wmq.16.2024.04.15.05.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 05:47:29 -0700 (PDT)
Message-ID: <9869ac57-56c6-41b7-a2c6-d42a5ba475ee@redhat.com>
Date: Mon, 15 Apr 2024 14:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> HIODLegacyVFIO represents a host IOMMU device under VFIO legacy
> container backend.
> 
> It includes a link to VFIODevice.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 11 +++++++++++
>   hw/vfio/container.c           | 11 ++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..f30772f534 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>   #endif
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/host_iommu_device.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -147,6 +148,16 @@ typedef struct VFIOGroup {
>       bool ram_block_discard_allowed;
>   } VFIOGroup;
>   
> +#define TYPE_HIOD_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"

I would prefer to keep the prefix TYPE_HOST_IOMMU_DEVICE.

> +OBJECT_DECLARE_SIMPLE_TYPE(HIODLegacyVFIO, HIOD_LEGACY_VFIO)
> +
> +/* Abstraction of VFIO legacy host IOMMU device */
> +struct HIODLegacyVFIO {

same here

> +    /*< private >*/
> +    HostIOMMUDevice parent;
> +    VFIODevice *vdev;

It seems to me that the back pointer should be on the container instead.
Looks more correct conceptually.


> +};
> +
>   typedef struct VFIODMABuf {
>       QemuDmaBuf buf;
>       uint32_t pos_x, pos_y, pos_updates;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276e..44018ef085 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1143,12 +1143,21 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>       vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>   };
>   
> +static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
> +{
> +};

Is it preferable to introduce routines when they are actually useful.
Please drop the .class_init definition.

Thanks,

C.


> +
>   static const TypeInfo types[] = {
>       {
>           .name = TYPE_VFIO_IOMMU_LEGACY,
>           .parent = TYPE_VFIO_IOMMU,
>           .class_init = vfio_iommu_legacy_class_init,
> -    },
> +    }, {
> +        .name = TYPE_HIOD_LEGACY_VFIO,
> +        .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HIODLegacyVFIO),
> +        .class_init = hiod_legacy_vfio_class_init,
> +    }
>   };
>   
>   DEFINE_TYPES(types)


