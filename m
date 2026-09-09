Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468D5C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyF-000441-UY; Wed, 09 Sep 2026 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyD-00040f-6P; Wed, 09 Sep 2026 06:56:01 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004Fc-Ol; Wed, 09 Sep 2026 06:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9pMVbkf0EcM5WgAdnVTXArHPUhfPuC/T17p1N6IibRv/uNEJWmtAhkMINvTOJbRFs0DQU8RZoikUdfdryQW4AA5GBw6hKh82YEKBvNobghZsOmd8RGP+uO9pmpyQGA4RLGAopfXanDPLau+2CI0kE3LDirlqOKnzt/NLDLApdq0phpi4HkGFLLFFJzlqTOh2r/4Ulj1ZQui0a+6WI+GSlC7+fgEe7Vxkz9V/uzqC/2CHZJ2NgaSCZaqsUniU8P4G7qmse9rWKyb/XeDyTx222litCPlUdTYJL+PugobYLlA3GSs3YE7TJomouONF1CpYVUKQFCEPQvKlREGAWCs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=dMducqwysli1Fdztwjdq2UMuUrinPw2/xskkEQG7eVU7OuJmG91kBBjYBEeIsXH2GLG5K+pmhaSHGY8fwnGw9GxLYHp8O/Yrw1JK5i6g0WQPHz4Y4Tr75NOpNdRmRPx5Hxnr+EactjjXL1J0vUC8iqshmZGcUdAC19lpCYeFVoTKb5u4ymZ/rLDe3kO0WdLLns6igeSKwdpuDbnjPgPN1k17eLnNElZNmFYAi3CI1U1VNDv7hHUzPhZS3//B+3XVE9dJVcD35+Wuk8AjQzkojWpCi/q1QRrfkx4nRMK52ikWoB5aHLGlqRvj/AUMkDf6T1I5N3Q4Iw4u7osmmGgyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=etM5Soa3FQHemjXZf2RjJ/5hX71XwpDjtuweW+ysyTLE6hmC8RPfMYPKez6tILUuu/vaYJN+eqAi5bbNKFld6JuAEXd1PZ2Ce12dv9k3WpW6KteimKK2+IB4q6sdH9EoXbQzaWPLDFWUr2UKRxd7k6mdcCyb20fiMpv+eHzFWdvvdTsYvAJb0VAy01LVJ2ZAKvpWLinMqohg1L5g4XwDupWIfSLc6HcrP4Hsn1e+DNjOCXWiQrs1Q71ucRc5J3ZKy/aWRkhVTB6Ln0fYWPQLlVKeN9evwgUBpODSJ28pLg9CUknpBROAOc+Iv4hCw2OBQJKrf4IxhCoSEiey/txLnA==
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by MW5PR18MB5810.namprd18.prod.outlook.com (2603:10b6:303:1a9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:48 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::90) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:48 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 4601240BFE05;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 03/12] hw/arm/ax3000-soc: Enable BXRS support of CADENCE
 UART
Date: Wed,  9 Sep 2026 03:55:30 -0700
Message-Id: <20260909105543.1478008-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|MW5PR18MB5810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a75bac62-0c14-43a1-b383-08df0e60e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Hif26eXzMSRvX8CsCtUtkhLePpj/GyRNqvTjIHxTQj1JcojRuDPZA2G+EFcHZQzsh6Y+J6Z3be16IfPeQ1SJmP72CM1Xp/EhUVhro9ro2VxagbE5Z/T7D+pYRcsm5tAdZWSYsdY5NXR25ehWbZ4h5DLfnEOQao2sM08YKrhJ1lgAIMdiU8tdxfDway00csdB8LhBMSiAHf0pAaarjMEJF5f6JkH7AY9WJAv1bKLtJtYA2N1+Dclu1vI0J7o2vRT1ShFbKt/CKotq/gj4azftYBPjSowM3mUjSu9SLTxr6oRiE8mR5PS2VGb9j6/CK/m2606fUdf9/l7YpfkC4uKx7bdOqRrfqRTTytgxXwBHto7YqWKUUX84KLlYz07IJYVeh5aGemkEgvzHAnt1AvhQashErld4keToXayny0UecTrgSbeHBTqBUPPHSithrE6X1SlloejEcPhOw6sYkPfqHC1y9d3PKt9djpQxbEjvShkUhpDxhdDRjP6ErZsYLbqLI71aak1FaW3YsGzeGRIWM3yew+Cg2c1UvvgkIoJ9dngdxRNdF3vbvX0EIB5t5Ph0I4iMUUtc33lNcmQ1QkdR6au5UJqGkzkJ+b5MjcVo0r68cB3r1W6wjTIdSzgLkxgoWjY4S8txyyx6UebCWBfSwiG82VEaRNN6bO+CuUAjGABNKLC7hH9olb7qOatnKF3dwewHrGI6YboNsnhMS4E7SA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Luwn5w+nvzu7/TKcmXj8c3GrqkaMytAThIKe5TnfNzLQlTochJdpsZjlL44IEHJjm6WeLSbUexIOzpiEa3HABBgocaylwPajkDFkOmovNjZalA99Vruuz8RtzZkpZoTxx3tKBvzeDbf7Bdw6LvHjsV0eOjgofjhcSkrwDo2mL5vikVI+1TFaKwIZyVPuXmwduHrYAnRpc7R516HrITDSDCVT/IorJ8QkDixA+8YidLZtp31Cda1+40SLhkwIPNE7r/j8MGoj2uDUz2xRUQmvLA5+mEX9UqX4PToXI+XNCn05V12x5SOOmaq0UssjuKNo9PtKpOs6viiXOmcIkAJMsnIoxfiR+e+mrjL95bShGSeMdoZoqg1l2xHbGbt7gCoPSje+xhEnOuvWS7g22p8nMB77lqVaAjeQILJmFbk+UAu7xJC3sQCQ6KmgefQc6Ym
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:48.5648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75bac62-0c14-43a1-b383-08df0e60e840
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5810
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=kchiu@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

In order to access BXRS (RX FIFO Byte Status) register at runtime, set
property brk-support of CADENCE UART to true

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index ebe174fb97..7b96466860 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -155,6 +155,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     for (int i = 0; i < AX3000_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
-- 
2.34.1


