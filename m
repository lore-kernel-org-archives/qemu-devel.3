Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB1606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WR-0001FE-N7; Sun, 25 Oct 2026 12:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WE-0001BV-Jd; Sun, 25 Oct 2026 12:56:28 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WA-0004bx-WA; Sun, 25 Oct 2026 12:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=o5f42OaWmJyy0uLzEzVw2syhiFScLHs/Wy4A8G5vdgw=; b=EDFhLQbtXpi+/DNA/1ViWn47Cy
 Fs8xRN7jtSOtYX4+w0d2XolKSyr5M2czTgo54lVrGAUWW4e78bJ4qtT2x1//nWOrb3jiR0LkRBsO7
 7dGHIOX6QVH6LwPgbGrUKcmwOEtyaFAcldKy+IDaKifXwNfK1rpIPYNOQTtgUL9G33G5WyRXhvYDd
 cvdmw6H/nkupaj+UXDGegb56a+WvHpzy4Q0EmJ1jK1r9UIlASu+QTUQ6K5RZ+Qb+Ra48t2L3x53+D
 kbRNmxLYJ9XQbu05qEBD/gjd5yV9N30aPjArGXNvHfY8G0FOveC/Jf9L4IVCSJ4WMTvwu7W78U5Kg
 NpMg+g0g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kT-0l; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-1T; Sun, 25 Oct 2026 17:56:06 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:20 +0100
Subject: [PATCH v2 04/31] target/rx: add RXv3 DPFPU architecture state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-4-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=7591;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=sSDu9BW0tO++EF5C7bKj3owbDiRXZzDn9d3RG8G4yIc=;
 b=bUpzBkYq6FaXqnvxiOEBQXcLX3/nK2SomAyoV4n/voAzPBulE35UygN1VnkcXu8QF5p6Su04Y
 Jgzn4eq7Lb8BmejKSWTFcjnLOHkesilC2PrwCBOxqRfwpovh1s4fYoF
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the double-precision FPU state: DR0-DR15, the DPFPU control
registers (DPSW, DCMR, DECNT, DEPC) with their field definitions and
write masks, and a separate float_status for the DPFPU. The DPFPU has
its own status word and does not refer to the single-precision FPSW,
so it cannot share fp_status. DECNT comes out of reset with EHM set.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu.c       | 13 +++++++++
 target/rx/cpu.h       | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/translate.c | 27 +++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 73796c3f3b..3bc5d96ac0 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -105,6 +105,8 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     env->regs[0] = env->isp = env->usp = 0;
     env->extb = 0xffffff80;
     env->fpsw = 0;
+    /* DECNT comes out of reset with EHM set; the rest of DPSW is zero. */
+    env->dcr[RX_DCR_DECNT] = RX_DECNT_RESET;
     set_flush_to_zero(1, &env->fp_status);
     set_flush_inputs_to_zero(1, &env->fp_status);
     /*
@@ -124,6 +126,17 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
      * be the correct setting.
      */
     set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+
