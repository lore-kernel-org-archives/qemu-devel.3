Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139FC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umB0c-0005OV-EM; Wed, 13 Aug 2025 08:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1umB0X-0005MH-GL
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1umB0S-000270-LA
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755089700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6KH7D7BS6cfbcjbpLocRz9dUcyj/ezFWvsG5tv4hFoM=;
 b=Ziy0i+RLvZQA4f7pzv+SrfUtHuU/NwE6iwRJGmsrCXoqHGTDfxItB7n/ovsTifng5NdI6c
 fhWq5dGQqFxvKCSyTd3Z52jR1m8jvBjhuz441+hO/HZdPDZJnhJDb83nIplGuP9SvQ0vJF
 srxvv3F3M5nAZXbiqrlBOoF3fwWXsqU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-I2bQ9ViHO1u33NpB1BO0ow-1; Wed, 13 Aug 2025 08:54:59 -0400
X-MC-Unique: I2bQ9ViHO1u33NpB1BO0ow-1
X-Mimecast-MFC-AGG-ID: I2bQ9ViHO1u33NpB1BO0ow_1755089698
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b90ab438b9so1280496f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755089698; x=1755694498;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KH7D7BS6cfbcjbpLocRz9dUcyj/ezFWvsG5tv4hFoM=;
 b=xBC1JuJEN4KB6AWjysihV4TyilXJgVzD4gajXa6EsPqlnCPplK7XLhthh9NCPR7yBl
 VaEF20VX+ttwv5seGjQ91IPQTIEW3MLoSO6QZlGhtSUAxSY6JKdJOj4v2X5JFmccRcav
 axwQ7F+p/OfPvc8AnrlPtX0DnwXQyrrjJ7P4S5meayoN9dLB7iHpemu072LyQ4Gh9zPg
 a3MXiF9HdSsegxadylg0mHHPeZzC0VAKXf2Oz0ZbkxouPX4K17pScwBrVhzR7c3YeGGv
 XIdSYiE1wUOhG3aIOHNBwzLSYCYXmpkay6tFnBfgQ8bKR/m+B9Ob4jbdc2+qkp3Jkahm
 cy7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlaHARM0qzfIcfruwscM9uS+IAV9gqASOQ2PdchFTLfwfwdk8v/K7gVkhaIQZ7SUq2frYLOhCTPp1G@nongnu.org
X-Gm-Message-State: AOJu0Yyn0SrUiFWbdrvD8Ks8tGRvsOrSkHBnOilSHIRFnBWWIU91GAvN
 FP0J0JLBuEohPFR2u2WTfp8awny+v2Ab/cr6brwTAVRUgjr8TYXpwh3lBnCL87lTmYiCczoH+Vv
 Ja4K3VJTFSYIsA89H6rHw53uEOCkegWw2qk+BVWPnprIDVgowdr4nDv+J
X-Gm-Gg: ASbGnctSQb4dM37DVMneugZbQoC6pAJgjZA8ZAQbi20BrT1Xya5HP/zTiDyrptfbnzU
 5vWW6ZyCHPaKz7N06sYVVXPE9rCiFXJOlAjcvZsjB50Iz4+3RND5QEJdATaajALLlRpmHVqOwFV
 /RRFUb+MIauR4Hlo1rmOjrs/Enipbgv4vEWCH4yHYI9gyeGOMnWRMKIdkrXReMHj811aWUMLwM+
 Ba6HvnxDqTNDI/BbU7CET64TMSTiSJfDoPsq4EbVKvNWdZnw/4T8rXDTWLFYQnOX9uOfnkb3tn4
 rYuxKnfYguAKY0tRuHaat6VJJG3jw7zRUkOQizEjCqyVXI/HChvQuskHT0uoksQj4FFECtxF4Bf
 13g==
X-Received: by 2002:a05:6000:2a0b:b0:3b9:1d32:cf63 with SMTP id
 ffacd0b85a97d-3b91d32dd06mr504641f8f.8.1755089697764; 
 Wed, 13 Aug 2025 05:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQwW7GINMfRqZkBmZYOtr1NWEpgpuQIaXbJTm26RAqhGe1gnSQWEFtc1aDDdVh+flaw3lQog==
X-Received: by 2002:a05:6000:2a0b:b0:3b9:1d32:cf63 with SMTP id
 ffacd0b85a97d-3b91d32dd06mr504613f8f.8.1755089697262; 
 Wed, 13 Aug 2025 05:54:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm37812136f8f.31.2025.08.13.05.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 05:54:56 -0700 (PDT)
Message-ID: <9d709d91-1567-456a-83ae-b80f165da9a9@redhat.com>
Date: Wed, 13 Aug 2025 14:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 08/38] vfio/container: recover from unmap-all-vaddr
 failure
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-9-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1749569991-25171-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Steve,

