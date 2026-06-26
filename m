Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61DDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBVt-0003vN-3S; Fri, 26 Jun 2026 14:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBVr-0003jA-4n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBVo-0002bG-Uj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=berPH/TKVNYHF5lUYi0bNqIJRxg9lJU7fevz+SJjH6U=;
 b=fbxvpZAW6OZziLVmZYuAwpzOZfdGqeOWDqrRMLbUoQieJpavsbqttJuLoUPHtmS3j43pd8
 5eiJObGZRwPEmVWk/V6sp4P/HcFAuUPsgzkZHXNz7MM5gLfW7q3DtyBEDHA/PhOrryVWIy
 v8jx4Q6qqbQ7lVJhnTdEr28Zm66Yyl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-9AD9edbMNHSmX2GvYId0ZA-1; Fri, 26 Jun 2026 14:42:42 -0400
X-MC-Unique: 9AD9edbMNHSmX2GvYId0ZA-1
X-Mimecast-MFC-AGG-ID: 9AD9edbMNHSmX2GvYId0ZA_1782499361
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46c90c8fd42so909346f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499361; x=1783104161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=berPH/TKVNYHF5lUYi0bNqIJRxg9lJU7fevz+SJjH6U=;
 b=kKKGvq56rfxvEe+aFAqf6qJlmHpCjSgFrUsW+kH89mIK6XJGoVx3QnnAagfi+9nG08
 DdqX9FyGfzNbodzLXECGFW23hj+wIUdfgPKekxhRx1k/p6s0eCQsPDHrFftZPog4h12/
 JWtFpMU/z3FCE6J4a4k6lwCA7FNHDyoWUcOVNVohMxgbvHrWzSzJ8qkoM4XdxmDLBDqu
 pTS0BRS2W9uLolixi8Nz2f0xBFonWBhcO0gBqzeCWMStPRRDAbPn8rvs15GOeMh7bwes
 N2cJk2MmY220bauODq7jlAe/1DwlCeW5qpIClzU3sXjQ6funhJvOqkHRJi3Rn7b3YLWe
 CwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499361; x=1783104161;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=berPH/TKVNYHF5lUYi0bNqIJRxg9lJU7fevz+SJjH6U=;
 b=aJ2fqUcHJJYJmQS3tnZRlNjL5zFcUQt7px8o3taxGhvH6qniwljlpEkC1YD//6x6xp
 gKyTVr5YX/LEFouWKzR3k+IpeOACU6ekBvVLqkwdx5FO1mhWbYTOg1zdIrisEVMGvZR3
 JP+/YDfRWpiEvuEYcvYJ2989aucup2TsWaFGJ5+QhI1DPHRndrKnCTWkzJ1vOeCQW+wf
 Q10/zaWddorAsouSoNDd8m3S8l2Fqbb1bK4CSWveumbTPya7kBubhj97WYNTNphbexzd
 POFmraNYzbxSt/ljOSgCRuDYDg0pS9wHExea6wV9y7cZt4DR68eC4yG6VfAHc1UgbPh+
 r2kQ==
X-Gm-Message-State: AOJu0YzzWbf+j0+6a036wsibf9VAFcIE4IPokApWoVr1deL/Y5FMvBZ1
 Sa7sm8M3bPvznaxKymRoaTCSjIYpJlcJpd2QVab/emWK55VkdLerrZa4KhWEYAXG+ier8IA5Li6
 SkKDyp50KYiZ0f9OnKi81Il/hEUcnVK9KUQmg1nfvlHAl9kN+uVXq4rcMbBwrtV4nC74ONsu52C
 S9oX+4GzR616VzfOdCkQ/r3H9DXbANF7FKpw==
X-Gm-Gg: AfdE7clUaeHGWiBKrSMTGD3FGf7exMYl7a4xbxnG0XssOJGTDAfskWm46SQWxSWy0+A
 DoAa2ZOTMMzBWhyPkjWIXuZ9mJ9ZhYLv4Bw6A6sYogucv2i6w99kaIKOSDjpmdoVh7s3uw5OwJw
 t5h7GabaEXT257YmhTb5u9X2sA3F9WWbutp8OXUWoVRpZ1feoKaUU1bQwKyc313eEq4ekhcEf+n
 fMFFAhGcH3y4sHYzaMBDvAyz7IQ5Sh6rFz+EeYaTO30l3CMIxWpdS0AUQ3k5ac6O1bw3t9Nb1HT
 wUEjkwpRpCC8nYjXpaCQZg7Vq/95TrWQA16QNzlLysmSPEHI8KWTF2pzBbGRrDBNPIIAsHsIUOt
 b4aE2H4Myb3y1m/KUak0TnENxWkTBIQB8E+Qo1KwEDtvT8fsDWiDm
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id
 ffacd0b85a97d-46dbf117b6fmr13190274f8f.6.1782499361331; 
 Fri, 26 Jun 2026 11:42:41 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id
 ffacd0b85a97d-46dbf117b6fmr13190209f8f.6.1782499360668; 
 Fri, 26 Jun 2026 11:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm4085984f8f.22.2026.06.26.11.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:42:40 -0700 (PDT)
