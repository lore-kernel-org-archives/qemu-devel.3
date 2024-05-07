Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3714C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Esv-0008Ld-Bt; Tue, 07 May 2024 03:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Esq-0008L9-F0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Eso-0005tm-9H
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715065500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVAqjg7Hgn3nprLRs5LQRaoVcIylBktO9XNtobYUmUs=;
 b=b8mPIhNeZ8GZaKyrQaf+twxfGegGW40YeGKAyh5BORj8m76lmwEkzpEjeEAc0tq/6rXjIb
 gLzSTmrNEjNXb3xYtAOi8Y07UKam5xjMp9pfygF2pVOSZZddwsiOO0i73gZTk/XAPibRr2
 Hrqtp0KUQUKHauUUAZtMRJfgHZso40I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-TYTFInrgNDeNUtavE8yDYQ-1; Tue, 07 May 2024 03:04:59 -0400
X-MC-Unique: TYTFInrgNDeNUtavE8yDYQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7928abc8eddso444861785a.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715065498; x=1715670298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rVAqjg7Hgn3nprLRs5LQRaoVcIylBktO9XNtobYUmUs=;
 b=YwLYbYZfRuZomtDr5Bqtvu2mdFZxK4DKF6VRP+0x1E0CUqIkLfkYK+IBtV99KSbRTV
 H/U0ES6nSgODXqO2yI8U9y8TOVJKanSybO9hQI/tT0YpGoqq9biKMbF8EuJCGsB55E0I
 kcp90x7+Q+ynEGff3iHQKbSglexcTiXAEiTRlW+tscbA6Hvb+Cz1YPNJkMAiGN41dYtM
 GfEHfMg5PiPB+yUWtP7Vrd52Lf8c9b85DuMxJ/QgCItrhvhQjpQZYP+np3LRDFOUpLLc
 tMlVaaSl9LcMdqC5J+BQhfnnUfNmS+YXqJvIpyOupqa1X5KSutKjYpTqMJbN5S54O55I
 41qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWc0p/ObUlXNRoAV82fSJY47uJjqifSwWzOq2VSprus/zaNkJQS80AiAdHemWlMhzEFHGqRhel2bT9fpxWBgNmkpbo/kk=
X-Gm-Message-State: AOJu0Yzy0nDCCpvRgGVEeq3GH0D268RlOn0dMN9RdXuBlHCKZtPRcgin
 Sz1zmpCEd6YJBaFkwSKv9Fs+mwj5l+GmlMOKC7P2UwsQZOPfqNI0UMeG1f7vfyXPYic+QOuGbCq
 /5SvrRJFAcEhe7GBTcqUCMZaGLli6p5IC71GUPdBx/pZy+YPFmxE6
X-Received: by 2002:a05:620a:118b:b0:792:91e1:2c5a with SMTP id
 b11-20020a05620a118b00b0079291e12c5amr7703427qkk.68.1715065498404; 
 Tue, 07 May 2024 00:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP5A+1p6YUhwKfIKwMq5nlIli/Rfb5348HzIadx72tSgmciB1YBbpC9m95opHf+5yralEdHw==
X-Received: by 2002:a05:620a:118b:b0:792:91e1:2c5a with SMTP id
 b11-20020a05620a118b00b0079291e12c5amr7703407qkk.68.1715065498071; 
 Tue, 07 May 2024 00:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 po3-20020a05620a384300b007929547c02bsm2055176qkn.129.2024.05.07.00.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:04:57 -0700 (PDT)
Message-ID: <adb10cf9-faff-41f1-a6e4-e7c169f16c72@redhat.com>
Date: Tue, 7 May 2024 09:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-16-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240429065046.3688701-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Zhenzhong,

On 4/29/24 08:50, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> pci_device_[set|unset]_iommu_device() call pci_device_get_iommu_bus_devfn()
> to get iommu_bus->iommu_ops and call [set|unset]_iommu_device callback to
> set/unset HostIOMMUDevice for a given PCI device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/pci/pci.h | 38 +++++++++++++++++++++++++++++++++++++-
>   hw/pci/pci.c         | 27 +++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eaa3fc99d8..849e391813 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -3,6 +3,7 @@
>   
>   #include "exec/memory.h"
>   #include "sysemu/dma.h"
> +#include "sysemu/host_iommu_device.h"

This include directive pulls a Linux header file <linux/iommufd.h>
which doesn't exist on all platforms, such as windows and it breaks
compile. So,

>   
>   /* PCI includes legacy ISA access.  */
>   #include "hw/isa/isa.h"
> @@ -383,10 +384,45 @@ typedef struct PCIIOMMUOps {
>        *
>        * @devfn: device and function number
>        */
> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
> +     *
> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
> +     * retrieve host information from the associated HostIOMMUDevice.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     *
> +     * @dev: the data structure representing host IOMMU device.
> +     *
> +     * @errp: pass an Error out only when return false
> +     *
> +     * Returns: 0 if HostIOMMUDevice is attached, or else <0 with errp set.
> +     */
> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                            HostIOMMUDevice *dev, Error **errp);
> +    /**
> +     * @unset_iommu_device: detach a HostIOMMUDevice from a vIOMMU
> +     *
> +     * Optional callback.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     */
> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>   } PCIIOMMUOps;
>   
>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
> +                                Error **errp);

please include a forward declaration for HostIOMMUDevice instead.

Thanks,

C.




> +void pci_device_unset_iommu_device(PCIDevice *dev);
>   
>   /**
>    * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 02a4bb2af6..c3293e9357 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>       return &address_space_memory;
>   }
>   
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
> +                                Error **errp)
> +{
> +    PCIBus *iommu_bus;
> +
> +    /* set_iommu_device requires device's direct BDF instead of aliased BDF */
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
> +        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
> +                                                      iommu_bus->iommu_opaque,
> +                                                      dev->devfn, hiod, errp);
> +    }
> +    return 0;
> +}
> +
> +void pci_device_unset_iommu_device(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
> +        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
> +                                                        iommu_bus->iommu_opaque,
> +                                                        dev->devfn);
> +    }
> +}
> +
>   void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>   {
>       /*


