Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F28FC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx04B-000666-LM; Thu, 20 Aug 2026 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx04A-00065b-1b
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:10 -0400
Received: from mail-eastusazon11022106.outbound.protection.outlook.com
 ([52.101.53.106] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx048-0003lx-Em
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRnAEO0gufVukZnbgsekeRqagssn+omxBD7OjRHvd/Xfgb1Eeyu2uOfTYULa7hvs7Ze7getGl4zpMcfAd+eIM97i9qlxmLr9LLVljhFTIiaSPPaHznD55Mi9VyoQGM7xRP3Ey0yYh0Vk7+g7n9Ph2CouHzLE9Nc8IGm56wWK8SEX/4fexYF2ihqAyFZHbHf2vWdvDoBEORd8Z4C1nVBBz+1s4g7XVCLSc21VIoo+LCgla4377oW8KEQJcbP3H8xtUduXdABrYDBEaOC/r2vxgjkbFsqWk4q6wPFDl1plrGIVaU+EZe/gvDFb3gnlto2ceJ0M/mluq3IBrq7ZJo62gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=q1uh7Cqtdck2539dbyfMMR+JbdGPsHctA8gS2ip2W8gKcfNtAc7ZOR6ri/apg+l8j20mJ+M5CdDyW6osfqiEmvIl4OquTO9VpMIlFtJmN76XGTnugGdiiUlngR+OKG/wnhmqwcLecu4XGD4S80LUZFYd6n7hedYPQ06BRbBuE3JCAD/6bzqB8eOye0xMGJj9UwRRBi+LXQMjJAg7mBkP7rzjS2W89QSQRo9FL8fdYeovyK2/yTehYzuJOr4XRI0I5+9gh7btiHhjJwEQk9aXZgCC9nyZL7alAOzmnZRych5HQHIViVCfBVdpEjjjyl2HKzCaR7NBzzM2Q2veCC3Gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=ULHxshRlcPBGAiQGN8sbrQIhb6wuIP2KlBIDw5OnDKMYPngYHWeoxNIRhyuCU6FH9MWAGvk1dQuXyiy6g31Dkc8YGdSOVhHqJLa/Bofg/aaBb1kw0XoBWtrEB5X3a/MYSqrjzMKRurbixeuCLqcjnPgptlhWEwhc+tSEYVRWx3+zv26r0ugbXdUBiPS6lmpIpL6CLjHRriIYxwwxeIPrfCLTBb3UjsrHjraKOkBGDZdXcM7M6H8FOtoj22o1BXcCEbLR6xVdlXhYvglK93wxGzNuCE4kSpIxg7ZwpbXR+j5tKGWd1BlNNnPKLloApYI0rFl56BsGfbewUf0NWSfMsA==
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by DS1PR18MB6170.namprd18.prod.outlook.com (2603:10b6:8:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:27:01 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4e) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id CE84140BFE04;
 Thu, 20 Aug 2026 03:27:00 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 2/5] hw/arm: Rename ax3000-boards as axiado-boards
Date: Thu, 20 Aug 2026 03:21:29 -0700
Message-Id: <20260820102132.361642-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820102132.361642-1-kchiu@axiado.com>
References: <20260820102132.361642-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DS1PR18MB6170:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: baa338b3-f7d0-4a8c-09e9-08defea5926f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sLAdawoM341W2nRfy4PuXAlhUZhUQzsjE9sS7k4uvLm4z5Qnl6jbY21piVr6dBqMR+FvV1L5CO42Tfc4KGOl7c64FBDoWLIjiTB1nfy5pWy/xUgkjF3T0i55LfRHF4fchiQJ4mcXRNQrk8DG8Cd2XgJIjjhhqbmiXinAFwgnK97xYHn+WJofFDE6ylCGKRsh+lzy/GVeht78Xy3/Fr1mOFZynWGe8pQl3GFckpY9EmZ7ukBEx93Mv2vW44Q7HZE0qSCfz1Dw/641KfwS9VlKK0twJXcwZrTottzsI0608EAFxCCkwKMO/dZh1NcIn8E1B0TgQSH6d9obtsHWHWastwNpTxkWli58LSsWIlXCdxj7MYdZKwIxv8X7a0O485o0g70Q5pzE3Pl2E94k2maZPlCHdj9C27qMdZzCcU7g2TFcsmOyWJ9yPs9/w8AgfiySTlW5AUZ15g5Z6NmNqKPbAr+d+k3aVfbmsqYfi7gqSJhOYyFVcKSHxCTMHnc9pxl5Kkzuo+ReH6a3cpNOZW6/iAhteVxDOp9qmUKWTDuCImEOwJ/LRenlm3k5T7v10BWC++/iG8bHPLur974mn2aFsta4+FbOrvFxQjJa7Wf/Swgb/BuJIbG24upWHuu8Iux5FbFTLblEN1P/RCQh44DyeCuV6S02p/vJKoK9Hy96eor7YHwmvY2ldSRhfwYlLRME1iTydpy+TcS2UMQh10CG+A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PVtLCjxINQ4cAcsC1OYtNTN0oT/j8boO4bsc7PCkYJ+6k80qtfiddmOO1uXWadhj3DTKBigpxTovkXbeQeWPuXdeyuCVgwyhAueRsQS1tOXE8zevd9rt/rFb/IjQ/6CziHrOcgBM+BCdXDX09Q+f9fhauQrjWGt8hAySHygwPkKQiol4awUd/iNWiUhz4R3zSSK0ZkoIJWKwsahofikaYe+0MUWAn5I2XkAPUywJEzzfFOROSZgPWBDCrgkjR69ETT9OM2Me/T/j2GQr129peM6XxOFGsFTF1yIEhMfSUl51JzLhhunuSciYcLRjCP9LY/Y8DVxXS5p6G9MnYoCLTETGBMSDu84F/MW5JChv5vQrGVIUtjfeOPHDw44rLNHCm7thwORX7la2bexlggxo7HeBxcTnjPi6wz9RaUGakmd+KWpKAIwXkpv3Tb8mUZSn
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:01.2552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa338b3-f7d0-4a8c-09e9-08defea5926f
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6170
Received-SPF: pass client-ip=52.101.53.106; envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