Message-ID: <4a980fdc-e037-47fd-9522-a8fea261e6a6@redhat.com>
Date: Fri, 26 Jun 2026 20:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Merge .dma_map_file() into .dma_map()
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260608055758.359002-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260608055758.359002-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/8/26 07:57, Cédric Le Goater wrote:
> Simplify the VFIOIOMMUClass interface by removing the dma_map_file
> handler. Move the logic to decide between the standard virtual and
> file-backed mapping into the IOMMUFD backend, utilizing the
> MemoryRegion already passed to the dma_map handler.
> 
> This removes redundant dispatch logic from the generic container layer
> and let backends to manage their own mapping strategies. This is
> similar to the vfio-user implementation.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-container.h | 15 ----------
>   hw/vfio/container.c              | 38 ------------------------
>   hw/vfio/iommufd.c                | 50 +++++++++++++++++++++++---------
>   3 files changed, 37 insertions(+), 66 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index a7d5c5ed679a0338937ae02f37140d94720f6f11..c70828a0529cb2b41162a8bd452da1d9c20bc08f 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -172,21 +172,6 @@ struct VFIOIOMMUClass {
>       int (*dma_map)(const VFIOContainer *bcontainer,
>                      hwaddr iova, uint64_t size,
>                      void *vaddr, bool readonly, MemoryRegion *mr);
> -    /**
> -     * @dma_map_file
> -     *
> -     * Map a file range for the container.
> -     *
> -     * @bcontainer: #VFIOContainer to use for map
> -     * @iova: start address to map
> -     * @size: size of the range to map
> -     * @fd: descriptor of the file to map
> -     * @start: starting file offset of the range to map
> -     * @readonly: map read only if true
> -     */
> -    int (*dma_map_file)(const VFIOContainer *bcontainer,
> -                        hwaddr iova, uint64_t size,
> -                        int fd, unsigned long start, bool readonly);
>       /**
>        * @dma_unmap
>        *
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 56bd9ac0095df7b0f4da85f1d8dcb8d571fa9f2a..d09a6637324c6bf29b2fe22369082f87e280c98f 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -15,7 +15,6 @@
>   #include <linux/vfio.h>
>   
>   #include "system/tcg.h"
> -#include "system/ramblock.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/vfio/vfio-container.h"
> @@ -74,49 +73,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>       bcontainer->space = space;
>   }
>   
> -static bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer,
> -                                            MemoryRegion *mr, int *fd)
> -{
> -    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -    RAMBlock *rb = mr->ram_block;
> -
> -    if (!vioc->dma_map_file || !rb) {
> -        return false;
> -    }
> -
> -    *fd = qemu_ram_get_fd(rb);
> -    if (*fd < 0) {
> -        return false;
> -    }
> -
> -    /*
> -     * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
> -     *
> -     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
> -     * 2) RAM device sub-regions (MMIO BARs)
> -     *
> -     * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
> -     * they are subject to copy-on-write (COW) anomalies, their underlying
> -     * PFNs can permanently diverge from the backing file
> -     */
> -    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
> -}
> -
>   int vfio_container_dma_map(VFIOContainer *bcontainer,
>                              hwaddr iova, uint64_t size,
>                              void *vaddr, bool readonly, MemoryRegion *mr)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -    int mfd;
>   
> -    if (vfio_container_can_dma_map_file(bcontainer, mr, &mfd)) {
> -        RAMBlock *rb = mr->ram_block;
> -        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
> -        unsigned long offset = qemu_ram_get_fd_offset(rb);
> -
> -        return vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
> -                                  readonly);
> -    }
>       g_assert(vioc->dma_map);
>       return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
>   }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 68f2ae6f9f667bb05c20e452e8c5b43da6558098..6ff668d2597e07c6953cf0f1997514aec199642c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -20,6 +20,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "system/iommufd.h"
> +#include "system/ramblock.h"
>   #include "hw/core/iommu.h"
>   #include "hw/core/qdev.h"
>   #include "hw/vfio/vfio-cpr.h"
> @@ -35,26 +36,50 @@
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>   
> +static bool iommufd_cdev_can_map_file_dma(MemoryRegion *mr, int *fd)
> +{
> +    RAMBlock *rb = mr ? mr->ram_block : NULL;
> +
> +    if (!rb) {
> +        return false;
> +    }
> +
> +    *fd = qemu_ram_get_fd(rb);
> +    if (*fd < 0) {
> +        return false;
> +    }
> +
> +    /*
> +     * Use iommufd_backend_map_file_dma() (IOMMU_IOAS_MAP_FILE) for:
> +     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
> +     * 2) RAM device sub-regions (MMIO BARs)
> +     *
> +     * Private RAM mappings (MAP_PRIVATE) are excluded: copy-on-write
> +     * semantics can cause their underlying PFNs to permanently diverge
> +     * from the backing file.
> +     */
> +    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
> +}
> +
>   static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
>                               uint64_t size, void *vaddr, bool readonly,
>                               MemoryRegion *mr)
>   {
>       const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
> +    int fd;
>   
> -    return iommufd_backend_map_dma(container->be,
> -                                   container->ioas_id,
> -                                   iova, size, vaddr, readonly);
> -}
> +    if (iommufd_cdev_can_map_file_dma(mr, &fd)) {
> +        RAMBlock *rb = mr->ram_block;
> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
>   
> -static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
> -                                 hwaddr iova, uint64_t size,
> -                                 int fd, unsigned long start, bool readonly)
> -{
> -    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
> +        return iommufd_backend_map_file_dma(container->be, container->ioas_id,
> +                                            iova, size, fd,
> +                                            start + offset, readonly);
> +    }
>   
> -    return iommufd_backend_map_file_dma(container->be,
> -                                        container->ioas_id,
> -                                        iova, size, fd, start, readonly);
> +    return iommufd_backend_map_dma(container->be, container->ioas_id,
> +                                   iova, size, vaddr, readonly);
>   }
>   
>   static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
> @@ -929,7 +954,6 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>   
>       vioc->dma_map = iommufd_cdev_map;
> -    vioc->dma_map_file = iommufd_cdev_map_file;
>       vioc->dma_unmap = iommufd_cdev_unmap;
>       vioc->attach_device = iommufd_cdev_attach;
>       vioc->detach_device = iommufd_cdev_detach;


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


