Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C67CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLRR-0003WW-8N; Fri, 24 Oct 2025 13:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLRQ-0003W6-B8
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLRO-0008EI-3h
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761326340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F0kMmeKl4YZ06uBU9gD3D9MgpcSdq9tB67fzkejJ8js=;
 b=RUjkbLaIPBMUS1x4W/Y4cgMkn9q3w1L3kgJ4Km9BCJKjb6enp3aa2ePWVLfOhDEcIkg5Bx
 nKCmi4wZt+362v0wnV/2Nps7F5mSiJZsfTNqYVBFYMeDktunnCf+UuHTB3pgxd10FvW/ij
 XXg41zyW7xM7C6BpgE257BkyK1d7qO8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-fKgyziGwPOG66igLwxi4CQ-1; Fri, 24 Oct 2025 13:18:58 -0400
X-MC-Unique: fKgyziGwPOG66igLwxi4CQ-1
X-Mimecast-MFC-AGG-ID: fKgyziGwPOG66igLwxi4CQ_1761326337
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so1672203f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326337; x=1761931137;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0kMmeKl4YZ06uBU9gD3D9MgpcSdq9tB67fzkejJ8js=;
 b=bvVhlwdOLHAQd7ZaSn3dMf1mHRn3vrJywP7hMgPYbhhmNLHOWNWvzWlSVNVivGlv/K
 tdkFgjYn/1HPgVKInyzry7Bb9Ft9aUG1e/1SOWCY6RSrGbIDE16LMig8jq3JdoMSBPBN
 +oi9d6xRe/VK+r/Szyj3SO0WqbHj8cBuBJERqdZ5CZm3seHucFtAG1KdFkug/gbScsGA
 sJKaSi85iK5AzcFoiPzuT2s5pC7wwwLRPUucUGYrzn7Nylf70qqJl8dgngXiS1aOUWM0
 u8UT/kGmJyBwg5axmZ5DSthpbIDQkcTsDw474t/alreFlmSlLY+XFWR+Phbx1Wdh2RrT
 lamg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6liALwXCncKubV0Hr4GEP4qyUIbsFRYp+ppBdl7Z+r2wKcbJzliDo0mzOrDMD4FPRHA5msM4ez3d5@nongnu.org
X-Gm-Message-State: AOJu0Yx4pddbQ4bWjlYMXILko2V/BE7Qh+rxYeCV+73gbLbwCFheihxa
 1oL2j4zVJLcFP1KvrrW36dYaYV0GL1qVXrHPFp9cZYYDSOioJe7LhYvpFdKECTUgNl5JrmZAd82
 +ZG2O5e0LMmlNvg1tfXYcvYk79JuXfNXHoVKHpiaUB+4iCfO0t6NvxpqU
X-Gm-Gg: ASbGncsNY8ZlSgL3QS+ormrhZOF9O8gKkWS6km6qA0UlQFhN4z7+NZ5SflcMU1rUmhD
 q73vOBq/8FvpG6BS9XvAhReH0SQT/RrpkGKH3+NVtzTqITR2p90XaMfLp6Glf9tY7mTuwbJdOg5
 ad4N31cpZE5GJVlGBeHN8ZuN/hNjP2cbA1e1+l/is8D+YeG+kEeWSiv0+PREybb83ghTq638Hap
 tN4t/N9BqY8fpXZ+KIEVB4tIQE4vZi9snCaNej8iYi64CvKoJALzZxZpnWNnDC2uF1/+jjMVaB6
 V8yuFsymaJW6SvYoONsp99YqpdQSnu34ZvN7cOFk5RtS0bHl/ZHYDAjxGKo5iriPEBIAbcjV
X-Received: by 2002:a05:6000:2689:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-4298f489f65mr3656628f8f.0.1761326337306; 
 Fri, 24 Oct 2025 10:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9spf4DBAd7sK53BIkqMVf6nOc8FCsfHar6n07eCDHG3GvGXyYBLeBmuQK5Y7j+/SQ54M3KA==
