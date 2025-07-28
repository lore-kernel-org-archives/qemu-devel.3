Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9930CC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLwz-00043Q-0M; Mon, 28 Jul 2025 07:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugLSD-0006DM-7g
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugLS9-0007cT-5a
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753699880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lwa7I/IGCPCwXAq7bTniRCT7djg0hweFTAxQZ5mtGmI=;
 b=SCBI7UroBpe8tzZ3YjyL22VhX4C4htS3Bi3uusgU7SMUcWCCRhJHdz9Ab/vP2RVLFHNska
 vFKb5obBOxdWk1pnivRNwBH5nVXUQymM9J0vqUeYetAg+QiTR5kwtWEnSBiqqMcieiSsKk
 j+V9ZUO8XYNrWw57tcMXt0GSMSrl8Mg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-k53CWxRrNnOmNEsALHdzVw-1; Mon, 28 Jul 2025 06:51:18 -0400
X-MC-Unique: k53CWxRrNnOmNEsALHdzVw-1
X-Mimecast-MFC-AGG-ID: k53CWxRrNnOmNEsALHdzVw_1753699877
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45624f0be48so20085165e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753699877; x=1754304677;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lwa7I/IGCPCwXAq7bTniRCT7djg0hweFTAxQZ5mtGmI=;
 b=ZJ2wIZzxf0MzYCWeEFM7HJiaKv5NCggCALWUZLhZpJJ82eRSYUPjCSFBagTG1jID+m
 n2wdI6tk8ffzCBLqHKFAIfI8uCNSOwdVVmp/7NqRO9kJv1tUqB9k3L7PayZohYPbm8S8
 TMszYhBh5KoPd+lX6MjF56dhbjutxt6lF+tyOTMVQYKl0/wPDQmDAfyuQkQbtgENGbaz
 n1pO9ns/V2G6g4AnW+Kor2M9ssAnRypJZK2/hU43fL7Tov00BFhxuef2GvmOsvxSohtl
 CvhGV1UVqSra476kbX3YRjcxBS/Sxf4rc3eRhePHu52cK3eTJ3mK7ZDiTPY0v1DSqvKD
 1W8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNBwcZMifugxAyJfk4+v58l3jvnnpFREJkF5bv5Bhx0FuoBLKyMnNmrmH77NXAKYaDyWuZlaxRsGy1@nongnu.org
X-Gm-Message-State: AOJu0YzLMx1jgPkGJERwaIGqCQK0ZNrOsKvUE/mGNcA1F6O6uqg9gTU4
 ZItmCuINkamM0QrPrwv4755eeZMVmH74PX77AnHzKIMWSave5yvToh/FihaIyMNPr35ut3THSEX
 sBetzetL9QK5QiquKp5D35ZeO/UEmywGFYBD71vkTH/slGpjfKV2w1KmF
X-Gm-Gg: ASbGncsqWo+wOXH0umMN1xp3NB1NWn/p5uzcQfWk3MaWa1W/Aqa2PIgjHJ8EtRcctZd
 eaQrLvPwfklsk2zdNlX1sGORUDhSOLcW7J3hAubWvQYDkCJeI9cCAF2rqljVx0extcMBtKZQpIf
 E0qQFVD/CFcZYUo1sy13yBnI/PFBmMx6oBHPP17B9jr3DmxlPJ8WvTBOXDMegj7csmTq/O4y9Q9
 1l1mxEygW60nRTIK4k/HGM+TBIlKAnH/MlfMe2rMV1anZMmPNVg1OpLugr+4Fp6ZcmmI3CFTX6N
 jGB6TXhKabay0VyHAAumb70avpe7CuU2d5q9+TELoZHQ5y5mpWFsc2Rxf5n8B2qdqU1/3cxPNCf
 3vLMt
X-Received: by 2002:a05:600c:3b0d:b0:456:1824:4808 with SMTP id
 5b1f17b1804b1-45876671c42mr87868015e9.32.1753699877347; 
 Mon, 28 Jul 2025 03:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjMI0upUP1PjX3NYaeKRk9lhqOnNOxHkK+7Z7f6oMPWhVvvgHAjLZM3bekg47hg6LrSS/0kQ==
X-Received: by 2002:a05:600c:3b0d:b0:456:1824:4808 with SMTP id
 5b1f17b1804b1-45876671c42mr87867575e9.32.1753699876736; 
 Mon, 28 Jul 2025 03:51:16 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-169.pools.arcor-ip.net.
 [47.64.113.169]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705e39b1sm147118125e9.34.2025.07.28.03.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:51:16 -0700 (PDT)
