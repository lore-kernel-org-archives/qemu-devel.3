Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F1FC624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i7o-0002Cb-Bp; Wed, 02 Sep 2026 06:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7V-0001du-Fw; Wed, 02 Sep 2026 06:23:09 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7U-0006nZ-0H; Wed, 02 Sep 2026 06:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psSH2wU0mcf22/1RCy87osnlEF8hTZBAFHVf/x6Rp1TjVvlyyyqpP/761TVd7PC7ATvDjotKQZ0efp4qQ/533Eq9VSKzuHEbOHXuFfxPcr7zdKZafPkPwKn7Qdf4gtXefxC2BiRlctv8Z88ViW/Lc3BYmX5Z+YVw9Xj0Jd4kxBBCzS41eNtw840QKv9DTPSMnsIqm2xIKLtPo4176xNjfu/J1zVpOi4TJ3HCxqNXd6FNbQJNAXBQnmVXjaT3rlzNvA84I6SW4j/PiGxO3SjRdTSORlXpZT5u/p1ebqKcpLb0xidEPvFJECKgiKJxva7rDEMVWfYejPhNRAFf7fFfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/TcmHiPQ113LfinQzXdKB0I+QriREAaO4BJ13e3hhg=;
 b=r4TXm9Clg0fQ0FkA3STixF9LhDAN0nsunFeg1O4jFOqY1j3LPJ5tilMvZToYr+Mbb1o2NR32HImKm807SKzQtCw2lZZ7doSESiOc+4cqloMqPSgy/TOyP2iL1iSfUfvkFXAyrLt2duOj2kN+/Bd7RB39pubxel8tq6SDo8SLqv5JERSJVTLWTUJeOx+UrdddZcgC+6L/+/CWksbG4HXfQiOna7TeB8l5eWvqRE1fHCRGtMNZSJ7/KSqORMeU5le7dBprbW4+CSTxZhySUFg+3o+13mEY8E9Fvm6ovT9fqGOt76i/Mg8XyFqgTdPIvoZpCvu8lMF2YSzaNivzOA3rUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/TcmHiPQ113LfinQzXdKB0I+QriREAaO4BJ13e3hhg=;
 b=kZYV5sWbHFx9qv3e0610kQTUHKMAQqgO0zDbkT1avh6UdpJYUFPSWyOPBvVRcwCMoM/yki2/g/cLPitztPXvxjhZLdJCDaItOGDJhBMwijQBYjKx+PT/2eZ8WIAlEfVtVHva+FQPVW7KXpdtGuPsvrIaLZ3YXjLW1VmZz/MtkDGPZyCMnZf9pR4owmtqek0ETp3fd3QS50FT9DtZMXuS4a+YMdiw8FZqyFYpawA19urdRhZxirI4bmaqY8krzJvoukGEGWRV2L9BOvx8yFIh9vtsejGunq1URo2XcDuwsw+oRMES/EVvW5MvA04VAXRLUSXyiuz9HtxM1Kua07YTPw==
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by DM6PR18MB3682.namprd18.prod.outlook.com (2603:10b6:5:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:59 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::3d) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:22:58 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 34BFD4186B53;
 Wed,  2 Sep 2026 03:22:58 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 05/13] hw/arm: Rename ax3000-boards as axiado-boards
Date: Wed,  2 Sep 2026 03:22:56 -0700
Message-Id: <20260902102256.3039288-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DM6PR18MB3682:EE_
X-MS-Office365-Filtering-Correlation-Id: f148680f-5d2e-440f-5b00-08df08dc2911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 11AlbpSWOphaFrct42x9qUr0GfXckzqFqdRWjlhha6IsqlrJoMr5xQf9RpI3q+i0gFsLaU5RHknTbcnevUzbPv9+Akta/Sqyeq9GYZ/jNCbdUsrdiu0N+Yq0Bun93HGFW4MefKirC0tRmXPwgI3IQ+1ixVrQTiL1GWGX1B3xr4VhMv9kta+Vni2vBf8EL7HciK8/Fal6Nk4S1PCqlTXTOHAt8xnw7IhCjxuNtgoMsamyhOaQS6Y0zrbnzaxzFowgzg8m1DIi1xpQnQEJ+KAVjJ439DOg2dQyGUQvdL/6FYc5GzO5TBYaMYL4vsxh15uRRAHSMkhHhSjCs6kxLXrTKcL3MX67wjZ+/PMxfcPBZJOdy5gdK9dRtBeEGsBfklRbTMTBNkdu7Fd4qmF8+bpo60LVWTJkcxxfjSEPg7Ux+aoFw7h9niu4F6cPCognOIUcSP5roPLmoTqHyFePe6tNrF5uhjoSHnATwC11IMiAk8CgTvhy0wMAkcUJhMvb56J/uYYJKxIWVCV4TXO8Epk8xh8UcbsoqWI46xMwv5Pwee+SlosoNiwXLgNf07nJ2cspB35aN1wwtdHfRhvVYOvXGZ/NyG7I22ebHjJemNA5kkoZcRiLq127FEKGBYwzYYW61JCqPrfLIIq79fQm65SRT7aRTN93Zg/8eq2JYidBL9Wcs9AgncRYiBttnRHHXgYv7h8Ff4QSP7LYeaVP2/4nNQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rL3ZhusAfY38Qk+jUtYgZbRDVFM7cwDm3GIOATTlW0Nopuo+sfaOLhW2HXiWR28JqKS2oP6u6jVNTKGlGtcWMghpXqY39AftKBhOKiB9czhH0H9Q66pqtpDQ1JySCN6ZQ4ajQYZbsIl6MiqNX9is13p0kRz3jpJfh5GTpz/YmZEFpEpkrFcCsHUzokVmK8BtVu53khYE68j2s+YynN6qKLYgowDPYQf8Biq7aziVokeGS8oWs4UzIgOZ6a4G/YiTtk6r99K1pLK/srRh/E44GPs3n9df0zFl32tnKFmoNC2k+JUQpJVgCWDkQ+HpmQyLnvHd2Mow+gnK4eba93MnGZ2HlpAXHBSXtQs+7sGlbw6gkQO3jXtyZNukYHfsNqJZJhCINVhH76LKhwLzueBOggO9KEsL9bzsAOeWPoIV/NUvHZ1+74pXBiVBqUbQpdf3
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:58.4276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f148680f-5d2e-440f-5b00-08df08dc2911
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3682
Received-SPF: pass client-ip=2a01:111:f403:c105::1;
 envelope-from=kchiu@axiado.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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


