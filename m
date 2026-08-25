Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC6CC5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygeJ-0004ww-1r; Mon, 24 Aug 2026 22:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeH-0004oq-2G; Mon, 24 Aug 2026 22:12:25 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygeF-0005q1-As; Mon, 24 Aug 2026 22:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1q5gmokBzwNSUU2VRSbVVZ8tRzD1bMe88u3lNw1/6He7qh0r2FXXIa3WBYLWUIGQ14YAjDccBQClCVrauomPYlGPSogW6cYWzps5I907vzXlCJ591cgki/dQtweU8EhtkCJYL2iy9P2MCnRMN6WuFQKQi77fu0rGkaZJpwQCKYmAVPseAraz8pPul+9ZCGU7DNCsFo5gRMNr9l0ggYzUQtKDmfLOpwPQ7ICA7vdhDtEJtL44Sn/vIZjXgc2FW7/6z+9TcSLI0jdTrVmhVwn3UpYtWhQBt2dlc/BUCPZWyaNZASyF0JoDQQ0VGAT9ZyA8jw9SOX4SpdjLn0U+yKemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=Khyp7+X6+pKoqLtw7K2XJ4DNmQ6ev/k7WjGZWMAlkaA5q6aU31ce8KjairYRzGIeKpuNxsxI6nT+iqTxW8mIHkHv1zAIQbuGhqlzWhC+ij5AEmc85h44fiGaw3J3QPdXeCh/3UT0WgjflIsaTd7fQ7gFpP5eMRS9pHiNtdVxO3vwnF2KnofNpPVyij2qiJjUyghJ73RJwYssw/qJRG8b+ygkPPG+aGR76ICqWcwNcbjArx4+z178aq1oqJfMCT5Achc/sea+5KSFyY2FT6H/tF6NQzt63GJumAEu1SSpknD5wJ5lcPldimM6+IUpx4CBXNEGTlK+OGGiu25pUINWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2d0f012yVHAJbDUiZoLmK9LJ42PGIPCVlDniv/xbc=;
 b=kFWUGeo6swRiCkhRr8xklIN8nWUjIQnqkgKuO4hTEFOu62l0c/Jj1YsP7JP68CAhK3hiED0WtY4M19jyk2trLLYRpi5Kaf7V7EkZ00X90R7qNjUqvkruajDZhcuM71TAkDyxuu2pjbTkcjk1iskYnZrCxCKOWg0gY6RVm0G0RYR+1d3qO9DLfuF9RRZUTetQFBHoMlY84lEU84GO7nbwZ7dVvQFJlCMLwvjwRTOSluUobVixlpY67yaqCrFWiIjyziXltGCgeY5olyKgWsFWk/N6DnfM6aRlMNcRMYU1O83qvhpmw/UKNDNBzb58aljznhnkvkNbFR1C9rC/5hUs+g==
Received: from CH0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:610:e4::29)
 by SA0PR18MB3598.namprd18.prod.outlook.com (2603:10b6:806:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:12:17 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::7c) by CH0PR03CA0204.outlook.office365.com
 (2603:10b6:610:e4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 02:12:17 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id AEEF34186B5D;
 Mon, 24 Aug 2026 19:12:16 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 163wangjack@gmail.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v3 1/5] hw/sd/axiado_sdhci: Add header guard
Date: Mon, 24 Aug 2026 19:11:51 -0700
Message-Id: <20260825021155.2475879-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825021155.2475879-1-kchiu@axiado.com>
References: <20260825021155.2475879-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA0PR18MB3598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63888754-c2ef-436d-4379-08df024e49a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kw51VCsvu3sY0U4xZOodgY43C3CEFoJz5uvwSvxP/3rz9qvTOSpV3GQqXV2paXd8TsVPW2WHqKcU25U/Ro7MZJ6MFCoLzaqssLeNlTUygUQw+MXY87kFMVtXn0SLX3P9ZMiGu+2if9Ki6QIIheS9xaiVWeSCwtXRhrQZEQYBhH1I80pPTE9P9uEsDFmy5RVKDbAWPLiYdbMNRM7lM/qFcA58dsTs+SfJIz4p4JpvYnEkxcJwKZL5p3T3ohGVCLGtjzg1jzSbBFD0LGxY49eKNZRDS87nqUoqkESkPcVQwW4wjvSzjCCFmTjKW/OBiTn4lOAGNoSfPgd4d40+Uu7c6BwzlFj+a28aMDDlNhl5JTqmBP9eZPGlQSjL+iYELTsjSAtW/2cdhZhfS9pzK3OcQ+waWFOHRA0cJWBbC0yRRE8J8rKddoB7wTz23/CtnSDREWjh8NmNpBVfZHHDlxYBKE+AdGdFkZO+IWl/sEgUldApcMMKItHXuvsY2pH864mAGWTd63DIIkcZr0GwhMSX4FDdGBwRv6AOi1TIvZU8YEo8SNRAymHUvW/llsBv3romz/s3gVvIYIGEtRKXH8CgYPE9AdNy+2AJ7xH0kW6Oq1dY45gduYU+kh27G+3WLwvvYjYkLzOKcni/Oax7tn5YSC8pnBEhPtjnGOr9kxhWnTozOoqboPdo7Jzdkj8zkteKyKBSe2wcXD1QvJQl4GjKHw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0BybEoFETt1koeiYVcn8FIQytAa7f1ENUVJi2F29b1UCz3HNNuTedR25gQO4BlIMyg4gP+/Ab8m75VSGEeajOr5pd4sog/rowlBWJpA84o6VS3TTVACRSPydnrRrRwGSgv+mJzXkuFwz/7r22W0ihLj4BZ724p3XH/pgS7bx1lPZAuS+u2Fo1RxO1YA2E4SAwGP/4bBs+tPtGAAFjbZN8OSquTiJc3shTPgujuW9yehhFchivKdNYY3TKcXPs+3xNo4FLnRRBkwYWw3wkcx4yxk99cw3bajPfw1vY8v5tC2prx6mVPSK2HDkOKM4nDmnlBgSUpCFYmSQwZm8s3YBgkVScCo6N7OJmIQhK4DK+w5sUUcEcSNNig+XcxNC1iCd+gF9oew1FM6DdCvgrN8KKJKpykbZfhOHlGoWiH1HreBtB7YYHfmMxa9MPEJGe6AR
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:12:17.3345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63888754-c2ef-436d-4379-08df024e49a0
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3598
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
 include/hw/sd/axiado_sdhci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
index 85afebad93..ab52eb8185 100644
--- a/include/hw/sd/axiado_sdhci.h
+++ b/include/hw/sd/axiado_sdhci.h
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#ifndef AXIADO_SDHCI_H
+#define AXIADO_SDHCI_H
+
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 
@@ -19,3 +22,5 @@ typedef struct AxiadoSDHCIState {
     MemoryRegion emmc_phy;
     BusState *sd_bus;
 } AxiadoSDHCIState;
+
+#endif /* AXIADO_SDHCI_H */
-- 
2.34.1


