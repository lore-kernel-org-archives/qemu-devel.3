Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C467EC79FBE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyH-00044l-Dg; Wed, 09 Sep 2026 06:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyE-00042R-M2; Wed, 09 Sep 2026 06:56:02 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004Ft-Q3; Wed, 09 Sep 2026 06:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty8EoDDhCpQTq40WjmPxP2v9v5yDBEx9D/frz0S6LAiIu3a0LWWk9rMZB4kh6dMIQUBtFO9g5dDUCQ3XlWegPjwb2gecwmGZSDfr+TuF9IkTXQqmg62cI16rm7QatM/WG3I19fQSwBOKPBk0qFb8QDjp+F0BhwH4SDLaevB9/CW3D49COUiB79v9H2JLN4rz/6JtAvMcNEJ8oW51FbnlOjcY2Of++aOMQ7fvGiNd3jV5V0BXTuV4XawEVGrO5dmAklvvyGKMLOpAqaIjfYwEnst4FRbEaHpoEEovOjsjbqKccZMd5hhP7xOfyhnpFX1SUXvgDROlxlopXFMg6dzMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=eQ8fwDTuGDxBO4tFlZ6YcUVZbivLdcSGSm2PQrS1GWfNhc3Uw6tRWNqmZSWpdG59Yh2hbNihbptqvjxKUBiHwDq5zw2oHEk+9yQ3YTK65bHEZLNDqY3T5nyucwL+dD7N3sOFgxiaYc/vqqYeJsiv1HedgkxV8Eq15XaMN8YpFlS0wHAbS+xM5huTPUe52SP0xz+0HEdUVOVmK/L24gX6rGf1N0Q6hQMITyiCyoUBsDBQMUX5phUXIg27lnLZpnRxZYPkY5QsTG96onTgI4Nu+SJgPdaxHeLau6itFofn/xj50gSix8UBJsLcKJuvPeDLXhjN6AXZki6/zYDzJHaitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=M9xhbAWcGyOzUyztTa1oshORhD+EiiYF7y7OvrSNAzl6zNR0vEStvc7UDynkW83FL568FN39yXT+36YwIHKd3UluBKiIq2biiDXeuFjr/tUNukoVTcuxXugOC6LB3dvkorq1lagLSEwD9OCf/TkVhcxcrpMlzTLVx3CSGDZK2Llb7o+NHQ0vltUVyKHs7xUrbX1nK9qptRufcGRa28jClGVDe72cAFg81hopbmzjIb383UppNI+83SkcFUSvqIJyz8Q7cb2H0oq2E0wHYDMS1douYG/xQt31gC9lyISL5OSbXPm7FFy3ElN3PrVCTgfq608vg2l9aMls3pacaYY9+Q==
Received: from CH0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:610:e4::26)
 by DM4PR18MB5146.namprd18.prod.outlook.com (2603:10b6:8:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::a0) by CH0PR03CA0201.outlook.office365.com
 (2603:10b6:610:e4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:48 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 277FB4186B5D;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 01/12] hw/char/cadence_uart: Reduce the size of MMIO to 0x80
Date: Wed,  9 Sep 2026 03:55:28 -0700
Message-Id: <20260909105543.1478008-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM4PR18MB5146:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e39a274c-e743-4658-88b5-08df0e60e879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: WGOEPKf7uxVYVME9scDJsB4RRYb2Tk8Nan2iBBWVbkexuYmDlCMFJfRxYHbjMPeuA8F/mntaLVzEgzUegG+vSXeDyJzgo55L7XTLUt2DbcuScYjlxXCpX09A+MfQe1DNVPjpZCxRFgTfDQzBI7c3Q+yGmFNvW56giD4VQAJCPvvDZo4ETP7bleI2Ax/0vMowQiTNzCqpbbvP6auA+t4CU4XdXYYlhFtlWiqOqry8/RBM51/7VPSsUCvAXDLlw2LSzz37yDHN0wQOFTiyNPwIxqyeiLozkfQ4rfY8CliSleckdd7BFaS8y2wZpy2CqktdP+iiZckYcCB3ymYn01wNU8o9GiuP1UorY8MT44eI7zoLsMDHCYA6eqJIru2xras/ZhOaFt+AO+YM795f+1CPQR2KN2yz1r2xwxlN0bqMUr7eMgkTVf0YTlmDo/hoJaz0rX1EHT1NJPmYJDPWMsPXbm4Xi+ulUr7d+jSlCDXq7mx3uWUpo+QA06P5YXkpZciz8gJE4roWK0w9yBaQ+3B39LFO42BewyZrKJ9wuVTgCFGYUNnIskwfyWcJczQDAuTyOoQpaEM+DoU/sXHUr73/SIDSbO1LULLpSR6nQtY/Bdsojy22trWppDcxrBjVntMW/O//N/0ZWXJhpGrxsm1CBZLKjOGHGbllbVWcMs0cR/8ImqiQ5+Fjl0ZrjXwNfgBSYIoqjGaqXhvkbKyaGGlE+g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IuZx1PrszMZ4IvwqbKnuoh+WMXz9ewFrjhTfpYZWO4DkCqfosbn3F4V/31VabSDFCMKC8dz3jcQo3s+Xe1wMmZYUfwbEggRz4p1ONbYiS6ba1U5tdPRVdxvFWcfsKTjODf0uoi3doOWR7JmHnRKkIY7yHGtJow5Rg2NdOYJtK7TxotgREO6L/BWchYQJ8zm934zQOpFImkuwTb/aZAgv2APi/O1P4yy6H/vr3LBiUYUjur7AlOUQFdNfRy/R4nH2pp5dLOCAzaTXHHhpYA0boFaJYP625TCNELJDH4x+7rtkh7JIlJQ2f5rnzZZtuxhPfN9kkmqy5rCMmmSRWljCJ9+WmG46vZ4Sr8sA1yQAncx19xc38S3F8UaCEkaxgvrTty4+/AMte+f/dhauBSiOoj827P1FCjT7VOcWE8goyyQ5b65Z93+orDuG3p+5iTxg
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:48.8167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39a274c-e743-4658-88b5-08df0e60e879
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5146
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

We don't need to reserve 4 KiB for MMIO since the last register implemented
is R_TTRIG at address 0x44

This patch reduces the size of MMIO to 0x80 from 0x1000

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/char/cadence_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eff6a3c4d1..8e23a378c4 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -559,7 +559,7 @@ static void cadence_uart_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CadenceUARTState *s = CADENCE_UART(obj);
 
-    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x1000);
+    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x80);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
 
-- 
2.34.1


