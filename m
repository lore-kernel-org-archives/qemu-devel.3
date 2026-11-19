Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9A606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=Myzb7M/U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwLt-0003BE-Do; Thu, 19 Nov 2026 02:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLW-00030J-N0; Thu, 19 Nov 2026 02:14:16 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004JX-N2; Thu, 19 Nov 2026 02:14:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jShmyHTwq14H6ssAp673bWljeiwwLw0iOqMPGu2YWyoBL9eysKgaQXxJjXf/D7rUp7KpcPgenc75y0OoHeDaqT5pUpE6cu7gcU9ejvXQvUbNI9ejDNV7AzU5CeOK2cvGgeN1PPp00WnAkYv7o3Epv2MaSsjHBVafjU6GT8DvwKNZzjwjUJhe7QxIr86u+1xYZpnjHQDrT9+GBO6VXqj1SSotbGqKfJLomz/iwJr6pspwWQHQyb4s+Q6tE7/s3ibACE63Sg4+rb0hUmae825gDl+79Yzgli5nSUWH7ogbdFP3guInTUnJVUx0FoTw51trJPwCpoUUzELFsx2KmcV6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=p/df80K3fMPwYzVu2ADClcYBP26pH38maUTVvBSnNynYLk3vBHHLYzRJ58WDzjXMiA8XvhK0WE+Br9Qg7As/yWJjFIFH6GTPONPYvdmepZwWl90M8kqwDFIy+6ZDaxDkGApIk/UkT0GJS8b4JM0mTBE/6lmw7jYhMstud9kAK/y/qlhun0j9ErHw9It95TPd76zmREG0j5FCwpDNnfU8RHO8rfI57KYenD4jKnqdqlX44fqjytyEl0YSwAQsAAsd+mXqJCAKDEw8yinm7cYhNdWBLjNMUoRS3GwVo+mlxbHvQwKRJ4SmtIyYeMQg2RKJ2bX32QExaVdfhJ2kRhXUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=Myzb7M/UMygmI7lfu7RCAWBxCqeJhbpvC5Zzu8HWnEn/5iwudTMrZlmTEif/wJJAzYfzb41b3sJD49qgoOR7myixUcwS08otqWzCzhPO+cMvVIYyDQ4auzZQLdRqoazZGoBLXCFjYd+8xaHZvPkc2Sgga0FYGOCwDtsAcHLouAp0WTrIZKx+eIBP2/OH68DTFQJohtbfDF85hl/+yLjet6Mc0s5JBFLqB2onHWRQkxi+wOkMgEoHsIKXe5+soVSsn9f/TdUqJ/oCwCe5DKoxy78uiDaAvGI9y8GVVaV8Z+6J9np0zT/p++xE2uWxYEy8MZI+jHwlTALdIOfABMs9tQ==
Received: from CY5PR15CA0231.namprd15.prod.outlook.com (2603:10b6:930:88::16)
 by LV8PR18MB6003.namprd18.prod.outlook.com (2603:10b6:408:230::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:00 +0000
Received: from CY8PEPF0000005A.namprd21.prod.outlook.com
 (2603:10b6:930:88:cafe::7) by CY5PR15CA0231.outlook.office365.com
 (2603:10b6:930:88::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 07:14:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005A.mail.protection.outlook.com (10.167.247.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:13:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id EB7864186B58;
 Wed, 18 Nov 2026 23:13:58 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 01/13] hw/char/cadence_uart: Reduce the size of MMIO to 0x80
Date: Wed, 18 Nov 2026 23:13:41 -0800
Message-Id: <20261119071355.3520249-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005A:EE_|LV8PR18MB6003:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd7797da-04f9-4263-4037-08df460caf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|56012099006|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: pqFNlm7Knhd5r3aQrccFCXpVPR/uBV7XFBHGFc86X2Xy393kdALDsha1/cz9mflTS/+1foTa/G8Y6V4SBINTICUYH6h2Q79K+F3Se8ZVSCrjvumLyIxMTc0xILJ978KsIyYk/yQgIDeydx+XxBK4DbkS7W42WZHgg+oaOiqCESwGIwRIJiYwXQq6QSv4Tl/HqKrsoT4i73BjfC6Ej4NA1gDAH8POMLISfnIuNLT/7gydYd5kpEprHXtiGZK1R9Wj2zkcOqs7XJyvGCxoaaalB0sylOj5VB5FpfAh+NzfBLtxJo6z7IJ6QKIvsULSg4FBdZ8nimZpZPct2iiyB4idqDnj7CFFaLpT2icCD2ecNtbm6+DDxg+NqNNknOeBp9lc45xXZWFdhYbo6ky93z5qUFJ2Fk17tORM13ZF7+aN4PVblNPJ/HqaznHr7+x7NFU5hIJxrqf4BkrSjxoVfiIN1LQ1ejNpV9Jl1qhllJo4/iaItufggPiwatnJxF6+R6PNvENJEXoOq1q6grAEhmhSn39zCEcv3ZFjAgMd5P9NHJnT7MzOJWVIQSkQ78W7dT7YXVad6xI9bChd2MIWsj4N/0fC3bTHIAzvc9Li9ewmuFXS9rOEFvW20omGjcGtYeWAXJZz5b5sUgq4vDciiWY039qKFwXVTG7xlppMXNfcHQPMoCx8/QUcSN7YyXmAaQMkXTCQo2Ez+AnqhBS3UuZvEA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: poQOy1J5gRaHAgDwJ8TQhdxyTJr6xxvQxW5wgvyTeLSsyaWm3c702yxrWdvkRD7J5yA0uSyXGUyzGjUFHnBYl7nKHVuYPHQXAJPnnz04cbj0rKy5YiINUQ74JEVlvrGKFezkAyT+19Z7WuXFsYfFDn3H0b+AJ2/gGRtqVC8CFgiIVAMMzHUyezQHZIFtGoWjyOz/gTmt96UOT/XOaScrG5AV3/wq7NI7uHJkabHBAM67Cf2gk1kaalaEJ34tNbzCkgwQj6L66xuycVwH+ibQAHpTnxjKMtCnPW0AguL5unevCJXdHWraf09Uexc280bcZUe8W0N75yS2xNc5oDK9rIvVMeb1l8v3sHFpunnKfJQWkHRKLjSi2WdQCAkaYO3MVn68ORqlMbNtnOeMzKZETyWrw0He3h/zAvXxtoICZF7KVtdFmRLKQSqRABH5cx7d
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:13:59.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7797da-04f9-4263-4037-08df460caf1a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6003
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We don't need to reserve 4 KiB for MMIO since the last register implemented
is R_TTRIG at address 0x44

This patch reduces the size of MMIO to 0x80 from 0x1000

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/char/cadence_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eff6a3c4d1..8e23a378c4 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -559,7 +559,7 @@ static void cadence_uart_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CadenceUARTState *s = CADENCE_UART(obj);
 
-    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x1000);
+    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x80);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
 
-- 
2.34.1


