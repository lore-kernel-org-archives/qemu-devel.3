Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4C4C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcy-0000Q4-Fu; Fri, 11 Sep 2026 01:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc4-000098-Gi; Fri, 11 Sep 2026 01:15:48 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc1-0005kN-Uk; Fri, 11 Sep 2026 01:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aha9ZZ9ByEuGlrU8LhNTccUzmdLEUXrLE9JHrdbufIIGW0/wPLgG2ng48tXd/Hk/VfMEZ5tiPE9aWSZcJ6o6q9Y/H7PY2DvSRHv0OXmeO3LzJDkF1hLOf3ju2LDzJ4BjHrEsZnUGijJs3YQhtJWq+RGXWWGaHAgLlaA+eh+50jCYDxXMo7TMFA8ZJdFBZDX+l3TSmU+3BstnuGLmhRxc9zCA9B5NVYULihEmm22fW1uu6ihDg77uUf6os2x0sae6uaOoAi+LCmpw0q2Z6BJeDcWOtdtmN23rmAvETKGLIDDMnfXMkaNujIIX+GzdlLe7vIkkk3JmwItm1WQDQcZSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=TnMcwVb+aBOpdLz7smY833POExB/89N4DA5lGZ5+/zvHBbDYCLe2DZk23tajyD/9IlmCSh0UomUj+HYVa5Spc/qprtllki31PGXh8Ji1G4V5CzPzS85t82CC5drjcXv2v6zLcglyFYd8bP3N6ZuNuOmQl2oTZaDQJmcNq/8r1Ktynieb0GSJLPOWCqxYxEP9LcYVjdlbSIOTMyYuuehc5eaLaB67wMdqsQdoAv7IF/X/2sk02tnXMjli5MNd9Mq0OCbCzRQnkoO1pAoAiJ/CEp5o9BtYYJI54vTA5qE2KNeYmhxAaWv6X4GEB+dU4k7ORCqSBG8UbF558KG0ry2O3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwn00Yi6NUIqJXdclfvY0V/LM+QNvMVYR8FvfgJbb7A=;
 b=iLinSvnk9+m/5d8TntyoBgz2uWhs+o4HKwVGcS8CQivyr/5k5Ulp/EI5GJ3bM2qPDpCoGnHabHTaaOrxgFEKgSTP2HauUeuv28F24Tfd3LvI1zjTyPL4hqfUkzuyZ0wLH5HeGOY0wQd2PJmnGwkKeGYrFfCl9AXx22xswlbQqwAelq53jp8XlsO3yTgy9heAAbTizTjLS8NxNGPnNwS6TteuDDtYHY1gEAFTkGa9AgTcjw7rxisaU1YzzGG39DnDTt5xXcp0qykpzZCgTksrvDm50yRHu05mvmn+d0J0sUtGt1R9EuCwad96U4k7cvVgCZMvHfeHYyMlaZetoH4D1w==
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by LV1PR18MB988753.namprd18.prod.outlook.com (2603:10b6:408:3f6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:35 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::8f) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 53B1C4186B53;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 01/13] hw/char/cadence_uart: Reduce the size of MMIO to 0x80
Date: Thu, 10 Sep 2026 22:15:20 -0700
Message-Id: <20260911051532.2378501-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|LV1PR18MB988753:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 067f6af3-a2c2-4133-ebbc-08df0fc3b5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 3kfeyoS9RqgLu6zFUibUWoD3CA3/9mj7pYCMZ3Dcwjgnv74qA4tpUbElIBtkSPJZMIwjHWFMCRtGocND2k9Q/Sr94qm4MtpKdkod6QuG7pRj1Ekm4SDzHjGbu7cdQv//t0efPmHz5tcIOVjwUFW0tS8cScJf2LaDjvJj9Mn46kXDknfvAYSAev4auBLioBLlv97Y96LZbBTsE4kM0j3bqsbaXh6ujY0cRkkkEjjbL5o76PwNktuiJ7pgJfd/xnYQT0byVa6xsoam1VGH2JQblrXSF1QQhFtJ/3kA86ZtI1JZi+CKGOtm8KDGbgH9aLSd3oywqQOIzu4GpIS47rNzpet6oMEzy+7NeWCszvhNZU+dD0JD/VVR5e8PWxL7YSReb665v+oGRV7BPylctAiO49oChN5K9ZXSir0RlvepeKZiEmmf6v0Q0PdvEXOMrpuCXqJhddmODfgjRTjWnKgaMnKtBbWFo9+yKIbRHNtV8Lh1Gb3Iv+VOrpcH5QO9nsN7i7aVXn61EoT6KpflWoLUYZdRxD9IW/ZsL7Qe5jWtveo/fhLwunu40k8tySIccwCGwnnymN3gnsyATIHYc7IIx6FhS4NmfL8ltQo1ST5TIwoiGX/i53uWLV7t4r5EX91cM4JnkUk9vY8RgfO47yBMcuiv+dB8sv3RryttjoLhXEfxZDQtSeJdlGY2MopzOVJnml1YLYmXZMM7AMX/KMYbyw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mjm2+R0E2AU08yiUEVh8kPYJinKmzWBOjf7JwDE8C5GGA6m91gec+nxZpwghbZhT9m/KQ70gE95Q45enrVD4n/07tAl0mLixqDc/MuWv7D/Hn/OHykg7qoCzEmd17FecAxAH1f7hLBJA25ywPa+M++UtFvk3EpYmBqXweJh19zPlcpVRQ0hEEFHdkymFmUa0v41wf2WgPOsoULqodJSI1x4gDSFkA6vBFDyqcNrghE7/AZ0l2Yc6EWlkM6R5vavEhf5UwLQrQlJzqnQGoCyzZMNlFgXIE3aVgY33hmOMxYij3yOt+arf89NTefkbYQqSDCnVlE0YDv5WuUyIq3rFXXTL74I7r2pcDMPGh1Nw0KwKq6fz9wf5tIfqWtbZdkSFLIb0mFLLlQEYH0iXs+a1xPXiBf8JVrfUh4e/r/0u54BA3waOrONpNaCoylik7I54
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:35.0193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067f6af3-a2c2-4133-ebbc-08df0fc3b5ba
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB988753
Received-SPF: pass client-ip=2a01:111:f403:c110::1;
 envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


