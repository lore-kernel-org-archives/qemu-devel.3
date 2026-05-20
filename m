Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857A2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf5-0004ou-Mq; Wed, 20 May 2026 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgf1-0004lU-G6; Wed, 20 May 2026 09:08:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgez-00013y-Bg; Wed, 20 May 2026 09:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=dDcP07ZN1+P+qyXkxHKmye37sUEokR3lgbJbdEcaicE=; b=dvACLaj0zcREaol
 1wYePj2rhEUU+LH1zVxHD2GZyyaYbdN3aua5WJ+a5sc0q+it311hrdDXMp6KXWybEMzag9gTXVCKb
 ijzEI/VY4Iw5vtCH7kDeRMWyKmoq/ZAuc34MXdQXMIQsVly1MvR/NT0dRMKfCwyqeh9kLh4ZOiyOH
 JI=;
Date: Wed, 20 May 2026 15:12:59 +0200
Subject: [PATCH v3 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-7-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=3705;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=7xHWC+KvOPCwect0w2AuYbsi6ke8eC49IW0/RQCR6eU=;
 b=7BmSLvwiZ4QcQlp1teIh0JQUpMfoxHQ8C7PFDCGjGvFpiKeWSS0cUNbK40dj4gtZQGDiMe09J
 TR6q94QJPcxBoB0T1DrJngl5qbN/c8lBX4fpUggaTBWEeCO78n0BD6Y
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TYPE_RISCV_CPU_BASE is used only to initialize the correct default
machine for 3 machines. Replace it with a runtime check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/machines-qom.h | 12 ++++++++++++
 target/riscv/cpu.h              |  6 ------
 hw/riscv/microblaze-v-generic.c |  2 +-
 hw/riscv/spike.c                |  2 +-
 hw/riscv/virt.c                 |  2 +-
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 3459437d84..8396155373 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -9,7 +9,9 @@
 #ifndef HW_RISCV_MACHINES_QOM_H
 #define HW_RISCV_MACHINES_QOM_H
 
+#include "qemu/target-info.h"
 #include "hw/core/boards.h"
+#include "target/riscv/cpu-qom.h"
 
 #define TYPE_TARGET_RISCV32_MACHINE \
         "target-info-riscv32-machine"
@@ -43,4 +45,14 @@ extern InterfaceInfo riscv32_64_machine_interfaces[];
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
                                             riscv32_64_machine_interfaces)
 
+/* Default CPU type inferred from target info */
+static inline const char *riscv_default_cpu_type(void)
+{
+    if (target_riscv64()) {
+        return TYPE_RISCV_CPU_BASE64;
+    } else {
+        return TYPE_RISCV_CPU_BASE32;
+    }
+}
+
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fb44f0485d..f521686c43 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -39,12 +39,6 @@ typedef struct CPUArchState CPURISCVState;
 
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
-#if defined(TARGET_RISCV32)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
-#endif
-
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68..386c5dce9c 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -183,7 +183,7 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
     mc->max_cpus = 1;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = riscv_default_cpu_type();
     mc->default_cpus = 1;
 }
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 08ef291b6b..b937cf0fa6 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -343,7 +343,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = riscv_default_cpu_type();
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 39caf37c01..e108e29f63 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1933,7 +1933,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = riscv_default_cpu_type();
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;

-- 
2.52.0


