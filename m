Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40395C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liR-0001HP-Uc; Wed, 16 Sep 2026 05:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li8-0001D4-8V; Wed, 16 Sep 2026 05:13:48 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li6-00088N-Od; Wed, 16 Sep 2026 05:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=c5o4tGOyOoWMVjs8wMdbgBWBYQiz0qqSiNJACKcuT3I=; b=gGt/v/pp4GtAHgZ
 iSPLk8rjchkBMIR0pVB7D0wKEF7lwtyArPGUTg2WI/07YNIo0iDRGXbPIfXXsOikMDsw2CsTUDE9Y
 DsRvy/druYfGnsGZ/gF1SRNig+iiaf4yusBiVG5HJ0FJ36V7K2u4FP6tu/E8KneSxwhVFLlBDxmzT
 t0=;
Date: Wed, 16 Sep 2026 11:19:01 +0200
Subject: [PATCH v4 06/12] target/riscv: Move target_long.h inclusion away
 from cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-6-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=1891;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=F0eu78YQitKke1fI9k2BY2J9Hs0kvtBirbAu/KUbG2I=;
 b=d1ToUZxyu3bPI6WHrjIW4DQZwp1E6lVU0Qmt4W3eppvm6wKXREjMsIa0gzPNVRhPb2sE+t5yv
 ydahavROKkyBN/mpcaUFePOw3F5y7dHhxe/d+kdvms6FNpjD61uB15z
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h         | 1 -
 target/riscv/internals.h   | 1 +
 target/riscv/tcg/pmu.h     | 1 +
 target/riscv/kvm/kvm-cpu.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a5fb75b990..3fa322a8a9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -26,7 +26,6 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
-#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de96..1ee7e99e98 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -20,6 +20,7 @@
 #define RISCV_CPU_INTERNALS_H
 
 #include "exec/cpu-common.h"
+#include "exec/target_long.h"
 #include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 2429c01b77..fbdbfe7600 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -21,6 +21,7 @@
 
 #include "cpu.h"
 #include "qapi/error.h"
+#include "exec/target_long.h"
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 68e1501b21..a5879d8d6d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -35,6 +35,7 @@
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
+#include "exec/target_long.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/core/boards.h"

-- 
2.52.0


