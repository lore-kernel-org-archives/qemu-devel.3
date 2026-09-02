Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91800C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i7q-0002EK-PG; Wed, 02 Sep 2026 06:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7o-0002D6-Gv; Wed, 02 Sep 2026 06:23:24 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7m-0006s7-V2; Wed, 02 Sep 2026 06:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVoFlLKz4co3kqwtqHUcOYF4PBIMK8ZBjVaZWOpvvgv4auWgHEKtEbzwhyDE9uy3DXMnZ8+FQNHueGjyqnO+cTSlYnYgdH22mFsgMvf+xiceogAyhZYDG7ehNBFdoy9hQENyo4fexdt/jsvwaD2hA+RS/d5Ej+MS1DGzqY4XGkVcIRdz6ccrCtHD3xiXL4VnA9qz/E/gLeH6LnIIb/Rec2FFc3Oss6C9iC/5QR1ersS/z3oh2wbipsnkA9h7DWtYi0z7itUUGRtMouUvCUIWc0UNdW+CDNNk/pLtDHSi46+KJ6cB/DNf6NyIoJYOOmtkaDTvk1MHfkSQGeVdv98H9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hp1QjwPDERYnXM8rBnr+Okr/Cf6hQxZMJl2BDCr83k=;
 b=yIjYn5/AcQ3xs0pHMKLiR0S+/ikwEqJZmv0RCmLD6caNA06iaPr6UavrOWfA97AhaZ/r+pWOKqc0foj+zJSh05btBOrg+iaww0MbBj/B/tFxA8lyr6aYo2A30TXtu0Yig7Vf5wZL2VpIdQ6QOERQxOUsXBAnk3wgb7lP5UioFXOskSQDii52oZmi23jSeL3Vmx2vnI+thaAxbV4F0T7CVTxKK93SZW5YCHSSVIcgOGzvveINaVdoRf+YsAgZMOrBgS0KtzifC5xhYkIy7ZgsmZkSdFjSGSF2LfIdotCg4dgHvqfwPzuL6HhDfB0qejaa5gnvrWi3Dxv72g4wUq6lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hp1QjwPDERYnXM8rBnr+Okr/Cf6hQxZMJl2BDCr83k=;
 b=BDGG6d4fuxSpsXr1tQvYo0oYnXO2lvsDMWYLKmRx1U0lISPpn4U1LqKhjz5xyWCWDuhIUuiy9Lo5tDXoIGjCRfhFOHvB/2SWKY1E467wyeHIUiUHrJDZ57f0FPrJsULPanAWKThAEyYyMlJpN4QPO1Jv2dmoTxnle2vn6wHqViuOtr94STkGLL8trTYcvXE2gYOwtk50ClRCdnqEuUY1b8LWutmdgmtVJgfhvTzh8qSqxK9r/bddTbQMd6QRIincOgofib+nxIVtLDQR90yYXQVXr2H73bSjpXKQV7QZDj9XG6x9iMVvssTP14peeebCNdKVCy7624ZNWpJ9OKLy1A==
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by DM8PR18MB4485.namprd18.prod.outlook.com (2603:10b6:8:32::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 10:23:17 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::8b) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:16 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 34B244186B53;
 Wed,  2 Sep 2026 03:23:16 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 07/13] hw/arm/ax3000-boards: Add memory guard
Date: Wed,  2 Sep 2026 03:23:15 -0700
Message-Id: <20260902102315.3039317-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM8PR18MB4485:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 276b5e3d-316f-43b6-12eb-08df08dc340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 9kqjgQVPzVwcnfpUpHQP5HG3/+adExsfZExHkb0rY/9xSoy9VG+lmnws9pU5pchR0KHc/F52riZPtC79QNIHh5enptUNMh+57eqeyeRC6lniYdZTjdh5FnhN69ARqk0ypkOHQI/OfZIGJ9O7xEOXBN8dP+PITNDJiUbf8qEIsmBNG9jDr92AtRfc1RydlusVF8pxvp61AepvinGYbxmHTp9l/UGjI4vKJCP03u6LN0bXZFXmopjBbye2lCbra33dUvzcOt6AkL5mOBi2paGZXAu8+LWNBPFK0pBRZgJTnutyZWLZUoL2iee4IPJ5JWbMUEZ5RbtzFxb6c2xkaIZUEM8nlg36kKoy1f5QnhOYlIyNwmb3pbRsiMjjTT6bqbSVPFQ4cVhqYFAaX2ADzoQnv/fjLejdC1zOYIX2Wr4j4gcRLjVfQv5sFUVTk2cgZ1kyABl5ab7C3eZ5GY8aSWhrY3c9jdUMkgSNmDlhF0LhzXwmhdesxyZRq/FsHUkXg5vGoekxhwWhzuK1QlMu9QulWyJeOy8Cdh1CWRw0iS1pPUPL9aEHeXE+yp/znKjJgP/VKNTSmWARE50SpdSwN+QfzOFDvj+P7G7+VF95u2K/vlsd/tdS6TOeHhKTIJT3iYElSF3oD/5SseG2E2tC3e8rpM+dlnTSWxrWpE+VMwCDcBBZ0xpDqePejnP7M8iKCF5y+IGWiu0elpvU83vY3GPKbQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +VJoKxkZEp+gizJJcdw96EFO0xiKb/gNF4LMKcwybVlp0Cs30qz+8YpYcnmA8a2rnT6qHXIMLxD0H063m+t5PLLusPske7zCFHzOhHYDvo+xHAdDZQ1cp7yRI87tcQAzUppQ9oF0n42oXfO7zI55KKrGPJsYEstNG/pOKFa0Hu7zRvED13X/qRVZrBjGJ4lMojl9mqtdcTvFACosxYAtpAMHyrMSP+fM9jOISo+nXzUe+VZRNOcyYMYSV4WR8jmbSKRWSmlqPVF0+PrtwOEet8r0a3mASKQllEkCMWAON0icbJV7cB9Mtw48jNSlnMju0jty98j/FgzrvoXKlofDE2Lh8U1WZISM+dtQzuVjKBtqVpGAm+mHUTbfQ7ow6Hj6taRJB78TvYtDeht8Jno6P4xKYTyddgfW7RUMmi/jnlIpWW/gi6UfGtUy9U7Dwiau
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:16.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b5e3d-316f-43b6-12eb-08df08dc340a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4485
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


