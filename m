Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF25D41C19
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 08:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB9CV-0004Qc-DV; Wed, 13 Nov 2024 03:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tB9CO-0004QK-R5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tB9CM-0008LG-VR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731488281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7/d+DEGYPklnP6E7jl2Qve9YIrTAYLLX3LMs4Girfw=;
 b=IxDRvaR/PYZqb5kp8iTU1EZg7yb+BQ2/L6l80YMyDUD5vHCprP2ANjGUzQI/gQawYrgYQ+
 cHH6qFWWQsftvNVfp/y5bzdmMTHQb3xOeQSE/Fbl7LrnAldfMJ4mp0lCRbSfOwy1+b9ABN
 ic9HDXI3AyNLk5Hwov4wzhpcldNTTcI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-0xAwRWbvPTiY4RxC7a4KEA-1; Wed, 13 Nov 2024 03:57:56 -0500
X-MC-Unique: 0xAwRWbvPTiY4RxC7a4KEA-1
X-Mimecast-MFC-AGG-ID: 0xAwRWbvPTiY4RxC7a4KEA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so1077414185a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 00:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731488276; x=1732093076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7/d+DEGYPklnP6E7jl2Qve9YIrTAYLLX3LMs4Girfw=;
 b=Qq+KCN3u+KTdX29pLy+y3uZYSAcF+ym++brguzY+uqPEUecVwZ5kVRllTPuwQebWrT
 LpF7Iib9OaKwNOUH46fyvDw+q2As1r0k11pOwPOpx49yRj3HiDsnmog3o/Ao0Nm9970I
 4bDiUoQwjlHA83Mx/FacolLKriVioDdrEP3jKm/VRymsfPXqluImXE+9IcIS2SZZ1BwI
 STj8aJAzqG8jQ7nJZ0erb+P81xRRwJPazO4RygDD+s7rXa4ZjGxKdTwSyy5AsUnkYO5+
 GI6zVA0JY/Ut5uXtBNlS1wdwaocaYi9bOQFzh9W8Gj0YjLdlIZldA5J5nkUx4AGO7oQR
 oz3A==
X-Gm-Message-State: AOJu0YxhQ9l7H1gZeGGxyJDsiB6Szp6Bhr5SRfI4CMS9bXR2xfCnubDA
 1Yq6cV+MXiJOKa4g7wJGVLDKzO11PoGC5GIa7KIsTI0ovcmbbesY/C9SAteZmBNNJJOjPdnAx9n
 wgnwr70acJ5k3isXr+GLvGBYwVEfpQpW4TnfwGtaVajTpv/mt/GI5
X-Received: by 2002:a05:620a:199c:b0:7b1:4fcc:5ac1 with SMTP id
 af79cd13be357-7b3529c314dmr268359885a.44.1731488276160; 
 Wed, 13 Nov 2024 00:57:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd9K2+aX/6GFVv7woNyC6/WWtqegjSnXRIFDnQ9ejkbkorML2sa2em2cJzlUBnynxQmzCXOg==
X-Received: by 2002:a05:620a:199c:b0:7b1:4fcc:5ac1 with SMTP id
 af79cd13be357-7b3529c314dmr268357485a.44.1731488275707; 
 Wed, 13 Nov 2024 00:57:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac666efsm669328585a.60.2024.11.13.00.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 00:57:54 -0800 (PST)
Message-ID: <7d31a829-52b2-4ae0-9406-c5ffecd764d0@redhat.com>
Date: Wed, 13 Nov 2024 09:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vfio/platform: Add mmio-base property to define start
 address for MMIO mapping
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Juan Pablo Ruiz <jpruiz84@gmail.com>
Cc: qemu-devel@nongnu.org, Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
 <20241112164326.562406a9.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241112164326.562406a9.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Juan Pablo,

