Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ABDC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lo-00054a-KI; Wed, 26 Aug 2026 03:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Ln-00054F-3x; Wed, 26 Aug 2026 03:47:11 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Ll-0001YM-Jm; Wed, 26 Aug 2026 03:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho7ifN4++vp55kB7N3oxCSi8bPI0e/j/36GiCprUqP9I64+9uAq1MbRDyKd/QqW+kzD9R6R2FOhJJPlGvRwaPG5EV4BjjJJdQav5snODazdxSYclYFG7mDvS+6XDv9aaohWC7Q4fD7OAlIUm0ysbPal4OLrKp63KC34SpCGPXiyUHAQxe24pLbGlDAuoaJAV9S3h9Ak5g8CaFmoT84QEU0bq84T72isEZSd+r2S7lGBQJ1G1R9TMqJ03csCDxBwzQbs1sb3bFA+tEUOFmCYZKzS3kH8YAC/q714FoEA053c3DQhUtshpq/Xu8a3khlbYwZhWtFvCgcsQ/czP06ooMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF6CgdNKRnlSw1ULpc9bBnzhojk2L4uo+bbUUyZPC7M=;
 b=YFFcw2OY0azFd4FxvGnf2POHoTzqLIEZ0+R3KOk9HkEcj03P6l3AgUrFILT8TR/x2cXWsPNf5qkNWkS6KTqEdZDm3+kJfewH9M5KkfECrxN2SvA4ZY6UJoyLvfMrYIcjYWBNtQg2sGL0riL/d6lqAWt3Kwt4FriTPWJKERsNljPt6bScRMr93ALt2UMI/sBcGvcvAaApjpqKMGunejW9sBBcFECCrRn7CWUK9IhF6Wj8en00LNt1ypWzHUEWWnCjrPRxCfDWRTsXcj9/G3aEFslYqbYFKfJ1wf6YbaS32BGD7GF45sKI0kBgwOLlbq0WI3U96RhjHbhSSqBHyxL2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF6CgdNKRnlSw1ULpc9bBnzhojk2L4uo+bbUUyZPC7M=;
 b=Yf91HgOHzW5R3eFutJqFoifsBqDDurLEXcCluzE0FmEblofJ/Uep1owYMHi3hEJfqGG7w/maonZeUXMeZjFqJ0duDxbxUigcSTl5yspb9ENl9/W32/AWC5aOIS4nCfXy8G9HThCDXS1v26SbGAdEhG88oNjTVx3FzvYi287uBv24pfEuZEtum5VtCv9zHASin1r1WSB3BV2LjPWDB1Sg+Cf55qBT6YADasyNp94cLHtiykGq+e1G2KHD1oakY4qHKKps+xmUfwHD7MSxCFaCoZ/Z+ObaP7YzhJB6ntZI2nfUZvxMYPFtHP3JoXK5+glsuqDqU7Gi4E2g+Dr7/917ZQ==
Received: from SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35)
 by PH3PPF8C903F238.namprd18.prod.outlook.com (2603:10b6:518:1::cb0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 07:47:04 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::3e) by SA9P223CA0030.outlook.office365.com
 (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 07:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:47:03 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 440F24186B51;
 Wed, 26 Aug 2026 00:47:03 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 2/8] hw/arm: Rename ax3000-boards as axiado-boards
Date: Wed, 26 Aug 2026 00:46:28 -0700
Message-Id: <20260826074635.2850931-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH3PPF8C903F238:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1800fb11-3072-413f-8e06-08df03463878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ztWlsUaXMQwLd954aaRdgmPs8NcQR/KAaGGFCGGoNFf1UDGFfUkEX4ASb+uhh6OPsNF8TH43c6AWyymyUDG06ll0pUrPfaMNqG5dHpLlPFpNbo5eyBqg15Y9PTsjnaVwx7YjGmpfsXl832l8Dp/Envi1884TNC3dm7frkcrYgpJ+tDv5SHUWStPHvATVXwewgBYCDdlw7HRPeauX7WFeF5S8TS6rb/Gm5UPMD/6KyrEtscFgrDGGt7BA7ZU9nVcOv0lXr3skGWxjJ4oL/rkv8XGAcF3KSR+BRoPchbE3W5h1rhelxxyw99LDCSfMZdyncyfLr9A3the18BXIedA7EhUD2HW1XZnExpX7Yb/yXAvxdf4VdAj9c5002+8YN9kEPJb29CkYv2fLStS8DD86S1wRfiXvjo0dw1fd4U1SxjuLnbxbArhp4Chn7SMxAkH0jgy92ROrESh16pIoJs7+MMArRwvvs2pjCYVdypv52Mj4YJBkuEsgie4d1PlbsiajiU1NMEiBj1kmooGVJfmNcNPDXEpRqNAbive1oc14LvnBQP9IuBmclFgsdLba3GZI/tYS3YlufLxk1+wmN0yvqasB/8CoPE+AwYisyacOiVRSob8mTyRh9z/LbuhZih5NWDIYpK0eVYLkxdV6W7L5oyYC9FPT4zq3ev7LJ8owRhQPWsZtvaBqHr3DlpchXPxRF1CjkCwcqBQ1PyasBmr63Q==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bY8ZoBZlsCf6jStqg/u0oAjA6/ZsnCeeuRMHzPG0/Qv3lEJE4MtmP/1bjIoMIH9YhbGa2NRp6F9zoy+tVuG9uxOhkkiZPU8NscAIVjLqjstLo0kMU7e9Xtd/bot8Ajb+idrhCKaOX9vQRn50Qcztlrf465+5XMX6NfgUybRJBzslXqy0x7iZxQHnQJ+sKzVBNksFwGQX1bGgUrmixqvz0oa9iswaBUUWHtska8ZFT1SvsTVeQ/7JGoZJgRKzyA6T5URZrojJBzK5PbATuThpop+sIbtev2jebD3LMCh1QN+F1utD3i9vtHdNquBHhERBiWpAtLVzb6SvjWxO2nzg6ZWolJdsmqlzVz7EDt7LvACmaL14uQNyUcffmP5EhlTiI6akIj/Csu33Xos6xBe/14us8p68NIiJCQ241NaWzQhUSfV4chcBL+gRBbSYUVll
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:03.8714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800fb11-3072-413f-8e06-08df03463878
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8C903F238
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Rename header file ax3000-boards.h as axiado-boards.h for sharing across
different Axiado SoC series

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Jack Wang <163wangjack@gmail.com>
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


