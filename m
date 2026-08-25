Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D232C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygeM-00050u-BK; Mon, 24 Aug 2026 22:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeJ-0004xB-1w; Mon, 24 Aug 2026 22:12:27 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeH-0005qy-Hi; Mon, 24 Aug 2026 22:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBvFRktn84ERqPR06P8+BJBXPwdg3cF6HSY7ziFUVfWUnB34LXnKOss6rQMJnNPKfcMdIClw0hVYt5RvHk69z1DaLZn/0W6Ng2gUE/SJjxAvVS3L1dfm4hq8MUOKgJgsVYZ1sRbDVc28nCXjhpxQ3c8r2SS/0vh468f6A+Bq844H/NPFBTlnRTvwybDJGtF4xs1ABBNwfqWhFtvjFd/mm7Q4XLWG+E+x3Ns08cqBzrUBJrMBmKL1VziZVbiQEDO5b0vC4Z7BMY0cfr+SYvjrAuIc+t75cFwJ0Lh5Q9iYNMtFoNiYIWHaDltBxVtsMs3wRjtOsv4JfJYAtxpXDu9Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7I2FiWY3weEGOLrF4e7gtNQ2u0ENUJfZmmgc/mle48=;
 b=oLmjg1kDb8aLegi5aJtXpCjKwKcoBeAsHt7nypEM+LkQrkeg1q1fpfLa6MLfblr0urim9W36VRw8qbhvgacVoh9AdcGAIee4jEm2zgE5L19jiNG0Thbrk84y80EjgNq813iaVsoxV/DfNZw1vWuEmdJAWzHxKUQ0Ht9SnH88w9EYiZBX7iWjbn1DtWgTeKOtxsE1T/Ov9Q9o+ElWiIUuNLboelmhTYPjy9SohJMcA2Xz5ZQx/sdrzz0HLWI8snAqll2IWaRpQlEmBwcZdMKAmgVlujP8rRKDy0r+MqBOrx+A3RQu0go8+aqR64+DJ4v3IMZ1/lnMjGPjH76QGHElkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7I2FiWY3weEGOLrF4e7gtNQ2u0ENUJfZmmgc/mle48=;
 b=uuErsiO+WUrTXx83nujPfHWMsXny5XiSmBcM155rrjcKrlhmiQypTwnfkMMlRP+WoqM5KPNx1d+ZdK+VhGNMWWSQF6ppAssBOljnI5Q0N9ovT5TBaiSOluk1KW0Q/kRvtf/wE6PiSQ1dxLC7PeXTPS5h+e5SZV2+lIEZNlTsOYXtU909ogmTT8w9kb6+jr4TsAN5mdfGhQKx42TLTYnyPKO4hwtzixL10k9lMD2AkUmjPPLv4LpR0UaOKvPkUiwnh0uFXktudzsk4PKGSBk7UteujZGvdV8Gs65qiOpxeoYTTMN+zpuZ9eoFZv5BlxeS8deTY2gJpnvAft8R8HDFAQ==
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by DM3PPF2ECDCC238.namprd18.prod.outlook.com (2603:10b6:f:fc00::699)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:12:17 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::81) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 02:12:17 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D441B40BFE05;
 Mon, 24 Aug 2026 19:12:16 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 163wangjack@gmail.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 3/5] hw/arm/ax3000: Specify SoC name in header and variable
Date: Mon, 24 Aug 2026 19:11:53 -0700
Message-Id: <20260825021155.2475879-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825021155.2475879-1-kchiu@axiado.com>
References: <20260825021155.2475879-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM3PPF2ECDCC238:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df122461-8b5b-4425-7e5e-08df024e49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FTPoxLePTzhl8j1QEdPqw0osaA/coBIFduYe7DKUbHmhAdfXHaMCqpwwToKC2/RuAEum3JSJtdY4Q4WLzCgV+CsrmL3GOynvnUu0poyFB9Y4eYVHaH7zp2fIl/R0OLMf3F7oblVdJmlXDuKqeLefT1ig6nOWnbCpwyrLUjpJYVuzxUZuckjFbN3jz74HbEBBxoaTGKJuNvtEYQ34I4wv/telqVYJYXe3fMKi5GrYBkDtN0Nz+jWLz0QyI/XY3iz1zXzctSc+76Yu42+s8lVIEpHbqjuvQ4hVEVFDGxoUT0M2ealvAnIE67O77siUCdC6O5Kg2mXcaCKmTUWrxAqk8mL2rnX6uV1Y1BoPIFsbGUpJ5+ewwwOsF3neOey3CBzns8P5FBpv5/1svx6Om+btndjU0oKXIVvzBXatKG+ReHe3+qwapcuihtfEDm4nUEAvMlcGHJCYMiMGW5LgjxzLufQJxtrsp2cNSrS+63q9DrB58C6QPJWIGUih5VkIcfrAV7fLMFtVx8Yjf79mBsoCOp31VK628Em07oV5lj61kFxlPRHv2W9elhuWhqWoNNQwnVtMqhmejfEGjbWWObNPmSh3gCqNUauoovpqeyKc5nCe/yV5veCZHVdlf07QpEf/a3jmlzTXzK0MaiDOXslq7wwT5ZYRDVwM3hbWOYsXTQyOxtX1DHxBoGsTppA/Y/8h
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DYAiZTQlmcLKOB36RaB3mrsqbnM1TY1Hd/jMNRacnDwaNhOeLVRwVLL3wZKX/jHUi+72INZ7mhiCJ09z49Z5Ow99i8fft1rj4jOIAgryj/Bo6mxJws0i3bYYdLNHt9Of000gQ4cWMkhnY9H8DWNVJ2ggZYm77ZGFQXYBVoZtbVRu0DKMDsJT3JMpylA3hW/xoVEJZGnsAfKrnN40AWDxm8WXCsGHknpNQgZ16l+bSefVafgipB9WqEFIliDORb7q+A3Q8DO4OO+gdHM7uQJceuDLPUXz6eJrz8L9ZrLQXTfHopUOV5aK4k5gBdz0oA6wS6NSXz/mUti6jZ53TQ8w0K9oo0FXAY+5mdVbGGjWcn8jqj0tl+HR9Ywb3754IzzRLATTZffkcDrf9oOV/z252ZkcCyZ2DVedlsEZE/WjdqD48ZSES5z42J1EzpPVMbSK
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:12:17.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df122461-8b5b-4425-7e5e-08df024e49ad
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2ECDCC238
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
 hw/arm/ax3000-boards.c | 2 +-
 hw/arm/ax3000-evk.c    | 2 +-
 hw/arm/ax3000-soc.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 1b645b7f43..a499890317 100644
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
index ebe174fb97..a2e0b19732 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -229,7 +229,7 @@ static void ax3000_class_init(ObjectClass *oc, const void *data)
     sc->num_cpus = AX3000_NUM_CPUS;
 }
 
-static const TypeInfo axiado_soc_types[] = {
+static const TypeInfo ax3000_soc_types[] = {
     {
         .name           = TYPE_AX3000_SOC,
         .parent         = TYPE_SYS_BUS_DEVICE,
@@ -240,4 +240,4 @@ static const TypeInfo axiado_soc_types[] = {
     }
 };
 
-DEFINE_TYPES(axiado_soc_types)
+DEFINE_TYPES(ax3000_soc_types)
-- 
2.34.1


