Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8602606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jn6lQGvm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWF0-0005Fc-OS; Thu, 29 Oct 2026 15:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xMWEz-0005FI-9s
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:56:49 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xMWEx-0001VN-Cg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzoEB5whPiZKxS3fryrtEtZ7VzaVe/vLXV1TJLkb0YfaE08Klll0lWK0DzT77PzpEXG3isZBRbdqMACHkfyMFtcZLAs7AoXZ49qptrgrLquB4bKHMxPbdOJ280C9Nd+okXDKuATdeQpnAvX60hdu2o8UE8f2tGIz+p9SoCB/nigsPxX79n+p7aa2Fdp9GNOvkNe1b4oe5Tkt9N7PGnsRSfj1t+6VvHRl79RMk92QKZlxofFHi91BLAX4MfI8OjSJSFLc6zc3unVQdW0tMVPASds/xU5FHHEECaoW87/58D6yqGfSXLvq4K71+1c/mz8tXM1F9gSZLujJyF18TkWvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nTTs2389CZpYD9qLs3aHhULxjDsuKy4+h3GbDFH8OU=;
 b=B9CwYH3/mbgVVeicyiMdpIXpHnu6jzQsg9SYEfTfSC4gIqAxTMVUINm581meboQ3jvr/p8+gFK5dyaHVOrHfunA7yictez3vQWyk77hMsrBLwGjHMTZ1x+x340g/sTdtHV3FiaTZt2KLrtQEhoa2HN8ostAVAvTH4Xrakd7f1XRfNDME7LQWAwJHpvZw6YlbV2rYijcY3DULrzE4xir0PhC9imKF4vBtYFxmQFVNb5ppAeooTQqDoJMjv/ep0j0v98r5WIr+18T/LxyDs+pKZKtcqM6BRnycjFcE+u4F4zKBQlBaI4UvD7hLBxhLl43pZxFK78i1aAZzSaext5i6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nTTs2389CZpYD9qLs3aHhULxjDsuKy4+h3GbDFH8OU=;
 b=Jn6lQGvmABljm6KpLKrW2p3diTVTZfvCaIq9MjTDVz+ElZBQ1cxm0tncWw5gu5fcB5n6yj0M3EPWUnzK+L0ia16d6LmbUHp4AkQtYq9/HvhALIcohgolu1Ipq2ap/kbA+idHh5y0coPaH1Opm7NIsbUqdnSYqQOGVHXIFUhVHtM=
Received: from YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::23)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:56:42 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::4e) by YT4PR01CA0040.outlook.office365.com
 (2603:10b6:b01:fe::23) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:41 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:40 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>, 
 <babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 4/6] i386: Add Bus Lock Detect support
