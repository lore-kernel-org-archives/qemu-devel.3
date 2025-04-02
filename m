Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8371C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u01Cj-0005BX-Oq; Wed, 02 Apr 2025 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Cf-0005Aj-GC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u01Cd-0002SK-8t
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743612273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T2/hlcU2C3UxAnnSfJ4viCnotDCjjHqB4xClPfD44QQ=;
 b=hS+sKjg0NNtFOppLKZseo1MYwgkHWBTcGFeXjRKxBMoHxA+HlIoecADulPu/2DN1vmLDBG
 H8YTR/w2KTzXswcfhdcpqfVybtyv2IhgxQMymumkshO8Qs6yq8uWQDUHFyb/4wndqpoxMc
 ERpPMdVZ2I3GVdzWINKZ/wWozwdr3b4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-821RVPcSOpuDzyNO6VLDNA-1; Wed, 02 Apr 2025 12:44:32 -0400
X-MC-Unique: 821RVPcSOpuDzyNO6VLDNA-1
X-Mimecast-MFC-AGG-ID: 821RVPcSOpuDzyNO6VLDNA_1743612271
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391425471d6so6402f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743612271; x=1744217071;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2/hlcU2C3UxAnnSfJ4viCnotDCjjHqB4xClPfD44QQ=;
 b=U0P2sIyJYMXkcMVgbLDd45LNq8ADPZQmloKhgQclUxUBZtlY8lsbxNwGrTn8nQnuRa
 WkSMNdo26uq0fjnIBdBmjyV6nc5O7xI8KDus5LP7mfIRSPBvRXN+/M7DpyQD39NpySPw
 yKql9AW7mYZnPEoLsrxzbZ1N4YR5Qy3otLVK1OxAD/uYdQ2dfCNyJoQ6/FS7ren08aix
 3jqjqCSBoOJT2haSIze2nU+BEhRZeLDAHQduxIl2oman7U9qjoCAuSglbDsNUrlQ+3PR
 OV53uiFsAO1TwYYMnbGWUklVDuu9F9ld/DIRJVKmV9kmQOeQS16FFpEP/RXQp9o7B9e7
 b9tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRl5Qp07EexfBbfvE6X9Qrwr36qDZxJzaZdIWTH37bzcmpxd6DqaBm8k0iMlpsjkIGVolNwg7Frf19@nongnu.org
X-Gm-Message-State: AOJu0Yz8qERIwdiPPq439/3a44f3vKL092/WR2zpPRRMSAV/eMjpELC1
 2kA88QDYKHn3v08H9djXuLASaUMDawT2VgOkmz0XBjr7yu29R9fzqsNP++/QyFQWBdXK6JfGXWK
 +gO06cCLlNXd7oTEtgs26ZGEUbCtmoOaZq00OpCGLFHZAPDbIt9T8
X-Gm-Gg: ASbGncsxU+i5V9ipIFckjGdGekLGkWuh9LxaoNZJrYCEz+9cxoD8Oj0EAI74CUn5yOD
 O8AYtuYilnTZDLM6/rWyvTT9gBcteB5KomEUN9565+gWSZ5GmQliBCuEgHyoJGZI1XGmowqOwb6
 9HVPZ8OyQF08lD+rGhH9BjbiNwvSw3kkHar7v4MqruLF8+VdWuVbBPv7N8iCvBhk/yqk8Zi5QqI
 KCMF3nnr6/FfC4Xf5yE4dvHluEHpX/atrkn0JXnGgLdZi94TaHlfmo7INTkabl3e7Vb1+27lBeN
 yHssGwCmDb3bopwrEpzXL4P2rcd7IoEzTdVPYy/gM2Lk0JQzSPWTAg==
X-Received: by 2002:a05:6000:43ca:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-39c120e0ac0mr10284128f8f.31.1743612271110; 
 Wed, 02 Apr 2025 09:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmmDBxfCQN9lXC/13sD+6JaQHoe6JJPsNGx384UCUji9oZQTAoiNxsZAuGxZRv2exo2hMoyg==
X-Received: by 2002:a05:6000:43ca:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-39c120e0ac0mr10284117f8f.31.1743612270700; 
 Wed, 02 Apr 2025 09:44:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4482sm17075608f8f.86.2025.04.02.09.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 09:44:30 -0700 (PDT)
