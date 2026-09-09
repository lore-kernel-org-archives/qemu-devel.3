Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EFCC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyG-00044G-W9; Wed, 09 Sep 2026 06:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyD-00040h-6v; Wed, 09 Sep 2026 06:56:01 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004FV-QO; Wed, 09 Sep 2026 06:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr+Sjp6hV1YmjrtydA+/CJUrbFWl+oRNy0QMQ+c3umk4BqlCQXWAzoM7K1vXd3uxnpOwJTLIwd+EIsbAhC7X9SxIvtZ5NqwG2fIWHEedmitmtoBGGwOmCH9rBMSSGoz5P+jZsXelLzRGbH4Yuskt6oa0mWhKzasYToNnGgSSpGy3Txu1WuS4GWHcbwVcMgLB7+Ed+dCy7AODCnk2cYwH1nGs3HrYvoch7Z8ny9zXyaIfKt/0DThsu62lmGRMPjQSFAmqwm6QkKW1JHsdFhZ3hjK2auZTLMhsWg92dfzMYbduDZH1KNCFDw6KGq1lrt0iA0UIomz0FkLHOGtvBU7dWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=B2XUuqW0cRJCaKcsM4xNcQCGcxUmF4wjbVt7FGUp9Kvr2W+VFjisDJ66btTz38VTq41kplwd0YQAM3Ohrwxa7E36u4JV1Kh8MdDQodky6Tfix39gwOp4Owk9Pr1Vyb9tezI+fLo9ehrUMKHosFnr/wI4Q0MTg12P8XVCXMXqnNM1WWuCcUv00U0KGPOqdIftU8bRYeIpKE5wJY86Rrssa7f4RlsEi/EoRQrPkejN9wGJWkCmBZ23ujXaDtZsHA2ZCnNnMERU+7iCrCNxfVfy16uunmdr60tOKWOaXGaS2TmgDzdurRjNNv0IDgNETf2knbO+PO2iod+/4+KvhfnoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=GeHyOkakEPCjiyUVpY2ifG/podSrA78oTRibdvaQPpQ0P7SgrT8ipXV0t/3tBFFZUbnonblqE8XsDOTA2IGzqRsHqKSg3UlBEPPO/vnKz/d6U6rues/8YkVqmnCMTtW4UXJ+MWS/BoZq27tAsx73kwxl3Y2Ahs+dvs14lcNbNrKNbEdnmPXb0KhBjksabAltzRNi00lraxi/Mxns7deP9UcJF08qQ+xdtCNb0mxlVERwIJtil/DqEq6PxaOzwIF64qVxT9b/yN/HxC2lDp9xNDlxwv6qZBA95jTCWQSycYqNmrqoV1mvuPoCqek9T1gaayvrSrVhbRtHb+6AKijJHw==
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by SA1PR18MB553823.namprd18.prod.outlook.com (2603:10b6:806:519::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::10) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:49 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 82B1840BFE0D;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 05/12] hw/arm/ax3000: Specify SoC name in header and
 variable
Date: Wed,  9 Sep 2026 03:55:32 -0700
Message-Id: <20260909105543.1478008-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|SA1PR18MB553823:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed3ef21-9392-46ca-62a2-08df0e60e902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 53/ZiERbn2WAmcSFVinS2wiUk7tepq0ZDYPXgRoSiWwrIfrXzDtTBjh7VeAfB5Dlx/FMmrxRcL3qfLXXlPCFdjmJlyE5XVorVkZmAgr1sGNNy2a2IWWSCz/NyNPOOEJDIoztm9dffWda0z8Rt+Z1LQA/4/pzRONdeYv0oiKcDvA/abKYpfoux3Z3DI+CZNkCXDZrEmtGDiBTrwGQfQzGzB6X73yko2/FNpNkZGwP3DszV7qPl3q0bq1yz4Wk/nqJ/n4jKQOENutC7vF8DzlEz2YS2Bk6DXnt7o3wm/LScOTgRmz24lwdeZbhANTbi2nSGfHYjs4MlQ51AozpHUBKVouX7r165g26gMzb/NGrm9UE/6xW7N55uVzZiMeF5adR8Vo2yY72a/SrBHe9rUPdEGMrUmwpIf+MJUEIJHYjEkXK6Ga5RNz1e3ROwBWZPmsTLCl/2T8OZqJyS5qwdA/2kS53qGx9rp7O8BZT1BRzFovnseO7AXJp0rgBvq7Mh4gUP5HzLviBCTCGKrmEp6Fsqjl++C3xlTORdFFsuHCCScS47Vlw4EULhfjatGlnOPCRfqv7r+9cAah0JSPIvzU014U75TLUHhUODtlokzEWlb8ioQRGg8KxvN8AHB0MewBy+T2D/pNU5zqCNjOhB/sDUZafMbCIL3MgDf5+68t48SFalwUtu5GfPJGQ4VUXatthVzC/tO8d5G2rq1FUDD8O4A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KzlNdj3fDQna8OSrZvCsY8hGIudPPeX1XgegTxzqqKgXb+ennuOVEGZ8jm0pYkTcX0R6cVxeS/eTLUkvCKucvdzT/7BaISNCQTQnF+b2knopSz/fwetsZTe5wMfFuaz785Dn2ex1z5qs8U0kt7+nMrCGLY7xZeYUpZO7ZTGqspNFXrflvvBz9184H2tJd02ld79PiOIqyexHeogWSggG1ARTvhh0+Cr6Ga4RUvfre9+Se0YSoPbEbaMoDY7JIfL4fB1IY0IkrX67tXS3SvlmBFM7tlj0uIvhW7fNeTc3643JA7jg59KktEslUSMf3bxVvkVgAiOpF+9Yo5JdRolTR59hxGnq5C5SamFs7/Oxt2mfcKgt0JoxHt0BERr6OBK8m5TJl8tY7dMm80zX7hDx1Sl4Eu5lih7med8UHmMw2+45UW/jOG4wwu+9hv3zvj4y
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:49.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed3ef21-9392-46ca-62a2-08df0e60e902
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB553823
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