X-Received: by 2002:a05:6000:2689:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-4298f489f65mr3656599f8f.0.1761326336901; 
 Fri, 24 Oct 2025 10:18:56 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm10354188f8f.34.2025.10.24.10.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:18:56 -0700 (PDT)
Message-ID: <8dccb89a-f41b-4ae0-9f9d-f39f609766ee@redhat.com>
Date: Fri, 24 Oct 2025 19:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/23] hw/pci: Introduce pci_device_get_viommu_flags()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_flags() which
> allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
> device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
> support of HW nested stage translation scheme and wants other sub-system
> like VFIO's cooperation to create nesting parent HWPT.
> 
> pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
> device potentially protected by a vIOMMU.
> 
> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
> flags which are only determined by user's configuration, no host
> capabilities involved. Reasons are:
> 
> 1. host may has heterogeneous IOMMUs, each with different capabilities
> 2. this is migration friendly, return value is consistent between source
>     and target.
> 
> Note that this op will be invoked at the attach_device() stage, at which
> point host IOMMU capabilities are not yet forwarded to the vIOMMU through
> the set_iommu_device() callback that will be after the attach_device().
> 
> See below sequence:
> 
>    vfio_device_attach():
>        iommufd_cdev_attach():
>            pci_device_get_viommu_flags() for HW nesting cap
>            create a nesting parent HWPT
>            attach device to the HWPT
>            vfio_device_hiod_create_and_realize() creating hiod
>    ...
>    pci_device_set_iommu_device(hiod)
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   MAINTAINERS          |  1 +
>   include/hw/iommu.h   | 25 +++++++++++++++++++++++++


Hmm, why not under include/hw/pci/ ? Was this discussed ?


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>   include/hw/pci/pci.h | 22 ++++++++++++++++++++++
>   hw/pci/pci.c         | 11 +++++++++++
>   4 files changed, 59 insertions(+)
>   create mode 100644 include/hw/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36eef27b41..d94fbcbdfb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2338,6 +2338,7 @@ F: include/system/iommufd.h
>   F: backends/host_iommu_device.c
>   F: include/system/host_iommu_device.h
>   F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
>   
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..9b8bb94fc2
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,25 @@
> +/*
> + * General vIOMMU flags
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +#include "qemu/bitops.h"
> +
> +/*
> + * Theoretical vIOMMU flags. Only determined by the vIOMMU device properties and
> + * independent on the actual host IOMMU capabilities they may depend on. Each
> + * flag can be an expectation or request to other sub-system or just a pure
> + * vIOMMU capability. vIOMMU can choose which flags to expose.
> + */
> +enum viommu_flags {
> +    /* vIOMMU needs nesting parent HWPT to create nested HWPT */
> +    VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +};
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index bde9dca8e2..cf99b5bb68 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -462,6 +462,18 @@ typedef struct PCIIOMMUOps {
>        * @devfn: device and function number of the PCI device.
>        */
>       void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_flags: get vIOMMU flags
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't support
> +     * exposing flags to other sub-system, e.g., VFIO.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: bitmap with each representing a vIOMMU flag defined in
> +     * enum viommu_flags.
> +     */
> +    uint64_t (*get_viommu_flags)(void *opaque);
>       /**
>        * @get_iotlb_info: get properties required to initialize a device IOTLB.
>        *
> @@ -644,6 +656,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                    Error **errp);
>   void pci_device_unset_iommu_device(PCIDevice *dev);
>   
> +/**
> + * pci_device_get_viommu_flags: get vIOMMU flags.
> + *
> + * Returns: bitmap with each representing a vIOMMU flag defined in
> + * enum viommu_flags. Or 0 if vIOMMU doesn't report any.
> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
> +
>   /**
>    * pci_iommu_get_iotlb_info: get properties required to initialize a
>    * device IOTLB.
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d0e81651aa..c9932c87e3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -3010,6 +3010,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>       }
>   }
>   
> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_flags) {
> +        return iommu_bus->iommu_ops->get_viommu_flags(iommu_bus->iommu_opaque);
> +    }
> +    return 0;
> +}
> +
>   int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                            bool exec_req, hwaddr addr, bool lpig,
>                            uint16_t prgi, bool is_read, bool is_write)


