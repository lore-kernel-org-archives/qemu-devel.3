Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A3606ADA3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cLZ+N0lz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRw2H-0005MF-B0; Fri, 13 Nov 2026 13:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRw29-0005HM-9l
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:29:58 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRw27-0001Ks-3M
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:29:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRjN0Y8XYg8oehouv2l9pGbJs1EYPq0p6RiKPe3yLpAQoR9fJnmLW2zplL2xTzapzsyD2l54LjSPrYpJO5pd2uQt+e9PtUWxCB9RIBlMG8GIESg9y6BUYJHD4VTAGV5XioJPk58fAN46jn58ANlXwA09+X2woaFqDdEB5nJ6xEMbs4+d55JjtjQcZorTZ4vbA/hUxI7HmSKSRATs5m1VbB3LhdReWMGaNJM//zxYEGIBMpDMbCqRQ2QvUCG7Q1fp+xfFeQmI6ebU2pgQ5rUNfXe9EiEBBotmcqrPftoZJMEE9xeOmFs2bNkCTc0FeAGMa5vWpzJx8IXOUy+RH3ZWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X52gF56imuOldEtUZ6+djMwF9L2IJxj/rP8OETEF9FM=;
 b=HhqeD+iNgoommymevegUZm1jyIJrrHNHHlAGnDe6/hI/sfU+wdkW0VIj58EcftI4zNNK1mCHp8UmTB9PoMLlpoVlzt4UX9eWhVvpSo2v02g2RE6REtlbmtFeJc8a2kpx8ZUzRfbfERO8Xs4gL1FjFfhWv2+R18OQlJUBRTZE/fK2KH1z1vqFnm1ZOqgIg+ZXDrS6UL/4hgFaiKxTfusGz0tFlotsKipMFTToODtpd/irgMaFuAczohBfSbMZA93BXX/AnF5XmpMoSQMWtflL9LV2fYX95JL8iir7IzUd5HKcdtrsNpKvBwWWHD9sGJfBvO3dQ1dgaACoOcJDpO6TrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X52gF56imuOldEtUZ6+djMwF9L2IJxj/rP8OETEF9FM=;
 b=cLZ+N0lzhwb+8IeTxzYTEZ3X/MUXfynLrYln5vn4VP78ev04HLod4QAu+AvvQh6n3MBceXCXbCM9SZTW2mMuw+olxUv1R36FwTFEmTBB2jTJUe6c5yDXmC24nvZIJ7wrC3K1QM8OkcgAnwINklcasrNkOT6fd681tvIys7jkWk4=
Received: from DS7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::15) by
 PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:49:46 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:25f:cafe::74) by DS7P220CA0113.outlook.office365.com
 (2603:10b6:8:25f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:49:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Fri, 13 Nov 2026 17:49:45 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:49:44 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 2/4] target/i386: Add EPYC-Milan-v5 Model
Date: Fri, 13 Nov 2026 11:49:24 -0600
Message-ID: <20261113174926.1861-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113174926.1861-1-Benjamin.Cheatham@amd.com>
References: <20261113174926.1861-1-Benjamin.Cheatham@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb28c4b-6bd3-4e37-6938-08df41ae8153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|11063799006|261021121427099003|56012099006|261021123027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YsGLADTZyUu0QzPUe9IcHbtTcMNopOOl63PErGReSMSOJ0mcyhMNUlWf9cv8E5C5kL7OQkdnG80EnCJkktpo3cxh2wJ/+5VMnOPmIxsF4QRijI4cpi2AsCBDbwSjhEexA43uUI21GlaLQkvm9ASjl7vkTOJmTqwDfuSlL+YxGBS6V4paPxZdGffvsvDoos1PjC9IHuR4cyujrZiHKU/82Na3eyQ6NNwaq7tTMTbywVw1mWCtncFnvZB6PZdrlENT5KD5kJwWpKhodZ0Ugw8nFRiMF3aXxHriiYcChUCfLDYXLRQSc0uRPAgvYel4sW9FclOVkx2BMjX8++U2Wc2WQpM5+37yFpu6kQmeenvYV+4e2kzM33zKZ3kPDpeYmBGEBy+N+K2hoDnz8Cfy3HaPyTBKTCXfDVVES8QIMbr3kNIhDCJ17N8rHQXrNaP61B/pxour3Gq0kbdCNf6HZe2qrSzM5kaml+tG8EbPR54Pi5zbc03KUUqUBudHF7Vc8xAU3GpfotLA/RqGrT/SEHJHVCwp9ymIDuY0GzhACFDos3VH39PDy/SjZDFoo8u6daSWj5MgwA4q4yb3O6EhkltrUN/O030ozTBK+OTvUhANuj5/wsdHV5fskkcHNIfZTYUqmjIAjPLm1c6BNeWRJegbiDTzyWV6DO4BRvWSC6EGQqR8zzAhXeLLvf3jhxI9XWVJCZFjD0n5qywyheX73B0z5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wq82SVxENDZhW6h06STRpr3JqJII6rNzAZ9SiRr2Un+exnKHZOvphgPYjtZ7X4lYMnmU28G0SWELitTJddYpVURXzhUbleZsfJGywo1eCc05HM8zpLcSIrm33gtWfCj8Z8UPSYeeUvN2Ag61sxwDhnO0luY0RPTnz8dxTfhZzhsdp+3dfvPDVBZpaSPcZiNVW5FJVDVZcpXJF+DfAIOr5McowPRmEnv329wrEH9fwxbi6uRjM+XG75pjC1DIJ7hqe4Hlprwdh3OWrwOpACFv+VJuxh+geXji4HWH6Qod3XNZ4f+h3b96sZ8BxyUlyGsK+YcwmsZmvTRP+5pPZLeILj4BUFWEFP14wq7G0Hl8B97Cb6hcvpft6N2d3qnBVgPaH5R7zwwj8QSD0jBzJqCYhYMmzy5/QK/9sumEyJKJjXKryWADbfoSz4O7pfEJyN/a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:49:45.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb28c4b-6bd3-4e37-6938-08df41ae8153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new version of the EPYC-Milan model with the verw-clear
feature set. This feature is used to mitigate the TSA L1, SQ,
and FILL variants.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f047fe8a90a7..85745d5f907c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6958,6 +6958,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v3_cache_info
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "verw-clear", "on" },
+                    { "model-id",
+                      "AMD EPYC-Milan-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v3_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.53.0


