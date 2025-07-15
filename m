Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D65C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYlF-0005lz-4N; Tue, 15 Jul 2025 02:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYl8-0005jT-LA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYl5-0001Ub-Ni
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752559398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HjFMQMHpd53Ih+uZb3O1wDNqKyNpbD2eFNxnT3Q2dQk=;
 b=aQvnsE86A9kI5WiSUt2i8IKggV2GqZnWE7o5p0sGtj74vqTNAHGO3RxGTBSSLZF/D4Vsal
 PM2CLBS6yiY11rsjZfqrpQNnq9G7Y/P1wEJDSD+Uf5ei4KMwpaE1pCRwidnpkBztnu/rsZ
 fpOtLJNvAFlzeyf41IpExufCBiT5OMQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-3B3_XYE5MHC_BKRPIHpGjQ-1; Tue, 15 Jul 2025 02:03:15 -0400
X-MC-Unique: 3B3_XYE5MHC_BKRPIHpGjQ-1
X-Mimecast-MFC-AGG-ID: 3B3_XYE5MHC_BKRPIHpGjQ_1752559394
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so11077645e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559394; x=1753164194;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjFMQMHpd53Ih+uZb3O1wDNqKyNpbD2eFNxnT3Q2dQk=;
 b=usMx6mA8OCbRStQEad2hA/Y1R74ntwSMArndm6URqU2ZhlBsNkBkzPMNcHVYi1eb7n
 6VGQmbUJYzZimpwh7HgpT1MksZTXsMuOtAtaL1ue9jGQKp5GZWbA8Z+r1eTWYT5AWLRn
 uv9TYkcOkvUYhLyOl58g4oqNSK6rz7C7IYxwE2AOcntgdWTImRvoXwwl47hBaZNh83qE
 RtBngPHdijGDpl5DQkKExl0JDtaXN9627rPChVqzaUGbbTY7eTFqYSTPxmMWxjcDcgto
 ghdzMxDCvXIZuQf3Z+m8VRj9Mf6oewj95xx7hGlt+b/J5veIp/qKRt4FldZQCuA3Hudt
 H7zg==
X-Gm-Message-State: AOJu0Yy1Yx/3r4t9cfozUX0fEAVAiBYAwFvXBoVWz5Q4gK8jnKaUf2ID
 sF+XaGXY+7cZzCiPqb0UVo/sajNqgGKAdKer0EiFym6rNFwTC3TIqYFHS8va65Z8L/SYj98sWNb
 JYFDqzNHvFBcKnbCYRQh6bFSto2HIYLsnZ8PXkmtNowui2H/rf7lppG3H
X-Gm-Gg: ASbGnctG59iuIGvSC/nGvirauead7XEhkj3GbbOIjcLn4oVM3ysCuJ5A2KkfVLliGbW
 h/Xlzzu5KwGo5gD3irUn3UcDQFbTPQ+cX7ntRpiulBb+tjEZ6zt0deu0cy6iiUh+Siae+wzDI3m
 aC5Z8pwD42+IJ5amkMX4X4CRcOFlkRq+4LWeYPrZNngTc7eCstnHlAIvYxE5QtXAAz4gJJNDpyJ
 BPuCub8WRCemIlAH83SulrUMtprrmzt8W5S/TvYc/tJJLiS9fDkN81BZauYZrpC3lQR+7Ks6kRH
 9LutvosXYEh6ze8BRaMGOlzbiaMhrSpVlBt1pBMIBvcVzjil2Oo0kmUKs1kgzH287hYluu+QZco
 =
X-Received: by 2002:a05:600c:6290:b0:456:1f89:2483 with SMTP id
 5b1f17b1804b1-4561f892ed3mr38435975e9.26.1752559394219; 
 Mon, 14 Jul 2025 23:03:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjKV7CEcq2paulxaHBrAkWMPh4CMu07npciYHEmQAo8mfShUSJM74oeyILiQtwhUyuRO/sKw==
X-Received: by 2002:a05:600c:6290:b0:456:1f89:2483 with SMTP id
 5b1f17b1804b1-4561f892ed3mr38435645e9.26.1752559393689; 
 Mon, 14 Jul 2025 23:03:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd540b52sm151201805e9.28.2025.07.14.23.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:03:13 -0700 (PDT)
