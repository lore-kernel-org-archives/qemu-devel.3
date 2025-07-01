Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6862C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 05:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWTNG-0005X9-Qo; Tue, 01 Jul 2025 01:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWTND-0005Wn-SK
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 01:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWTNA-00047H-C1
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 01:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751347052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GP0IvbFuGzYX0dGCbJyf5OR8k9o+SbLFNi5hmpHXPEU=;
 b=FMy6ulQUMG4Jc2QsgWl82VgogL5Ukx6maWUf56OCkqXkmSCp5Om5UafpIcd5BlxqSvnTFB
 3KRFg9sIXzrjzfIIGNhPWaubh80dx37J+OsjRRHA89bX/GrUXpSE5DrMW1K8Bth7EpV/jp
 OtLIsKmEJZxJmPF2jTVfP0SJPvFkG9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-M6gyR8RCOrSwrMI7wnwXiA-1; Tue, 01 Jul 2025 01:17:31 -0400
X-MC-Unique: M6gyR8RCOrSwrMI7wnwXiA-1
X-Mimecast-MFC-AGG-ID: M6gyR8RCOrSwrMI7wnwXiA_1751347050
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so24715545e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 22:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751347050; x=1751951850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GP0IvbFuGzYX0dGCbJyf5OR8k9o+SbLFNi5hmpHXPEU=;
 b=UipXG6wiDeo/24NzgT9sos2qX+FS/X1dz6JNz/KuutYYyFqBDRspaBlwm6BeLNAiT+
 x2Llpa0uO2A4MUNt99YhiecuVGdIJYkiGngdbpf5wHJlMlsLqmFhLOGlaEsCP2tyt9LT
 nU6ps7MKCoS5kI3jdYJkFvjDHTJmT9erJWKMV34jOuNqpsGOpGCZbbBvLn5EAsNtUtQf
 AssizavfsndCCPUJXATvu2GlQEj+6C46qkN+rX4aJ6ZaAYdQ2b2HTB8vRJ9DUsV27w+o
 Mm/dUSAyrm/kl2nUTC7c+lkKenJo7Pmlm4cwb4QCgAla+ioqZ4quKVXg1IQfm9Jp6Sf7
 ud3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwmvjNQgZA8pNwFzSk/jPnQoPGPTmeX/SdiJDefQ8bFh5l6ncL7kFfyQ4NsQ9Fp3H23YHkILOTT10S@nongnu.org
X-Gm-Message-State: AOJu0YwABfcU/EI0qcg7vdbA4R+STYzD57OthZAJR+z7o5lwbIVodcHK
 5vlOLH+ph3a7xvgm5US7ET2gIzij0DHSWeMmt1Y1ndxAHmWPxN2jeu842rUetb3oLOrckhDwEnI
 TMxjr5DQpCj5VrtzGzkDEJhvCPe20Z8mv0Bd5s1LCHuCF/gaDVKR2JY7y
X-Gm-Gg: ASbGncuHvAWGLVYFxwZa1kNlvQ9l/o+lIeT6596Dr3CoP0k3x37mENjei9vslNJ4Cif
 gEuh4Uht0HGOpxxTEmZWz7rxMHjAm7uS4dL0aGObAuP9W8i1olhMcXBWEvkOqn95vCjX8VYI1NI
 Oh5+jienX+ZhZ9F1U0FAYdSSwlIKhnziq/48lpQFK31dImHqPZ8ypOVYrswTVxuEApGtjjd1+ne
 lWYhXUdF656FA4dWvGEXoArEiQnEdNjtLB/b5Pd83TIhaOyJXTcyXYPtkDFiyU62xBC9jEwmfhu
 lisf+tWIxA3+K6Ssm3wO2WQu1b6h+dIREiDu7U82egd48weOy70gd0mhjuU1p54u
X-Received: by 2002:a05:600c:3b8c:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-45396072f4cmr107127465e9.5.1751347050312; 
 Mon, 30 Jun 2025 22:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHos/bOX9m0qeZhL01ZMtYjn/DzG6jYVPwvIfOgJI9OJAYaxFFwGxYgmyG6TcNUfDYJlpT9Fw==
X-Received: by 2002:a05:600c:3b8c:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-45396072f4cmr107127155e9.5.1751347049843; 
 Mon, 30 Jun 2025 22:17:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7098sm11896245f8f.4.2025.06.30.22.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 22:17:29 -0700 (PDT)
Message-ID: <9bbaa0bb-cf32-48f2-aff6-6484285496f0@redhat.com>
Date: Tue, 1 Jul 2025 07:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hw/i386: Add the ramfb romfile compatibility
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250701030549.2153331-1-shahuang@redhat.com>
 <20250701030549.2153331-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250701030549.2153331-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On 7/1/25 5:05 AM, Shaoqin Huang wrote:
> Set the "use-legacy-x86-rom" property to false by default, and only set
> it to true on x86 since only x86 will need it.
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/core/machine.c             |  2 ++
>  hw/display/ramfb-standalone.c |  2 +-
>  hw/i386/pc_piix.c             | 10 ++++++++++
>  hw/i386/pc_q35.c              |  3 +++
>  hw/vfio/pci.c                 |  2 +-
>  5 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63c6ef93d2..349aec1e0d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -46,6 +46,8 @@ GlobalProperty hw_compat_9_2[] = {
>      { "migration", "multifd-clean-tls-termination", "false" },
>      { "migration", "send-switchover-start", "off"},
>      { "vfio-pci", "x-migration-multifd-transfer", "off" },
> +    { "ramfb", "use-legacy-x86-rom", "true"},
> +    { "vfio-pci", "use-legacy-x86-rom", "true" },
why 9.2? The 10.0 machine type should also apply the previous "true"
default setting. To me the new default shall only affect the latest 10.1
machine type.
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index af1175bf96..ddbf42f181 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>  
>  static const Property ramfb_properties[] = {
>      DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>  };
>  
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 6c91e2d292..4a8bbc0e28 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -49,6 +49,7 @@
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "exec/memory.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/vfio/pci.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "system/xen.h"
> @@ -77,6 +78,13 @@ static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>  static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>  #endif
>  
> +static GlobalProperty pc_piix_compat_defaults[] = {
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +};
> +static const size_t pc_piix_compat_defaults_len =
> +    G_N_ELEMENTS(pc_piix_compat_defaults);
> +
>  /*
>   * Return the global irq number corresponding to a given device irq
>   * pin. We could also use the bus number to have a more precise mapping.
> @@ -477,6 +485,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                                     pc_set_south_bridge);
>      object_class_property_set_description(oc, "x-south-bridge",
>                                       "Use a different south bridge than PIIX3");
> +    compat_props_add(m->compat_props,
> +                     pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>  }
>  
>  static void pc_i440fx_machine_10_0_options(MachineClass *m)
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index fd96d0345c..f6d89578d0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -45,6 +45,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/i386/amd_iommu.h"
>  #include "hw/i386/intel_iommu.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/ide/pci.h"
> @@ -67,6 +68,8 @@
>  
>  static GlobalProperty pc_q35_compat_defaults[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
I hope we do not omit any other machine that would actually need ramfb
rom. At the moment we take care of q35 and  piix. Anyone aware of any
other user?

Thanks

Eric
>  };
>  static const size_t pc_q35_compat_defaults_len =
>      G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ff0d93fae0..a529500b70 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static const Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                              ON_OFF_AUTO_AUTO),
>  };


