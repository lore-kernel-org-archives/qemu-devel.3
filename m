Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957CBC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9ye-00056D-AJ; Thu, 07 Mar 2024 04:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9yc-000562-7H
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9ya-0005FW-6L
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709803422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vl22hqxItbeweZssfysbZOJUEhUg6dAIqZ0k4psyFCU=;
 b=goMBhSeim8jJcOC+Y3CYe0bz7EcdKjKPyBZX1fzbWjGmXnlL3e7i2wgNXJm+5h1Gc5Uhg/
 DxzVDPYqXQXxzhN+d21QZx76+uh2BuRjQKSWr2xBRHM5SOILRJSU4bKcn374N+V0CITP/y
 kFZtTW5F1Oh2zehFMOKw0GdrBA6FAe8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-GPkjO0QBOdCFTeET2OY4_g-1; Thu, 07 Mar 2024 04:23:40 -0500
X-MC-Unique: GPkjO0QBOdCFTeET2OY4_g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d7fcb70c2so778897f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803419; x=1710408219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vl22hqxItbeweZssfysbZOJUEhUg6dAIqZ0k4psyFCU=;
 b=lL6TgmbhgfGwCz28PyfZLFTZs5rD606J02kXNLkkxP5cM9UNlvJ1/V3jeUVZXYPJF+
 SLg+10FTdajscUyNqxrvqSfCiIPrBnZ9CfQ3C/l3yI+bxlGFLjdm6rS92BOYCspU1ymx
 pl4A9Jelkxo894PmD+ZfAB+S7Ycv30VQP0m03xnw7gJ9vYCltbHtyttByTmj5Wf5mfY3
 o3anfV1Slwm0Li+ICPHmTQOP+UZ8NjcRM1olPd7YD9YBbmUCwNxr/KBBeTvrHfZadiPb
 YLPQCj0IkfaoNDk4QTeVthsAatRasya6ir6bixy20ufQW9GbMOW889mNk/n/pEGiZ7Vc
 uEBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOhErwdJg0zTERfbJP/EY8gLXW52AoMrAyqn7kAY8OZmrBJFKbrdg0pXPwJoFVVFL3bVnmYAYLUwFHzXZol9krtCNOMmo=
X-Gm-Message-State: AOJu0YywZvtntJlLWXtptf8BVHUMEdnLUed2/9QQDJMv+AP62MmFhmAT
 0M1lDxxxcAzmMBX9UEHq60zMUK2e5Nz8G5TCJGZAng0iyU7F6dvUHRCqInSqQ7X/PgGiIpE0/ZE
 abXfa+qIt/LM9FKqIK1GdwZmO+ajX1f6U40mOOFOjds2PT+dlL9rU
X-Received: by 2002:adf:ab03:0:b0:33e:bdf:a7e6 with SMTP id
 q3-20020adfab03000000b0033e0bdfa7e6mr807716wrc.25.1709803419107; 
 Thu, 07 Mar 2024 01:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIMjw14wS0WVyacBPndTNAZkML3H8Q+wdjatOohJN+BgzOpV9jEQCNb7FNzHOH5+LEwELGFA==
X-Received: by 2002:adf:ab03:0:b0:33e:bdf:a7e6 with SMTP id
 q3-20020adfab03000000b0033e0bdfa7e6mr807686wrc.25.1709803418683; 
 Thu, 07 Mar 2024 01:23:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfb648000000b0033e0ed396bdsm19659074wre.106.2024.03.07.01.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:23:38 -0800 (PST)
Message-ID: <91e409f4-19b0-4154-8e0a-6996df8d88e7@redhat.com>
Date: Thu, 7 Mar 2024 10:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/25] vfio: Add Error** argument to
 .get_dirty_bitmap() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-24-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-24-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/6/24 14:34, Cédric Le Goater wrote:
