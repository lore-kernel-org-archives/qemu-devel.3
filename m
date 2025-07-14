Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B9DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMVW-00086P-U2; Mon, 14 Jul 2025 12:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLbV-0004ud-Oe; Mon, 14 Jul 2025 12:00:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLbR-00081u-MV; Mon, 14 Jul 2025 12:00:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn7B3Nfgz6M4Hl;
 Mon, 14 Jul 2025 23:59:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 20D3A14038F;
 Tue, 15 Jul 2025 00:00:15 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:00:06 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 00/15] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3 
Date: Mon, 14 Jul 2025 16:59:26 +0100
Message-ID: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) AC_FROM_MANY_DOTS=0.664, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi All,

This patch series introduces initial support for a user-creatable,
accelerated SMMUv3 device (-device arm-smmuv3,accel=on) in QEMU.

This is based on the user-creatable SMMUv3 device series [0].

Why this is needed:

On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
must be set up in nested translation mode (Stage 1 + Stage 2), with
Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the host.

This series introduces an optional accel property for the SMMUv3 device,
indicating that the guest will try to leverage host SMMUv3 features for
acceleration. By default, enabling accel configures the host SMMUv3 in
nested mode to support vfio-pci pass-through.

This new accelerated, user-creatable SMMUv3 device lets you:

 -Set up a VM with multiple SMMUv3s, each tied to a different physical SMMUv3
  on the host. Typically, you’d have multiple PCIe PXB root complexes in the
  VM (one per virtual NUMA node), and each of them can have its own SMMUv3.
  This setup mirrors the host's layout, where each NUMA node has its own
  SMMUv3, and helps build VMs that are more aligned with the host's NUMA
  topology.

 -The host–guest SMMUv3 association results in reduced invalidation broadcasts
  and lookups for devices behind different physical SMMUv3s.

 -Simplifies handling of host SMMUv3s with differing feature sets.

 -Lays the groundwork for additional capabilities like vCMDQ support.

Changes from RFCv2[1] and key points in RFCv3:

 -Unlike RFCv2, there is no arm-smmuv3-accel device now. The accelerated
  mode is enabled using -device arm-smmuv3,accel=on.

 -When accel=on is specified, the SMMUv3 will allow only vfio-pci endpoint
  devices and any non-endpoint devices like PCI bridges and root ports used
  to plug in the vfio-pci. See patch#6 

 -I have tried to keep this RFC simple and basic so we can focus on the
  structure of this new accelerated support. That means there is no support
  for ATS, PASID, or PRI. Only vfio-pci devices that don’t require these
  features will work.

 -Some clarity is still needed on the final approach to handle MSI translation.
  Hence, RMR support (which is required for this) is not included yet, but
  available in the git branch provided below for testing.
 
 -At least one vfio-pci device must currently be cold-plugged to a PCIe root
  complex associated with arm-smmuv3,accel=on. This is required to:
  1. associate a guest SMMUv3 with a host SMMUv3
  2. retrieve the host SMMUv3 feature registers for guest export
  This still needs discussion, as there were concerns previously about this
  approach and it also breaks hotplug/unplug scenarios. See patch#14

 -This version does not yet support host SMMUv3 fault handling or other event
  notifications. These will be addressed in a future patch series.

Branch for testing:

This is based on v8 of the SMMUv3 device series and has dependency on the Intel
series here [3].

https://github.com/hisilicon/qemu/tree/smmuv3-dev-v8-accel-rfcv3


Tested on a HiSilicon platform with multiple SMMUv3s.

./qemu-system-aarch64 \
  -machine virt,accel=kvm,gic-version=3 \
  -object iommufd,id=iommufd0 \
  -bios QEMU_EFI \
  -cpu host -smp cpus=4 -m size=16G,slots=4,maxmem=256G -nographic \
  -device virtio-blk-device,drive=fs \
  -drive if=none,file=ubuntu.img,id=fs \
  -kernel Image \
  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on \
  -device vfio-pci,host=0000:75:00.1,bus=pcie.0,iommufd=iommufd0 \
  -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
  -device pcie-root-port,id=pcie1.port1,chassis=2,bus=pcie.1,pref64-reserve=2M,io-reserve=1K \
  -device vfio-pci,host=0000:7d:02.1,bus=pcie1.port1,iommufd=iommufd0,id=net1 \
  -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000" \
  -device pxb-pcie,id=pcie.2,bus_nr=32,bus=pcie.0 \
  -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.2 \
  -device pcie-root-port,id=pcie2.port1,chassis=8,bus=pcie.2 \
  -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie2.port1 \
  -fsdev local,id=p9fs,path=p9root,security_model=mapped \
  -net none \
  -nographic
  

