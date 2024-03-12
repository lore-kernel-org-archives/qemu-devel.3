Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E287C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5ee-0004iW-Mg; Tue, 12 Mar 2024 13:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5e0-0004Q6-24
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5dw-0001uI-E6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710263421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xg6qZCMrJoZ7qdlP6h4Xau/cyCcAhyzEFQyTWdBb5ZY=;
 b=i2qEXluIYefdZ9S5isvIW4KdKl6c9dpmmRScOsq4UJRbr2AG0TDmw32OpxNYdymIqYxfhl
 s/jh3oFiz946Au57UF9PnnbZKzfDEoNN9SVmBaaAc0lGKKYnQHnBDEdwFCk+VyNGevcNQn
 UXORhNdArojzH9i+w7cAqrNqgYiqE3A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-D_Fh9kVUPPuvK8BLkHf6Aw-1; Tue, 12 Mar 2024 13:10:19 -0400
X-MC-Unique: D_Fh9kVUPPuvK8BLkHf6Aw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51313b50f1bso3850773e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710263415; x=1710868215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xg6qZCMrJoZ7qdlP6h4Xau/cyCcAhyzEFQyTWdBb5ZY=;
 b=nvYKXZtA4kytujxoWneEiPnQsjBDK3MmB44EnFUuf6DvNIH/bkWr/a8wGabmWI2juG
 rHoj4uVddjp04QscmqpYKjNcPs1UvpdfBksHucbIelLgMCcLZ5yNWME0Zkc+oR8IDi2C
 /nC5gSGaUN3XuP+MRj7x1DBhc99RFlYpCsO2e0btIoiVh6BdDV6Vu1clin5BR6YZ0cQL
 W7XX/x5vIh2RrG0MfcXPjlBJBveg9no40oBZUVkKVWpgyF/ta1PSA+O2a4EoAoQBq/VJ
 DOsuxqc2Pgq9qKBjZEP+nNGbd8CZfwB3WWi49kukfsA3BosgzdPaok5r6HKYCVnYM+9j
 ReYQ==
X-Gm-Message-State: AOJu0YxB9wK78TQJxV1Q3rnc/uK8CxRgbA3X3m6mIOIrHT65IcX/jMl8
 Gv5PTxy/1YUWxbtuioLHsjVR4sBCx0p2/vQeyay5/kMjBM7qxZYbcFt8kg654wBO4axRgBX9cTz
 SlUy9CcH+4BjVoSbHRVoZS96mjc+f92JRk1EU4mhA0SvwOO9ymapD
X-Received: by 2002:a05:6512:3446:b0:513:5dee:3aaa with SMTP id
 j6-20020a056512344600b005135dee3aaamr5521712lfr.68.1710263414663; 
 Tue, 12 Mar 2024 10:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFad8MBpBAJQ3+/+t+etE1Vo347ks1l8KEBg5Z76PuFVYHLdfgLUE+ed1KMPcJ8T0yl4z8kzQ==
X-Received: by 2002:a05:6512:3446:b0:513:5dee:3aaa with SMTP id
 j6-20020a056512344600b005135dee3aaamr5521701lfr.68.1710263414080; 
 Tue, 12 Mar 2024 10:10:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 gw7-20020a05600c850700b004131cf78b4bsm13795555wmb.12.2024.03.12.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:10:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:10:08 -0400
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
Message-ID: <20240312130833-mutt-send-email-mst@kernel.org>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-10-zhenzhong.duan@intel.com>
 <20240312125422-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312125422-mutt-send-email-mst@kernel.org>
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

