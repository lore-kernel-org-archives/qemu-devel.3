Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A46CD5BAB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDx-0006yK-P5; Tue, 19 May 2026 12:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDw-0006wq-1d
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:16 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDt-0000pV-1o
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:15 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6966f99716fso1921289eaf.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207792; x=1779812592; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0jVrLkSHknvVMOmXWoSrZsG6N2tjdXBVtgmIsqR7xU=;
 b=XMmjWcvFg2tB+3A4b1w/VNS0kgzOAqicYKmV6TWX6PUsrtG/dOXSHG0p9/zmMl2yYd
 PCLwvcGsOl55UGpqVx+2T8IUyiG/NO0BSAyr329oxqZlEevjzfq+hQG9vwdTiEarXRsU
 WSLeEeRxaDc7tQkyRfON/TZnG0Xe/VX0FAIsBg7/lN66IBLgRF/wrVG8fJFZTHPDHuzW
 QjVzTBZnWo5sZyvjSlZagzRYWXXIFa5e1SEdKMhNDbqykDTJCfzrcfYxpF96KSwz1hYf
 PBF8go3h1FK2MzyZH5VwimqGK+j/pecJQSF6kZXzX4VHBHtF2aLh2mj8HIl+gilDenO5
 hlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207792; x=1779812592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O0jVrLkSHknvVMOmXWoSrZsG6N2tjdXBVtgmIsqR7xU=;
 b=kTi6PdooQMt6PVRu4EMfANHquoVDmsjf1locjukAMHZIoWHa4vrZk7hxuh8NIw5U+K
 8OMm9jQyPpGmH9iJpaYHcRCAxTZUCJ5PX06QLWyYhlXeV3rqMZHeqTokc94g4lH8ZIcv
 V2f2gnAuOQBldZW3nhFRtX66BxDGaArsdAAQO27O5WwnvKbSOqb9hvjQ/CILhRLzdpRI
 CuoMi4i2Sfz/X1alkmjdaINdVhlPq4q7AR8JfJaOoRcc7mUdMw4Gj2kg4IMaAo0dvh4P
 zLyDqEaGdCO+aURGzjp1dZBjM1X3SLukhoGctwV/WhyLBwFqIZywvc1+qMan4yb81/Bq
 7stw==
X-Gm-Message-State: AOJu0YwTdhowmhL5uZR6F1uzrcr5zZ2u9cdoVSHvY47xq63KX5fqtnOJ
 hID3xJv7IzfIs0c26BPtwgZwjgfBpjRskZHWCpbhel0lOUIJMLTrWLk/rijasA==
X-Gm-Gg: Acq92OHqqsjhYauih18vhhu7Gv6zd5Ozy1vNL0+cxVal345RMsc2s6WAfDvgQ2VAE4N
 OxziaUm7iflY5FzPumQJ8ZgPnrgvdT4YukHlMQaM/8arRIlmUQbc4Vc1vRr1cCsDeK9fQy9OYLb
 KKxYv2akGfRNt8nm7YrtdtSUWBuSigJ9DwCpoJQ69yPe5s5zrE9UftrwJLgfLQH1GIiGy2QnmMp
 +nyL8K6pavWTJwW+wG3q/3Yu2VI61p0jCl3SYIhVf+xoAnl7PYIfuQxn4fUoOtskpdXlGBAWu+2
 zxIpKPC9t17aT1vIE2qnLhgDU4Yhej8ae3agi/VMz+0A+fTvaJW+cjzUQIftotkr0JcY/8dg6kR
 a1sXdbsol7gRx9VdSFgMoC3hxdQ9zDw096tuxxitQXVOAU5qdGgwl8sJozDEQ493JYDpd6LGGGL
 GBSHiIhhQtWXUhqfehUGW8gU7P6L6ZhMQg3X1AYSX+Qtglp308QZeNqRYL42JEW6v3rXTOlKknm
 ViAO5UNeN2OBMLFeF9NZKgWYagcZHZ1AcACcv/QDZiDhIzKWVg314uzEq11myvZ2zAjQ9Wm2Ig5
 mZs=
X-Received: by 2002:a05:6820:627:b0:69b:95dd:46f0 with SMTP id
 006d021491bc7-69c9437cddemr13083934eaf.33.1779207791596; 
 Tue, 19 May 2026 09:23:11 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:38 -0600
Subject: [PATCH v9 36/40] target/mips: add Octeon CHORD and LLM COP2
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-36-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2e.google.com
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

Add the Octeon CHORD hardware register access path and the LLM 36-bit
and 64-bit read and write windows. Model both CHORD access forms,
including the RDHWR $30 path and the legacy DMFC2 alias.

