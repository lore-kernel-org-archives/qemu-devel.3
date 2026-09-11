Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AAFC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4td7-0000gG-VP; Fri, 11 Sep 2026 01:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc3-000094-BL; Fri, 11 Sep 2026 01:15:48 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005jU-Hv; Fri, 11 Sep 2026 01:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT2J7k1R/xFcs6kBrTgEUAcSX1WTmGT9h1I/kQTlM9k+ftrAflwYn66yjNsNAYi5kLd+C0Qq8uqweM4eNp/73zPUwDa2OZEzXwr+rExGn2px7q5CqgGLJEqhADyQy5dUabG/AtHkiBeVIrGPjdnCSpj+JhzWml0EsoRo7nc2oBM420eepQAxNyc/wGl7XJnPMRShpoMJORxefGmU5cEUd20J9GUC/VzufSXlQqA8tcf0Ha5akUJ0QTkHR/hYsTMBgLNnpCXt/iEEyzMrY5p2YxUz+CLj5oJqfykXLchk4bb4JLZCFo8Uix2RjzDq40elEg+Jv3V+fN939atkhLiTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=fniv03sI4wU9BS7M/0rikAnVKMPRuntOh+8mMKkhwswxtBASaTMjEjcLRpi1M0NFgBiOPCOJyi47Yhww8QqeuFbGukOdlGVi0CVzDhAB/Y7XwXnh3j4UpewfCJKKM9PbiKi2Ot4KsbxMytyKoq0ysE8SytdKI1mE2/L/OcGaGN9L7Vodbl4g2DDq/vlUC14jdB9/DRZp4s/IIliblW1R/fiXq7sybrj77UnFa/XSyYm9xEOv/chKq66bxHtq8EyLtUsh3R4Nbv6Ur1lTjWav7xQ3fRX9/B3QLDgYZORON8LlT0A+Ht/yS5J+rctHu5hucrn4qMjLyN7/n51BIiS0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp4FsZQldTPJ56k2UKg7NuqJserkWdPewaNA4ZdY1dk=;
 b=DVyU9xjVjxcmOZ89Z2yFTPtHKn9Uew5d0WQ5BHa9aFP/LuzrghdljfzwKZ8/wkONxh/sm9Dpfr/tntX0OczaE1l0AKDyfjEHi/V9LOOlpg06YdJ27SQ5Tapia/kxaZyq2zbTH+MJD60+rITeyz4y+yk0E3D97Oj43FRp0LGXzfKec8Agg2VN+t3X+DsyH039EOMsmvw+aqAKBcD8PZc19QqvvbQer7kXiFCymWl55MhuDpUCBFeFRpUSvTBfZyF0z1tqRmFN8PHyAEPOGJRzZ5iZlcvqvTHfCCvfOAa7efhZlZ9y/HAglIpfsAoGnY1KWuBQygU5R30eFMkq+SlBFQ==
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by MN0PR18MB6115.namprd18.prod.outlook.com (2603:10b6:208:4a5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 05:15:36 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::6f) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id F047B40BFE10;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 06/13] hw/arm/ax3000-boards: Add memory guard
Date: Thu, 10 Sep 2026 22:15:25 -0700
Message-Id: <20260911051532.2378501-7-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|MN0PR18MB6115:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d984a566-2a73-4bbc-640c-08df0fc3b68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9plyapWvZ1kaI9xqDEFqzq/DpsuuNtpWkVlEWiBPS+M++ax7uKqUP4ii9h9hZnR6mjzRnVbcKbiIN3WxhWaO3QLhqCiZJfEDa+Ed/FGuy8Fl9wcgpCRtdRkMo4zkrzgbrYaKK1wZamhHg/08UAVRW7jHgS5sJc8/qC2GwrbitJt4LyU6YA7oG+5Btuu2OAP4UCQTSCF33m2FD3kGOPTBaSwdEI+KPUpoec3ROx6ka0Gv56P15A3glQJm+8l2fveuKaGDLoDHE4cfEnc80RAjq4lC7Geo0l0rt7oOl9PJgntrrChr+y0KsLr37vfaF9Yihdf0UpGeyr9tPl1/2dzWyU/q2BSosJPS0jYHpvO/1DjuEjD835DwaPzMvN/xGElKohC1xneahNqvJrenudTpoQeU4DN8cOfsSybIpORO0pRfERDn+DOAGSV/nMRh5jxpAR3om4dh9LFEyubKPJWoZLhDt966aLfYpNJROhaLuQyWViDmXe5/iyPM9E4s8Nv6ubWdh4NYA7sSXAEovHObWDjXwgbFf5C3LdcKAOH7HQ/wLfyoL1JeE/T8N/BC9wLuV8rJCOIlpEVXWwy/wq1XPn4+97E0B/5tlHDlfSAgZ2JIYiwtrHypz7lETbqfe5aB6hYwVOJfPIWenUiyISzlDL/yhb0Tv+EgsQOv8ZI+x4BF5Kufrl+rd5UoAunKrGNXlyyj6gxiJvloF+1vOWK07g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXqqhnHe5i9cWI7FL5+ffcLkZuTyaZ8i+wmj22F/HDa/8eKltiG5VBy3nY/PdZS5SA3eXrTwixwxP6aujEfH7N9kjgTrweVTIdA/SF7hMTSHuoauQK381zkXlaXHDO3KEuSc2RaJVSWDT/xFFU67pLbaZYlp2HFwqGqrv7FCN09v8jDo/t1x9k9DPb244CxY0RoopHTcncGAEmR1QRZFoCActbic4SPl76MZs1jl0kUT0e18q7JfgUPazt8LBnCnoI2CnUnzPKiBI1XvGBRibcN0K7u3suiU5e4sKUl4RtI1K4p+ikT/SzjpihieHWBhlQMQXCm9+go8kjemL6nL5jXbGZD99wskUdydnyHpxcgpDoUlCaBX2jxBQ1b895DWO0gGE/vgr7fs3vlXQWpIm+UxWvXVJKSkfrsfSKPP5uoljMTO/Y8Cq3A6t4i+Yowb
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:36.3986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d984a566-2a73-4bbc-640c-08df0fc3b68d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6115
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


