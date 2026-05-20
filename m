Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01418CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgd-00019F-VA; Wed, 20 May 2026 00:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgc-00018r-7k
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:38 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgY-0003nz-W6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso4230651a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251852; x=1779856652; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2GwP5cCH4UfiaQKX7UsB28XhQ0mXlfLfaYCHR8sP+pE=;
 b=LVyCdziWMjFETL7MoMBBfV+PMswAPzseN3XwTrtw/m3ckmHKLCoCTt/QHRSv2+GCmL
 CvjrW7mvSYg2rW2jq+Z/SrW/sbgEXp+1hEpgVFXMK0qEUj7U75PguJUsifjpKIwjjv2U
 X2yFfHGExm0xA1aPjXvpWOVGFc3ibjqC4O65YTDh4cDLxxg98jF6hskBhTLk4Hh8Z/mJ
 gbnH23F5uSnq0Ds47AGNJAGOtQS6s8zygNK390bwBK06Ze6LK0myTle8xM7QMrHkqp4Q
 afyeSrAUb3AHSC8KpB53K7XUi1LZiEMpDM78uS90IY+pZCNk9S8bdXYhOPYPDQ6usgFE
 fgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251852; x=1779856652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2GwP5cCH4UfiaQKX7UsB28XhQ0mXlfLfaYCHR8sP+pE=;
 b=L8I8Bdfdr60gUZzNj7CPhy+DoMivhRXtLjgg6P52NLSxIatw2IyVFmRySx4zAuGaT2
 fFpHHvOQAgUDDHVJvD+eMIc4C58X6DPpK/NQ49bF6crzDI5b8H/yBFOCSsfvkjTF09yK
 uaAc1uNauSf68uQD9Y/9vnIeF5OHwNWWCIxBUsaFmJ/E97CU0ZsuPuUqwSYSBwRC5aWr
 oN66KJ5GrE0+19xFA+8U2P9Ec4bJ0G01Wi1c5tnh164LuPf4kuAkpPpFrZbmsXVUnvzY
 mTKDwJw7FHakP2ahUc5AdekVotmqkWlHZpdVsd7y0FxOp7kR1nYnUGIFj53TAVjPoBW+
 7vRw==
X-Gm-Message-State: AOJu0Yy+PoNkd1D4S+H/JQTI6k+jmQv2W1m3iEAA2w2EKnl1bDZb4N+d
 XgFQYddq/YzhTmYSPysZ8YlBfLjW1WMBRn5ro62n0YQKNUiSku3VwmKd
X-Gm-Gg: Acq92OH2mO3QerbYGIV4dkeSolxFvcofCpD4XOWG+Y9DFzOuZhYklra75gxtQcKZOFH
 nhO7afN63ehaIW8+ahL0/ccY+7g4OIQdNT/YtFComWS/HvttnC/TGuQcxGmf6uvEWAHygs79XNH
 betVPh5Txyh68P6gRlk2yGrHn3zAWAI267xCCLVFUNbBW0pTkXJ/IGD/S69wxDOcuzepaU45yA8
 r0vr4++66KNiSmhISJjiNw4Kr25RChzd9x1QmTDGE4J4VIsVluXiJ7LtzW3vkRJcNj/+Vs0sZTP
 C/VFwHGqzpGDhRklb4nEO1QpGGOdV9c4i0vn++PaFn2ZidUfynEiulYAZ4mVUj/Vnf3XWyrgAw2
 +702/0LElh1NvY6BF0RNDixszN/SYLd+NrLmw9M/SjWjCbA3H9YgHJxOF6QksXjUJn1POjAXvY0
 FwyyV/+4N1dnHvlxnpVhAp5J3lJP3CFoOG554UrQ9k7b7GHGtmcRJv/xr8YekpKtti0sAEyA2YR
 yZC+L4GrxIISrRcrWNHIjchUFplR3afti6zT0h1wIdEcwVyVoMcnj5sCnW0zepr90T6
X-Received: by 2002:a05:6830:6417:b0:7dc:c4ae:a679 with SMTP id
 46e09a7af769-7e4ea07276amr15803710a34.9.1779251852368; 
 Tue, 19 May 2026 21:37:32 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:09 -0600
Subject: [PATCH v10 15/45] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-15-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add per-thread Octeon multiplier state for the MPL and P limb banks used
by the VMULU/VMM0/V3MULU instruction family.

Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
both banks as uint64_t arrays so the TC state matches the architected
64-bit limb layout used by Octeon68XX user-mode code.

Expose MPL/P as global TCG variables so the multiplier translators can
expand inline without helper calls.

Migrate the multiplier registers in an Octeon-only subsection so
non-Octeon CPU models do not grow migration state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split the multiplier state out of the combined Octeon arithmetic and
    memory instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Document and keep the Octeon3 MPL3-MPL5/P3-P5 high-lane state used by
    the two-source MTM/MTP forms.

Changes v7 -> v8:
  - Incorporate Richard Henderson's v7.5 global TCG variable setup for
    inline multiplier translation.
---
 target/mips/cpu.h            | 12 ++++++++++++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c  | 18 ++++++++++++++++++
 target/mips/tcg/translate.h  |  2 ++
 4 files changed, 65 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b478f834c1..346713705a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -459,6 +459,14 @@ typedef struct mips_def_t mips_def_t;
 
 
 typedef struct TCState TCState;
+
+/*
+ * Octeon3 adds a second bank of multiplier/product limbs used by the
+ * two-source MTM/MTP forms: MPL0..2/P0..2 from rs and MPL3..5/P3..5 from rt.
+ */
+#define OCTEON_MULTIPLIER_LANES 3
+#define OCTEON_MULTIPLIER_REGS (2 * OCTEON_MULTIPLIER_LANES)
+
 struct TCState {
     target_ulong gpr[32];
 #if defined(TARGET_MIPS64)
@@ -497,6 +505,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[OCTEON_MULTIPLIER_REGS];
+        uint64_t P[OCTEON_MULTIPLIER_REGS];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 5880b401b0..f988b3695b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -120,6 +120,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -247,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -363,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index dac30aff8d..123d2c89c3 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1179,6 +1179,8 @@ static TCGv cpu_lladdr, cpu_llval;
 static TCGv_i32 hflags;
 TCGv_i32 fpu_fcr0, fpu_fcr31;
 TCGv_i64 fpu_f64[32];
+TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 
 static const char regnames_HI[][4] = {
     "HI0", "HI1", "HI2", "HI3",
@@ -15276,6 +15278,22 @@ void mips_tcg_init(void)
                                                         active_tc.gpr_hi[i]),
                                                rname);
     }
+
+    for (unsigned i = 0; i < OCTEON_MULTIPLIER_REGS; ++i) {
+        static const char mpl_names[OCTEON_MULTIPLIER_REGS][5] = {
+            "MPL0", "MPL1", "MPL2", "MPL3", "MPL4", "MPL5",
+        };
+        static const char p_names[OCTEON_MULTIPLIER_REGS][3] = {
+            "P0", "P1", "P2", "P3", "P4", "P5",
+        };
+
+        oct_mpl[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.MPL[i]),
+            mpl_names[i]);
+        oct_p[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.P[i]),
+            p_names[i]);
+    }
 #endif /* !TARGET_MIPS64 */
     for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 89dde1e712..ab2e217367 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -189,6 +189,8 @@ void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz, int crc32c);
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
 extern TCGv_i64 cpu_gpr_hi[32];
+extern TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+extern TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 #endif
 extern TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
 extern TCGv_i32 fpu_fcr0, fpu_fcr31;

-- 
2.54.0


