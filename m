Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE5C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfWc-0003rG-To; Mon, 23 Jun 2025 07:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uTfWW-0003qH-Ub; Mon, 23 Jun 2025 07:39:40 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uTfWU-0003Ju-TL; Mon, 23 Jun 2025 07:39:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQmLf6Xztz6LD7L;
 Mon, 23 Jun 2025 19:38:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 863B81402F6;
 Mon, 23 Jun 2025 19:39:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 13:39:32 +0200
Date: Mon, 23 Jun 2025 12:39:30 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <imammedo@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <gustavo.romero@linaro.org>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v5 06/11] hw/pci: Introduce pci_setup_iommu_per_bus()
 for per-bus IOMMU ops retrieval
Message-ID: <20250623123903.00007aff@huawei.com>
In-Reply-To: <20250623094230.76084-7-shameerali.kolothum.thodi@huawei.com>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 23 Jun 2025 10:42:25 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
> However, when retrieving IOMMU ops for a device using
> pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
> and fetches IOMMU ops from the parent device, even if the current
> bus does not have any associated IOMMU ops.
> 
> This behavior works for now because QEMU's IOMMU implementations are
> globally scoped, and host bridges rely on the bypass_iommu property
> to skip IOMMU translation when needed.
> 
> However, this model will break with the soon to be introduced
> arm-smmuv3 device, which allows users to associate the IOMMU
> with a specific PCIe root complex (e.g., the default pcie.0
> or a pxb-pcie root complex).
> 
> For example, consider the following setup with multiple root
> complexes:
> 
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
> ...
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device virtio-net-pci,bus=pcie.port1
> 
> In Qemu, pxb-pcie acts as a special root complex whose parent is
> effectively the default root complex(pcie.0). Hence, though pcie.1
> has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
> will incorrectly return the IOMMU ops from pcie.0 due to the fallback
> via parent_dev.
> 
> To fix this, introduce a new helper pci_setup_iommu_per_bus() that
> explicitly sets the new iommu_per_bus field in the PCIBus structure.

Maybe call out where this will later be called from?

Otherwise seems like a reasonable solution to me.

One trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> Update pci_device_get_iommu_bus_devfn() to use this when determining
> the correct IOMMU ops, ensuring accurate behavior for per-bus IOMMUs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Please refer cover letter for more details on the issue that
> this is trying to fix.
> ---
>  hw/pci/pci.c             | 25 +++++++++++++++++++++++++
>  include/hw/pci/pci.h     |  2 ++
>  include/hw/pci/pci_bus.h |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..e1940c05d9 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c

> @@ -3169,6 +3182,18 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>      bus->iommu_opaque = opaque;
>  }
>  
> +/*
> + * This is same as pci_setup_iommu() except it sets the iommu_per_bus
> + * to true indicating the iommu is specific to this bus and

Trivial: Odd line wrap.  At least not can go up a line.

> + * not applicable to any parent or child.
> + */
> +void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque)
> +{
> +    pci_setup_iommu(bus, ops, opaque);
> +    bus->iommu_per_bus = true;


