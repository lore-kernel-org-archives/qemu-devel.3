Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37E606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=YHkfE0l5;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=fEo+8YX7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLei0-000715-Ut; Tue, 27 Oct 2026 06:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg7-0005QG-Uw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:22 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg5-0007wO-G7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=R1XYILt
 lsceFyB2Xsk1roOB/O840+tbYfpOsNnb4K6MoX/UNmQHJSDk4hsnQevUX0GXzXsRgb1yfW
 X/Gyvm4rbBN9LwQ3FelxgbAdeNkmuW8xCJ+1ZlE65fFXLsApo4mwrpqTs/lD7BrQslSxhq
 M6OkD1N+Ebzc5iHJz2ijlwngWOYo8R16ObFQxC4HVwEmk5viVPsgoL3664MZPoHR3a9EAU
 AlEg+cQ+Cj/LfIYJIkOobgTxHZG9sDM1/Z8DeR6ThDoxS4DfXw2qog54r5gL6jYN6ro12/
 la5ZtKHJuClIH7RnICRZT5XNs81pMkR6An4Yz0SPJUoI+rk9LYY7q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=P
 +mGKrnZfBZ2dtpU1pumlQ4uzbXXM4sfK+yupQv6FKg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=JSpoO0plureDMRphOlRhATOjRCtIa1OEdEw8lU0cI0R9M9gmFiEW9FZLdHIcPi5/3NH6
 zt2B3K8tEqJkeejr+wcXHne+7Pj3/qLJkAEB9kPOhOi9MCNbm77G0cvZv0CxoULxaSV135
 LupPSA+ZZDJrh31YAaMTM6atWWgIuCcQipH+ch6Oq8yThfraCCLN+4OV+9ChnGNLyD+Ffi
 ufAw8LuX0UEjjgBZ5oibKH2gjZN2XHopWpR2zw6pkMxTakOdiliankUTTMWWaxyPyDidJe
 RH9LufVkfSZKE3EHIFtJGjc4xAT6Lfx6MohcnYrg/rEq450ZsZ2zL+7FjpVXXgKg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=YHkfE0l5; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=fEo+8YX7;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=P+mGKrnZ
 fBZ2dtpU1pumlQ4uzbXXM4sfK+yupQv6FKg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=YHkfE0l59hm384c56lCgylUjudJ47mfb6vQ
 EGWZEKCaKXMBo9sAowpqR+ZFuCOg/9RXa1K7se0m+2lF240cKEh+qEHfBaHaTBeOGTKqQv
 a5cUoW9ZzR/Da8EDdg1eOiHdPHtaxhDKM3hd593BtERMTvvsS9MsaLsXkTMyiy9wE79dzs
 ca/nZNVZDQrU4c4NBqFIhfgyFDCENIIlg/vVq8BftoKsxUxuRFbZZeOEUKQLgbCeUvbO/r
 r9zZ8j0V83h0YJg1Al1ioFM0gWeS0C425R2jSU8HtrpdPl21G8GQaZU2YPlxj7ju1fShgz
 JKzZteHZY7dyUha2HO8bDL/PZNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=P+mGKrnZfBZ2dtpU1pumlQ4uzbXXM4sfK+yupQv6FKg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=fEo+8YX7EwkIk2JIxh
 5TfGZcpGxZdnNlqOeRpFN2N5ZggO4Nyc/TbcI6KklzEnTfx+9PFNOgvbE5knRUgMOYBg==
Received: by mx2.catap.net (OpenSMTPD) id 0d54a543;
 Tue, 27 Oct 2026 11:45:01 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 6b8e3dad;
 Tue, 27 Oct 2026 11:44:52 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 15/25] hw/mips: expose Octeon reset CSRs
Date: Tue, 27 Oct 2026 11:41:39 +0100
Message-ID: <20261027104433.25720-16-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


