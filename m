Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF9606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=hHr/1uJc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwLv-0003DI-Dx; Thu, 19 Nov 2026 02:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLV-0002zz-Sl; Thu, 19 Nov 2026 02:14:15 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004JR-Hz; Thu, 19 Nov 2026 02:14:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+BH8DQSq7Lk2y/Qt+4AZWJBTYIrTEKF2B4lfmsdcUyxjCPGgxgxBqiff+s52ORjXr7bwTPx9Mwn1KDo7W3QLayBzFuvtfYluRdd7+93ck/SVV43YqJvMX7QBVc8vPFUEreHNsIFlf00+7IgufPfOebU9H5heyzy3NPiLfaRJPAy5I6BGPQ5LRBHOAUgDykMUSCWOz4lPzrSHPYpFi9e8HUfEbXSyif0xtR05y2/sn1UjWKwBwAlrLjNjYHX0BpE/8BE9xPiEfoelvamV2IJMLkT4hSS3lnrmUCD0UR6mKSyfkgFQqSGJoSfrGg+G69qnbqC8JSC/nhS5sMsjxuHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=RbD8g4Y6foxxNQOokgEBjS+mn+C7ZvmgMCOBrVkToUazTRqcqHznJ6/FihM2WU04dLJ3srFf0OG6qN6aIJ79vrwZ/X67rAFO5yvAUN//Havl7CvZv85TfT7EyUVzv77mcVqdbCnuJVmfC7DFryHV3vxEzB8QQ5x/TUOrg3aJE4YqNge0CtNF8c++BB58pzlMxTVxfe6GxYzyyIkeAnY4Ik5PojBqdMZ9yssLpiCpKYShwZBY3bj0kWVOvyftETrXxAlUZ9jyo2vkNKYYiSxr5tqUYWTY084aoZiPEQpoB7lXreDETTurrz7jLEHnR+OvLOHShbFy1Fvg2wSEAmQMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=hHr/1uJcAuw7SrfcxOZ4eKkUxXQF8r56LLwY+5jjxKEI+YzrA4HOShW8pgSKUAPJvG0OEtEk2131Sli09Zr+9cTxbd9eLQnpaPvFqaw98uy8y04wR4PBhbjtlTAeGOsogv/yqH3Jz4HcdEgqZTLzb3Jgs3foDAy96T1ETRteEUiUWsENGFXpeQf9GxYqR4+TW/pYzzZHM+NMg7yxv4Z1V61rZ/GKXiLMgxecrfjHJ4KHpwW+SWFRCS6H9d6IYG76iz5jDb3ClTrC0chX6IxWvE0y2b5o1eUyvCKTOYK6d5xotWnKPoc5KCu4cdtSwznq1f6/cJCOMBD1Z9wWPf48rQ==
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by LY0PR18MB371118.namprd18.prod.outlook.com (2603:10b6:404:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:00 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::3d) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 19
 Nov 2026 07:14:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 07:13:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 3B32C40BFE0E;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 04/13] hw/arm: Rename ax3000-boards as axiado-boards
Date: Wed, 18 Nov 2026 23:13:44 -0800
Message-Id: <20261119071355.3520249-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|LY0PR18MB371118:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c5f767-5896-4bbb-bc25-08df460caef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|261009223027099003|18002099003|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: r7RzCfX39TmZV4Ii5SGpkzYNsNoTbrYXOqTuMx0VRmKZ40CkVPU/72mpglcOcrvbXOs9mBsM00hY02z7uqeWsSKSIwLirwsG8XJhLLnKwVRdw3vbl0AIbThqLtIK8H6vQG/t8tBabmz9TOhEo/5n+AReNpbY9QwE1pBYorMCy7p90om+DuJtYs0KmKfxjTxl77QTZLvse9ekeCB2QWExpZD12wsu5YK3sKOYsR9BvHwSZfW6qajpHs2XSsAbMqYAbAFRm6G7hdaEvzvQ9y+ViDoE7WibNsTrTkjpQrzwMuRNgIRf4xaPy/VKydwnvV4SavLpR6ECWZnRaN4aCM284nho8wRtdMM6ZAK4NbLZto10YHuU5YiCOOdPlQGYdUQKgUIxiy0gpV9ktZJRg7XGw1EHoF+NtT2xwhuEYO/ShOMQlYLzJTpJFa4z2jZn5o1AUATtVKiSNefh93j5KHrrCw6imq6ekMJo8B3xWqDF3GSppFKDfWP0uPDsiZZOi/feqY7R38UqQL4JDZf7bNrOiQqCJGR/OS/AulgCOnjAp6QVwqIAoeHir3tad/f8i5uWALBjvIQU+kwWY7VPXyJ4oiypm58ihjuZPSOW4DicSZvV84xkmPYwE8MZMUKKUkYXuvC2vNdD6mA+/y5P8sCaPRoStzeuGw0ysbEwR5lp+HM1DC0trwtusnCCSVmyblEFyO1OTfN+zfq0LRNxXTrx9g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(261009223027099003)(18002099003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zUa6x1JiUZUeegub9LtPBJ8gTubOtGHqGNHdeXFmx+KmutGJArVtVFPJdpOwLkG8QS9oYBmtwSuznkMPf0YxJnDodZ3cnI4OyTwqPSCGzJptHL2496d3cjTZKCXVGO6bPIntGqLA9SQ6LO4zkB5asKSYVNm7sHyWuWr3XhVNBCFqaVyK4gKNmy5n2zrIEUcnLy/3rWj+C5WLc/cPu8ciMPsfLWqhmZOMvsEZQ+u9Oc0N/QrGa7c5w+O/KQ1jgWxW84P5B/jyE7H/e+QYYQA2G0uDQKcjVg3t6D+p7GA19CE8ocf/dRYIs42nJDeN4hj5tE0fHhcL3nozcebRIn5wdDzNciHaqn9joM10cbdI+l7sd9rJvx6eLLxY19QHTQLnyfrUfm20Z05VFvgCWlEoyQ/5xMlnebDwNFFG20KKdN8tEFyDMV5qsjqU4kwCVGu+
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:13:59.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c5f767-5896-4bbb-bc25-08df460caef8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR18MB371118
Received-SPF: pass client-ip=2a01:111:f403:c101::7;
 envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


