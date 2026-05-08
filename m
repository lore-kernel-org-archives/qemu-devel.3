Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9E5CD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMty-0003Xe-Bd; Fri, 08 May 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtS-0002lq-Hi
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:36 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtO-0001nc-CA
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:32 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6966e1a0b91so1321132eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253209; x=1778858009; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZzgJ/wJZ1r3XOAnw9+OKtdkI2ICRbzmAKYSbDIuZLw=;
 b=QYG7S4bd2Z8qW5aoeIyN2qDzg7+44ME79CnPPi2jSpGQBq9Rd/DESHY8t7a9+9gWv2
 clsK8qkPiNp0T1WlIbNfjYE2nLEAKunz5XTQT7I+l59x7iLmBdcWr6OCPg6twjex8MGe
 gPHKCFeQvnDWbGYM0ijqwCLLSZh04RyA8OH9cKljIc5liGHA6sDEofAFLh5Ras/lu51M
 KFyHgah+L+ApQorLA1ql0IrU4BXZDI/1No2MYNlWtFacb4E7wcE0Yba2SUyA66IweiQ3
 bDeEpExOeQewDxbbisJiUNCjH/wT1csOd6ker8xD3UNw6n1zWSfIVV4wa8V+MZqwzxnY
 vugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253209; x=1778858009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sZzgJ/wJZ1r3XOAnw9+OKtdkI2ICRbzmAKYSbDIuZLw=;
 b=PMYOvB3qj5eIcyJEtxA0F5vdL62AfYpxgskFb/TQt/wkctJ2j28vjm+QJKaMaXc2XB
 aGUDIRcT8CwK4nni1pRfQcqf71lBm9UwAQkhXcidB6Ox8vP6TgVyfu9iloHNNoT2Xr6q
 y2ddBTzY/dZwwllxNn9yElUiEDQw0Vncto/UeVpkipKX/668d7zIU7Sh5GUWn4+DyGFw
 qp3IeDdJ4OS4BYwh/9VUKds5MldjzCWRbCCppcw2odXGTw20MS0GsJ+oj7HqHF2nqVO7
 ciAXVh1yoQqSX3JPiBbOs8sdwHCRp3lBgC/6YSB7MQgi4RO5d1KGa5f+s4usWZkcOb4P
 UWLg==
X-Gm-Message-State: AOJu0Yw2Yp6WaZhPkQ7JXjt5Jqfu0kCSCMhT1WDpSBEYUaF4FbzL2Ro4
 SqL5hAfHekv83KZn+2yo7X05ca3lIo9N0PKgg0UjAjTo1iFzt4ZSO/6qIkLe6w==
X-Gm-Gg: AeBDiesXAWPlCcqZPNkjvtRYQwPhVkG2u67ngPFUNFuoormY4sLSYQX9ZG1OGchMBK9
 BSA2mbxXAHnQeBEOSXFH3Wsw3KN6RlHNgTZFbtjITFCIqEOlENxug4/mHlGVOuhX0Dz9Ad7tXag
 91RCJktciw+PjiCiecPPVuUofguIsvIKdB+VAfE3A70dEtSXF8edWC21YavJDMTuyShrqqNfzWH
 5PLRvPELBCBBjt6b7smAqFx0GhTY9wGBJSzpg5N8IfSyrm1M+EqbiB/m68y2SfgbY1MASxfoHVb
 l76YTMo78dLRO1Y1i7kChdmVG2LjVl2ZvMPmMKj/DfTQ1TvtgXgy1j8+IQbomNGRGNd+UtLNzT9
 aWzX19dxSMqPjzQMPYSxq7dx7iYlL+6XW5LPbmRUfVOJ5onSrf91/EtXjfaxJEck1RY9igiCTHs
 M/4DeIc75mps03DsM7pZqJhBHx+sJ5rfLGpW0fOwCtGZTH4CM7YDu1sRSqyC709aF0ABzKU28ig
 0BDJhOt0ldm656aeB3lw23DsDY1yoHguCd96yTv2w3u4YJlRXl75jQbqRS3HyqD8QlsdKJtdq+u
 anMnP3Ynvw/ZvFmFdQTMrVuxx9KzTHVa61/laydi65z9R0H6JXQEKdrBM6Xo9kD/PIVDluo=
X-Received: by 2002:a05:6820:c8c:b0:696:8098:b0d9 with SMTP id
 006d021491bc7-69998d0fc66mr7375308eaf.38.1778253208829; 
 Fri, 08 May 2026 08:13:28 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:31 -0600
Subject: [PATCH v3 31/32] target/mips: add Octeon CHORD and LLM COP2
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-31-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc33.google.com
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

Add the Octeon CHORD hardware register access path and the LLM
narrow/wide read and write windows.

