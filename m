Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D4AC5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0I-0006aR-SY; Sun, 23 Aug 2026 23:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0H-0006a2-9s
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:41 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0F-0003zQ-Kf
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm5BGAzZV/B5RWEadVtRSeiNuNfqXJLHKwX0omOuio6GKDtCKcfrJi6uC1Diz5+ApjC/ng+W5qrfPe5uEA+bzS9Q0PXsi7GGgv3v3hGASlSUKVQvD04jQ/JNBanQ8qoPrrLTq8KSbSp+8HAu7/VjleumEzH0YskCWI9DQDyDBRyz2GD0frks6cQsnPIYPEYbSgy21XEXI8WNo3WIB1L9OOGWzaI7FoKQptYGysxEqKJEQDZSS1uA7B9aB6HbUKRmUAbL2LtuRyCts3NFsj9keYZmO4sp6iWDThHaITIVj/c9i0IMjJej4fQuRIMFyCoY8iWWNbOqrd7lPY8fr1LxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0prrgh0MdI3tEtxNZCqjlr3gGF9e5hu1PchXqWVathc=;
 b=mN8ii/zUC2VdFri00cMx44zgt/iZewj6zGGss/wIbcy3lS/pE2SLk6FxO7ptp1emEO0uUdz7rOtkz2BKAoqrfvzJLPmsUd1DRliilAE7FG/nOTuqV5t63hm7En3Gc9uxPQMq1vN38FImNM14o+XSTZGiOOVAmMQ5vgYViyjW1DTKj/VICQtbR9TH4VcIEmm+Kp1fpUtFzCjXVTQablrWA6JnWepB1TbjSnCCoN34NveVVLWqJriuNYvJaF8XLmC6NfGkTPbry8lF5TcnY9vyHriw4YnA0QjbBip6RQ2udimuTdWcZ42agboDFpfer7iwW5i5jz6DLHR6QuyrDljyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0prrgh0MdI3tEtxNZCqjlr3gGF9e5hu1PchXqWVathc=;
 b=xit3zq9ylQCks0D2Qy63+fhTGjLF6FLJaEh8Ez05T1b7z1k5G/GmFQ0BBU1YZb2LyA0eJ14J4SNFknx7XLlFg0xC+04MtZxZd11Q7XkoEOgkllW/8OCFycCZSPydSivyY8ScmvDdwSxPJMN+UiVv+62tkMKKpF01qeo51GVERbmfjDoyyyO3y4FOFs8Xo+WKtVKVdYJ5vELwiqVjgM/x75TQTlt4++KjSZS9JEQujcZqRH/Ggd2bt3YwHv34rxfZ8RXHjOuvYBmaB2bDJgg0z8SBgY/jBV0VxMH2NlUuu+48xxMfOc2cmPjSXiOYtFn8GO13JvLW4IYXNzBDIfXesQ==
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:35 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::90) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 03:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 03:05:35 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id DDAA940BFE05;
 Sun, 23 Aug 2026 20:05:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 3/6] hw/arm/ax3000-soc: Add missing class_size to TypeInfo
Date: Sun, 23 Aug 2026 20:05:02 -0700
Message-Id: <20260824030505.1969726-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824030505.1969726-1-kchiu@axiado.com>
References: <20260824030505.1969726-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MN2PR18MB3685:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56e347d8-c3f0-4e14-fe66-08df018c9115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T1x/dDgfJBP6580taUBMVW0fXfXM/YnfGT4kXiaG4DNlvj4Sowt9NtMBJlOzkzumz2BjpZZo+akDC0SDj7bU210rCHqh1uCwyfDKnGfFpvu8sCMpVq2pseYEa+HDYRk1nW/gj9gYJiATO4nENVcZ27X9uae90bN7CHBDeP1km1ktwHX6tTbOFVPvD4v3EynEkXfG3WfR2gKFazjlVI1F6S/C83VGSmQPqB+stPA2woviAnkJ/vtX41e4HkOFNvxwxmeAB5UwOGoh0R7wup3lUpkJJnd5KG1df3HiI+s+LU8nOXP/2yfqLM0KpbnyV8+nioZQRBgaOLeP29g2TCx5QGn8chtkcBRo6es4j4Ej5z3z1kNwjg/qilo62LsZEv3B+2IafqDLGx1FgMq9iq9Y2YnjmUSpR8lAj8evJDZD9ffJc9jC7HyOeYxnN+4bPUSDHAob39lx54QYTwEMs27yFWoU41HflCTqIOtarzqFE2swc3Q2QRuPWP8+yqdmkwtcp1eCKeGlKw0lStAnAkD985/On7TQssj87um4JvrYfnEhH1u6bCy/MArekgHGIOQVs+asMD6NVq47CU2XJSWHlbVcIo0WQpZY6wz6bkR9oSCimJoNAnF64yxFbh3w9/J1lLGDvdTtwWNrSvbxH/+Xb470Gr5/6TcJ9LHreW1+bQoNILqTcv4L87tFi36f7sRWVfF83hhxnZu/u/ojOUxsmA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KipTshSS/U5u3P7xP3piHXJS0tJQMSWokTJOaI9UZco8gAiXb6PQKHSw3t2Ex593KUfaVbuv4DLMG4a7BKL6uQ8LG2ZLLxLuW7rIu9lIeA4h+J7cdfeW3wkkcHiNs7P6kRn+BeTLhE1j7WCm0sHBvEYNJky325YCvAW64syiLQY1b41/EtaRmPtMYXldreSEavKT5ixPdbn/jay/8T5qyTbjzXsALCk8XukG+F2g/qJ2Aw5jAG1jIgizKrMhRKCE59yL0fbxJAa1WaSQXT81xrizqknOEhyUm1c5zGMChsHrDPvMioP9Rz72TRX7y19mJI9Amect7v08n6G+3S8T+7KbvSxBFCepXgMuyzDCSCiRK81IQRwp7bhsrcZ56g5SdApSWf9+DVYGwrVGuuS988PGge4dsVFDnCtbp5TlKqM3fKoTMwLOSmppT0cf15yz
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:35.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e347d8-c3f0-4e14-fe66-08df018c9115
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3685
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

Set class_size so the class object is allocated at its real size.

Fixes: 33a71a68c6e1 ("hw/arm: Add Axiado SoC AX3000")
Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 71e31c6fb4..b5088b17f5 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -235,6 +235,7 @@ static const TypeInfo axiado_soc_types[] = {
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(Ax3000SoCState),
         .instance_init  = ax3000_init,
+        .class_size     = sizeof(Ax3000SoCClass),
         .class_init     = ax3000_class_init,
     }
 };
-- 
2.34.1


