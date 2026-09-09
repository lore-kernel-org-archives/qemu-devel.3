Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0303C79FBE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyH-00045U-Tf; Wed, 09 Sep 2026 06:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyE-00042U-Mb; Wed, 09 Sep 2026 06:56:02 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004Fj-RW; Wed, 09 Sep 2026 06:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8YKdlCnMOQ4KOM5saD1I6UP+OdlLm8VYvlO87fXc5jPIE255axRhmRJ7tG5Gx0izq8x4Kl2TNqItkcs30oDnsuKiKQ9FUA7whpgBau7nEmOhThulBGlkXmRoTs4wa8qyJicGFNPqwG1AXUY4CL2lufev92ldRj7+WeFJXylb5lMGGjkrJGgrEvboKO8ziMZ2YdAHjPZlEOJ+GXzhxMV+J3xZif4Lt/VlsJPQh/g3P9nP3JTAE8fpZNhDBO5G6Ihstd5Y5HY8Wvy8kMzt1ivMQCkIrvwI9QWZFFJ9xcMYH4akjyyvPhhQeIfrASCBJQYrJSUwlakLdgCxjyBsRcttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=AcLBAp+XC4+YhwyJS7Cgl5itobuY5aAZbimJqZcJBRxm8M/6u6lYHKD/xRSaHrE6LLaa6ArhqbFzsG14ZXOfWcnGE/zVjy8lJTmftWgsQ8Znwh/xQLxgbnGdzD1TDDIw9eKb1TJcaZzWvCnZE6a5N5fQX1J91mG4Cye5GMyCOGbvUMVIINIwVwvUOs1cjirVcb9EhIlOEQQcrGtrsXZOGkNUUly2+5As/H3othGMg9rrE5LcictmAeYW9dRY9Nh1jFNU5SqOsUZFCI8eam5DRkFLnps6KjuEr6XYj8t7ikCxXajtMxPAwJpA+W6Arjh3pX2LA/iZJy8oC4VJkhGYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=Wxv3/P4TO21DKeymyVLNqSFDaPNOBiSwIgVsTtRfAeWp7IGifRgOJ5z8fuSBnkdPHMOzypM2LBBgBcQocZf8DA37At1VYGs89ilDfX6qDA1tBOzGd/PZCWqCodQx7QS2NkjBl6IDQUR6HbAC0wEMX3Y5J79mxVuFO/HtUHtfqFOESmQRDX9MII9yUWppwQshCau/7rg2XCF+tpnHhSBvOK7xT9LmBUTAaLUtCoDvF02D33JcpbH2LYHWikYHVNS8dlCAPZMRhli+RWF+WNrfx6q1xVu4DomHhC+cc76w7jBRlmd2EA6Tlxs6kB6t105JgxOMcieieTX3gvSWCej3WA==
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by IA5PR18MB988727.namprd18.prod.outlook.com (2603:10b6:208:602::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::7c) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:49 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 9DF5440BFE10;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 06/12] hw/arm/ax3000-boards: Add memory guard
Date: Wed,  9 Sep 2026 03:55:33 -0700
Message-Id: <20260909105543.1478008-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|IA5PR18MB988727:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44529d6e-9d7b-431f-f939-08df0e60e904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8LQXyeJmS89GdEVY+TeaxJfvGqiJtmdtTTCZ5JVOKOD9GvaYNzeNf+v7Qxgazj1oQU0Ggz5kzE0aJypwKskWaQg2m00FYCfJkPnGrY+rZXLwv8VLBe1hCay1T1biqHcxAP9xwFUTbuAiNvgYUGSS99gOIpsgFZofIOcQqAidgKTk+k0GpeX7i5yREdXP7ImC6g/BsHeACGFVLbwwt3bQrze0em6oyJYiUEHcksjHrWW77Ls3sMQKghRcY/fhhyyxEwRcR0RHI7cUQ0OPykgtWt4ASMes+9Nq4v8+/SFEX1fEqiFKU7NOK5zE93Q0xS77/JLQKIQuJJwRtFyVE88TeCROjErCoSxVCUP1NbSBGit00WoSo5oB6nroP31Tom0UmcemqMGGdD/UPc1bZrBFl3aeTdJtiLHWF/iPJKGQwI9wba0ELL7GPtC/ADy2NhMjMBx1Zagm7EE01BdQDt03AkSuJLxUd1dzTm9nsMa6qzRbnPHgX4oOY1QNLQkWo25P1XDeCk6AsXlU268eH+nMPM0Fm84I6w8/psQhjw9h9cc59+VmNSyYzJJEYY3KUrkPy9XyQ9WI/EfPJucYMivXji7mReUcJkP204vmb5C0ulVDbYHbTxypJF/LtXoPWO7hbsHgqjGH0F43addPSzZEpmOzbb8xIxK1HGAvudn++eXOflmSmKYtWgqmOTFtojXDJXhfH7Pm5Q3tBvyjPNcRew==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: preZE04Z3lMGoL9LxwFBYkkuLKxG2q8a6RHrjiEjPwijDLWTfJyENCZ1FGBth3I+tOCb735oz0TFym380qr7twCh8DFH6+Ahze0Zri9aTWDyeYPtjOO7UzF2IcgtSCloIFnkqDV8R1wCQHCGld1e5Y3liRGgs52x6dpKfiio9NvwB+KdQkQixNKtyR5EpxZI8+10dVQMFfJr4d9nyDsQBou2JYbSG2IaC+GRd+vH9aCowBWxGfduWwPOSWVrXiBThWyfnowF5YKqspueVrPCYZHFYWixUkufD0/4zOjXAwrRdID1jG7oP/YTY2Apvlwsd0vZe2te1YcSzfFGCMPpkjgJzqEgIQLbywLs69HmIWXTqbQz+gNMPBuLz6kowfoE1a0v4EJSc/rvf7tlXaQWKcRitU5YWx5xBkkwZEQyXuouBfKbaMEzWMNRV13aI26l
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:49.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44529d6e-9d7b-431f-f939-08df0e60e904
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR18MB988727
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
index b3ee6c4a69..bc1f818d74 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
@@ -21,6 +22,13 @@ static void ax3000_machine_init(MachineState *machine)
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
@@ -38,6 +46,7 @@ static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
     mc->min_cpus = AX3000_NUM_CPUS;
     mc->max_cpus = AX3000_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_ram_size = AX3000_DRAM_SIZE;
 }
 
 static const TypeInfo ax3000_machine_types[] = {
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 344fcb6f3c..4987ee3834 100644
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


