Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8ABCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9kO-0005dX-Js; Thu, 18 Jun 2026 06:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kH-0005c9-UC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:15 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wa9kF-0006Ak-4P
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzVp6HQ1k2qbOBBrQRuNWidZa5iSHxOTOMQU8GmYWRJM5/XD+gBHkp8z8Z60EVgmUXPonjiA19VWnuNoDO8A9UbjboudHUoyXKqaT2JBsuk9GiUSqynJLQLG7RRH7kfApXk3PPdLyfiuA6XiaL5P/8kKtaOXXml1FpVOmhTJogJQ1GET4IX9OlqVTszEH6BITDr0rxqnxjOB8hJz9XOtbst0qdx4d68ci66AI+AclAciFe3ucvEMCsh3pA0/tgX44a3rtROW9ZCOqFQGXYAvYbhjtYp8nx5nGR2NX7S2j+q4FSpCwLY71ha1IT2ppn2ebgLLcK5uNMwFl/ctmEIt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZMzeFt6kaGmwpVS46DDOt15XHcF2Jf0Jnl1/xSrAp8=;
 b=EP+uxXIpnIrJoDIcJw1uahqoqqyUgYtAq9TV8RdqQZqoKw9FDtMOqREIi/orC68+HxMGhULIq6S2Gxs7MCZkSKkuSsl+pvP3uAkoDCEaYmFq7CxPMna1C+krfHV/A+7hRKtQIYyYxbH7fJT9Bv/RgWIw3pgtfTUe0+ReGsSN95jmpkxmJsXALZCR/VRjL5GbXlWKnAEu3W+YoyaWmm1aHednDI4/2IIWgRWoGySZPGe+5uMD9AO8aTvJmPP5kUiK4dBsjQCfGDjdDX9p/bBTTbWMZlAZJnWWK4sC+xc5X4RSrBaesHrjbKT9Lg9n1TVnw1f1TQ09Kb49g5w9b8ByFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZMzeFt6kaGmwpVS46DDOt15XHcF2Jf0Jnl1/xSrAp8=;
 b=X/mD4V1RfAQ4tiFU1Nlcg/lwWYfCe3g0YPiwAK8VPuMz8O9H7TqZxWDAn1dRuMZO1bQd6ZAQeh0ZLvP6blU7T4b4uOxPn+UZ1E4lBJ9i1iQJDxnqi0AGXN1cifKCOrpmk1EWxAj6zOp0i3/Lxcaoy6Wt153f/2yPObxhCWBSl6dohVBTQYyUiCquuYMNUVtstIemaY9cbOGhZL/OrM8Q2D+8oGRqkeT7Y9v6Z7azV6SnvOt2whrRKsUXf6jUHf4wI+MxDAkSVLe73ow8959NXyTnARtLaQP776yIrHC7Hs/fSXIcolZKmwACKBhW8ll+HKqJVkYCShqBlmx+cURhpg==
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by CH3PR18MB5546.namprd18.prod.outlook.com (2603:10b6:610:19e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:13:04 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::58) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 10:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 10:13:04 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 44C9F4186B5D;
 Thu, 18 Jun 2026 03:10:23 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 3/8] hw/arm: ax3000-soc: Enable Ax3000 clock control
Date: Thu, 18 Jun 2026 03:12:44 -0700
Message-Id: <20260618101249.2926976-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101249.2926976-1-kchiu@axiado.com>
References: <20260618101249.2926976-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH3PR18MB5546:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3f3fee40-3287-43bb-b3f6-08decd222f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: u8Vt/YCDHRqW9J2rwTrCmpuhndElumkuZFNBBQeXXS/T/i99xcofarWsF+4sW2FWBxN4VXgtGNKM2gEAgZ6V++5OTWe62yMgvg4rina25WzWXPYdt0+sZx+aV+H7+j1hZpU1E6/P8KxMTfM2ulIvi+0PF7xWT9AzO77tD6GDYVpSPfeU5nO02ic6gsiaclfASFUvwug0LJ18UbfcKHigmm5yuPE5DGfTB5eNxuncZg41Tk9NTa9urOhvqH2FZqBDJ4XQmZqJJL09HNeGZX7SeePDRzuTQ5cQLsmbJPclbb6s/M8ogyfJGJV6pkKzOiHDZMP3+g7E1rak2h+HW+U0h055Jsi+st3lRha/acsCKvefc+Y+g95Nq/1/wgWokBKIbJ8H6xwbpOELcC9o4OOnWaLxMu1t1vV98K8UYKZ8bxKf2cNkcTsb09Z/fY1pUKLe7MbALq+fEB909mqwcqP8GIZABaV90FqkbDul5z1n12aFtxt9AQLwXBEA8oB1nZCXn63MVePgMKrH/qOt2eRqDMDSeG38ham5vhj8/rQA8c9lY08qYAxm2Dl+ni82y5jQo+zB8yzuHxEGEQBY1JsBm4UCp8sF3Kw5/O8KK6FHJPFYch0mfca55TmQtoUlaTkFeHRxf5R+r7L4qoPWVNPRhtYWaHgHs1+KF3QRCLL5PLyED3JNJ9R2OmKBAzqFC29v8gUJJZPZWRyy3iT5Wyn9uxwj0df0mPytZFdyu6/7ru8=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qWuZMsF2q3H4KyVuXqrhWWPCz8BxosldzF1lMviYCxeZupPCl109DT6La83aeMlbJPRe+8UC2/8UMrDfLM5BiZHK7uSG2eqUr7+/ED5Dhfm15Ure5SDorpGnhMRQXAlXObTWt74LJkqvkL1eZ6/xiKaK3sXKNJBpniH3OqYMKRTQZeoePAVkivQf71daFA3WVsJzX0ntGI9pO4mDmWgLYizEmN0adSn+wvlLvoe02EHLgF4QZJhezf8qfafgMto4IH7K/vvb1PgowVOVbrcY2j73Fw1TC0/biqFEOetBZ5NaGVMcpKXmAemuwFa7kc05GczojBGllf3h/c6eEc7zzKkuK43mt3Ya1RtcmO74wgZptqXtW/bt88ChTkZs4mauhWu+xdEz4wdgTEun3nMoCvvDaSJLWdMzwhPRlRYYY4CXQfxFT99yObfCRgY9cXDV
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:13:04.0123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3fee40-3287-43bb-b3f6-08decd222f73
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5546
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              | 1 +
 hw/arm/ax3000-soc.c         | 8 ++++++++
 include/hw/arm/ax3000-soc.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 818ffdbce56..866e4b14e6f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -723,4 +723,5 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select AXIADO_CLK
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 8e8d2edfb71..9a01d23bcc6 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -33,6 +33,8 @@ static void ax3000_init(Object *obj)
         g_autofree char *name = g_strdup_printf("uart%d", i);
         object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
     }
+
+    object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -157,6 +159,12 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     /* Timer control */
     create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
+
+    /* Clock control */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ax3000_clk), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, AX3000_PLL_BASE);
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index b984d7a8ec3..329aa4e7698 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/misc/axiado_clk.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -49,6 +50,7 @@ typedef struct Ax3000SoCState {
     ARMCPU              cpu[AX3000_NUM_CPUS];
     GICv3State          gic;
     MemoryRegion        dram[AX3000_NUM_BANKS];
+    Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
 } Ax3000SoCState;
 
-- 
2.34.1