Message-ID: <4f472a77-7085-4b7b-90ac-392314f3ef52@redhat.com>
Date: Wed, 2 Apr 2025 18:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/28] vfio/container: pass MemoryRegion to DMA
 operations
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
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-2-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-2-john.levon@nutanix.com>
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
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> Pass through the MemoryRegion to DMA operation handlers of vfio
> containers. The vfio-user container will need this later.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>

FYI, in case you didn't see the discussion here :

https://lore.kernel.org/qemu-devel/1739542467-226739-29-git-send-email-steven.sistare@oracle.com/


Thanks,

C.



> ---
>   hw/vfio/common.c                      | 17 ++++++++++-------
>   hw/vfio/container-base.c              |  4 ++--
>   hw/vfio/container.c                   |  3 ++-
>   hw/vfio/iommufd.c                     |  3 ++-
>   hw/virtio/vhost-vdpa.c                |  2 +-
>   include/exec/memory.h                 |  4 +++-
>   include/hw/vfio/vfio-container-base.h |  4 ++--
>   system/memory.c                       |  7 ++++++-
>   8 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index abbdc56b6d..8d3d425c63 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -248,12 +248,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>   /* Called with rcu_read_lock held.  */
>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                                  ram_addr_t *ram_addr, bool *read_only,
> -                               Error **errp)
> +                               MemoryRegion **mrp, Error **errp)
>   {
>       bool ret, mr_has_discard_manager;
>   
>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> +                               &mr_has_discard_manager, mrp, errp);
>       if (ret && mr_has_discard_manager) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -281,6 +281,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mrp;
>       void *vaddr;
>       int ret;
>       Error *local_err = NULL;
> @@ -300,7 +301,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
> +                                &local_err)) {
>               error_report_err(local_err);
>               goto out;
>           }
> @@ -313,7 +315,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>            */
>           ret = vfio_container_dma_map(bcontainer, iova,
>                                        iotlb->addr_mask + 1, vaddr,
> -                                     read_only);
> +                                     read_only, mrp);
>           if (ret) {
>               error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -378,7 +380,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
>           ret = vfio_container_dma_map(bcontainer, iova, next - start,
> -                                     vaddr, section->readonly);
> +                                     vaddr, section->readonly, section->mr);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -675,7 +677,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>       }
>   
>       ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
> -                                 vaddr, section->readonly);
> +                                 vaddr, section->readonly, section->mr);
>       if (ret) {
>           error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -1232,7 +1234,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
> +                            &local_err)) {
>           error_report_err(local_err);
>           goto out_unlock;
>       }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 749a3fd29d..5e0c9700d9 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -17,12 +17,12 @@
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly)
> +                           void *vaddr, bool readonly, MemoryRegion *mrp)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       g_assert(vioc->dma_map);
> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
> +    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
>   }
>   
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7c57bdd27b..0db0055f39 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -175,7 +175,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>   }
>   
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool readonly)
> +                               ram_addr_t size, void *vaddr, bool readonly,
> +                               MemoryRegion *mrp)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df61edffc0..583b063707 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -28,7 +28,8 @@
>   #include "exec/ram_addr.h"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            ram_addr_t size, void *vaddr, bool readonly,
> +                            MemoryRegion *mrp)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..a1866bb396 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
>                                     &local_err)) {
>               error_report_err(local_err);
>               return;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9f73b59867..adaf1d1ca4 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -747,13 +747,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>    * @read_only: indicates if writes are allowed
>    * @mr_has_discard_manager: indicates memory is controlled by a
>    *                          RamDiscardManager
> + * @mrp: if non-NULL, fill in with MemoryRegion
>    * @errp: pointer to Error*, to store an error if it happens.
>    *
>    * Return: true on success, else false setting @errp with error.
>    */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +                          bool *mr_has_discard_manager, MemoryRegion **mrp,
> +                          Error **errp);
>   
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 4cff9943ab..c9d339383e 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, bool readonly, MemoryRegion *mrp);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
> @@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> +                   void *vaddr, bool readonly, MemoryRegion *mrp);
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
>                        IOMMUTLBEntry *iotlb);
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0..de4f955a66 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2185,7 +2185,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   /* Called with rcu_read_lock held.  */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +                          bool *mr_has_discard_manager, MemoryRegion **mrp,
> +                          Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2250,6 +2251,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>           *read_only = !writable || mr->readonly;
>       }
>   
> +    if (mrp != NULL) {
> +        *mrp = mr;
> +    }
> +
>       return true;
>   }
>   


