Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24149C88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53C3-0008Kh-Ln; Fri, 11 Sep 2026 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53C2-0008K4-Ha; Fri, 11 Sep 2026 11:29:34 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53C0-0007GG-9q; Fri, 11 Sep 2026 11:29:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd6PsSvfkjCY6LYD30kkgzIjCfx51Dj94FPwJBZUlP61t/FR0MR1fVSnFm6DKV1r5/Ji5JGTQehN3BIJUAraJb1pCAjGy5dkGQip6UkWlewNCNovoNnK/rGL1tgxoVhuO+wogCl2efMigUhzs9LUVsILY0aLtjKTdpy8AH4GsQX0hCrMB1AHTimFUHVYwARzLgug/iruvFYQcZGNHOYW89W+HPrrZZ5cw+tta6CVY11ivVHBiGKjzOP9mIZbdgHHf4BHv2Ftxtz7gAq+I+9X6LmnUCUzPTXjCgXAZGX+SfNjV0lAAte9JVSnc5C5vbMgtA7SVr030wF2hy0/ZzduoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbZZQSEilcG66n6kx6vk0RI0RbpH2oGGDd+PxBlvbc8=;
 b=AAwSMraZkzDOH0ILUYrfNTBF0bJuzaFZQOW70H9m+PILetxH6olxKjvOC3uw0QV1pWif79MQRLgyQRMHy/51DfMb2LtKINOA0pieiAOndUjURYQTsxEj0GH/Gh34+tzKlO8u9n4Fd53fcT4CCk6nI5oU4Wq1SdBBGQIPzfeWIi1+tT5eU5WfXNq9UOh75WDIIr+LSSrMheEUOMsFPDNZ9H4fnkU6QHt/uUDC0LZ4X3TMU10dipqfKxgXZHwlhYUZw5lKSaC6uiyGJQzVtPqdihFaWsoCZmSQRsp9RVGXVp3sDRrAoYIhD2205HVSAJ0uPMMCpMDQ7O2jsq/0CLu5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbZZQSEilcG66n6kx6vk0RI0RbpH2oGGDd+PxBlvbc8=;
 b=E9nkOaYgJEDufmFT9BvQ9exJLK/IfzfR1R1AsiUb/Gjeam9fkOUDsRpE1dDMTvjJ8ggKHW3/Ud9IZCmHiQPkqasc81MFkKbfU+xcf4Quh27/RGMCIcy6JRjAsPhUqOYagoS9DCSHQEqB1Tpun8H/5KPi3MHgF7zph+vtLYI3tM7bxcwor3MWIC7KUWbdY4aY6gWjAJACHGOOjjJY70qvHDA1wM60WYkx1Wfw+njqmRw+XaEB7UH0Fhg+/a659sGv0Q0JlZ07S7Ih6iZKJivTDsr43uJOpFKaf1J9WoD/4DwFcAmToP4k876W9LCF+BLouF8xQTaQCSKZVnnDcWc1gQ==
Received: from SN7PR04CA0026.namprd04.prod.outlook.com (2603:10b6:806:f2::31)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:29:25 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::80) by SN7PR04CA0026.outlook.office365.com
 (2603:10b6:806:f2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:29:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:55 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:52 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 4/5] target/arm/kvm: Handle KVM Target Imp CPU
 hypercalls
Date: Fri, 11 Sep 2026 16:27:53 +0100
Message-ID: <20260911152754.706518-5-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 681c94a9-b38e-4a64-b332-08df10197557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p1LliI100mbdaC3OKa/vhbn/MpAyy0W25IsQNmS5X/RIJXi+op0BmvvWpOeO6Zho1Suax9MUluqGGjH4xqoaCymW0y/q3+5ZP4pSDxRz3Rj7up2J5S+N8P9dG5fPbrLohledxPXvyXS+TOESyEW144NitZzNTUN/p7NnUgNZO0EYqKMz0lU0EWgOKykN7ijjyXn0J8JEGeVeONk08EIB7sAbYf5blb5VUHLALc358RhmAK63WTc1x6VafULG30KXbSbRMK8P8FWBD/1DyyjqP5ECJux5EyEO3hQWlcp0jSjkdJbf7Ue/cvjvL542MhKcJA01Qtjb914rh9OyvEgtce93YmBAKMPzArDBxCyFORyuWvmgDHvtwp3erQJBoRzctAlgz5Mqng/1pSm/kH0bqd9aY8PCnS7hArdAvcx4w/8JaqR73UbtECXdcT/et2Q30h0t3RfR5reb5lyk3WfNKp54sgcAsvZ2Dp5mtrfaZBp334l6gmNPBnr20v02Cllx/deB8R4wiResi7yj25SDiyqrzfHrAdAsrU+Fo/3IXrJLEARX/7Ft/nwFQs3qu+yeuT1e8+lldnsMxCTvvLmKuXSQaokalVVIyBS8vLUJmseVkCNsrw9sM/Hjqu/3S4JiDMGhSl2KOta4qdUTn8DHumpEgcTZaRn6CN4m0Tt0sKzGM4dSBcL9A3bsKwoQoqQL8t0L3TbhGbq/bMH6R3RdJg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ji/hjSs00a2e4sFI8jx2sjUJJ+g617cH9sAHquWeyry+4O6U5JzhrlG4VcX2mVA3XnSHq6NA2z0cw0RS8sZZxRxO2YIEcUXijP3OxaPhlfL7eF2ZnIUktR0PFoxUMdEU5jgWS2Fv6rLsCcTMCnJDaCx8UmewFsrt5TFrA9Dv+jRWjW1eb5YPUtyxOC5NU9Xr4FQVFA4wReKoebx1ncIeX+MG8dt8SYgLdbSH0an+yjwnRujDkEoqZ6VdAMuTZ1RwyTMgB+r+QeVNcdTp9ElnOgCDd3SjRHi7Ok3CPHIaLEWWdpzjE1TjByHtMlRPnRg/KCy2WgKZ9ZDViK2Hm7dMGmjmu3qIW4NEcwG+vkczTBbfNJtQdkQg5XJ3vIjrsBOug0AbL8Zf8Agg2Cyq0Rtv5FtvTNCdIbFBCjA1Vmwmw3YEyK4g8TRz8j/MI21WLDGT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:23.7493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681c94a9-b38e-4a64-b332-08df10197557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

