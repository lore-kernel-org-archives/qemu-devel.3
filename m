Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D817C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u01I1-0006Ps-TU; Wed, 02 Apr 2025 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Hr-0006K3-8h
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Hp-0003DR-7V
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743612595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0VFiK7ZEJ50v1VYufkl8ML1hma29bLo67zs/mp+WzwI=;
 b=azlNKCVIibkQD00mM+1wLhZxYyBiUZ5XelVZ/rjpVLyume65RbCoBuL75Rq/G4g7bt13sK
 Jb7ogWfMNSCYmpesfbsdkY8PccNlTd5DpzeC4otoopWNDPOAB0Hp8P9mLrgosREnCQQTRF
 05+QuHTeNBgeyG7G3xv1NN4tkqMkpqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-xdV8VO3PMu2q2PT88wFJDg-1; Wed, 02 Apr 2025 12:49:54 -0400
X-MC-Unique: xdV8VO3PMu2q2PT88wFJDg-1
X-Mimecast-MFC-AGG-ID: xdV8VO3PMu2q2PT88wFJDg_1743612593
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so41639305e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743612593; x=1744217393;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VFiK7ZEJ50v1VYufkl8ML1hma29bLo67zs/mp+WzwI=;
 b=IKC1w6ujcgIA6rnnb8Hk1cVZThiIfBz3D3WwwUKDibdxDJj6UGOn93ADaB6jkjyHr4
 at2tsrxGqSihibJhwEj1ab3lKaPscIl0Uv0Qry1QzevZHwd5x9KF/bv/NyC8Pu67nZgV
 muncF9bjQHUCZorIeg8pGMq3nmtJ4F21bF4CEVURh9E4rXedyCaf9AbHdKR3ULTE5mAb
 jQQ5VlFTMcjQDHaahNOV8sY0qOU7zXa5uQxJuBV95qYjDkvvhO9QiGPC6tfgkhdZ5R5R
 r/pCModHt3u3AnkmZD5XX9sGR3Be8tEcuqttwkLTSgINGpGMmXm472EYHRY3Uszn37m1
 ECMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIl7cYsLgCcwt34sIZmR4lNNyVYDJVRsvUp/G0VeBfMnuQvdo1vkZSoVRkw31xzr2vzkW8D5yDAeGk@nongnu.org
X-Gm-Message-State: AOJu0YxovY0TAssW0/6cVWcqWQ11faDUDRfuopu2M/yepJBigKgiUNa6
 lZTx5jJ5HlxePy5MSxetc9j6ufW2CkRDgwogcIbq3dYtGlZl4rOxHZj7i6Ay3MQRAU1dstwbVmO
 9baOImXnTB5MqHRlJQYFOfdA0fYDuydBgXhI4i7hpjtLweD1mpGRHYElhNgoM
X-Gm-Gg: ASbGncvcPOKh83T8qD+4RmA7oqHEGQ2JUkqBR96NEFENv6zlk/J37tJhql8QHQXG0zU
 rYMtECnYVxCvyeFxs9rofeja/afodBnVgoGKdq8aQdSO5BwAvtmLFVaXSswTs+vAlhwJqGAjZQC
 NBZvq38aQ8jsuOVqhao2Cw+yXobG+VqJWv+5zKgpZr/XAbIpkkGtPoi433Png1Tcw/BXu2+IwAe
 NXRb4PE+eJiPFKwb5+1PpFaLfb8u1YRbd9+h3enfSJJLghqAqWQSc30zapcmvnY4l3Gy2UTFe92
 sdTsWBbgg0IXQzepk5YTHrTVYzTeEjCE3aDJrtGzC07LLMdXWgXIdw==
X-Received: by 2002:a05:600c:4f82:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-43db62b5ba8mr148430735e9.26.1743612592881; 
 Wed, 02 Apr 2025 09:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx/oUBbGz/385AjnWBxdbqBSuv6014zPoT680OO1We9hpfqRGCy+1r4QzWjKG1UqWcKwNr3Q==
X-Received: by 2002:a05:600c:4f82:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-43db62b5ba8mr148430355e9.26.1743612592420; 
 Wed, 02 Apr 2025 09:49:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b65b4fcsm17802014f8f.11.2025.04.02.09.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 09:49:51 -0700 (PDT)
Message-ID: <7aee0391-256c-40dc-a2a1-328065d6dd08@redhat.com>
Date: Wed, 2 Apr 2025 18:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/28] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-4-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/19/25 15:48, John Levon wrote:
> Some containers can directly implement unmapping all regions;
> add a new flag to support this.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/common.c                      | 24 +++++++----------
>   hw/vfio/container-base.c              |  4 +--
>   hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
>   hw/vfio/iommufd.c                     | 19 +++++++++++++-
>   include/hw/vfio/vfio-common.h         |  1 +
>   include/hw/vfio/vfio-container-base.h |  4 +--
>   6 files changed, 68 insertions(+), 22 deletions(-)


This is difficult to understand. There are no functional changes right ?
I think it should be broken down further to clarify the changes.


