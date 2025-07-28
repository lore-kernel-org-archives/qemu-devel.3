Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B763C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRbA-00072n-64; Mon, 28 Jul 2025 13:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRb8-00071E-9C
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRb6-0005Rz-62
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753723511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kOsFhZht9N5PriZgwbWc9LHi2hqexjmgjVmfQBGWcuk=;
 b=Hf7HS9q6q2eV3IvdeSW49AV2Sx8o05ZYaenRBoMhbgZhd+mjEfrNk3vcXqfDtxJjILKoHU
 qB90EMrHUp1O360r2PaLjel3FRKfORVFdqoDdHg03me/FuVdA784KErfluI2As2DjC+nuP
 sKl8zt44TNKaJC0NzmQ5TXpjfUleF6Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-3-ennhVgOWmh5LGFZ1imNQ-1; Mon, 28 Jul 2025 13:25:09 -0400
X-MC-Unique: 3-ennhVgOWmh5LGFZ1imNQ-1
X-Mimecast-MFC-AGG-ID: 3-ennhVgOWmh5LGFZ1imNQ_1753723508
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b78329f180so1530942f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 10:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723508; x=1754328308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOsFhZht9N5PriZgwbWc9LHi2hqexjmgjVmfQBGWcuk=;
 b=pqRKSp82f1yryEaYdjgMS64Gf5s8p82heBRz/zUiJsjsp01e5f//hGR/JbdgibPBVW
 hxNS687d3HHaIZexKViQp5Jr4pd+1FSMnbDWf1JvvYHyf6on0NjKZQ0VijroX5Bv7pLa
 hvSJPql8p1fGs1LWxbWH0Ca0wcNco8pxiVjd+5yly4ePok5PXh/d6usQQxYqpOMfv4vN
 1eamNqwQ9xKYgRDLsgKHhKsEP6gTnX/Xf2kv2WXZmgkMYWanqYQmiaOuaNQPwC8Wipcp
 I8ZH95zcYBeiywum6bYNJG+uE3Ii9mSZR9Wg+vuHPXvCaVcRtrzMwPXed9PnlN9Ds1XS
 jzeQ==
X-Gm-Message-State: AOJu0Yy+81fUCOXwK+tct9mshF+OobVMu6U0y7AzM+P8qZxtqcOsIo+Y
 eRPHZjgxar8Rd4mqzWrMWom801pDk1Y82byEFhuLohbuXv9SAzq7BGhQK6kC4yXTptZr2HvxVrk
 /fe1IEj8AUBe7oHdHnoeZ+FskFIQvp0w/JAPD8nXz7w7zHnFICEACgitrZiT2k1B+i7AlcsHPcv
 JbvzeaQBZ00SrdaLSYnLrh1CiwuhojKoE1Tg==
X-Gm-Gg: ASbGncuYZVzwAvxjJL4B6MwUG1bjV2oPpN69wJnID1M3os/gWybzC5Y7Uqp/7717Hzr
 CNbuLBJ8cmvteIk1mVfyOAQgRlW1pkzD109eyFjc8O6S9xLvuSKbs+J2JeGsw3GyxZ5soP5/49N
 4V1ikU/5bKyolp5PB7fYSaG9X7yI4q4ZSX43t5oy/iEAipB6wr6oRU7j18BYrIr/1m8Ll+HaEUA
 D4sgD0v0UWyVo87nMDD2L9nmsds2z7GifwvNXgvDW6iEzld1VlZDJL7yXCLWXOOaOuUBStHwbEc
 s+KDHbaK2jkyxZQETJedOjAlj1DmD4R7klAd1N8tI4rKX7h57XllnmrLXbOBvxQoIlPI5dluvm1
 jNg==
X-Received: by 2002:a05:6000:103:b0:3b7:8c83:db1e with SMTP id
 ffacd0b85a97d-3b78c83df34mr1318142f8f.33.1753723507649; 
 Mon, 28 Jul 2025 10:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQi1WVBKrikroWlcSB8e3VdENwkApfWNSVi+HPjl96wz86B/XLNsdF2XP4jfF/emeDCKUhWw==
