Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18358C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lz-0005GE-N6; Wed, 26 Aug 2026 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Ly-0005FM-KT; Wed, 26 Aug 2026 03:47:22 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lx-0001aZ-3B; Wed, 26 Aug 2026 03:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogT7xu0Wa574bFLiXDcdZVF0gMaZjt/Qg0ry2GpOoWRnzWYV+A1BJk+BL/dcJdSnQ+S7UE+OFlkdnqeEo7ZpMJ2uY7TAu0vca4ASTNAQTdiTJQuspiFenphBiyYy3y71rbY7bGW8AFaprqenon0Bg55xNMY3Pl5VndGu9BovPc6W1VyJr8Mlw5JnuOYnnWnpH118VEjKQYXf8b7N5tfZCEnnw+0o65dihwqADirBmDOb5GQYc+YUCmODinfDed2cg/zPMMhoE1CBoGimtJyhaojR+Gh3BSN/gGGRsr5pu4pxr4PUvqjqL5Zv6qQuJt+4oND3T9na2orzNI+R6uLDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1KuM1zBKtEbIhpRQtuwJ6WP/UTsbv2Q2w6OuiOU4dI=;
 b=nP00rpuBjSlwKI1nVhKHw15LttAfbFaHHvXMbbfxjqeuX+0csWJEPPbi8197e1sHppnvZsj4IN7XIz6YjxETsNSsuxmmmCYP20X6u2mTJltXeN3UH1UivxyaPyc+M3nHBjJrpoX9yNUw3m7nAvIlhfXZcIDz5RSzbdU5pMaSrFPoAL3kuJjX2dtjaOPBCX+GEmfD9hacALRtHbdbdeANAnfAsdX/tDe15nGB2sqvk0LCrFoCxAuDPitO12MsmwAtXnBiouLEBZmvcNqLL/EpJksqYS2fop0KxlXHqgmZRVFLH7SARH6EryG5nhBywSw0XVzOc9QNW+DVRT//+q+vDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1KuM1zBKtEbIhpRQtuwJ6WP/UTsbv2Q2w6OuiOU4dI=;
 b=e+cEUUFzDxHhLpICFhv0Bu8/dCUHBWedz/87vaaQQ4nZZW4H8/UGiJkSvOE+Ckmrhoo7RFaSjUsr4xDiuEoL2O2tcxF+3vQmRI8g4oKW/z/C9avzcR9ERpoaoVI1NjTBdd+xqlx3viZJmDeLf9+MVW1oVe7ejcCmRg9Fr5/zW/ppZL2oTmNR4PxZGqRhUnet+q74dPo/9SDKXX3r2jiQt64SEbR0k1d0eoD2Xtppewv2rSjOl6jFY3Ey5j1yqvFp1Ia9DpIipdU5sLwZOfnqpzERqHE5cLIlOOY343AUrC5T3l/M9t59cycwdZS0Kjat5CDpD/2EWvhvn9kklNkz1g==
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by MN2PR18MB3511.namprd18.prod.outlook.com (2603:10b6:208:264::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 07:47:16 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::8a) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 07:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:47:15 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 657CE4186B51;
 Wed, 26 Aug 2026 00:47:15 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 6/8] hw/arm/ax3000-boards: Add memory guard
