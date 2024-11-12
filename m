Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B77D597B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 23:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB0Xr-0003B7-JQ; Tue, 12 Nov 2024 18:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tB0Xp-0003Aj-RJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 18:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tB0Xn-000108-Ri
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 18:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731455013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i12siLNMw6OymdRUM8a3B/eVgL/7e/MH0JZhzjD0Veg=;
 b=PMmqkrlx9yk5V++JUZjKT08TYRza3/Y+IlfZnVZlaYmuN/Gdxywlvj27r2tOldx1SNa7Xz
 IxN8FgYmCBeYIyJfUHm9RGOoh3cQ8hFLknv3HTgcIwojdHkyUl1k0eFeCxZBK0w+A34Cq2
 LKukrfMegAlIdaeNZ7XsRWfZmpU9P8g=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-dX64NDnSPwe6_dVITcf4Fw-1; Tue, 12 Nov 2024 18:43:29 -0500
X-MC-Unique: dX64NDnSPwe6_dVITcf4Fw-1
X-Mimecast-MFC-AGG-ID: dX64NDnSPwe6_dVITcf4Fw
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83aa8c7edb7so50769439f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 15:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731455009; x=1732059809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i12siLNMw6OymdRUM8a3B/eVgL/7e/MH0JZhzjD0Veg=;
 b=uBHAmqf13Wjx5EZvebDZCVIFMWragAZxlfnMYggeYH2HOGAZdgna5cnHK1zuD+TSB1
 S1fAOMwwzi8JieBVmv0KIPk5tm17oSQ62B9ECAn2L+479iWaN8OWCK4Bnesk/H1oTV5t
 dWAoPNs0FM6oujUgotpInPdOJ5jFCib0jxB3Wqj0Oy6uvqWQ/LtMqpitmDJyFsGJo0Ag
 QUyWr5ZBw7pXxQGaVFhIQ/J5KW78zV2377GitNd6aMTIyAzODrn/1AYBmMc24mGevaCT
 tmqaoE7iLgJn2hjMHnFwq2EZKMmeDPCIsXm55sLgyB/mWT0aCLBL+zHIbOXjVLUHOMWg
 KV6w==
X-Gm-Message-State: AOJu0YyVz3Zzo+X3hLqZ5yx++ybr6huvD0Z9alveVORmvevpcS1g2uA7
 8OIBzgHgK5cfWS6YMnUt1WOC+At0Mzmsf2e64wdNj6KLfMBqnVKS+bcDvM7LELZD5T2fj+2dwbm
 QfEMKJ97SYj4SjU2KzNKhejWTfOLLs+Pn0wWbfr9YVCg8yaRmOkiR1fqp+C5p
X-Received: by 2002:a05:6602:29c7:b0:83a:addb:7196 with SMTP id
 ca18e2360f4ac-83e03290109mr570324439f.1.1731455008771; 
 Tue, 12 Nov 2024 15:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFKxmegMhj8ugB6CShW7DLdidA/n6evAUaBBDBHO6CoR7lQ/N0fHeraIZVHIkygE0CM5VZEA==
X-Received: by 2002:a05:6602:29c7:b0:83a:addb:7196 with SMTP id
 ca18e2360f4ac-83e03290109mr570323639f.1.1731455008334; 
 Tue, 12 Nov 2024 15:43:28 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e135583d2sm229422039f.46.2024.11.12.15.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:43:27 -0800 (PST)
Date: Tue, 12 Nov 2024 16:43:26 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Juan Pablo Ruiz <jpruiz84@gmail.com>
Cc: qemu-devel@nongnu.org, Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>,
 Auger Eric <eric.auger@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/1] vfio/platform: Add mmio-base property to define
 start address for MMIO mapping
Message-ID: <20241112164326.562406a9.alex.williamson@redhat.com>
In-Reply-To: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
References: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 12 Nov 2024 22:02:12 +0000
Juan Pablo Ruiz <jpruiz84@gmail.com> wrote:

> Some platform devices have large MMIO regions (e.g., GPU reserved memory). For
> certain devices, it's preferable to have a 1:1 address translation in the VM to
> avoid modifying driver source code.

Why do we need 1:1 mappings?  Shouldn't the device tree describe where
the device lives in the VM address space and the driver should adapt
rather than use hard coded addresses?

