Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960FDCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYh7-0001JQ-Cl; Wed, 20 May 2026 00:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh4-0001Ie-El
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:06 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgw-0003u0-8z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:03 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e36bb16a92so2625996a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251877; x=1779856677; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TfJAMXA0mMIJvIAJY5Wemrlulr5Q7+++P95p/sSCnss=;
 b=MB9VY+jScUdwqpkz+dkD/6DTmo9ZKj3uSfa0XG9MZ5ZzhUCTwv5qlyrkF4qT7KHYRZ
 cjx550QIz8WLMTaqEvm7x2EPhie/VMgq5RX5YmQe4wlSkGGCpICoHCVg9PtW1EyT3rhA
 aZF1cLQjVDfiON9xkkjmnhyOo0d1mWKnKwNt0u3ApHNP2VgKsJP64Ov5tE3L/xaepvIz
 JYqlCnBt4Wfz+Xt8lx+LV1O3QP5z2b5axMgymq9kC1YldXyHmb3//2b6QzeO6j8bnUfx
 u8fcYuJRZMhMB9z4Jm9pwWXSXiyy2GeFmsoaRaxArsh+CMKD256nvn9YMNDB0LJpGCfM
 4UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251877; x=1779856677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfJAMXA0mMIJvIAJY5Wemrlulr5Q7+++P95p/sSCnss=;
 b=tU0Ow855ncq8JyjQuA/aPrvYkB6QTvVp0V1fzdI3t8TA2b77IbVgVFf6XC6RlFU+vf
 hI0EuFXubC7lAlciKJlnVHJVsVlz649lFlCKFiEf2KAmlmC2HlFitFua08Jxn3+etz+z
 0fh7AfVYhNfEu9bxXRX9akAqDBKJigdUL5jHrJohtCSeVJkg3lesUOTTw2ekrIOa1Ete
 N67b1cmkkAUrqYVn7bVzZK1GB8XL/eWwUfnxs5iy/MqvoUqKGTZL4Dcy64BCqsTiQV/b
 jgxVgxZMdG+G3Y3lEA/6lTXCRhvlfM4pIfpmvRKZbOweo8q+rrlOKtL+oYljohZzDiFX
 klVQ==
X-Gm-Message-State: AOJu0YztE8RNQuhgWaPB0TBALPfLtsIcOpEYbIoqWMWS85xQ96tLs7oc
 bXR+m1Dd3s1se2hVqWGANBew5WuAi0WL8jWCNgaPaz9ULeOZoUPSEbAz
X-Gm-Gg: Acq92OEpu6MfBZC8NOVGk/i9mhX1LW7z+YjIWly+Fj7nDyybwtikoRTE6SFRoPfr/pp
 WSbKTucumrJJbnf3rLvPPIVTSwA4iSfc+9LqWqNPGPS6wsJlZEj7Csnm8hyxGLYDsB3/bAKRs3B
 LW1a3iYZns3ARU1jcs3CCIVVbBE0mw+NMWmjYpIsoQprNvRZ3o9uiFjLeRO0poIjX+QXq5dCYre
 qGimavalIGSoe/whvQdaV4DrR3KjSKCk1j8W81+ewQofXmbEMen3yP5WqUyfdwmlU4zWxyEGtkR
 AXM3TwThEohxa0pXAZqLBq+f0zW5g4GZ10a5iKJIT5RB8WDl0mBEsn5zqmsoAolVAGfQyNEK/aV
 cg5ZW1Zxrk/tLIc3f8IkflFwTnqSf7KK4OlbxgGFpHULU16jrckRxiuYT1bnEMrKSyoY1PxaHFI
 yhepLJzCvoYdCj/EKyHO0qsCKZzjIL43S9ie9BiYLa4cM74xPMNBcZMqOIkmuExAKeuzWR6Il4K
 1LTu+S2m/xyFG+RZ8+M9DV74WYK5kDo27Ub4ElyES/HbCAOgOhf8gbVBaVl8qHIwADw
