Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E66606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRHQT0uw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQG-0008MT-87; Sat, 14 Nov 2026 19:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQE-0008KG-Td
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:42 -0500
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQD-000172-1M
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:42 -0500
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1b3b4bcbfc9so2396614c88.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703720; x=1795308520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RrbCTmuYz05ZihDwfRnJi31ets07yrwrVtDlvFAiHy4=;
 b=QRHQT0uwLMVc4vKDo0x9DLWMY9gsCrTK8aMM6+IB03SzVJ8T60eTuwcautTydGhndH
 sRAFJ+VmzMmliGjREWFX3T4srgj3sbfN7bfAcZE9c5AYQBncBYJR9opGoZAtQUGoebAl
 s+WryOx5UJhiAF8Dt/OPe8Y+60zILVPstKgaq3VKgTckfbafT5RI5n8PSte+S/t9PbQh
 Q9E4eMjQSSGFcaz+ZyWxzvg91z3B4VbF1NCbkbShizjE3HWGWZUdkspUsCOsCpddr9JW
 DG8p093QO0xjNYbfOXF25Vk+u9s3lpsC73noukfBH39CwMQImn6dpd9A4DMAEAQaGvDS
 RBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703720; x=1795308520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RrbCTmuYz05ZihDwfRnJi31ets07yrwrVtDlvFAiHy4=;
 b=M1LaptfLd/lMd7ej9Wxh86Z0UKZJiMokWQ1UuawbiMt8p3lqcJjUTAjYLfJvEOsS16
 UMbRY7qdLYM973ioEBWBcXHKoj3oORH4aZUgS9YVSwtvEZdZkKpBEIAYPsza65jkLpyy
 3IqZsoSQHrD/5i8F/QrqeYciRJoYPUJ5t3epzaRAkNEneDca67nLTr+Gns+L2h0LImVd
 pBP2SbW/WoVkmWBOgL2K09uBl+cnqDuqS45XQnWJHn7gGapdLNhRLJJTAVMRWjxo/4S9
 Z3zNgsD/4VuWxH6HvivUfmFwozHaZGi02ub2VPDH+ZGp+STg7wzEZVfDebPH1kbeGEcf
 IdEQ==
X-Gm-Message-State: APuU4Z9YHOGPY8C2ezcmblnA6Fq28PDOtzYB04yfqs3Vyq/xTH9pu6BW
 uToaRdX7a8NR2zwrl22mEs8HztR/CoHILFfE29IQnKbMjqhDHkzRD/p3okLdpw==
X-Gm-Gg: AYBFou050Tz6QF2dunT3pVSN7yIxJfAwkT+30AQiMm/HZonGAhPC1fYkpcV+62kJmS1
 2DYB7UpcYOPXrQHeIwdi8Qbewf6ARkGwyiVfje2HiKIUJ131aK2ZnM0SsT3tDRS0qRR8d5gK9In
 scl8Ocd7JMrsj7LuZnuFxPWKjT25Dc6HEtfSg7L/UQ2BMhayJivYPo7kQ32zMuTiiwX80zhY0eN
 RJwN1rowDUCE7VRm8AX7oMX0Y8/8Oe+cMeNfkIWG+9P0Eydg3v073Ha/mIWprhXdhCpkJVnECjK
 7rzBPqQeC7wRzdxyLciQ4RX9EQ5SAf8Bu2cZ86+t7w9GcP1N5Fpt12HiSzqfbAHV0uYSgjylUjc
 uD2rpIRnAul1nvuy9Ul2Mr75KjM2clr+Zvy6hSNb/7I+VyG+eeiHX2gBr+RSC2p8usCrvoM6fDw
 s7Sh7mWlKDVUOtLyptriaXwQ6ytu/2GEDe4zyA+rHX8fEaGad+N3m+mHutXxuj94/y1GP2WrTHa
 hFI6miXzpnRoop0/Q1Z1l1d6/RT43PMrskAnjH9I81ckMelHs0ig38wOHnj8GJwJ6siQzUdm+Pf
 nqfQ3veHAYljwy+KcktpFsYePNI31pGM/hmbkBHS88bLYT6c
