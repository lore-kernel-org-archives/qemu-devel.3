Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC42C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4td4-0000a7-SB; Fri, 11 Sep 2026 01:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc3-000092-5V; Fri, 11 Sep 2026 01:15:48 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005jC-Ii; Fri, 11 Sep 2026 01:15:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX45GzGZ8UDi48vSwrcc8htM5GpyCh0meAnEicE0OOUHdOtijPz+RmQyTJKFGy6aM39V7hzUfihdArJ8/s18+80XR32iq+AsFLXGM8M8C7ex5t9DD6amfxm1QOBKftRMtLWPYWPFL8i39n4Ik2RYbKxN+mIPyoigW0LQ5ZL8NuxXe303OM9E2+OkSxaMONzaZXPwe2V7W4XiqCCTMZX9i95I5UDd4OU7qftS3WVj9vfDiPd8e6W18TnD6Z00zvTs9KGejm34WYlWpLH9PjHeZCCwdoevm2jJn/9u4FAp7HVx7CRCRKD7uimX+5VHtBQRTYVcIHlk2ElSi8VvDo21sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=COLu3Ebr/iAhm30exvuqjfCftntbCYL/r6rbqYFRJJG3KrsmJjPoBx1cZBuOoE/CAFgimv6zDwrGgtB7kx/uijzcneUFXUIv41EyQVxDiAXVxhiSsVScf45n6KLGe4xgLvELCW8K60izd3kF9vOxbgC4GOz3I7O5AifUb1QDQpdcyXshldwghEIgE9X9RMoWPlJH508G4COR2G6L6bzTDBJ+rH39WJ6r5UsFoU5ftbAeYWPAJeFH2tDCS4GPPEBD1sYESDT0UCkMQLNCsaq31fBg3meSEj7em89NbdwpPPbU/AYnv+X4fUBAw+gOkXGMtyN+KK4qNpZJO1sEfdEHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=W5/DiEe2ZFE2Y7pALZT6se7S1lBplM8wvynOysxjhaY3HRZuQM21Fp6U9AYh/XVe+zemvGK5GTfc7qcfuwGuVmT4LmheKVC3M4M75hAQxQY/bPpDr63CqrBh+VaMVIIYY7KTRMnLvnYIyHXo3+6XjPYN9DBgwTsVzPL1PKfFStYyIbTq4GrnybYAeau6QDU8oBQ595Qvy2PeJrGeG8OKpwT4/36ntFMcvEFX+ixsWtpfXt599owzjCcIrGQKXdPS1HI9I2/2gI+thlSy3KscUh4tg1tzGRf+iFb34LtGQh00yN5zYnU6D2XOs0FICmsukSSMOnGtMINXsd1nuKTqDw==
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by BN9PR18MB4155.namprd18.prod.outlook.com (2603:10b6:408:134::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:36 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a5) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D787040BFE0D;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 05/13] hw/arm/ax3000: Specify SoC name in header and
 variable
Date: Thu, 10 Sep 2026 22:15:24 -0700
Message-Id: <20260911051532.2378501-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|BN9PR18MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8e68dc-2de5-4b6e-c181-08df0fc3b649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +2Kea7bVN4eqkDb5IhvNJiLAQ9H8cJgSJAzRjRGgN8I1RSFt23AFKqk3fYwEfE4mWS0cM+H2LpYdd2UnkA5qRiCyy0SXockeDY4q70lQmr0w2B6u/8ELU6RN5bnbgjZPH2j2ACm47Mz7qILZpGxzo73V+maiv8R3gBUmS9Zin/bkKZ39z/964F8jc5sedSNkMyzHNqHywqB+akYsxTMoUWe5UO7KvqFl/KmvU7JxGdasIZvOCrwIZJO6ygo7bFvcbUwIL4iiwA6/7FcxXlWa6mqCTCs49h6OfAIEoO1kFU/gRbCKoATPUZqc3Z93y7B3iQBUlA/aQjCXdkjvHIgUSfbDPyk/iJ290MjEj1qxp5iGyzDHyQLpIATqouDFGA5ew9oWusihdRpJGOKYwsquyNkewlEJMWE6llOZhEIJFIA4UYJ0i4SX4vQwCPrtxVI9DOCvl+E/vrCWVAM+HTAsDuxJqWnCgpjq2aryJS1nFOp8WNhmrDa4abMLOMuxQEdnSFWjrNFsGslvUgzLfShx9Ds5Go4DPUypDV9yB7CHYp7xnO+UpPBfF2AFhTmU+OB273NztIKQGy3XdYFxwt+DGepj3nJNU4FMxPw8T2iflgjligNFj2EMszMbJbtNWhfaYqJYE2CCbrCqAfOaVNNNS2O8RJXXir7vwQX7iTlZdndTNIsKm+XcWYZzBgEbsS9972yFMasentPeFNiZb4BZhg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kyv1Ypa7+3r41CtCOHGqe/m4mhpQs+M8G4Wx8m8zfR9sYH7Wzrnt6ZImCzbDCm3I80C66/4Zh8bUIWTYCVw1X9CXgG8dOIjyHGN2cmSoEM5aBJ6rEeCYKG+mIQegLNxlxbnm4JNhuALG6To9t8NnTYCYiFarV5OzsKW8KTdrkxonxCqtDC5KhtbDrY5qyI3HAgduuHuDm2OVal/xu6YhEMSMgbuDLc6QtjRjDTuiKbncJ5+u15ujaW9PR9H3gGTSrqxgtdlgQSfdMpGmBZ81ukSAtEERzTLxpaN+MA7IgKCfQS/dVWVHhLpSJRnVfBnZB8y3KlgHl42Me/FLC/M1LeYCwSYmxKrfwGrQ0sLwD3Po2xkHW51zp3SnIp34VqGDynqgXUIdDEXlh/W2sauj2RI0MFNWidtsRS+NU9RcuAbKMdTBYEJLTCclDdee6wJH
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:36.0345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8e68dc-2de5-4b6e-c181-08df0fc3b649
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4155
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/ax3000-boards.c | 2 +-
 hw/arm/ax3000-evk.c    | 2 +-
 hw/arm/ax3000-soc.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index b4e7ec6f1c..b3ee6c4a69 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -1,5 +1,5 @@
 /*
- * Axiado Boards
+ * Axiado Ax3000 Boards
  *
  * Author: Kuan-Jui Chiu <kchiu@axiado.com>
  *
diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
index f491de7521..adcad2f340 100644
--- a/hw/arm/ax3000-evk.c
+++ b/hw/arm/ax3000-evk.c
@@ -1,5 +1,5 @@
 /*
- * Axiado Evaluation Kit Emulation
+ * Axiado Ax3000 Evaluation Kit Emulation
  *
  * Author: Kuan-Jui Chiu <kchiu@axiado.com>
  *
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 7b96466860..37c938d942 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -230,7 +230,7 @@ static void ax3000_class_init(ObjectClass *oc, const void *data)
     sc->num_cpus = AX3000_NUM_CPUS;
 }
 
-static const TypeInfo axiado_soc_types[] = {
+static const TypeInfo ax3000_soc_types[] = {
     {
         .name           = TYPE_AX3000_SOC,
         .parent         = TYPE_SYS_BUS_DEVICE,
@@ -241,4 +241,4 @@ static const TypeInfo axiado_soc_types[] = {
     }
 };
 
-DEFINE_TYPES(axiado_soc_types)
+DEFINE_TYPES(ax3000_soc_types)
-- 
2.34.1


