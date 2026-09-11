Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D10C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53Bu-0008D3-Ip; Fri, 11 Sep 2026 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Bt-0008Ce-7m; Fri, 11 Sep 2026 11:29:25 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53Br-0007FB-NR; Fri, 11 Sep 2026 11:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNgWBhb4oBW3COPhdICL8nKAYP7Bars5Q5xy4LqCyq6EXlZ/13XP9BUZlRI/NTVX/pc2h7OO00ArtMiRY6qANxjNIlcwVV5ebNCV6tvOfp09CvRdyzwvbw+Kw3kbABBgXLEt6Rkad4P+JOBekInmNxdTzNWvrQePtMtoEVAgRK5de74Pi8XW090mSEzQf8xjUQ6Pr0HtFky8wr+20szWcfsaJAwuqcUuy9ktoTAlf483/gHtbuNa7Jd6pl5SyAS9aQOUWBii3EAWQNE7jWKhNxqkyqXgz66Vb8GX79/arB1Y68aNd3n8Q7xtH/+eYEfnMWZ6ZyIv7NOr2EGx1Hk2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkpeyUjwIleydYDKUCQmZXlD1B/OVgbJDkME/++juuM=;
 b=ET0A8EUDp4uyCxaVFUrX28stFvSZwWDLH+OvgvfBhzkCPdsTkewXfTQNmANh37HVzraulWfObfB02UFg4l6P9ahbWkpEHzjtZ7XBR2F0AxadQnoLNTQfy1z3pAJ60ZUTANQJxITM1lkZDV/skg5MQ1XKM0hWvvxCrpfmDa64R/5JCazpYVHp1L2iKVWU9vDh2Tc3AJbHoEqXFQ8uQwLr+8IMMZWQkwBeeymZXagcVPygX6COMnfvcdPRWQvfHaiI2RF9ZCHvi/xok4pk03BFItPuDbCaHcdE/J5ALdOMJgI7aBqrUfQNWbHZi/LixcyN7Txy8Tv0Y4ADStN+Whl+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkpeyUjwIleydYDKUCQmZXlD1B/OVgbJDkME/++juuM=;
 b=cyz0u67v6ZHw3xHCFqZM4BWTYxsN/5nuud+TsX4flHCvDec3NxUP1QuMemu8rzEitFL/zgZWByzdgkGoo8hmmuAoQmWRIz3J0xDFfmZptxn94k55ZGgJEEMJsePZq3LyrAX/SyuL8bHMRcGyBv2HncD4nx3ikE6dLjHLOo1OA+AYwjUOguZfqJI0e6AaDBoqwGY8zTIrQJtBK/bT1DNs1fFGM+82ssVGRlQLCeke6wgWukTHgdps6CV3nmirqVcDjjnv+kZQO8ISp5k6YKZ0QBjtdFjiF6muD/9Zujm2fVVbO2BQcgLlrWKpuJlLkqh5GHlBrQ0QZ+NLGXNCQWWVrA==
Received: from MW4PR04CA0163.namprd04.prod.outlook.com (2603:10b6:303:85::18)
 by LV2PR12MB541025.namprd12.prod.outlook.com (2603:10b6:408:3a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:29:19 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::53) by MW4PR04CA0163.outlook.office365.com
 (2603:10b6:303:85::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:29:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 11 Sep 2026 15:29:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 3/5] target/arm/kvm: Add QAPI struct ArmTargetImplCPU