Model both CHORD access forms, including the rdhwr $30 path and the
legacy dmfc2 alias, and implement sparse backing storage for the two LLM
sets so user-mode code can save, restore, and probe the architectural
state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Use neutral selector-slot wording for the LLM/CHORD alias comment.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/cpu.c                  | 67 +++++++++++++++++++++++++++++++++++
 target/mips/cpu.h                  | 20 +++++++++++
 target/mips/helper.h               |  1 +
 target/mips/internal.h             |  3 ++
 target/mips/system/machine.c       | 67 +++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_crypto.c    | 72 ++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 13 +++++++
 target/mips/tcg/op_helper.c        |  6 ++++
 target/mips/tcg/translate.c        |  8 +++++
 9 files changed, 257 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 19001d829c..d439b14f7b 100644
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
+    if (crypto->llm_narrow) {
+        q_tree_destroy(crypto->llm_narrow);
+        crypto->llm_narrow = NULL;
+    }
+    if (crypto->llm_wide) {
+        q_tree_destroy(crypto->llm_wide);
+        crypto->llm_wide = NULL;
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
@@ -648,6 +714,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 4848125992..5764fb9490 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -609,6 +610,21 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
     OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
     OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
+    /*
+     * Selector 0x0400 is the narrow LLM read selector and is also used as a
+     * DMFC2 alias for the CHORD POW tag-switch completion bit.
+     */
+    OCTEON_COP2_SEL_LLM_READ_ADDR0 = 0x0400,
+    OCTEON_COP2_SEL_CHORD = OCTEON_COP2_SEL_LLM_READ_ADDR0,
+    OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0 = 0x0401,
+    OCTEON_COP2_SEL_LLM_DATA0 = 0x0402,
+    OCTEON_COP2_SEL_LLM_READ64_ADDR0 = 0x0404,
+    OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0 = 0x0405,
+    OCTEON_COP2_SEL_LLM_READ_ADDR1 = 0x0408,
+    OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1 = 0x0409,
+    OCTEON_COP2_SEL_LLM_DATA1 = 0x040a,
+    OCTEON_COP2_SEL_LLM_READ64_ADDR1 = 0x040c,
+    OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1 = 0x040d,
     OCTEON_COP2_SEL_CRC_POLYNOMIAL = 0x0200,
     OCTEON_COP2_SEL_CRC_IV = 0x0201,
     OCTEON_COP2_SEL_CRC_LEN = 0x0202,
@@ -746,6 +762,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t zuc_lfsr[16];
     uint32_t zuc_window[3];
     uint32_t zuc_tresult;
+    uint64_t llm_data[2];
+    uint64_t chord;
+    QTree *llm_narrow;
+    QTree *llm_wide;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 93a5a497d0..5e63572838 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -200,6 +200,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 23e1ada185..026dc0ea4f 100644
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
index c9d477896c..912993435f 100644
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
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm_narrow, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm_wide, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 9c5f19f41d..3369993fc9 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,6 +16,42 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
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
+        value = mips_octeon_llm_load(crypto->llm_wide, addr);
+    } else {
+        value = octeon_llm_pack_narrow(
+            mips_octeon_llm_load(crypto->llm_narrow, addr));
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
+        mips_octeon_llm_store(&crypto->llm_wide, addr, value);
+    } else {
+        mips_octeon_llm_store(&crypto->llm_narrow, addr,
+                              value & OCTEON_LLM_NARROW_MASK);
+    }
+}
+
 static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
                                           MIPSOcteonSharedMode mode)
 {
@@ -2001,6 +2037,12 @@ uint64_t helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
         return crypto->crc_len;
     case OCTEON_COP2_SEL_CRC_IV_REFLECT:
         return octeon_crc_reflect32_by_byte(crypto->crc_iv);
+    case OCTEON_COP2_SEL_CHORD:
+        return crypto->chord;
+    case OCTEON_COP2_SEL_LLM_DATA0:
+        return crypto->llm_data[0];
+    case OCTEON_COP2_SEL_LLM_DATA1:
+        return crypto->llm_data[1];
     case OCTEON_COP2_SEL_HSH_DATW0:
     case OCTEON_COP2_SEL_HSH_DATW1:
     case OCTEON_COP2_SEL_HSH_DATW2:
@@ -2157,6 +2199,36 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
         crypto->aes_keylen = q;
         break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR0:
+        octeon_llm_read(crypto, 0, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA0:
+        crypto->llm_data[0] = q;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR0:
+        octeon_llm_read(crypto, 0, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR1:
+        octeon_llm_read(crypto, 1, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA1:
+        crypto->llm_data[1] = q;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR1:
+        octeon_llm_read(crypto, 1, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, q, true);
+        break;
     case OCTEON_COP2_SEL_CAMELLIA_FL:
         octeon_camellia_fl_layer(crypto, q, false);
         break;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ce3c7948e0..c7e9bf0840 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -76,6 +76,9 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_GFM_RESINP0:
     case OCTEON_COP2_SEL_GFM_RESINP1:
     case OCTEON_COP2_SEL_GFM_POLY:
+    case OCTEON_COP2_SEL_CHORD:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_DATA1:
         return true;
     default:
         return false;
@@ -111,6 +114,16 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
     case OCTEON_COP2_SEL_CAMELLIA_FL:
     case OCTEON_COP2_SEL_CAMELLIA_FLINV:
+    case OCTEON_COP2_SEL_LLM_READ_ADDR0:
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR0:
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0:
+    case OCTEON_COP2_SEL_LLM_READ_ADDR1:
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1:
+    case OCTEON_COP2_SEL_LLM_DATA1:
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR1:
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_IV:
     case OCTEON_COP2_SEL_CRC_WRITE_LEN:
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index e4107a304c..2adb4de680 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -349,6 +349,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
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
index 5c19adbbcf..65bca8a987 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10923,6 +10923,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
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