X-Received: by 2002:a05:6830:82e1:b0:7de:d056:19d with SMTP id
 46e09a7af769-7e4de6588e0mr16282912a34.0.1779251876912; 
 Tue, 19 May 2026 21:37:56 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:30 -0600
Subject: [PATCH v10 36/45] target/mips: add Octeon CHORD and LLM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-36-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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
Changes v9 -> v10:
  - Keep shared crypto helper routines in their final order after the COP2
    helper split.

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
 target/mips/cpu.c               |  67 +++
 target/mips/cpu.h               |   9 +-
 target/mips/helper.h            |   9 +
 target/mips/internal.h          |   3 +
 target/mips/system/machine.c    |  71 ++-
 target/mips/tcg/octeon_crypto.c | 932 ++++++++++++++++++++++------------------
 target/mips/tcg/op_helper.c     |   6 +
 target/mips/tcg/translate.c     |   8 +
 8 files changed, 673 insertions(+), 432 deletions(-)

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
index 890734556f..60adae1ec9 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -549,13 +550,17 @@ typedef struct MIPSOcteonCryptoState {
     uint64_t aes_resinp[2];
     uint64_t aes_iv[2];
     uint64_t aes_key[4];
+    uint8_t aes_keylen;
     uint32_t crc_poly;
     uint32_t crc_iv;
+    uint8_t crc_len;
     uint64_t gfm_mul[2];
     uint64_t gfm_resinp[2];
     uint16_t gfm_poly;
-    uint8_t aes_keylen;
-    uint8_t crc_len;
+    uint64_t chord;
+    uint64_t llm_data[2];
+    QTree *llm36;
+    QTree *llm64;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 436a61b2d1..68a99cfc11 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -138,6 +138,14 @@ DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
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
@@ -309,6 +317,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
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
index 2447915750..a90b391ba3 100644
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
@@ -296,13 +359,17 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_resinp, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
         VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
         VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
         VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
         VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
-        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
-        VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm36, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm64, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index aea9a24f0c..79a4439f33 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,7 +16,58 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
-#define OCTEON_SHA3_DAT15 15
+#define OCTEON_SHA3_DAT15           15
+
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
+static inline uint32_t octeon_crypto_hi32(uint64_t value)
+{
+    return value >> 32;
+}
+
+static inline uint32_t octeon_crypto_lo32(uint64_t value)
+{
+    return value;
+}
+
+static inline uint64_t octeon_crypto_pack32(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
 
 static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
@@ -78,96 +129,6 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
     octeon_crc_set_state_reflect(crypto, crc);
 }
 
-static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
-                           uint16_t poly, uint64_t out[2])
-{
-    uint64_t zh = 0, zl = 0;
-    uint64_t vh = y[0], vl = y[1];
-    uint64_t rh = (uint64_t)poly << 48;
-    int i;
-
-    /*
-     * Keep the reflected-shift formulation used by Octeon software: the
-     * selector polynomial is pre-positioned at the top of the high word before
-     * each carry reduction.
-     */
-    for (i = 0; i < 128; i++) {
-        bool bit;
-        bool lsb;
-
-        if (i < 64) {
-            bit = (x[0] >> (63 - i)) & 1;
-        } else {
-            bit = (x[1] >> (127 - i)) & 1;
-        }
-        if (bit) {
-            zh ^= vh;
-            zl ^= vl;
-        }
-
-        lsb = vl & 1;
-        vl = (vh << 63) | (vl >> 1);
-        vh >>= 1;
-        if (lsb) {
-            vh ^= rh;
-        }
-    }
-
-    out[0] = zh;
-    out[1] = zl;
-}
-
-static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
-{
-    uint64_t lo = int128_getlo(product);
-    uint64_t hi = int128_gethi(product);
-
-    while (hi) {
-        int bit = 63 - clz64(hi);
-
-        hi ^= 1ULL << bit;
-        lo ^= (uint64_t)poly << bit;
-        if (bit > 56) {
-            hi ^= (uint64_t)poly >> (64 - bit);
-        }
-    }
-
-    return lo;
-}
-
-static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
-                                  uint8_t poly, uint64_t out[2])
-{
-    /*
-     * UIA2 uses the GFM datapath as a reflected 64-bit multiply in the low
-     * half of the 128-bit register pair.
-     */
-    uint64_t vx = revbit64(x[1]);
-    uint64_t vy = revbit64(y[0]);
-    Int128 product = clmul_64(vx, vy);
-    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
-
-    out[0] = 0;
-    out[1] = revbit64(res);
-}
-
-static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto)
-{
-    uint64_t in[2] = {
-        revbit64(crypto->gfm_reflect_resinp[0]),
-        revbit64(crypto->gfm_reflect_resinp[1]),
-    };
-    uint64_t mul[2] = {
-        revbit64(crypto->gfm_reflect_mul[0]),
-        revbit64(crypto->gfm_reflect_mul[1]),
-    };
-    uint64_t out[2];
-
-    octeon_gfm_mul(in, mul, crypto->gfm_poly, out);
-    crypto->gfm_reflect_resinp[0] = revbit64(out[0]);
-    crypto->gfm_reflect_resinp[1] = revbit64(out[1]);
-}
-
 static inline void octeon_hsh_load_reg_words_be(uint64_t reg,
                                                  uint32_t *hi, uint32_t *lo)
 {
@@ -643,21 +604,6 @@ static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
     }
 }
 