Date: Fri, 11 Sep 2026 16:27:52 +0100
Message-ID: <20260911152754.706518-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|LV2PR12MB541025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0701a3-0b15-492c-2f3b-08df101971c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9kq3fnYv3vFYN5fPkJSKxyif9CiJPWujnfeevK5tow3qseP4H2f3hFIz25S+pRxdpblI37bDfLceTIDnBFR6Ijufs2dLlX/ZaK55NetAE9UJVfjRb9pfNgRNQ3LdOwX+nbmIktprd5rprWk/cZu3iLyJCzndHQGzQg3l01Gl0UzIyilD/vuC4GzwSKTqEDU/4A4hzAPJYainasbtuS7m5WtWT6wV6hsDNBqZC+sVZD/zMIh9otdtWufZ+REiEk6AA1hwcPH4reZrDS8xvj+1jDNz9saZtZvt6eXfEae3Bn/AD/pC0sO4vqXVgqxw/krhZ7RLLiupkxAxc6iyBtsCv5I5n+obwKmD89w69YT80jivSpgqf1DAsWOmJrXGXKbsUV0XZQwCeLERjCrcAyci7dJRRJ0disGsCmrt9+u9yrlzdiEr8O+e9C9Jt7SnFOvHz736GbJC10f8bgwY5hOoEnJ7I0q2iT55sFsmEXMvUoRqn9hX/MiPcs5tjkjBlwnWCZwBZjW66uYea8ed1tkzg5vECX/AYTx/Yw0knxwq3uwgFqzzu6lHJ+QXBcTwPrkeHBVuMdrcMiqnMFdViU/hPbGlLNtBnAfN4Cd1yML3ldTBikDfAsTHwhAdkxteEXZSl+/5GA+Im8YMVgEcRdaXg98tFIs6ase4QuNOr5ZFazdTmuh2OcVGfQMRCiVyiozE1ox01cLMiZx2rjop4G966A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J3YfxpIsTwbC/XSNs6BPz1Mjfea5C9km8OZgtAh1WaTv0AOIZsBYUlciD/m4XfLhoX8FhCDyZG6MgVGJuLS5oTgfT0X8JevLc0iBnQhhwaUz3qHv7yR3HPzIvjV5ibRIiNfYp3yFoJ0q2y+eIlDoYlFvTZjGjKfWAsEGFhuRI/R5gBk192NlFJw8eKQnx8KW0enPawXFqr6jLeRs7DuWmjZ0zyFHMv+TZMrxzAGfa//l88KGpM465jiMV2HuYLmVxWiVv6PK40/pKwWzVHQz9gwoJEtHCMMCXZKDwjaVbbQq3qbx6R0CIpBCMjPP1Bt2ZlVsYM97uC3iLOz414b3gDpqPXi1E61BXXejs0FcUL1z4bOGLtmJ3vj7IdLlR5o8lZ05VyteruoPdeHzCNTzAsZKZsQWheo1LDqKSX66XouWcD97TCEZqdmNuI39A9Hs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:17.7273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0701a3-0b15-492c-2f3b-08df101971c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB541025
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Introduce a QAPI-defined struct (and its array) for target implementation
CPUs. This enables specifying target implementation CPU parameters
via -machine, for example:

-M virt, \
  impl-cpu.0.midr=1,impl-cpu.0.revidr=1,impl-cpu.0.aidr=1, \
  impl-cpu.1.midr=2,impl-cpu.1.revidr=2,impl-cpu.1.aidr=0

Subsequent patch will make use of this by using object_property_add(),
allowing users to configure each target CPU's midr, revidr, and aidr
fields directly from the command line.

While at it, also provide a helper function to set the target CPUs.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 qapi/misc-arm.json    | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h  | 11 +++++++++++
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 20 ++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 4dc66d00e5..8dbfb98fe5 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -89,3 +89,39 @@
 ##
 { 'enum': 'OasMode',
   'data': [ 'auto', '32', '36', '40', '42', '44', '48', '52', '56' ] }
+
+##
+# @ArmTargetImplCPU:
+#
+# Info for a single target implementation CPU.
+#
+# @midr: MIDR value
+#
+# @revidr: REVIDR value
+#
+# @aidr: AIDR value
+#
+# Since: 11.2
+##
+{ 'struct': 'ArmTargetImplCPU',
+  'data': {
+    'midr': 'uint64',
+    'revidr': 'uint64',
+    'aidr': 'uint64'
+  }
+}
+
+##
+# @ArmTargetImplCPUs:
+#
+# List of target implementation CPUs.
+#
+# @target-cpus: List of ArmTargetImplCPU entries.
+#
+# Since: 11.2
+##
+{ 'struct': 'ArmTargetImplCPUs',
+  'data': {
+    'target-cpus': ['ArmTargetImplCPU']
+  }
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8cd770c7c3..4dc59779bb 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -281,4 +281,15 @@ char *kvm_print_register_name(uint64_t regidx);
 bool kvm_idreg_write_scratch_vcpu(int cpufd, Visitor *v, const char *name,
                                   void *opaque, Error **errp);
 
+/**
+ * kvm_arm_set_target_impl_cpus:
+ * @cpus: list of target implementation CPU descriptions
+ *
+ * Record the target implementation CPUs to be reported to the guest via
+ * the KVM vendor hypercalls. May only be called once.
+ *
+ * Returns: true on success, false if the target CPUs were already set.
+ */
+bool kvm_arm_set_target_impl_cpus(ArmTargetImplCPUList *cpus);
+
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index a0aed2fd84..9f835787f1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -47,6 +47,11 @@ bool kvm_arm_target_impl_cpus_supported(void)
     return false;
 }
 
+bool kvm_arm_set_target_impl_cpus(ArmTargetImplCPUList *cpus)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ee4b2e72e8..68c22a6cde 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -69,6 +69,9 @@ typedef struct ARMHostCPUFeatures {
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
+static uint64_t target_impl_cpus_num;
+static ArmTargetImplCPUList *target_impl_cpus;
+
 /**
  * kvm_arm_vcpu_init:
  * @cpu: ARMCPU
@@ -3061,3 +3064,20 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 }
+
+bool kvm_arm_set_target_impl_cpus(ArmTargetImplCPUList *cpus)
+{
+    ArmTargetImplCPUList *iter;
+
+    if (target_impl_cpus_num) {
+        return false;
+    }
+
+    for (iter = cpus; iter; iter = iter->next) {
+        target_impl_cpus_num++;
+    }
+
+    target_impl_cpus = cpus;
+
+    return true;
+}
-- 
2.43.0


