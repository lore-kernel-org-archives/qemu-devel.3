Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE253606A8A3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1sRtsoAy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRw3n-0006Kd-U4; Fri, 13 Nov 2026 13:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRw3G-0006DY-KZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:31:09 -0500
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRw3E-0001zu-Sp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:31:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKYYdpCZVhI4bI9/CjU/dp/LBmHW7n9feDI7ZJ+6ICicDTk8zL827Ihy245WXQJ2VftuCAYWyP2oko/IsLEyEBYjD+JgtwFD+o05VSRySWm5wKXrHh1xKmqJqDS5wmog5BDniTvsqX9mI5XDkLOaNczwedUmKWZ7OxYI6amQjYRurygQSaSL2M7uR29nnhe5zxa60vpAE1J58Q+MiLZaDL1I3C+VQ25LNxNVhWOlr98SQb5zoUcu1t4DfCkWOOhDWp5BqK0MLUuDx1ux4+UdFqhf9430DV2INijshjSHHPSjYFLG9KXGII8ivSfuGGUlK4WmEm43HE7Isi90FEVFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmwFkD6f9Od6Wdw/8JVpfHr1plaEaSfaNHEixEq29J8=;
 b=RTSGSAQgz0o8bLEYwVsCazvL+QggnDmrtVk/QPerkL74oFUIVmEuo0tQBMijeeths2xqF+s0GkbRMVvP2JOVAFq41WCPIXRL2CsOYI8kzB1OTbWLK4SCOJAg/MeAtmHFHUWcQpRP9Mn0iGhU61Z7NyFfzMJEvzqqRHTIH39nLT/eZog4Rtb2eZ9gqrOIglEk4quMCrjWlAXRU0r4TtX+J+QxtDzwMA46F4wMpHlo0E0I+8P2hVRD8YEFbhYfLW0STzU21IdRju6q2C34S4vu0Fawtju9x+eJmR3JCvLXmBM5iDDQRg721A8BMn+aHTvEmXr3395uKGaKlUfuroq2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmwFkD6f9Od6Wdw/8JVpfHr1plaEaSfaNHEixEq29J8=;
 b=1sRtsoAyZBj/OB1pgqtF2sN+3copsvlj5IPJfUQaioTn3afxuuminQhFNrXq8kQxaUOYRDEiXlL8BHVXKB/Jac+heW9H96FNK69ISknSryfZ05Cg2mMIO+ubG7SrLRmtqgC3MOn0IKQwTLDJShRmfSZcek/ou1e84Q4crjq4OzQ=
Received: from DS7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::9) by
 LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:49:46 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:25f:cafe::6c) by DS7P220CA0118.outlook.office365.com
 (2603:10b6:8:25f::9) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.592.0 via Frontend Transport; Fri, 13 Nov 2026 17:49:46 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:49:44 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 3/4] target/i386: Add EPYC-Genoa-v4 Model
Date: Fri, 13 Nov 2026 11:49:25 -0600
Message-ID: <20261113174926.1861-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: b11d9b7d-e9c5-40b7-1903-08df41ae81b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|261021123027099003|261102123227099003|261021121427099003|11063799006|261009223027099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: P+clid+3xeYXs8Db2rNM3YQ88LT654xzaK3Iu5NXHcumTr3KRkhv5zbWY89SYQca3FsdMmctkA6nJGg24RCZ32PXY5yibaElRswyULzzikUGHygBUx+Ec6oTcGkJOrTOpMwNuG+8ZuMPUbPRVgsmxwzZ6/rxIhsY2ddaZB/Il2kZD72r701s0QckeiZcNobQqLHUdA+8wvzgoKdesDuRw4xMXK9/AaI5yFRl7q21M50VxmzqSoZfRIvs/JrJQzvXyML0iumd21B2yscFgdbQzc2H8YjD4hY498ikbUx+9DXec5ESnJ0n8MjeeOb+6SO6YcbmqlLKP80jU7JDHF+/WCKHsrPQ2/hAeC3r9G1DNyXageJ3LvpXB09IVKPGmef9oawnPpJnTtocSz3BYaMXkOMRJPwwvyCyYLwhu9d1Zih46kxOKtb/K1ME+HtPN/zqvcLT418PJyVQFRT6FLWDNsh20QreqVsGdUZFWoFoOEUrduscpeCc4KDQSSfdneouK92ADJaGGVN60q1dznKzIy2kL5DCub8n6gPpgSpzuhTPtqU0t0mNNFUlwM7QCsFcEn7GE6a5u5KEBpgVOwXnP40PZhRhj7B5JRjRDctBf/zAcQhXDEz/Itpx9DZUnlZMvr97aFT1zm09AsjnVx5NmTCPZMhsQo0GOm++8HOrZhlNcg8gzZoqRsXO0n8eudf0x7IEgWlB2YTSqbWaTavx2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(261021123027099003)(261102123227099003)(261021121427099003)(11063799006)(261009223027099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: COVzR7mBWGIh0d/8LFgkB0w0tEKpNvQBSChO99yWpozNycdHV7AxIt7Ph0TQqfav+szqvsWjQYU1Aw7stT6jGwG2SLSKavHgwDfPNhq6hGW+9F//c+wC95HE9hcWZV2XnQDHUxsBD9x/bhM6b++KUx+ep5JXO4rmNucOZ8jQjP0b+expHfMB8s0r+SKF5j/n0fM/UzeHLmkxDgfAFkCOmWZyH9K6EEA847CQmZhvTexjoQyzhcIkCW4n1zDfbkqd+zJgA5AG7F6S9qFDMPoOenpUBCU2o7+8LdvOwwx+sUis+rQ6I3a9415uvUybfEE6YUBjynYe4/jVpsFDZy8E63Z3HTM0aHg1W6sOmMwv3s2og9/v7uGLK8FD+u4r+EeSkoRRmX7rvikUU0I/DKquZkNl+0k1bEh1V2sA7+ixogYgk4EKElPVLktsMGKLJekf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:49:46.5391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11d9b7d-e9c5-40b7-1903-08df41ae81b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new version of the EPYC-Genoa model with the verw-clear feature
set. This feature is used to mitigate the TSA L1, SQ, and FILL
variants.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85745d5f907c..f80dd98d3ebd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7075,6 +7075,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_genoa_v2_cache_info
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "verw-clear", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v4 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.53.0