-static inline uint32_t octeon_crypto_hi32(uint64_t value)
-{
-    return value >> 32;
-}
-
-static inline uint32_t octeon_crypto_lo32(uint64_t value)
-{
-    return value;
-}
-
-static inline uint64_t octeon_crypto_pack32(uint32_t hi, uint32_t lo)
-{
-    return ((uint64_t)hi << 32) | lo;
-}
-
 static const uint8_t octeon_zuc_s0[256] = {
     0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
     0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
@@ -1286,265 +1232,67 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
     }
 }
 
-static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
-                                uint8_t *key, size_t keylen)
-{
-    stq_be_p(key, crypto->aes_key[0]);
-    stq_be_p(key + 8, crypto->aes_key[1]);
-    if (keylen > 16) {
-        stq_be_p(key + 16, crypto->aes_key[2]);
-    }
-    if (keylen > 24) {
-        stq_be_p(key + 24, crypto->aes_key[3]);
-    }
-}
-
-static void octeon_aes_load_block(const uint64_t regs[2], uint8_t *block)
+static inline uint32_t octeon_sms4_t(uint32_t x)
 {
-    stq_be_p(block, regs[0]);
-    stq_be_p(block + 8, regs[1]);
+    x = sm4_subword(x);
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
+           rol32(x, 18) ^ rol32(x, 24);
 }
 
-static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
+static inline uint32_t octeon_sms4_t_key(uint32_t x)
 {
-    regs[0] = ldq_be_p(block);
-    regs[1] = ldq_be_p(block + 8);
+    x = sm4_subword(x);
+    return x ^ rol32(x, 13) ^ rol32(x, 23);
 }
 