Implement sparse backing storage for the two LLM sets so user-mode code
can save, restore, and probe the architectural state without allocating a
full hardware-sized backing array.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split CHORD and LLM helpers into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation LLM helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Use neutral selector-slot wording for the LLM/CHORD alias comment.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Rename sparse LLM backing fields from llm_narrow/llm_wide to
    llm36/llm64 to match the 36-bit and 64-bit selector windows.
---
 target/mips/cpu.c               |  67 ++++++++++++++++++++++++++
 target/mips/cpu.h               |   5 ++
 target/mips/helper.h            |   9 ++++
 target/mips/internal.h          |   3 ++
 target/mips/system/machine.c    |  67 ++++++++++++++++++++++++++
 target/mips/tcg/octeon_crypto.c | 103 ++++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c     |   6 +++
 target/mips/tcg/translate.c     |   8 ++++
 8 files changed, 268 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 57935adea4..a2b9f6634f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
+#include "qemu/qtree.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
@@ -183,6 +184,57 @@ static bool mips_cpu_has_work(CPUState *cs)
 
 #include "cpu-defs.c.inc"
 
+static gint mips_octeon_u64_tree_compare(gconstpointer a, gconstpointer b,
+                                         gpointer user_data)
+{
+    uint64_t av = *(const uint64_t *)a;
+    uint64_t bv = *(const uint64_t *)b;
+
+    return (av > bv) - (av < bv);
+}
+
+QTree *mips_octeon_llm_tree_new(void)
+{
+    return q_tree_new_full(mips_octeon_u64_tree_compare,
+                           NULL, g_free, g_free);
+}
+
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr)
+{
+    uint64_t key = addr;
+    uint64_t *value = tree ? q_tree_lookup(tree, &key) : NULL;
+
+    return value ? *value : 0;
+}
+
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value)
+{
+    uint64_t *key;
+    uint64_t *stored;
+
+    if (!*treep) {
+        *treep = mips_octeon_llm_tree_new();
+    }
+
+    key = g_new(uint64_t, 1);
+    stored = g_new(uint64_t, 1);
+    *key = addr;
+    *stored = value;
+    q_tree_replace(*treep, key, stored);
+}
+
+static void mips_octeon_destroy_llm_state(MIPSOcteonCryptoState *crypto)
+{
+    if (crypto->llm36) {
+        q_tree_destroy(crypto->llm36);
+        crypto->llm36 = NULL;
+    }
+    if (crypto->llm64) {
+        q_tree_destroy(crypto->llm64);
+        crypto->llm64 = NULL;
+    }
+}
+
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -194,6 +246,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 
+    mips_octeon_destroy_llm_state(&env->octeon_crypto);
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
     /* Reset registers to their default values */
@@ -248,6 +301,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->octeon_crypto.chord = 1;
+    }
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -264,6 +320,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      * hardware registers.
      */
     env->CP0_HWREna |= 0x0000000F;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->CP0_HWREna |= 0x40000000u;
+    }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
     }
@@ -422,6 +481,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
+static void mips_cpu_finalize(Object *obj)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+
+    mips_octeon_destroy_llm_state(&cpu->env.octeon_crypto);
+}
+
 static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     const MIPSCPU *cpu = MIPS_CPU(cs);
@@ -650,6 +716,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 801893b67f..d55d8c5218 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -582,6 +583,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t zuc_lfsr[16];
     uint32_t zuc_window[3];
     uint32_t zuc_tresult;
+    uint64_t llm_data[2];
+    uint64_t chord;
+    QTree *llm36;
+    QTree *llm64;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 6d6ceaea08..fafcca4151 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -136,6 +136,14 @@ DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
@@ -307,6 +315,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index aab77b1b25..c5c286872e 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -93,6 +93,9 @@ extern const int mips_defs_number;
 
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+QTree *mips_octeon_llm_tree_new(void);
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr);
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value);
 
 #define USEG_LIMIT      ((target_ulong)(int32_t)0x7FFFFFFFUL)
 #define KSEG0_BASE      ((target_ulong)(int32_t)0x80000000UL)
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 9bcb066245..1ec05f0600 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -131,6 +131,69 @@ static const VMStateDescription vmstate_octeon_multiplier_tc = {
     }
 };
 
