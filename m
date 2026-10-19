Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AA606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wqoW0r9U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xItkA-0005Yc-OZ; Mon, 19 Oct 2026 16:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1xItk8-0005YM-UB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:14:00 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivansh.Dhiman@amd.com>)
 id 1xItk6-0008Dp-Iz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:14:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oITi5iynJ5/qxlfmMGXk0RMrHWrD9hUOhP4OW4T6hbpN30HOwunHagoxRuK1Ti07BuDYuIemoc+MDWFBOD8SjWbdPws8e3uNzV71VzcqTwc8bRJeuuUkG7U7k+lm9eSjJ+ZKrNQNkHxI3h0mkVX8rA/FaX7OcxR+X+tKWp6eY9f/AIaQqFK2hoNSt45kFhZGcuAMpo45z5JljeJANQzcHrkZ7Wz/iSLIO9K1dMiT6CsUqNzyglz04Y0Pj5a1JpXRI3phQSq7j/waDp5jUbjpUoq/Bvc0QyRihgJKeuYL+IZWPkvHH+FIUmEq8WK8h1FxaPbkKDCIncZ27N6EqZUpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFLAUO5wRz8W7BWT838Cyx0y9jjPkSt5KGupEr5N/jM=;
 b=RfEDeHra60z1AOVKdi/+8KT2QTh3EW1Ph+fHMjF8UUpskI5wcGgMkIdEtXT+NNPvCJb1AON+HejHEP0OGh6CPbZLKbgDSXfOfI26WHvilngyrSblmv4pbyc6u0WP9IaVdtoem8+ZnEK3nN2B/TywEof9ZKJlot/qycz1ogGeCrjHarMVjHezh0ZWNK4uslN2APQTJ7NPvLSBb0ypoKUwWnN7r/+noIsb3EAWc9nQ6gmz/Sf0Cs/5uTKqTIOLc9bY54Yf59MyYA+6nRyTfuh1GTxvSLRoBmlx39zb2eE53WEtwf+EWgZ1cVgkpz8QHVl4eh582N4X7zODLdpcLvX2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFLAUO5wRz8W7BWT838Cyx0y9jjPkSt5KGupEr5N/jM=;
 b=wqoW0r9USUxj0LfA5ZPPwwwZWRIZpE0eYYQXeHQJPWbCfLa+5xHhf6Jnn5x0CPIF2VoqcfolH8S/7lm78ADx0n2/4x0JQU+qjsln4nxj08d4gS5NF1yDTHSRXcQHTowKC4hDPiGY0QfcSmUgRGJ/wWvyO853rle6SyF2kJnsbVw=
Received: from DSSP221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::16) by
 DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 20:13:51 +0000
