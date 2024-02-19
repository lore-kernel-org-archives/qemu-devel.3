Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D99C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc7dx-0008Uw-Mx; Mon, 19 Feb 2024 12:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7dv-0008U0-Th
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7du-0005q3-41
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708364485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZNlYVbP0mXJhEhPIFEmnqiVyeafBoYRjMH0nFuswzI=;
 b=GcpLx31SAB0umOtoEkjjziuhQ+FpBjekRZPbPMziHz+JUBIHShGe6E5HAmzzlBva7lO2R4
 vLKljrZ+5grefP5P858w0AVBQAPQuSbEzRK28mF8dJAuPTWQurHryD02KeAkUSAEQ3FZ5B
 p+0V34DraT3GEWXoyz10j0lTMYA/ClU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-mtIF7rITPdyV6AF1R5qNEg-1; Mon, 19 Feb 2024 12:41:23 -0500
X-MC-Unique: mtIF7rITPdyV6AF1R5qNEg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e2e6992dc4so2866722a34.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708364482; x=1708969282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZNlYVbP0mXJhEhPIFEmnqiVyeafBoYRjMH0nFuswzI=;
 b=amWD/o90XwOODd6YswVJwsqOsjw6Oa0trF7Lt4gNB+R9Kf6XGKv/2tPpZNbfBMp7J8
 0jqiaA4d78BBiuNi9cYlEtk5w90ysIdxzCNoC8nhN9t8ldnIsXexM4Hl6BRnmF0MUijg
 0tPMWVc0jSJVIWAfpAHsnZ3JqUusE7RxPd+jjxnmkSV5+sx9LBiyD8s7KOF5rwXUV8w/
 wYrqNO8c7cgeeOZOAbNzBkINmIVWCf3hgoRhO7cgHsij9rFT76wNkQuVO8OIbjfAzfRI
 YZWP4yfJQf9qoJMCenxjZ8zOu5JYtWg2fV0QC5AvcYPJZSqmyIugm+wbth768z3OOQpF
 pa+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm5z4eZ2UFc0rsOeiazLt/oOvYjNAKaA0QngYDu1PxiNbtcoo7Cu054EGqMrdYN6h4qjpA6laamDWAWnTOPvmJEzjLLwY=
X-Gm-Message-State: AOJu0Yw3RvNWgKHBjjIG43Dfk83Av38znQdejBJB3rNhsd3RvRcNkBKf
 IZGVtG4CKX/bjNGPN4zaj1HumglA3vrBVrYIxmYkcE6fOx9arg0O21WvRf31P9mA5u2tbF9A8w/
 qGYwKpMLtJYlBKAXg1xquU7Xj/XSP7MriPc6FvT7dxuRMDEMdhFo3
X-Received: by 2002:a05:6808:19a6:b0:3c1:48de:5f1a with SMTP id
 bj38-20020a05680819a600b003c148de5f1amr9665329oib.11.1708364482273; 
 Mon, 19 Feb 2024 09:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/SJ14MVP/Ke0b9mRY2+K0chxMrc5KVqjI5P6cYN8KEuc7QPK3GfmUA2W2J2ulavgDW0GNzw==
X-Received: by 2002:a05:6808:19a6:b0:3c1:48de:5f1a with SMTP id
 bj38-20020a05680819a600b003c148de5f1amr9665299oib.11.1708364481929; 
 Mon, 19 Feb 2024 09:41:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 md10-20020a056214588a00b0068d137664e3sm3465510qvb.134.2024.02.19.09.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 09:41:21 -0800 (PST)
Message-ID: <7b1de385-a79a-4a91-b0f6-ba6b32894b71@redhat.com>
Date: Mon, 19 Feb 2024 18:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 10/18] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-11-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240201072818.327930-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 2/1/24 08:28, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds pci_device_set/unset_iommu_device() to set/unset
> HostIOMMUDevice for a given PCIe device. Caller of set
> should fail if set operation fails.
>
> Extract out pci_device_get_iommu_bus_devfn() to facilitate
> implementation of pci_device_set/unset_iommu_device().
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/pci/pci.h | 38 ++++++++++++++++++++++++++-
>  hw/pci/pci.c         | 62 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 96 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index fa6313aabc..5b471fd380 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -3,6 +3,7 @@
>  
>  #include "exec/memory.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/host_iommu_device.h"
>  
>  /* PCI includes legacy ISA access.  */
>  #include "hw/isa/isa.h"
> @@ -384,10 +385,45 @@ typedef struct PCIIOMMUOps {
>       *
>       * @devfn: device and function number
>       */
> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @set_iommu_device: set iommufd device for a PCI device to vIOMMU
attach a HostIOMMUDevice to a vIOMMU
> +     *
> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
> +     * utilize iommufd specific features.
looks too iommufd specific. Then vIOMMU can't retrieve host information
from the associated HostIOMMUDevice
> +     *
> +     * Return true if iommufd device is accepted, or else return false with
s/accepted/attached
> +     * errp set.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     *
> +     * @dev: the data structure representing host assigned device.
> +     *
> +     */
> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                            HostIOMMUDevice *dev, Error **errp);
> +    /**
> +     * @unset_iommu_device: unset iommufd device for a PCI device from vIOMMU
same suggestion here
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
>  } PCIIOMMUOps;
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> +                                Error **errp);
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>  
>  /**
>   * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580..8078307963 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2672,11 +2672,14 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>      }
>  }
>  
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                                           PCIBus **aliased_bus,
> +                                           PCIBus **piommu_bus,
> +                                           int *aliased_devfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> -    uint8_t devfn = dev->devfn;
> +    int devfn = dev->devfn;
>  
>      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2717,13 +2720,66 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +    assert(iommu_bus);
> +
> +    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
> +        iommu_bus = NULL;
> +    }
> +
> +    *piommu_bus = iommu_bus;
> +
> +    if (aliased_bus) {
> +        *aliased_bus = bus;
> +    }
> +
> +    if (aliased_devfn) {
> +        *aliased_devfn = devfn;
> +    }
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    if (iommu_bus) {
>          return iommu_bus->iommu_ops->get_address_space(bus,
>                                   iommu_bus->iommu_opaque, devfn);
>      }
>      return &address_space_memory;
>  }
>  
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> +                                Error **errp)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
> +        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
> +                                                      iommu_bus->iommu_opaque,
> +                                                      dev->devfn, base_dev,
> +                                                      errp);
> +    }
> +    return 0;
> +}
> +
> +void pci_device_unset_iommu_device(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
> +        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
> +                                                        iommu_bus->iommu_opaque,
> +                                                        dev->devfn);
> +    }
> +}
> +
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      /*
Eric