On 6/10/25 17:39, Steve Sistare wrote:
> If there are multiple containers and unmap-all fails for some container, we
> need to remap vaddr for the other containers for which unmap-all succeeded.
> Recover by walking all address ranges of all containers to restore the vaddr
> for each.  Do so by invoking the vfio listener callback, and passing a new
> "remap" flag that tells it to restore a mapping without re-allocating new
> userland data structures.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-container-base.h |  3 ++
>   include/hw/vfio/vfio-cpr.h            | 10 ++++
>   hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
>   hw/vfio/listener.c                    | 19 +++++++-
>   4 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 9d37f86..f023265 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -256,4 +256,7 @@ struct VFIOIOMMUClass {
>   VFIORamDiscardListener *vfio_find_ram_discard_listener(
>       VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section, bool cpr_remap);
> +
>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index b83dd42..56ede04 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -10,6 +10,7 @@
>   #define HW_VFIO_VFIO_CPR_H
>   
>   #include "migration/misc.h"
> +#include "system/memory.h"
>   
>   struct VFIOContainer;
>   struct VFIOContainerBase;
> @@ -17,6 +18,9 @@ struct VFIOGroup;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> +    bool vaddr_unmapped;
> +    NotifierWithReturn transfer_notifier;
> +    MemoryListener remap_listener;
>       int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
>                            hwaddr iova, ram_addr_t size,
>                            void *vaddr, bool readonly, MemoryRegion *mr);
> @@ -42,4 +46,10 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
>   bool vfio_cpr_container_match(struct VFIOContainer *container,
>                                 struct VFIOGroup *group, int fd);
>   
> +void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
> +                           MemoryRegionSection *section);
> +
> +bool vfio_cpr_ram_discard_register_listener(
> +    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 2fd8348..a84c324 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -29,6 +29,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>           error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>           return false;
>       }
> +    container->cpr.vaddr_unmapped = true;
>       return true;
>   }
>   
> @@ -59,6 +60,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> +static void vfio_region_remap(MemoryListener *listener,
> +                              MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer,
> +                                            cpr.remap_listener);
> +    vfio_container_region_add(&container->bcontainer, section, true);
> +}
> +
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> @@ -120,6 +129,40 @@ static const VMStateDescription vfio_container_vmstate = {
>       }
>   };
>   
> +static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
> +                                  MigrationEvent *e, Error **errp)
> +{
> +    VFIOContainer *container =
> +        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
> +        return 0;
> +    }
> +
> +    if (container->cpr.vaddr_unmapped) {
> +        /*
> +         * Force a call to vfio_region_remap for each mapped section by
> +         * temporarily registering a listener, and temporarily diverting
> +         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
> +         */
> +
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
> +
> +        container->cpr.remap_listener = (MemoryListener) {
> +            .name = "vfio cpr recover",
> +            .region_add = vfio_region_remap
> +        };
> +        memory_listener_register(&container->cpr.remap_listener,
> +                                 bcontainer->space->as);
> +        memory_listener_unregister(&container->cpr.remap_listener);
> +        container->cpr.vaddr_unmapped = false;
> +        vioc->dma_map = container->cpr.saved_dma_map;
> +    }
> +    return 0;
> +}
> +
>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -142,6 +185,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>           container->cpr.saved_dma_map = vioc->dma_map;
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>       }
> +
> +    migration_add_notifier_mode(&container->cpr.transfer_notifier,
> +                                vfio_cpr_fail_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
>       return true;
>   }
>   
> @@ -152,6 +199,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>       migrate_del_blocker(&container->cpr.blocker);
>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +    migration_remove_notifier(&container->cpr.transfer_notifier);
> +}
> +
> +/*
> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
> + * succeeding for others, so the latter have lost their vaddr.  Call this
> + * to restore vaddr for a section with a giommu.
> + *
> + * The giommu already exists.  Find it and replay it, which calls
> + * vfio_legacy_cpr_dma_map further down the stack.
> + */
> +void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
> +                           MemoryRegionSection *section)
> +{
> +    VFIOGuestIOMMU *giommu = NULL;
> +    hwaddr as_offset = section->offset_within_address_space;
> +    hwaddr iommu_offset = as_offset - section->offset_within_region;
> +
> +    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
> +        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
> +            giommu->iommu_offset == iommu_offset) {
> +            break;
> +        }
> +    }
> +    g_assert(giommu);
> +    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
> +}
> +
> +/*
> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
> + * succeeding for others, so the latter have lost their vaddr.  Call this
> + * to restore vaddr for a section with a RamDiscardManager.
> + *
> + * The ram discard listener already exists.  Call its populate function
> + * directly, which calls vfio_legacy_cpr_dma_map.
> + */
> +bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> +                                            MemoryRegionSection *section)
> +{
> +    VFIORamDiscardListener *vrdl =
> +        vfio_find_ram_discard_listener(bcontainer, section);
> +
> +    g_assert(vrdl);
> +    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
>   }
>   
>   int vfio_cpr_group_get_device_fd(int d, const char *name)
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 203ed03..2e57986 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -481,6 +481,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> +    vfio_container_region_add(bcontainer, section, false);
> +}
> +
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section,
> +                               bool cpr_remap)
> +{
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -516,6 +523,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           int iommu_idx;
>   
>           trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
> +
> +        if (cpr_remap) {
> +            vfio_cpr_giommu_remap(bcontainer, section);
> +        }
> +
>           /*
>            * FIXME: For VFIO iommu types which have KVM acceleration to
>            * avoid bouncing all map/unmaps through qemu this way, this
> @@ -558,7 +570,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>        * about changes.
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_ram_discard_register_listener(bcontainer, section);
> +        if (!cpr_remap) {
> +            vfio_ram_discard_register_listener(bcontainer, section);
> +        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
> +                                                           section)) {
> +            goto fail;

vfio_cpr_ram_discard_register_listener() can fail without setting
an 'Error *' variable. I don't think this will generate a QEMU crash
(we are in the !bcontainer->initialized case) but it would be better
addressed if &err was set.


Thanks,

C.


