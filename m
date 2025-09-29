Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C84CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GQu-0000Xj-Ag; Mon, 29 Sep 2025 12:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3GQr-0000Wl-MH; Mon, 29 Sep 2025 12:08:57 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3GQm-0004Gz-Ls; Mon, 29 Sep 2025 12:08:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cb5fM6fJFz6L4sl;
 Tue, 30 Sep 2025 00:06:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id BFCBE14038F;
 Tue, 30 Sep 2025 00:08:43 +0800 (CST)
Received: from localhost (10.47.79.72) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 17:08:42 +0100
Date: Mon, 29 Sep 2025 17:08:39 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <20250929170839.00002db9@huawei.com>
In-Reply-To: <20250929133643.38961-7-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.72]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:22 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Accelerated SMMUv3 is only useful when the device can take advantage of
> the host's SMMUv3 in nested mode. To keep things simple and correct, we
> only allow this feature for vfio-pci endpoint devices that use the iommufd
> backend. We also allow non-endpoint emulated devices like PCI bridges and
> root ports, so that users can plug in these vfio-pci devices. We can only
> enforce this if devices are cold plugged. For hotplug cases, give appropriate
> warnings.
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
> system address space so that VFIO core can setup correct S2 mappings
> for guest RAM.
> 
> So in short:
>  - vfio-pci devices(with iommufd as backend) return the system address
>    space.
>  - bridges and root ports return the IOMMU address space.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
One question that really applies to earlier patch and an even more trivial
comment on a comment than the earlier ones ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/smmuv3-accel.c               | 68 ++++++++++++++++++++++++++++-
>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>  include/hw/pci/pci_bridge.h         |  1 +
>  3 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 79f1713be6..44410cfb2a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c

>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,

I should have noticed this in previous patch...
What does add stand for here?  This name is not particularly clear to me.

>                                                int devfn)
>  {
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      SMMUState *bs = opaque;
>      SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>      SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>      SMMUDevice *sdev = &accel_dev->sdev;
> +    bool vfio_pci = false;
> +
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        if (DEVICE(pdev)->hotplugged) {
> +            if (vfio_pci) {
> +                warn_report("Hot plugging a vfio-pci device (%s) without "
> +                            "iommufd as backend is not supported", pdev->name);
> +            } else {
> +                warn_report("Hot plugging an emulated device %s with "
> +                            "accelerated SMMUv3. This will bring down "
> +                            "performace", pdev->name);
> +            }
> +            /*
> +             * Both cases, we will return IOMMU address space. For hotplugged
> +             * vfio-pci dev without iommufd as backend, it will fail later in
> +             * smmuv3_notify_flag_changed() with "requires iommu MAP notifier"
> +             * error message.
> +             */
> +             return &sdev->as;
> +        } else {
> +            error_report("Device(%s) not allowed. Only PCIe root complex "
> +                         "devices or PCI bridge devices or vfio-pci endpoint "
> +                         "devices with iommufd as backend is allowed with "
> +                         "arm-smmuv3,accel=on", pdev->name);
> +            exit(1);
> +        }
> +    }
>  
> -    return &sdev->as;
> +    /*
> +     * We return the system address for vfio-pci devices(with iommufd as
> +     * backend) so that the VFIO core can set up Stage-2 (S2) mappings for
> +     * guest RAM. This is needed because, in the accelerated SMMUv3 case,
> +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
> +     * manages its own S1 page tables while the host manages S2.
> +     *
> +     * We are using the global &address_space_memory here, as this will ensure
> +     * same system address space pointer for all devices behind the accelerated
> +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS ID in
> +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be shared
> +     * within the VM instead of duplicating them for every SMMUv3 instance.

These two paragraphs definitely not wrapping to same line length.
Nice to tidy that up.

> +     */
> +    if (vfio_pci) {
> +        return &address_space_memory;
> +    } else {
> +        return &sdev->as;
> +    }
>  }
>  
>  static const PCIIOMMUOps smmuv3_accel_ops = {

>  


