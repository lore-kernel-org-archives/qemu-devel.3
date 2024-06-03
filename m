Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B992C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE89E-0007Ak-3X; Mon, 03 Jun 2024 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE89C-000765-62
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE89A-00065k-Ew
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717422887;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxFeie7EVNncCW3s913sOR/A9fbjLYVobzQ8EGv13Y0=;
 b=VK5lNJQWP/a1gKI3k+vDYyUSMdvTJyBpiLqM1AxIwmo1y4BtUtkiKhcjNxSZ15sy3toysS
 4/lWVDIVvtUbvM4wZlSy2ldGxkpttNdtdmdacBxb4bkRJYdhKMN6N3g5vjHQk48RPpIqNW
 u2D9i2GBIiJ5TnRQrPdoWp4JyvWLjNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-NMSF54KDOgm2Sr5FsHRRgw-1; Mon, 03 Jun 2024 09:54:42 -0400
X-MC-Unique: NMSF54KDOgm2Sr5FsHRRgw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35e50fe93a5so1096458f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717422881; x=1718027681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bxFeie7EVNncCW3s913sOR/A9fbjLYVobzQ8EGv13Y0=;
 b=uWa8Wmt9MFWUy42b7S69gV64WfF2H8L4FwjbpZ2ksn17CndpjnQrvs3+7c7EFC0lAx
 7k+ZFVgz+VM+kSMBl8iVpYsEs2+3eGG8SlOrxsFBGJQuHfj5LQHrvp52nRhnMCK5T5gA
 pQPb/AYocjsU64t38Ig+DtlJ2zGOgjimIbhYAOBCyHauwIYhfVMoPsEKiwYwmdzeHVJ4
 vt4PXmpygLcYR3l57QoTdTkCxC+ZST+m0+IqeY5+aR6H+xnbLslsxuacC/C64ziPCTjm
 LFp8XpHWhCJTt8365C7lF2eggbXzt87jxwBlGN3JlpgoQrSIJIFLkr/BJ9CQb3yU8lBs
 6t0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhDsloBgCh/J+h7v4XWvz2pQgZ3aZp8yLMFD+daZcBBstJqEG2Bj8/3dj4iznP9W4qVM/apEsPo+yOLJ3yT1/gIDlg2R0=
X-Gm-Message-State: AOJu0Yx3QdXsVDDatdTBscOoE27WmMoe6DX1DyzVnBG1LOZSuxkaRfSc
 5+IH6QhcA79fWZ/SdszruvZ8/+W4Et0HQfwXj/PgFhqBPnZo2smnN8tBfrPc5OPBMWxKDhRhGnc
 9hv05EU4GUt5iYOH4xtUtn2uAFCoIxWAC3ocvDE54B8sL3TW4tgmw
X-Received: by 2002:a5d:5f8b:0:b0:354:f550:8363 with SMTP id
 ffacd0b85a97d-35e0f286c5dmr8206658f8f.34.1717422881549; 
 Mon, 03 Jun 2024 06:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFONI8U9FHDf3JbmBAvUjBt4yjJAyvdsmquMOTjeruRuOCqIVc4uLkx3Ybav3yzYuq/CctovA==
X-Received: by 2002:a5d:5f8b:0:b0:354:f550:8363 with SMTP id
 ffacd0b85a97d-35e0f286c5dmr8206636f8f.34.1717422881128; 
 Mon, 03 Jun 2024 06:54:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04e48b9sm8844838f8f.64.2024.06.03.06.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 06:54:40 -0700 (PDT)
Message-ID: <0e8d80c7-2c51-4f5a-a88f-390194e2ae67@redhat.com>
Date: Mon, 3 Jun 2024 15:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-16-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/3/24 08:10, Zhenzhong Duan wrote:
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
>  include/hw/pci/pci.h | 38 +++++++++++++++++++++++++++++++++++++-
>  hw/pci/pci.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eaa3fc99d8..c84cc9b99a 100644
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
> @@ -383,10 +384,45 @@ typedef struct PCIIOMMUOps {
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
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     *
> +     * @dev: the data structure representing host IOMMU device.
the #HostIOMMUDevice to attach?
> +     *
> +     * @errp: pass an Error out only when return false
> +     *
> +     * Returns: true if HostIOMMUDevice is attached or else false with errp set.
> +     */
> +    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                             HostIOMMUDevice *dev, Error **errp);
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
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
> +                                 Error **errp);
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>  
>  /**
>   * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 02a4bb2af6..c8a8aab306 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>      return &address_space_memory;
>  }
>  
> +bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
> +                                 Error **errp)
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
> +    return true;
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
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      /*
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


