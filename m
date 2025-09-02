Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8BACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQns-0001yF-CI; Tue, 02 Sep 2025 09:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnj-0001Nx-Q6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnf-0004aS-Lw
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3da4c14a5f9so416070f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818706; x=1757423506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o+jLO/3nb8aNGzAALSlOJPeY6QIm6fDGV5/Q+uhwhJY=;
 b=E8J6kRT/zfOPJYldyRnrSQvDOjp+hVCLIiBWMEVFR44bDwgpqhGLUdrEN8WPpBCtAL
 50bl/BOhS/gjE2RzhbBAcTEz9YiycS2Q4JB0QnTx3Xilxn+5LhDr9Yuw+p+1lqhGB9C4
 A/tUMqplv67VFmCkOqPfASB1ZTora+tJssgBDY0XO5Td6jSvNVrejFYfl3sOmA4AD3Py
 q2To8OLMM0YJKlh8k3rN6yohlw9ZqLzgKAQ3crMNZXDvjqZyh1mQhwujE4KtJyujB4q4
 9PGqJu2wOJb+sRnf+NQ+iq+RByqmLdJAiOcztR/z3w+Lh15r2DM9uEKWniwAMgZPd6et
 vw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818706; x=1757423506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+jLO/3nb8aNGzAALSlOJPeY6QIm6fDGV5/Q+uhwhJY=;
 b=s7+22fjrA3vS4E/Lv3u6utu0joLFfpI1r5pcdUGt3g6f8xbZeNlTer/nTn0biKxAkp
 VnPi6403AGSzOdzvRBeZAtUEwYDv2opRZx4qciqlcDz3BcoV1CxNWomzaB7ZXI6CbG2z
 vEF2Igwqgv9QrO0ODnqZ24f0TnxFO6TAeFMZ0SqTQvfQt6Qgmx19YzuqVJBvMlNvZqXy
 FvssrP38HfkIATftLR9kTcAfSQlrTbkcR04su4ELYepumTzgXzLPwNWMgWysPtlZmAjJ
 is2YglfPfONLLSxleb7hVlmBNgK5D99hok49Bl3uPStTjuRI46LDA4RZXE1qYOC6npe+
 mMhA==
X-Gm-Message-State: AOJu0Yx5orHY+N/oMjGx2GQ0vZyU6QXkYYNX5SaLiHCAcQUlyL+KIIDn
 7U3DGQuojMgTfQUoJTbH5cWQklMUy4rGP+dbz6bVokgFtHhw8KkZWe1Of6yURNJJFJUBJwnv4mI
 q6JUZ
X-Gm-Gg: ASbGncsY6OMs58aKsXGMYjwwP4DUPOoXqgyg3ZlZgtaJx5kt+AZtiZwSUVxGl4KpdOM
 ebS44HBHF1ogDcgqgY2n/as7jeRFp6MV1s6IlxLFDEWu4t/k7I3yasPy6tW/kV8NBmWyg6/zqnS
 TF+Nn8FklfafYANWGnMdjA4/5GSmuB9VrYQg9etHfLDS/sMJ1k2K/KU5pgof1gDZ4Rlo0PWk7mn
 MkA6l9p+YKhGOIVZWspO9rLd84h6NsJ1J3QIfEE3qCXxhtIuyMdxUA4j2ysGBJHQ51XB7/EVrEr
 0oKacA7VCkKDPtDrz3hJC8VZ+2GcybtUA2Z65O+TXW/BS3ckNAFPF/f8tZuD27YS1KSu593kANC
 3x8yBszu4Uuo62phercYRt+Nw3RZJGZHIUlEkudtz/q37Hnp8jYd0ME7M8Lgu12Ni8M3muB5m
X-Google-Smtp-Source: AGHT+IEnd791XwRWyGuvmSYvq//9aPuv/ag6els0XgvtXAc+rU1ya6Xfaa3gOoas9ehRtwJtx6lUMg==
X-Received: by 2002:a05:6000:2409:b0:3d6:4596:8a3a with SMTP id
 ffacd0b85a97d-3d645968c73mr4991116f8f.17.1756818705909; 
 Tue, 02 Sep 2025 06:11:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a5asm19367334f8f.55.2025.09.02.06.11.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/39] hw/ppc: Fix build error with CONFIG_POWERNV disabled
