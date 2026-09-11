Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A7FC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53Br-0008At-58; Fri, 11 Sep 2026 11:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bn-00088v-RJ; Fri, 11 Sep 2026 11:29:20 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bm-0007Dp-8t; Fri, 11 Sep 2026 11:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMP2DF0NH6ztr6hr50fMg4uVRLNIZtIraonMoIenqAqV0Mchh6JrPBfn7Ggdre7qyj8Yu5xdo+NHAi4PQO3GvhgJNuazfCExiVNJsgjgUrdSNX3kSGkhpbFTYDIMN6rli6fzd/KJX3E/CFDaDewxo65FyZvxMg+mIL68GDnmp82LJKqM9PbDSr/j9sZT+KdckV3v64WylG8ul/LfHN3lz/YrqNjM/vQ9sNq6B2icxD718Cc4YUgZ0ktAASITxu62P2akWF8OrMnB6pmULUMH4Vu4MFL0g8M0j2sorivEGYKrMNF0XOfNXOXWRym4udfmvLSxLx6XFUKP8Qw884UClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvZxcy+P3zf8eA8CsA362mwDWTLtY9pDNm6r6agnuOE=;
 b=B/NhG+I8gW/9t61bisYDlEAdZfl2chwRTc44CPaVmzGk8az5D/3ZxYjrO711APSswoNCKz0PGVIklGswZd9BRa4/muTqsVP492uat1z+0MEmIp7DBL5YKZ2mu+jSO7m04qyMDOqXBIpOKMRgPVC5pL2V1tmWfJcmdLPOMUC9Zgk/gdfGMc4cfQZmEgeY7CVbt/OUWqOJCs3yYsT9XbnNrwqpj1HFIc1BHgiYECWH49QujirQxTL91jaBIjoHH1slj0S3TLIJqbKGEfKivAQYv/moTQhTXWTWE0ByIGQYYm37Kky1Sx31iAbHsiC/6ZRqq4VG9jQDKCSeRoSQ9AN0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvZxcy+P3zf8eA8CsA362mwDWTLtY9pDNm6r6agnuOE=;
 b=eupR3+tHemL7VlV4n3LOHJ9YJfKvXnBIBJsM00ca/YiLUqLIsKjJIgK50FMIhz5HeE384UXFcVFaNUcX8zjbwi8izv8wWYRpd50is0sFF3rUCVBmqbIA5Ad1zzg+4FMxcJJ+s4eA88PosLZyP/mVv6l2OwfjhGQRZS8LxOg9p9xLhSR/GWjEhmiKpG4JWL+5BTBgbNjfhbWS7/qw5hcx2y6hU6vOxEOQBnmqq1JWWTIJdAv1pZ/Jzi958MyPQz/PglQUO9T4oQ9nyYSnDmqZ0QKp+gCeErE/Ry5Tg1LwOAU0/2okauyV6J4NaymkpwFwSSSQfEKwV2yZBKxUsD5rKw==
Received: from SN7PR04CA0187.namprd04.prod.outlook.com (2603:10b6:806:126::12)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 15:29:13 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::54) by SN7PR04CA0187.outlook.office365.com
 (2603:10b6:806:126::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:29:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 2/5] target/arm/kvm: Introduce helper to check target
 impl CPU support
