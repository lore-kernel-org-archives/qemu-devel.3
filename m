Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4KV-0005WD-DB; Tue, 27 Feb 2024 15:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rf15G-0004BY-SD
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rf15F-0000JD-At
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709054255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0W6NjHy1O3beFA83G2xH6CBA5TI/HWbpIhKHp3KIHk=;
 b=evdzJt3az6tth10Rhet0fLNxKRTVSRze625sQiyOI46LNd3FmtivgQ89nzIbdVTb9Ea7Qk
 o+1pP5ut7g+pewyIvXSwrBxLUvnx/CzyhvqiCQV/AfmovnP0ZMaG+YOosy/6m0Czvzm1B/
 fxoQgvKu/1kSawZ3no+MQtzY7f7aDsY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-5vUU9NCMOPqKzwCGML3WyA-1; Tue, 27 Feb 2024 12:17:33 -0500
X-MC-Unique: 5vUU9NCMOPqKzwCGML3WyA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42e3fa7e328so53412781cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709054253; x=1709659053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0W6NjHy1O3beFA83G2xH6CBA5TI/HWbpIhKHp3KIHk=;
 b=kp9OrtArYOwomQrg1oelR3pafUc/39FFd4CsfHCCVlT3qQ+b+qZ6HJxOq9mUfG59ib
 xa6zWUrSShk7b6kgigPAKwh5aHUqbOgERosCSRGUuRRsWt/smyS+YRhW7Bn/IIal4hZJ
 InZv8gQG1thafld5mUIiYrTZIjZnXf8MCazaWEMOk056hBi+IlJOUntPsT9f58krGNlj
 23gQDR+WkXiCw1maRn5ZjgjsSwAfYUKS0xnhqeuOlbmJeGevUvtRYTWq6Bnbz14gKO/3
 5CKDExS0NHVN0vR00iiyppo51WfMyUCe935rsdScG11qWh9naoxM0s5hjWMo8WprC8SP
 mqOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4EW9X/XBwn0tcYHKnd9i8jWSvqt8bhSgIf4OXKQsRSob57KM4ZP+J2fj/SawL+yK5jO0B/HafxoB4mkYiC5tH8eg9N1Y=
X-Gm-Message-State: AOJu0YyYj0puAWEpNziZ3KXBCfejND13npGVuHC5DD7HYCURjO4gAOfQ
 Wwp/XdqHYRt4a3ZOtZRrQ0X7TIR2wiK7NQKxjozRilsD8bx1/RwGb9EFvqGE+KSm2NXwwogvPaw
 721KpVE/8DbPdkJbRtPS+88UVRjHijKZQpz9nzz+6rtoGy5NyoQO/
X-Received: by 2002:a05:622a:113:b0:42d:feeb:64df with SMTP id
 u19-20020a05622a011300b0042dfeeb64dfmr11952233qtw.36.1709054252751; 
 Tue, 27 Feb 2024 09:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh8sVj+p4iqtjKvqGhJP2V9uS34S1iv0f/rdInoHJBaPReu+sOm9R8LtdBiwXKkeKSLDtkIw==
X-Received: by 2002:a05:622a:113:b0:42d:feeb:64df with SMTP id
 u19-20020a05622a011300b0042dfeeb64dfmr11952200qtw.36.1709054252402; 
 Tue, 27 Feb 2024 09:17:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fp7-20020a05622a508700b0042e6d2dd6bbsm3711686qtb.11.2024.02.27.09.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 09:17:31 -0800 (PST)
Message-ID: <2259fba1-4c57-420b-bcab-ecf202d10819@redhat.com>
Date: Tue, 27 Feb 2024 18:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw: Set virtio-iommu aw-bits default value on
 pc_q35 and arm virt
Content-Language: en-US, fr
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 mst@redhat.com, peter.maydell@linaro.org, zhenzhong.duan@intel.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com
References: <20240215084315.863897-1-eric.auger@redhat.com>
 <20240215084315.863897-4-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240215084315.863897-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:23 -0500
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

Hello Eric,

On 2/15/24 09:42, Eric Auger wrote:
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

We need a property fixup for pseries also:

$ build/ppc64-softmmu/qemu-system-ppc64 -M pseries  -device virtio-iommu-pci,addr=04.0
qemu-system-ppc64: -device virtio-iommu-pci,addr=04.0: aw-bits must be within [32,64]


Thanks,

C.



> ---
> 
> v3 -> v4:
> - update the qos test to relax the check on the max input IOVA
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
>   hw/arm/virt.c                   | 6 ++++++
>   hw/core/machine.c               | 5 ++++-
>   hw/i386/pc.c                    | 6 ++++++
>   hw/virtio/virtio-iommu.c        | 2 +-
>   tests/qtest/virtio-iommu-test.c | 2 +-
>   5 files changed, 18 insertions(+), 3 deletions(-)
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
> index 8b541de850..2ec5ef3cd1 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1526,7 +1526,7 @@ static Property virtio_iommu_properties[] = {
>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                        TYPE_PCI_BUS, PCIBus *),
>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
> index 068e7a9e6c..0f36381acb 100644
> --- a/tests/qtest/virtio-iommu-test.c
> +++ b/tests/qtest/virtio-iommu-test.c
> @@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
>       uint8_t bypass = qvirtio_config_readb(dev, 36);
>   
>       g_assert_cmpint(input_range_start, ==, 0);
> -    g_assert_cmphex(input_range_end, ==, UINT64_MAX);
> +    g_assert_cmphex(input_range_end, >=, 32);
>       g_assert_cmpint(domain_range_start, ==, 0);
>       g_assert_cmpint(domain_range_end, ==, UINT32_MAX);
>       g_assert_cmpint(bypass, ==, 1);