Date: Tue,  2 Sep 2025 15:09:56 +0200
Message-ID: <20250902131016.84968-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aditya Gupta <adityag@linux.ibm.com>

Currently when CONFIG_POWERNV is not enabled, the build fails, such as
with --without-default-devices:

    $ ./configure --without-default-devices
    $ make

    [281/283] Linking target qemu-system-ppc64
    FAILED: qemu-system-ppc64
    cc -m64 @qemu-system-ppc64.rsp
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
    .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
    .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
    collect2: error: ld returned 1 exit status
    ...

This is since target/ppc/misc_helper.c references PowerNV specific
'pnv_chip_find_core' call.

Split the PowerNV specific SPRD code out of the generic PowerPC code, by
moving the SPRD code to pnv.c

Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250820122516.949766-2-adityag@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h         |  4 ++
 hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/misc_helper.c | 59 +++------------------------
 3 files changed, 96 insertions(+), 53 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811f..0e26e4343de 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1522,6 +1522,10 @@ struct PowerPCCPUClass {
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int  (*check_attn)(CPUPPCState *env);
+
+    /* Handlers to be set by the machine initialising the chips */
+    uint64_t (*load_sprd)(CPUPPCState *env);
+    void (*store_sprd)(CPUPPCState *env, uint64_t val);
 };
 
 static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d84c9067edb..9c74f46091a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
@@ -1794,12 +1795,83 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static uint64_t pnv_handle_sprd_load(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        return pc->scratch[(sprc >> 3) & 0x7];
+
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used anywhere.
+             */
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
+        }
+        /* fallthru */
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+    return 0;
+}
+
+static void pnv_handle_sprd_store(CPUPPCState *env, uint64_t val)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    int nr;
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        /*
+         * Log stores to SCRATCH, because some firmware uses these for
+         * debugging and logging, but they would normally be read by the BMC,
+         * which is not implemented in QEMU yet. This gives a way to get at the
+         * information. Could also dump these upon checkstop.
+         */
+        nr = (sprc >> 3) & 0x7;
+        pc->scratch[nr] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+}
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     Pnv9Chip *chip9 = PNV9_CHIP(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv9Psi *psi9 = &chip9->psi;
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -1827,6 +1899,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE interrupt controller (POWER9) */
     object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
                             PNV9_XIVE_IC_BASE(chip), &error_fatal);
@@ -2078,6 +2156,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv10Chip *chip10 = PNV10_CHIP(dev);
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -2105,6 +2185,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE2 interrupt controller (POWER10) */
     object_property_set_int(OBJECT(&chip10->xive), "ic-bar",
                             PNV10_XIVE2_IC_BASE(chip), &error_fatal);
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e7d94625185..0e625cbb704 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -328,69 +328,22 @@ target_ulong helper_load_sprd(CPUPPCState *env)
      * accessed by powernv machines.
      */
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    if (pcc->load_sprd) {
+        return pcc->load_sprd(env);
     }
 
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        return pc->scratch[(sprc >> 3) & 0x7];
-
-    case 0x1e0: /* core thread state */
-        if (env->excp_model == POWERPC_EXCP_POWER9) {
-            /*
-             * Only implement for POWER9 because skiboot uses it to check
-             * big-core mode. Other bits are unimplemented so we would
-             * prefer to get unimplemented message on POWER10 if it were
-             * used anywhere.
-             */
-            if (pc->big_core) {
-                return PPC_BIT(63);
-            } else {
-                return 0;
-            }
-        }
-        /* fallthru */
-
-    default:
-        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
-    }
     return 0;
 }
 
 void helper_store_sprd(CPUPPCState *env, target_ulong val)
 {
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    int nr;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
-    }
-
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        /*
-         * Log stores to SCRATCH, because some firmware uses these for
-         * debugging and logging, but they would normally be read by the BMC,
-         * which is not implemented in QEMU yet. This gives a way to get at the
-         * information. Could also dump these upon checkstop.
-         */
-        nr = (sprc >> 3) & 0x7;
-        pc->scratch[nr] = val;
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
+    if (pcc->store_sprd) {
+        return pcc->store_sprd(env, val);
     }
 }
 
-- 
2.51.0


