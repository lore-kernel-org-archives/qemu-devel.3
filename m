Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDB3C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyH-00044m-Di; Wed, 09 Sep 2026 06:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyE-00042Q-MH; Wed, 09 Sep 2026 06:56:02 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004Fd-SO; Wed, 09 Sep 2026 06:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4sra5Lggo5Dza3qdUNqVaIxBLFgtJWPXTJuhLaEACmvE28asyMNE+EIoVrd5onbUvAnJ59E6VydvvtbP4mGoqnZXhjXnoXYbQ1d+cZsjCWJKTGQlyLWbWc+sydLjnZuneyTLHT83cO16SoBr9T3w1rX+318CUqGVJjSM2ASYuH8NzI8tT5EW94P8TDvC27nFxRB5ShxjpB8ZSGxhK/66bTp8K2vihxvTHej1GGuQWfeivdAacWSsTVWvbO2qrUWd6U5wtUjI/x+prUQFPtB+d6UTzKD5yOSJ9YcrJzCj++I6Qz+7um1OIPUoYUJpeAyREchiz8PSgrmVvt2nrUupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=AoCyHoJGRoNeLLG847ZrvFgQhEfb6ROTuMcixqp9wwFPf5nVC8GMMxkWJKVBFgdk20IfhjW6K0BdWF3RzxEIxJH8SMQ1Hg8u9cn1VxENxHmbhpu0BfDH9vOyzdchgm4cnixinhxXLfmJqSgA4oYEVqKFDDXcfE9sjtrClzAXbm46yfGhnBs//4q7+AaivZ8OIzysUk3MfvxZNX7oqQQVLlCmqAnznaMqqMgjEa3J1E6z7FZD7ooq4hyUcGOT2+sSMqM+ktHfK1MGtSZfpp5NE8dPK7DiDC5iY/bS2q1RUoDkyKnMNjeHSJbCR2GDNwng+SjoI9fvK/OF/lm9UUVZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp2IMpRJQ9AO/vEt/ZMxRK8McgCLBrrwJP7jadipwJs=;
 b=XZzl5seem5jPbMZxI1CiEgC2Md7cFUneyZNJBE2KCRHvDBwKOn7Y7Nmu7sGFoaVk0lnZeCr2AsLoFuLFoLnwmwmLXutvWx+VVt1SVV6mPj3zr6036k6QatyltTXfWaa8YFzjgOfAKaM0+oJufMNWOcNFf6yAdw/Mo/hEjdW+gP00YuThMG9xtATrQPEXRHo+iL0i0+TeAlyxDfvKg3q2li+7K2baXspzv/S/CmjDXBkWW12sLE3SU+OiJlQ9GiC/meEdb36hpArENyLOMnRN6K7SLaAkl+pt0NgWFA4SwsjP71tAMccozmA2bolAtOOUeUv35d0uHHiytsrSs7maJw==
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 CO1PR18MB4698.namprd18.prod.outlook.com (2603:10b6:303:e5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 10:55:49 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::65) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:49 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 70B4740BFE07;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 04/12] hw/arm: Rename ax3000-boards as axiado-boards
Date: Wed,  9 Sep 2026 03:55:31 -0700
Message-Id: <20260909105543.1478008-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|CO1PR18MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe3a09a-d2ae-4185-92b1-08df0e60e8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z3HX+fKTLA2EpXkkiK1+kpW9GzW6898pJNlpThykVFie7QN8/VpThq9ZLrUrEPXNbWqJqA5MXvYPmVYsrXO1uiNopBYRHForwtQEdS3HKKr3yTK/11lesHXruwVRZQ0OqK/1vclLG8djPjVocMe4SP4gzeNFVtDOYSjBmObvs24WUHIBEEBwPkDAXoQg+IJfM4rnUu4T0SYDj+dsVmo+u6GD/gqWslHTIxGdXqmN1hfkuJVg1NDkvoJeUOQhyMPYGchVKYOKEHw+Sex+NhpW5FexjjOFch3cXhq58iEtdDbO3onDU1q/N9GHUpKLIG7WRQyqE3q0iV1dWLqg6dt+aKcXRU8Q92EtaYkLY7TUhzit3ccKsPkXAdqmcKoPvlzEz7b5qmY6lNsKd6NTdffoBfxMct/vfRPskIU7fMsdKlxagAWJqOgilFteESLzAvXDLro+Uk0o0+wK8tRkaKYaMEwHdd7QVXK+BAgNVZUf3D+FAQcC7xFnljRu42wwmNIofH8ktOc/ZfJkPKTbyD9lUaPqW9jVz43t9SBtpiInMVc5B20bjn0s1IACHlj+9QXHiSgW6hCbOonvOJv5o6/o1hNnPGeW/Uc4OrI8FeY3XbjMCriMjj45Ky5LZQvYaDJEgzSxyDLKmIOpjqNm05j/sqwFehvdcLpfHH4mmJWh5T3qWu1RIBV0fJmDkhrMt62r0n29badSXojkX+v2+qcESg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j22rBv6EORK6VaJaVaAku9cGgqDK9duhFngMt96lLuYqX+mm6zHE779Ljg1jGYmuP/9Df0sSKyMrwknvA0GM3MAIBlwqg8uIKCPctSGGL1/UWmf/YWF23tvoFVgJSwE94WQKlKIgvbHOcL70WOtlkikmc8/Z44hdl0gSbVubskItkykaUC5nUC4fjoQW1ABToa8qUIFi+e3oBWaaQy2WgWQB7pITYJRH7PDfUkbjv8LO6dgghk/pEJtnGmNzH2DLEU1VWLaxKSE4OzvwUDPvplgZ6zYdiyPHM1xzhf7wrbg0n/dlcDUngQ6H6IpSHTMPAPSQSbasWZgMdqNT3cpvUESMS2LmIvY+iLXHLdvEBRj2E0JxxAobEh288/M7OpAf+TEHDhDXwRP8jgRbtt4SrGeu2BQslyt8/CBrIOeNZcYIzg5dVoAMM5cJfTeFrRik
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:49.1114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe3a09a-d2ae-4185-92b1-08df0e60e8a6
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4698
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


