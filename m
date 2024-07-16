Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88B8C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTefD-0003Rz-F7; Tue, 16 Jul 2024 05:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTefB-0003IQ-0d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTef8-0007L6-VD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721122797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPjsTYsiH4cAjxTke3Myo2jLE7wXxPp6IZURMgjgyRg=;
 b=CNlMD/atwRKVAjBBRhmviBxylR0ghsqvVKimcSi/Xn5WAlHWM0MfNMWWI8VYaPNBhdRZIb
 b4mK9rM3ZB3CUIpub/rnIsFM8C4JftPy0IUJOjzlpVghjAqyQZXEtDj9co3ktoeeqvKlIH
 KZywEVrkAuD7EbLpiJZ7hLfsB5Pli5w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-TmjcC4s8O2mnzur77r3VxQ-1; Tue, 16 Jul 2024 05:39:56 -0400
X-MC-Unique: TmjcC4s8O2mnzur77r3VxQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-447dcea5048so60847811cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122795; x=1721727595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPjsTYsiH4cAjxTke3Myo2jLE7wXxPp6IZURMgjgyRg=;
 b=orIIDYOQrd4d/hvQwKd4Ziykft6Q87Q11xAvrb6nJdK81HqGbDtKdQEOQPx6L9hQMz
 f76NTQkhrDGwgB6mxikei9xCXuTrAjn8LNy1K5NyuC21nz3cF3R6Tifj8R+EYsS+OPiC
 +eVbrDh2BBy51fB91UiYy7EzvkCPJ1bQtektLTjkNuRBnbEfxBb1XpyUOdqlJFO1mVOv
 n7kBVr9xdRYn4z9PhoOqwoic2BizKcUKNHy7mIp/OiCHrk96shP839mF6FSBzZYpRxS3
 caFPUIcjB1x9Qi/NIccB0fDlqpaBl3MIB5n5EPGO4ZYHQT/VjaSj4NmRMZE6zFhNKz+Z
 pz0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIuOKl89EWCWGNr9uBrXwPH0B9PP0xut9IWU47RPWFmVU8l7FnX3HylSrbQKNVoQYqEQMu7mCJhmP6K/Rr7wcBXRZKDwI=
X-Gm-Message-State: AOJu0Yy7A1zZ5EUE3ppx4FFg9mLmudJZTPqS1h+DDmXTTHdDUSRAqNpo
 0tDcfJIz0xTnCwlKZQV24YYp+xKyLxKVczmorPOfWlEifV2cRAAdKZ0cun1AM3JWgCydViXKlZp
 oghOaAj5N/mjPP8wLrFYSRUhbEMcqSKjPO3WP+iKBUOwL3kqYepx7
X-Received: by 2002:ac8:57c1:0:b0:447:e769:76fc with SMTP id
 d75a77b69052e-44f7ac6f13emr21469091cf.34.1721122795492; 
 Tue, 16 Jul 2024 02:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR/f3bYteWnJHV+Hd3FVv1RpD7Cmmnv9gyN5G7FYEYKDu8U2/vXjj1mX5Fr/9IMb/duBwhHw==
X-Received: by 2002:ac8:57c1:0:b0:447:e769:76fc with SMTP id
 d75a77b69052e-44f7ac6f13emr21468881cf.34.1721122795067; 
 Tue, 16 Jul 2024 02:39:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b83d99bsm33219541cf.79.2024.07.16.02.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:39:54 -0700 (PDT)
Message-ID: <78c7c331-c4cf-4239-a875-b321ca5d7e08@redhat.com>
Date: Tue, 16 Jul 2024 11:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-6-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/12/24 13:46, Joao Martins wrote:
> There's generally two modes of operation for IOMMUFD:
> 
> * The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
> and mainly performs IOAS_MAP and UNMAP.
> 
> * The native IOMMUFD API where you have fine grained control of the
> IOMMU domain and model it accordingly. This is where most new feature
> are being steered to.
> 
> For dirty tracking 2) 

I suppose 1) and 2) are the bullets above ?

> is required, as it needs to ensure that
> the stage-2/parent IOMMU domain will only attach devices
> that support dirty tracking (so far it is all homogeneous in x86, likely
> not the case for smmuv3). Such invariant on dirty tracking provides a
> useful guarantee to VMMs that will refuse incompatible device
> attachments for IOMMU domains.
> 
> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
> responsible for creating an IOMMU domain. This is contrast to the
> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
> when it attaches to VFIO (usually referred as autodomains) but it has
> the needed handling for mdevs.
> 
> To support dirty tracking with the advanced IOMMUFD API, it needs
> similar logic, where IOMMU domains are created and devices attached to
> compatible domains. Essentially mimmicing kernel

