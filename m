Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00628C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Pv-0001ed-LI; Tue, 12 Mar 2024 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5Pj-0001bq-0k
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5Pg-00078c-C0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710262538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSQdOV9+UFl6iHdm2F0NdvdWTdVRmAMr8rskNMI3LbM=;
 b=GG6ZYYtX/VaMQsn8Ua5P8OupfetV9/KsxJ1Zoi3j+fqJ0bHo1kV+R41eYfVU8ytbsS2NtJ
 HTsBBmcawk8HgUFOvwXPW9HOjE5ClZxvOyYhsCFiGrCnQzSfbHJD311YmB7eF8itz8mQXQ
 3DVzXkLd8RZyaYKkwp4QIwO95a3p74c=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-43B8yaCyOqyj-2wRigKd7g-1; Tue, 12 Mar 2024 12:55:36 -0400
X-MC-Unique: 43B8yaCyOqyj-2wRigKd7g-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a20c33f0bso47192787b3.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262531; x=1710867331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSQdOV9+UFl6iHdm2F0NdvdWTdVRmAMr8rskNMI3LbM=;
 b=kLdbtw1TEErDDEznIhLzC99P8mCZTSyEUSHIgiAu9gnv7kKw0xaNeoegydacG1N52x
 QoIOVN4rTEljpQFpoOIbI6znOl6e4HWmb/cRSoLwHm97aSRuK4d3nJOYbaMuBLzeR5f7
 pjB47SjPtWMELRjp1wPBCUarn2Zv0qIJh9wbck9T8xNJ4w/GO0/wYmrBEr4FxvD8GBFf
 F57JBupzLWwdcioby5kZVVPajgpXuIUJQz5BK5K0IPqX4Hx54Rs3kJgUphIn23eS137R
 +SiMDaiu2eGn21EN/aP7IY+PvxoD3G8aG7wBNhz+433bDylLZLz3sjFwR93inkLwW0vT
 5knw==
X-Gm-Message-State: AOJu0YwJqVhwFccfv+i0jWYVUpLvhHLfuUunoIvgKSHv3XKhQNoBcb2g
 TrM6pjEXCboU1ZW80yuOo1apsOO3hcXp5A+IPY2Cw7/B9uD54Mdlqgi31Ue8RLzk1G22Xi6N66S
 8g3OSsOY1F4tCJTF0vk2XpfnKJpG0Lp28FIf9sgjEo/zkXq/Cyvb5
X-Received: by 2002:a0d:dd13:0:b0:60a:66d3:bce9 with SMTP id
 g19-20020a0ddd13000000b0060a66d3bce9mr29494ywe.26.1710262530631; 
 Tue, 12 Mar 2024 09:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf52igNZqyES828bI419taaYqwCTwHwVgV6u4HFx8yE4+6g4wyvZlZastB7ssp2DGcqvCwmw==
X-Received: by 2002:a0d:dd13:0:b0:60a:66d3:bce9 with SMTP id
 g19-20020a0ddd13000000b0060a66d3bce9mr29467ywe.26.1710262530123; 
 Tue, 12 Mar 2024 09:55:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a0dcc10000000b0060a4371759bsm973829ywd.52.2024.03.12.09.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:55:29 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:55:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 09/11] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Message-ID: <20240312125422-mutt-send-email-mst@kernel.org>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-10-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228035900.1085727-10-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 28, 2024 at 11:58:58AM +0800, Zhenzhong Duan wrote:
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
> index fa6313aabc..8fe6f746d7 100644
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
>  } PCIIOMMUOps;


So I expected someone to implement these new callbacks but I see
no implementation in this patchset.

Is this just infrastructure that will be used later?
A bit hard to judge without a user ...



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
> -- 
> 2.34.1