-static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+static void octeon_sms4_expand_key(const uint8_t *key, uint32_t round_keys[32])
 {
-    AES_KEY key;
-    uint8_t in[16];
-    uint8_t out[16];
-    uint8_t iv[16];
-    uint8_t raw_key[32] = {};
-    int bits = octeon_aes_key_bits(crypto);
-
-    if (!bits) {
-        return;
-    }
-
-    octeon_aes_load_key(crypto, raw_key, bits / 8);
-    octeon_aes_load_block(crypto->aes_resinp, in);
-    if (cbc) {
-        int i;
+    static const uint32_t fk[4] = {
+        0xa3b1bac6U, 0x56aa3350U, 0x677d9197U, 0xb27022dcU,
+    };
+    uint32_t k[36];
 
-        octeon_aes_load_block(crypto->aes_iv, iv);
-        for (i = 0; i < sizeof(in); i++) {
-            in[i] ^= iv[i];
-        }
+    for (int i = 0; i < 4; i++) {
+        k[i] = ldl_be_p(key + i * 4) ^ fk[i];
     }
-
-    AES_set_encrypt_key(raw_key, bits, &key);
-    AES_encrypt(in, out, &key);
-    octeon_aes_store_block(crypto->aes_resinp, out);
-    if (cbc) {
-        octeon_aes_store_block(crypto->aes_iv, out);
+    for (int i = 0; i < 32; i++) {
+        k[i + 4] = k[i] ^ octeon_sms4_t_key(k[i + 1] ^ k[i + 2] ^
+                                            k[i + 3] ^ sm4_ck[i]);
+        round_keys[i] = k[i + 4];
     }
 }
 
-static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
+                                    const uint32_t round_keys[32],
+                                    bool encrypt)
 {
-    AES_KEY key;
-    uint8_t in[16];
-    uint8_t out[16];
-    uint8_t iv[16];
-    uint8_t next_iv[16];
-    uint8_t raw_key[32] = {};
-    int bits = octeon_aes_key_bits(crypto);
-    int i;
-
-    if (!bits) {
-        return;
-    }
-
-    octeon_aes_load_key(crypto, raw_key, bits / 8);
-    octeon_aes_load_block(crypto->aes_resinp, in);
-    if (cbc) {
-        memcpy(next_iv, in, sizeof(next_iv));
-        octeon_aes_load_block(crypto->aes_iv, iv);
-    }
+    uint32_t x[36];
 
-    AES_set_decrypt_key(raw_key, bits, &key);
-    AES_decrypt(in, out, &key);
-    if (cbc) {
-        for (i = 0; i < sizeof(out); i++) {
-            out[i] ^= iv[i];
-        }
+    for (int i = 0; i < 4; i++) {
+        x[i] = ldl_be_p(in + i * 4);
     }
+    for (int i = 0; i < 32; i++) {
+        uint32_t rk = round_keys[encrypt ? i : 31 - i];
 
-    octeon_aes_store_block(crypto->aes_resinp, out);
-    if (cbc) {
-        octeon_aes_store_block(crypto->aes_iv, next_iv);
+        x[i + 4] = x[i] ^ octeon_sms4_t(x[i + 1] ^ x[i + 2] ^
+                                        x[i + 3] ^ rk);
     }
+    stl_be_p(out, x[35]);
+    stl_be_p(out + 4, x[34]);
+    stl_be_p(out + 8, x[33]);
+    stl_be_p(out + 12, x[32]);
 }
 
-void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_aes_encrypt_common(crypto, true);
-}
-
-void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_aes_encrypt_common(crypto, false);
-}
-
-void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_aes_decrypt_common(crypto, true);
-}
-
-void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_aes_decrypt_common(crypto, false);
-}
-
-static inline uint32_t octeon_sms4_t(uint32_t x)
-{
-    x = sm4_subword(x);
-    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
-           rol32(x, 18) ^ rol32(x, 24);
-}
-
-static inline uint32_t octeon_sms4_t_key(uint32_t x)
-{
-    x = sm4_subword(x);
-    return x ^ rol32(x, 13) ^ rol32(x, 23);
-}
-
-static void octeon_sms4_expand_key(const uint8_t *key, uint32_t round_keys[32])
-{
-    static const uint32_t fk[4] = {
-        0xa3b1bac6U, 0x56aa3350U, 0x677d9197U, 0xb27022dcU,
-    };
-    uint32_t k[36];
-
-    for (int i = 0; i < 4; i++) {
-        k[i] = ldl_be_p(key + i * 4) ^ fk[i];
-    }
-    for (int i = 0; i < 32; i++) {
-        k[i + 4] = k[i] ^ octeon_sms4_t_key(k[i + 1] ^ k[i + 2] ^
-                                            k[i + 3] ^ sm4_ck[i]);
-        round_keys[i] = k[i + 4];
-    }
-}
-
-static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
-                                    const uint32_t round_keys[32],
-                                    bool encrypt)
-{
-    uint32_t x[36];
-
-    for (int i = 0; i < 4; i++) {
-        x[i] = ldl_be_p(in + i * 4);
-    }
-    for (int i = 0; i < 32; i++) {
-        uint32_t rk = round_keys[encrypt ? i : 31 - i];
-
-        x[i + 4] = x[i] ^ octeon_sms4_t(x[i + 1] ^ x[i + 2] ^
-                                        x[i + 3] ^ rk);
-    }
-    stl_be_p(out, x[35]);
-    stl_be_p(out + 4, x[34]);
-    stl_be_p(out + 8, x[33]);
-    stl_be_p(out + 12, x[32]);
-}
-
-static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
-                                     bool encrypt, bool cbc)
-{
-    uint8_t key[16];
-    uint8_t in[16];
-    uint8_t out[16];
-    uint8_t iv[16];
-    uint8_t next_iv[16];
-    uint32_t round_keys[32];
-
-    /*
-     * SMS4 aliases the AES state onto the RESINP, IV, and KEY banks,
-     * with only the operation selectors remaining distinct.
-     */
-    octeon_aes_load_key(crypto, key, sizeof(key));
-    octeon_aes_load_block(crypto->aes_resinp, in);
-    if (cbc) {
-        octeon_aes_load_block(crypto->aes_iv, iv);
-        if (encrypt) {
-            for (int i = 0; i < sizeof(in); i++) {
-                in[i] ^= iv[i];
-            }
-        } else {
-            memcpy(next_iv, in, sizeof(next_iv));
-        }
-    }
-
-    octeon_sms4_expand_key(key, round_keys);
-    octeon_sms4_crypt_block(in, out, round_keys, encrypt);
-    if (cbc && !encrypt) {
-        for (int i = 0; i < sizeof(out); i++) {
-            out[i] ^= iv[i];
-        }
-    }
-
-    octeon_aes_store_block(crypto->aes_resinp, out);
-    if (cbc) {
-        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
-    }
-}
-
-void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_sms4_crypt_common(crypto, true, true);
-}
-
-void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_sms4_crypt_common(crypto, true, false);
-}
-
-void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_sms4_crypt_common(crypto, false, true);
-}
-
-void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
-{
-    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
-
-    crypto->aes_resinp[1] = value;
-    octeon_sms4_crypt_common(crypto, false, false);
-}
-
-static const uint8_t octeon_des_ip[64] = {
-    58, 50, 42, 34, 26, 18, 10,  2,
-    60, 52, 44, 36, 28, 20, 12,  4,
-    62, 54, 46, 38, 30, 22, 14,  6,
-    64, 56, 48, 40, 32, 24, 16,  8,
-    57, 49, 41, 33, 25, 17,  9,  1,
-    59, 51, 43, 35, 27, 19, 11,  3,
-    61, 53, 45, 37, 29, 21, 13,  5,
-    63, 55, 47, 39, 31, 23, 15,  7,
-};
+static const uint8_t octeon_des_ip[64] = {
+    58, 50, 42, 34, 26, 18, 10,  2,
+    60, 52, 44, 36, 28, 20, 12,  4,
+    62, 54, 46, 38, 30, 22, 14,  6,
+    64, 56, 48, 40, 32, 24, 16,  8,
+    57, 49, 41, 33, 25, 17,  9,  1,
+    59, 51, 43, 35, 27, 19, 11,  3,
+    61, 53, 45, 37, 29, 21, 13,  5,
+    63, 55, 47, 39, 31, 23, 15,  7,
+};
 
 static const uint8_t octeon_des_fp[64] = {
     40,  8, 48, 16, 56, 24, 64, 32,
@@ -1963,34 +1711,29 @@ static void octeon_kasumi_crypt_common(MIPSOcteonCryptoState *crypto,
     crypto->des3_result = block;
 }
 
-void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
-{
-    octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
-}
-
-void helper_octeon_cp2_mt_kas_enc_cbc(CPUMIPSState *env, uint64_t value)
-{
-    octeon_kasumi_crypt_common(&env->octeon_crypto, value, true);
-}
-
-void helper_octeon_cp2_mt_des3_enc(CPUMIPSState *env, uint64_t value)
-{
-    octeon_3des_crypt_common(&env->octeon_crypto, value, true, false);
-}
-
-void helper_octeon_cp2_mt_kas_enc(CPUMIPSState *env, uint64_t value)
+static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
+                                uint8_t *key, size_t keylen)
 {
-    octeon_kasumi_crypt_common(&env->octeon_crypto, value, false);
+    stq_be_p(key, crypto->aes_key[0]);
+    stq_be_p(key + 8, crypto->aes_key[1]);
+    if (keylen > 16) {
+        stq_be_p(key + 16, crypto->aes_key[2]);
+    }
+    if (keylen > 24) {
+        stq_be_p(key + 24, crypto->aes_key[3]);
+    }
 }
 
