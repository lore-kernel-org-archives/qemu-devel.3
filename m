Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67514C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv4-0005Ym-Ec; Wed, 15 Jul 2026 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv2-0005XN-IB
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:00 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv0-0007u1-9C
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=IWnNruG
 7b18Sc/fI0yfVWBcXhnw9xZ3bmnU2PdxFCdVz9McEZt6isKwchP/e20xhW2hPnFpXQjdbO
 Dxf/JnPaGY7gu6Sq1BSGHmo+/JL1xhJ2zbFfoQq/2zAnCl0pqJHgOUOEJcN3YzQtnxBpKa
 NwLi4JY40Oq2l7JY94cZcBnHFmNvBkJh2V+o30o76NAz6rRc1+jPkrpiYQC8vJ4kHgsxUD
 3H0Agn8f8mjTB21ZAct7fORzLPSXsn0A4cNFhV1ybFjktNuqzCqEzfGxmupfs6Ue1tt39N
 dvl25z/Hj+lGpk34OJhh8p54TOluNr8yyZvBkWqjy5mbEycee1jj90g==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=o
 vBHesXI0MiKFPQdP7nUTsJW4n+0iEF97sGoPyPeFZo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ri7AfcxUPV4yfUR84R07aNNumff9m2zPPj0u+mrLmLvsBcEGpZTmZphEqKXkkeOHtnoS
 m4NCYAkdNAyI6t0RO970qmkmAlLtq+QIOlV6pl69XNkm1e7PF8TBW9QnHSEe7otmF5oLxi
 Dy+LSxGXdimfy1XhtHXkfGoUq5LgG9VW8tiEQwxRWhRi1H0mZUjA/293ZfXihx/9adrQ3T
 P4qQbkiUZ/8B1xs4W3x2to0Lbjyor/qmWdUXsMp/AjSOLGVXZEdxKAHI8X4UDWnHo3L4HZ
 wHon9zeF0q2Nfp3s+O+QnLSTG7eI+YgA13+VKevK6XeURlkXDl2TKsOR2GGQ9Vcg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=lwlGSnYN; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=sAiFX7Hc;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ovBHesXI
 0MiKFPQdP7nUTsJW4n+0iEF97sGoPyPeFZo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=lwlGSnYNrnX/QNQKklYO3vcK7l9WyjVn1t6
 hSpn2mdB3wJ3TFc9+RKQAou6uma5rRtpT8ofCuVD5mr3kxap33ham81ARN2kiD7VsdELib
 n86Y3y7sKY4PzB6irzEjG/RLWgd8zqKvX/CnaFqxuMdw0QeEtJM//3YQeaMBffQ3M07jCA
 YDeCP9J/W9R4ozLqbevJz2BDe5HNTvEtXM/RgEOox6XAl/awLKaysDOxh6XhYR70EjCYhn
 puba8phqhJ4M87NXSxIfDnvJOhByDQs+wLuM+pYcpPGsGBhqLa0exZfzOOQlzIQgfwa65H
 +LgOmSiWAfwu4b45dph9Wsvu0Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ovBHesXI0MiKFPQdP7nUTsJW4n+0iEF97sGoPyPeFZo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=sAiFX7HcIV1sYpu6K7
 I8c0vdpcPD+bE8ZPI3YXl+A5A1aCgsWtG7BVriyuCB18q/zvBhfUZZosQGan++oxd2CA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 1ad36fbc
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:53 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 0eef788f;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 15/25] hw/mips: expose Octeon reset CSRs
Date: Wed, 15 Jul 2026 15:44:01 +0200
Message-ID: <20260715134447.56007-16-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Expose reset clock, soft reset and processor power registers through the
shared CSR window. Keep mutable register state and reset handling in the
reset controller.
---
 hw/mips/octeon.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 0caf088adf..007fc4b537 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -24,6 +24,8 @@
 #include "system/cpus.h"
 #include "system/memory.h"
 #include "system/reset.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/error-report.h"
 #include "qemu/atomic.h"
@@ -124,6 +126,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
 #define OCTEON_CSR_BASE             0x1180000000000ULL
 #define OCTEON_CSR_SIZE             0x100000000ULL
+#define OCTEON_RST_BOOT             0x6001600
+#define OCTEON_RST_SOFT_RST         0x6001680
+/* U-Boot uses the reset controller to park and release secondary cores. */
+#define OCTEON_RST_PP_POWER         0x6001700
+#define OCTEON_RST_BOOT_C_MUL_SHIFT 30
+#define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -168,6 +176,7 @@ struct OcteonPeripheralClass {
 
 struct OcteonRstState {
     OcteonPeripheralState parent_obj;
+    GHashTable *regs;
     uint64_t rst_pp_power;
 };
 
