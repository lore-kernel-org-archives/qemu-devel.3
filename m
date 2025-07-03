Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC83C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFbO-0006WF-Iz; Thu, 03 Jul 2025 04:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbL-0006VW-UM; Thu, 03 Jul 2025 04:47:28 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbI-0003jE-NQ; Thu, 03 Jul 2025 04:47:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXr0Y0td3z6L5fF;
 Thu,  3 Jul 2025 16:44:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AED7A1402F5;
 Thu,  3 Jul 2025 16:47:08 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 10:46:59 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v6 00/12] hw/arm/virt: Add support for user creatable SMMUv3
 device
Date: Thu, 3 Jul 2025 09:46:31 +0100
Message-ID: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) AC_FROM_MANY_DOTS=1.024, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changes from v5:
https://lore.kernel.org/qemu-devel/20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com/

1. Rebased to target-arm.next and resolved conflicts with the series 
   [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off'.
2. While at it, noticed an issue with RC id mappings creation
   and patch #1 is a fix for that.
3. Patches 3 and 4 have changes because of the conflict resolution with the
   above series. I have retained the R-by tags, but encourage all to take
   another look in case I missed anything.
4. Collected R-by and T-by tags. Thanks!.

Please take a look and let me know. Looks like this is in a good shape now.

Thanks,
Shameer
 
Changes from v4:
https://lore.kernel.org/qemu-devel/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/

Major changes from v4:

1. Added stricter validation for PCI buses associated with the SMMU.
   Only the default PCIe Root Complex (pcie.0) and additional root
   complexes created using pxb-pcie (see patch #1) are allowed.

2. While testing this series with a setup involving multiple PCIe root
   complexes using pxb-pcie, I encountered an issue related to IOMMU
   ops resolution. Consider the below configuration, where an
   arm-smmuv3 device is associated with the default root complex pcie.0,
   and an additional pxb-pcie-based root complex (pcie.1) is added
   without any associated SMMU:

   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \
   ...
   -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
   -device pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \
   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \
   ...
   -device virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \
   -device virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1

   The guest boots fine, and virtionet.0(behind the SMMUV3) bring up
   is successful. However, attempting to bring up virtionet.1
   (behind pcie.1, which lacks a connected SMMU) results in a failure:

   root@ubuntu:/# dhclient enp9s0
   arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000090000000002
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: (unassigned sid) sid: 0x900 ssid: 0x0
   virtio_net virtio1 enp9s0: NETDEV WATCHDOG: CPU: 2: transmit queue 0 timed out 5172 ms
   virtio_net virtio1 enp9s0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5172000 usecs ago
   ...

   Debug shows that QEMU currently registers IOMMU ops for bus using
   pci_setup_iommu(). However, when retrieving IOMMU ops for a device
   via pci_device_get_iommu_bus_devfn(), the function walks up to the 
   parent_dev and fetches the IOMMU ops from the parent, even if the
   current root bus has none configured.

   This works today because existing IOMMU models in QEMU are globally 
   scoped, and pxb-pcie based extra root complexes can use the
   bypass_iommu property to skip translation as needed.

   However, with this series introducing support for associating
   arm-smmuv3 devices with specific PCIe root complexes, this
   becomes problematic. In QEMU, pxb-pcie is implemented as a synthetic
   root complex whose parent_dev is pcie.0. As a result, even though
   pcie.1 has no SMMU attached, pci_device_get_iommu_bus_devfn()
   incorrectly returns the IOMMU ops associated with pcie.0 due to
   the fallback mechanism via parent_dev. This causes devices on
   pcie.1 to erroneously use the address space from pcie.0's SMMU,
   leading to failures like the one above.

   To address this, patch #6 in the series introduces a new helper 
   function pci_setup_iommu_per_bus(), which explicitly sets the 
   iommu_per_bus field in the PCIBus structure. This allows 
   pci_device_get_iommu_bus_devfn() to retrieve IOMMU ops based 
   on the specific bus.

   Not sure this is the correct approach or not. If there is a better
   way to handle this, please let me know .

3. Picked up few R-by tags where the patch content has not changed much.

4. Dropped T-by from Nathan for some patches as things have changed a bit.
   @Nathan, apprecaite if you have time to rerun the tests.

5. Added a bios table tests for both legacy SMMUv3 and new SMMMv3 devices.
   See last few patches.

Cover letter:

This patch series introduces support for a user-creatable SMMUv3 device
(-device arm-smmuv3) in QEMU.

The implementation is based on feedback received from the RFCv2[0]:
"hw/arm/virt: Add support for user-creatable accelerated SMMUv3"

Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the machine
and does not support instantiating multiple SMMUv3 devices—each associated
with a separate PCIe root complex. In contrast, real-world ARM systems
often include multiple SMMUv3 instances, each bound to a different PCIe
root complex.

This series allows to specify multiple SMMUv3 instances as below,

 -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  ...
 -device arm-smmuv3,primary-bus=pcie.1,,id=smmuv3.1

The multiple SMMUv3 instance support lays the groundwork for supporting
accelerated SMMUv3, as proposed in the aforementioned RFCv2[0]. The
proposed accelerated support will be an optional property like below,
-device arm-smmuv3,primary-bus=pcie.1,accel=on,..

Please note, the accelerated SMMUv3 support is not part of this series
and will be sent out as a separate series later on top of this one.

This series also,

-Supports either the legacy iommu=smmuv3 option or the new
  "-device arm-smmuv3" model.
  -Adds device tree bindings for the new SMMUv3 device on the arm/virt
   machine only, and only for the default pcie.0 root complex.
   (Note: pxb-pcie root complexes are currently not supported with the
    device tree due to known limitations[1].)

Example usage:
  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  -device virtio-net-pci,bus=pcie.0
  -device pxb-pcie,id=pcie.1,bus_nr=2
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
  -device pcie-root-port,id=pcie.port1,bus=pcie.1
  -device virtio-net-pci,bus=pcie.port1

Please take a look and let me know your feedback.

Thanks,
Shameer
[0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
[1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/

Nicolin Chen (1):
  hw/arm/virt: Add an SMMU_IO_LEN macro

Shameer Kolothum (11):
  hw/arm/virt-acpi-build: Don't create ITS id mappings by default
  hw/arm/smmu-common: Check SMMU has PCIe Root Complex association
  hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
  hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
  hw/arm/virt: Factor out common SMMUV3 dt bindings code
  hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus IOMMU ops
    retrieval
  hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
  qemu-options.hx: Document the arm-smmuv3 device
  bios-tables-test: Allow for smmuv3 test data.
  qtest/bios-tables-test: Add tests for legacy smmuv3 and smmuv3 device
  qtest/bios-tables-test: Update tables for smmuv3 tests

 hw/arm/smmu-common.c                          |  35 ++-
 hw/arm/smmuv3.c                               |   2 +
 hw/arm/virt-acpi-build.c                      | 207 +++++++++++++-----
 hw/arm/virt.c                                 | 110 +++++++---
 hw/core/sysbus-fdt.c                          |   3 +
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci/pci.c                                  |  31 +++
 include/hw/arm/smmu-common.h                  |   1 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/pci/pci.h                          |   2 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/hw/pci/pci_bus.h                      |   1 +
 qemu-options.hx                               |   7 +
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 0 -> 10162 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10162 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 0 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
 tests/qtest/bios-tables-test.c                |  86 ++++++++
 18 files changed, 407 insertions(+), 81 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy

-- 
2.34.1