Date: Fri, 11 Sep 2026 16:27:51 +0100
Message-ID: <20260911152754.706518-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911152754.706518-1-skolothumtho@nvidia.com>
References: <20260911152754.706518-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 311f9cf1-8456-4833-7b0a-08df10196ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 1U4OxuqXM70BngHnvyVwcQhIkPfrkvKxCNFcagk8ConbqwYt0gVS71EN8uYVNcYv2GEta3JGc89wtFxbJJDWkZQWMhzZCKcCwQHK6blQfXjKiHATJtyP8tZnERVe4n2iFJex+43BwZ4gupd0Mc78lP8hf/ksakEq85ZGmNaPyX+/aN/morc8/UgFNnfbLVTwpuyKP5A7JphQpPBQOi92D9yf3YxtSDcafzh9fUnu/mN96FYaBRKSq4PWl9p0fWbP6AgHYZAo4vsMul8rPq6zOh+OhVijeLYNnNFPAln7scwCXlUb6Q2uZZV2L4LPgdoDbyFyH7l3RbroyQpnya9Kut+O49CCATk45q1h6nN84G47BvQKs/ZS+pUmMOxwYLdCfGkd6CClJV13WoweYUpMXfLnxH9wo97x7Lwu90NaEtUu3u7Ij5cpvMR9cH3ExQb/aUEySjaKmCvCG+/0hVLvyhLqYEzqVZbbCKAJ/wuQD8ZU43qEn3KjCS4PpvSRapWkWXb60z2F3CL0h9tZ9KrwXvDO7R2DSit0hbyoRIKw8eWwCnSURXwo5wbNveaXJ9zsmCjsze5qXhq119mfDO9HWmLbzfyImPEzdgs4l3Lwj9OB7d6RJzb0INvcwjhj/+8q5Lq9fvHq4OyYcjDk/Kk/KbMxlyh1w7c8wKr/5pMbJMonXMGsO07qDdtqTRrQyB0NoWsgqYt7T/A7BLa0+lBEuA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNXUwQdKO9pFOV6rgoFgu0iStVlJa5QQOUXsJknOjTzUiUZYdBF4frFNGe2ZUgVm9QXtdFWe8XSC4is6miG0Yq9RbT9GCuy5K89k8XRjMRNA4Yj4383tgKN6b7QJ+EhxrPHpBHYaz5s6ZHYsVbcgjbmxupPCLdwZeRCNb1k4Iz85UbhIBYCanZKUIgmpaAZshCAm13ILDggQKhh1Lpqd/X3JbHLjsod3dwOMa6bsU/AgImWjV8EMlc7JKcYxdrRaiORf1UB4VD0QUeFVa7z+IkdGK/3K+ebJeOycicAvECHPcgFyNTHQB7YG+F7gV3i0CnnTYPdHU2fQKOAFXz6gU1Mv7/LrtxIjJIFQijEAxSdaJFezh1/Gwed4clP5lkQJulA52U86XsjK+7zswuYzrPl8jGNPmcg1y4UFekl9rlNrk6jgnlrmSGj9PjrWbplp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:12.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f9cf1-8456-4833-7b0a-08df10196ea4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

The helper function will try to set the SMCCC filters for KVM vendor
hypercalls related to target implementation CPU support. It also
checks the kernel support for writable implementation ID registers
(MIDR/REVIDR/AIDR) and enables it.

Subsequent patches for Target Impl CPU support will make use of this
helper.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 target/arm/kvm_arm.h  |  7 +++++
 target/arm/kvm-stub.c |  5 ++++
 target/arm/kvm.c      | 69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index aafb3cd232..8cd770c7c3 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -212,6 +212,13 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_target_impl_cpus_supported:
+ *
+ * Returns: true if KVM can enable target impl CPUs, and false otherwise.
+ */
+bool kvm_arm_target_impl_cpus_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index eae2e1ec2c..a0aed2fd84 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+bool kvm_arm_target_impl_cpus_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e3a0dc07de..ee4b2e72e8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2296,6 +2296,75 @@ bool kvm_arm_mte_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
 }
 
+static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
+{
+    int err;
+
+    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    return true;
+}
+
+static bool kvm_arm_set_smccc_filter(uint32_t func, uint8_t faction)
+{
+    struct kvm_smccc_filter filter = {
+        .base = func,
+        .nr_functions = 1,
+        .action = faction,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VM_SMCCC_CTRL,
+        .attr = KVM_ARM_VM_SMCCC_FILTER,
+        .flags = 0,
+        .addr = (uintptr_t)&filter,
+    };
+
+    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
+        error_report("failed to set SMCCC filter for function 0x%" PRIx32
+                     " in KVM host", func);
+        return false;
+    }
+
+    return true;
+}
+
+bool kvm_arm_target_impl_cpus_supported(void)
+{
+    if (!kvm_arm_set_smccc_filter(
+        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID,
+        KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        return false;
+    }
+
+    if (!kvm_arm_set_smccc_filter(
+        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID,
+        KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        return false;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS)) {
+        error_report("KVM_CAP_ARM_WRITABLE_IMP_ID_REGS not supported");
+        return false;
+    }
+
+    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS, 0)) {
+        error_report("Failed to enable KVM_CAP_ARM_WRITABLE_IMP_ID_REGS cap");
+        return false;
+    }
+
+    return true;
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 static int kvm_arm_sve_set_vls(ARMCPU *cpu)
-- 
2.43.0