mimmicing -> mimicking, I think.

> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
> it falls back to IOAS attach.
> 
> The auto domain logic allows different IOMMU domains to be created when
> DMA dirty tracking is not desired (and VF can provide it), and others where
> it is. Here is not used in this way here given how VFIODevice migration
> state is initialized after the device attachment. But such mixed mode of
> IOMMU dirty tracking + device dirty tracking is an improvement that can
> be added on. Keep the 'all of nothing' of type1 approach that we have
> been using so far between container vs device dirty tracking.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

This needs feedback from IOMMUFD experts also.

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  9 ++++
>   include/sysemu/iommufd.h      |  5 +++
>   backends/iommufd.c            | 30 +++++++++++++
>   hw/vfio/iommufd.c             | 82 +++++++++++++++++++++++++++++++++++
>   backends/trace-events         |  1 +
>   5 files changed, 127 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7419466bca92..2dd468ce3c02 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
>   
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
>   typedef struct VFIOIOMMUFDContainer {
>       VFIOContainerBase bcontainer;
>       IOMMUFDBackend *be;
>       uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>   } VFIOIOMMUFDContainer;
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>       HostIOMMUDevice *hiod;
>       int devid;
>       IOMMUFDBackend *iommufd;
> +    VFIOIOASHwpt *hwpt;
> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 57d502a1c79a..e917e7591d05 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp);
> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t pt_id, uint32_t flags,
> +                                uint32_t data_type, uint32_t data_len,
> +                                void *data_ptr, uint32_t *out_hwpt,
> +                                Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2b3d51af26d2..5d3dfa917415 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -208,6 +208,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t pt_id, uint32_t flags,
> +                                uint32_t data_type, uint32_t data_len,
> +                                void *data_ptr, uint32_t *out_hwpt,
> +                                Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_hwpt_alloc alloc_hwpt = {
> +        .size = sizeof(struct iommu_hwpt_alloc),
> +        .flags = flags,
> +        .dev_id = dev_id,
> +        .pt_id = pt_id,
> +        .data_type = data_type,
> +        .data_len = data_len,
> +        .data_uptr = (uint64_t)data_ptr,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
> +                                     data_len, (uint64_t)data_ptr,
> +                                     alloc_hwpt.out_hwpt_id, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
> +        return false;
> +    }
> +
> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
> +    return true;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 077dea8f1b64..325c7598d5a1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -212,10 +212,86 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
> +    uint32_t flags = 0;
> +    VFIOIOASHwpt *hwpt;
> +    uint32_t hwpt_id;
> +    int ret;
> +
> +    /* Try to find a domain */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +        if (ret) {
> +            /* -EINVAL means the domain is incompatible with the device. */
> +            if (ret == -EINVAL) {
> +                /*
> +                 * It is an expected failure and it just means we will try
> +                 * another domain, or create one if no existing compatible
> +                 * domain is found. Hence why the error is discarded below.
> +                 */
> +                error_free(*errp);
> +                *errp = NULL;
> +                continue;
> +            }
> +
> +            return false;
> +        } else {
> +            vbasedev->hwpt = hwpt;
> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +            return true;
> +        }
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> +                                    container->ioas_id, flags,
> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
> +                                    &hwpt_id, errp)) {
> +        return false;
> +    }
> +
> +    hwpt = g_malloc0(sizeof(*hwpt));
> +    hwpt->hwpt_id = hwpt_id;
> +    QLIST_INIT(&hwpt->device_list);
> +
> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +    if (ret) {
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +        return false;
> +    }
> +
> +    vbasedev->hwpt = hwpt;
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    return true;
> +}
> +
> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container)
> +{
> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
> +
> +    QLIST_REMOVE(vbasedev, hwpt_next);
> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        QLIST_REMOVE(hwpt, next);
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +    }
> +}
> +
>   static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                             VFIOIOMMUFDContainer *container,
>                                             Error **errp)
>   {
> +    /* mdevs aren't physical devices and will fail with auto domains */
> +    if (!vbasedev->mdev) {
> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
> +    }
> +
>       return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>   }
>   
> @@ -224,6 +300,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>   
> +    if (vbasedev->hwpt) {
> +        iommufd_cdev_autodomains_put(vbasedev, container);
> +        return;
> +    }
> +
>       if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>           error_report_err(err);
>       }
> @@ -354,6 +435,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>       container->be = vbasedev->iommufd;
>       container->ioas_id = ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
>   
>       bcontainer = &container->bcontainer;
>       vfio_address_space_insert(space, bcontainer);
> diff --git a/backends/trace-events b/backends/trace-events
> index 211e6f374adc..4d8ac02fe7d6 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"


