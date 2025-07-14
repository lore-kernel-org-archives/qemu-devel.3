Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F15C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubO5g-0002Mf-AZ; Mon, 14 Jul 2025 14:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1ubN2U-0001D1-MV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:32:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1ubN2R-0006A8-U9
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:32:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgq6w60QTz6L4wZ;
 Tue, 15 Jul 2025 01:28:56 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BFBC14038F;
 Tue, 15 Jul 2025 01:32:24 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.81.206.233) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:32:23 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <gaosong@loongson.cn>, <imammedo@redhat.com>,
 <jiaxun.yang@flygoat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <peter.maydell@linaro.org>,
 <prime.zeng@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v7 1/4] tests: virt: Allow changes to PPTT test table
Date: Mon, 14 Jul 2025 18:31:43 +0100
Message-ID: <20250714173146.511-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714173146.511-1-alireza.sanaee@huawei.com>
References: <20250714173146.511-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.81.206.233]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yicong Yang <yangyicong@hisilicon.com>

Allow changes to PPTT test table, preparing for adding identical
implementation flags support and for adding a root node for all
the system.

This is related to both loongarch64 and aarch64.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..5c3ff47748 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/PPTT",
+"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/PPTT.topology",
+"tests/data/acpi/loongarch64/virt/PPTT",
+"tests/data/acpi/loongarch64/virt/PPTT.topology",
-- 
2.43.0


