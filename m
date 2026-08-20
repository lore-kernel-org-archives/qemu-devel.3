Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C877CC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx04D-00066k-NI; Thu, 20 Aug 2026 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx04A-00065i-Fp
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:10 -0400
Received: from mail-westcentralusazon11023139.outbound.protection.outlook.com
 ([40.93.201.139] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx048-0003m0-Fc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRFkee7NooUSKrYlHKrhCcX4hz2iRGWj2kX8uK6EyeAXG1rwdCR5brIRY1dhr2X/CkB3koJ1L6ta+o795oFmJd0gJXeZW09CSVcm4lemFECS7CUMYIFa0bmebEef/UdIr88IAzwmBhoMGwSFU+ORSoh7p15wTKxLAKcuHVQNSwww98DNgvvDSo4pEyJ8gbBopioHNrVUAp/HJHybRQIl56WAPXRj223qmrnWu0ghYmem6a7Wm7uVrIP0Nms9vZW8AutNYShB+SdLw0Ut69zc8XK/0QoTm4NZpDkIS5jinVT6nbgOiEh05CFijqmGIfQ9tFOLliuk+xlcts1eSczRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=BuGfeJdS71OC9984veytCeeH4CvdaI2pkbGRomD51RR+jeEpK92yTIeh6GEc53oi7Yk1xkp2o5TJeq4YJfbMztzjQEc0HeVt4ztOgnpGfXFVMFSEwzyTE7QuSqRO3zZUKoKPRlS8bWJ3Q9PGaCcBf1E6PVBKRKvh+kJ3iGmjALewIBhMB2Y6z10nthHeQgg3sEFA73TDfd6aKbZ/zxF8/ubLUgzQp8lBfAKzafyc9W5rk5KmRVRhvw2R/suoR47vx2UCoAra1Yx/ESgeihfrZLufnD8r3pnUr9wMKl/5Yaf/evOQZjutm5ImP2RnNemTfAhCKs4N2v55bfrRGP6xKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=oPopbdsPpQxAnqbUx9EeuKk9HcuOxBsbHohy8/sCI9iiMkNRwzMH6p2mY94S+XfxMFbcx96p+ZEwUN4x2FE8VclbFwI4GRoge4xtWrbjhdtvIQhqegE3WKXiLSMcSgwYrFtCm2bLMR5t4IWJynjA2SdNna+n5eWWRYdRZwVPgv3vvZ4p/R43OcBrUWK98e6Gd99hlDYlLfInK6fp6FUvGo9EZSOcynpTKexWhBShJ6gU0JrMzy7eZzQEnEiUy29SlGD34Ok5W/JzaQ5TYJjQgPFjGTyNZbd3femLsCMdPulm1QQ6WQfJNFahODQ1KisAODTP3QNsCHa1vuKoJhzf4w==
Received: from CH0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:610:11a::25)
 by CH0PR18MB4131.namprd18.prod.outlook.com (2603:10b6:610:e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 10:27:02 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::47) by CH0PR03CA0334.outlook.office365.com
 (2603:10b6:610:11a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 8E9F14186B5D;
 Thu, 20 Aug 2026 03:27:00 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 1/5] hw/sd/axiado_sdhci: Add header guard
Date: Thu, 20 Aug 2026 03:21:28 -0700
Message-Id: <20260820102132.361642-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820102132.361642-1-kchiu@axiado.com>
References: <20260820102132.361642-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH0PR18MB4131:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e341cb4b-6bd9-475a-bbc8-08defea5928d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Cg3AOSLYDXZMoVSAu6qZhb+0PxumfbZ4L/6YGxXEM425CXjI4drBQ4wcIJAYGn0pcaH1Nx/JknKjJMLL2EmeiKaynNKNegve6djnNoerk6BzB3LsIfE3+3AqostO/Yx2GYhHxTtZ0LIqqQTQzYm/wA/E4fyjkP5QDSWc0PZb2CbO8eSN5cIFptelq56yIQTLOzAbFY02SnaO4XFNd9sRc6jTO6QA2lGpb3Yelh3TRAeHK6UFzT2ZHz2nNkm2T7w2mkJfe4gZ4+Cn5GIBmhJ6g+0KmhlIcuRvHflmQOmtxuj4hGdnGU72zI9dmC9zrfC8bsr4U0F3DmdwrYHTWz47b7Krm910t2aC2pEGsfwMh1dm9keOGELyWhKO6wQL8pLPQaDxGUGDx2I6tZMey7ftXPMOdxS5q0yQSr0VWz7HloG+/8TqU3rgPCXEBWvXoBvxX//+8iNqUgm34fA9PgIjE+0t/dGOYlQ2XJfa4/Xbq1YLs9ju7CWUoUZJsDMZwqCT+Lxq/SKvxiC2J1CfPxOcpD8P+AmpsTRfSdIBrte00wiu/te8eveSagO/pUsaTfe+YveAs0X4iIu5KjYPwi3d8S0xR8FcsPUEN25t/a6FA3bGDseKUbAp8icDlgHU73hD/TPX4b0P2Tx9Ig389LE+pkHbQIrifyn18zxIl5OplRMDQDpamIEgCnbr0hfJHhCU5qjPwjb1TkJXZ7D5tGqReA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5srr3IEV6N+Nzo1sXXbzwXRBsBgyPNO/Dv4NQKVVUJJsKmj6EeXiPkGzyN9ZXZkYq2O0mJg2wbvj5013ke75RsiUTd94dXYT+iTvSD3XkD/16wA3bNLkulUPGW2RE8Abb1/R42V/3BhL3KyxA8puWBgMBP7oRXQGAgFKLnG1F05vmv8D+bgfZCVMuSTW7b9aqH9h9pCoFfJdEzbQa4mgllhvwYLWjEKGQCdXAOWhTzJM/Vv1CJ61+UwqhtbHf/4w8uRYs18zZ3oic8N5jMpoCibAJ/NLwpbmJz+U4hP8BkVubivaiNJQWOgXdPqpdfnIQd9aFyBrzb0AracfWpQ7I1UNM3BlxN7lyYbzvss3BOARVDe1wIY2s+rszdW2vfktNSc/m2wUYFARpPAlSkqgcIB/LQTfyjbEOEEr0GhzqMVGnGl7THYL0/26Lj+2IqqB
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:01.3627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e341cb4b-6bd9-475a-bbc8-08defea5928d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4131
Received-SPF: pass client-ip=40.93.201.139; envelope-from=kchiu@axiado.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


