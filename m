Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BE8C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThKr-00068j-UB; Tue, 16 Jul 2024 08:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThKo-00067Y-QM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThKm-0000Lq-3Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721133066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSkAUm7AEgApSOBZqItTnYq+k5mUxRi5Bbmv2EAEpaY=;
 b=QA5fzfxg6SJYCx39VYapHs9SSchIbRSqbGvBT6btaDhKQgF7bYCeFkX/Wrlx+0t8oiHC64
 pRdjw4HtIndurwEBC/C5NbPv+yoZ2BBA4TyiEuHRj+SbctqAmViV1SaA/V2a9KbZhNngcs
 5W6atN8AKJ4kfFCAzibZp7LG07dzBEw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-6454RoE5MHugrTMVOQzNNA-1; Tue, 16 Jul 2024 08:31:05 -0400
X-MC-Unique: 6454RoE5MHugrTMVOQzNNA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-368255decf3so658713f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721133064; x=1721737864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSkAUm7AEgApSOBZqItTnYq+k5mUxRi5Bbmv2EAEpaY=;
 b=aS83SCWockbQHgqd6tkQKxDKBtHLErF2xd5aRQrMhvAy2xtGW+PA66Pi7IaH+mWRUE
 O4A8ds2GZURrZQlJ1fC8EKJ3h00S+v5obmo+JtBkxm9+7mqUCuVG8KayMxm5/c3aVsjO
 rjVkmB5FnnQLgBnvJdEmJC+FeYKPM+oEmScAi+YOP8Gnf1Af1pbnESZOjKXXKOq7qhh2
 aRWej6O6aiCN+HJVBfNs9qOEx/D3oLVt2LY2fVkQqRA3hbIpkJVqa2qh17bewc3Tpok2
 uAkZopAvomYnRtxinGkD9dDNM/IO2Z6cm1Y4+7yGJy1iPPfjq5yx+ijaOm7DQjbjYUp6
 n1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzKKqpWCjchnvjCLdI3J2yWrQ5bwsf46wh3cf5tPq0sqZhKPFEv4cH0RaJu8UHrx7aO0A0uZAq32SXAleSGqNqVQhWpgM=
X-Gm-Message-State: AOJu0YxGYKy1MvvWBzA/soloIpU7JZpyL19S854Y0RLC5f5D14HtYYJV
 YRyl8pkjrz6nagZFatOLcuu6g5fXG4ObrI1oWUmVggMfGTqfzz2+Mu4Czn3IshrzEEDAJzgOyod
 bmLV3GfgUnwtSO4MxNEbb1OFmZW2wm0FwORFXXDBdiLD8LrZG5/QJ
X-Received: by 2002:a5d:59ac:0:b0:367:2d2f:e634 with SMTP id
 ffacd0b85a97d-368263128damr1959828f8f.55.1721133064141; 
 Tue, 16 Jul 2024 05:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfZEMJAzaw/APOZ0tDNfcKoxcg9rMgEWmsuCUdjTuzZL0300aHxYurpGK7oPAdkOizWCbw1g==
X-Received: by 2002:a5d:59ac:0:b0:367:2d2f:e634 with SMTP id
 ffacd0b85a97d-368263128damr1959800f8f.55.1721133063694; 
 Tue, 16 Jul 2024 05:31:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a8799e7esm113591655e9.18.2024.07.16.05.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:31:03 -0700 (PDT)
Message-ID: <ea58dcaf-650f-4387-bb19-868b8efe7523@redhat.com>
Date: Tue, 16 Jul 2024 14:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-11-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-11-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/12/24 13:47, Joao Martins wrote:
> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
> that fetches the bitmap that tells what was dirty in an IOVA
> range.
> 
> A single bitmap is allocated and used across all the hwpts
> sharing an IOAS which is then used in log_sync() to set Qemu
> global bitmaps.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/iommufd.h |  4 ++++
>   backends/iommufd.c       | 29 +++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c        | 27 +++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   4 files changed, 61 insertions(+)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 7416d9219703..869ca8b7ef59 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -57,6 +57,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   Error **errp);
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                           bool start, Error **errp);
> +bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                      uint64_t iova, ram_addr_t size,
> +                                      uint64_t page_size, uint64_t *data,
> +                                      Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 239f0976e0ad..46be719cae71 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -262,6 +262,35 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>       return true;
>   }
>   
> +bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
> +                                      uint32_t hwpt_id,
> +                                      uint64_t iova, ram_addr_t size,
> +                                      uint64_t page_size, uint64_t *data,
> +                                      Error **errp)
> +{
> +    int ret;
> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
> +        .size = sizeof(get_dirty_bitmap),
> +        .hwpt_id = hwpt_id,
> +        .iova = iova,
> +        .length = size,
> +        .page_size = page_size,
> +        .data = (uintptr_t)data,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
> +                                           page_size, ret ? errno : 0);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
> +                         " size: 0x%"HWADDR_PRIx") failed", iova, size);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index da678315faeb..1fd1558fa0c0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> +#include "exec/ram_addr.h"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
> @@ -146,6 +147,31 @@ err:
>       return -EINVAL;
>   }
>   
> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp)
> +{
> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
> +                                                   VFIOIOMMUFDContainer,
> +                                                   bcontainer);
> +    unsigned long page_size = qemu_real_host_page_size();
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +
> +        if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
> +                                              iova, size, page_size,
> +                                              vbmap->bitmap, errp)) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -754,6 +780,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>       vioc->detach_device = iommufd_cdev_detach;
>       vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>       vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
> +    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>   };
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/backends/trace-events b/backends/trace-events
> index 28aca3b859d4..40811a316215 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -17,3 +17,4 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"


