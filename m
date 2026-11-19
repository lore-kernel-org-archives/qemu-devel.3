Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A7606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=t3+cKs35
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN9-0004Y0-Ko; Thu, 19 Nov 2026 02:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLu-0003CZ-8Z; Thu, 19 Nov 2026 02:14:39 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLs-0004QY-Av; Thu, 19 Nov 2026 02:14:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i17GNmVBuuq2GBeXdpDlxWNentjhmnPt3m0hUM8wdqmd9XTYpjx1GUmkGOciwovUKcKGFemw/LHxp5OP03gGUIqxGJzDN6l1oSnTwu+L3tNr1C47LlMrD1X6YbTh9hHXtJgwpnphhiSz7jf7odMIVU98b6ZCr+zrkez3GbdRxHVCuPwpEaW9lUuiF/3xEQSi2IFUjNVaBDj4PbzxRradvz+CQszK091lY3A4CZirztsL/bDk/4yOPuppfG9aDQFfOcA/4p1NWPx71WH4uGeuWsnTQ0cGlnaxdeb8EwfwUJj9Hg/ScPqj68RipIeH04f4WBFI2whKGLVRyNf8eNsb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=uHZP33SCBmgBuYk/6U7PzUhRJCf5S5Y8eAtYkM2ckEU3Ik8TERJnDQ8SBSIcrdX8u/hpsozAm11hiojjQrktnxyc6/nQYvo3hbnavqWaGyRsL7rtENa+1NAAthnFlJrqSZzUYMTaU61ONKc91THf4u9TfWtObfBOWQBifKt8gIheD4n2zglh/voSnKCxGykcUulOWp40jfG6PtueCGu2YI5enHGK45CjO87ZS59T0DdyIGfatbBWiX3v5Wxg50g1wt+0P2NQQ0OLIuv0tAmJSDOxKdNrlUYNS4D6xSBYFo5n8DlLjmmvmgx9WQpGRwebKqsANIacxULgAV/Ou1vdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nasF1JlzF0AQQQsEY9a98SqUZjUJnTKsNsAl/8/J88=;
 b=t3+cKs35lsDs4NngatVva4GhnKgeFitrTHr3Kr/d/xfJEf5RlaHOpA8cu79YpsZfGBbwpenE1g+vx3B7Xg15WfmZZZmQEiO1LKERrG0ymv6NbrZhxWqfT15M5UvmtGXlU/94vx4lbA1s3O2DVq5F8AxVD4geW0QoWxCBbUYh7hyiw/wUFH4jve0tfylnwNtekIGNHsqj5OKpHG5G301HxNCs2dtRKz+QBB9sT7Jfciyw2k3css6D2MZYdjDB7Q9wOPDrhGwEQiSkDMgnR/AA3VgY2HNKQigeHSScIIeILtu90fSeBRb9Gs+BTgu7eo3guWBP7bPNl421ziIMaIPoFw==
Received: from CY5PR13CA0112.namprd13.prod.outlook.com (2603:10b6:930:9::38)
 by DS1PR18MB6319.namprd18.prod.outlook.com (2603:10b6:8:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 07:14:01 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:930:9:cafe::a7) by CY5PR13CA0112.outlook.office365.com
 (2603:10b6:930:9::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 07:14:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:14:01 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5623F40BFE0F;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 05/13] hw/arm/ax3000: Specify SoC name in header and
 variable
Date: Wed, 18 Nov 2026 23:13:45 -0800
Message-Id: <20261119071355.3520249-6-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|DS1PR18MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c24394a-5287-4a63-93ae-08df460cafd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|18002099003|22082099003|10067099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: J1f3Hw56YAVi0YKq377KZDq8P9REl1yQUuush4oduhoPGOskzF3hTvN5qQQa5dSfGNf3pTUZ99Srqd7q1fq4/joInxd8kd+48W8LIw/CUaQfc233YlJU+cjSSxQhC5WOuBOQasNDQ5QoIiXdtre2NHVVdYkYvvj1Nq/ztg8Ubgyh36DpEj//LT03AwnOaoVR3Yv7XsC6n/IFc1yWVa3K3uxoZkpCYjgVyBIdEkNa0MeiXZq++vSBmZjb6+8mqqMs3dbEbxLZsxa0EvBspxd51yuM5uv+O2qvNN4ilKBoB2D0o5q8dRWOBNGHkRfBbtbWbW/PoGVwLR4Fe5j8HiBiMdZlL4d+aVaopzulRqtj9rg8Apkj0XiWgPvT5BvUdnr0iUbONGZgL5Uz5gQ8X3SxFZ/TzRpqP/1fpZyR0RWW7fgKUFC2pcUgAax3XrUegMP0XzejI2i8sr6/TzoNYoNLhKOcdUVA8snHtnnkPACf6ZIwDg75Xlgd7612PgkiuwC9G8nylz9YY/rvaqs/AToWoc7C5L7bYjbHKIp9SyNTeCs9op2syoJqFRGadHUe4UHRQIRnCz2Q4ta4XqBi00rwrzyMl4oyr+9keWU8zb8PGgfFVxFwNGktiVBNksCkgXgpnBSrrcnSwdQLHet0oi2BtPAvCHEiCFfjWDmgtlMYUGWTrtezFYQkzzeEpd+ev9li/xNKh7ziXgZvdpVK35Bw4A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(10067099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Wc0iRTVPHCbFZUZrDIF1OG8iVQV+Pl148C3EwQqst8STVXeIcKP8NRZrb6oe8DXuM4stjg2KlHVS/c1RXZIiP9/0kEsiFT86IvIU/ND8U75yHSoKZ9rWgyYdmY5FJmo+bQz3UYygAJMxyA8beBPz7HbiQT7peCFFpK7TI4LXj+aeJ0y+6NvQqNq/qyBE9XjE1W8M5bD+rArq0n4nZ6262pcS3AiVzihBv0cBLSui2t9y+k9ZgYWkQOka3cbEE9zoDzTjS4KzuBO+jyofpLUcxaADC+5Xr+y/sKOuLG8aj0PIeDy9mt6cLdj+S9dHE2NdYPhaem+mRYZnkCgLdwrJ8XL5Y62IeG4fak3KlByplMnrDMKMxO0TiN2eksCGTIZC+WV1h/wTzD7+Xs6ZmQBn2JwBI7ErCizJ6eWY9WFLnmaabeKWlThTjnJeYBHQcIw
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:01.1649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c24394a-5287-4a63-93ae-08df460cafd6
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6319
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