-void helper_octeon_cp2_mt_des3_dec_cbc(CPUMIPSState *env, uint64_t value)
+static void octeon_aes_load_block(const uint64_t regs[2], uint8_t *block)
 {
-    octeon_3des_crypt_common(&env->octeon_crypto, value, false, true);
+    stq_be_p(block, regs[0]);
+    stq_be_p(block + 8, regs[1]);
 }
 
-void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
+static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
 {
-    octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
+    regs[0] = ldq_be_p(block);
+    regs[1] = ldq_be_p(block + 8);
 }
 
 static const uint8_t camellia_sbox1[256] = {
@@ -2104,40 +1847,203 @@ static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
         camellia_fl(state, key);
 }
 
-void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     bool encrypt, bool cbc)
 {
-    octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
-}
+    uint8_t key[16];
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint32_t round_keys[32];
 
-void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
-{
-    octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
-}
+    /*
+     * SMS4 aliases the AES state onto the RESINP, IV, and KEY banks,
+     * with only the operation selectors remaining distinct.
+     */
+    octeon_aes_load_key(crypto, key, sizeof(key));
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        if (encrypt) {
+            for (int i = 0; i < sizeof(in); i++) {
+                in[i] ^= iv[i];
+            }
+        } else {
+            memcpy(next_iv, in, sizeof(next_iv));
+        }
+    }
 