On Tue, Mar 12, 2024 at 12:55:30PM -0400, Michael S. Tsirkin wrote:
> On Wed, Feb 28, 2024 at 11:58:58AM +0800, Zhenzhong Duan wrote:
> > From: Yi Liu <yi.l.liu@intel.com>
> > 
> > This adds pci_device_set/unset_iommu_device() to set/unset
> > HostIOMMUDevice for a given PCIe device. Caller of set
> > should fail if set operation fails.
> > 
> > Extract out pci_device_get_iommu_bus_devfn() to facilitate
> > implementation of pci_device_set/unset_iommu_device().
> > 
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >  include/hw/pci/pci.h | 38 ++++++++++++++++++++++++++-
> >  hw/pci/pci.c         | 62 +++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 96 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index fa6313aabc..8fe6f746d7 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -3,6 +3,7 @@
> >  
> >  #include "exec/memory.h"
> >  #include "sysemu/dma.h"
> > +#include "sysemu/host_iommu_device.h"
> >  
> >  /* PCI includes legacy ISA access.  */
> >  #include "hw/isa/isa.h"
> > @@ -384,10 +385,45 @@ typedef struct PCIIOMMUOps {
> >       *
> >       * @devfn: device and function number
> >       */
> > -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> > +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> > +    /**
> > +     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
> > +     *
> > +     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
> > +     * retrieve host information from the associated HostIOMMUDevice.
> > +     *
> > +     * Return true if HostIOMMUDevice is attached, or else return false
> > +     * with errp set.
> > +     *
> > +     * @bus: the #PCIBus of the PCI device.
> > +     *
> > +     * @opaque: the data passed to pci_setup_iommu().
> > +     *
> > +     * @devfn: device and function number of the PCI device.
> > +     *
> > +     * @dev: the data structure representing host IOMMU device.
> > +     *
> > +     */
> > +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> > +                            HostIOMMUDevice *dev, Error **errp);
> > +    /**
> > +     * @unset_iommu_device: detach a HostIOMMUDevice from a vIOMMU
> > +     *
> > +     * Optional callback.
> > +     *
> > +     * @bus: the #PCIBus of the PCI device.
> > +     *
> > +     * @opaque: the data passed to pci_setup_iommu().
> > +     *
> > +     * @devfn: device and function number of the PCI device.
> > +     */
> > +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> >  } PCIIOMMUOps;
> 
> 
> So I expected someone to implement these new callbacks but I see
> no implementation in this patchset.
> 
> Is this just infrastructure that will be used later?
> A bit hard to judge without a user ...
> 

Looked at the second part of the patchset now (dealing with VTD).
Let's continue the discussion there.

> 
> >  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> > +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> > +                                Error **errp);
> > +void pci_device_unset_iommu_device(PCIDevice *dev);
> >  
> >  /**
> >   * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 76080af580..8078307963 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2672,11 +2672,14 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
> >      }
> >  }
> >  
> > -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> > +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> > +                                           PCIBus **aliased_bus,
> > +                                           PCIBus **piommu_bus,
> > +                                           int *aliased_devfn)
> >  {
> >      PCIBus *bus = pci_get_bus(dev);
> >      PCIBus *iommu_bus = bus;
> > -    uint8_t devfn = dev->devfn;
> > +    int devfn = dev->devfn;
> >  
> >      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
> >          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> > @@ -2717,13 +2720,66 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> >  
> >          iommu_bus = parent_bus;
> >      }
> > -    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
> > +
> > +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> > +    assert(iommu_bus);
> > +
> > +    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
> > +        iommu_bus = NULL;
> > +    }
> > +
> > +    *piommu_bus = iommu_bus;
> > +
> > +    if (aliased_bus) {
> > +        *aliased_bus = bus;
> > +    }
> > +
> > +    if (aliased_devfn) {
> > +        *aliased_devfn = devfn;
> > +    }
> > +}
> > +
> > +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> > +{
> > +    PCIBus *bus;
> > +    PCIBus *iommu_bus;
> > +    int devfn;
> > +
> > +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> > +    if (iommu_bus) {
> >          return iommu_bus->iommu_ops->get_address_space(bus,
> >                                   iommu_bus->iommu_opaque, devfn);
> >      }
> >      return &address_space_memory;
> >  }
> >  
> > +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> > +                                Error **errp)
> > +{
> > +    PCIBus *iommu_bus;
> > +
> > +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
> > +    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
> > +        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
> > +                                                      iommu_bus->iommu_opaque,
> > +                                                      dev->devfn, base_dev,
> > +                                                      errp);
> > +    }
> > +    return 0;
> > +}
> > +
> > +void pci_device_unset_iommu_device(PCIDevice *dev)
> > +{
> > +    PCIBus *iommu_bus;
> > +
> > +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
> > +    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
> > +        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
> > +                                                        iommu_bus->iommu_opaque,
> > +                                                        dev->devfn);
> > +    }
> > +}
> > +
> >  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
> >  {
> >      /*
> > -- 
> > 2.34.1