X-Received: by 2002:a05:7022:2390:b0:18d:96e8:b913 with SMTP id
 a92af1059eb24-1b503195191mr9629314c88.47.1794703719546; 
 Sat, 14 Nov 2026 16:48:39 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:39 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 4/8] hw/riscv: Pass socket topology to KVM AIA
Date: Sun, 15 Nov 2026 10:48:15 +1000
Message-ID: <20261115004819.2586336-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

KVM AIA initialization uses the RISC-V NUMA helpers to query
the socket count and per-socket hart topology.

However, KVM support can be enabled without CONFIG_RISCV_NUMA.
In this configuration, kvm-cpu.c is built while numa.c is not,
resulting in undefined references to riscv_socket_count(),
riscv_socket_hart_count() and riscv_socket_first_hartid().

The virt machine already determines the hart topology when
initializing its hart arrays. Pass the socket topology directly
to KVM AIA instead of querying the NUMA helpers again.

This removes the build-time dependency on CONFIG_RISCV_NUMA
without changing the IMSIC address configuration.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h               |  5 +++++
 target/riscv/kvm/kvm_riscv.h |  5 ++++-
 hw/riscv/virt.c              | 10 +++++++++-
 target/riscv/kvm/kvm-cpu.c   | 10 +++++-----
 target/riscv/kvm/kvm-stub.c  |  3 ++-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index e4dcc5aae09c..ed9b613f3c80 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -12,6 +12,11 @@
 #include "exec/hwaddr.h"
 #include "qemu/bitops.h"
 
+typedef struct RISCVAIASocket {
+    uint32_t hartid_base;
+    uint32_t num_harts;
+} RISCVAIASocket;
+
 static inline uint32_t imsic_num_bits(uint32_t count)
 {
     uint32_t ret = 0;
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index aef681f0a212..bad78e28f453 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -21,6 +21,8 @@
 
 #include "target/riscv/cpu-qom.h"
 
+typedef struct RISCVAIASocket RISCVAIASocket;
+
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 /**
  * kvm_riscv_set_irq:
@@ -29,7 +31,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
  * @level: %0 to clear the interrupt, non-zero to set it.
  */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ffd6e8868f70..dceb3ff55e17 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -859,7 +859,15 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
-        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
+        g_autofree RISCVAIASocket *aia_sockets =
+                g_new(RISCVAIASocket, socket_count);
+        for (i = 0; i < socket_count; i++) {
+            aia_sockets[i].hartid_base = s->soc[i].hartid_base;
+            aia_sockets[i].num_harts = s->soc[i].num_harts;
+        }
+
+        kvm_riscv_aia_create(aia_sockets, socket_count,
+                             IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              s->memmap[VIRT_APLIC_S].base,
                              s->memmap[VIRT_IMSIC_S].base,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5beb60233809..32f18a1589fe 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -48,7 +48,7 @@
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
 #include "system/runstate.h"
-#include "hw/riscv/numa.h"
+#include "hw/riscv/aia.h"
 
 #define PR_RISCV_V_SET_CONTROL            69
 #define PR_RISCV_V_VSTATE_CTRL_ON          2
@@ -1930,7 +1930,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                     "auto");
 }
 
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
@@ -1938,7 +1939,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     int ret, i;
     int aia_fd = -1;
     uint64_t default_aia_mode;
-    uint64_t socket_count = riscv_socket_count(machine);
     uint64_t max_hart_per_socket = 0;
     uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
     uint64_t socket_bits, hart_bits, guest_bits;
@@ -2039,8 +2039,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
     for (socket = 0; socket < socket_count; socket++) {
         socket_imsic_base = imsic_base + socket * (1U << group_shift);
-        hart_count = riscv_socket_hart_count(machine, socket);
-        base_hart = riscv_socket_first_hartid(machine, socket);
+        hart_count = sockets[socket].num_harts;
+        base_hart = sockets[socket].hartid_base;
 
         if (max_hart_per_socket < hart_count) {
             max_hart_per_socket = hart_count;
diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d893..f92916162804 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -9,7 +9,8 @@
 #include "qemu/osdep.h"
 #include "target/riscv/kvm/kvm_riscv.h"
 
-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
+                          uint32_t socket_count, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
-- 
2.55.0