Received: from CY5PEPF00000E7B.namprd02.prod.outlook.com
 (2603:10b6:8:3d5:cafe::e) by DSSP221CA0004.outlook.office365.com
 (2603:10b6:8:3d5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:13:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E7B.mail.protection.outlook.com (10.167.247.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:13:50 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:13:49 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <yosry@kernel.org>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
 <shivansh.dhiman@amd.com>
Subject: [PATCH v2 1/4] target/i386: Add MSR access interface for AMD LbrExtV2
Date: Mon, 19 Oct 2026 20:13:10 +0000
Message-ID: <20261019201314.269798-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019201314.269798-1-shivansh.dhiman@amd.com>
References: <20261019201314.269798-1-shivansh.dhiman@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7B:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d59823-ed9f-4756-f905-08df2e1d7dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: MAWOuyMGnGg/C6UARM42M5zVn4+pApn/Xlnvpz1ySHuwBJoGWxdSky6z9NVgB4ot1I/BwmOVovwq6VtHlnBYfTlYXwV5hPX2yryMyHBxuCm3bD6O2vklO14jM4sFQiybAjhH77nQCAw1Eu1OhP40Y2O/lH7v39mdtLKqsiQkZgabbV880fCTfaoM6zx7laux4V61wMqbXgOty6IqdNFVjI2NrxUV2bAxzrzxVyS+/T4UyR4lXGXMehwmjUCeHhJ1tYaqNTCDYMp8MpxyoKYyG/oO+MFeHyyFLApO/83r33HtfykshjKxlf0TMnrkp0W+xrQ7B6suPfCNNUsAOzjvnA+qk7pSibXMSmWoCiouGIMVObtVX1o9hiuCTvuNGOZTGfKM1M+7w2T+N4gJIhJ0NXsF0v/KSJH3tqKb0ZNOjfXyKDTbX7dJLXq9T4Vd/Axw947fGaBCLNufQJ20zomN/ZoDvG1NZW057x+acTEbEr92LvzWgUQ2lmd6W7ymcb2oEPblf/vjcS7m6XPrb5vtuKRGRUK59mkx14M0lyUDPg1LfNzrnEnAVwaOVjR9FUPrEi28MWnklo+Syv+ZaBmX3hKl2Eo0Qof5FQmuqRi0+24sV8NYdW13Q2VXP+3pIPUzGEWHyKWJfWtX4ez5LJlwep96aNGcyCI4m0LvuAsp9TGvisLecTQu5fMnbqBlNGp5+KSRAPc5oV+LObeeO11Tfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e5cy6jIY592tRpMKVL7bHoVZUz4IxWROH+yzWM9d3QO+mll6KprRiRrUZrvyEO4w5bP8NfDddbM3lfZriSOjTrQVpy1Kj16WTEN391pj/p96NIE0Zzs6Uy5IpQ3XvpRn/BJe2nHjolaS1I3QFElbheUHznpy6WvgF21I28ZLoq5ASXvLJdukAlCWTKZjw7gPJgLAQa0SsnzvcZsdkY6/HHYQsgLTpTpb2LQgZnRSmUktfOovT0sDuTvEkOWkIGE4k24VPoiFHK1BAqvOJtoXrokEUwzJEJPKxxbagXxtNY2my0LyaCJ3/aIWto5kbp+SOdzpMsf5J7h80GsFfL9ufBsLSW9pWfkWgd9C0v3T/kCOb6FzzZqOrZYcGNcoQ9bZtxCngKdN/rqPkAlLQYw85yNj1SqoAti/ncLY7UHGCO6T1BMT7jWCwjdTDYTakyWN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:13:50.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d59823-ed9f-4756-f905-08df2e1d7dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E7B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Shivansh.Dhiman@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read and write the LbrExtV2 MSRs with KVM_GET_MSRS and KVM_SET_MSRS.
These MSRs are the Debug Extension Control MSR, the Last Branch Stack
Select MSR and the 32 MSRs of the 16-entry LBR stack. Do this only when
KVM is enabled, the vCPU has a PMU and LbrExtV2 is set.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.

---
 target/i386/cpu.h     | 12 ++++++++++++
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d87..59bc1c46e243 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -566,10 +566,16 @@ typedef enum X86Seg {
 
 #define MSR_AMD64_TSC_RATIO_DEFAULT     0x100000000ULL
 
+#define MSR_AMD64_LBR_SELECT            0xc000010e
+#define MSR_AMD_DBG_EXTN_CFG            0xc000010f
+
 #define MSR_K7_HWCR                     0xc0010015
 
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+#define MSR_AMD_SAMP_BR_FROM            0xc0010300
+#define AMD_LBR_V2_NR_ENTRIES           16
+
 #define MSR_IA32_XFD                    0x000001c4
 #define MSR_IA32_XFD_ERR                0x000001c5
 
@@ -1224,6 +1230,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+#define CPUID_8000_0022_EAX_LBREXT_V2   (1U << 1)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
@@ -2176,6 +2183,11 @@ typedef struct CPUArchState {
     uint64_t msr_lbr_depth;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 
+    /* Per-VCPU AMD LbrExtV2 MSRs */
+    uint64_t msr_amd_dbg_extn_cfg;
+    uint64_t msr_amd_lbr_select;
+    uint64_t msr_amd_lbr_stack[AMD_LBR_V2_NR_ENTRIES * 2];
+
     /* AMD MSRC001_0015 Hardware Configuration */
     uint64_t msr_hwcr;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..944359e5c5d9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4517,6 +4517,19 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] &
+             CPUID_8000_0022_EAX_LBREXT_V2)) {
+            kvm_msr_entry_add(cpu, MSR_AMD_DBG_EXTN_CFG,
+                              env->msr_amd_dbg_extn_cfg);
+            kvm_msr_entry_add(cpu, MSR_AMD64_LBR_SELECT,
+                              env->msr_amd_lbr_select);
+            for (i = 0; i < AMD_LBR_V2_NR_ENTRIES * 2; i++) {
+                kvm_msr_entry_add(cpu, MSR_AMD_SAMP_BR_FROM + i,
+                                  env->msr_amd_lbr_stack[i]);
+            }
+        }
+
         /* Note: MSR_IA32_FEATURE_CONTROL is written separately, see
          *       kvm_put_msr_feature_control. */
     }
@@ -5017,6 +5030,15 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (kvm_enabled() && cpu->enable_pmu &&
+        (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBREXT_V2)) {
+        kvm_msr_entry_add(cpu, MSR_AMD_DBG_EXTN_CFG, 0);
+        kvm_msr_entry_add(cpu, MSR_AMD64_LBR_SELECT, 0);
+        for (i = 0; i < AMD_LBR_V2_NR_ENTRIES * 2; i++) {
+            kvm_msr_entry_add(cpu, MSR_AMD_SAMP_BR_FROM + i, 0);
+        }
+    }
+
     if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK ||
         env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
         kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
@@ -5400,6 +5422,15 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_AMD_DBG_EXTN_CFG:
+            env->msr_amd_dbg_extn_cfg = msrs[i].data;
+            break;
+        case MSR_AMD64_LBR_SELECT:
+            env->msr_amd_lbr_select = msrs[i].data;
+            break;
+        case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
+            env->msr_amd_lbr_stack[index - MSR_AMD_SAMP_BR_FROM] = msrs[i].data;
+            break;
         case MSR_IA32_U_CET:
             env->u_cet = msrs[i].data;
             break;
-- 
2.43.0


