Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D84C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFF2-0000gT-Ky; Tue, 08 Jul 2025 16:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZDqt-0007AN-2g; Tue, 08 Jul 2025 15:19:42 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZDqo-000882-LZ; Tue, 08 Jul 2025 15:19:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc4zr0FgZz6D8k3;
 Tue,  8 Jul 2025 23:39:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E79081400D4;
 Tue,  8 Jul 2025 23:43:01 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:42:52 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v7 10/12] bios-tables-test: Allow for smmuv3 test data.
Date: Tue, 8 Jul 2025 16:40:53 +0100
Message-ID: <20250708154055.101012-11-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The tests to be added exercise both legacy(iommu=smmuv3) and new
-device arm-smmuv3,.. cases.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | 0
 tests/qtest/bios-tables-test-allowed-diff.h     | 4 ++++
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2e3e3ccdce 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.47.0


