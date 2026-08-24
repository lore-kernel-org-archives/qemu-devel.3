Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91289C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0K-0006bQ-Dc; Sun, 23 Aug 2026 23:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0I-0006aV-Qj
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0G-0003zk-EL
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiF3V1Co2HLxaLM8Wt9NsgdL5fL/4KM96zbBc+1aIkwfX7YjnVzJBc8p4EvHHZsMpAJwEESzWHu04uej2BvI4EcL5VE0MvATo01bpqRVU9w3Ksa90B6mcjItWom4doI/jFr07gj9r9/c/54kaBwVGUPatCZPsxkLPwzulC55xAm6+FXVpBdjYrB6ksyKpYkxdpDDjPqcubCVPTbSj7cxKUpsPEdgmwfKoLaQqhIvcbNcqWBhYuaDU7GfuYIVSI3h0k8l016e5lwha1RZuFm8nf9W4ElYegBEXLStfqvxw3o5xOFZDFeDci0H19oI1mV9hWrt6bdHk75Z7I7G0xmWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk9CuFzmBIdy4+owCGsx9o+MhUZrpiRj3FTfRhw8kwI=;
 b=vDfPJ9/ASWevRWheeBzNbG+gifglbxQeD0zMZf2yycqGP2xLEZ4ll8+SQ4ih0X84iWLXLZDtjNi8g/dP2RquzSP1uHPCK4KYDX1ehvfCOKOhRfIbemOas6713KTGPPnuaQKJd6N0f6xAfgRfUP7H63xzZE2HHIevEBg/GTARkLRSIznVVGciltXXuYQB0kxRhetjaovetl54KXqJSXg8EJtGwY65MppoDJNEU3vXKmrpxIjLAMyOOEQ/31KIXHvvn+WapHAhVjFXHNjx029IYqkkK7pWgzpPKBwWynLr5wMd/85X2lK3J49owjTFE1j4LC5WlwpOcYEQJ+0NQdpxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk9CuFzmBIdy4+owCGsx9o+MhUZrpiRj3FTfRhw8kwI=;
 b=F/RLAZ7u4XMDzD0xJixEIAGXTNbQOq2zPr0gqhUwOBWqgfhdotM+Z5rkEuszndqpQ3DI0VEdSxEuaobIYcifgpYA9yigIgKfyBvmyObn3R/59DZn7cU7pG77nldLd1jW9vpW9YPLoppGf99fmsA2TggsaRLij03xxfSDm7suLr5vVhlpdxUk/VY1NesWYKVn+RKc7DwYCHScHLI5Vp93/ARWt1su35ul+Y/CYShYZreVz2NSQwJFgsU8+n0kqoLbpp3nNhhych3XrtYbSJcTUnEicO/KO+xx4NO9pdWWHAeiFK6rJWRA7k5U+gyueGXo9ET9/VMmqDebmiN+XOtBog==
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by LV8PR18MB6122.namprd18.prod.outlook.com (2603:10b6:408:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:35 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::13) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 03:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 03:05:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id EA0C640BFE07;
 Sun, 23 Aug 2026 20:05:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 4/6] hw/arm/ax3000: Specify SoC name in header and variable
Date: Sun, 23 Aug 2026 20:05:03 -0700
Message-Id: <20260824030505.1969726-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824030505.1969726-1-kchiu@axiado.com>
References: <20260824030505.1969726-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|LV8PR18MB6122:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 99499afc-9cca-4731-c3b1-08df018c911c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KIg7BSdWMgbT+QN2UvnFl/4uJTjnqK+Wn6v7lEL+JLBiTB8suVG46awLN9eCmta+wLTY2elMfAcbnVlBKVBKBPy7l8LuF20CzZlT85qrXoTvs+hyVylA58o88Yf10IiaTBoDDnXgBhDS+twjZ7e8ZLyzGOJOOGl3d6O4u7Oc/3zGU71rVkMPopJcTuyhXGWqYVUnfjq663qC73JyWw79HJHED6R8f/YWGgVLliKINOyJGcztxRo2x54ZU2yGs7pIouMZm70XgD9m09cMBeAz3lLtkM54zcwr0WrmiMbHz+iWv4zZ9LKvqFEZ0J0kRGkgsLsL3qKqBiZ7GKI6ViElZmej0U0DeygkAIem0/g2W/fMmXdqvI35O8lwBZqoOu2xdWW5Omk1m2s504p3x7G/kuKFzvYu7qoHsKWnMqxExTGRjbM946utng21Lhm4N4U3d3QFGpZlA7OyvJd8ZNcIRSrG+B3sb3D5i5v0OFOM9bc7am6crcxwXbH+PukCGIeIf9n9905WhwPlA43WlirfZmZ9MN3xqVSSlBbPsxtofeh/T5jzR7yxex1oVI6WReLZkmCRfnU47CZ3d1C4bGCQh4FpLtsRWLcSAsB7L8EmBXHDQMkJQKgv9XXWuy/vhVR2jm4V6qRPsyT75UK82hJ7Nwyjs0gtY+W5kaYcPG1bMHzzy6RkAJzfJbstpHafLJ6V
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4lp2Sh6p2phiUlY6KRrUQxBj/ngyS6o4Y9PLwKxxLk4lFY2yPU8KAfIw95rk7GkxgGh0YSjwEmpzwgrxgxCjDi0FQ4YCVLP/IJWyOEtIYNEwmTQrXZ6tNfQQWmzZTKbmQbpL1rPFHC0CGfqgX9Qb93Op+/Ubh0zHmPAN8e/WRVd/4DXeMRsw8jTSbWd/Iknb546qGmgN9u/IbE1OkdCGy4lSspHtAifUQ9k40jqVxYRHSwjobekJMl6rr2KLVKsiawGWDWgZs45a2L7IDi8nRRY1/2b4L1qrdIXjJ0Aapi7fmgtDJa0hmlZy7JVp1AqEJlRq5cdNSZBFEgo430kXjTpvLWpkAQg+KqhU5u2MIrLnFo4zg4Rce9puUKXdKrbLIohaPDUUdzkMLhYLQWtV/Wbe7U8bV7+erln2mtHyfLwIkhFuj3gwBM7rqxBRdvcU
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:35.1048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99499afc-9cca-4731-c3b1-08df018c911c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6122
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=kchiu@axiado.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
index b5088b17f5..e0d268da65 100644
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


