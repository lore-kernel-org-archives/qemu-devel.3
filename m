Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F1EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwM3i-0002xM-Vx; Mon, 15 Apr 2024 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwM3h-0002wy-FI
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwM3c-00079y-SO
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713186456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXhEXKQxXJEyufwop7Log9Kkvd4UZN51cf2kP3CzMqI=;
 b=HZXgxmAQoB53HNR3qtVEtb5NPolVQOK+3GwPD6fn9VZaSV2hhjUUt50uF3lT3BApXmKfFU
 OKo3dqnKk2XlUkUmmeqjXxzm+wr7bn/mBfeaE5XgaN07y0dZYZQ2HdGUxA4KuDMMBha/Nr
 6aWwbWdEh8WVFUGZ+UaEK1CcLOeaXT0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-5PnbvubPMS-tQaLu4fmfXQ-1; Mon, 15 Apr 2024 09:07:34 -0400
X-MC-Unique: 5PnbvubPMS-tQaLu4fmfXQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343e54fc19bso2176916f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186453; x=1713791253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DXhEXKQxXJEyufwop7Log9Kkvd4UZN51cf2kP3CzMqI=;
 b=OgGtf5hiEF8UIQcy8oka7g9Sco0Kda4E0an5aubXXQav1o0DaOD4vZcAmSNVkCd1Dh
 sYdDrJrStEwyLFnXr9xKyusoDz/Nqk0tVEONgDW07GXMjKDo3jHYBUou4hSm13knrg2P
 dKQ2aTrW9GXKfGjFbeXKHi5yEGVBABXj5d91mxukZLu8ca86nPA/Tbegr2L/WpIwAc/X
 at64i5WDLaMb7kkvvrFwGA/3UP0v7/sbHAZ670axGvj5fmO/dHKp3wHf+suSvHF0SnSp
 O26Arp9Kmi0kzm2CNkdJ35CjxOGXupXfuN12L1SJOZx73/Hl74Yt2AgDOXnhyj7x5e8L
 ds0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbi40rePDqSnpGMv7kgKprUDvrzbzStAI+5GngzNoEoBGuZw89gmvimYSH108Ou8yVU1QxsMRv3usAsr9YGPfHaok/AuU=
X-Gm-Message-State: AOJu0Yzc/qbwzZDYAB7F+FMkq6F+zPKbF09H19g08PjJrsOZxKLgE8F4
 nR47juWMcG403eTIOUeCyQAR6Uw7YXM/Mi0Y5R3ThxLOFShx9GMiEnnvxQLZ3geDewVt8tDAS25
 BiVBqcysLz3odbpPUXUwjVglvspPE84A8CCPXXL8MOsYb76nBfy8I
X-Received: by 2002:a5d:6b4b:0:b0:346:7f2e:6d19 with SMTP id
 x11-20020a5d6b4b000000b003467f2e6d19mr7554448wrw.39.1713186453716; 
 Mon, 15 Apr 2024 06:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx88WcMf8iL4Fc1Xjd4I7CfE/eF4LYjB2P8awOHdJfhP1q0VZ66X1U2+RQjAxGFCLNjUDk0Q==
X-Received: by 2002:a5d:6b4b:0:b0:346:7f2e:6d19 with SMTP id
 x11-20020a5d6b4b000000b003467f2e6d19mr7554425wrw.39.1713186453347; 
 Mon, 15 Apr 2024 06:07:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4e05000000b0033b48190e5esm12045838wrt.67.2024.04.15.06.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:07:32 -0700 (PDT)
Message-ID: <b761d626-046a-4032-940a-17d659090c9f@redhat.com>
Date: Mon, 15 Apr 2024 15:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] backends/iommufd: Introduce abstract HIODIOMMUFD
 device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-4-zhenzhong.duan@intel.com>
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
> HIODIOMMUFD represents a host IOMMU device under iommufd backend.
> 
> Currently it includes only public iommufd handle and device id.
> which could be used to get hw IOMMU information.
> 
> When nested translation is supported in future, vIOMMU is going
> to have iommufd related operations like attaching/detaching hwpt,
> So IOMMUFDDevice interface will be further extended at that time.
> 
> VFIO and VDPA device have different way of attaching/detaching hwpt.
> So HIODIOMMUFD is still an abstract class which will be inherited by
> VFIO and VDPA device.
> 
> Introduce a helper hiod_iommufd_init() to initialize HIODIOMMUFD
> device.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/iommufd.h | 22 +++++++++++++++++++
>   backends/iommufd.c       | 47 ++++++++++++++++++++++++++--------------
>   2 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 9af27ebd6c..71c53cbb45 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -4,6 +4,7 @@
>   #include "qom/object.h"
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
> +#include "sysemu/host_iommu_device.h"
>   
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
>   OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -33,4 +34,25 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size);
> +
> +#define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"

Please keep TYPE_HOST_IOMMU_DEVICE

> +OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
> +
> +struct HIODIOMMUFD {
> +    /*< private >*/
> +    HostIOMMUDevice parent;
> +    void *opaque;
> +
> +    /*< public >*/
> +    IOMMUFDBackend *iommufd;
> +    uint32_t devid;
> +};
> +
> +struct HIODIOMMUFDClass {
> +    /*< private >*/
> +    HostIOMMUDeviceClass parent_class;
> +};

This new class doesn't seem useful. Do you have plans for handlers ?

> +
> +void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
> +                       uint32_t devid);
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 62a79fa6b0..ef8b3a808b 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -212,23 +212,38 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> -static const TypeInfo iommufd_backend_info = {
> -    .name = TYPE_IOMMUFD_BACKEND,
> -    .parent = TYPE_OBJECT,
> -    .instance_size = sizeof(IOMMUFDBackend),
> -    .instance_init = iommufd_backend_init,
> -    .instance_finalize = iommufd_backend_finalize,
> -    .class_size = sizeof(IOMMUFDBackendClass),
> -    .class_init = iommufd_backend_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { TYPE_USER_CREATABLE },
> -        { }
> -    }
> -};
> +void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
> +                       uint32_t devid)
> +{
> +    idev->iommufd = iommufd;
> +    idev->devid = devid;
> +}

This routine doesn't seem useful. I wonder if we shouldn't introduce
properties. I'm not sure this is useful either.


> -static void register_types(void)
> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
>   {
> -    type_register_static(&iommufd_backend_info);
>   }
>   
> -type_init(register_types);
> +static const TypeInfo types[] = {
> +    {
> +        .name = TYPE_IOMMUFD_BACKEND,
> +        .parent = TYPE_OBJECT,
> +        .instance_size = sizeof(IOMMUFDBackend),
> +        .instance_init = iommufd_backend_init,
> +        .instance_finalize = iommufd_backend_finalize,
> +        .class_size = sizeof(IOMMUFDBackendClass),
> +        .class_init = iommufd_backend_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { TYPE_USER_CREATABLE },
> +            { }
> +        }
> +    }, {
> +        .name = TYPE_HIOD_IOMMUFD,
> +        .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HIODIOMMUFD),
> +        .class_size = sizeof(HIODIOMMUFDClass),
> +        .class_init = hiod_iommufd_class_init,
> +        .abstract = true,
> +    }
> +};
> +
> +DEFINE_TYPES(types)


