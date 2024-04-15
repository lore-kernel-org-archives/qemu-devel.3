Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECF2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMTT-00056B-UK; Mon, 15 Apr 2024 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMTS-00055u-9o
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMTP-0003hs-8P
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713188054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbhXMDavblqnysjaxgpjrBlOO7/UYo3xs8Ugruns2Ag=;
 b=UyHhNsuLHY6ufWNp9RufHnOapLG4iWjFdLmkk2kTAvzQijqrvhK6gHq1klVMSOEMYpSuvp
 iAGPF8wms/o3QKedT2KBJhslVvVRhmD7ir5XVLj7sZHkUOcrTkbBMv+6D0KN46epydHUig
 R2gokvjgZtdydswI23hSSeNDPUXWJQk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-klYIk0ANNwG4K0KQsDGQpQ-1; Mon, 15 Apr 2024 09:34:13 -0400
X-MC-Unique: klYIk0ANNwG4K0KQsDGQpQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78a43601cddso288343885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713188052; x=1713792852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbhXMDavblqnysjaxgpjrBlOO7/UYo3xs8Ugruns2Ag=;
 b=DHmTMixkUsXQM8tTY9uD9Q6zvOFSJ9zzp9GeMMX+HDFuNnviQUKhKyo3UGRJwhEEHa
 LrCYK61jy6DQVal8E2Vm36zCLcFePuM6YgTIpyd55GWNBRJJddh3gBuqGnWY++42i1A8
 2sWm2dXjuFsgi0Syk1O3LV9Bher5/EVt/V+sLufmFGRo7oT5QST5ophr05CUv4iIBc9v
 zkFrRMeTbhyrRc99ANTbWQoeAx2bs7mOWC+G5KGa1AC+wj3vzBFoF2livrgclsZHJO41
 aKyHAuAtXURhF3b/5e1RbUsxKBQ10X0wZ2Tqq4YcSEsLuh8/tIkXZ9JwX5oL/UjSIelY
 7aeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Hn7HfpLiMBgPCU1V4yw904HNjaDzv5+zRfWPqa2MQuKUs4WLLBgW4k87hMkgRc3XkLgaychZsglQnNfJ47gO7YxIl/s=
X-Gm-Message-State: AOJu0YwUEcN4MO1ym4t4SwwPP3EaQbzPN02qfzwwC3W5AAsr+ELoXeRN
 PeGML9BGiY+94CAwAbC6ub+TFa34YVXvxImUWdCHWV7G9oulmLrcrXQbnHQxXr/9Ipo8ywsKO+S
 dU/gqjQfSytIrXrJc5l4xkX3p7xhXx93hmB+Eowg0F0mGU71bKQQO
X-Received: by 2002:a05:620a:2204:b0:789:e263:2e3c with SMTP id
 m4-20020a05620a220400b00789e2632e3cmr9524679qkh.28.1713188052544; 
 Mon, 15 Apr 2024 06:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkhmSTs1MZcsPnYVgZZ0HXNMW5Fx82F/QoO+M2IoU7av4OH3uiisjpdll561TY7vckYYzyA==
X-Received: by 2002:a05:620a:2204:b0:789:e263:2e3c with SMTP id
 m4-20020a05620a220400b00789e2632e3cmr9524653qkh.28.1713188052196; 
 Mon, 15 Apr 2024 06:34:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a05620a098700b0078ecc54b1b9sm4771241qkx.71.2024.04.15.06.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:34:11 -0700 (PDT)
Message-ID: <24e91342-eec6-4d2a-b271-84c2380533a8@redhat.com>
Date: Mon, 15 Apr 2024 15:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-10-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> This adds pci_device_set/unset_iommu_device() to set/unset
> HostIOMMUDevice for a given PCI device. Caller of set
> should fail if set operation fails.
> 
> Extract out pci_device_get_iommu_bus_devfn() to facilitate

I would separate this change in a prereq patch.


Thanks,

C.


> implementation of pci_device_set/unset_iommu_device().
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/pci/pci.h | 40 ++++++++++++++++++++++-
>   hw/pci/pci.c         | 75 ++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 111 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eaa3fc99d8..4ae7fe6f3f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -3,6 +3,7 @@
>   
>   #include "exec/memory.h"
>   #include "sysemu/dma.h"
> +#include "sysemu/host_iommu_device.h"
>   
>   /* PCI includes legacy ISA access.  */
>   #include "hw/isa/isa.h"
> @@ -383,10 +384,47 @@ typedef struct PCIIOMMUOps {
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
> +     * Return true if HostIOMMUDevice is attached, or else return false
> +     * with errp set.
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
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>   
>   /**
>    * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e7a39cb203..8ece617673 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2648,11 +2648,27 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>       }
>   }
>   
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +/*
> + * Get IOMMU root bus, aliased bus and devfn of a PCI device
> + *
> + * IOMMU root bus is needed by all call sites to call into iommu_ops.
> + * For call sites which don't need aliased BDF, passing NULL to
> + * aliased_[bus/devfn] is allowed.
> + *
> + * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
> + *
> + * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
> + *
> + * @aliased_devfn: return aliased devfn of the PCI device, optional.
> + */
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                                           PCIBus **piommu_bus,
> +                                           PCIBus **aliased_bus,
> +                                           int *aliased_devfn)
>   {
>       PCIBus *bus = pci_get_bus(dev);
>       PCIBus *iommu_bus = bus;
> -    uint8_t devfn = dev->devfn;
> +    int devfn = dev->devfn;
>   
>       while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>           PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2693,13 +2709,66 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>   
>           iommu_bus = parent_bus;
>       }
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
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus) {
>           return iommu_bus->iommu_ops->get_address_space(bus,
>                                    iommu_bus->iommu_opaque, devfn);
>       }
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


