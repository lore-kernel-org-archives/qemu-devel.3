Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EFBC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7IU-0002rp-L0; Mon, 02 Jun 2025 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uM7IR-0002qs-4I; Mon, 02 Jun 2025 11:41:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uM7IO-0003BW-EL; Mon, 02 Jun 2025 11:41:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b9ykP0Hqhz6L7DB;
 Mon,  2 Jun 2025 23:41:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A97F1402FE;
 Mon,  2 Jun 2025 23:41:43 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Jun 2025 17:41:35 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v3 0/6] hw/arm/virt: Add support for user creatable SMMUv3
 device
Date: Mon, 2 Jun 2025 16:41:04 +0100
Message-ID: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) AC_FROM_MANY_DOTS=0.914, BAYES_00=-1.9,
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

Changes from v2:
https://lore.kernel.org/qemu-devel/20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com/

Addressed feedback on v2. Thanks to all.
Major changes:
1. Not use the default "bus" property for associated PCIe RC.
   Instead use "primary-bus".
2. Split of IORT ACPI changes into two different patches(Patches 2 & 3).
3. Picked some R-by tags. (I haven't included Nicolin's R-by for the v2
   ACPI IORT patch as that is now splitted into patches 2 &3.)

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

Shameer Kolothum (5):
  hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex association
  hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
  hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
  hw/arm/virt: Factor out common SMMUV3 dt bindings code
  hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation

 hw/arm/smmuv3.c          |  10 +++
 hw/arm/virt-acpi-build.c | 164 +++++++++++++++++++++++++++++++--------
 hw/arm/virt.c            | 111 +++++++++++++++++++-------
 hw/core/sysbus-fdt.c     |   3 +
 include/hw/arm/virt.h    |   1 +
 5 files changed, 229 insertions(+), 60 deletions(-)

-- 
2.34.1


