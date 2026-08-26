Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2414CC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lx-0005EJ-IV; Wed, 26 Aug 2026 03:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lv-00058p-Od; Wed, 26 Aug 2026 03:47:19 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lu-0001Zd-7L; Wed, 26 Aug 2026 03:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhSyur80sqHd239x7D1geOfflTBoAA+IzqKsBBuh9UZ2qOmwqYIupE3IMHvIcZ5tZk3gN0A7k9eRR6gYAoi+mE8EhVjvKkagqnkUfSjIRX5Qnq+xiVjKD/ooYB+pGftMDOgL4BS8BvLrrHkWXrs3O8g5Q2YLSwiLjRbdlsBKDn5icXSE4WQAWCfZ5my5pviSpCjVxPnMedZ8yPcUtKxhhRGbno0ssFrmL77z6i4+prc9KCVYvu9tdKgcDoMyzdcCMVa7Vkbk3hwmKWP8N8xBkzdeoVVnizm3MubkMEsO2eQpaxPnY37Jrn4MjSfREi38WSC6y39u5aEgcjmtZWTq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7I2FiWY3weEGOLrF4e7gtNQ2u0ENUJfZmmgc/mle48=;
 b=IB1i0ht78XvadRV2Iuih1roMOf/A31+1xFRiXqv6RHTxDLiXA5ddCxN3Z3CreLgaFbqgUCyO+3nQ5yC/NvY4nNQoXbcyUIk4ChLFIDwQxdQvYTqWuJlsqwRf5TiWzL8gj5dGmoTzyqit8UIU4ToYS0/Is15pirsViQxYjuNibYl+azPWtUN+yZGp1dF+/YhXCsdYWTHRPhM010JP5cfjOIQas2V6k4BxU7Mq7YQXllHBoIxwlunKCiKvmvDn1qzs+/ITla8OE0BmMsqCrElIqams0uyqWTraDgBcrtxgWsvIiBQ+TLS/+ZYZrTMt4opGu3EPnpQwAvAg/jNXoP8PaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7I2FiWY3weEGOLrF4e7gtNQ2u0ENUJfZmmgc/mle48=;
 b=mW6/umOPAC2f7e05MtFaTifGO2kxUq4aPE0LHzFnd3z/D3kcjPiIhQM0YH1B+bamZkA/7rubk6ZUkUsoFC8jsudXK6OM+o/FUKEc/5QOVpvAP2TDXyzzQS8BsTnwTDWcDJjjDmuvKDzskkG4yAztaCZ7Vz2cSovpCg5mUb3qg9/3ReSRh7PYy4EvZDuqZ26+5jcYE1bFXWC9HFVNsoa0W0ov9rbfX0DM7czLqD4q8G/TLr3iUbQ5wl+m1Yi6/DjgwsQd/geMc0d4WYZOclCZ7oLBr6IwZwLqYgSmHujV2cwS3d7yIIJn8UxyCeRtktzN2f8ln23dbM1qjshqCnNVYA==
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by SJ4PPF097E5369F.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 07:47:09 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::b) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 07:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:47:08 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5658D4186B51;
 Wed, 26 Aug 2026 00:47:08 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 3/8] hw/arm/ax3000: Specify SoC name in header and variable
Date: Wed, 26 Aug 2026 00:46:29 -0700
Message-Id: <20260826074635.2850931-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ4PPF097E5369F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74b14868-6168-4377-fb6e-08df03463b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EDj06Irn//L5lA926qAuZMqQOsI1SLGsqkBjd9CVCEQmPU7A1RxWV4GiERSXq6N7AzrL8jCu+ObBWvRWw9EXv5O0hgkmc0uj6+FuJBhH1eBdcgdUrJns0P9fu8PH1nyR4wqgjEZv4Psx3S2sdE1CJyhHj8WoTqek4G06iumeYAIMID1fmbm+vsj9kQGKg+B7NHM/7KwaglyqXRcZHoncXgmtuJR+s1oZlckZY4Svnwbdz5/WLWJlqhAMeu1bcS5JNOybf6n1rTqHPEmTMfFN6JssHxrrZl6u9I+8TgWSy602/tnGgLxPdoMuJqtkc0Rx0HI4ZkIJkCx9CUWF0cfa9NTygyXv9lEd+UkVy2P1Tn132T+UXtwTcnpr1lTXco4brik9dw2NtM7WbifwciNuL3UXkVxWCbatGSTqpiiBxJrfdq1MMsrhXH7g0Xk8GInlfaR37f/Mpq24vZ1DLcDkFZRZ7PU8UJRkWgd8KYF/T+CItxL4TdPzyS8ZbkexLzDrfQ7jNEa4hdqyGS4q9QOY+e3XYCdOhPoWU0Rl8V1rDPKZ8qMcCWZiL+fwlr4tgNDcJEf6lmlMzIeyA0oHRCOnR8GA2g6h2qtzhf217UmkgYZO9+PmbvbfYOeXS8SHEcabxXzyfGWsKnJC5JfEVnhN3/sW6pBabaIYP+gsLEWvoYanvdpmqO1HcN5Gq91lSLUo
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jqCwuWGbk4qysG0XnGf4voteZ2vSnfAH9kfViGh6+34z6WtaWJ0o4iD/oiMUPJAMf0YclhG2rDQP8Uq1Pz3BQSE9uOpu26+DuRodMeXJN/qw+HBtl9k0UMFdbK4GELzo3ToYN0owvJPFyhL+9TUqCzEgwOaDxKcO7bGtqnYSiJWh61EFh6qg93kakMeEd1Rh0LfVj/UJAP5AMNIwXOWQuZsURbCTVH2UI3awY8AxsVaaoipxe2Tm1KzRf2viHieRVsXkhx7uDLFEpeU24yjLIpZG3bFQLpS2QFwTwBdjA0hW+e6TL+pkknB5LNsXyUQH6VhW3Ixo9ymHlX8Cl0rlA0UGy5RLsM3sfXg7z1zNV4qj094RQuimxiY6/pP3PmeGqV+Foy6Fp2z+9QXY/6MWRNsl2QAHGBMT/W26yMOebNJyhorJO8SrgW9mMs7rC3QM
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:08.9729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b14868-6168-4377-fb6e-08df03463b83
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF097E5369F
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
index ebe174fb97..a2e0b19732 100644
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
@@ -240,4 +240,4 @@ static const TypeInfo axiado_soc_types[] = {
     }
 };
 
-DEFINE_TYPES(axiado_soc_types)
+DEFINE_TYPES(ax3000_soc_types)
-- 
2.34.1


