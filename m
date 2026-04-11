Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6B2F36BA5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSR0-0001d0-PF; Sat, 11 Apr 2026 03:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQz-0001cc-7j
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:13 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQx-00011L-5e
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:07:12 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-46aa216a65aso1563915b6e.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775891229; x=1776496029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sg85p7Iqac4DT4DHFeQF4b5N57xVPOx6e9bnRBDjzI=;
 b=dwxtvbBWMXx9xuemf5M60Ng6M2FF43fEZdrqczywcw+QrMRZDSLrBMM2Abfo5Yo0Es
 3TEV5UBb4RxivZ1w+/3icFJxjyGKpc0qpg1uFFheRkFqp/q82foJ87BuNjwvuS0FSYLq
 xCEdJ66vWDuVCSv1zSiwi1ejUmpu2n8fY+TPtC50AQwIlmvnhG7r6fg6HC4XL08US+jf
 UZpBCi8991UoiUdM2+hnJWRvJM9xe6X5E9LxE7NOi1Pevx9L0veL2EEfwbv2nJEh6wNJ
 DNd9h5IQn2QeLNKD3rJ5fQTjp4HcVl1bhidYClHh5K7vp/2m+TFXTCPKgRWgmjeJhFU2
 Cl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775891229; x=1776496029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/sg85p7Iqac4DT4DHFeQF4b5N57xVPOx6e9bnRBDjzI=;
 b=HCf17l5QhDDcEZjKTJ4SLDksucnusy8jbWJ3lJPYD2qWfNCM+xRgce+zn0H33TdVTG
 tbnABXpClJ0BgUCGIiAJzuI5hR1zNqemO9n91xf69B4DhoGRN+EWhwUbbdmyN11T9bba
 6uxR3oY5VxR278CV6pz1HOVPNSA4VPMO6RHD/q8ClzGNrxPciuyEHzZTljf+BYTnYL42
 piuGZfSb2Kh3b1L6szEjeziFQ6g1XxO5IBjGrAiFpxMuW90PL4u8pq4taVkseGyDXkdP
 0uM9k5MvbLHf/ldcltV6yiv7DdIJaMLLPSteH642efgKiH3aXOC4ILDfh3WQ875jUsr+
 D9Eg==
X-Gm-Message-State: AOJu0Yx7GkeP2VAtIcfr3n8aHQzEA0j/B1Z+ZU0o3d44jLkbMGSYyOzC
 oSAxUwan3KkA9jJAPlz17dpZwD+Qo4YTp8Ev1k7fBu6AjSsL3ULOUfQAqgdSzsRpSyg=
X-Gm-Gg: AeBDies0HShME25dluUwa7eeAKZEOoMyaypXkjzdjNE7gBhvDSimhcR9B6vu2jDvM+i
 Dt3bwWt0CyxEWg1YLAmqCK7ixGJaJ0Q8yYC7ohGrxkg660Ii3XFEGszTbgWtXENjFT4WaQBFbXX
 2f+sfE0+8UEysd8jdmBFPz1/8wb+DNCM0g5klezqxj+6E0MaQWcyTkYs2Xv2X6SMP/pDNSmFoFV
 jSAlPP1MJhP0+aUw6zZn0Huav5wY5x/3qtmHwA9v9UTE0AHcmIkxX0OVXDlY4DFuNN1KFD/xcXt
 Yka7T0TaFtujGQs6VnPKKmGmN4BHij+IobyW5S2VPIHjGKD0wLBxU4TojxawhTXNOYOxltiHGYH
 2rerqoHKAY6fmDAghp6nrSw6uQE0cF6dLwquUGwMPq4NXwFatCYzuOM8+g1tfqj6s9Qp4xdEYHR
 D0VfCdKt8L4jHEt9lUrt6d+ITIe2dEeAu1XWJqGZCXNk5S2Mk/oSQ9lOiUja3a/KcTFg4hM5Is+
 wW4G8vyiQ/tMzxMrRyY70t6oeEDm825hckviOGw9iO5QHQQsijHaOA7IUondQqjirFHjPg=
X-Received: by 2002:a05:6808:518f:b0:459:b569:702f with SMTP id
 5614622812f47-4789e427876mr3260738b6e.15.1775891229407; 
 Sat, 11 Apr 2026 00:07:09 -0700 (PDT)
Received: from Mac.localdomain (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm2651091b6e.5.2026.04.11.00.07.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 11 Apr 2026 00:07:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 9/9] target/mips: add Octeon CHORD and LLM COP2 support
Date: Sat, 11 Apr 2026 01:06:35 -0600
Message-ID: <20260411070637.72421-9-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411070637.72421-1-james.hilliard1@gmail.com>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x235.google.com
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
legacy dmfc2 alias, and implement sparse backing storage for the two
LLM sets so user-mode code can save, restore, and probe the
architectural state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/cpu.c               |  28 ++++++++
 target/mips/cpu.h               |  21 ++++++
 target/mips/helper.h            |   1 +
 target/mips/tcg/octeon_crypto.c | 111 ++++++++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c     |   6 ++
 target/mips/tcg/translate.c     |  21 ++++++
 6 files changed, 188 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index ec70c10985..b098c5030d 100644
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
@@ -183,6 +184,18 @@ static bool mips_cpu_has_work(CPUState *cs)
 
 #include "cpu-defs.c.inc"
 