> Let the callers do the error reporting. Add documentation while at it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h         |  4 +-
>  include/hw/vfio/vfio-container-base.h | 17 +++++++-
>  hw/vfio/common.c                      | 59 ++++++++++++++++++---------
>  hw/vfio/container-base.c              |  5 ++-
>  hw/vfio/container.c                   | 13 +++---
>  5 files changed, 67 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 46f88493634b5634a9c14a5caa33a463fbf2c50d..68911d36676667352e94a97895828aff4b194b57 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,9 +274,9 @@ bool
>  vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                      VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size);
> +                                    hwaddr size, Error **errp);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr);
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
>  /* Returns 0 on success, or a negative errno. */
>  int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index c76984654a596e3016a8cf833e10143eb872e102..ebc49ebfbe7de862450941b1129faad5d62b3769 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -85,7 +85,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp);
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                        VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size);
> +                                      hwaddr iova, hwaddr size, Error **errp);
>  
>  void vfio_container_init(VFIOContainerBase *bcontainer,
>                           VFIOAddressSpace *space,
> @@ -138,9 +138,22 @@ struct VFIOIOMMUClass {
>       */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                     bool start, Error **errp);
> +    /**
> +     * @query_dirty_bitmap
> +     *
> +     * Get list of dirty pages from container
> +     *
> +     * @bcontainer: #VFIOContainerBase from which to get dirty pages
> +     * @vbmap: #VFIOBitmap internal bitmap structure
> +     * @iova: iova base address
> +     * @size: size of iova range
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                VFIOBitmap *vbmap,
> -                              hwaddr iova, hwaddr size);
> +                              hwaddr iova, hwaddr size, Error **errp);
>      /* PCI specific */
>      int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 496e5adaf8f18e9ae7e86dd69be0b9e71e86404f..65a11dc088524647541db97b7b8d6f07e5044728 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1158,7 +1158,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>  
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                      VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size)
> +                                    hwaddr size, Error **errp)
>  {
>      VFIODevice *vbasedev;
>      int ret;
> @@ -1167,10 +1167,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>          ret = vfio_device_dma_logging_report(vbasedev, iova, size,
>                                               vbmap->bitmap);
>          if (ret) {
> -            error_report("%s: Failed to get DMA logging report, iova: "
> -                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> -                         ", err: %d (%s)",
> -                         vbasedev->name, iova, size, ret, strerror(-ret));
> +            error_setg(errp, "%s: Failed to get DMA logging report, iova: "
> +                       "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> +                       ", err: %d (%s)",
> +                       vbasedev->name, iova, size, ret, strerror(-ret));
use error_setg_errno as below?
>  
>              return ret;
>          }
> @@ -1180,7 +1180,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>  }
>  
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr)
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp)
>  {
>      bool all_device_dirty_tracking =
>          vfio_devices_all_device_dirty_tracking(bcontainer);
> @@ -1197,13 +1197,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>  
>      ret = vfio_bitmap_alloc(&vbmap, size);
>      if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to allocate dirty tracking bitmap");
>          return ret;
>      }
>  
>      if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                              errp);
>      } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                errp);
>      }
>  
>      if (ret) {
> @@ -1251,12 +1255,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                translated_addr);
> +                                translated_addr, &local_err);
>      if (ret) {
> -        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") = %d (%s)",
> -                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                     strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                      "0x%"HWADDR_PRIx") failed :", bcontainer, iova,
nit in previous prepends you used "-" instead of ":" at the end. Maybe
align.
> +                      iotlb->addr_mask + 1);
> +        error_report_err(local_err);
>      }
>  
>  out_lock:
> @@ -1276,12 +1281,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>      const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
>                                  section->offset_within_region;
>      VFIORamDiscardListener *vrdl = opaque;
> +    Error *local_err = NULL;
> +    int ret;
>  
>      /*
>       * Sync the whole mapped region (spanning multiple individual mappings)
>       * in one go.
>       */
> -    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
> +    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +                                &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
>  
>  static int
> @@ -1313,7 +1325,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>  }
>  
>  static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
> -                                  MemoryRegionSection *section)
> +                                  MemoryRegionSection *section, Error **errp)
>  {
>      ram_addr_t ram_addr;
>  
> @@ -1344,7 +1356,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>          }
>          return 0;
>      } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        int ret;
> +
> +        ret = vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        if (ret) {
> +            error_setg(errp,
> +                       "Failed to sync dirty bitmap with RAM discard listener");
> +            return ret;
> +        }
>      }
>  
>      ram_addr = memory_region_get_ram_addr(section->mr) +
> @@ -1352,7 +1371,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>  
>      return vfio_get_dirty_bitmap(bcontainer,
>                     REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                   int128_get64(section->size), ram_addr);
> +                                 int128_get64(section->size), ram_addr, errp);
>  }
>  
>  static void vfio_listener_log_sync(MemoryListener *listener,
> @@ -1361,16 +1380,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                   listener);
>      int ret;
> +    Error *local_err = NULL;
>  
>      if (vfio_listener_skipped_section(section)) {
>          return;
>      }
>  
>      if (vfio_devices_all_dirty_tracking(bcontainer)) {
> -        ret = vfio_sync_dirty_bitmap(bcontainer, section);
> +        ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>          if (ret) {
> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> -                         strerror(-ret));
> +            error_report_err(local_err);
>              vfio_set_migration_error(ret);
>          }
>      }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7c0764121d24b02b6c4e66e368d7dff78a6d65aa..8db59881873c3b1edee81104b966af737e5fa6f6 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -65,10 +65,11 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>  
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                        VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size)
> +                                      hwaddr iova, hwaddr size, Error **errp)
>  {
>      g_assert(bcontainer->ops->query_dirty_bitmap);
> -    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
> +    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> +                                               errp);
>  }
>  
>  void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 6524575aeddcea8470b5fd10caf57475088d1813..475d96eaaa927998c6aa8cc9aa9f2115f5a1efda 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -131,6 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      };
>      bool need_dirty_sync = false;
>      int ret;
> +    Error *local_err = NULL;
>  
>      if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> @@ -166,8 +167,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>  
>      if (need_dirty_sync) {
>          ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> -                                    iotlb->translated_addr);
> +                                    iotlb->translated_addr, &local_err);
>          if (ret) {
> +            error_report_err(local_err);
>              return ret;
>          }
>      }
> @@ -237,7 +239,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>  
>  static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                            VFIOBitmap *vbmap,
> -                                          hwaddr iova, hwaddr size)
> +                                          hwaddr iova, hwaddr size,
> +                                          Error **errp)
>  {
>      const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                    bcontainer);
> @@ -265,9 +268,9 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>      ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
>      if (ret) {
>          ret = -errno;
> -        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
> -                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
> -                (uint64_t)range->size, errno);
> +        error_setg(errp, "Failed to get dirty bitmap for iova: 0x%"PRIx64
> +                   " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
> +                   (uint64_t)range->size, errno);
use errno flavour?

Eric
>      }
>  
>      g_free(dbitmap);