+typedef struct OcteonLLMTreePutData {
+    QEMUFile *f;
+} OcteonLLMTreePutData;
+
+static gboolean put_octeon_llm_tree_entry(gpointer key, gpointer value,
+                                          gpointer user_data)
+{
+    OcteonLLMTreePutData *data = user_data;
+
+    qemu_put_be64(data->f, *(uint64_t *)key);
+    qemu_put_be64(data->f, *(uint64_t *)value);
+    return false;
+}
+
+static int put_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc)
+{
+    QTree *tree = *(QTree **)pv;
+    OcteonLLMTreePutData data = { .f = f };
+    uint32_t nnodes = tree ? q_tree_nnodes(tree) : 0;
+
+    qemu_put_be32(f, nnodes);
+    if (tree) {
+        q_tree_foreach(tree, put_octeon_llm_tree_entry, &data);
+    }
+
+    return 0;
+}
+
+static int get_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field)
+{
+    QTree **treep = pv;
+    uint32_t nnodes = qemu_get_be32(f);
+
+    if (*treep) {
+        q_tree_destroy(*treep);
+    }
+    *treep = mips_octeon_llm_tree_new();
+
+    for (uint32_t i = 0; i < nnodes; i++) {
+        uint64_t addr = qemu_get_be64(f);
+        uint64_t value = qemu_get_be64(f);
+
+        mips_octeon_llm_store(treep, addr, value);
+    }
+
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_octeon_llm_tree = {
+    .name = "octeon_llm_tree",
+    .get = get_octeon_llm_tree,
+    .put = put_octeon_llm_tree,
+};
+
+#define VMSTATE_OCTEON_LLM_TREE(_f, _s) {                         \
+    .name = stringify(_f),                                        \
+    .version_id = 1,                                              \
+    .info = &vmstate_info_octeon_llm_tree,                        \
+    .offset = vmstate_offset_pointer(_s, _f, QTree),              \
+}
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -316,6 +379,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_lfsr, MIPSCPU, 16),
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_window, MIPSCPU, 3),
         VMSTATE_UINT32(env.octeon_crypto.zuc_tresult, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm36, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm64, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 6282226cfc..5a8b5b6c2b 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -30,11 +30,48 @@
 #define OCTEON_SNOW3G_RESULT_SEL    OCTEON_HSH_IVW(0)
 #define OCTEON_SNOW3G_FSM(N)        OCTEON_HSH_IVW(1 + (N))
 
+#define OCTEON_LLM_NARROW_MASK ((1ULL << 36) - 1)
+
+static uint64_t octeon_llm_pack_narrow(uint64_t value)
+{
+    value &= OCTEON_LLM_NARROW_MASK;
+    return value | ((uint64_t)(ctpop64(value) & 1) << 36);
+}
+
+static void octeon_llm_read(MIPSOcteonCryptoState *crypto, unsigned int set,
+                            uint64_t addr, bool wide)
+{
+    uint64_t value;
+
+    if (wide) {
+        value = mips_octeon_llm_load(crypto->llm64, addr);
+    } else {
+        value = octeon_llm_pack_narrow(
+            mips_octeon_llm_load(crypto->llm36, addr));
+    }
+
+    crypto->llm_data[set] = value;
+}
+
+static void octeon_llm_write(MIPSOcteonCryptoState *crypto, unsigned int set,
+                             uint64_t addr, bool wide)
+{
+    uint64_t value = crypto->llm_data[set];
+
+    if (wide) {
+        mips_octeon_llm_store(&crypto->llm64, addr, value);
+    } else {
+        mips_octeon_llm_store(&crypto->llm36, addr,
+                              value & OCTEON_LLM_NARROW_MASK);
+    }
+}
+
 static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
                                           MIPSOcteonSharedMode mode)
 {
     crypto->shared_mode = mode;
 }
+
 static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
     return bswap32(revbit32(v));
@@ -94,6 +131,7 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
 
     octeon_crc_set_state_reflect(crypto, crc);
 }
+
 static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
 {
     uint64_t lo = int128_getlo(product);
@@ -136,6 +174,7 @@ static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto, uint64_t data)
                           crypto->gfm_poly, crypto->gfm_reflect_resinp);
     crypto->gfm_reflect_xor0 = 0;
 }
+
 static inline void octeon_hsh_load_reg_words_be(uint64_t reg,
                                                  uint32_t *hi, uint32_t *lo)
 {
@@ -497,6 +536,7 @@ static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
     crypto->hsh_ivw[6] += g;
     crypto->hsh_ivw[7] += h;
 }
+
 static const uint64_t octeon_sha3_round_constants[24] = {
     0x0000000000000001ULL, 0x0000000000008082ULL,
     0x800000000000808aULL, 0x8000000080008000ULL,
@@ -631,6 +671,7 @@ static void octeon_store_shared_hsh_window(MIPSOcteonCryptoState *crypto,
         g_assert_not_reached();
     }
 }
+
 static const uint8_t octeon_zuc_s0[256] = {
     0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
     0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
@@ -901,6 +942,7 @@ static bool octeon_zuc_is_shared_dmtc2_sel(uint32_t sel)
         return false;
     }
 }
