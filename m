Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A43C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx04A-00065j-UX; Thu, 20 Aug 2026 06:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx049-00065P-Bj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:09 -0400
Received: from mail-southcentralusazon11023117.outbound.protection.outlook.com
 ([40.93.196.117] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wx047-0003lj-On
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPlBcYN8l10LEXQfI821jk5LfGO2JO+2w6OiNNnMY8U1I+BORtKkt18nvDm4wtGZW0xx4CqldgxM5TxfUlMcz6Qqg6LHYT6Sy1E8iBJZxHVQARdTm1zwbpTAbCJLWMnNf7f7p2ox04sRdYdu8Jz3KrM5PfjHFJuDhWmojeyVX3hjsKHOzKHLfbDEtxk7T3Bwa4o/lEEaMUS4TNxvSouRhxyjPkFrzi5205P/gMqXe0li1hE4AbJTqC7BjUb3jmXgwNg6FhE/mvgqU5lTlqOm/Dc2fizkhernw+Md8jckFu3v94nmKw73i0hmDhQ4fBumNfRO7fV/YY6nUWovwjtMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s53dlB4p8s2EcH+3NCKEp1lL+e/33GW/m73yDnWxNS4=;
 b=BPnEkivav+XA/bppXtug9LxPCRl0J92fMUV3bz3FBiGdxOxYJeV2W8Kp9jS2fS/Ej2hDCYOlc7sXPt/cLuIIlYJLJ6xH676TEnzc6b4ALhBnJ82IVLLwMr8GCb9rW0LFHfrvnJrAEsafxreqPq2JnVMURVENSRbPSUrUR9VE35BuWe6XHRLSfNmkycz736l2fySEVOzDQM35fy4cyVp8sX6LmxCZ1tD5l+LTGyufe/aRtRB/4zFsr4+onhJ/yGbQUEFArSIiIaLhM0fSjo6nZ3FwK2I9Bcl5hjd2758Zn3CLPQig45KFvYkmAa/O4RnOPxWPmH49wcMFSil1Ep0DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s53dlB4p8s2EcH+3NCKEp1lL+e/33GW/m73yDnWxNS4=;
 b=kQrZd4Bq08huRcVR/lm5I3TeFIdqJFLGOWny9TojNGoXKhT5w3JJsVEIMGtF4+Ppiz7QHiGA7AkAa7T2lZK+uwuI7++rvaGk4ZlVU7IeknMeyJsmkuIQvOnClIRPkxIGJQhSOd7mMhXH1dC990uymx+a1SIk2MJ5OYHmQ69EQv3Jl6k6/H3dXeQKhCq+M5lMygdTPE7BSPSyL/+8CL9zqPe7DGyj+SL7lbNqPXEdxXVoCEKZAGX4XB4kS4rgjm3DLrzzm5jHfLAOkudhDkUR4hqN2XxMTXtxLC9qvN0oGMAjEEPvVmn67DCUkA7Q+89BTgM/ndS26UowvvJ7PwSXHg==
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by LV3PR18MB6289.namprd18.prod.outlook.com (2603:10b6:408:271::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:27:02 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::56) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 10:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 10:27:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 2713C40BFE05;
 Thu, 20 Aug 2026 03:27:01 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 3/5] hw/arm/ax3000: Specify SoC name in header and variable
Date: Thu, 20 Aug 2026 03:21:30 -0700
Message-Id: <20260820102132.361642-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820102132.361642-1-kchiu@axiado.com>
References: <20260820102132.361642-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|LV3PR18MB6289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9204e73b-a6a8-49d6-5a77-08defea592f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: dMHXYfuEdHcjxXIs4g2eGgsixsDl2svmjBBQT3PGyfMsLYRjsc1yrtnEzQZkJ9EfksWjedB/XiVevGPXERyXTX4NhREsNt67CCoIijo3/ZikfRzYR8FuqNHPQYjod6sz6p4Znmth1qotCCjxCO6LsiHncA5V9lb+mhlcFeH7LFqfPLTw94fkz4D0/BrwKgSj127PMiD+Da6ZdyTwlLWoLHTg0b+KmATznthmk1jbEqw7uOh8H2Tke4XxqWPFznUA2Z9wPTFT+owy5iPnVqS1XpF4ExJ4y98COkKakqoZGeQv1nIWcbIjN/L8iBJabSRP90tGREw5HHcMX+pFJbhtL/fvNqlCf6RS3bM8xGPzVzfCXekBDBxu19P5X/RWSLXtRjeF8+39RQrH1W+cFAHlYl+08kYO9Zll2rH0bCeLkK7vXbsDuosG4g4fEb3ddbyVgIBiTd83D/j4YL2TvdsXz9r4mFyG0wfLi40QsvC+lqtvtl6Ts84IyadVhePVstWoRX+8cDrRZPBXZjE11rnswDbZ5ZzhfvVwBfWRPFMI/ml7nELjijP4lSgoVBy/jpSRW2XRkJRDs9vGCS7NH/vP2+0ZaBufGnp7dBDTnERUdUd7RMKCN32nbeDUBZk88ADwPesBNoxLwg1fm5SxZ6Ltfjmgxt9H5463uiErLaDaGjHMEjAbeBqOu0gT+FnUiWEu
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CqIT0/Q+EYeXk3UJbAxLoas4D9TiGWJrMUmAUOnhcqJoXTe828FDI9f49mywbGJgge/6AJDshGNRMpsGI46eY+UNpbnXUPrNj4s9/+/6GLfY2VQAmucARw6io39yWA3W0ZqwStJAO/5sMYOQ2YOTK4GO0QhKAZi+lSDGxsSpRBfPoLOoBqakRuSN5nqjtDuwpAgSf8AOSfFDue67LXwcTQbKlvBkKPNxukYQmrrGYZ1kVLFfBv279WyfYiaxJ6S3bA3/V54d+U20bmOIYEZB/r/+55ZckeGegTPyR/ia0fLsKy7OX4jMZUy0Po30JGob94DiZqu0Xx3YWco+/cGhM8skm4LxfGOxOOUoPZd5ZqO7+rH9DRvWX0wsLyz5iP40JkSXw8l5uOYtlnzlI82SkrVHxo4fdYhhMFFTzr9Tp6+YO/YM2k48U7bnCcLtv2t1
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:27:01.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204e73b-a6a8-49d6-5a77-08defea592f8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6289
Received-SPF: pass client-ip=40.93.196.117; envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
index 71e31c6fb4..5009faaf99 100644
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
@@ -239,4 +239,4 @@ static const TypeInfo axiado_soc_types[] = {
     }
 };
 
-DEFINE_TYPES(axiado_soc_types)
+DEFINE_TYPES(ax3000_soc_types)
-- 
2.34.1