-void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
-{
-    octeon_camellia_round(&env->octeon_crypto, value);
-}
+    octeon_sms4_expand_key(key, round_keys);
+    octeon_sms4_crypt_block(in, out, round_keys, encrypt);
+    if (cbc && !encrypt) {
+        for (int i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
 
-void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
-{
-    octeon_snow3g_start(&env->octeon_crypto, value);
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
 }
 
-void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
+static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
-    (void)value;
-    octeon_snow3g_more(&env->octeon_crypto);
-}
-
-void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        int i;
+
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        for (i = 0; i < sizeof(in); i++) {
+            in[i] ^= iv[i];
+        }
+    }
+
+    AES_set_encrypt_key(raw_key, bits, &key);
+    AES_encrypt(in, out, &key);
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, out);
+    }
+}
+
+static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
-    octeon_zuc_start(&env->octeon_crypto, value);
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+    int i;
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        memcpy(next_iv, in, sizeof(next_iv));
+        octeon_aes_load_block(crypto->aes_iv, iv);
+    }
+
+    AES_set_decrypt_key(raw_key, bits, &key);
+    AES_decrypt(in, out, &key);
+    if (cbc) {
+        for (i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, next_iv);
+    }
 }
 
-void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
+                           uint16_t poly, uint64_t out[2])
 {
-    octeon_zuc_more(&env->octeon_crypto, value);
+    uint64_t zh = 0, zl = 0;
+    uint64_t vh = y[0], vl = y[1];
+    uint64_t rh = (uint64_t)poly << 48;
+    int i;
+
+    /*
+     * Keep the reflected-shift formulation used by Octeon software: the
+     * selector polynomial is pre-positioned at the top of the high word before
+     * each carry reduction.
+     */
+    for (i = 0; i < 128; i++) {
+        bool bit;
+        bool lsb;
+
+        if (i < 64) {
+            bit = (x[0] >> (63 - i)) & 1;
+        } else {
+            bit = (x[1] >> (127 - i)) & 1;
+        }
+        if (bit) {
+            zh ^= vh;
+            zl ^= vl;
+        }
+
+        lsb = vl & 1;
+        vl = (vh << 63) | (vl >> 1);
+        vh >>= 1;
+        if (lsb) {
+            vh ^= rh;
+        }
+    }
+
+    out[0] = zh;
+    out[1] = zl;
+}
+
+static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
+{
+    uint64_t lo = int128_getlo(product);
+    uint64_t hi = int128_gethi(product);
+
+    while (hi) {
+        int bit = 63 - clz64(hi);
+
+        hi ^= 1ULL << bit;
+        lo ^= (uint64_t)poly << bit;
+        if (bit > 56) {
+            hi ^= (uint64_t)poly >> (64 - bit);
+        }
+    }
+
+    return lo;
+}
+
+static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
+                                  uint8_t poly, uint64_t out[2])
+{
+    /*
+     * UIA2 uses the GFM datapath as a reflected 64-bit multiply in the low
+     * half of the 128-bit register pair.
+     */
+    uint64_t vx = revbit64(x[1]);
+    uint64_t vy = revbit64(y[0]);
+    Int128 product = clmul_64(vx, vy);
+    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
+
+    out[0] = 0;
+    out[1] = revbit64(res);
+}
+
+static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t in[2] = {
+        revbit64(crypto->gfm_reflect_resinp[0]),
+        revbit64(crypto->gfm_reflect_resinp[1]),
+    };
+    uint64_t mul[2] = {
+        revbit64(crypto->gfm_reflect_mul[0]),
+        revbit64(crypto->gfm_reflect_mul[1]),
+    };
+    uint64_t out[2];
+
+    octeon_gfm_mul(in, mul, crypto->gfm_poly, out);
+    crypto->gfm_reflect_resinp[0] = revbit64(out[0]);
+    crypto->gfm_reflect_resinp[1] = revbit64(out[1]);
 }
 
 #define OCTEON_HSH_MF_DAT(N) \