On 11/13/24 00:43, Alex Williamson wrote:
> On Tue, 12 Nov 2024 22:02:12 +0000
> Juan Pablo Ruiz <jpruiz84@gmail.com> wrote:
>
>> Some platform devices have large MMIO regions (e.g., GPU reserved memory). For
>> certain devices, it's preferable to have a 1:1 address translation in the VM to
>> avoid modifying driver source code.
> Why do we need 1:1 mappings?  Shouldn't the device tree describe where
> the device lives in the VM address space and the driver should adapt
> rather than use hard coded addresses?
>
> How does a user know which devices need fixed base addresses and what
> those addresses should be?
>
>> This patch:
> ... should be split into at least 3 patches.
>
>> 1. Increases the VFIO platform bus size from 32MB to 130GB.
> That's a very strange and specific size.
>
>> 2. Changes the mmio_size property from 32 to 64 bits.
>> 3. Adds an mmio-base property to define the starting MMIO address for mapping
>>    the VFIO device.
>>
>> Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
>> ---
>>  hw/arm/virt.c                   |  6 +++---
>>  hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
>>  hw/vfio/platform.c              |  1 +
>>  include/hw/platform-bus.h       |  2 +-
>>  include/hw/vfio/vfio-platform.h |  1 +
>>  5 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 1a381e9a2b..9fc8f4425a 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] = {
>>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>> -    [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>> +    [VIRT_PLATFORM_BUS] =       { 0x60000000, 0x1FC0000000 },          // 130048MB
>>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
>>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>>      /* Actual RAM size depends on initial RAM and device memory settings */
>> -    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
>> +    [VIRT_MEM] =                { 0x2000000000, LEGACY_RAMLIMIT_BYTES },
This won't be accepted. We had this discussion in the past with Peter
(added in cc) and it is not possible to change the inital RAM layout
like that.

Thanks

Eric
>>  };
>>  
>>  /*
>> @@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState *vms)
>>      dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
>>      dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
>>      qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
>> -    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
>> +    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>      vms->platform_bus_dev = dev;
>>  
>> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
>> index dc58bf505a..f545fab6e5 100644
>> --- a/hw/core/platform-bus.c
>> +++ b/hw/core/platform-bus.c
>> @@ -22,6 +22,7 @@
>>  #include "qemu/osdep.h"
>>  #include "hw/platform-bus.h"
>>  #include "hw/qdev-properties.h"
>> +#include "hw/vfio/vfio-platform.h"
>>  #include "qapi/error.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/module.h"
>> @@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>>                                    int n)
>>  {
>>      MemoryRegion *sbdev_mr = sysbus_mmio_get_region(sbdev, n);
>> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
> How do you know it's a vfio-platform device?  This completely breaks
> device abstraction.  Thanks,
>
> Alex
>
>>      uint64_t size = memory_region_size(sbdev_mr);
>>      uint64_t alignment = (1ULL << (63 - clz64(size + size - 1)));
>>      uint64_t off;
>> +    uint64_t mmio_base_off;
>>      bool found_region = false;
>>  
>> +    if (vdev->mmio_base) {
>> +        if(vdev->mmio_base < pbus->mmio.addr || 
>> +           vdev->mmio_base >= pbus->mmio.addr + pbus->mmio_size){
>> +            error_report("Platform Bus: MMIO base 0x%"PRIx64
>> +                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"]",
>> +                vdev->mmio_base,
>> +                pbus->mmio.addr,
>> +                pbus->mmio.addr + pbus->mmio_size);
>> +            exit(1);
>> +        }
>> +        
>> +        mmio_base_off = vdev->mmio_base - pbus->mmio.addr;
>> +    } else {
>> +        mmio_base_off = 0;
>> +    }
>> +    
>>      if (memory_region_is_mapped(sbdev_mr)) {
>>          /* Region is already mapped, nothing to do */
>>          return;
>> @@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>>       * Look for empty space in the MMIO space that is naturally aligned with
>>       * the target device's memory region
>>       */
>> -    for (off = 0; off < pbus->mmio_size; off += alignment) {
>> +    for (off = mmio_base_off; off < pbus->mmio_size; off += alignment) {
>>          MemoryRegion *mr = memory_region_find(&pbus->mmio, off, size).mr;
>>          if (!mr) {
>>              found_region = true;
>> @@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>>          }
>>      }
>>  
>> +    if (vdev->mmio_base && vdev->mmio_base != off + pbus->mmio.addr) {
>> +        warn_report("Platform Bus: Not able to map in mmio base: 0x%"PRIx64, 
>> +            vdev->mmio_base);
>> +    }
>> +
>>      if (!found_region) {
>>          error_report("Platform Bus: Can not fit MMIO region of size %"PRIx64,
>>                       size);
>> @@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
>>  
>>  static Property platform_bus_properties[] = {
>>      DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
>> -    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
>> +    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
>>      DEFINE_PROP_END_OF_LIST()
>>  };
>>  
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index a85c199c76..cfac564093 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] = {
>>      DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
>>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>>  #endif
>> +    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
>> index 44f30c5353..4e9913a5d7 100644
>> --- a/include/hw/platform-bus.h
>> +++ b/include/hw/platform-bus.h
>> @@ -34,7 +34,7 @@ struct PlatformBusDevice {
>>      SysBusDevice parent_obj;
>>  
>>      /*< public >*/
>> -    uint32_t mmio_size;
>> +    uint64_t mmio_size;
>>      MemoryRegion mmio;
>>  
>>      uint32_t num_irqs;
>> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
>> index c414c3dffc..90575b5852 100644
>> --- a/include/hw/vfio/vfio-platform.h
>> +++ b/include/hw/vfio/vfio-platform.h
>> @@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
>>      uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
>>      QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
>>      QemuMutex intp_mutex; /* protect the intp_list IRQ state */
>> +    uint64_t mmio_base; /* base address to start looking for mmio */
>>      bool irqfd_allowed; /* debug option to force irqfd on/off */
>>  };
>>  typedef struct VFIOPlatformDevice VFIOPlatformDevice;


