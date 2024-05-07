Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29AFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Itn-0001gL-AU; Tue, 07 May 2024 07:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Itk-0001ep-TI
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Itj-000756-6n
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715080934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOEaft7+EiUFw/VXZEc+25Cfs/j3W1qQJYhOQG1Yk0Q=;
 b=di8dO+bTbQuXSJKDVm7H5PO17a1r18s7v5n1t6kt7Vb84KJuzK1RXJj+TWxDWcX0MOppjv
 7o50q76DzzaI3t4mff08iEUqcDgChMGsdTZIniUOfPBPhiBZYZoW5Fy4rFYPVpA19ingQl
 0EbQvK+IPrw11+z69JrxUk0Q0AmTN34=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-CyodD6FNM2i5FNa3BTMaIA-1; Tue, 07 May 2024 07:22:12 -0400
X-MC-Unique: CyodD6FNM2i5FNa3BTMaIA-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7ee501e9fa1so1247175241.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 04:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715080932; x=1715685732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOEaft7+EiUFw/VXZEc+25Cfs/j3W1qQJYhOQG1Yk0Q=;
 b=DdBoI4F1Gn8VHUtBvXfTOp3a7rwSC6t5MSNdFPdWBSeSV0lf4BXw/QXbCuipJfKpIK
 sCkZaUSPZTQDzaqr+7fGfECUmvdSehM0gPlVdLdiTa7aN/7bv1yx0byMJFbOZIFeCrwt
 iKV/HrzrH+lcectKT2UyrDJGsITnLIEJpAgMUAbDFLkHk9cHGQ10MP5hXdoP0kxMS3q5
 m0+63sAdk8DRl+52DhacseZwbsJcn7OIQSbYZGYBoHQuEm8AqjVPwyL/8Lpn0EYqg/hi
 7Apeiugs0n2KfYA7alLcK2Ck4GPayLW1z9192jBdOGUUvvBlB1QaVtHGGqm5+BmnEnC5
 r1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJQnN1zFCq30ncNZnhaZxoTJvXgIkb+osKAd2P+IPGaQRWba1DfWL47rGSBnhKNEv72qAaQXhtsF2hRwFLGYmAOsOJAT4=
X-Gm-Message-State: AOJu0YxqgnGkJ3P2ciXGeN3NXmnvr0DiID19tdkABPDD8STRX3cTTo6I
 k3eCvkDc6yqDjOdL4V6izaXOpU8j3EEMMcIeaAaZTAUplujPDCnHJkZXgHs0fGqRvo7a19jzssK
 9A95qvRnA2pMHmuGRK35X712MaboPM6R6eHrbfmVRg8eC8cfKvTdS
X-Received: by 2002:a67:fe02:0:b0:47e:b21d:f4a0 with SMTP id
 l2-20020a67fe02000000b0047eb21df4a0mr9691137vsr.35.1715080932334; 
 Tue, 07 May 2024 04:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz0bV2FazjvC3vqoSkBtde7DRVuCRK4jT2uUYs24KHaXSiZl67Y0h95wi0tqya+lRF/fmwzw==
X-Received: by 2002:a67:fe02:0:b0:47e:b21d:f4a0 with SMTP id
 l2-20020a67fe02000000b0047eb21df4a0mr9691111vsr.35.1715080931970; 
 Tue, 07 May 2024 04:22:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 dg9-20020a056214084900b006a0dd95babdsm4583743qvb.96.2024.05.07.04.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 04:22:11 -0700 (PDT)
Message-ID: <3d74ba1b-2f07-4107-8d06-d99e85309e64@redhat.com>
Date: Tue, 7 May 2024 13:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-16-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507092043.1172717-16-zhenzhong.duan@intel.com>
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

On 5/7/24 11:20, Zhenzhong Duan wrote:
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
> index eaa3fc99d8..33ad56408e 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -362,6 +362,7 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>   
>   void pci_device_deassert_intx(PCIDevice *dev);
>   
> +typedef struct HostIOMMUDevice HostIOMMUDevice;
>   
>   /**
>    * struct PCIIOMMUOps: callbacks structure for specific IOMMU handlers
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
>   } PCIIOMMUOps;
>   
>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
> +                                 Error **errp);
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>   
>   /**
>    * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 02a4bb2af6..963e589790 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>       return &address_space_memory;
>   }
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
> +    return 0;

    return true;

I will fix that.

Thanks,

C.




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


