Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AE8CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnY-000561-Lb; Mon, 22 Jun 2026 02:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXnA-0004yD-S7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:06:08 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXms-0006bh-Ld
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npizK0aZbPuwsdtY6DVdXNO79r+fYczNuNai4l5Q/hd/j2ZYTZ5ZYB3IpJRY7FgqWqaQ783r4eqzzUlnY9LaT5jGcsbCgHxFFQhviq4EDXFM1E+E1RHDEtGBMrwb6zW9yyntei2Y2KqKZm0sAExxGzhlNUU0MhZn6Mth0E1dv5JI2AS8cix38cmulMpmJwViGGiGKS1p1lZY2Mn3bIMF6XBwJnFulWmxlslVppwGg/wx6YJymgGxsFk09zER8eoDxCWUXGFOjYHQzy35cK04RxQ9wTcs9ygpwtJCrXycvY+dAjVp3dN1yq5WPobsdsiZ/8hD3Ly82XhhlqPZgrzaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj1rMkHpXaqkjA/YdxhdaN81/k09fa+1NYy9vi5oNIo=;
 b=wrvNUD/aEq2WfUcae+We6T2VUb9YNciHrgzt+NEuSdZ/9Gz19K/Msx/HRUXC9EjU7W0xedhJy5R5wPOfkecYb8Yf9bLpr+uXAUvEsoSBUqfbvixl9kx2P5z33bXYs1Wt8lXjMfuT8efg6MrSDM+m7HBwQ7rqWTk6c2Pxb1nZ70ev/1WLZnPbN96vTqb8l2owCQtZet5O42woHJjxZue5mWEBInqi4lPoUrvdtINEIwVrMVLBPg8aJpFilJ8St+bJXwW/iNdjlj+ovtLUnBaagYbvaTjFkRr5lfH1ligdXQf6566XDzPb7cyWauia1+cF5NsprlT3LcqUSaFRrU9VaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj1rMkHpXaqkjA/YdxhdaN81/k09fa+1NYy9vi5oNIo=;
 b=IdFs7SkChOSaatfRFyNdfOiRPoCSjfvB9X6NJBtzj1Vv2y5yQV6ipilOw5fzXWfeeW60LNCfLD7Dyk9w+VPUlYDIkUIgTU0wPaKwvbEwnNs5neVvpmtI9RYj5HyuCbn5lTL7Xa9LAWYI4P7geolSRBZX4jqm9oLM6MSJ3Pwcr1A/7hBQzWbAbAvjPIAg9FyqSdDq/p4lktarnjxXKHC3JW80A39w2Fdy+WHlPi7PRYZVlIHAQrTR3aVLxy8WQKhmjpUtl/wP3mYP3e10P7Ov/ht+ER2jsCgRP2a74bOH3wbeft0hTLM2gDvrFeliEkaOIMqX7JKSaSmEMAAKlu3foA==
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by SA6PR18MB6224.namprd18.prod.outlook.com (2603:10b6:806:41a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:05:12 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::a0) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.0
 via Frontend Transport; Mon, 22 Jun 2026 06:05:11 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 7D49A4186B5D;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 3/8] hw/arm: ax3000-soc: Enable Ax3000 clock control
Date: Sun, 21 Jun 2026 23:05:01 -0700
Message-Id: <20260622060507.83195-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA6PR18MB6224:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76f4e24f-71e5-4a07-94fe-08ded02438a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fJmqLDl5FW1j+w6JWdQP/lD1m3tv6BMVbN0Mq/XZg5tur5Wgdx1fU7tb6eu+3iTZSnqQGRyOB9W0rOUrGS+rrz8iYhXdXx7uBsDzFeIcqwcTgkgXoAIeYApqa6XLrfOoYMj5sLxQknyjsOW8pb5/+TGsFPx886/bnRfclHjbE3Sd2kcRy+TDFlBot+St5hTFG/JxXLIF5W8dKG0Y9LlA3Ip/w/Z3ac8z34w8dYXYS++nnaYH0KDHyrycqAf71GIX2f6XfOnH7p3cEaJJIakjaL4PgqKOyKdSviYku7Ln7Okp+ZH8vqqjA13EX9I1sIbi3eENzxbYkC+wJyVqHIvKCUd4F/dLzxzGS5SVFii82Swum5N4EgjHvg7WdX/MQi7SJQZFzTL7uA8eQ0ujOZwaLgJUrVU+alXwQrhhr53eJAhqofL5hRv/sMLjsM4xdwjYtzKRREb/Aa2Gk5dbVPXuLpsPUn+c3Ivu6fQmtAM6EMKyucI0Ws2i8VTX5yPm99ft7f7C43x3vNiWptsrAjQ8m8JoNNJ1g2zfyRRIaE6p5iGcPL5qUK8kfEHSC5FFB5y3FR4K3JZJGS1daTZnJxoZ3WryZ5LPFvDo/q24uBhcstnVqHyTBJ9HpJw2bGqA6/05hAjNIb1MBlcPF0m4AyRvLt81AWEj0Kw792IAoz3jtjRa/o7j+PTfn063iHIHLxRkrC91/FowVY2A/I6ADrotJg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c3QTYKuRWnjmHvuTwl/0U1DboynO9IFx2Vu8drhqpIddhktjBu25X1M/o2JNjinAnp1DWhhS/fgVD1RGHBpS7E+nwHBDHFH8jB7k/2ZscUwEmXqgJSD75s0PhYlDywIF2nUW0v4nfGkH6XI0oxrQK9K3XdgSvQWE9jvGRm1+EGnkRB9Tijl8LHVt/xB11qPNeZQAn0wQM+//7ZVOy7L1HIRNNDIXweE3WRRvfnY5r+O15LyLHy6H8ItaMgLGp5FNeNod/pgC2aRiPcM1+KVLqovAzkuz07OaEzAPHdYnDLuvH41cUEBjWxxuteTfpoiwgYWOFUAfDwtl5thmKJLp9Y/RJ4ja0xYYqaOjwos0uAHXeyXBN3hg1xDcKV+oDyxW2D324Vw0G5ozhsznizc6eBlyScyhvXPdyjlOunmSZZS9chqzWToqVCjvIwkGMFHG
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:11.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f4e24f-71e5-4a07-94fe-08ded02438a9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6224
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index d4e5df69066..63fa8869317 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -728,4 +728,5 @@ config AXIADO_SOC
     depends on ARM
     select ARM_GIC
     select CADENCE # UART
+    select AXIADO_CLK
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index b528f8af532..aaeae110747 100644
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


