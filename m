Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2320D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fhu-00058W-Pp; Wed, 06 Nov 2024 08:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fhq-0004yT-7Q; Wed, 06 Nov 2024 08:04:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fhn-0000Rj-D6; Wed, 06 Nov 2024 08:04:17 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk54m51Kmz6LDWB;
 Wed,  6 Nov 2024 21:04:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 33A2214011D;
 Wed,  6 Nov 2024 21:04:11 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.170.112) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:03:56 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <anisinha@redhat.com>, <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>,
 <david@redhat.com>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>, <zhao1.liu@intel.com>, 
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: [PATCH 0/3] Fixes CPUs AML & acpi-bios-tables to be x86 backward
 compatible 
Date: Wed, 6 Nov 2024 13:03:28 +0000
Message-ID: <20241106130331.205020-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fixes the the CPUs AML code and its corresponding golden masters ACPI
tables files for backward compatability of live migration on x86 platforms
i.e. when newer Qemu is migrated to older Qemu without `CPRS` Bit present
in the register block.

Fixes [PULL 60/65], [PULL 61/65]:
Message-ID: <bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d.1730754238.git.mst@redhat.com>
Message-ID: <4d62d15b11909e9af121577e707b88f2e4524371.1730754238.git.mst@redhat.com>

Salil Mehta (3):
  qtest: allow ACPI DSDT Table changes
  Fix: Reverse CPUs presence check logic for x86 backward compatability
  tests/qtest/bios-tables-test: Fix DSDT golden masters for x86/{pc,q35}

 hw/acpi/cpu.c                                 |  22 +++++++++---------
 tests/data/acpi/x86/pc/DSDT                   | Bin 8561 -> 8561 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8472 -> 8472 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9886 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15432 -> 15432 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9025 -> 9025 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10215 -> 10215 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8512 -> 8512 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5068 -> 5068 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8633 -> 8633 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9920 -> 9920 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8419 -> 8419 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8567 -> 8567 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12354 -> 12354 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8389 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9714 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8668 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8435 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 12002 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8853 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13182 -> 13182 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10043 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8464 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8477 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9748 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9519 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13242 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8269 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8247 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8490 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8995 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 9021 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18623 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14649 -> 14649 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35752 bytes
 42 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.34.1