@@ -2178,6 +2084,16 @@ OCTEON_HSH_MF_IV(6)
 OCTEON_HSH_MF_IV(7)
 #undef OCTEON_HSH_MF_IV
 
+uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
+{
+    return env->octeon_crypto.sha3_dat24;
+}
+
+uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+{
+    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+}
+
 static void octeon_hsh_mt_dat(MIPSOcteonCryptoState *crypto,
                               unsigned int index, uint64_t value)
 {
@@ -2264,14 +2180,133 @@ void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
     octeon_sha512_transform(crypto);
 }
 
-uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+void helper_octeon_cp2_mt_sha3_dat24(CPUMIPSState *env, uint64_t value)
 {
-    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+    env->octeon_crypto.sha3_dat24 = value;
 }
 
-uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
+void helper_octeon_cp2_mt_sha3_dat15(CPUMIPSState *env, uint64_t value)
 {
-    return env->octeon_crypto.sha3_dat24;
+    env->octeon_crypto.hsh_dat[OCTEON_SHA3_DAT15] = value;
+}
+
+static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint64_t value)
+{
+    uint64_t lane = octeon_sha3_get_lane(crypto, index);
+
+    octeon_sha3_set_lane(crypto, index,
+                         lane ^ octeon_sha3_reg_to_lane(value));
+}
+
+#define OCTEON_SHA3_XORDAT_HELPER(N) \
+void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
+}
+OCTEON_SHA3_XORDAT_HELPER(0)
+OCTEON_SHA3_XORDAT_HELPER(1)
+OCTEON_SHA3_XORDAT_HELPER(2)
+OCTEON_SHA3_XORDAT_HELPER(3)
+OCTEON_SHA3_XORDAT_HELPER(4)
+OCTEON_SHA3_XORDAT_HELPER(5)
+OCTEON_SHA3_XORDAT_HELPER(6)
+OCTEON_SHA3_XORDAT_HELPER(7)
+OCTEON_SHA3_XORDAT_HELPER(8)
+OCTEON_SHA3_XORDAT_HELPER(9)
+OCTEON_SHA3_XORDAT_HELPER(10)
+OCTEON_SHA3_XORDAT_HELPER(11)
+OCTEON_SHA3_XORDAT_HELPER(12)
+OCTEON_SHA3_XORDAT_HELPER(13)
+OCTEON_SHA3_XORDAT_HELPER(14)
+OCTEON_SHA3_XORDAT_HELPER(15)
+OCTEON_SHA3_XORDAT_HELPER(16)
+OCTEON_SHA3_XORDAT_HELPER(17)
+#undef OCTEON_SHA3_XORDAT_HELPER
+
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    (void)value;
+    octeon_sha3_permute(crypto);
+}
+
+void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_round(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
+}
+
+void helper_octeon_cp2_mt_kas_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_des3_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, false);
+}
+
+void helper_octeon_cp2_mt_kas_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_des3_dec_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, true);
+}
+
+void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
 }
 
 void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
