Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F83DC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6li7-0001Ca-SS; Wed, 16 Sep 2026 05:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li5-0001BM-78; Wed, 16 Sep 2026 05:13:45 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li3-00087h-8m; Wed, 16 Sep 2026 05:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nwLwQgR42J7eKkcK5W6JtsjBjSmohEpkHacQMA24HDk=; b=MaPLKnNF3wru7fk
 LNCyXx+juwdFDVytJAaPaXndGbeKmelFMWX0nD8iQ28MKczec5vvZLvm6sGWAiYrOt0ZT0oViMbRR
 CuaxN/ME8ZhvBUtxDqDV3IgLKCjtGd44meYiPl8BszLUk8xK3t5tSLKvGuPz1WXFHl903fnXOq/c8
 PY=;
Date: Wed, 16 Sep 2026 11:18:56 +0200
Subject: [PATCH v4 01/12] target/riscv: Replace TYPE_RISCV_CPU_BASE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-1-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, Chao Liu <chao.liu.zevorn@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=2759;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=UBOkEAVcELBmELPjY92jS8lwx3tbFIEInyLiERUp3yM=;
 b=oSp9sgo8YDzx7XE4KP0qaiD3V4kCOPj351ec5X1Q/COWyrZ5zr/LIZeqONVR94t7SoxJaE9wW
 cmdACvDKl1UCKDtA9vurlAWmZSCz5nkzgv+g1p2/N7Dva5r9viWtnsc
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
machine for 2 machines. Replace it with a runtime check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
--
Note, this patch is to be replaced by: 20260526095731.63525-1-philmd@linaro.org
---
 target/riscv/cpu.h              | 6 ------
 hw/riscv/microblaze-v-generic.c | 4 +++-
 hw/riscv/virt.c                 | 4 +++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c2138dbd4b..aee1dcaaf9 100644
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
index b0494b1ac5..3f07ab2132 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus.h"
@@ -182,7 +183,8 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
     mc->max_cpus = 1;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_BASE64
+                                              : TYPE_RISCV_CPU_BASE32;
     mc->default_cpus = 1;
 }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..4da11db8b9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -1136,7 +1137,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_BASE64
+                                              : TYPE_RISCV_CPU_BASE32;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;

-- 
2.52.0


