Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EDBC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBD7-0006Id-PF; Mon, 13 Jul 2026 03:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBD2-0006HP-Od
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:13 -0400
Received: from mail-westus3azon11021097.outbound.protection.outlook.com
 ([40.107.208.97] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wjBCz-0002vT-Pb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEczjgJrohKStnbYELe4yX9+0sl2/iS2fEwAPUP05V86zGo3zYRReainrZdasbiU+4rd9USQiFMFdpABdGOFerWD92NwnZxyD6cc3WKG2QsEeZgrootYkgelhWW+9Zl7uecvuJ8vEdDIbFKhrN38d3W1M0JLUlsPeyhTH5I6GytnrwyhDhjYDVzWeGl/RFtUY7pNXQcK0layPHq54/RnCkotjUNIxhSEeHNWqxNsnwnX7LzhWpF8jo4oQJf4JcdDmLhycI6pyjrGchW9HY3TT5kyFqhFuRQfpgVcYG2zUSPPs2j5N7da107js7doJ+iaBtAc3x/OLioi1bfwF4RNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vabmgsxhW8Uss5olLxk9MOg89pwx1u40ZIcXIGSOAs=;
 b=J/V1QCx5Mife1hHgLCAzk1shOuS3CmuSRWGA9wn89htiWn5KEVuTM/MuOtbm/DAHtvFgGwlK9hVi3muVzsSEUBQeapZlCdViAEphomeVlXrIhAMakwSpDb6IhuUWp+IUSva2JTaC8P0hGEhyuRagXBYn67r+cthDZIx3LGwBp081n16XiUXIEQRrL9pDvxvnPRoAsV4whQDgzeMCoeftsMLmgu/AE5SdNwdiCcyV1BhE8y9S4blJJTQhmgb9Jrocr5V5W1805h1+UzNd9zplCs7Tc8GeWjsb8rw7iaArAa9hyal19IWNc8a0wRaA/QGITLlEF6/gvCu9XxoHgpJnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vabmgsxhW8Uss5olLxk9MOg89pwx1u40ZIcXIGSOAs=;
 b=is/n3TCOtn+bLMNoFThLp+LPzoqUQKnB2MM1GnwvdW4Lsq3taD+BqAQu+iCu6bQ9+ljjKv0CQ1nqCumSn0cdusIbjvJaf6SrCmYb8icO1PPSP/PG3OHYMykWeJkJTVFHlMJaXWbfbov/P8nypCfXu4gazFTuBIWau4w5D9BorhlCtsuyz6M44Bp603XfdK1Vi6GQTSklN3O5lYl/tMv4EiHobXPs6ZmnR4V6JVZvmx+dDQDQpdwUshkpq10c0MFmV8V/YONiGJ/I5ivSl2KQuDX9OXQZphGGSMTijpv5NuI/8StE3RPYvwZr22kzWbFLQWPq+VDrWsOFkoheFfqA/Q==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by LV3PR18MB5707.namprd18.prod.outlook.com (2603:10b6:408:1a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.20; Mon, 13 Jul
 2026 07:30:59 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::29) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 13 Jul 2026 07:30:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 444AC4186B5A;
 Mon, 13 Jul 2026 00:30:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 3/8] hw/arm: ax3000-soc: Enable Ax3000 clock control
Date: Mon, 13 Jul 2026 00:30:28 -0700
Message-Id: <20260713073033.3883619-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|LV3PR18MB5707:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 726ba369-21e7-4d64-eb74-08dee0b0af7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Uiac2Og5VphdxMXtg+d/aMvCtCShiO5vSwZBX8GRnhT/lY1MBgWcPH75Ogi7rqEa/wgddwyvhUXpW+hgK72ldRa0sANRjJwkmR3uD4183SahBzeG93rKzaqk1cVJOzQxCPOGrmJtZNM09gtAjcTkJsoRwA497lQjaRkCh4/jXBZJ/qDHI5zhyJbRaL2+Gi5U+qq4yHyTF/eA7RANN8uXd0Qyy8S2zLHjQu/Rlb7NaaRnAC6kaQRJoia629puwPcDN2qew2zZTQbffEjxVY1wVBb2xn5oYDmZ1iYbv81L6b/MrCBq83q3OsTKKvnBOQkzEx5c2s0UCxM/YOnbKW8XVDcHgR4F12r2ttiTe8TV3Ptws0Q+Q+HFG4o2LcgJTagQruGr5VszaJgFd70UC855+Y3Ldxabi9KmXpA/eLRQK87V4nO68wz3afsXJ+tpJcnB1kXPIJr2/8l+VFtB2b6mtrsdUTjPi2J5PuhQLX6FeF88PWDZmAjLlnsh0B5ZbnZzJqrYxDwQiI89itm3Uju09JwyrRBLJb/5yLoTmcffijE+wBOn78vuUOrQj2ZuGQ2fdJJFgTMRNjxjLZRkkBiIMJ7FUjNGYZFZA1zpfTuxn2ijY1gNmZMUrR+l04tQacvvYrxEvajsps9wyw48fDA65WonpRnQPl7hkvQUR5JNnW5OKx2rPHwqMH7IGIuGnTPd
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4cAJhcE2p5VNf/TE9CeAx2VKfQ5bGOs1ZzpqFBPl3ye5gp1e0Hvmm8zbH9+pPCyQvD8DuYmya399J33XvHgSDqYqpcONU4oY2g7VblqY8SDhsHMhoxZEBC3J8ySo612QBQ0/9Lu+rJB7Fhz0JMPGTv0nzVyYRCoeEzQVVrDP3kKVvUntogTGY9YTam23cyFKypXgNUI2EIYdG4B6yVkSnJuen3X0kNmUMYJRbCLt0MRKas/e4hvdhdP+dgnRmodV3cyf0aNUqc+FY7qByykuaCsgC2JOcG5CrqiZ2DwDHte3y8GFzzg13P3b5Vc0zE5TLaDuD7BuD6HHWJsF2XmOmMp8brMBqG5K38Kqep0P1sHVGSeYKTJkrqcSY48inWCkT9+mS6XJgXQ7ojgBmUsMW+uPESNTWuzvSrWhhZEQ6QyRvmAoG+5evKsZ2t5yZa2o
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:30:59.5748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ba369-21e7-4d64-eb74-08dee0b0af7b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5707
Received-SPF: pass client-ip=40.107.208.97; envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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
index feba0de1bb..fc82a1ab01 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -729,4 +729,5 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select AXIADO_CLK
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index b528f8af53..aaeae11074 100644
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
index b984d7a8ec..329aa4e769 100644
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