@@ -2308,56 +2343,97 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
 }
 
-void helper_octeon_cp2_mt_sha3_dat24(CPUMIPSState *env, uint64_t value)
+void helper_octeon_cp2_mt_llm_read_addr0(CPUMIPSState *env, uint64_t value)
 {
-    env->octeon_crypto.sha3_dat24 = value;
+    octeon_llm_read(&env->octeon_crypto, 0, value, false);
 }
 
-void helper_octeon_cp2_mt_sha3_dat15(CPUMIPSState *env, uint64_t value)
+void helper_octeon_cp2_mt_llm_write_addr0(CPUMIPSState *env, uint64_t value)
 {
-    env->octeon_crypto.hsh_dat[OCTEON_SHA3_DAT15] = value;
+    octeon_llm_write(&env->octeon_crypto, 0, value, false);
 }
 
-static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
-                               unsigned int index, uint64_t value)
+void helper_octeon_cp2_mt_llm_read64_addr0(CPUMIPSState *env, uint64_t value)
 {
-    uint64_t lane = octeon_sha3_get_lane(crypto, index);
+    octeon_llm_read(&env->octeon_crypto, 0, value, true);
+}
 
-    octeon_sha3_set_lane(crypto, index,
-                         lane ^ octeon_sha3_reg_to_lane(value));
+void helper_octeon_cp2_mt_llm_write64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, true);
 }
 
-#define OCTEON_SHA3_XORDAT_HELPER(N) \
-void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
-{ \
-    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
+void helper_octeon_cp2_mt_llm_read_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, false);
 }
-OCTEON_SHA3_XORDAT_HELPER(0)
-OCTEON_SHA3_XORDAT_HELPER(1)
-OCTEON_SHA3_XORDAT_HELPER(2)
-OCTEON_SHA3_XORDAT_HELPER(3)
-OCTEON_SHA3_XORDAT_HELPER(4)
-OCTEON_SHA3_XORDAT_HELPER(5)
-OCTEON_SHA3_XORDAT_HELPER(6)
-OCTEON_SHA3_XORDAT_HELPER(7)
-OCTEON_SHA3_XORDAT_HELPER(8)
-OCTEON_SHA3_XORDAT_HELPER(9)
-OCTEON_SHA3_XORDAT_HELPER(10)
-OCTEON_SHA3_XORDAT_HELPER(11)
-OCTEON_SHA3_XORDAT_HELPER(12)
-OCTEON_SHA3_XORDAT_HELPER(13)
-OCTEON_SHA3_XORDAT_HELPER(14)
-OCTEON_SHA3_XORDAT_HELPER(15)
-OCTEON_SHA3_XORDAT_HELPER(16)
-OCTEON_SHA3_XORDAT_HELPER(17)
-#undef OCTEON_SHA3_XORDAT_HELPER
 
-void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
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
+void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, true);
+}
+
+void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, false);
+}
+
+void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, true);
+}
+
+void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, false);
+}
+
+void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_snow3g_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
+{
     (void)value;
-    octeon_sha3_permute(crypto);
+    octeon_snow3g_more(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_more(&env->octeon_crypto, value);
 }
 
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
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