Message-ID: <b10a9b6b-927e-4c25-aebb-9317fe43b9ad@redhat.com>
Date: Mon, 28 Jul 2025 12:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] hw/i386: Add the ramfb romfile compatibility
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
 <20250718194349.65771-4-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250718194349.65771-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 18/07/2025 21.43, Gerd Hoffmann wrote:
> From: Shaoqin Huang <shahuang@redhat.com>
> 
> ramfb is a sysbus device so it can only used for machine types where it
> is explicitly enabled:
> 
>    # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
>    hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>    hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>    hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
> 		  TYPE_RAMFB_DEVICE);
>    hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
> 		  TYPE_RAMFB_DEVICE);
>    hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>    hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
> 
> So these six are the only machine types we have to worry about.
> 
> The three x86 machine types (pc, q35, microvm) will actually use the rom
> (when booting with seabios).
> 
> For arm/riscv/loongarch virt we want to disable the rom.
> 
> This patch sets ramfb romfile option to false by default, except for x86
> machines types (pc, q35, microvm) which need the rom file when booting
> with seabios and machine types <= 10.0 (handling the case of arm virt,
> for compat reasons).
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> Message-ID: <20250717100941.2230408-4-shahuang@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/core/machine.c             |  2 ++
>   hw/display/ramfb-standalone.c |  2 +-
>   hw/i386/microvm.c             |  3 +++
>   hw/i386/pc_piix.c             | 10 ++++++++++
>   hw/i386/pc_q35.c              |  3 +++
>   hw/vfio/pci.c                 |  2 +-
>   6 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e869821b2246..a7043e2a3425 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,8 @@
>   
>   GlobalProperty hw_compat_10_0[] = {
>       { "scsi-hd", "dpofua", "off" },
> +    { "ramfb", "use-legacy-x86-rom", "true"},
> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
>   };
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>   
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 82d8c69f8903..72b2071aed01 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -64,7 +64,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>   static const Property ramfb_properties[] = {
>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>       DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
> -                     use_legacy_x86_rom, true),
> +                     use_legacy_x86_rom, false),
>   };
>   
>   static void ramfb_class_initfn(ObjectClass *klass, const void *data)
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index e0daf0d4fc30..d90b69a16200 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -49,6 +49,7 @@
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/usb/xhci.h"
> +#include "hw/vfio/types.h"
>   
>   #include "elf.h"
>   #include "kvm/kvm_i386.h"
> @@ -633,6 +634,8 @@ GlobalProperty microvm_properties[] = {
>        * so reserving io space is not going to work.  Turn it off.
>        */
>       { "pcie-root-port", "io-reserve", "0" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>   };
>   
>   static void microvm_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index a3285fbc6450..ad5caff3a5d2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -49,6 +49,7 @@
>   #include "hw/i2c/smbus_eeprom.h"
>   #include "system/memory.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/vfio/types.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "system/xen.h"
> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>   #endif
>   
> +static GlobalProperty pc_piix_compat_defaults[] = {
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +};
> +static const size_t pc_piix_compat_defaults_len =
> +    G_N_ELEMENTS(pc_piix_compat_defaults);
> +
>   /*
>    * Return the global irq number corresponding to a given device irq
>    * pin. We could also use the bus number to have a more precise mapping.
> @@ -492,6 +500,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                                      pc_set_south_bridge);
>       object_class_property_set_description(oc, "x-south-bridge",
>                                        "Use a different south bridge than PIIX3");
> +    compat_props_add(m->compat_props,
> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>   }
>   
>   static void pc_i440fx_machine_10_1_options(MachineClass *m)
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index cf871cfdad86..9b9519fa02d5 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -45,6 +45,7 @@
>   #include "hw/i386/pc.h"
>   #include "hw/i386/amd_iommu.h"
>   #include "hw/i386/intel_iommu.h"
> +#include "hw/vfio/types.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/ide/pci.h"
> @@ -67,6 +68,8 @@
>   
>   static GlobalProperty pc_q35_compat_defaults[] = {
>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>   };
>   static const size_t pc_q35_compat_defaults_len =
>       G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0b969b3359db..174499ecec65 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3810,7 +3810,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>       DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
> -                     use_legacy_x86_rom, true),
> +                     use_legacy_x86_rom, false),
>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                               ON_OFF_AUTO_AUTO),
>   };

  Hi guys,

there is something fishy going on now:

$ ./qemu-system-x86_64 -M q35 -device vfio-pci
Unexpected error in object_property_find_err() at 
../../home/thuth/devel/qemu/qom/object.c:1345:
qemu-system-x86_64: -device vfio-pci: can't apply global 
vfio-pci.use-legacy-x86-rom=true: Property 'vfio-pci.use-legacy-x86-rom' not 
found
Aborted (core dumped)

Could you please have a look?

  Thanks,
   Thomas


