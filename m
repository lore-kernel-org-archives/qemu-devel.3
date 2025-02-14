Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD61C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiys9-0003yn-EA; Fri, 14 Feb 2025 11:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiys7-0003yN-Bs
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiys4-0004qk-9Z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739551734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mGVllckroo7rM7NYtqXLiiVLkAvmo5PwYA8r4ryeOg=;
 b=eR+oyQ9jw4nZ5p20T2YyYMD4+aavXSttgjLv6RGazYx/G1vS0nZ/gnwftWFX+A+/MHuvgw
 evg97KoAKLTtPj73HX+XIYE7OQbyap5L4YkRAK9T9+HgOeM8hBmWVIaxtdQ4mnGJTpB4Ya
 waaYF3jymY3O7pV8ZJ/LHjn1cdtkPgg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-wNMyjE_gOWWX1lFoLYiR2Q-1; Fri, 14 Feb 2025 11:48:52 -0500
X-MC-Unique: wNMyjE_gOWWX1lFoLYiR2Q-1
X-Mimecast-MFC-AGG-ID: wNMyjE_gOWWX1lFoLYiR2Q_1739551732
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-471d2e94d0eso8605481cf.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551732; x=1740156532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mGVllckroo7rM7NYtqXLiiVLkAvmo5PwYA8r4ryeOg=;
 b=wA1Hz9xVo72AEDSDIj8OPSNvKEPSYKRDWy5KoF4mpIsy4tWvMOX9yY2CpWQnQju0n2
 LhAJRIzWcz5Exo28IE7VNj7rKb+wR/nU0N9jZmjJ2PLqJ8ig3GAguPBIrXnPLCQ2SQY0
 KGiyz0dJx0zJN0zevvWjw/vIrMHTCLBgdJZuC9f4WcoZefcmQNUs2dhNFkVINtfOzDc8
 WqdasKubPyJeSgSutnV0/t9X0wrDAjP9j8K38Mm2qWjFwEB3ejXtJfyiiEMAO2QE69GQ
 FJ2zQqW321dXtluTv8wVOF2eMeWzAxteGt1jpGLRxdyK2IxQDVr0vZ5XmoLpO3ESKfC9
 /5OA==
X-Gm-Message-State: AOJu0YzvTMEn8bPbyMi9+Y8IwF71U0EjohxcXWvlnteBgxAMjknY9C0T
 Mu6UGdboaVZ1OAq4rS8sgtfgBxfDAY9/+68fn0yuwERSUs0vj4z4FDI8ndc4bK6iCUnm+GXt8RN
 9BsHycZJap58y0HUDbiGhDI7C7W2leM0iXQ1qdQviSdPnFMmtxqnF
X-Gm-Gg: ASbGncuHbfVY0sITPrmDZWAF5B19uFfPOGwCLJXEwFnY99vb8vKDWds4uTDQoBBLugQ
 ylDMuMsw0WCX9wzgPPkqGbVQXu8OWz85WaI3EplGcTLRRUif+gSHUevzdog4ImqAm0xln3/tbL9
 cLSLuTBl0VbrfwRxeNoPQRVbYPUwzd8ADR7+2DpS6FUqF8bmx5ykr6HOo1Nl091u0LDsQ4+8y2H
 VayU+pd/t4PEBxKHLlsMW407XE+OQ9elESuxUx+avE8F+LhcwLXJlKmUTU=
X-Received: by 2002:a05:622a:6f15:b0:471:d41f:c636 with SMTP id
 d75a77b69052e-471d41fc71cmr20275631cf.34.1739551731830; 
 Fri, 14 Feb 2025 08:48:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjBSI7QOL5x/XwCJ2o0ybMZS1MyVkSv7Y9L8CCcfS9uIInP21EZG5664nDDdbcZdHCuiJSwQ==