+
 static const uint8_t octeon_snow3g_sr[256] = {
     0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
     0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
@@ -1124,6 +1166,7 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
     octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SNOW3G);
     octeon_snow3g_queue_result(crypto);
 }
+
 static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
 {
     enum {
@@ -1143,6 +1186,7 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
         return 0;
     }
 }
+
 static inline uint32_t octeon_sms4_t(uint32_t x)
 {
     x = sm4_subword(x);
@@ -1193,6 +1237,7 @@ static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
     stl_be_p(out + 8, x[33]);
     stl_be_p(out + 12, x[32]);
 }
+
 static const uint8_t octeon_des_ip[64] = {
     58, 50, 42, 34, 26, 18, 10,  2,
     60, 52, 44, 36, 28, 20, 12,  4,
@@ -1620,6 +1665,7 @@ static void octeon_kasumi_crypt_common(MIPSOcteonCryptoState *crypto,
     }
     crypto->des3_result = block;
 }
+
 static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
                                 uint8_t *key, size_t keylen)
 {
@@ -1644,6 +1690,7 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
     regs[0] = ldq_be_p(block);
     regs[1] = ldq_be_p(block + 8);
 }
+
 static const uint8_t camellia_sbox1[256] = {
     112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
     174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
@@ -1754,6 +1801,7 @@ static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
         camellia_flinv(state, key) :
         camellia_fl(state, key);
 }
+
 static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
                                      bool encrypt, bool cbc)
 {
@@ -1794,6 +1842,7 @@ static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
         octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
     }
 }
+
 static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
     AES_KEY key;
@@ -1861,6 +1910,7 @@ static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
         octeon_aes_store_block(crypto->aes_iv, next_iv);
     }
 }
+
 static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
                            uint16_t poly, uint64_t out[2])
 {
@@ -1894,6 +1944,7 @@ static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
     out[0] = zh;
     out[1] = zl;
 }
+
 static uint64_t octeon_hsh_mf_window(MIPSOcteonCryptoState *crypto,
                                      uint32_t sel)
 {
@@ -2004,6 +2055,7 @@ OCTEON_HSH_MF_IVW(5)
 OCTEON_HSH_MF_IVW(6)
 OCTEON_HSH_MF_IVW(7)
 #undef OCTEON_HSH_MF_IVW
+
 uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -2013,10 +2065,12 @@ uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
     }
     return 0;
 }
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
+
 static bool octeon_zuc_store_shared(MIPSOcteonCryptoState *crypto,
                                     uint32_t sel, uint64_t value)
 {
@@ -2062,6 +2116,7 @@ static bool octeon_zuc_store_shared(MIPSOcteonCryptoState *crypto,
         g_assert_not_reached();
     }
 }
+
 static void octeon_hsh_mt_datw(MIPSOcteonCryptoState *crypto,
                                unsigned int index, uint64_t value)
 {
@@ -2226,6 +2281,7 @@ void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
     octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
     octeon_sha3_permute(crypto);
 }
+
 void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -2257,6 +2313,7 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
     crypto->aes_input[1] = value;
     octeon_aes_decrypt_common(crypto, false);
 }
+
 void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
 {
     octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
@@ -2271,6 +2328,7 @@ void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
 {
     octeon_camellia_round(&env->octeon_crypto, value);
 }
+
 void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
@@ -2300,6 +2358,7 @@ void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
 }
+
 void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
                                               uint64_t value)
 {
@@ -2323,6 +2382,47 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
     crypto->gfm_xor0 = 0;
 }
+
+void helper_octeon_cp2_mt_llm_read_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_read_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, true);
+}
+
 void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -2354,6 +2454,7 @@ void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
     crypto->aes_input[1] = value;
     octeon_sms4_crypt_common(crypto, false, false);
 }
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
@@ -2364,6 +2465,7 @@ void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
     (void)value;
     octeon_snow3g_more(&env->octeon_crypto);
 }
+
 void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_start(&env->octeon_crypto, value);
@@ -2373,6 +2475,7 @@ void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_more(&env->octeon_crypto, value);
 }
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5b..3e586e3049 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -255,6 +255,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
     return (env->CP0_Config5 >> CP0C5_XNP) & 1;
 }
 
+target_ulong helper_rdhwr_chord(CPUMIPSState *env)
+{
+    check_hwrena(env, 30, GETPC());
+    return env->octeon_crypto.chord;
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 123d2c89c3..1f44932882 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10925,6 +10925,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         }
         break;
 #endif
+    case 30:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        gen_helper_rdhwr_chord(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);

-- 
2.54.0


