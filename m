Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31D7C5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL0L-0006cK-Ev; Sun, 23 Aug 2026 23:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0I-0006aJ-EM
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wyL0G-0003zW-0C
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfEwIqbYPEWDsMHU2gM6sOYom8v11aZnfmUmI5ugauTlNna+B+RPFfBqLJ9QRZevkmMXJYne1BmMgNBKWiDFqoT+ZuagKy82kCmqgnae/aq2xBKLs0HEPmiwz2CLcZ2t4nB7Auz+Cf34yMDEyGgFEfkEpqiI4JBJRRWrHdq31jhcRLxGk+OhpK3WOWp/QkeZoMNRE4g9dSmPvy5tWZH+9hq6FLC0i3M68ze82sqbTxEswS1b5lvp+AadZenqCaKgVF9EVZ9kmCQlbiaXOXFqD8JhcwtdMT2GGoi3kMZarSONJ+GfBXrOZfLcqpD9FXgeaLgOy6wCfOOjATz1ADfV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=SNsKkMkbnkpV5MdPvyqc31In4GthQcArGlXv4ekc4UFajY7GNBFCBfJg023IP7PBTxHZAxWOG9LbGjOjqzrPYq2PppXZI27e8HS1RjknFLSKhFWMEOaXLqaiPBCkpNBECNNrsoBu2kTSBTp9Bi/yNAoNUKsAtQpGwNmd8+1n3luaSzxSLtr8qgYRzJVCUq1+51+qo4qxDsFcI871PTgRvQvP1fL0sivuXeLtHKyjR8PdvGquSQ+AJg0opbOBVFwXhNtbOE2OqSkOCnPEVNhfk6Mq7FQvmtMj0dbglpcuoxsVp8IaZ5v5cowmgvWWWrJ4PERyCtPn7Rm4OeDkI/ytdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfMRbeKHti39Rkjz1jBp9+nT6iulJO4bkyNMI2AfOtQ=;
 b=YPgSK4B/i2I+MAhhR5I42GKaLmCpEsag8GBqMWDVCqfpgnXxWY7Xc+l1q8u0cyyvM77t28U9JnrvdaolG3ynIftFoAtM/DSJUCGQMu+ob+WHE8sQJOsYyrnQs5NIgK2iYfNm9Zve18SkIT4XLoYx0jTLTyNDq8DDutiIJy9fDRSvOgaeZI8BA+ZoAEpzOnm/VfpNOBEcfgfUL8SOxEbiE+deMrWzaQKco52TMQcTAszElAVZsAuZI3bfAg2u+lIiMkgodHRHPBHqtklHZ3GeCwV0hy4ySm4sIevf9mrio0wUHEmWXmh0YpoNZ2smW8lo843PjfFGkm/51+hmq53D3A==
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by SA6PR18MB6184.namprd18.prod.outlook.com (2603:10b6:806:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:05:35 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::26) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
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
 by smtp.corp.axiado.com (Postfix) with ESMTP id C20D440BFE04;
 Sun, 23 Aug 2026 20:05:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 2/6] hw/arm: Rename ax3000-boards as axiado-boards
Date: Sun, 23 Aug 2026 20:05:01 -0700
Message-Id: <20260824030505.1969726-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824030505.1969726-1-kchiu@axiado.com>
References: <20260824030505.1969726-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SA6PR18MB6184:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f192d82-9753-45be-dc5a-08df018c910e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fZZNICMFO2+J6JtEGJfOMm1g9rvhIRhk7+u7lGMsq9D8ee12IufZcQuQWYwQG5BOfbiCZLP2hkHPoecoQyJjFQsCoAEWAmx45NB9H0Pigu6vhR0zaP7eh3hmlX5MPlXpzfPILCjVflVNCnM6V5cD++MKvsMMPYtQDYUavsurnQ1ioDQQGh+kb09OddpJSjrzrMbQNgsxeomRxbKZhOqjBzRZ6DFK8C11FIohlsYhHWxV7JbKq72t3rCcQK4gSVJaAPI/UP4FApOKngFaAkKFVG/i84DLwqVR5DacZkaomXj8RD7gxNeo7ru+05EkZWTvzxPbKBgcoPPS18G05XJ6Wfff4eYx3HjtIntpt/XawAK8bvNbn1a9M+gPYiAreeWCtUldsji0QIwbKm+wwG2m/EmW4VVzYyx9fAWTwiY/hmJrNPStaqtMISk6KbiW+IgYD3Bw5c9pcs+YDxt/29hhU62k2+89V8SeLGQM2vUQ/YIc5jOItmJMEGYc4qmkDFYulQIVZ81ouqb0tbg9ilXX0H/lYm8zq8Rd5zeWp9DSURgZXxRf2f8PhfxJqY6hNNr+DO3Gdi2vH+6qQ6kGnlwncj0FHudkWGP2T/W6P82F2TaQQ/hpgEqUEasyKemVmrSuZ5R6DI/wqoKgkcPvY3o5ucv9I6oaKtHAISz022kWjBzTk1RoyHnK2jBhosxQP4B/+pWmnM/qJoQao+bgc3Ycdw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fb5Vh5h6hLwBXT+OwGztWP9NxzQV3zrlTBoK9hs1kFi1ndJywbFPhwubStG00XLukDZww2gyeB0Wb4M2UC01HvejFTqzgG8yHxZ9j3S5GdGblXl2581PQD0OdJCfzPGwqW6FiPJMzVa7dA05suIIFO6zkP5NQV63FbH0wZL/3heXS4wI3Kt0JjaIy4jnZWKjMfZRBv8f/XdXqixmCQxScPtuTjzJAhv/fMuGnZChfVRAh7fw5+/Bvk+t1cKzsOcT4jJ0zcGuG0hn0D8BC80p2SFFx7NiuOgIRThyNtULkldoo7F+2XgJ1v22DLYbODyzMsTh/zGUueJgWwFkhTIhb+vtFUxJlJulbH+ZmKufofnALqUEmZtqqTY+3xlsFPHt06I1/e+CWyMYdO6q8sU70O8LmEq/RgXvkE7xG5QssPGwTfravqzHpwvIFIQBbyZQ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:05:35.0160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f192d82-9753-45be-dc5a-08df018c910e
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6184
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

Rename header file ax3000-boards.h as axiado-boards.h for sharing across
different Axiado SoC series

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-boards.c                              | 2 +-
 hw/arm/ax3000-evk.c                                 | 2 +-
 include/hw/arm/{ax3000-boards.h => axiado-boards.h} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (100%)

diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 4b8deec15c..1b645b7f43 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/axiado-boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
index a170848871..f491de7521 100644
--- a/hw/arm/ax3000-evk.c
+++ b/hw/arm/ax3000-evk.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/axiado-boards.h"
 
 static void axiado_scm3003_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/include/hw/arm/ax3000-boards.h b/include/hw/arm/axiado-boards.h
similarity index 100%
rename from include/hw/arm/ax3000-boards.h
rename to include/hw/arm/axiado-boards.h
-- 
2.34.1