X-Received: by 2002:a05:622a:6f15:b0:471:d41f:c636 with SMTP id
 d75a77b69052e-471d41fc71cmr20275351cf.34.1739551731440; 
 Fri, 14 Feb 2025 08:48:51 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c29e97f1sm19533541cf.14.2025.02.14.08.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:48:50 -0800 (PST)
Date: Fri, 14 Feb 2025 11:48:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
Message-ID: <Z69z6oTtaGOC287O@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

On Fri, Feb 14, 2025 at 06:14:10AM -0800, Steve Sistare wrote:
> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/vfio/common.c       | 21 ++++++++++++++-------
>  hw/virtio/vhost-vdpa.c |  8 ++++++--
>  include/exec/memory.h  |  6 +++---
>  system/memory.c        | 19 ++++---------------
>  4 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index c536698..3b0c520 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -246,14 +246,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  }
>  
>  /* Called with rcu_read_lock held.  */
> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> -                               Error **errp)
> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
> +                               hwaddr *xlat_p, Error **errp)
>  {
>      bool ret, mr_has_discard_manager;
>  
> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> +    ret = memory_get_xlat_addr(iotlb, &mr_has_discard_manager, mr_p, xlat_p,
> +                               errp);
>      if (ret && mr_has_discard_manager) {
>          /*
>           * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -281,6 +280,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>      VFIOContainerBase *bcontainer = giommu->bcontainer;
>      hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>      void *vaddr;
>      int ret;
>      Error *local_err = NULL;
> @@ -300,10 +301,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>          bool read_only;
>  
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>              error_report_err(local_err);
>              goto out;
>          }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>          /*
>           * vaddr is only valid until rcu_read_unlock(). But after
>           * vfio_dma_map has set up the mapping the pages will be
> @@ -1259,6 +1263,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      ram_addr_t translated_addr;
>      Error *local_err = NULL;
>      int ret = -EINVAL;
> +    MemoryRegion *mr;
> +    ram_addr_t xlat;
>  
>      trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>  
> @@ -1269,10 +1275,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>          error_report_err(local_err);
>          goto out_unlock;
>      }
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>  
>      ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                  translated_addr, &local_err);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12..5dfe51e 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      int ret;
>      Int128 llend;
>      Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>  
>      if (iotlb->target_as != &address_space_memory) {
>          error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>          bool read_only;
>  
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> -                                  &local_err)) {
> +        if (!memory_get_xlat_addr(iotlb, NULL, &mr, &xlat, &local_err)) {
>              error_report_err(local_err);
>              return;
>          }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>          ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                                   iotlb->addr_mask + 1, vaddr, read_only);
>          if (ret) {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ea5d33a..8590838 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -747,13 +747,13 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   * @read_only: indicates if writes are allowed
>   * @mr_has_discard_manager: indicates memory is controlled by a
>   *                          RamDiscardManager

(some prior fields are prone to removal))

> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
>   * Return: true on success, else false setting @errp with error.
>   */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp);
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>  typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/system/memory.c b/system/memory.c
> index 4c82979..755eafe 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2183,9 +2183,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>  }
>  
>  /* Called with rcu_read_lock held.  */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp)

If we're going to return the MR anyway, probably we can drop
mr_has_discard_manager altogether..

>  {
>      MemoryRegion *mr;
>      hwaddr xlat;
> @@ -2238,18 +2237,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>          return false;
>      }
>  
> -    if (vaddr) {
> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    }
> -
> -    if (ram_addr) {
> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> -    }
> -
> -    if (read_only) {
> -        *read_only = !writable || mr->readonly;
> -    }
> -
> +    *xlat_p = xlat;
> +    *mr_p = mr;

I suppose current use on the callers are still under RCU so looks ok, but
that'll need to be rich-documented.

Better way is always taking a MR reference when the MR pointer is returned,
with memory_region_ref().  Then it is even valid if by accident accessed
after rcu_read_unlock(), and caller should unref() after use.

>      return true;
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


