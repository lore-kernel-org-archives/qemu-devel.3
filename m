Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27DBC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i7k-0001jB-8M; Wed, 02 Sep 2026 06:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7R-0001XT-68; Wed, 02 Sep 2026 06:23:01 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7P-0006ma-So; Wed, 02 Sep 2026 06:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww5XaX4boDuy2JSNSKQh5yL/tk+gYdh9O+1u+BVpc/4rZPHE8cBj+F5Ig0+m6/+alnhwRwaGHzSL41u9ypSRramizFtuNYIDPueCaF/ELDvG0nSpNbf1S300Q/yXn7ESaqs/ZPGAzDtHsDAwJ9MWqaKpBpbMIgQ6JQjqcNYvZf+Sp8HxREsN9NR/g++P/EkXxfeamS0740zrgaGha/F84K+0UwilEijnopVM7++9Q90r8PALvjdsM8P3pwM87we1EPLPsxTlhwsvnGBIYk2KVfZD5t3Rzu2loRfVnPOG6AOnLWK1O8UvxctTdxfZXwKVpFF+UIYoHaUM278PW9JbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7RuoKR/z5ze3XzVEDAEr0LgnMlkWw69MJ0HkOPOjhY=;
 b=jHbby/rNwena4ZMEic6CVn40sfWVdldNVfcFXU/IB3XlQZSD6I6PiDDMLH6LmZ0BqtE+OIV6H9JPGw+tR5q+vWO8qVwPqBNop4oXNFE2e4YBbqCjCMiLRFqHdPU85WSU2VMRWjh9ISQNKWnEqcggIe50V+lrzm6YRmB1K/WCqPPBf66X95dldqtdTX/BPKcbvleeS44PumBp6pg9dFPm0PLEPQdVnV7WfAF6dob4Nz/9hcHXORve2bxUoAjM5HaSYQAFB4Q4ZtqV5pHxtO8OpgsI+qZEFhpYlstz6QVMBdOq04wbWpLmbU2s5xoLaLN6O+dNIVAc3VjfWe5Ej8ROfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7RuoKR/z5ze3XzVEDAEr0LgnMlkWw69MJ0HkOPOjhY=;
 b=TiuFH7bksAf0ivBCLCSBrhIucx7BBTP32wo/M5c0vBRYyenglKtYsIBZgFmBKclZwk8h5VSXn6gUCCZH8ED7/sk7TVKHx/umj6zZEWqbxWv2mllUi9oIaVtcnhpBpOnZL7mtw4Q3xJN+9grcQK1iC3rp5Bp3svl9BRGyRVDtaoHadt6aYR9Miqa27k94wgzqO0CopmEQwWsLcBOI8yinI/F1UYVITY6QoJlveDPzWdnEMQ5jHPxU2bcDGsQBvGmtzgzwvglUd7DHkq7qVQ2zO5BY9q1qUh+ddi31S5mPQFXM8OaINgrQvBZCTdziX4jNL5G/eou9PrxNd9kP9qxJ2A==
Received: from DS7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::6) by
 PH0PR18MB988450.namprd18.prod.outlook.com (2603:10b6:510:3c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:48 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:25e:cafe::89) by DS7P221CA0037.outlook.office365.com
 (2603:10b6:8:25e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:22:48 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CBB6A4186B53;
 Wed,  2 Sep 2026 03:22:47 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 04/13] hw/sd/axiado_sdhci: Add header guard
Date: Wed,  2 Sep 2026 03:22:46 -0700
Message-Id: <20260902102246.3039271-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH0PR18MB988450:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdc8fea-9ff3-48fc-4d2e-08df08dc232c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: m0Rkh0fRtFcCoHdvOKXlk+ieLc2mPOpApfXVemrPGKstX/WKjdc3PL0WEf+LrQONZwI3i22WdbZ1GWeg/KGAFEy4fC6pix4DPthNpztNOW3sXFl2vC7VRcfRc9laTc7OTqMeL2X+hbN2kVpA0pJkx99+sc4fdsEsaHSlChYDyjdOhtKgDIxjXyFm+wfHIfAx9bX52G3nJZ9+I9pJc9VpoUL//3Ji0vUdwLJzAfYkl4n9YqYQIWETLHfqmEO7noDfhpRtFXaGcLvrz6pplWKCsnzp0YSRJPzylDnum4OV9SBV7feVNwBvtGFoBmsj+p4XaD5RGnHp6x0jyVY06PlYNvdZ02qKsUIhZ45VaT6wVaSBKgotlIDOh4DOdNrBXcfminfuLKLOnv1kxi78lQjfliuE4O92enA/DJj0me3ocRe9Mhv174AaapVSh4X8Td7IyvEgg59YF0q5jrAssylk206OC260eDCCUMeGzFczz0e30qaw75Y7Fa26FdI0sFQGCi9762/PxhqQSuzYlgDjQtwomb/x0MCn+2y2Db+ZgtwtfZ7GIB5aiTIc3sJ+wViBAVFLDnHRoBnJ7De1iIJ0iVCTDcAheawWUXWBDEOG7FHQaDYM7KIV1kxFYltcHVFxiM1fHixZhdxx+4TtknE3eVGtN48vBBlJk55sFTYDn4m8vktYVTi7lWKmMs3Oz3zlGfN3EEW33JZOFdKBSx8Ghw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HBgyUYkemhv7fwcmzJiz/WwG9w2WzYca0V53pOXo0TFQOrmAaBgaIF92j2ra3Z7Un+4VPcYVSJq+QhzuXw5OucDF2/sh1t89ZxHu2gqEo8JQlw3HjWQqc6CUJn6hACa6uryNEfSmHukaVTNP/yvOhy23mWAbFxsNELlixTkuaySJ9Av/PH3z6tLMoezr9cXH+3RD5zqeieMRFZL4nz1LHGXer1gxzMkCExcRwFP2LHFVvxyjkNRiMu1HEs1voMc4CbWFfO3QsovtUQLiewbTGOD3dAF3p33ynKLBK8Xb8WfLR2Gp/W1XCckHRgdzuKXFMY1xjW9fZ7G4w9/PCSKshvmswgZyYGKkcLA8NIboL/5TvU4GOljjU9ypVrPzu7s2pPx0y9fY4y5zjjgYEEftIaGZfnze9fQmDS/luQKFCwuUuGbTIFic9Y7gh5d/4hjW
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:48.3978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdc8fea-9ff3-48fc-4d2e-08df08dc232c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB988450
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
Reviewed-by: Jack Wang <163wangjack@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


