Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B003CC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lk-00053Q-71; Wed, 26 Aug 2026 03:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Li-00052h-MM; Wed, 26 Aug 2026 03:47:06 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lh-0001Xw-8Q; Wed, 26 Aug 2026 03:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMa6LltNBopUI+E6NFWdKrVKp+RRT7t9NE14tNgWJj0kWSj9C6NievVS2roEwR5ABZqwXtZ428cCvR98mTeGsLXbvYKKuS/GuevVn0z2yUI0vq9SvCg+2g2ubijbqHl+rZZhjgVJnQj/gZi3zARfOHHYJncqlF8e8DnIi5sKsKr+L8eBmCcfj8PqlnNO1pv2hnF5YL7pniyLt1ikJVL3xIxsS235ysvGSPOm2V7ToCEEbMQX6xg+oHbQRui/dy1xy1IwrGk0OvlV3TgKqY8fu+1fvOm54o2IgkQmyNQtCpRZd8nVN9tmedTRyvW1gf0wZ4WGMC8EviDgS2C64vOMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBVl3jUV9s5J3nBKX6Nr1TOeMnlSeU1YntFb/UMuUoE=;
 b=DstLOHJPCkuKPWebGiC2SwCS+2UUWhC43mK3gv3VAmCkwnYaXjaEL0iyuGd/Dgf6ky2Qrlfz9/lUpVLcHyA2AMprqzZCu5yq1xxijyoXRGALOf1nwALyYPg9OlEik42lzGQk3BtwYhIjJd9yXu1H1MBle14Xi+8XvgCzqYCqHED9xvU+OtVb/yNOw+cIdSObtcaQkjEI5cPzNJe3mFmMc1bNHTNaq0nr7uhbCB286aDbaC5PDnNqGf+foLFITwZH7qRgYa1i/JyxyjdaloGeYOZNEg6glNh6Q4i4rxAqP9bUC++XXOR9lv8DbZvjHNRMY91s8T/t3Dl+yc6o1/TXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBVl3jUV9s5J3nBKX6Nr1TOeMnlSeU1YntFb/UMuUoE=;
 b=tv6FPKPJdhdR857nTy+i9DIPVKMIJi2X48pwEJR71BX9LidK9d79wmLRuO4FHI1PoRFwBHw6qZZyVqLDPvuBlV5WTvafBou09uGJVKcaksri7oowizH5QH9k60OI1aFMoLpW5Kbi5tAcuaC0UXgwxO893N+X+HXIudMUYYEKy1jPF6++p/64o5aULRIDy6VS5rhSbVXMLIDRYVq2B8+90YeVGZNS8hVJmFj+77L+gmUYJN+lPq8iXyxS13w4MUO6gk4ylzgluqQDlqy0pLX7Hi1tRaAkrKUxTaURrjMylNX+nWNZSgezshp58CfrZ5XNeAXKqq9o5qNrGKJshJ19nQ==
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 07:47:00 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::8a) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 07:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:46:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 171DE4186B51;
 Wed, 26 Aug 2026 00:46:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 1/8] hw/sd/axiado_sdhci: Add header guard
Date: Wed, 26 Aug 2026 00:46:27 -0700
Message-Id: <20260826074635.2850931-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|LV8PR18MB6078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d3a6347-38ea-4b97-b677-08df03463616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XSQurTo+cOrmG0hLLrTRScTlB/K/F9AptVoQAHzyapvQ4lkH/SCamMPPjal+AxjA3V8CDA63kyummGj5SAg0si0dXcQSlbu+dPHLNEf+yudiMIq7sJBvJMjV5dPFLKwnAtJ8KCx9pIt0cMba0sh8Hqkd/pX448ZZ9AdAvVjNsCegB1wyUYBgnO/kC12zIjlben5STEwlfmv+Arq5ONFoOYnVEspRwx/Sv/O+Bgio7d5KYJUlkX/q+/Pjhz8rzlyrGM/3vrPTfRhKiLMv1HLJPPgI/DOjjtxdVm4ZPOiSmC7GyEYAw1LTaUkNNeoLt1ym+E4DEl+WSgp59X3zfSbveturm1jZSq8ou4HaFqytEnek1u91nKmzh36FOQNh1i0pMokgScsTXL5XrspThbSRerEKrSJXFMaCfyx84ISNrLoq13v9KKV3/LtXkyORNPZbOOCb2NyR7OYQvVILpvGbrpkQAbZjRsfnK/SsNfRt6uJKQXpnHbJbSsoR7fN7psw2IcuZsTYi+yJ0opyza1ldg6fNomxfEnVk4/2+hPGk72ILnDQ1mnf4ls/SQMwawSEWH8aUOAajR37liGO7snZLH1Yt+3OIRVTMkKMZ7Co4TbhJrf13mEoqyBxCah44cLO9Jb2e2X2yewrDja9BmM4Z2w4caeuf1P14cJGD50e04a5jWIu/EuncI5Mv60yXFOZETyLg8Rz7ev9iJzsKPHYAKg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZKpuqcmXMlK0rHv7qzrYsa4BQAnyag2SynI37c2/xRi6Eoc7cjT2pM2PC8kesYDVkgwPUqo5XyFRTh7bOiXXVMpUFc7H9jBEebgVjCco7F92meMHidwwW7KUTAC6JgluxfOvAkKOmcQw4etLIDfrmo/tBuBDZ1qowpLqxK4l6Vuin525P2lsMapcoYZ0o/FspKCpzJN3W9gEEV+l0IVWCvWmT5U7vHHzpabhlpyDcSNqAYvqDCW5p+aohFxr1udjvDwg6K9O52+bXhj1TfIrGIWpWS/1S/fhrBpn/S3qmAT28LP66HF+P3slN003n4ZGbvyP1ZpW8W7g7BW4YB0y3JfYufkSexMLRZFkZu/krsgeSkZSunt5NJtjSgLo3D3XKjkzfUDIwo6c0zJsKb0PO1ucao/4nAlBWTY/HdadSyUUk0CU8JSU/DhwVGDQK7bX
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:46:59.8193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3a6347-38ea-4b97-b677-08df03463616
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6078
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
Reviewed-by: Jack Wang <163wangjack@gmail.com>
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