@@ -294,11 +303,18 @@ void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value)
 
 bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
 {
+    if (reg == OCTEON_RST_SOFT_RST) {
+        return octeon_reg_lookup(s->rst->regs, reg, value);
+    }
     return octeon_reg_lookup(s->csr_bank->values, reg, value);
 }
 
 static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
 {
+    if (reg == OCTEON_RST_SOFT_RST) {
+        octeon_reg_store(s->rst->regs, reg, value);
+        return;
+    }
     octeon_reg_store(s->csr_bank->values, reg, value);
 }
 
@@ -869,6 +885,33 @@ static void octeon_ciu3_nmi(OcteonState *s, uint64_t mask)
     }
 }
 
+static void octeon_rst_pp_power_write(OcteonState *s, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    uint64_t old = s->rst->rst_pp_power;
+    uint64_t changed;
+    unsigned int cpu;
+
+    value = octeon_write64(old, addr, value, size) &
+            octeon_present_cpu_mask(s);
+    s->rst->rst_pp_power = value;
+    changed = old ^ value;
+
+    for (cpu = 1; cpu < s->cpu_count; cpu++) {
+        uint64_t mask = 1ULL << cpu;
+
+        if (!(changed & mask)) {
+            continue;
+        }
+        if (value & mask) {
+            async_run_on_cpu(CPU(s->cpu[cpu].cpu), octeon_cpu_park_work,
+                             RUN_ON_CPU_NULL);
+        } else {
+            octeon_start_cpu(s, cpu);
+        }
+    }
+}
+
 static const MemoryRegionOps octeon_ciu_ops = {
     .read = octeon_ciu_read,
     .write = octeon_ciu_write,
@@ -1082,6 +1125,19 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
     hwaddr reg = addr & ~7ULL;
     uint64_t value;
 
+    switch (reg) {
+    case OCTEON_RST_BOOT:
+        value = ((uint64_t)(s->cpu_hz / s->ref_hz) <<
+                 OCTEON_RST_BOOT_C_MUL_SHIFT) |
+                ((uint64_t)(s->io_hz / s->ref_hz) <<
+                 OCTEON_RST_BOOT_PNR_MUL_SHIFT);
+        return octeon_read64(value, addr, size);
+    case OCTEON_RST_PP_POWER:
+        return octeon_read64(s->rst->rst_pp_power, addr, size);
+    default:
+        break;
+    }
+
     if (!octeon_csr_lookup(s, reg, &value)) {
         value = 0;
     }
@@ -1095,6 +1151,16 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
     hwaddr reg = addr & ~7ULL;
     uint64_t old;
 
+    if (reg == OCTEON_RST_SOFT_RST && value) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    }
+
+    if (reg == OCTEON_RST_PP_POWER) {
+        octeon_rst_pp_power_write(s, addr, value, size);
+        return;
+    }
+
     if (!octeon_csr_lookup(s, reg, &old)) {
         old = 0;
     }
@@ -1354,6 +1420,7 @@ static void octeon_rst_reset_hold(Object *obj, ResetType type)
         opc->parent_phases.hold(obj, type);
     }
 
+    g_hash_table_remove_all(rst->regs);
     rst->rst_pp_power = octeon_secondary_cpu_mask(rst->parent_obj.board);
 }
 
@@ -1411,6 +1478,16 @@ static GHashTable *octeon_reg_table_new(void)
                                  g_free, g_free);
 }
 
+static void octeon_rst_init(Object *obj)
+{
+    OCTEON_RST(obj)->regs = octeon_reg_table_new();
+}
+
+static void octeon_rst_finalize(Object *obj)
+{
+    g_hash_table_destroy(OCTEON_RST(obj)->regs);
+}
+
 static void octeon_csr_bank_init(Object *obj)
 {
     OCTEON_CSR_BANK(obj)->values = octeon_reg_table_new();
@@ -1594,6 +1671,8 @@ static const TypeInfo octeon_machine_types[] = {
         .name = TYPE_OCTEON_RST,
         .parent = TYPE_OCTEON_PERIPHERAL,
         .instance_size = sizeof(OcteonRstState),
+        .instance_init = octeon_rst_init,
+        .instance_finalize = octeon_rst_finalize,
         .class_init = octeon_rst_class_init,
     },
     {
-- 
2.54.0


