Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC2C5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygeK-0004z3-7T; Mon, 24 Aug 2026 22:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeI-0004uQ-BB; Mon, 24 Aug 2026 22:12:26 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeF-0005qR-Lv; Mon, 24 Aug 2026 22:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIUvlELCo2/jBDr8PaStvVBf9AWB8A/9kinZftGz5T1X2T9cogg/QH1LmfL34o0U64aourBFJUytw6KQs0eF37qT0WvxZwD9vpqIpmXOLPQVkY5Xd50QufLfMGp8Z4sR2Gi+x0vjucD8FGo85xNy9v4tNeAw5ljxRtcpctfwMsziESB7tXXJtDsuDWAktxK1bVN3TGtkQEZeMCg4hKqBMS3OhOloZt/UimIB1YTPWIYP6JKQ01MyfIcT5PG5t67lmP+gClPVxnKMNEYgPkGKZI+uXkzdOusdwZUE9TrhxwmbvF/Jl10bLWFhZn6JYqY/f1gajgO4NDGJ0cgzdbdDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=OKTFnqjdzlFuA77sXOrSE/5Qat3Fqyw/sBB9TKcwjgQKeVtUKpMK3dQvzHaJkxxgBK9K2lCkdI8pzOzYttCgNYxPtqp8k+dGmmlAj7L4Fw36+UhrlSBxOmPecAVu3YpqtHvlNBZAxSpQciLznMCzFInLaWS/eLCl5gk+ZtryHT67tdgSK4/wbTLJZocT7HiZz7CjqASYy+SyjIjjzeAHkAyhGdIAflGB8xuTKV5WXpg5JXyc8MbUTULwnFJNJhnueeovgaDPPZXWCsIMrV1QAvN+jmJAiKFef5S/vwRhZG85yl8ZbjV4dB3aZDzI4f7NtCV6eYi4y9+wTKh6tJ0H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=NDcMWXe5xSZ2GFPdrIit3Yc0yd94KNLQG7k7aTslAKOxTS5NTThIDBVszXnyhn+ns/xq/xNWADDEvxNsKxVSQ4CkM60plilnw3z6E7mUvQnmqWkqY9eZ+1O7BGWS6GEImzi5ktUYDiPLzvUB4K2HZTtKj76vhww7pycSMmum6vXAQxYOgBDVV286BNQj/KzQIt4EPlFnbt/398qjuv0PKO1GOXjVC5AZ3oFc5viKHye4PCsQOuF9Ll3dIr2kEnJPc55ChHaXXTb5Svw7/P5Qxle8ZSt6u186lZnnNMV9RrmBBqevohPewdp/bqzxaaiakoS95NeJvsouVEBea2fJvw==
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by SA1PR18MB4646.namprd18.prod.outlook.com (2603:10b6:806:1d5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:12:18 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::74) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 02:12:17 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id BD9BC40BFE04;
 Mon, 24 Aug 2026 19:12:16 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 163wangjack@gmail.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 2/5] hw/arm: Rename ax3000-boards as axiado-boards
Date: Mon, 24 Aug 2026 19:11:52 -0700
Message-Id: <20260825021155.2475879-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825021155.2475879-1-kchiu@axiado.com>
References: <20260825021155.2475879-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SA1PR18MB4646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e11ac06-a3ec-424d-79a4-08df024e49af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B2ieZqFg1MddAXgBxg0Sq9n0msyZHH+/m02D8IN+ILI0nDf6U4mSz3OOVI2P6+WQrtU7AzuVJUyLP0Ie5jfap9iQimQeXlTdM4ZeTnPVqwRcivIwE0+E9Fkx2qVh+GJXwV1G6QfcXIvyNi1gfd0sP7WZrjH543qFCwLAjQzjM4bQMhGU+5zMkM9ifoDvKTTA9xxz/jEQAomd7IDQWbQE20ttg1uZ0A0eUmp65UBRITOsVk6/Ru+ApaCfopcu+RYhze8OZBGEoAfMOV4ba4fFHc99c6to0n7RPgh320bLcsOVkmNs9Fv/BjuTa3QrC3FUxyMb1aSNH0aceAC3BbM1c6uT4wcav90jolvM4Hs+XMxXJ5o6ct97pzuBULrqMtB/jGDhpYEOUy92sG3mLVNzesLC+eT0aJL12mUCO6ECKO7wPNWltXsFaN9EEn8RKdshETYf4ItRGJp0sW0ewng39dQHjbNanY/0CvjT/uXaKqjHFQJhvCdxM4VTd2ODH9/6xhkxMtxPKbZXEBRolQwf9zlMowE0x4P9x0f8AII0K3vgDLwc0x/w7oRHWoVOoOQg5byi3oeFcxaTIrwrkEShbqOTfPOOQIIDJzHDoOfoFyyPahwDacRT9TQRpcH+8S5NWW4q5twZ44GX8D9Qzd+BxMKTH6qdbEKiw4IyN0luQpYzD/kHllEDkE3T4hYslF4N4LZhdB45K54p/0nMAKlU1Q==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tZW6arxgJclRTji5fP0sUULIPB2WUNrBpuzC3GUxt0ZbePcps0FAD28sPl9z5nv4ZRw66RBzWRy2bC1EbqTrjZdcvQCWY3i+PUvyr34UoRDWYmRooyudV4F222hUXaZUb8PpJozjpizPlnQUgcpYsax9ANF8CliMFaxO/Udhvx72WSEtF/DeS+q13DVhx054oWrJ2DNl/kO4bYHujt7ufSTiuD+4kdln0qro1+EyderJga8PAga/bRANSR3xw3mPn7XVcNiOLm+vuqZBf9m9SYQ5NGKRF7/jS/lQ8O67lF+LCyOb3OfUiyyYY214rG3VMGwLp+Z3tRQ/FvXhTwnxvbHecGEsiu3o0jm+ZZldTFaObkvDnDdI6T3PvoNxcCENAkP6uU2vn3c4KnOZ/XDMu+Hlb1EHTzaUWl96vb+mZBLD3iGV68MMkcVw1/fkBQLQ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:12:17.5090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e11ac06-a3ec-424d-79a4-08df024e49af
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4646
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

Rename header file ax3000-boards.h as axiado-boards.h for sharing across
different Axiado SoC series

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c                              | 2 +-
 hw/arm/ax3000-evk.c                                 | 2 +-
 include/hw/arm/{ax3000-boards.h => axiado-boards.h} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (100%)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 4b8deec15c..1b645b7f43 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
index a170848871..f491de7521 100644
--- a/hw/arm/ax3000-evk.c
+++ b/hw/arm/ax3000-evk.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/axiado-boards.h"
 
 static void axiado_scm3003_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/include/hw/arm/ax3000-boards.h b/include/hw/arm/axiado-boards.h
similarity index 100%
rename from include/hw/arm/ax3000-boards.h
rename to include/hw/arm/axiado-boards.h
-- 
2.34.1


