Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9BEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuke-0005bl-SL; Wed, 19 Jun 2024 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJukd-0005am-8W
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJukb-0008OB-58
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cfe600cbeso2280270a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718801359; x=1719406159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYUdrW7l/DLW1Z4TgfkAfyXdWOn38cJZ9hefdlLR9fY=;
 b=Mx9sKbqsaoRciH+f7EVKysLiYb5IcT5XyY/2LZSRZx2EQxzL04gXOdodNoAvBAmdhq
 g9Fy3p0C73pCW2qNFzksm/FWcrT4RuQFGx2SckvDws/xGjx7Eqr3524vFPG3Aktv+fzS
 ohYwXXGDEdbzhZUG5DRKGJVKfqPODA020sCkYsmr3V+Pcek3mG/W1GLHEc5lmD8WBoDl
 +l/c8SgWIqw3jurLDGED+0HtgpqpjM8q6BbEY0PUOcGdhJ2ZuRbHqn0HxP6H5GY74IyY
 nUCe1apk8wrVyzHvYejFH3KXy1sizXUFSgYIKEh0QNcXiHiGXylIjSnPDPYfgXeBtzyj
 POqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801359; x=1719406159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYUdrW7l/DLW1Z4TgfkAfyXdWOn38cJZ9hefdlLR9fY=;
 b=SxuYocwsa4mjeBlFqR2DCQH9wJ/3XnSlOA4na0bbDzWJqWYnjimHx/hBxp8jYkFlFN
 g3n0ko+khnPap45VnUg/MEUbLpN8inCGJZ7WZXhaq/T3IFz4+vimE3GQKgvAR2+hBCCD
 QsQ6a3q1qwT53ut5LQ6vkNc7VAp5cpjBelFH3d7AiZaL0bHlFSTXnk8MlxAQtWDSqnSx
 wbj7w+aQPB3bWeLw82jo7io8raa2okopcRSQT4WDYPqcru1D1WuUeZoiGsPDlaJ1FIIF
 VOstrDuciCxIqeb9vhL+5GEZcCH4oAZyhCF4r6GI5aJBuC84BttLOlVruh2WdEvjI/4I
 nGCw==
X-Gm-Message-State: AOJu0YyJ3fxcESpPooUGr6gwzlXLu7HpIzTKY6S0ausXpL2cFnIYgcet
 I15xCnfte14BCO8ekhC9mRkdVLp7Bum08XaSw0C5Qpnf/kY85FOTbQ4EvHqjZ0Kr+ujdP4OvS63
 o
X-Google-Smtp-Source: AGHT+IHJfUKhFHzJHzfPU66S5QcsRP+yQ4xbZFqcceYymLp9T1hO0tBxFqJxeFaPiQihWGxUTg43UQ==
X-Received: by 2002:aa7:c70c:0:b0:57d:e27:4774 with SMTP id
 4fb4d7f45d1cf-57d0e2748a4mr1049767a12.37.1718801359241; 
 Wed, 19 Jun 2024 05:49:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d1606e7absm175608a12.69.2024.06.19.05.49.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jun 2024 05:49:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/arm: Always build Aarch64 gdbstub helpers
Date: Wed, 19 Jun 2024 14:49:03 +0200
Message-ID: <20240619124903.56898-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240619124903.56898-1-philmd@linaro.org>
References: <20240619124903.56898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In order to have a single binary for ARM and Aarch64,
always build Aarch64 gdbstub support.

Since arm_cpu_register_gdb_regs_for_features() checks
on arm_feature(env, ARM_FEATURE_AARCH64), the Aarch64
gdb registers won't be registered on 32-bit ARM.
There should be no functional changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h       | 8 +++-----
 target/arm/internals.h | 2 --
 target/arm/gdbstub.c   | 4 ----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f..1240754f71 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -180,12 +180,12 @@ typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-#ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
 } ARMPredicateReg;
 
+#ifdef TARGET_AARCH64
 /* In AArch32 mode, PAC keys do not exist at all.  */
 typedef struct ARMPACKey {
     uint64_t lo, hi;
@@ -606,13 +606,11 @@ typedef struct CPUArchState {
     struct {
         ARMVectorReg zregs[32];
 
-#ifdef TARGET_AARCH64
         /* Store FFR as pregs[16] to make it easier to treat as any other.  */
 #define FFR_PRED_NUM 16
         ARMPredicateReg pregs[17];
         /* Scratch space for aa64 sve predicate temporary.  */
         ARMPredicateReg preg_tmp;
-#endif
 
         /* We store these fpcsr fields separately for convenience.  */
         uint32_t qc[4] QEMU_ALIGNED(16);
@@ -1165,6 +1163,8 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, DumpState *s);
@@ -1194,8 +1194,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
 
 #ifdef TARGET_AARCH64
-int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
-int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..79dd62dd46 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1632,7 +1632,6 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
   return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
 }
 
-#ifdef TARGET_AARCH64
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
@@ -1648,7 +1647,6 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-#endif
 
 /* Read the CONTROL register as the MRS instruction would. */
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 508b3d8116..92fa716826 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -311,7 +311,6 @@ static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_sysreg_feature.desc;
 }
 
-#ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -671,7 +670,6 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
 
     return &cpu->dyn_svereg_feature.desc;
 }
-#endif
 
 #ifdef CONFIG_TCG
 typedef enum {
@@ -847,7 +845,6 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * The lower part of each SVE register aliases to the FPU
          * registers so we don't need to include both.
          */
-#ifdef TARGET_AARCH64
         if (isar_feature_aa64_sve(&cpu->isar)) {
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
@@ -870,7 +867,6 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-pauth.xml"),
                                      0);
         }
-#endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-- 
2.41.0


