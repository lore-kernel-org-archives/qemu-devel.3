Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60954C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcm-0000GQ-7Q; Fri, 11 Sep 2026 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc2-00008J-10; Fri, 11 Sep 2026 01:15:46 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005iS-GA; Fri, 11 Sep 2026 01:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnHYinSUaHW/eLzW0LyTf/Nfj7gX1Q8GbZRIyJdjUKvhT5ObsjLJfBlmkX5mSqtwkqiWddtCXecBdVGgmlt1VJdUjVmJodp7pjweTjM0kk7jhLreTjqw9iD2Jf9kuGHWq7oNxqKIzYlp32743m1h20ud/nPuKFHL4dBDnKh11MBpVLa0okKVwbdmgnoTrSflswaw7w2N2NxPhvYsBRSyxhhAqtCzkCsrJlwvaJon3AwbtOGaqv4kDKgfBvLzK1TB0y5rMlze17LL4MVMXNwSgiUWV9o3SIssHnlEpcKgdvpj2o+RVBAe3Pu3npBcURcPvXRq9Y4jqz+PHjJtorHaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqn7LyYVOuvwl2brEYItfdK/gAOVjL9nDh3yEC/hUOY=;
 b=ZAiSms2DVLIZ04vI+MD+IYTjSPhMxTa1z/CTqnTS5rc9PBxdkSeaPQpyZKEaLkF1Z35MFG11x9JsnFk7Z102h+qdgQ6ofz2PGC/2xGs3PtJCspZirt4DopiXQBYWLKk3362dgNSLZaJHRe1Qz1Bi/LeoebzdpbOot+Vr2lIL0WtbBE8acYge1oRd6S8eC1zTFayF14Jk+1qgBseUWi35lAEmYcBR62uedMg/qcT6Yusy97fNXlqLifVckG8h30CnjqW4sk7BDXbbvgCJVcYsMaxqe6/wGDp2KeNnu02WxLS/lmCHgdIagUlN2urR1YHSEyMYelIv80mmfwv+NPOP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqn7LyYVOuvwl2brEYItfdK/gAOVjL9nDh3yEC/hUOY=;
 b=Q8G7JEIqznsp+hO+BLznWwhHww3NKjZjzkyUvSVs7BVycVc5cSGWnkRufEOIfhhVUTILq5TshDK/TY6uWb+dgW4ZE20yLo8LyiwlLF3GXTwZpd4RxcDMCgLW9N2/QwnYzpu1QqXr/6jHRXWqQhqloggzcjC2u6FLAayTnq2SlpaOSUDMyg7XaaqDepMcAR8pUyXfhrWtvEXy0KfAbY8fl+a2atqWgu8JJHsLeyY3OAAdyFzSzHgBT2CVYasVyREBldBbIfEaoov/xYRO4mEWMd9rOzWx+qEDiyrUa+b3ZbWg7TqfuYIX3nODynLJTg9Sed47oh11IWd+VcZjWhF3Tg==
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by BL4PR18MB6431.namprd18.prod.outlook.com (2603:10b6:208:5a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:37 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::22) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 05:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:36 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 62A2140BFE13;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 09/13] hw/arm/ax3000-soc: Revise variables accodring to
 QEMU idioms
Date: Thu, 10 Sep 2026 22:15:28 -0700
Message-Id: <20260911051532.2378501-10-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|BL4PR18MB6431:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c0f73165-738c-42fb-7c4d-08df0fc3b693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u/54CEpDj47lZxnnqlfHiRc+qXm+Km1PSrlkgTnBV2z+BqT3J2iaMvcO2Aj4nOj0YySmWYKrFOLeECO0rrCzgFkrT/NyrSEwDA7qQmxEhzUnl+07qB76BnbkuI8erF8dP8g/57WFDvIL4zOt0aiHkbiShwPjuowqmUSBwPq902FWt3I5AyYagFsKtiHWdRtRZFlKU2HneU9DtSrJcmi6FZWX57/a3rXPJt5VkveaIedobareAfDYs4nZlSfRkZQ+jlfMjXY1ZZsxj/BGAQ+NTsFoaaerwZZA8olhPTZjkbJ9u2n5KBat/hIDZPdxFGjGuS8RsSdaYfE06KN8ofulJDs5iucqjh+rO/ofDIVhrPcON5DVtRlR1NJ3BtSdyhbidLA4GOqlVqvyh6S7gP10/+JwnXVQV8dZZwwNWb0qJuDT914x0RaNzJ5aPLybTSgDDcj6QNh7cDe/rBUoHduEGADlPKFhKUZ/DrZsOVi3URNtxSQfA0Ubb6uU7zIXCSm37ESU2zjZdsYnyjJ+mRkysfdaAwlysN2BF8y5gq/8myyrh1hX8mzUUkniHlIbX7X/EAif+Fh/Gbz1dA8apmaIII/k2OfgC8ouLMeSZwltcqKVHALMJLcgqVFmXW6bUIHab69nOG4RUnTfIAOHWgpWhEh/ewWkWZKHzpEqmB1zL/StfeI7xGR11b0DN1910QgoTfyFmyDEjsg0W3LdGcP27w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nwiGE77pU0T1uCMMNoCZrENKTXBFgXZ6MKpkCzCCflJwTKlNXm72ahokUzxHwIKCn71JYcNZyKXCmxWP9E3cSREzH07f7MjeoCrfUY5ctqAfFOmhtih7Y1BV8Trvd+J8qiIU+RKWazZWB/qf2Ku3d0VgjuzVpB2xl24I3gpROflfeo0p9MUIrtJh+xoe/EqvXT7o7H54LqWBxvGlXhK9FswMxouTvZXrN70Gc7tYHkOTL44Vzf1igbpECb5BEg09pwEtOIY7iNKq23HJ+Ue6GhKcmRDVUtGCGO7P0UvSxUUIYIhdM5QxZuiMkTrw+8V9XajE6KQAu7V62lLh3lv13miUqH6x7MM577ZxWqMF5ofei+c6PCQcIpFchD/ccpfqyxHsmmguM3FivT0lcZdQW8w3ZRJFM/IxGZEO3pOtmTnOx3MpiHD4keBDkRggCjDk
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:36.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f73165-738c-42fb-7c4d-08df0fc3b693
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR18MB6431
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

1. Change the first declaration of struct to parent_obj/parent_class
2. Remove unnecessary typedef since macros add it automatically

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 include/hw/arm/ax3000-soc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 4987ee3834..e09cd56c30 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -60,8 +60,8 @@ enum Ax3000Configuration {
     AX3000_NUM_GPIOS    = 8,
 };
 
-typedef struct Ax3000SoCState {
-    SysBusDevice        parent;
+struct Ax3000SoCState {
+    SysBusDevice        parent_obj;
 
     ARMCPU              cpu[AX3000_NUM_CPUS];
     GICv3State          gic;
@@ -70,13 +70,13 @@ typedef struct Ax3000SoCState {
     CadenceUARTState    uart[AX3000_NUM_UARTS];
     CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
-} Ax3000SoCState;
+};
 
-typedef struct Ax3000SoCClass {
-    SysBusDeviceClass   parent;
+struct Ax3000SoCClass {
+    SysBusDeviceClass   parent_class;
 
     uint32_t            num_cpus;
-} Ax3000SoCClass;
+};
 
 enum Ax3000Irqs {
     AX3000_UART0_IRQ    = 112,
-- 
2.34.1


