Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4988606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rn7VyuQ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvcx-0000cK-GW; Fri, 13 Nov 2026 13:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRvcv-0000c1-3j
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:03:53 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRvct-0002Nu-Be
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:03:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou+rOfvouP9A50YzDLednnLbbawZqs9nq5YuAK4tevbkIKMSZDT36k1HdNk/oi5sPnXrH3cM2sGbaLKEUvvVNDOnWUG5HW5xwKjNa0kY1VdJemmXma3L4mF3nUgwkXPDBsn71YPwHqXvFFbWFg/kUqi+hdA9DGOzLX9A0A/EAD292VGpZ0kEJUIX9ZjyGskHh78aJ64HjHkoNZYbpOn5GePdjeUOZqCkVxKSxQHDkKcB/P/CxkCPLNYGRCwwkpHIF9sRo8dhCYdqI/3eDau/0JfBOv6+KlOwmXyslaR3vhjG5V77fR5C54HfNjT3TxTybSW6Pr4bOgdPDGkEz7t3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O97MDJw9Y2MpMnK5fUwJ7rlrqpUiVl5PXg48Vxhr5HU=;
 b=d+dZ2qMur/zBvs5749rY8mtE2afomeyylsxxdmOX4PfBwbDBjA3gnze3BOGeNeHkQFuuIoKkiq9wWXAz0dhDp1d7MNG5COLYYPRGES7WILf/1xNoaQ073O/zrtrr7Xd0zw+7MXRD3HW8Yoaipi+z38bmVOFhBJOpMkVEw2UQSA7uLf+4CmufZuuKs6s6CXFUnmS7RebL5gsIX0sU2eJ0R10M/mUUcWyRMLYeQmO4pH/BHmV1q8zpRvdLARLyNIOOBWFWy4uHSbzW753g4+NLApEy2UdLIXxJcL3JlrBgDAPuGBieQbhbD17Fn9lzGeq98TJsGVpDGr2SQjh/UXWGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O97MDJw9Y2MpMnK5fUwJ7rlrqpUiVl5PXg48Vxhr5HU=;
 b=Rn7VyuQ3oBE00VEWFzZOuIVn4AbsFCDjsUzTAtL/frf9PGfUzexLql4Rf8E4Dp7dt6VvGFJf0ZjJllEEx0IZdBQPMUsUFS0P8bGl8wLEeXL3FHrUEKMJVSQBUB7CR0wwT2mu7/4heuX9Ummnc/w4DU1Zm7SuvbicY81Qlf5suTk=
Received: from DS7P220CA0123.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::19) by
 CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Fri, 13 Nov 2026 17:49:47 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:25f:cafe::10) by DS7P220CA0123.outlook.office365.com
 (2603:10b6:8:25f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:49:47 +0000
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
 15.21.592.0 via Frontend Transport; Fri, 13 Nov 2026 17:49:47 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:49:44 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 4/4] target/i386: Add EPYC-Turin-v3 Model
Date: Fri, 13 Nov 2026 11:49:26 -0600
Message-ID: <20261113174926.1861-5-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 99916185-cfa9-44b8-8c29-08df41ae820e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: gPUXMbNhw6N4XgsqFiwcKpqOrkRkNpjFHtOFArlwkbFx4Zo0CugUwm7w0KEpwCY5ZJtMLFGR+dohUlQY1/hsC0AgKglkVtbxGq/bq6mAiWuqUXe/QxSeQeY2O/+WYidvKRDg6nDgiyRZcfr4mWGtDyIeM2wHulbA4u/6jg5OjInzSPNPQvNwa/h/IVGSQacFdUt7SdYCieqpENSMSl9v7Jb7FcarXFcuRxYFQjmAO9OV2riNB8QY5K3d4+ttrxAdkelndCVqcAfu6tCxifrwyEzRjZMrMBFOdRqIQnod6mcBw4qnVqs3KhG5TlqcBd6ohKL0GrOSRKcvlsUNggq3euVCnngTzKSaNUrYxzuLrKSw1Z0A7nemJx3Wd966f5eP7/Z6BAnInAylqMKCGo62GOd1mtzbNanzvFaAM1Jxngs4yHkC195ci3jChQalM9eVKPlzc2KeYYCnul5OqMU4tWL06WvhU8NNFSy2yB/msjNFWe1R8aYb6oWb1tLuCf8wwFfvwJyzG1xQ0/B7vX3Vle3GaS8CyRsWdeDk1c0uObbxZpEy/DIiBWoznOHOFr2Hp/d7bzyeMEU5Gw0gRIRpkY7JIwgOCepKxkxQEmLwbV2w1/HYIq4FGatYnwgu0zpWBTXktyZykxfYYHWPoK8Y8Xd76TBKS/VoAcKTLH8Y5QTMLOUnVsch8+am2I3EUqQjK592N47Nf4iHEL/DTmIQ+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P5VUejfNC6gzK7ZYcF/K9OODyHAuu+HS7Nixbdtd8YZRcHtzp+RHNBcJEPVNCLIRheDwvJHiOY/Qw1BL8K4nAPdm1VZVoe0JvNpd3uOT4p0TyY2hWMGmyARqVY2qjB+pB+c2kloxdpNFbF7MT8DC8+xAR/vmPS2vJGQGA/u6W1ILPaJyFCl4UuBoq/PVaF6hf9fGsg7xtMr3SMy8AO/fVFIS2DwmZRPwk1DpWQyupYN/w9gN9666XXsqQpG2Ev8yzAA9yj/T3Cyx5zlzc7Z6LLIbaTjpHevoMGFKLbP6nG+IWBcAx0Wql6MpO/WKzyW78CXZLNufBalQQ4kVcM4er6aHlSOcBuqIoq7qwbGLanzOtUqWCJrtAwrh0oqzm7hbU7o/DLGBUdvQV3s124Ed8Ly2IyqUsGqpldF9oMKQQlzn0IFhAVBRHPOT2fTy3V3B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:49:47.1462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99916185-cfa9-44b8-8c29-08df41ae820e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new version of the EPYC-Turin model with the verw-clear feature
set. This feature is used for TSA attack vector mitigations.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f80dd98d3ebd..c0cf782e8aca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7327,6 +7327,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_turin_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "verw-clear", "on" },
+                    { "model-id",
+                      "AMD EPYC-Turin-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_turin_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.53.0