Date: Wed, 26 Aug 2026 00:46:32 -0700
Message-Id: <20260826074635.2850931-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN2PR18MB3511:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48c7a5bc-503b-4bae-a536-08df03463f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VM86LSxuR9zK+Hc7uF8YB0g2XsH9FlDAaFDrrkZ8Vpf7zC0tiu4IiaXAVbbDiTtAcIqU7j+gT5eNdDOexamVg2FjtZHahJUvcN0huZdyzOUJKlems2NUZgCPDgrsnYD67TcoAnpS2l8keUQAXa0IR/N8THm2imkXxbffHuMhvZQjkljtc9AmvbkupsaT72RNQuBIPb7wHoqLn9nto6HowdqxLz/OBJckiCFUQjg7etSUUcKo4ggQOg50DF7cTKvq9a11xEKlZGbGHfB1okNdTc5vlxkln3w7s6fy4pUtJksXBmlONYWaMJakbmCSS3tkQPR4kL/T5Bfzpbk4/yW12PvlgUo6HRQxt0ODfds2m8El+9hnA1PuKzdwIHyqqa42AuZk3Cf6tswffo5i8T1A7QYmJQjh1uxB4zuynORPWHNUHD2lwdpbOm9/B9tBvSi1XoiDqHHjZ+FCbOkewqgzN7W1mSKzPL7UfpRMXXeNPceyJ+8/FwsCw3/5mFhVMgTnFoFGt2DunnietZvVa9qLF1X13fpz1nisT2PH70xoW7oiiqJUAcM9wev1d089Idb3O2Yd3u4iv0qXjy69iTLaEDS4Bbageyj/3xSR9KL0BNaDHPVtnMSZtmZspUlfHHyBBjO1MInq1Rm/Rvj1iK3ZdzBgcW/pY1+RWIAZixeS/Y7hfO22mG8/sITXegBqUCMFq8Yrsy/T4I7sCsVGbtc8xQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cN/v3iwMGOBXzel/ATonDboPhybfCNrLK1c/EpKkTzqoSqMxDHEcDxze1+9kHzIUh1Vc4sPPiTBNmaXaw63XpCdHDDIPukv2dEwtMhp24Ix8WY0DihB8Tyat3LJVgoyuteD0ID8lLMF5CDC1q9cB0gyDSPhGzCu/yeub/DYE3AEelB0VfP6PJ1mzdpAqc5sJOLwjLf/jo9Q+UVbCXdWJg2qktYrymrwtPVd8jNNBUwabHdOf7e1M7ZyPAiWfi30+fL7MdTuDAlJmtNwI/55ANPKGeZeF/Y90isAVFwSeBm0NXj4dmGOTOl+18TNmblMO20ZMs3DiPLjW8wSLnymLVknUDNKXgf1hYuCnpycHblmI/UOWTW06q9/dlaFuDW3o1P4WyFt9VtbjbHYvtiXk3LHO3zWmU4Fn7DK/lSho4dfbLud/tUAf/S5EyJBMUcOX
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:15.5716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c7a5bc-503b-4bae-a536-08df03463f66
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3511
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=kchiu@axiado.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ax3000 SoC reserves 3136 MiB memory for access totally
QEMU allows -m option to set the ram_size which would cause the
inconsistent size issue while running in QMP

This patch adds a guard to check if ram_size is different from RAM size
of SoC and setup the default_ram_size

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c      | 9 +++++++++
 include/hw/arm/ax3000-soc.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index a499890317..4fd04e42f3 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -10,6 +10,7 @@
 #include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
@@ -22,6 +23,13 @@ static void ax3000_machine_init(MachineState *machine)
 {
     Ax3000MachineState *ams = AX3000_MACHINE(machine);
 
+    if (machine->ram_size != AX3000_DRAM_SIZE) {
+        g_autofree char *size_str = size_to_str(AX3000_DRAM_SIZE);
+
+        error_report("Invalid RAM size, should be %s", size_str);
+        exit(1);
+    }
+
     ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
@@ -39,6 +47,7 @@ static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
     mc->min_cpus = AX3000_NUM_CPUS;
     mc->max_cpus = AX3000_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_ram_size = AX3000_DRAM_SIZE;
 }
 
 static const TypeInfo ax3000_machine_types[] = {
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 032edafff4..f1cfabe1bd 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -25,6 +25,7 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_DRAM0_SIZE       (1088 * MiB)
 #define AX3000_DRAM1_BASE       0x400000000
 #define AX3000_DRAM1_SIZE       (2 * GiB)
+#define AX3000_DRAM_SIZE        (AX3000_DRAM0_SIZE + AX3000_DRAM1_SIZE)
 
 #define AX3000_GIC_DIST_BASE    0x80300000
 #define AX3000_GIC_DIST_SIZE    (64 * KiB)
-- 
2.34.1