Thanks,

C.





> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6f106167fd..b49aafc40c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -324,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           }
>       } else {
>           ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       iotlb->addr_mask + 1, iotlb);
> +                                       iotlb->addr_mask + 1, iotlb, 0);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
> @@ -348,7 +348,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>       int ret;
>   
>       /* Unmap with a single call. */
> -    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
> +    ret = vfio_container_dma_unmap(bcontainer, iova, size, NULL, 0);
>       if (ret) {
>           error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
>                        strerror(-ret));
> @@ -806,21 +806,15 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       }
>   
>       if (try_unmap) {
> +        int flags = 0;
> +
>           if (int128_eq(llsize, int128_2_64())) {
> -            /* The unmap ioctl doesn't accept a full 64-bit span. */
> -            llsize = int128_rshift(llsize, 1);
> -            ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                           int128_get64(llsize), NULL);
> -            if (ret) {
> -                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                             "0x%"HWADDR_PRIx") = %d (%s)",
> -                             bcontainer, iova, int128_get64(llsize), ret,
> -                             strerror(-ret));
> -            }
> -            iova += int128_get64(llsize);
> +            flags = VFIO_DMA_UNMAP_FLAG_ALL;
>           }
> -        ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       int128_get64(llsize), NULL);
> +
> +        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> +                                       NULL, flags);
> +
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 5e0c9700d9..db27e9c31d 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -27,12 +27,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>   
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
> -                             IOMMUTLBEntry *iotlb)
> +                             IOMMUTLBEntry *iotlb, int flags)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       g_assert(vioc->dma_unmap);
> -    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
> +    return vioc->dma_unmap(bcontainer, iova, size, iotlb, flags);
>   }
>   
>   bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 0db0055f39..82987063e5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -117,7 +117,7 @@ unmap_exit:
>    */
>   static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>                                    hwaddr iova, ram_addr_t size,
> -                                 IOMMUTLBEntry *iotlb)
> +                                 IOMMUTLBEntry *iotlb, int flags)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -140,6 +140,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>           need_dirty_sync = true;
>       }
>   
> +    /* use unmap all if supported */
> +    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> +        unmap.iova = 0;
> +        unmap.size = 0;
> +        if (container->unmap_all_supported) {
> +            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +        } else {
> +            /* unmap in halves */
> +            Int128 llsize = int128_rshift(int128_2_64(), 1);
> +
> +            unmap.size = int128_get64(llsize);
> +
> +            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +
> +            if (ret == 0) {
> +                unmap.iova += int128_get64(llsize);
> +
> +                ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +            }
> +        }
> +
> +        if (ret != 0) {
> +            return -errno;
> +        }
> +
> +        goto out;
> +    }
> +
>       while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>           /*
>            * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -162,6 +190,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>           return -errno;
>       }
>   
> +out:
>       if (need_dirty_sync) {
>           ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>                                       iotlb->translated_addr, &local_err);
> @@ -199,7 +228,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>        */
>       if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
>           (errno == EBUSY &&
> -         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
> +         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, 0) == 0 &&
>            ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>           return 0;
>       }
> @@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       vfio_get_info_iova_range(info, bcontainer);
>   
>       vfio_get_iommu_info_migration(container, info);
> +
> +    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
> +
> +    container->unmap_all_supported = (ret != 0);
> +
>       return true;
>   }
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 583b063707..e295f251c0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -41,11 +41,28 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>   
>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                 hwaddr iova, ram_addr_t size,
> -                              IOMMUTLBEntry *iotlb)
> +                              IOMMUTLBEntry *iotlb, int flags)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
> +    /* unmap in halves */
> +    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +        int ret;
> +
> +        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                        iova, int128_get64(llsize));
> +        iova += int128_get64(llsize);
> +
> +        if (ret == 0) {
> +            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> +                                            iova, int128_get64(llsize));
> +        }
> +
> +        return ret;
> +    }
> +
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
>       return iommufd_backend_unmap_dma(container->be,
>                                        container->ioas_id, iova, size);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ac35136a11..f4f08eb8a6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -84,6 +84,7 @@ typedef struct VFIOContainer {
>       VFIOContainerBase bcontainer;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       unsigned iommu_type;
> +    bool unmap_all_supported;
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
>   
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 0a863df0dc..24e48e3a07 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -76,7 +76,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              void *vaddr, bool readonly, MemoryRegion *mrp);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
> -                             IOMMUTLBEntry *iotlb);
> +                             IOMMUTLBEntry *iotlb, int flags);
>   bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section,
>                                          Error **errp);
> @@ -118,7 +118,7 @@ struct VFIOIOMMUClass {
>                      void *vaddr, bool readonly, MemoryRegion *mrp);
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
> -                     IOMMUTLBEntry *iotlb);
> +                     IOMMUTLBEntry *iotlb, int flags);
>       bool (*attach_device)(const char *name, VFIODevice *vbasedev,
>                             AddressSpace *as, Error **errp);
>       void (*detach_device)(VFIODevice *vbasedev);