Guest output:
  
root@ubuntu:/# dmesg |grep smmu
 arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
 arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00008305)
 arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
 arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq
 arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
 arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features 0x00008305)
 arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries for cmdq
 arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries for evtq
 arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x0
 arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit (features 0x00008305)
 arm-smmu-v3 arm-smmu-v3.2.auto: allocated 65536 entries for cmdq
 arm-smmu-v3 arm-smmu-v3.2.auto: allocated 32768 entries for evtq
root@ubuntu:/# 

root@ubuntu:/# lspci -tv
-+-[0000:20]---00.0-[21]----00.0  Red Hat, Inc Virtio filesystem
 +-[0000:02]---00.0-[03]----00.0  Huawei Technologies Co., Ltd. Device a22e
 \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
             +-01.0  Huawei Technologies Co., Ltd. Device a251
             +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
             \-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
root@ubuntu:/# 

root@ubuntu:/# 
root@ubuntu:/# dmesg |grep Adding
 hns3 0000:03:00.0: Adding to iommu group 0
 hisi_zip 0000:00:01.0: Adding to iommu group 1
 pcieport 0000:20:00.0: Adding to iommu group 2
 pcieport 0000:02:00.0: Adding to iommu group 3
 virtio-pci 0000:21:00.0: Adding to iommu group 4

Further tests are always welcome.

Please take a look and let me know your feedback.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com/
[1] https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
[2] https://lore.kernel.org/qemu-devel/20250708110601.633308-1-zhenzhong.duan@intel.com/

Nicolin Chen (8):
  backends/iommufd: Introduce iommufd_backend_alloc_viommu
  backends/iommufd: Introduce iommufd_vdev_alloc
  hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
  hw/arm/smmuv3-accel: Support nested STE install/uninstall support
  hw/arm/smmuv3-accel: Allocate a vDEVICE object for device
  hw/arm/smmuv3-accel: Introduce helpers to batch and issue cache
    invalidations
  hw/arm/smmuv3: Forward invalidation commands to hw
  Read and validate host SMMUv3 feature bits

Shameer Kolothum (7):
  hw/arm/smmu-common: Factor out common helper functions and export
  hw/arm/smmu-common: Introduce smmu_iommu_ops_by_type() helper
  hw/arm/smmuv3-accel: Introduce smmuv3 accel device
  hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
    with iommufd
  hw/arm/smmuv3: Implement get_viommu_cap() callback
  hw/pci/pci: Introduce optional get_msi_address_space() callback.
  hw/arm/smmu-common: Add accel property for SMMU dev

 backends/iommufd.c                  |  51 +++
 backends/trace-events               |   2 +
 hw/arm/meson.build                  |   3 +-
 hw/arm/smmu-common.c                |  70 ++-
 hw/arm/smmuv3-accel.c               | 631 ++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h               |  93 ++++
 hw/arm/smmuv3-internal.h            |  27 ++
 hw/arm/smmuv3.c                     |  44 +-
 hw/arm/trace-events                 |   5 +
 hw/arm/virt.c                       |  12 +
 hw/pci-bridge/pci_expander_bridge.c |   1 -
 hw/pci/pci.c                        |  19 +
 include/hw/arm/smmu-common.h        |  10 +
 include/hw/arm/smmuv3.h             |   1 +
 include/hw/pci/pci.h                |  16 +
 include/hw/pci/pci_bridge.h         |   1 +
 include/system/iommufd.h            |  19 +
 target/arm/kvm.c                    |   2 +-
 18 files changed, 981 insertions(+), 26 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.34.1


