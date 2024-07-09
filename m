Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E855C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4v0-0000w5-NR; Tue, 09 Jul 2024 03:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4ur-0000sb-NC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4up-0007zR-1O
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720508729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIh0/xT4ftrujjWI4SgpVnqT/rl0V7sKh9mc6p+r1Ug=;
 b=LCaoyYGK+5vpN/W5hFkFEmoZOKpyRP64sGHwYXSdQP2yLxZN9fYqMGfeRcXb5jJNVkJAhm
 SPWmegN7KzYOAwhjo+GN5qc9zFDaVeHot4EEiRvFFCICvOKWImV9TDZeT4H4J73xqqBDme
 71j7PEcepFHUkwyodX1YBIglhniNTt0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-1hl_2RxJPiaKVTrtOZYrMQ-1; Tue, 09 Jul 2024 03:05:27 -0400
X-MC-Unique: 1hl_2RxJPiaKVTrtOZYrMQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42725ec6d8dso961795e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720508726; x=1721113526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HIh0/xT4ftrujjWI4SgpVnqT/rl0V7sKh9mc6p+r1Ug=;
 b=ZzBwFBjqXi5+gECMnA/P59i9N5hz0DzV3nDIvBIxEsBxqux62eTasU842m+L3BoEUZ
 Uo1BH7ZgvB0Hgx60yZLBFKkrGa88Bf3YK5RlzceSMuWB+zQWWzdnBAuJDJZEC7MBF5JV
 dICnxYAZWioZ38cph1zLM81DXJ2Xrt6Hte0jiPcsrtlEXOePzdLO6VQQxsu400a5y0e4
 rBgXqq2ktfgBJubyJfuCbkCA+Q67C1Q4pXvxM8CDg3j5Ixe8cLEoGO8khywcn++eV9Sj
 9R0xyj6Cy6Z9/4ZY0EqmpeCPCusrO9cCEmsOXLYqfVd7DSWMNvagTNkgfXPf00EJo8I2
 JnUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Bop1lXFne37ZYCcOCmYNsB++Qo716WiHwduAqLEP67CCJacNlQ5zW8/IAUmtBwm6whT0CMOd2puxrkemLFxfT+dzDqg=
X-Gm-Message-State: AOJu0YwG/HA9uCN59jfrOqWzM3cwRgvwFGPO0JeUa5XczLLyOW+zrXeZ
 XXivS8hO8zlKfoZyXhQWxZ/C68spqykv0GiR7XnxpO2XgjCNbFLm1nncP449bpw+RcsQzRLzyv7
 leKmAUD1Es44Rnuy8ui87czLRZ7Znl4xT31NqdTqlZ6/a0Lw4ugs9
X-Received: by 2002:a05:600c:47c7:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-426706c62c0mr13095245e9.4.1720508726431; 
 Tue, 09 Jul 2024 00:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5W6b0o2NadFACd64xIdexisSnNt8SfF779ibMx4pjVVTSemlyKBv4LQINwTZDqrX0iuNJYA==
X-Received: by 2002:a05:600c:47c7:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-426706c62c0mr13095075e9.4.1720508726047; 
 Tue, 09 Jul 2024 00:05:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266ac156easm62546655e9.38.2024.07.09.00.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 00:05:25 -0700 (PDT)
Message-ID: <7dd75280-47a7-4d66-8b39-7347e9194a9e@redhat.com>
Date: Tue, 9 Jul 2024 09:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-8-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 7/8/24 4:34 PM, Joao Martins wrote:
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
>   include/sysemu/iommufd.h |  3 +++
>   backends/iommufd.c       | 26 ++++++++++++++++++++++++++
>   hw/vfio/iommufd.c        | 34 ++++++++++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   4 files changed, 64 insertions(+)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 1470377f55ba..223f1ea14e84 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -56,6 +56,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  void *data_ptr, uint32_t *out_hwpt);
>   int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start);
> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint64_t iova, ram_addr_t size,
> +                                     uint64_t page_size, uint64_t *data);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 69daabc27473..b2d3bbd7c31b 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -257,6 +257,32 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>       return ret;
>   }
>   
> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint64_t iova, ram_addr_t size,
> +                                     uint64_t page_size, uint64_t *data)
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
> +                                           page_size, ret);
> +    if (ret) {
> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
> +                     " size: 0x%"PRIx64") failed: %s", iova,
> +                     size, strerror(errno));
> +    }
> +
> +    return !ret ? 0 : -errno;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 158a98cb3b12..9fad47baed9e 100644
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
> @@ -152,6 +153,38 @@ err:
>       return ret;
>   }
>   
> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp)
> +{
> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
> +                                                   VFIOIOMMUFDContainer,
> +                                                   bcontainer);
> +    int ret;
> +    VFIOIOASHwpt *hwpt;
> +    unsigned long page_size;
> +
> +    page_size = qemu_real_host_page_size();
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +
> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
> +                                               iova, size, page_size,
> +                                               vbmap->bitmap);
> +        if (ret) {
> +            error_setg_errno(errp, ret,
> +                             "Failed to get dirty bitmap report, hwpt_id %u, iova: "
> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> +                             hwpt->hwpt_id, iova, size);

This error looks redundant with the one printed out in
iommufd_backend_get_dirty_bitmap(). Couldn't we add an 'Error **'
parameter and simply return a bool ?


Thanks,

C.



> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -777,6 +810,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
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