+static void mips_cpu_destroy_octeon_state(CPUMIPSState *env)
+{
+    if (env->octeon_crypto.llm_narrow) {
+        q_tree_destroy(env->octeon_crypto.llm_narrow);
+        env->octeon_crypto.llm_narrow = NULL;
+    }
+    if (env->octeon_crypto.llm_wide) {
+        q_tree_destroy(env->octeon_crypto.llm_wide);
+        env->octeon_crypto.llm_wide = NULL;
+    }
+}
+
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -194,6 +207,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 
+    mips_cpu_destroy_octeon_state(env);
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
     /* Reset registers to their default values */
@@ -248,6 +262,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->octeon_crypto.chord = 1;
+    }
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -264,6 +281,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      * hardware registers.
      */
     env->CP0_HWREna |= 0x0000000F;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->CP0_HWREna |= 0x40000000u;
+    }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
     }
@@ -422,6 +442,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
+static void mips_cpu_finalize(Object *obj)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+
+    mips_cpu_destroy_octeon_state(&cpu->env);
+}
+
 static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     const MIPSCPU *cpu = MIPS_CPU(cs);
@@ -636,6 +663,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 69f96172d8..03ee9181a0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -617,6 +618,22 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
     OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
     OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
+    /*
+     * The low-latency memory window shares 0x0400 with the older CHORD
+     * alias for the POW tag-switch completion bit. Newer code reads CHORD
+     * via RDHWR $30, but compatibility still requires DMFC2 0x0400.
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
@@ -754,6 +771,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t zuc_lfsr[16];
     uint32_t zuc_window[3];
     uint32_t zuc_tresult;
+    uint64_t llm_data[2];
+    target_ulong chord;
+    QTree *llm_narrow;
+    QTree *llm_wide;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 0d5713b705..faa8061dc9 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -200,6 +200,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 70cd1ddcac..e9937ed1ca 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -15,6 +15,81 @@
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
+#include "qemu/qtree.h"
+
+#define OCTEON_LLM_NARROW_MASK ((1ULL << 36) - 1)
+
+static gint octeon_u64_tree_compare(gconstpointer a, gconstpointer b,
+                                    gpointer user_data)
+{
+    uint64_t av = *(const uint64_t *)a;
+    uint64_t bv = *(const uint64_t *)b;
+
+    return (av > bv) - (av < bv);
+}
+
+static QTree *octeon_llm_tree_new(void)
+{
+    return q_tree_new_full(octeon_u64_tree_compare, NULL, g_free, g_free);
+}
+
+static uint64_t octeon_llm_load(QTree *tree, uint64_t addr)
+{
+    uint64_t key = addr;
+    uint64_t *value = tree ? q_tree_lookup(tree, &key) : NULL;
+
+    return value ? *value : 0;
+}
+
+static void octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value)
+{
+    uint64_t *key;
+    uint64_t *stored;
+
+    if (!*treep) {
+        *treep = octeon_llm_tree_new();
+    }
+
+    key = g_new(uint64_t, 1);
+    stored = g_new(uint64_t, 1);
+    *key = addr;
+    *stored = value;
+    q_tree_replace(*treep, key, stored);
+}
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
+        value = octeon_llm_load(crypto->llm_wide, addr);
+    } else {
+        value = octeon_llm_pack_narrow(octeon_llm_load(crypto->llm_narrow,
+                                                       addr));
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
+        octeon_llm_store(&crypto->llm_wide, addr, value);
+    } else {
+        octeon_llm_store(&crypto->llm_narrow, addr,
+                         value & OCTEON_LLM_NARROW_MASK);
+    }
+}
 
 static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
                                           MIPSOcteonSharedMode mode)
@@ -1935,6 +2010,12 @@ target_ulong helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
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
@@ -2088,6 +2169,36 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
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
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 3164166910..eae1ce7083 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -353,6 +353,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
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
index 625faae9d1..6760b816d7 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -9185,6 +9185,9 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_GFM_RESINP0:
     case OCTEON_COP2_SEL_GFM_RESINP1:
     case OCTEON_COP2_SEL_GFM_POLY:
+    case OCTEON_COP2_SEL_CHORD:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_DATA1:
         return true;
     default:
         return false;
@@ -9220,6 +9223,16 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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
@@ -11135,6 +11148,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_helper_rdhwr_xnp(t0, tcg_env);
         gen_store_gpr(t0, rt);
         break;
+    case 30:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        gen_helper_rdhwr_chord(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        break;
     case 29:
 #if defined(CONFIG_USER_ONLY)
         tcg_gen_ld_tl(t0, tcg_env,
-- 
2.53.0