Message-ID: <40574987-05ed-494e-8cb9-00795a50ac91@redhat.com>
Date: Tue, 15 Jul 2025 08:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/pci: Introduce x-pci-class-code option
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250708145211.6179-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250708145211.6179-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/8/25 16:52, Tomita Moeko wrote:
> Introduce x-pci-class-code option to allow users to override PCI class
> code of a device, similar to the existing x-pci-vendor-id option. Only
> the lower 24 bits of this option are used, though a uint32 is used here
> for determining whether the value is valid and set by user.
> 
> Additionally, to ensure VGA ranges are only exposed on VGA devices,
> pci_register_vga() is now called in vfio_pci_config_setup(), after
> the class code override is completed.
> 
> This is mainly intended for IGD devices that expose themselves either
> as VGA controller (primary display) or Display controller (non-primary
> display). The UEFI GOP driver depends on the device reporting a VGA
> controller class code (0x030000).
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>


Applied to vfio-next.

Thanks,

C.


> ---
> v3:
> * Save the vdev class code when it is unspecified.
> * Call pci_register_vga() in vfio_pci_config_setup() to ensure VGA
>    regions are only get exposed when vdev is VGA.
> * Check vdev class code in vfio_is_vga().
> Link: https://lore.kernel.org/qemu-devel/20250528155548.29344-1-tomitamoeko@gmail.com/
> 
> v2:
> * Add vdev class code check in vfio_populate_vga().
> * Fix type in trace-events.
> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
> 
>   hw/vfio/pci.c        | 29 +++++++++++++++++++++++++----
>   hw/vfio/pci.h        |  6 ++----
>   hw/vfio/trace-events |  1 +
>   3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28df7..910042c6c2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2893,10 +2893,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>                             "vfio-vga-io@0x3c0",
>                             QEMU_PCI_VGA_IO_HI_SIZE);
>   
> -    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
> -                     &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
> -                     &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
> -
>       return true;
>   }
>   
> @@ -3228,6 +3224,23 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>                                                 vdev->sub_device_id);
>       }
>   
> +    /*
> +     * Class code is a 24-bit value at config space 0x09. Allow overriding it
> +     * with any 24-bit value.
> +     */
> +    if (vdev->class_code != PCI_ANY_ID) {
> +        if (vdev->class_code > 0xffffff) {
> +            error_setg(errp, "invalid PCI class code provided");
> +            return false;
> +        }
> +        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
> +        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
> +                               vdev->class_code << 8, ~0xff);
> +        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
> +    } else {
> +        vdev->class_code = pci_get_long(pdev->config + PCI_CLASS_REVISION) >> 8;
> +    }
> +
>       /* QEMU can change multi-function devices to single function, or reverse */
>       vdev->emulated_config_bits[PCI_HEADER_TYPE] =
>                                                 PCI_HEADER_TYPE_MULTI_FUNCTION;
> @@ -3257,6 +3270,12 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>       vfio_bars_register(vdev);
>   
> +    if (vdev->vga && vfio_is_vga(vdev)) {
> +        pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
> +                         &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
> +                         &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
> +    }
> +
>       return true;
>   }
>   
> @@ -3643,6 +3662,8 @@ static const Property vfio_pci_dev_properties[] = {
>                          sub_vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                          sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
> +                       class_code, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>       DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                      nv_gpudirect_clique,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 495fae737d..4aa6461117 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -157,6 +157,7 @@ struct VFIOPCIDevice {
>       uint32_t device_id;
>       uint32_t sub_vendor_id;
>       uint32_t sub_device_id;
> +    uint32_t class_code;
>       uint32_t features;
>   #define VFIO_FEATURE_ENABLE_VGA_BIT 0
>   #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
> @@ -205,10 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t de
>   
>   static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> -    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
> -
> -    return class == PCI_CLASS_DISPLAY_VGA;
> +    return (vdev->class_code >> 8) == PCI_CLASS_DISPLAY_VGA;
>   }
>   
>   /* MSI/MSI-X/INTx */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8ec0ad0cde..fc6ed230d0 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -48,6 +48,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>   vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
>   vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>   vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
> +vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
>   
>   # pci-quirks.c
>   vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"


