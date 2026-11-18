Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD5606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ol8RBDTM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTcJc-0000kZ-ME; Wed, 18 Nov 2026 04:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXvS-0000Wy-L0
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:44 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXvP-0003u1-PO
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP9N2tGHQiFLxsPIcwn5aZ8SoyrgAcI495AN/1mzuYWr8E6m1KAM6Pb6RvBiP6LeIWu7ppGeaI1PFWN+5ew4/PFICQipVyBs5dXO+VXuelMTbLznZy9w3zEP8SaAXSlTjMh2FfA5hrCFKtGiyM7L8U8CAWGcCo+70okd/eaXsZOBUEjzmkkHJeM1wGVmE2rUaFfEo1DmDO6EhrWPhJno/QOW4he4U8RUIqsiG8OR6boUcwUxaubD05+qVDsn9xVcz479Rp+XzKO1s/rYirWW9R2HB5G9f3HotIkWgQL8SRY8MgDZehq4qmDDSYRRfQCdn/rox0J8F9Byb8oJkHna1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pyDd+2fQ40ZZXwI0lMnseTjUb5wlOZSwok5Aqx9lXY=;
 b=JKUsSCnWri2VWzodnt+iH6Eud/V9qTD5NS2l3tKkm4Odgpf0aQ3GBoJPj1IxTlvC3KWbf1Yd2WZXqz3ygBe9emTIFcFpvwo24B4huU3nSi2RsrsusmXOpGNWHhqDNqpYKBUzdUaOmtNXZVMOtb/wiRNeWHl39OgE9sRrjfGrk5upfJnLita6vzYyWkoGe2mQWqiY8XXaMGR0Z2q6F2Mzk9EFDaj4KR2BME9k1geNHYr2a4F0wo3WfbIwZH6dIyo2rjFBDCvapMkyCA70DbC5eEl4ZvTyZdfOd/s0JljttweGkhTZ06b+isY+GHnEnHK5H0B5Pe7SvFFWyx/MaESbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pyDd+2fQ40ZZXwI0lMnseTjUb5wlOZSwok5Aqx9lXY=;
 b=ol8RBDTMtEZqu8nFTiwlQofhKO9h0TFhNM2omDjbjdAkaqwNincyQjlhTiegMx7yvk60qJhFxZ36ISGKNf4akk25L9OzQ9JiNsh7Q/AK/W2X6om8B+cvRXiPBcb98HAM29A9f3ZuyVqkBpGiG/gEwofJtaEK5rBUEhcs6Opm31A=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:09:31 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::40) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 05:09:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:09:31 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:09:28 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>, <sarunkod@amd.com>