X-Received: by 2002:a05:6000:103:b0:3b7:8c83:db1e with SMTP id
 ffacd0b85a97d-3b78c83df34mr1318116f8f.33.1753723507067; 
 Mon, 28 Jul 2025 10:25:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587abc2798sm106433215e9.7.2025.07.28.10.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 10:25:06 -0700 (PDT)
Message-ID: <ac0efa36-222c-4563-8bcb-0b07af2e5f33@redhat.com>
Date: Mon, 28 Jul 2025 19:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Shaoqin Huang <shahuang@redhat.com>
References: <20250723062714.1245826-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250723062714.1245826-1-clg@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/23/25 08:27, Cédric Le Goater wrote:
> Commit 350785d41d8b ("ramfb: Add property to control if load the
> romfile") introduced the `use-legacy-x86-rom` property for the
> `vfio-pci-nohotplug` device, allowing control over VGA BIOS ROM
> loading. However, the property compatibility setting was incorrectly
> applied to the `vfio-pci` device instead, which causes all `vfio-pci`
> devices to fail to load. This change fixes the issue by ensuring the
> property is set on the correct device.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/types.h   | 2 ++
>   hw/core/machine.c | 2 +-
>   hw/i386/microvm.c | 2 +-
>   hw/i386/pc_piix.c | 2 +-
>   hw/i386/pc_q35.c  | 2 +-
>   hw/vfio/pci.c     | 2 --
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/types.h b/hw/vfio/types.h
> index fa20c29b9fbbf51ddad4f6cb0535a70152224a94..c19334ff25ae2f5221f08ed863553ce7f8e3be98 100644
> --- a/hw/vfio/types.h
> +++ b/hw/vfio/types.h
> @@ -18,4 +18,6 @@
>   #define TYPE_VFIO_PCI "vfio-pci"
>   /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
>   
> +#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +
>   #endif /* HW_VFIO_VFIO_TYPES_H */
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d6b2240fc250d2d1194dee62e5356c0c214f1069..bd47527479a7947ca293a47c9a6f49916d24bad3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {
>       { "scsi-hd", "dpofua", "off" },
>       { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>       { "ramfb", "use-legacy-x86-rom", "true"},
> -    { "vfio-pci", "use-legacy-x86-rom", "true" },
> +    { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
>   };
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>   
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index d90b69a162007af8af1b8596be590126fb00fb59..94d22a232aca1f82590d80c2ac6cc279bb9ff808 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -635,7 +635,7 @@ GlobalProperty microvm_properties[] = {
>        */
>       { "pcie-root-port", "io-reserve", "0" },
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   
>   static void microvm_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ad5caff3a5d251671db591c68bed3b69a5e45d17..c03324281bdb356e17d434b156e4080865867f4f 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -80,7 +80,7 @@ static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>   
>   static GlobalProperty pc_piix_compat_defaults[] = {
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   static const size_t pc_piix_compat_defaults_len =
>       G_N_ELEMENTS(pc_piix_compat_defaults);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 9b9519fa02d506393058c085178924156e9e0d10..b309b2b378db4741b72828c1f34d2edc2e057a1d 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -69,7 +69,7 @@
>   static GlobalProperty pc_q35_compat_defaults[] = {
>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   static const size_t pc_q35_compat_defaults_len =
>       G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e72d514a4cb91946f7c79332492bf5d709c308f2..0c4606d9cb5e163b8c533ed9b89d4d73eafaae24 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -49,8 +49,6 @@
>   #include "vfio-migration-internal.h"
>   #include "vfio-helpers.h"
>   
> -#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> -
>   /* Protected by BQL */
>   static KVMRouteChange vfio_route_change;
>   



Applied to vfio-next.

Thanks,

C.