How does a user know which devices need fixed base addresses and what
those addresses should be?

> This patch:

... should be split into at least 3 patches.

> 
> 1. Increases the VFIO platform bus size from 32MB to 130GB.

That's a very strange and specific size.

> 2. Changes the mmio_size property from 32 to 64 bits.
> 3. Adds an mmio-base property to define the starting MMIO address for mapping
>    the VFIO device.
> 
> Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
> ---
>  hw/arm/virt.c                   |  6 +++---
>  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
>  hw/vfio/platform.c              |  1 +
>  include/hw/platform-bus.h       |  2 +-
>  include/hw/vfio/vfio-platform.h |  1 +
>  5 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1a381e9a2b..9fc8f4425a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
> -    [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> +    [VIRT_PLATFORM_BUS] =       { 0x60000000, 0x1FC0000000 },          // 130048MB
>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      /* Actual RAM size depends on initial RAM and device memory settings */
> -    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
> +    [VIRT_MEM] =                { 0x2000000000, LEGACY_RAMLIMIT_BYTES },
>  };
>  
>  /*
> @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState *vms)
>      dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
>      dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
>      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
> -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
> +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      vms->platform_bus_dev = dev;
>  
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index dc58bf505a..f545fab6e5 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/platform-bus.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/vfio/vfio-platform.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>                                    int n)
>  {
>      MemoryRegion *sbdev_mr = sysbus_mmio_get_region(sbdev, n);
> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);

How do you know it's a vfio-platform device?  This completely breaks
device abstraction.  Thanks,

Alex

>      uint64_t size = memory_region_size(sbdev_mr);
>      uint64_t alignment = (1ULL << (63 - clz64(size + size - 1)));
>      uint64_t off;
> +    uint64_t mmio_base_off;
>      bool found_region = false;
>  
> +    if (vdev->mmio_base) {
> +        if(vdev->mmio_base < pbus->mmio.addr || 
> +           vdev->mmio_base >= pbus->mmio.addr + pbus->mmio_size){
> +            error_report("Platform Bus: MMIO base 0x%"PRIx64
> +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"]",
> +                vdev->mmio_base,
> +                pbus->mmio.addr,
> +                pbus->mmio.addr + pbus->mmio_size);
> +            exit(1);
> +        }
> +        
> +        mmio_base_off = vdev->mmio_base - pbus->mmio.addr;
> +    } else {
> +        mmio_base_off = 0;
> +    }
> +    
>      if (memory_region_is_mapped(sbdev_mr)) {
>          /* Region is already mapped, nothing to do */
>          return;
> @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>       * Look for empty space in the MMIO space that is naturally aligned with
>       * the target device's memory region
>       */
> -    for (off = 0; off < pbus->mmio_size; off += alignment) {
> +    for (off = mmio_base_off; off < pbus->mmio_size; off += alignment) {
>          MemoryRegion *mr = memory_region_find(&pbus->mmio, off, size).mr;
>          if (!mr) {
>              found_region = true;
> @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>          }
>      }
>  
> +    if (vdev->mmio_base && vdev->mmio_base != off + pbus->mmio.addr) {
> +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"PRIx64, 
> +            vdev->mmio_base);
> +    }
> +
>      if (!found_region) {
>          error_report("Platform Bus: Can not fit MMIO region of size %"PRIx64,
>                       size);
> @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
>  
>  static Property platform_bus_properties[] = {
>      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
> -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
> +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index a85c199c76..cfac564093 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] = {
>      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>  #endif
> +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> index 44f30c5353..4e9913a5d7 100644
> --- a/include/hw/platform-bus.h
> +++ b/include/hw/platform-bus.h
> @@ -34,7 +34,7 @@ struct PlatformBusDevice {
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
> -    uint32_t mmio_size;
> +    uint64_t mmio_size;
>      MemoryRegion mmio;
>  
>      uint32_t num_irqs;
> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
> index c414c3dffc..90575b5852 100644
> --- a/include/hw/vfio/vfio-platform.h
> +++ b/include/hw/vfio/vfio-platform.h
> @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
>      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
>      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
>      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
> +    uint64_t mmio_base; /* base address to start looking for mmio */
>      bool irqfd_allowed; /* debug option to force irqfd on/off */
>  };
>  typedef struct VFIOPlatformDevice VFIOPlatformDevice;