Date: Thu, 29 Oct 2026 14:56:21 -0500
Message-ID: <20261029195623.2209-5-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d0ec97-e675-4cf1-6ea9-08df35f6c090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|3023799007|18002099003|22082099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|10067099003|261021123027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Gh8onByt6XaWtFIS6E3sGQOqPm/89MpqQ87Eq6Xf9JEP/Ka0LU4jIVVDhQRNCSpH+LVTAq6wJ2CbeOyw9px2V7kjMfi+m5n36NuRNV+MY7Te3pu7zIaXtQHEf/nUrwmjCsgs5FDS7QJGKoaJ4Kzi/kBV1BilgHVMDHERJo/k1dk092SA4x0hwgOmqZePWXLTujLJFbdaQOpT6eOZ+Dk5yxNfh7G/0bZHR4PhZpWArQp2gZs1IgIVw4VrLzduEImvjR7Dn0JYx0cAF0JKG/75KleA/urnR2WcKOaYqHpgzU0ndmsBnnInlG292FFLKkatLdB6gd+kLE9D+a+jDGphcFEA160rAg5W9STsB4Ipcq1fItcYjztj/s+lcCzVXCg5VgTHwmI78Mnu3l6bqH50GHR4ACUIpTriptJz3DLz65gMd07WCaGSQPJeh90gvQR6FbQnOgUqTFpl0RXj0g/ozIkYdGTjKYGWN9zDhpjga8ONhGjPZoKy3JORnMfHzdDeR3sEFl4KFC4kb83JSijvqIp/GOz4IQFoXnMzURBRDfE/nBngSw4qSBAlOSNsUx6ZgyS1z0M46Jx0yAZsbA9bv9gDu/huPEabKlO1UgTp+eeyV56stvH8QqHdHGIUbq3+oica2mOgPgjah1hrO1Ryxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003)(261021123027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o9bMOMVTGnVBetP8ighwNThLuhvzsEfnZNcj4kSPQwGynw16Od06NpYu+xtaeVCmnUZzLeyNpCyXQ/woflojOnkXq6Fi+zH7ATi7hj8LeOb+cgx3Zwrj03Z9FaEj0KklWyWv1HAs7h2oIjwDW3kf8gbpSqJ4sZG1/Q6/koWlHzxMsdyM0mGer5voLLossjfLKp3+Dq/q3/Zj/1IBg+sCuEiYL2ypn7eE3hZ+4HcRY6rLPggRsYXsEbrCwPMEBkdVWo3c4ruG/dDn2Fdj6XouapGvfWN/RjxtpQQvsvV2BUW+GhFQNDXjZ3YHccDRcmR6fKT6WokgG2lVwUigWJmbEgobIUd6u3KGgjByBN6u25zlNMgme9O5Gp5FCx5/mCEYs4uE23f/9r4aKAt53kGdhkps+ficQ+ianZb1i0x4JfY1FlnGs3kIhj1WCAQpnpJF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:41.8382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d0ec97-e675-4cf1-6ea9-08df35f6c090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

From: Ravi Bangoria <ravi.bangoria@amd.com>

Bus Lock Detect is enumerated with cpuid Fn0000_0007_ECX_x0
bit [24 / BUSLOCKTRAP]. It can be enabled through MSR_IA32_DEBUGCTLMSR.
When enabled, hardware clears DR6[11] and raises a #DB exception on
occurrence of Bus Lock if CPL > 0. More detail about the feature can be
found in AMD APM[1].

Qemu supports remote debugging through host gdb (the "gdbstub" facility)
where some of the remote debugging features like instruction and data
breakpoints relies on the same hardware infrastructure (#DB, DR6 etc.)
that Bus Lock Detect also uses. Instead of handling internally, KVM
forwards #DB to Qemu when remote debugging is ON and #DB is being
intercepted. It's Qemu's responsibility to re-inject the exception to
guest when some of the exception source bits (in DR6) are not being
handled by Qemu remote debug handler. Bus Lock Detect is one such case.

[1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
     2023, Vol 2, 13.1.3.6 Bus Lock Trap
     https://bugzilla.kernel.org/attachment.cgi?id=304653

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

This patch was originally submitted by Shivansh as part of a separate
set:

https://lore.kernel.org/kvm/20251121083452.429261-5-shivansh.dhiman@amd.com/#t

I've included it here at his request since it goes with the Turin model
update.

---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/kvm.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b7d135d610d6..137b754b4ebb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -300,6 +300,7 @@ typedef enum X86Seg {
                 | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_CET_MASK \
                 | CR4_PKS_MASK | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
 
+#define DR6_BLD         (1 << 11)
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
 #define DR6_BT          (1 << 15)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..7e410dd9a47d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6279,14 +6279,14 @@ static int kvm_handle_debug(X86CPU *cpu,
     } else if (kvm_find_sw_breakpoint(cs, arch_info->pc)) {
         ret = EXCP_DEBUG;
     }
-    if (ret == 0) {
+    if (ret == 0 || !(arch_info->dr6 & DR6_BLD)) {
         cpu_synchronize_state(cs);
         assert(env->exception_nr == -1);
 
         /* pass to guest */
         kvm_queue_exception(env, arch_info->exception,
                             arch_info->exception == EXCP01_DB,
-                            arch_info->dr6);
+                            ret == 0 ? arch_info->dr6 ^ DR6_BLD : DR6_BLD);
         env->has_error_code = 0;
     }
 
-- 
2.53.0