+    /*
+     * The DPFPU keeps its own softfloat state: DPSW carries a separate
+     * rounding mode (DRM) and denormal setting (DDN) from the FPSW. The
+     * NaN and denormal conventions match the single-precision unit.
+     */
+    set_flush_to_zero(1, &env->dp_status);
+    set_flush_inputs_to_zero(1, &env->dp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->dp_status);
+    set_float_default_nan_pattern(0b01000000, &env->dp_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &env->dp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 8741d759b9..4c55b0bd7d 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -67,8 +67,55 @@ FIELD(FPSW, FX, 30, 1)
 FIELD(FPSW, FLAGS, 26, 4)
 FIELD(FPSW, FS, 31, 1)
 
+/* DPSW define. The DPFPU status word mirrors the FPSW layout exactly. */
+REG32(DPSW, 0)
+FIELD(DPSW, DRM, 0, 2)
+FIELD(DPSW, DCV, 2, 1)
+FIELD(DPSW, DCO, 3, 1)
+FIELD(DPSW, DCZ, 4, 1)
+FIELD(DPSW, DCU, 5, 1)
+FIELD(DPSW, DCX, 6, 1)
+FIELD(DPSW, DCE, 7, 1)
+FIELD(DPSW, CAUSE, 2, 6)
+FIELD(DPSW, DDN, 8, 1)
+FIELD(DPSW, DEV, 10, 1)
+FIELD(DPSW, DEO, 11, 1)
+FIELD(DPSW, DEZ, 12, 1)
+FIELD(DPSW, DEU, 13, 1)
+FIELD(DPSW, DEX, 14, 1)
+FIELD(DPSW, ENABLE, 10, 5)
+FIELD(DPSW, DFV, 26, 1)
+FIELD(DPSW, DFO, 27, 1)
+FIELD(DPSW, DFZ, 28, 1)
+FIELD(DPSW, DFU, 29, 1)
+FIELD(DPSW, DFX, 30, 1)
+/* DFS is the OR of DFV, DFO, DFZ and DFU only; DFX is not included. */
+FIELD(DPSW, FLAGS, 26, 4)
+FIELD(DPSW, DFS, 31, 1)
+
+/*
+ * Writable bits of DPSW: DRM, the DC* causes, DDN, the DE* enables and the
+ * DF* flags. The reserved bits and the read-only DFS summary are masked out.
+ */
+#define RX_DPSW_WRITE_MASK 0x7c007dff
+/* The DC* cause bits, which MVTDC can only clear, never set. */
+#define RX_DPSW_CAUSE_MASK 0x000000fc
+
+/* DECNT define: DP exception information preservation. */
+REG32(DECNT, 0)
+FIELD(DECNT, EHM, 0, 1)
+FIELD(DECNT, EHS, 16, 1)
+#define RX_DECNT_RESET 0x00000001   /* EHM = 1 out of reset */
+
+/* DCMR holds only the RES bit; everything else reads as 0. */
+#define RX_DCMR_WRITE_MASK 0x00000001
+
 enum {
     NUM_REGS = 16,
+    /* RXv3 DPFPU: DR0-DR15 are dedicated 64-bit registers, not GPR pairs. */
+    NUM_DREGS = 16,
+    /* RXv3 DPFPU control registers: DPSW, DCMR, DECNT, DEPC. */
+    NUM_DCREGS = 4,
 };
 
 #define RX_EXCP_TRAP_COUNT          0x100
@@ -84,6 +131,29 @@ enum {
 
 #define RX_EXCP_COUNT   (RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT)
 
+/* RXv3 DPFPU control register numbers (MVFDC/MVTDC/DPUSHM.L/DPOPM.L). */
+enum {
+    RX_DCR_DPSW  = 0,
+    RX_DCR_DCMR  = 1,
+    RX_DCR_DECNT = 2,
+    RX_DCR_DEPC  = 3,
+};
+
+/*
+ * DCMR.RES, bit 0, holds the result of the last DCMP; MVFDR copies it into
+ * the PSW Z flag.
+ */
+#define RX_DCMR_RES_BIT 0
+
+/*
+ * DCMP condition field. The four documented mnemonics (un, eq, lt, le) are
+ * a three bit mask of the relations that make DCMR.RES true, which is why
+ * le == lt | eq == 6.
+ */
+#define RX_DCMP_UN  1
+#define RX_DCMP_EQ  2
+#define RX_DCMP_LT  4
+
 /*
  * Instruction set architecture revision implemented by a CPU model.
  * Later revisions are supersets of earlier ones, so instruction gating is a
@@ -117,6 +187,10 @@ typedef struct CPUArchState {
     uint32_t fpsw;
     uint64_t acc;
 
+    /* RXv3 double-precision FPU (DPFPU) */
+    uint64_t dr[NUM_DREGS];     /* DR0-DR15 */
+    uint32_t dcr[NUM_DCREGS];   /* DPSW, DCMR, DECNT, DEPC */
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
@@ -127,6 +201,7 @@ typedef struct CPUArchState {
     uint32_t ack_irq;           /* execute irq */
     uint32_t ack_ipl;           /* execute ipl */
     float_status fp_status;
+    float_status dp_status;
     qemu_irq ack;               /* Interrupt acknowledge */
 } CPURXState;
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index b398af9531..b4e105fb8b 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -70,6 +70,9 @@ static TCGv_i32 cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
 static TCGv_i32 cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
 static TCGv_i32 cpu_fintv, cpu_intb, cpu_extb, cpu_pc;
 static TCGv_i64 cpu_acc;
+/* RXv3 DPFPU state */
+static TCGv_i64 cpu_dregs[NUM_DREGS];
+static TCGv_i32 cpu_dcregs[NUM_DCREGS];
 
 #define cpu_sp cpu_regs[0]
 
@@ -152,6 +155,15 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      i, env->regs[i], i + 1, env->regs[i + 1],
                      i + 2, env->regs[i + 2], i + 3, env->regs[i + 3]);
     }
+    if (RX_CPU_GET_CLASS(cs)->isa_version >= RX_ISA_V3) {
+        for (i = 0; i < NUM_DREGS; i += 2) {
+            qemu_fprintf(f, "dr%d=0x%016" PRIx64 " dr%d=0x%016" PRIx64 "\n",
+                         i, env->dr[i], i + 1, env->dr[i + 1]);
+        }
+        qemu_fprintf(f, "dpsw=0x%08x dcmr=0x%08x decnt=0x%08x depc=0x%08x\n",
+                     env->dcr[RX_DCR_DPSW], env->dcr[RX_DCR_DCMR],
+                     env->dcr[RX_DCR_DECNT], env->dcr[RX_DCR_DEPC]);
+    }
 }
 
 static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
@@ -2317,4 +2329,19 @@ void rx_translate_init(void)
     ALLOC_REGISTER(extb, "EXTB");
     cpu_acc = tcg_global_mem_new_i64(tcg_env,
                                      offsetof(CPURXState, acc), "ACC");
+
+    for (i = 0; i < NUM_DREGS; i++) {
+        g_autofree char *name = g_strdup_printf("DR%d", i);
+        cpu_dregs[i] = tcg_global_mem_new_i64(tcg_env,
+                                              offsetof(CPURXState, dr[i]),
+                                              name);
+    }
+    for (i = 0; i < NUM_DCREGS; i++) {
+        static const char * const dcrnames[NUM_DCREGS] = {
+            "DPSW", "DCMR", "DECNT", "DEPC"
+        };
+        cpu_dcregs[i] = tcg_global_mem_new_i32(tcg_env,
+                                               offsetof(CPURXState, dcr[i]),
+                                               dcrnames[i]);
+    }
 }

-- 
2.53.0