CC: <richard.henderson@linaro.org>, <mst@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 3/4] tests/qtest: amd-iommu: test FCH stub at 00:14.0
Date: Wed, 18 Nov 2026 05:08:30 +0000
Message-ID: <7489be2692832b0416be3f6917e30e6f11becd7a.1794484966.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794484966.git.Ankit.Soni@amd.com>
References: <cover.1794484966.git.Ankit.Soni@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: d194b18c-15ca-49a0-3cfa-08df45322111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|11063799006|56012099006|10067099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: v4DExJWfGmvvOjPNXat39wcGZW0+ZtBmDFnplsHVgmJZQ7MM93pHvrbWzRDyChGsYPRN8mJUsxn4LbXv65tUMgbb4/8uQuxDlscKWa4sB07Q87jsG3HvI47Nxo73uPtDNI1Qt/IEYrGrNWjbLE+Tq8OzBz9XziMxsevCEpRHRDqUobABt1/Bfc60Ve+gsdRz87EGLSn80Z9nCni7WBb2OFiFKPGRHLaOF7EWgACj3PyfEmv0tIxjCpRYio9xcu23LMFP9PeClDXlXLI0RJkOx6nSUJMsVOZlnH1Ecwov+azoUAn9RKvi550F3CWLpCFeNebiPk0E22+ufoXvJ4ecz01/mM6lxHTAForF9Beb1B7SDc9BIgVPvPxyEDfg8YJZKYN7uHC4cHSEghspsIKjdUQGege3vZgI7VjEQOySoss5p8hoIWVIvZ/YO9OtwT53BFIlp/ityhqn5PSlfEcmyXOCFBSNmBF238KGet5umTU4jzHElULiBHmhlKlXvXIG6l9Cg04JccWbxITbzF3iFfEK96r+egKQR7rTJFQErFj3BL7LXW4G24fPb+vZqNitU8aI7jtbqsqSGx8E9PM71nMok1vy/pTlL85Hym3N6Syi83mQKFDls+aRPXE0v86QQkkSRj39OQxbF+EkLVltzg7hAkswlJad3S6sVzXPZnQ1eP4GCzLqLrGMSSXQL3f4hLGD5BS9fc3M3RyShYbItg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WPzBjyEcc0AzXnPojch2wxSpF/iID0HZdm4EP+BVKARAGLy7pFosk3nPKWOkLehGPrT/QeXwi0yM3PX1m0kWYsmVirgs2uahW/Ip/EWKmnUL3AUjKGKcJGhj5Q1hXgB7JrAXeKP/SEHTvPxOtTreT+l+IV3190O4dWXGcgrnAxKFPYuvlGL9k95HG1yyIx4Z1tLdQnql74QYC45n08ABtD0qIG/0cUcrpbBn4FTTMS+MFhZE6HEMjCAICu6a6S7h6U5IYSTo9tpZGBNIT1qnGF2hriDLybfGWscfHfsp7NtNvSeK32VJqk8BDONkABjCaaIvVynZszmg3ATkdDgkQh4WqpwG6ZH7Nr6MfaGoKDevpCbFoSV/veDO4rdarIY1GNyITKREz1WMEjuI7mQ5Cqsj4Ul8xw0Z7EW70BqLtQFiwdgRBP8Jk1EGk7XUMQM5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:09:31.4648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d194b18c-15ca-49a0-3cfa-08df45322111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
Received-SPF: pass client-ip=2a01:111:f403:c110::1;
 envelope-from=Ankit.Soni@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Nov 2026 04:50:53 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that q35 with amd-iommu has the FCH stub at 00:14.0: AMD
vendor ID, device ID 0x790b, and SMBus class.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 tests/qtest/amd-iommu-test.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
index fb28511588be..8463fb6e63f1 100644
--- a/tests/qtest/amd-iommu-test.c
+++ b/tests/qtest/amd-iommu-test.c
@@ -4,6 +4,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
 #include "hw/i386/amd_iommu.h"
 
 #define CMDBUF_ADDR       0x200000
@@ -68,9 +70,37 @@ static void test_cmdbuf_head_wrap(void)
     qtest_quit(s);
 }
 
+static void test_fch_stub(void)
+{
+    QTestState *s;
+    QPCIBus *bus;
+    QPCIDevice *dev;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    s = qtest_init("-M q35 -device amd-iommu");
+    bus = qpci_new_pc(s, NULL);
+    dev = qpci_device_find(bus, QPCI_DEVFN(0x14, 0));
+    g_assert_nonnull(dev);
+
+    g_assert_cmphex(qpci_config_readw(dev, PCI_VENDOR_ID), ==,
+                    PCI_VENDOR_ID_AMD);
+    g_assert_cmphex(qpci_config_readw(dev, PCI_DEVICE_ID), ==, 0x790b);
+    g_assert_cmphex(qpci_config_readw(dev, PCI_CLASS_DEVICE), ==,
+                    PCI_CLASS_SERIAL_SMBUS);
+
+    g_free(dev);
+    qpci_free_pc(bus);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
+    qtest_add_func("/q35/amd-iommu/fch-stub", test_fch_stub);
     return g_test_run();
 }
-- 
2.43.0