When target implementation CPUs are set, handle the related hyper calls
correctly by returning the information requested.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 target/arm/kvm.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 68c22a6cde..48eb3e51a5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1903,6 +1903,77 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+/* Only supports HYP_KVM_DISCOVER_IMPL_XXX hypercalls */
+static void arm_handle_smccc_kvm_vendor_hypercall(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    ArmTargetImplCPUList *iter;
+    uint64_t param[4] = { };
+    uint64_t idx;
+
+    if (!is_a64(env)) {
+        env->regs[0] = SMCCC_RET_NOT_SUPPORTED;
+        return;
+    }
+
+    memcpy(param, env->xregs, sizeof(param));
+
+    switch (param[0]) {
+    case ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID:
+        if (!target_impl_cpus_num) {
+            env->xregs[0] = SMCCC_RET_NOT_SUPPORTED;
+            return;
+        }
+        env->xregs[0] = SMCCC_RET_SUCCESS;
+        env->xregs[1] = PSCI_VERSION(1, 0);
+        env->xregs[2] = target_impl_cpus_num;
+        break;
+    case ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID:
+        idx = param[1];
+
+        if (!target_impl_cpus_num || idx >= target_impl_cpus_num) {
+            env->xregs[0] = SMCCC_RET_INVALID_PARAMETER;
+            return;
+        }
+
+        iter = target_impl_cpus;
+        for (uint64_t i = 0; i < idx; i++) {
+            iter = iter->next;
+        }
+
+        env->xregs[0] = SMCCC_RET_SUCCESS;
+        env->xregs[1] = iter->value->midr;
+        env->xregs[2] = iter->value->revidr;
+        env->xregs[3] = iter->value->aidr;
+        break;
+    default:
+        env->xregs[0] = SMCCC_RET_NOT_SUPPORTED;
+    }
+}
+
+static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+
+    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
+        cs->exception_index = EXCP_SMC;
+        env->exception.syndrome = syn_aa64_smc(0);
+    } else {
+        cs->exception_index = EXCP_HVC;
+        env->exception.syndrome = syn_aa64_hvc(0);
+    }
+    env->exception.target_el = 1;
+
+    bql_lock();
+    arm_handle_smccc_kvm_vendor_hypercall(cpu);
+    bql_unlock();
+
+    return EXCP_INTERRUPT;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1919,6 +1990,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_HYPERCALL:
+        ret = kvm_arm_handle_hypercall(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -2379,6 +2453,29 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
     return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM64_SVE_VLS, &vls[0]);
 }
 
+/*
+ * Supported Target Implementation CPU hypercalls:
+ *   KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_VER   = 0,
+ *   KVM_REG_ARM_VENDOR_HYP_BIT_DISCOVER_IMPL_CPUS  = 1
+ *
+ * Setting these bits advertises the availability of the corresponding
+ * Target Implementation CPU hypercalls to the guest.
+ */
+#define BMAP_2_DISCOVER_IMPL_BITS 0x3ULL
+static int kvm_arm_target_impl_cpus_set_hyp_bmap2(ARMCPU *cpu)
+{
+    uint64_t bmap2;
+    int ret;
+
+    ret = kvm_get_one_reg(CPU(cpu), KVM_REG_ARM_VENDOR_HYP_BMAP_2, &bmap2);
+    if (ret) {
+        return ret;
+    }
+
+    bmap2 |= BMAP_2_DISCOVER_IMPL_BITS;
+    return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM_VENDOR_HYP_BMAP_2, &bmap2);
+}
+
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
@@ -2482,6 +2579,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
+    /* Set KVM_REG_ARM_VENDOR_HYP_BMAP_2 if target impl CPUs are required */
+    if (target_impl_cpus_num) {
+        ret = kvm_arm_target_impl_cpus_set_hyp_bmap2(cpu);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_arm_init_cpreg_list(cpu);
     if (ret) {
         return ret;
-- 
2.43.0


