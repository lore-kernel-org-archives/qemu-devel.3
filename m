Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D409C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i7m-0001zC-F7; Wed, 02 Sep 2026 06:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7h-0001ix-AJ; Wed, 02 Sep 2026 06:23:18 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7f-0006qQ-Ru; Wed, 02 Sep 2026 06:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlowhxwLlVs+8x9hxxn7p3lNi7ANDiZm5jrKL/YZ8MOl/TXQrzszrbZqP3jXOtIn1piTOeG/63pJCpDNKvgA7tGrHv6E+PJPzihWoSpZ53iI1OXTZV2vr/pWtnsUnleLQrbUzcmggP6Mp7i5e2t971BpHCCPUexvNfF8v6CUP5dkoViQrJV8Hxp8IuBQtxf8Si0psv73Ro8HIbfSEngQfqz0yT+eXV/bjyV/xT+MKt7Ims1Pb7OYxnecJKlcwAyRddv6bnNsH579asY6EDK5adZg6pgA+gQapF5QVdDI1LHgNBEuEAUjbZo7GA5UP7hogeFgf910m+X1O3BLYhFHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKNJvJOxwEIGO/93oLmeo6VpJWW6ICm5eJ3LzPzl72s=;
 b=GdzxhojXhtqE80iHSqcfCmfxVAleoWvHaAjgPCQuiIrndXSDSraupWO7ckmLz1wsRXjUp6nyFbYnYZIgRxGRYHhzwKFIQgtWF2NWhhdjOgqwNYpShb3t5Wz20eOQy33E6CqmsWSJK9aUeYpdKIqgUuleXBO2TVrhsIDIqBjKBDp68Ykf2ndw7WkQrTHGn1gb8YF9NWATP5kywido9qaBIHc2Pbu1cTnf+LDMO4zFbJZ55l7Hf6kl82TUgM9EDlf2WCzNYbZ0VB9PDPP5AMXIkuxCShQuw3ZXw6bE9LLtf2XkpdolDQdOj16Hx39ZQDz3TI80kEnKvERJsFl+2Zx1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKNJvJOxwEIGO/93oLmeo6VpJWW6ICm5eJ3LzPzl72s=;
 b=YB5PXrkdMHXYsye3P4wS2dG/RsI/FW0lJZIS7el5evjRraYpIpeVpZcrz1b5EOMQh98VAu8ALOMc8ZzSxAMijuviXBPF5QRFziBNTBlUSAdAVT0okQLHKE/+TJH5MNQWDn2RVHzS3OIykmzWlDu5s1IDs2NpDNhW7hseunhpok7Ug8G8vr5hNshHHFP+JWF+Dk3dr+G9fk6e05hBAwQYyW7VIFJDqdieHfGG7hhGc1NwYVJlB2Wc5JqTwz7UXa7dXw/p9OUe5wNlNRlIJsXqLnhip4GCvv/pddkalgnM9cIL0q9Q2cPNqrmg4wOhoyg+HrmnTNjVFNXPAS/xj2PSLQ==
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by IA1PR18MB5514.namprd18.prod.outlook.com (2603:10b6:208:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:23:10 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::4e) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:07 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5AD344186B53;
 Wed,  2 Sep 2026 03:23:07 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 06/13] hw/arm/ax3000: Specify SoC name in header and
 variable
Date: Wed,  2 Sep 2026 03:23:06 -0700
Message-Id: <20260902102306.3039303-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|IA1PR18MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f8cb6d-e300-4142-cca2-08df08dc2ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: CGChLmq/pEfHUtXh/7+uQeaVFawLF53pmbtl8geaAS/ldFG9LWnIa5cGEghh8GoeyOkUY83N8T0ClvCYaOqDxO+owQspe43JADPHh1cEUAQ+BXahC30GA4JmwcRghzK1ZHY8IFTZ+eOw+fXBVBr1/WzVHb++Mmc+9w1oLEuXjI6/DnVZqgYlsZd0SaAaUaIU6EMAlNpyWZasOpw3I0/YjDXVDqT+aMLpqXVqSeIbRMVBXnsficms39oA9YYrfNjOnG3JOERBtfvxKcUKJ6tojZ1yseryB/qyHNaV+4T2lBobVOWQMUI9gwTpJBToh4Erqeju7IJ9oCM+wvdjQtFzoXLPYerzV+TFHirID7BSDKvOauJ/N2CiV2HU6yuKya7If5IDWSBl9sxzQbf6LWv5MDWHKeiUM8Lzjg7nmx5BPnlZHTvtKHcwyEyoLuUEZ6WbN1jco2qOmjg2SCBlDU9edDKBLr3WBzlrsiBDWP//hzP67qMSXS6QhvggkbFDy6uBol1GrkCgOwqS3wdxM+PEnrTe28A1Canz12KtxGEToQW982+Ox/USN9LzxwYpKD0Lw0Zo4gjgiLaMQHlLR5WIxgrQC+rULCTRb1QWn3fWNBvcZbPYzno2gwFEAg3OtQXNI+Kbo06wMd2z39xEUUG20Jq5mSiIIjXXb1wyigREejif3x8ume8jefuRqIifNS7kg1NvESJja8xQnvZrfFOzqw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4P0GpQJtpPJKwE5gmYS5R5My0IFhVAmbs8x09kXbu/v2F2KvoUrjOXTo/gTQpfAWtFvUp8DN1+d1JkJ+8JvWPLoh66dM4AgDWH3DB6rRNrS/Jn5fenrl6elZLCrM2ZfZs4EJjXMT5MT3JmZBXS7RwnQsf8PJHidEFzMPaqkJX8FSF29iS1YAV1/gpcKQVFsqfKs0zA644C8DdyHDFq90Q6Xw1ZFhCaopctQrNo8389BuTce8Sk0xN8hUkqU+4q9QDMK93s7cGxzArFaZOF4obKwLjUolaxANHLcr4UcDCtM2/MOUsUI2r1SaO+U+k/rKBHwmZHfa9JtBacjMjnXu+TRQwnknsVii0BsAIeOAmZXoR3uvCeeXk6yxUmO4yYmleZOYdeN1ehw666OIbp48vA569AqArEASDq/wuenJEy3+4aQXTsxLBAuj18tRffAR
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:07.9819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f8cb6d-e300-4142-cca2-08df08dc2ed5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5514
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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


