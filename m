Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4B6C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0I-0006aS-S7; Sun, 23 Aug 2026 23:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0H-0006a0-5Q
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:41 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0F-0003zT-Kg
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXe7tGyGGrZcbNc1v85KXOyoei/VupvT5IoMe4Qxpegu/xAyLJKeJPCm9aq4Oko65+oO9PHw6tV1Yh7bA0xGM7Qc8Qr/xlpYptBmcD/7+mubbEul+VT1PVQjiXtbN9XffFcArpFakWYJ+sPxqRguQUswP8aYXeAYjhx5zjivXN9sD3BgJSlhIvbDR3VK9A1MnA3BAgasCQNHrIZJ0nhgKKrAmHcs6a/v8T76Cx3FQpUMEahtA3Lc922YONSslbpPqDJyAarXVTp8kK4YbWoGYJ+doYPaQL3DpQ6QL7QkqXhDiNiDgupxzyiwdhLI1ap8SZUHyx6yXHT4+6gWuyP99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=OZrxspR9RPGU6tBPPMEvtzh1wp28n6tkH+fFWVI44S/Hkc0F+VePrcg4EN1IXLDzLwYdAhHrJZfx81rkOzNikx47e8L1r1fBs+ogOXt619NPrsBVAb0vSkwHx79sdlOcveDRDAjpTsoyCBwS3mAPb7DSBRTRcNPq+P2ijQn5iIdsEIeW46Q7zAchLG8rIsUW16LRn0c9n3Mk09XmxH1sUDO+IHxKp5n8zZ7ub9vBUD1iforAZm+l1RNv0NWjgSIKMSCkw7iE419+qlG7lk1YXVllyemYA8j6X31mTh8/zPNGOQzIZiTXMW6KAOpEeRnHBFWy8RLO9uu+S6tQR1RvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=QfRAJqxfkW1uIJFlQ5YeqxAUZ3A0IAHdLaRS5dOlseFI+g+VV3Ozs0CsBH97neMVtSBoygeoN6wkgprpwboMDc1bQEmK824XnnnVqrFxywr3+obuZHa3jEmhaovLuoU59Lvy/EOUwsNhcfO3liwcOmlNWaRtMxAs4sO7oweKH8SToOY7EtG2tp3po3bXRwWXL/nKcDRDPForuhcOPVxt0E/iBEILqTSh3h7/PMbPnc9C1xJSgZlSbyH9rsn2+iHgM2S1hKiw3GE3GQdjpymkMpGRswUDmM47qyzhOfnrRSCCex9y8cpInK5oRKNPvpjH/QOL1sbb+jz5CAtNP8gCZw==
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by LV1PR18MB988707.namprd18.prod.outlook.com (2603:10b6:408:3f3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:35 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ae) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 03:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 03:05:34 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 96C594186B5D;
 Sun, 23 Aug 2026 20:05:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 1/6] hw/sd/axiado_sdhci: Add header guard
Date: Sun, 23 Aug 2026 20:05:00 -0700
Message-Id: <20260824030505.1969726-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824030505.1969726-1-kchiu@axiado.com>
References: <20260824030505.1969726-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|LV1PR18MB988707:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b17bdbd5-36d9-462d-ba4f-08df018c9102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pe9mHMW8RBqgLu/CvFEfKBHe5ti19kDYqGgV5OsLvmdrGba+ZgyDRZXVsc0dF4dAMjlYpwl93+OS0vmO6aXqB5n+vASHkSsRlSqzy5S8OTKamCRym6ajmulLIf+tu6KiYmPdyYJnSuXwmdANUifAyYg5OARk5OSCsWsESoxy1FIKnqy2X1N2pRh6HMuY+74qs+PNzkIOJgX3o+L1x1c5T0DaluExvLC27hCOYw7wiIIeGhNUd2yr69Mw1FP/p0YSxjERTCGBZAZs9ju63RQo0r1aHr892ZLrNiUlX0lCbgQfIFR9Mela10YiUkVqGt82YGYIC7TojotuRJoBrrNoox/7qWwMs1lPc+Q80vwXU80x/559yxP6EjovR1cs1SjO7iu+fYSLB+cBUUdMtNpIioP9VPvDmyvXZm3W3N86A/uaNY9o3Yi8vpno/vmG5xizEB7xOsSIbEfjYxJoiUlTp9K7sn+rxJNGdMruhXQ6AbXSRQAzzzIjWODOBW4+58Ism3V/AeZh+LqpjnOx1WrIlr8Dx27tlZ3tvu2mfidi/BtUgjUAqGEiXHf5mm8SHnhPkeIbWzJwL2a/jQpfQoTuH4dOuISwPI2b5hFtjgcMStttQMSpibaoqYxQdudDkErEnvscKuKMMOXJzmE2c7gQkN+JRLWbpQ4j8rDtpygJBfqZXtz6NqE9hf0IzL5CTq23o/SZd6XHP2mnTpu4lE6i4g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3OU42NyVuUakHcphveca+UUSslJzOxU6oKLdcP2S3Q15wIgRTAo4v3FGPF6STNhwlNOwVpADm6x0PL9+RJR6uzxJk4gfE96BZOm+p5JeHE8dXPaa//cazTUkhyYaILDd0Z/4qSjFXPlo8RmQ5kF+5ieShqvpTywFJ4AajgF+r1Pc/oXCDhR4Y/Mm4bX3kmwa/5d0qTDBM3xQGVWb1BHKD4k7sLWUPU53zO/Im/rZZyBDoarUQus6Gn+9k3NCfWSP2YuPVAfOkUeEkKhJZFodlJwMM5Z2UiGxobBSG2yZytuFNLV1DA30IuvQuXszZidsfEzu+RbNofJEqKPasLcEXJzmOrs63D/6CXEB5yoEcZxBQSD+nGlDulpitwt9F/OY0eF6IX4m7iJyF1DFXOyytlIazaMtGZZbfswd7XFyOMHvPueALpWqBHY+UOplkKUx
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:34.9378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bdbd5-36d9-462d-ba4f-08df018c9102
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB988707
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=kchiu@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 include/hw/sd/axiado_sdhci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
index 85afebad93..ab52eb8185 100644
--- a/include/hw/sd/axiado_sdhci.h
+++ b/include/hw/sd/axiado_sdhci.h
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#ifndef AXIADO_SDHCI_H
+#define AXIADO_SDHCI_H
+
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 
@@ -19,3 +22,5 @@ typedef struct AxiadoSDHCIState {
     MemoryRegion emmc_phy;
     BusState *sd_bus;
 } AxiadoSDHCIState;
+
+#endif /* AXIADO_SDHCI_H */
-- 
2.34.1


