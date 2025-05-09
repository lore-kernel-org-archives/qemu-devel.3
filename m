Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D14C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKsr-0005EE-Pn; Fri, 09 May 2025 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKsp-0005Dm-5c
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKsk-0003FI-FY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746786184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZAEPxr9kstj2+ZjrdreGcx6naC2WtAoG66RuSrRWLSA=;
 b=GcMsWTZ7lUiKpUkb7KxyufO2raClmNbkm14iczeBZo4Z+ghaKgg02wNYS6Cff6P2l3YKmu
 DNldNuaiMm2zDDfo0tf9TC8X9q7ZcQ7jvAMwkZr9d6eA+fJiije9kQgbkAeryAqaKHdIZA
 f42lOs7Bqu7EQ38vZYKH6o1PM8Mtxrs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-InNZOZx4MyenXfxpqhCjIw-1; Fri, 09 May 2025 06:23:03 -0400
X-MC-Unique: InNZOZx4MyenXfxpqhCjIw-1
X-Mimecast-MFC-AGG-ID: InNZOZx4MyenXfxpqhCjIw_1746786182
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f9ddf04bso280897f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746786182; x=1747390982;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAEPxr9kstj2+ZjrdreGcx6naC2WtAoG66RuSrRWLSA=;
 b=J6Y97n7p723DgQj8V2mzvZUqgtOvilcD1P1imbAujaBCvH5XY9Ox/nAt8VwuCFhZj0
 +lVhLg+FhpGFdoSmrIpprmKYhZWyxm1yHJMA5RCPs87FVj25xZq6def11eB0iatlUiju
 Sp7I+zNWGdhPCo4uConk0Jf3Gtu6UZvxd+bR0LRxyrNhEgjKrePjE4laCQljZ36cEAi5
 VwEr4SGiOrKg2J4tRjBPSolYIcveVMc6kV8VzgJuzaMb+Bu+KCL6w+FpcQKl7SUPb1Wd
 Cd43l0lsTmjML90FU4YDmLq8p9kB+LgttpWNpkelEv+l0sZt7dcihyJAg9WmhlXuzcS3
 J8Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSMpEZF0GqD9HbNTA1mHGnYRSnJg0pQjXUB6cBDpWsaUrwcqNEALN2Lcw154AFmnyEmXDGVCCVhI3@nongnu.org
X-Gm-Message-State: AOJu0YzzircTtSvoIYZDzvmXpSRpBg83tidNm34ZKkkJNwx9MOuGNxhr
 P1lzvJpuFsiHQLvuE3HQPFivedHl9EFrPq/g/XfWHFPtAGaOVqHj03x9lNsBY6UNwO4Zrwkf20+
 Np+XYCEC6n12S9ZrSTcf/r3QaOIlo1k59nxeJ/e96JaqY/+lnXZ6y
X-Gm-Gg: ASbGncs6CapS6tmlta+Fn4+2xFjEaQiQYVMP9f6kMGUf+6JcfuHIrlo42QtKV0kNmpN
 JGFNxZJNH4pF/zfM1Qwq/bGZ2oyN2cbKFeuN/zhLMiqYvVwaKCItZkVOg0kxILsbmtuknc2xf66
 5pFbyWmR/SRtJ97uWLxRkX66hBqJKnmONhkRb6rl22Y4A69DPsK26w3ogT7cemO3dhu4NfenPnf
 aih6ZsgYa2D5lmNzkP3jPkIPUJQxe11TE4OHBmqvrpVdslMqYX4lwnPFoFo3dXLhJaSknIknrW5
 0JmCsAhR/GT/GuFszXUl0CjlQkpW0OXK3P3drbreMF21NCq76bs9//U=
X-Received: by 2002:adf:f687:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a1fa6c4838mr882308f8f.35.1746786182058; 
 Fri, 09 May 2025 03:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEDU6wuaggfrm8umWU4ME3XDpyz7FpPpgOlA15hvAH+rAaNhdAzrBwRmlFEQuhkcJqGZ+u9g==
X-Received: by 2002:adf:f687:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a1fa6c4838mr882291f8f.35.1746786181620; 
 Fri, 09 May 2025 03:23:01 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a5a2e0sm2756761f8f.101.2025.05.09.03.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:23:00 -0700 (PDT)
Message-ID: <21444f2f-6666-40b6-9f0d-9a15efff99a8@redhat.com>
Date: Fri, 9 May 2025 12:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] vfio/container: pass MemoryRegion to DMA
 operations
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-16-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250507152020.1254632-16-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John,

On 5/7/25 17:20, John Levon wrote:
> Pass through the MemoryRegion to DMA operation handlers of vfio
> containers. The vfio-user container will need this later.

It think the subject and commit log does not reflect the important
part, which is to add a extend the memory_get_xlat_addr() parameters
with a 'MemoryRegion **' parameter for vfio-user usage (and why).

Could you please rephrase and resend as a standalone patch putting
in Cc: the system/memory maintainers, virtio and vfio ?


Thanks,

C.




> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-container-base.h |  4 ++--
>   include/system/memory.h               |  4 +++-
>   hw/vfio/container-base.c              |  4 ++--
>   hw/vfio/container.c                   |  3 ++-
>   hw/vfio/iommufd.c                     |  3 ++-
>   hw/vfio/listener.c                    | 18 +++++++++++-------
>   hw/virtio/vhost-vdpa.c                |  2 +-
>   system/memory.c                       |  7 ++++++-
>   8 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3d392b0fd8..359b483963 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, bool readonly, MemoryRegion *mrp);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb, bool unmap_all);
> @@ -121,7 +121,7 @@ struct VFIOIOMMUClass {
>       void (*listener_commit)(VFIOContainerBase *bcontainer);
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> +                   void *vaddr, bool readonly, MemoryRegion *mrp);
>       /**
>        * @dma_unmap
>        *
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fbbf4cf911..eca1d9f32e 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -746,13 +746,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
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
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 1c6ca94b60..a677bb6694 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
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
> index a9f0dbaec4..98d6b9f90c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
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
> index af1c7ab10a..a2518c4a5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -34,7 +34,8 @@
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            ram_addr_t size, void *vaddr, bool readonly,
> +                            MemoryRegion *mrp)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index bfacb3d8d9..71f336a31c 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -93,12 +93,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
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
> @@ -126,6 +126,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mrp;
>       void *vaddr;
>       int ret;
>       Error *local_err = NULL;
> @@ -150,7 +151,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
> +                                &local_err)) {
>               error_report_err(local_err);
>               goto out;
>           }
> @@ -163,7 +165,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>            */
>           ret = vfio_container_dma_map(bcontainer, iova,
>                                        iotlb->addr_mask + 1, vaddr,
> -                                     read_only);
> +                                     read_only, mrp);
>           if (ret) {
>               error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -233,7 +235,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
>           ret = vfio_container_dma_map(bcontainer, iova, next - start,
> -                                     vaddr, section->readonly);
> +                                     vaddr, section->readonly, section->mr);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -557,7 +559,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>       }
>   
>       ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
> -                                 vaddr, section->readonly);
> +                                 vaddr, section->readonly, section->mr);
>       if (ret) {
>           error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -1021,7 +1023,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
> +                            &local_err)) {
> +        error_report_err(local_err);
>           goto out_unlock;
>       }
>   
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 1ab2c11fa8..4c4b3d1371 100644
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
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..79671943ce 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2176,7 +2176,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   /* Called with rcu_read_lock held.  */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +                          bool *mr_has_discard_manager, MemoryRegion **mrp,
> +                          Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2241,6 +2242,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
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


