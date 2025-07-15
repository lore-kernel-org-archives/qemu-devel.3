Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21FFC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcKV-0001Cs-E9; Tue, 15 Jul 2025 05:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcJx-000186-Fa; Tue, 15 Jul 2025 05:51:39 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcJu-0003hH-Hy; Tue, 15 Jul 2025 05:51:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhDrM3c6mz6L5Cg;
 Tue, 15 Jul 2025 17:47:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EE2721402EB;
 Tue, 15 Jul 2025 17:51:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 11:51:16 +0200
Date: Tue, 15 Jul 2025 10:51:14 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <20250715105114.0000260a@huawei.com>
In-Reply-To: <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Jul 2025 16:59:32 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Accelerated SMMUv3 is only useful when the device can take advantage of
> the host's SMMUv3 in nested mode. To keep things simple and correct, we
> only allow this feature for vfio-pci endpoint devices that use the iommufd
> backend. We also allow non-endpoint emulated devices like PCI bridges and
> root ports, so that users can plug in these vfio-pci devices.
> 
> Another reason for this limit is to avoid problems with IOTLB
> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
> SID, making it difficult to trace the originating device. If we allowed
> emulated endpoint devices, QEMU would have to invalidate both its own
> software IOTLB and the host's hardware IOTLB, which could slow things
> down.
> 
> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> translation (S1+S2), their get_address_space() callback must return the
> system address space to enable correct S2 mappings of guest RAM.
> 
> So in short:
>  - vfio-pci devices return the system address space
>  - bridges and root ports return the IOMMU address space
> 
> Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
> Hence, if a vfio-pci device is behind the SMMuv3 with translation enabled,
> it must return the IOMMU address space for MSI. Support for this will be
> added in a follow-up patch.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c               | 50 ++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel.h               | 15 +++++++++
>  hw/arm/smmuv3.c                     |  4 +++
>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>  include/hw/arm/smmuv3.h             |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  6 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 2eac9c6ff4..0b0ddb03e2 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -7,13 +7,19 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/vfio/pci.h"
> +
>  #include "smmuv3-accel.h"
>  
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> +    SMMUv3State *s = ARM_SMMUV3(bs);
>      SMMUDevice *sdev = sbus->pbdev[devfn];
>      SMMUv3AccelDevice *accel_dev;
>  
> @@ -25,30 +31,72 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>  
>          sbus->pbdev[devfn] = sdev;
>          smmu_init_sdev(bs, sdev, bus, devfn);
> +        address_space_init(&accel_dev->as_sysmem, &s->s_accel->root,
> +                           "smmuv3-accel-sysmem");
>      }
>  
>      return accel_dev;
>  }
>  
> +static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> +{
> +
> +    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> +        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
> +        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {

Include gpex.h and TYPE_GPEX_ROOT_DEVICE
TYPE_IOMMUFD_BACKEND in iommufd.h

etc.



> +        return true;
> +    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
> +        object_property_find(OBJECT(pdev), "iommufd"))) {
> +        *vfio_pci = true;
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>                                                int devfn)
>  {
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      SMMUState *bs = opaque;
> +    bool vfio_pci = false;
>      SMMUPciBus *sbus;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUDevice *sdev;
>  
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        error_report("Device(%s) not allowed. Only PCIe root complex devices "
> +                     "or PCI bridge devices or vfio-pci endpoint devices with "
> +                     "iommufd as backend is allowed with arm-smmuv3,accel=on",
> +                     pdev->name);
> +        exit(1);
> +    }
>      sbus = smmu_get_sbus(bs, bus);
>      accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>      sdev = &accel_dev->sdev;
>  
> -    return &sdev->as;
> +    if (vfio_pci) {
> +        return &accel_dev->as_sysmem;
> +    } else {
> +        return &sdev->as;
> +    }
>  }
>  
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
>  };
>  
> +void smmuv3_accel_init(SMMUv3State *s)
> +{
> +    SMMUv3AccelState *s_accel;
> +
> +    s->s_accel = s_accel = g_new0(SMMUv3AccelState, 1);
> +    memory_region_init(&s_accel->root, OBJECT(s), "root", UINT64_MAX);
> +    memory_region_init_alias(&s_accel->sysmem, OBJECT(s),
> +                             "smmuv3-accel-sysmem", get_system_memory(), 0,
> +                             memory_region_size(get_system_memory()));
> +    memory_region_add_subregion(&s_accel->root, 0, &s_accel->sysmem);
> +}
> +
>  static void smmuv3_accel_class_init(ObjectClass *oc, const void *data)
>  {
>      SMMUBaseClass *sbc = ARM_SMMU_CLASS(oc);

> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..3bdb92391a 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,7 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +    struct SMMUv3AccelState  *s_accel;

bonus space.

>  };
>  
>  typedef enum {


