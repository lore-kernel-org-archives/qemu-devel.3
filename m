Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB260C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hH-0005KH-V5; Mon, 03 Jun 2024 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hE-0004un-2I
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hA-0006Nq-Vg
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so31632315ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413462; x=1718018262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gf09NafNEVyOO1I73va6raf97epWEC91xltk6mMdyo=;
 b=i1Xzlo3iDr4Y1UgIRBDv/Jp+5wdcH0Lnlf4S6IbBVwqMRXB/LH6rS5keuNpSFsx8Fg
 GMgiLOl8Mh4B5PUcJ6Tbk3wzZdU/OhpZ2zZXV1Fk9r2pbvG1Viv12pcNJZ8UAhV/lOC4
 SeKCQQp7jy5DMs/qjCVmJo1uqeL7qkUtT7zz5MCb1n/t2FxHXu5zp1tkGKjgkSGTKVqb
 8JlqzOqw3PI3FBF8uxyfwPzI2wKZicyzzEuWFdx0nFS+LiRb+q6aRaVBsQdqCaG/QjGQ
 e687kSKdK7/5X5AucoSbDMkreT509Cu1oMGkBmySmZCJ8n3sAcNO3wC1ATXyVBAy4BfW
 p9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413462; x=1718018262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gf09NafNEVyOO1I73va6raf97epWEC91xltk6mMdyo=;
 b=KI1BKt21zoilO1G2+rBZy5H9b+H7CkI+tcx8fO5qJU0BrmNkoQMFqI4X/4DBMLsxQ0
 ZdftDbRoZODAWruib+uLVuBHEB6V09Y+AMTVx0M4mvabvVNx3ay6kf/JNoC8eozCooc9
 gPiJidqA4jGEA0utch0BEQUUIWGgdZJfiTKlrSi+QnMpv0CH4b55T1zjy+6mv/hyg1t1
 8vTjvN2z7Gd3y95x9JvcvyneDXgEuAmgJegyaenndFqiwPeDWyT9oGVCDv3QAAhHP3wS
 mpOnZJlR8JnesP9tmG/aTpviETeD0eya2XrBEIM5g3+rmLfaMePNvt4Z4KScV6RIkeu4
 alNw==
X-Gm-Message-State: AOJu0YyD/9UJO+pKOGKGrQJFtjs+uz1Sbcth23HYMN7xHkxHgq2mweIv
 MayzGVWwNrqtEUzbWEZ1hFIqxiU+qYtXeRHTb4mFxDe04KRgTpy2WnQH2g==
X-Google-Smtp-Source: AGHT+IG2vOozz5kXjkwpva2ZNnm59tmZyZ8vomL74qaL0XxOdM3O015BTMX4hFAs2eM6EDiwSgjYDA==
X-Received: by 2002:a17:903:41c8:b0:1f6:5c5e:d84b with SMTP id
 d9443c01a7336-1f65c5eda75mr58686125ad.28.1717413462239; 
 Mon, 03 Jun 2024 04:17:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/27] target/riscv: Implement dynamic establishment of
 custom decoder
Date: Mon,  3 Jun 2024 21:16:31 +1000
Message-ID: <20240603111643.258712-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Huang Tao <eric.huang@linux.alibaba.com>

In this patch, we modify the decoder to be a freely composable data
structure instead of a hardcoded one. It can be dynamically builded up
according to the extensions.
This approach has several benefits:
1. Provides support for heterogeneous cpu architectures. As we add decoder in
   RISCVCPU, each cpu can have their own decoder, and the decoders can be
   different due to cpu's features.
2. Improve the decoding efficiency. We run the guard_func to see if the decoder
   can be added to the dynamic_decoder when building up the decoder. Therefore,
   there is no need to run the guard_func when decoding each instruction. It can
   improve the decoding efficiency
