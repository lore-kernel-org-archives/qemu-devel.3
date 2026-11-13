Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E7606D860
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y1AaWmcH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvR9-0000Ve-50; Fri, 13 Nov 2026 12:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRvR7-0000UX-DO
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:51:41 -0500
Received: from mail-westcentralusazon11010071.outbound.protection.outlook.com
 ([40.93.198.71] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRvR5-0001Fq-Lh
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:51:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5C6V6l7t3hPwqxzY5qvOG2j9LWzYXMbNPsx91kRlgTV1cD2C3lZxAQW9WcrTG28I/XLuAUjX48QbWq3g3CXMOguhyPLSXZYEp3CdLKTjPMSDBAr7oeFYdry0bs14HJ3FWOHyS3kb5u8Km3r6Nqw7jsLh81jnv2pj3IQUTWh5zbzgQe2a+O3cEwAODv50HlKTJxBKPbeVU+qiCAXyjx3w6koqr+B+r7qFzN1vYij9vIdzuxb8xIpidEm+8aeqRQ4HfuHxP0eMd6kMA/90vZ635kmSripmZMbJsSOGhzNbRnOYn+vpVRuRzhDGEXlW+YZ4TZNR4CVPdx8bD56wPKZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9xoyJOwKcj1HwhsxnWGdXASvtK1toU4eFHuiVcH6Bg=;
 b=r43NknzZCBTE0FMUXLa3uKz8fBegO9jsMYEMqIqW3u+CmkrEAIPoqbbwFLpFWgOCE8f0RRlkKcEgBmcTYG6HVVwfrZBuYa8P29ubAQpItOlfanzB7d+UgcdS77Ipl/0XIDxBJLd1oZBzfhmrBmGxhOFgPN89Ta7x0oQQGd5ToEbd05qwfsglmIu5ru6pOgtEDXmcgZlN9oHmx7iAdk/68hq5w6Gr45p13VAFT+9+wIMAnEZd+24KHSEbQWQdNprpAYhSIY430HjbsoBTHD3SVvuMS5D+mR+Hp8+PaR6JkHsraqzzQd5z6QfnuStJNX+5DSDMxZsd/ihyosnygIHSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9xoyJOwKcj1HwhsxnWGdXASvtK1toU4eFHuiVcH6Bg=;
 b=Y1AaWmcH1xuemDR6b+ufZhYgyxMiIvoESu+T02yWhAnaLILs4ZdqbXFy/iOoC914uPS60mxX6YRTv5r/GBUAzzfgQTbwW3Jzi/09sZO8g+iI22epJuET8NgmJPYLOp6gBxFaspv9q0+xzObk0FFZtsIqnTEHC9Cirx+PzgRAM6M=
Received: from DS7P220CA0124.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::8) by
 PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 17:49:45 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:25f:cafe::2f) by DS7P220CA0124.outlook.office365.com
 (2603:10b6:8:25f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:49:45 +0000
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
 15.21.592.0 via Frontend Transport; Fri, 13 Nov 2026 17:49:44 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:49:43 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 1/4] target/i386: Add TSA variant TSA-FILL
Date: Fri, 13 Nov 2026 11:49:23 -0600
Message-ID: <20261113174926.1861-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b6906c-f630-4af6-0a98-08df41ae80c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: TfVXt2KMT0dyeu5+qYU6HeNklSkGLfH/jOG8kIsnjvmY8lJSZNAZYq8cbMDwVRQ78bdtheQQ3TVN7YoXlWFxNfr7g4XppLR+xoDiEULfwPDiZJBKEaXagg0bOVPKGJmOGbkBLIYot6ciJsjIIMhu37idgNnMeIAOuAS7Sa4ZhRkgUbtpdjwMC7DiyNS8rNI7tk11we/dAP0QRLSgbdk4ZvmJgHE4F4fZtNpTB0ZHChz/Z2JJd8bkHQPRKZVjTMUQuAGJVlYK+Y38xtJQAy8vHC90+/YH+S/Endk/MEMsPRj1DgieOISxVbMlnOxpx+WboceK4VwE90PoOTE4oCue9IAe9p0MNMqJGQ2UUZR2yQlZ61zf70vD2OcmgIejHOujpv9IkONEq1j8V3c3R5FmlOiyL3kUDFhCUmw5nDAmrByJ9s2XoHtsumNEa8wZ2Ta+oE6louiCI5e8YMbbNraUWSUq9E7R+U3+iHsTKlwiaj+udr4HJROXRbAjOajS/lKrUBg9Lvr0bmu95qc+nfWEbtetzg47JfP0p+s/7Kt1UlVg+oc1M/iFk17qAVzEIkfEX2YVUZoli9BcFqllIe1unpdeOCUit6SKKeho4InayN5HQeKcf26yu9OJ8TkX9bHbYgpOnLL/PD5ZC9s1wGsLujbysFBWbPBR18U5gR9uIiYZ4NOdOT6vSAcE2NNgcPP77LYqBOTlV0uMwgmzQfl/tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q0vyBRTrL60sM5DWM96zi8T9f8Ojqysu3ojVgyM7gdZYsBDF3hLJkOHVFGFt+h28QLC8nkd6UCIOYkrJche5aK03BhiJwzgmQJpJV8YMQKJQV/JhtPSzdkZyconpT354ye27OYn+zBvq9dpC/rgj3VQEI9f9KlP/P2OUTOss1E/QWBmOkg7q5oku9xYewlfbxrTT6r1gWTJh/a6b2VWan5o1t9KjwuDo7AiRFMpXujkhcAoTDyiEd364WaWpLh8ELwfTuD+lPazTAjcj3HlmMOFjRUJLErUaGiGdj475EIdqkqFZHyWVG52xQsEaMo2pac6QSkjnlRu9orc5VUjycei2UTmXXbdczk9BSwiVzzPkX3ttUmw4DnPDpmpl1awK2ET0IvfxhzINLIxxIVhzwD2qfJ4DfPn5GFMUUK2OjsDAfO1y8K7/i2fbPsmQVw2u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:49:44.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b6906c-f630-4af6-0a98-08df41ae80c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
Received-SPF: permerror client-ip=40.93.198.71;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Add tsa-fill-no feature bit to cpuid 0x80000021.ECX. This feature bit
indicates that the CPU is not vulnerable to TSA-FILL.

All Zen architectures other than Zen5 (EPYC-Turin) are not susceptible
to TSA-FILL.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d1565..f047fe8a90a7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1453,7 +1453,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "tsa-sq-no", "tsa-l1-no", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "tsa-fill-no",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2fd..fe91a0255b6d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1228,6 +1228,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
 /* CPU is not vulnerable TSA SA-L1 attack */
 #define CPUID_8000_0021_ECX_TSA_L1_NO  (1U << 2)
+/* CPU is not vulnerable TSA FILL attack */
+#define CPUID_8000_0021_ECX_TSA_FILL_NO (1U << 7)
 
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
-- 
2.53.0


