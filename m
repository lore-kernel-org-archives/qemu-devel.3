Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2696FC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThgS-0005xQ-38; Tue, 16 Jul 2024 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThgH-0005H7-8B
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThgF-0005Ac-9Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721134398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKD9kgYhxoujlKSB43EIzyzXcpA7KdSfRQimkttTnQo=;
 b=TXTm1ZyEiX/FhRgWWEPsUY4jZd4X6pBWG0m8DmOP5KhV21pUJgMYnt/CoQw87yeXfUllNl
 PC1P7vTNhk4p5Kp1l8xaRqmKifWRCRDlUOMhMxRsArHTBDm3xwNL0hPapElyUliI6VmTAe
 5APnG9924PjjOglqGYVvbNEwtN95iCc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ckm9I_N-NVe3IDmw1RqGDg-1; Tue, 16 Jul 2024 08:53:15 -0400
X-MC-Unique: ckm9I_N-NVe3IDmw1RqGDg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ebdb0ef28so6738195e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134394; x=1721739194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKD9kgYhxoujlKSB43EIzyzXcpA7KdSfRQimkttTnQo=;
 b=AU/2ynKttdlUqHW7aSX9nGlhAXykc/zSyBzffN/a7doWwiDpKUE3QES0h2bO3hiser
 qB75/LTU78/nn1TTuPPdIfiGHk7JaKKVhfCmZrQvp6szvWVS2E0VlAbx9C/oHoB/wOPl
 wBfW6PM7DvzSiC9VzvvX7jykeTRTlz5sqrsMCeFQ84E6ycjEFSQBWzZh+r9jImbcyoeP
 NzzuQgY34yV18jiN9fu97AWXQqqwrcxHc5dTQEMz7893k6WXGaGTyjhqMMkrIOKNLlER
 rqB1qjGxCtmkuo84yx1W1LUcT7b92NabkRyz4dKHS2Ti6G5VhyTYVtitIxu32iGhoCGl
 rA7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfsrWB3m8TjEaKoK6UbKY/TkOe0XzeTGXMsf/ODPVlnirOQdx+Mxgie1h20ukjLH2YCrJfkIlMK1WWZ1oCtBm0ojoiCy4=
X-Gm-Message-State: AOJu0Yy6My2ex+n+RqrtQGVHnkBw7JGCxY3lgnSXbFQnjUmhDWf9sCBN
 2eUvRNgvrLM+4YgJIm9guEqkjLWFh1HuKwudWAMuaANQAp3E/OPx//PFHNsrJLFynI0pJjMRz9T
 67m8IMde3sdeOY4GAvh/gl9+dUdiqVlQ8888+DrDH+wbx1bxHnURZ
X-Received: by 2002:a05:6512:31d6:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-52edf0389b8mr1547704e87.53.1721134394461; 
 Tue, 16 Jul 2024 05:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmr5iD4jUgiQFWQ6waLPwfx8V+mCcCThpDEYQYEmhEHhpNlcMJf+W58yhfoX8a5bT+I1i7yQ==
X-Received: by 2002:a05:6512:31d6:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-52edf0389b8mr1547686e87.53.1721134394025; 
 Tue, 16 Jul 2024 05:53:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a63449fcsm124982015e9.29.2024.07.16.05.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:53:13 -0700 (PDT)
Message-ID: <e8964fb4-3825-4bc4-afd0-740318af26cf@redhat.com>
Date: Tue, 16 Jul 2024 14:53:12 +0200
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
Content-Transfer-Encoding: 7bit
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

format should be:
                             " size: 0x"RAM_ADDR_FMT") failed", iova, size);
    

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
vbmap->bitmap needs a cast.


Thanks,

C.



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


