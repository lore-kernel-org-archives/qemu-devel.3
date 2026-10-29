Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=O+JxBqp/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWEy-0005Ex-HH; Thu, 29 Oct 2026 15:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xMWEx-0005El-HN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:56:47 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xMWEu-0001V3-W7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI3hv3XYPzBi8jlqpTvjq53vm10hAM7rDfhN14ZzGtYSASz8b3GChXLnaQe97vfUSaEYC6ZCzLmm4dobksfXOPWc3EQ+1pxvoYGHTZ2cSjDajn7t7Ta+f3CJDGaGPsHMaRYxm015ipsT2u7SlxJMS/ysNJhvSAyKiGW6+vSQ0KKsSIplAkCe636N1CxXiAG8IGcze3Oyz2JzTHcF9J9BhEdmVRWC2zsczoMrL+o/Xcj50o5M94CXDVTFTpPTa0D2y+H+2uxIfGV66/45G8j4ioapLEz0jFtTSS86z72QtzIlQ6vEGtxgibpWLx/hZ/3OohRULLEBNFb/vbhk3Kc5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2ldarsBw2XGjtQ8UZ4f9L17A0+l0McgtJO67Cr5/IE=;
 b=xHThpL0UKAOo+SiwOoF2RBdp+wsgIVSu5v9Ax8Kwh609cW8qNN4U9cXY4f2yupGRvGD2I38iwh0sVzdv1dTtOh/AQWIr0Xy7GkTA/sVKLsiasXFhhaJmz5WmM0/67bUW476In9LNHMvjk0SSCDDGKfVSa9Vj3kn9vT7x/7pGWneC1qv0IMAWt7MJU8oZ2YHjrESvhLS/n6aED0Ginn0Sd24WDbI0Cc2QFxj1BwhU8g+/EI2ABmA2eYeEY5PtDU0/WG++1F82CV8ymSnwSEgKgxsnoN+xgzp6bUy5qKXv5JuR8shNX/JMnTLjScZXvaueqXiWg44m7BP3qhro+1yrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2ldarsBw2XGjtQ8UZ4f9L17A0+l0McgtJO67Cr5/IE=;
 b=O+JxBqp/GWLA9G4WzIk7Ek065KPLC3xJnhagnyKM9ZJVWyQAjjImqWZOC5GIis5/z0ic0klu30+jG6tmsJqKI4FYGUy2gUS2WUlWpvgPm5bl0pEMk9xpT/fyK0li94CbgecpwlvkSiEcaT1ihhPjM4iZQaiJpdRd1QS97sQiosA=
Received: from YT4PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::25)
 by SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 19:56:41 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::6f) by YT4PR01CA0043.outlook.office365.com
 (2603:10b6:b01:fe::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:40 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:39 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>, 
 <babu.moger@amd.com>, Amit Shah <amit.shah@amd.com>, Ben Cheatham
 <Benjamin.Cheatham@amd.com>
Subject: [PATCH 3/6] target/i386: Add getting RAPSIZE for ERAPS enabled guests
Date: Thu, 29 Oct 2026 14:56:20 -0500
Message-ID: <20261029195623.2209-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f3f91e-ea71-40ec-42fb-08df35f6c006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|261026121527099003|11063799006|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Xq2mwqJ2uwH+ma9ewHopKIazFBgPvfTqo8S1QA0kE9l9Snsj9/yB2UQ8xWTeBI8abfuEVm8jtT4BKThDfeaOsh0EaIMg5yC1CTScMySh/O5JIxu5tzfPU+pLm9Daj9WsScU0i5xS4I+d6PCK2ppfTSHgPgAoheSUXzIc9m8Iew/x706T/N+PBIFtsDHi5XhL2+R0Dl0vkq9OuO231ZXgw4H5NgVkU4s3oEA32jp48KpcMKFc9sm3w0+rA74+Hm/TOWiaWQhxdi9IXwhvKKv3yaPuOA2zLHSt7VqQEqHI8MaxUdaWKoBG2Ewbq9U2jN4ulMhleouZtZ9t6kqsqDHeeb+l1L217GKv8igxpce+GPAnsvsJBttLbIhDcf0CtTvMqn+A//MgyeWhVolNSa1+rh/D2NJeB7d2v9KGRccqnbRlbs1V45azijMGVwWDnmiPpz7U94MNyIUPWpDRfiMGgJRRJHuAKZS3AUldFgSml79GGEpxDajvFkNBmxC+v1fzyw5OOJbZpxhsDDc+IxgTbk/PfO8DLHxkhwdFbcgrwelyw9TlKQAPpE62rABiFgrlMEIHL6wXutlrMniJDHbvH3DHt9KT9E0Z4+t2nMfZippN8LxJK96JGSSiBYSryK5WWWgkcH3urH60cigwMaah6cHEM3xGGOJqRjlLSOJ5LsscReQBuKkIkk5lwp9sQlwFVtGPlMoYj7EUwt8kMBkqgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(261026121527099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M7VdfFK/wyTgLaVz2+dRYc1VgYKqLTKOcplH64oPD15Jgw/FsQmIgiUp0MaoEEdeOm2bN3ch3PmkymQJsDk5cCxTYfjDVXKZLSTe0OwChyxmN3+q2OVs1rEWlnEMnkt/r3jsPLwoLF24aUWnfb/IB5ZylOdHYvVhc9hzKI1nJkKyeIDLEj1Weber/1qZLOLFvs8sS5zlIqFzu6fGOMK/qsUof+/Pw4iR0IikeoHaszKgrvvwop5PrryxbynMZP2aFqi2rBzqrHzkui9lpAUWKsz/BcfXDEwbvgmONxfh8WZknwpToHv9NGeikmvwE/fc0gaxZyaGD7qg+2GKJfo8V7I2u8dsx787OfEBnu03SIjIZ4z49YM5TmtifdAqViqk/FGK065+fLUNPAuNRCdd98IwiTHDBX4u7XY7Xnsjrtfa3xg7KmK95S6CX/+E6fF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:40.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f3f91e-ea71-40ec-42fb-08df35f6c006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Amit Shah <amit.shah@amd.com>

Newer AMD CPUs have the ERAPS (Enhanced Return Address Predictor
Security) cpuid bit. When this bit is available, the size of the RSB is
indicated in EBX bits 16:23 of the same function. Allow the guest to use
these features when kvm is enabled and are available on the host.

Documentation for the ERAPS feature may be found in the AMD64
Architecture Programmer's Manual (APM) Volume 2, Rev 3.45, July 2026,
section 15.37.2 "ERAPS Virtualization", available here:

Link: https://docs.amd.com/v/u/en-US/24593_3.45_APM_Vol2_PUB

Signed-off-by: Amit Shah <amit.shah@amd.com>
Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ece2e8b279f..8805657f01de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9300,7 +9300,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000021:
         *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = env->features[FEAT_8000_0021_EBX];
+
+        if (kvm_enabled() && (*eax & CPUID_8000_0021_EAX_ERAPS)) {
+            *ebx |=
+              kvm_arch_get_supported_cpuid(cs->kvm_state, index, count, R_EBX) &
+              CPUID_8000_0021_EBX_RAPSIZE;
+        }
+
         *ecx = env->features[FEAT_8000_0021_ECX];
         break;
     case 0x80000022:
-- 
2.53.0


