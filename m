Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF4C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcr-0000HH-AR; Fri, 11 Sep 2026 01:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc2-00008I-0f; Fri, 11 Sep 2026 01:15:46 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005ij-7l; Fri, 11 Sep 2026 01:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZwIGXyKPS6MJrLEPt2pU48itruNx5uc2ycQePGbF1zTA3bQHIw0y0gUNHr6mQbqRl/Xe5PupkhfhzC5v0udQE1Qf3gp+tPlB4i96OUbsvbRP08oQI2WEbptI+wOe2bb2HGYRtSA+ELeMKgawOVLej3HJPeVB+LPeeTqIWzt2WdZOf63Kk9z2cA1nAmMEGxl3cL29aN8tjdyWY/AcW602Wem7cjRhm3Of381zakmuJ8kbeZm6kgWcvk4RqqjyV2n0gAt/w67Kfqgn6ptfJD3l1AmRwYfzxa+kDR1zhu0492LY8fjXbwc0iv8stFuhdOSxfo6Kv6BqHsuBlYojCMoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=QpuBGj91rnYkGR0NwJtbZVRX1zMIm2ePOahGfQyv6kRbUI6E8Rf0GO158FDKL3q+HT//BB2UraLAO23dGblZkI6Ob3q5lvrl/pEPzQW2TbbQIOugm7NHVEownR6kqR0dNLcaT3HdHMkQ4c4KSqT0bm5WnxQtqJYSyxGFMKJLOmDZsBO6HQ4a/mUGrDxILvEhoimQMsKTc+5EWaVqrjpqHYxmVpq/OPCcqTZRfqI8ye/mHGCz+Z1woxsFIVcN+WHXLVQuvFfDSHnwXF8cOYkMN1Ty7fRGW9RD4gtK+xrw2aFGv+6JYxM784pvSucNQboFGdJ3Gjua9OCXGvsfva8rFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=ZOcZK5wEas6Muy7mGjfi4FMS1h3FUOuM1IZpNgcuhRqA3Vx04/Tr/SO1NGomMRi2z23u5ofGgfs+KkXu7OGHTxbN2nLcw0ZGIwlFprChhOwPP5Fq6AfKOrSCodbPHQfSENTEerx+sthuEjatq/QHfug4p3nMZwBNqOIAl8UZEiiAt9D5F+L42grvpRcUPc9hR/jOZhNN4HcDzTiSwUgig+f0gFcTnr5coNlElQ9BJNSUWyEw6pPVNsiXBj11EbmK2PPDs4ikz+g3b/8JuPBhnV+xNEyDonLdgK5gb/8l3kp/JNssGTv9HAwnvJYX1K2r6jaMVS7G4N0yhL3aXgi0oA==
Received: from SJ2P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::14)
 by PH8PR18MB5292.namprd18.prod.outlook.com (2603:10b6:510:25c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 05:15:35 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::36) by SJ2P221CA0004.outlook.office365.com
 (2603:10b6:a03:5db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 05:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A362E40BFE07;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 04/13] hw/arm: Rename ax3000-boards as axiado-boards
Date: Thu, 10 Sep 2026 22:15:23 -0700
Message-Id: <20260911051532.2378501-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|PH8PR18MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efb7311-63e7-4a26-1642-08df0fc3b5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: jMz/6mbZfZLnXHkZsWNZaShmbsg1tHItZZyiZLMdg7p5bf3aD/NI2DhXrLSb0KIO9RP3QaJeUfs6DrZvjM0OF0Y+WdMe45JtZ7+E1/FpOY+A/MMgJEiOUQMTXWJL+azibKJSKW2MLyVMUcJczTrBj9/KDVvEDoGbio7qISvb78c75JidN7+A/FkP1mE5T2kdB8mNks93377PvJvSp+BBEPRpbo/GVmy90llpb2fHJ+u1yE5c5idSXfNQwKyzxLlR8okY8noqsdDjQuX5Eqg/tDeqXhkLiS8NhodnfnbT/cMCFZ1FCt/ESnIlEhapSHYrkIpUunZM77aOppqQ6gr+dA3AdUY7kzegNHxpXAPT/y6NyPzgI3GcUc5R6l/BRqe7oBeKhf4gSDHlVAKmBY8A0Br05hhPnfvKE/GBEWOfZqhAT8S267OwMueok1iGYNENXpru06GyphqbjQWxgTP9GOGboLVQ657DlhOhw3B364W2IlPhrfAAg0194QbsQAL5efWw93RmLUKUSR3b5O9lV+E1kW0GN8SNvTXw9gAaDTsJy0GI5ajzuItyiR0O03UgmwAxKCnYgs/PvXky6DR6NC8FlF3SHAlC9tlzKKo3ROky2fTFnXxz9hBM1JpMks+WCDzqI7vPpBhp0eaegaSJz371OY18EIyjxHMVScQ+hqrqQHtbee5FZy5szGgmalSXuAsnFzy60DqpWPxDglaKyg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e/v4cDNlSnOun8538jf6FC3idPRqxbvwANDw9fjVS0aQXVJomBW8GrSv8Vw7KTebf3dwushEz3Tf9nCTXvk5ONshpf+25Qt6jm89yCLcUaRHrej9eLjd+0ICr0JfAXh00xQA3KlhDTCOpjzlphG4+vO5Ek7VnpRuz1xdCz3Bu5BKAwqpCo1aHmv6lCuRB7fMNlXNqZAKFnLTmXhCtzORDQsssWIi7YQHf9t6/6YDrBbVzITFIfLaSWJr4TJkVH0ZJZTN7Bxyl3MeD6XhumqCsyTletAi16V2DqGEHsSueUEMUorcUIwQUdePFtBuN5baibpN1Whsesr4p8Ycil7m5MgiMJwYoaqwBK0Iw+M/bCY7EU6nWwX7lW2lARt+9ZOkt3NC193qawwyxWcUESuHFVVWEicJiwg8BILj9hDOTO3EVpnYYmgV7Oi9GRuWGySK
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:35.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb7311-63e7-4a26-1642-08df0fc3b5c8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5292
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=kchiu@axiado.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Rename header file ax3000-boards.h as axiado-boards.h for sharing across
different Axiado SoC series

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Jack Wang <163wangjack@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/ax3000-boards.c                              | 2 +-
 hw/arm/ax3000-evk.c                                 | 2 +-
 include/hw/arm/{ax3000-boards.h => axiado-boards.h} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (100%)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index dc98ee7b71..b4e7ec6f1c 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
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