3. For vendor or dynamic cpus, it allows them to customize their own decoder
   functions to improve decoding efficiency, especially when vendor-defined
   instruction sets increase. Because of dynamic building up, it can skip the other
   decoder guard functions when decoding.
4. Pre patch for allowing adding a vendor decoder before decode_insn32() with minimal
   overhead for users that don't need this particular vendor decoder.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240506023607.29544-1-eric.huang@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.h | 15 +++++++++++++++
 target/riscv/cpu.c         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 target/riscv/translate.c   | 31 +++++++++++++++----------------
 5 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 746efd099a..04ab0f153a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -455,6 +455,7 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    const GPtrArray *decoders;
 };
 
 /**
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index f7b32417f8..ce94253fe4 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -26,4 +26,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
 
+struct DisasContext;
+struct RISCVCPUConfig;
+typedef struct RISCVDecoder {
+    bool (*guard_func)(const struct RISCVCPUConfig *);
+    bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
+} RISCVDecoder;
+
+typedef bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
+
+extern const size_t decoder_table_size;
+
+extern const RISCVDecoder decoder_table[];
+
+void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0d6fb9b4ba..abeb50369c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1134,6 +1134,7 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
+        riscv_tcg_cpu_finalize_dynamic_decoder(cpu);
     } else if (kvm_enabled()) {
         riscv_kvm_cpu_finalize_features(cpu, &local_err);
         if (local_err != NULL) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fedc035313..f59b5d7f2d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -863,6 +863,21 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 }
 
+void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
+{
+    GPtrArray *dynamic_decoders;
+    dynamic_decoders = g_ptr_array_sized_new(decoder_table_size);
+    for (size_t i = 0; i < decoder_table_size; ++i) {
+        if (decoder_table[i].guard_func &&
+            decoder_table[i].guard_func(&cpu->cfg)) {
+            g_ptr_array_add(dynamic_decoders,
+                            (gpointer)decoder_table[i].riscv_cpu_decode_fn);
+        }
+    }
+
+    cpu->decoders = dynamic_decoders;
+}
+
 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu)
 {
     return object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST) == NULL;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2c27fd4ce1..4cd6480558 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -35,6 +35,8 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#include "tcg/tcg-cpu.h"
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
@@ -114,6 +116,7 @@ typedef struct DisasContext {
     /* FRM is known to contain a valid value. */
     bool frm_valid;
     bool insn_start_updated;
+    const GPtrArray *decoders;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1123,21 +1126,16 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+const RISCVDecoder decoder_table[] = {
+    { always_true_p, decode_insn32 },
+    { has_xthead_p, decode_xthead},
+    { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
+};
+
+const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
+
 static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
-    /*
-     * A table with predicate (i.e., guard) functions and decoder functions
-     * that are tested in-order until a decoder matches onto the opcode.
-     */
-    static const struct {
-        bool (*guard_func)(const RISCVCPUConfig *);
-        bool (*decode_func)(DisasContext *, uint32_t);
-    } decoders[] = {
-        { always_true_p,  decode_insn32 },
-        { has_xthead_p, decode_xthead },
-        { has_XVentanaCondOps_p,  decode_XVentanaCodeOps },
-    };
-
     ctx->virt_inst_excp = false;
     ctx->cur_insn_len = insn_len(opcode);
     /* Check for compressed insn */
@@ -1158,9 +1156,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
                                              ctx->base.pc_next + 2));
         ctx->opcode = opcode32;
 
-        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
-            if (decoders[i].guard_func(ctx->cfg_ptr) &&
-                decoders[i].decode_func(ctx, opcode32)) {
+        for (guint i = 0; i < ctx->decoders->len; ++i) {
+            riscv_cpu_decode_fn func = g_ptr_array_index(ctx->decoders, i);
+            if (func(ctx, opcode32)) {
                 return;
             }
         }
@@ -1205,6 +1203,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
+    ctx->decoders = cpu->decoders;
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.45.1


