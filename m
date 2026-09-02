Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB50CC624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i6g-0000Se-TX; Wed, 02 Sep 2026 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6f-0000SP-Su; Wed, 02 Sep 2026 06:22:13 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6e-0006dA-5L; Wed, 02 Sep 2026 06:22:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLY3bASzg7NGs68GpVqhr7+8Qn7RFumEulLAc/XiO+vxGuQTEDRQLfyd+PGEyjOPpg5y4qxZYMrIVCO2o/arRmVJJUnwupVykw6pQtavuMW/FEUQ4tMGAtUQVYf5xGXdkCwSW/X6stwhNwNLypX0tZiFArW4c9phppI++VjFSKbFc6SRI9iNdeq/5G36Rzmi3P56SK6ioJGD2OwHbX1E/NDRYhsUNGL9+9YWBBvvT7os8DAyX23KPWYkJK2LD1unzRUJknr9PMkZh3sZ6l2VMu0u/XHIqG6pcOpPwnoqz0wSTrAWueYn7/9T5IqHbkNdudYDpW9VkAh+vvUTWZnbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=tFyQnIvCafUWaeui0V7g3YeZYxv6YC635RIsZKsRKJUxGRfasZFdOlEu60+jYXoNSQvYXie/KeIt1MqCTt6aFcgqnAZ0shWLfZAYncNJmXxuqvOMEgdPQwRHlCCtuFXni7H+Int6aBwPrcrRj8Rf20A9DQR3rhYnVS96kdJZFo3DJNf4MQLLG3PdU5HARQsbUTkrtp8fbvupASu6mv+V7YCqaPuyoXMcYOAa4yb4gs0p3Ue3Lr7jk7iQZetxZSGMkpb4vRX6P3ZMBr+394xs2KpErY8WuvoY2teEF2rv+kTb9D/9JwRzHpFyk4YCtpIegT1DLusZsYdnKUTG7VgQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=Qxf/pnG4emmRyGh925UDl8Hf/xzbSsYRJt4aeG/fcXM9DLoTZViCTd80FwA0Ng5AUIMU47lnUJF3hUpfsLp25hvIhYWGbjIbPOZ9jmzAzgIqLFCDIQvPr4pv7Uyh+ZFP1WQ8DxDPJeRWdQXHj0x2VoGXV7qsHx9YE3bOwTErFZGUo4cz0DImpJZzxs8spEIxEqcJ7SVRP4bvQ0izDQNq5U382Z5XwshjSMuyXdjZOC/7cx9umlpefUMEMN2n7TIKl7k51ki9y9FGbF03zoPGPQT8pnJKzFKDcLieNWdHgKfgW0pckPejvaaNGcoJjUdhRl8ZnROd5fH9hwpk+iJzNw==
Received: from PH8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:2cf::21)
 by SAWPR18MB988743.namprd18.prod.outlook.com (2603:10b6:806:55d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:06 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::e) by PH8PR07CA0026.outlook.office365.com
 (2603:10b6:510:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:22:06 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 94F9E4186B53;
 Wed,  2 Sep 2026 03:22:05 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 01/13] hw/char/cadence_uart: Reduce the size of MMIO to 0x80
Date: Wed,  2 Sep 2026 03:22:03 -0700
Message-Id: <20260902102203.3039205-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SAWPR18MB988743:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40c8060e-ffdd-4cff-e3a7-08df08dc09e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: MvvsMBZDvGrc7NGWJRsOAv7c43joo4QsMXr0TejmMtORzOO+4fQcZ3S+Whwo/1get9DyrVOAhH8vyjcu9u/L8686CTBjHlwWIrnWS0wlFMZJP4s+8dM95Fg8lsqEBOcFq0/RFsoiAWLbYkNMVpKjNxwbYLw4h/qSHa1AbljNob1GeSXpfcBEKkNtYzMqLr/1Y4ACD/c6qlb4FNwX6WN1+1mfHHMbb90vW/KSUU6LK+X53CxmALbH8fiU2W9ZBOEAjMXjVx7+y14uqktVWQCRa2K6RIW7jr7Vx0Fc/zw1DNJynYPun7hN2vvQCMDrbRPFcm5I29jx9l39Hb2qeLlv4oqCoig2CX7Hl8liPBNBEb0ZpWIZE/m2uGrlBeXZTMHZ1gxPNGwxp+9Jq0nyOusB5gpXpsHCrAMHJMOEBWbAQNysnc9p7dahsXA+N7F+vF5k1GWATp1XyOjKucnSA80s4MyHQ5N7BwD5exlY+hScgJlfmB+ajMSJ+wcsrUTlXEn9lNY+a/AgDnvLBMSchQHjVn/HDPHlfpqk+yWpKEtJKmuNIvM8yOCnOEHyWKx1xWL8/TqNJrfvWo8z8WdaTr9uekk6u3tKqVX4KA9pRD6sJSwmCnNrw9xgH33BTgHNPHtJicszTKi8M11NIuBf6rCjwkFbxF9gnxt4uPkHlSe9v66LARhNE3dt/G7LgyY4sBDJm2HWzu0TFMLm+ZRShadX6g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I4RMizk/lkHKdNCHgB6q8FP9JX1vEJuxaD8mqCo/LZbq/siPH23J539PyTTfA9Afi7IZtg30CSM0V40PFo/fEliMWd93b/Th4HcdtxlQx8+93mrwgOnr7hDUxde98DG4qGm3lWpx/P3362gPy89pscyict4XyUbvqWrCe/nAIx3VVqxwGHSPWVTrQsPdFw/o3U7DcIZ/UCb0qQyrkbrKpzVZ1ge0anXhSFJe1Z0e+E9pvCkdO/YSSUTkQzXoACumdtrNFdcH8h6iHue5w7M/UVWJOcrKxDcsyh2683NxLZfyRnHgwVcykv1K2k4ED4AMkEqMrhg5/gnBMZvk8CCoTaimo6qqXUgRMvgq/rZFBcSo5tdIWrHw0lEripBtY7vjUvmpWoZ0/i3wGFXuc3OlAEPWuuo7uoyXsWGwdo59KGkI72uNojgOEB9lAXre6VEZ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:06.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c8060e-ffdd-4cff-e3a7-08df08dc09e9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR18MB988743
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


