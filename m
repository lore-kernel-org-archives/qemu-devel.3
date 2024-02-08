Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98DEC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1X9-0001cA-Ff; Thu, 08 Feb 2024 05:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY1X7-0001bS-BY
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY1X5-00022P-TJ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707387687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uyhl4gljIvylUxxsk4RjoaeNUwT3guyr/FMP3HOu0OI=;
 b=ZG3bDDePpQrvuse3EhKJ8eZojKUUK7hjWV09ezNWxFOluEwur2gibuseA63/1EgQXYu6SR
 Kiz8yoGGgR/guK2xoJDHo7OwNKC+MQYAWHcZiEQI4D06JBphLYAB9SC617ykqbDEqvRYbT
 PznWG/TsfeCJUc4lOmnFgdcwawo66fc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-mAArt141O-O_TF3xnBq1fg-1; Thu, 08 Feb 2024 05:21:25 -0500
X-MC-Unique: mAArt141O-O_TF3xnBq1fg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78408c4e2c2so186592685a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707387684; x=1707992484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uyhl4gljIvylUxxsk4RjoaeNUwT3guyr/FMP3HOu0OI=;
 b=WzIp43mPGqwZV50U1XAUmsNFaB9JUxk3Ne/99CIsjfHG7mOiFwrE9Ur3LTEl35+F15
 TaWD4t0BhOiPRD7mfAgKPKD3dR9X5aDjwAqBNVJqPtIz8F7fphe/V1p3Wu8Z+5a3RFLW
 aRh3KTalFMCYnMCgI6TMuS9bBX47zTofnbbvpQKD93jT8BTB6WYmf8V6UXW22VseiZT+
 TEfImbFhMPOBeA8OGrPZra5n6ZlYlKtMR8lZP11xK8K4op7+c2gydz1mIFyOBvuKV61R
 Ht57s+DGEeDNSzC7v4qKy1RYFd8qNUaeQXqa+PYZNV20Ckayy575Vc9NOHyseIJcem/R
 YIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWObhIElwLInAqTXvb0wbDH6M8DjdCQdpEb/IlbzBRAfcE+3We6u/HNkUUets1dkjoYiLR2V50kEhtzgygLQTQ3K8gj8o0=
X-Gm-Message-State: AOJu0Yw+BcsJX03LdM1w8i+1WNUyvy6Cfa4dIpqKUMuF6rDCK0n9nr+x
 nYqaqmYXo/iyMK/Ikp6hqQASbNBnhRuM6d3jwO+L4gfRCjDZsnziFFi4uPj12T/33EESvoWtLv3
 rlwzivFkbGDfYKExVrCX+OrEOU3eMN93PyCZCTeTffH99FLADi89l
X-Received: by 2002:a05:620a:21c7:b0:785:5fde:bf32 with SMTP id
 h7-20020a05620a21c700b007855fdebf32mr7869463qka.68.1707387683911; 
 Thu, 08 Feb 2024 02:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1kx5WzitmZPmhX/fiEEpruOKnUdGdKflcVCl5lINOr7QKaRwEZf5V1uFku2vb0gx2OqwFdw==
X-Received: by 2002:a05:620a:21c7:b0:785:5fde:bf32 with SMTP id
 h7-20020a05620a21c700b007855fdebf32mr7869446qka.68.1707387683525; 
 Thu, 08 Feb 2024 02:21:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXXfg+U6omYLmE9pV2gaJm8GDpBHjBClhpAZPkgYIiIBnjcWq+bjhZT9kIWZ2tXySRhZRJZCMN7+DJcgRFuxI9a/5ZiVFrIzBXA+8Pcmqr7fTxoENx05uxC7Kamja9l/U99wZiFiB84dP3vnZANl/6iivV5inlw/jd+tNwzs/BBL1RnK7q2C9Tw/RFNyH5a1yocvDgkEBNWEHzoDEqM6/469RUbyFiKHmgtErk8jEoVKRpFdmmgqNrkefikG2DczgIEM+aoiev6uZi2ao/wEKMgoXA08ypIGMsTgZYJ36AUNw2e3eBdbOThMk184TmvcVYmTLf8K32yu5gfnG0=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 oo20-20020a05620a531400b00783f534706esm1283323qkn.61.2024.02.08.02.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 02:21:23 -0800 (PST)
Message-ID: <8c0ac34a-58cb-4301-8293-e58596c208f2@redhat.com>
Date: Thu, 8 Feb 2024 11:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35 and arm virt
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 mst@redhat.com, peter.maydell@linaro.org, zhenzhong.duan@intel.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com
References: <20240208101128.655167-1-eric.auger@redhat.com>
 <20240208101128.655167-4-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240208101128.655167-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/8/24 11:10, Eric Auger wrote:
> Currently the default input range can extend to 64 bits. On x86,
> when the virtio-iommu protects vfio devices, the physical iommu
> may support only 39 bits. Let's set the default to 39, as done
> for the intel-iommu. On ARM we set 48b as a default (matching
> SMMUv3 SMMU_IDR5.VAX == 0).
> 
> We use hw_compat_8_2 to handle the compatibility for machines
> before 9.0 which used to have a virtio-iommu default input range
> of 64 bits.
> 
> Of course if aw-bits is set from the command line, the default
> is overriden.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Yanghang Liu<yanghliu@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
> 
> v2 -> v3:
> - collected Zhenzhong's R-b
> - use &error_abort instead of NULL error handle
>    on object_property_get_uint() call (Cédric)
> - use VTD_HOST_AW_39BIT (Cédric)
> 
> v1 -> v2:
> - set aw-bits to 48b on ARM
> - use hw_compat_8_2 to handle the compat for older machines
>    which used 64b as a default
> ---
>   hw/arm/virt.c            | 6 ++++++
>   hw/core/machine.c        | 5 ++++-
>   hw/i386/pc.c             | 6 ++++++
>   hw/virtio/virtio-iommu.c | 2 +-
>   4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 368c2a415a..0994f2a560 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2716,10 +2716,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", &error_abort);
>           hwaddr db_start = 0, db_end = 0;
>           QList *reserved_regions;
>           char *resv_prop_str;
>   
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", 48);
> +        }
> +
>           if (vms->iommu != VIRT_IOMMU_NONE) {
>               error_setg(errp, "virt machine does not support multiple IOMMUs");
>               return;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..70ac96954c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,9 +30,12 @@
>   #include "exec/confidential-guest-support.h"
>   #include "hw/virtio/virtio-pci.h"
>   #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> -GlobalProperty hw_compat_8_2[] = {};
> +GlobalProperty hw_compat_8_2[] = {
> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
> +};
>   const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
>   
>   GlobalProperty hw_compat_8_1[] = {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 196827531a..ee2d379c90 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1456,6 +1456,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits = object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", &error_abort);
>           /* Declare the APIC range as the reserved MSI region */
>           char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>                                                 VIRTIO_IOMMU_RESV_MEM_T_MSI);
> @@ -1464,6 +1466,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>           qlist_append_str(reserved_regions, resv_prop_str);
>           qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>   
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", VTD_HOST_AW_39BIT);
> +        }
> +
>           g_free(resv_prop_str);
>       }
>   
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 7870bdbeee..c468e9b13b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] = {
>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                        TYPE_PCI_BUS, PCIBus *),
>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


