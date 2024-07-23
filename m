Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B18C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9nL-00050H-BU; Tue, 23 Jul 2024 03:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9nI-0004r4-W9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9nG-0003gT-7t
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721719119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mpn6iMDpAw12WoS2DVWV8hTOlPhLtnLlVaALNuloLN4=;
 b=KNaOC9kU3SRgLjsm6GCspf7vEl7efCbZhd71H9f5DEVZK2Rrocj4uCn2lGCsGdiIXM6b3z
 q/abdVXsmdusf1PzTS4NpsrnPnMbA0ItdCX6c3T2dUcRR+sB1/qxQ7aGQZU7w5N6lO73l4
 5uSH7PcoFSnfnQmxyeJFA8vbAFkn5HE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-UldVRLxoOgyUSwjMi3hwhA-1; Tue, 23 Jul 2024 03:18:36 -0400
X-MC-Unique: UldVRLxoOgyUSwjMi3hwhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so22785385e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721719115; x=1722323915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mpn6iMDpAw12WoS2DVWV8hTOlPhLtnLlVaALNuloLN4=;
 b=lR9R3dDLkbO6Madsd9OiGsgRvIUqSg5D0UDoEpSHVDnO5BXzxIzxMVtXuM0zjNtyrf
 cYQ867a/AjY+avMDUgnul7XC25ENxszUdXNsNPT2tTwdfJi9OCHgu39i+v2bl9W90Dy2
 1IsxCPCmuCaNvsJTNtTK5+yqud2N18cScx7BfBQbNJSt9viRc9A4Irs7WS6BeOQPQCbb
 6E9GtWKT22Cp8jkeQMgZV5wOXQiBzzsG6aMMLy44nETPeyGUQ4fTSV23MAoW8JTclEaq
 jTyTZ+Ls90Gs4s5y2s6hKmy6kBY+WdB8sf+I1TrK+EhHt+FJo6ycr0sxVlDDiXDH6QKY
 lIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcPRISzokf71QXNF8MRgbZGKUE4JcmkQsqqAIIa/Iv6kzyHAV3A6uZbkF14o3HUY0fp4BI7tQlJO/Klhu36llNE3eXbx4=
X-Gm-Message-State: AOJu0YzHxjACyrfYUxzP2JKhpHqzFOlthQx3Th14f05ZfDmVYn4Pu6Bm
 7TaSYF7DQolQ35WX8kSMP/1NHoxlk3ysEwsOhpooYct6Z54c7z6iQP4XkWnOV5dsx00GfNatTr5
 WGnaxtVovfBFLuhss2PAN1GoPzj58m36jkMzl7KypnozozTzSZKue
X-Received: by 2002:a05:600c:3c96:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-427ef3a5a6bmr7664825e9.12.1721719115335; 
 Tue, 23 Jul 2024 00:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOttVVcTVPShkqQpLEzIDLIIhiUgMQxccorSERjAVQTBjNXd2tQK4YzbCx/QkzMjklSUFS8Q==
X-Received: by 2002:a05:600c:3c96:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-427ef3a5a6bmr7664515e9.12.1721719114784; 
 Tue, 23 Jul 2024 00:18:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94c30sm187497355e9.47.2024.07.23.00.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:18:34 -0700 (PDT)
Message-ID: <195a9848-08c6-4b39-84f3-84d936824cbc@redhat.com>
Date: Tue, 23 Jul 2024 09:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] vfio/iommufd: Introduce auto domain creation
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-2-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/24 23:13, Joao Martins wrote:
> There's generally two modes of operation for IOMMUFD:
>
> 1) The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
> to VFIO and mainly performs IOAS_MAP and UNMAP.
>
> 2) The native IOMMUFD API where you have fine grained control of the
> IOMMU domain and model it accordingly. This is where most new feature
> are being steered to.
>
> For dirty tracking 2) is required, as it needs to ensure that
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
> compatible domains. Essentially mimicking kernel
> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
> it falls back to IOAS attach.
>
> The auto domain logic allows different IOMMU domains to be created when
> DMA dirty tracking is not desired (and VF can provide it), and others where
> it is. Here it is not used in this way given how VFIODevice migration
> state is initialized after the device attachment. But such mixed mode of
> IOMMU dirty tracking + device dirty tracking is an improvement that can
> be added on. Keep the 'all of nothing' of type1 approach that we have
> been using so far between container vs device dirty tracking.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/vfio/vfio-common.h |  9 ++++
>  include/sysemu/iommufd.h      |  5 +++
>  backends/iommufd.c            | 30 +++++++++++++
>  hw/vfio/iommufd.c             | 84 +++++++++++++++++++++++++++++++++++
>  backends/trace-events         |  1 +
>  5 files changed, 129 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 98acae8c1c97..1a96678f8c38 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>  
>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>  
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
>  typedef struct VFIOIOMMUFDContainer {
>      VFIOContainerBase bcontainer;
>      IOMMUFDBackend *be;
>      uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>  } VFIOIOMMUFDContainer;
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>      HostIOMMUDevice *hiod;
>      int devid;
>      IOMMUFDBackend *iommufd;
> +    VFIOIOASHwpt *hwpt;
> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 57d502a1c79a..e917e7591d05 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp);
> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t pt_id, uint32_t flags,
> +                                uint32_t data_type, uint32_t data_len,
> +                                void *data_ptr, uint32_t *out_hwpt,
> +                                Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 48dfd3962474..60a3d14bfab4 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -207,6 +207,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>      return ret;
>  }
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
> +        .data_uptr = (uintptr_t)data_ptr,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
> +                                     data_len, (uintptr_t)data_ptr,
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
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7390621ee927..172553b1f7f8 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -212,10 +212,88 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>      return true;
>  }
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
> +    vbasedev->hwpt = NULL;
> +
> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        QLIST_REMOVE(hwpt, next);
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +    }
> +}
> +
>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
>  {
> +    /* mdevs aren't physical devices and will fail with auto domains */
> +    if (!vbasedev->mdev) {
> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
> +    }
> +
>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>  }
>  
> @@ -227,6 +305,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>      if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>          error_report_err(err);
>      }
> +
> +    if (vbasedev->hwpt) {
> +        iommufd_cdev_autodomains_put(vbasedev, container);
> +    }
> +
>  }
>  
>  static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
> @@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>      container->be = vbasedev->iommufd;
>      container->ioas_id = ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
>  
>      bcontainer = &container->bcontainer;
>      vfio_address_space_insert(space, bcontainer);
> diff --git a/backends/trace-events b/backends/trace-events
> index 211e6f374adc..4d8ac02fe7d6 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>  iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>  iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"


