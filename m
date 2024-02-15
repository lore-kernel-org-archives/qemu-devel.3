Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECFEC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahPs-0001dn-19; Thu, 15 Feb 2024 14:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPp-0001d9-V7
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:01 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPR-0004gw-Fa
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:01 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d72f71f222so10297925ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708025314; x=1708630114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QW83A0gGAC5k+fWtH60j37LLDzdUuqaercnK+L70kbg=;
 b=jtRQL4VJJtrTWj6tHERaodTWHqIjVqAisFj/f6w+TA61FwHHrz5tJR9F9A6n/4741z
 xQ0B3IJj4P1HJVeVBLDbfhF63xfK0F5z4qzuUtPCsBZfMywi7ugD+DHEK0ugEYHt7e8f
 v1xLy86EPHM3dA+aILvRKGNoXAsP4SKZulXuAS/6myAtp8d7zJi90OBDzEeTwt4+4ICT
 th0yuWI0KftDsxCbih0f5E0xl2IR92G2xyMO0zl7hXkLgYAVXVl3/C4MI4KIOjVQhMnS
 WTtDT8mUlDDPJd7rjAvr+OL0AhK9wU5ymM4HwXpvbb+7mW7pP7tM5N4WgE/y6H6DDhgP
 4yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025314; x=1708630114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QW83A0gGAC5k+fWtH60j37LLDzdUuqaercnK+L70kbg=;
 b=lNt0+WGSpC1Ag9QJb6rxO35StB/SxNz8kRuvHQTFkIAz0FzPqvkGxULoRvsfZmh3pT
 V489HRwgCzp4mtFbkpl974OpZ6qicIUkSGqqwiq0wRyl1SpqlwpKNcfTtBW3Yox0/nxa
 YbU+TsCZuWM8mnAm4kd1YNqnCcc2HPXAVaWyyWp1qm7Qxkb7QuWwkN0axouMBOJiC1uq
 QXHRy+4gAIdPY15NPeZs4UPw96Dlzri0CZKznNa7VKdABf8MXPcD84Q+lEsraLH111ig
 HJCF5vZjYLbmvwCJ4fm2rmlfiDV086WYWZIy6CUgdblokNLqGaiCjd86ZHQl0Q6bfy5C
 XyNQ==
X-Gm-Message-State: AOJu0YyFP3O7khG4w/c/cCg+UGlRD1GegwFyjHm3R36T4zMhhFFF4WvU
 O6m3TQx6WZ6f6pPCNJW1rCiRIPefBWAeEQrmAZFdnn45vVXWcqOsPLIZZMQgURxv813zqEgCFqD
 1DxIHfxiNnf5eulQ32G5ZtZLoqx7/V0IFpJp1Y4D1X2gH3pFYm7oS+ktuBaWTBuqLndW1kzpi6H
 luDKvbIWvrZV1ZRQyZsSeM+Zkl7oCVaLGd/Xi5B1UJ
X-Google-Smtp-Source: AGHT+IFoF6FsR2Rio4oDdz1n5oVrhHIaT1Pw5UsSUcdAluhuK7sNic1WojHYS4NGZJV5rYY/tca0mQ==
X-Received: by 2002:a17:902:b20a:b0:1d9:a647:5579 with SMTP id
 t10-20020a170902b20a00b001d9a6475579mr2431187plr.1.1708025314095; 
 Thu, 15 Feb 2024 11:28:34 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902a60800b001db5ee73fe9sm1618653plq.114.2024.02.15.11.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 11:28:33 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Subject: [RFC PATCH 1/6] target/riscv: Seperate vector segment ld/st
 instructions
Date: Fri, 16 Feb 2024 03:28:12 +0800
Message-Id: <20240215192823.729209-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215192823.729209-1-max.chou@sifive.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit seperate the helper function implementations of vector
segment load/store instructions from other vector load/store
instructions.
This can improve performance by avoiding unnecessary segment operation
when NF = 1.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                   |   4 +
 target/riscv/insn32.decode              |  11 ++-
 target/riscv/insn_trans/trans_rvv.c.inc |  61 +++++++++++++++
 target/riscv/vector_helper.c            | 100 +++++++++++++++++++++---
 4 files changed, 164 insertions(+), 12 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8a635238514..8b6ddc4cb88 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -157,18 +157,22 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
 DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlsege8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle8_v_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlsege8_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse8_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vssege8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse32_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse64_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse8_v_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vssege8_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse16_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse32_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse64_v_mask, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd1..0712e9f6314 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -77,6 +77,7 @@
 @r2      .......   ..... ..... ... ..... ....... &r2 %rs1 %rd
 @r2_vm_1 ...... . ..... ..... ... ..... ....... &rmr vm=1 %rs2 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r2_nf_1_vm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm nf=1 %rs1 %rd
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
@@ -349,11 +350,17 @@ hsv_d     0110111  .....   ..... 100 00000 1110011 @r2_s
 
 # *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
 # Vector unit-stride load/store insns.
-vle8_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+{
+  vle8_v     000 000 . 00000 ..... 000 ..... 0000111 @r2_nf_1_vm
+  vlsege8_v  ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+}
 vle16_v    ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vle32_v    ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
 vle64_v    ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
-vse8_v     ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+{
+  vse8_v     000 000 . 00000 ..... 000 ..... 0100111 @r2_nf_1_vm
+  vssege8_v  ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+}
 vse16_v    ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vse32_v    ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
 vse64_v    ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9e101ab4343..04fc6329359 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -690,6 +690,40 @@ GEN_VEXT_TRANS(vle16_v, MO_16, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle32_v, MO_32, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle64_v, MO_64, r2nfvm, ld_us_op, ld_us_check)
 
+static bool ld_us_seg_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4] = {
+        /* masked unit stride load */
+        { gen_helper_vlsege8_v_mask, gen_helper_vle16_v_mask,
+          gen_helper_vle32_v_mask, gen_helper_vle64_v_mask },
+        /* unmasked unit stride load */
+        { gen_helper_vlsege8_v, gen_helper_vle16_v,
+          gen_helper_vle32_v, gen_helper_vle64_v }
+    };
+
+    fn =  fns[a->vm][eew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    /*
+     * Vector load/store instructions have the EEW encoded
+     * directly in the instructions. The maximum vector size is
+     * calculated with EMUL rather than LMUL.
+     */
+    uint8_t emul = vext_get_emul(s, eew);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
+}
+
+GEN_VEXT_TRANS(vlsege8_v,  MO_8,  r2nfvm, ld_us_seg_op, ld_us_check)
+
 static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
@@ -727,6 +761,33 @@ GEN_VEXT_TRANS(vse16_v, MO_16, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse32_v, MO_32, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse64_v, MO_64, r2nfvm, st_us_op, st_us_check)
 
+static bool st_us_seg_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4] = {
+        /* masked unit stride store */
+        { gen_helper_vssege8_v_mask, gen_helper_vse16_v_mask,
+          gen_helper_vse32_v_mask, gen_helper_vse64_v_mask },
+        /* unmasked unit stride store */
+        { gen_helper_vssege8_v, gen_helper_vse16_v,
+          gen_helper_vse32_v, gen_helper_vse64_v }
+    };
+
+    fn =  fns[a->vm][eew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    uint8_t emul = vext_get_emul(s, eew);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
+}
+
+GEN_VEXT_TRANS(vssege8_v,  MO_8,  r2nfvm, st_us_seg_op, st_us_check)
+
 /*
  *** unit stride mask load and store
  */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb20..e8fbb921449 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -201,6 +201,32 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
                  uint32_t desc, uint32_t vm,
                  vext_ldst_elem_fn *ldst_elem,
                  uint32_t log2_esz, uintptr_t ra)
+{
+    uint32_t i;
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+    uint32_t esz = 1 << log2_esz;
+    uint32_t vma = vext_vma(desc);
+
+    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+        target_ulong addr = base + stride * i;
+        ldst_elem(env, adjust_addr(env, addr), i, vd, ra);
+    }
+    env->vstart = 0;
+
+    vext_set_tail_elems_1s(env->vl, vd, desc, 1, esz, max_elems);
+}
+
+static void
+vext_ldst_stride_segment(void *vd, void *v0, target_ulong base,
+                         target_ulong stride, CPURISCVState *env,
+                         uint32_t desc, uint32_t vm,
+                         vext_ldst_elem_fn *ldst_elem,
+                         uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
@@ -234,8 +260,8 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, vm,       \
+                             LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());    \
 }
 
 GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
@@ -249,8 +275,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, vm,       \
+                             STORE_FN, ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
 GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b)
@@ -267,6 +293,26 @@ static void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
              uintptr_t ra)
+{
+    uint32_t i;
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+    uint32_t esz = 1 << log2_esz;
+
+    /* load bytes from guest memory */
+    for (i = env->vstart; i < evl; i++, env->vstart++) {
+        target_ulong addr = base + (i << log2_esz);
+        ldst_elem(env, adjust_addr(env, addr), i, vd, ra);
+    }
+    env->vstart = 0;
+
+    vext_set_tail_elems_1s(evl, vd, desc, 1, esz, max_elems);
+}
+
+/* unmasked unit-stride segment load and store operation */
+static void
+vext_ldst_us_segment(void *vd, target_ulong base, CPURISCVState *env,
+                     uint32_t desc, vext_ldst_elem_fn *ldst_elem,
+                     uint32_t log2_esz, uint32_t evl, uintptr_t ra)
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
@@ -308,10 +354,27 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                  ctzl(sizeof(ETYPE)), env->vl, GETPC());                \
 }
 
+#define GEN_VEXT_LD_US_SEG(NAME, ETYPE, LOAD_FN)                        \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, false,    \
+                             LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    vext_ldst_us_segment(vd, base, env, desc, LOAD_FN,                  \
+                         ctzl(sizeof(ETYPE)), env->vl, GETPC());        \
+}
+
 GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_US(vle16_v, int16_t, lde_h)
-GEN_VEXT_LD_US(vle32_v, int32_t, lde_w)
-GEN_VEXT_LD_US(vle64_v, int64_t, lde_d)
+GEN_VEXT_LD_US_SEG(vlsege8_v, int8_t, lde_b)
+GEN_VEXT_LD_US_SEG(vle16_v, int16_t, lde_h)
+GEN_VEXT_LD_US_SEG(vle32_v, int32_t, lde_w)
+GEN_VEXT_LD_US_SEG(vle64_v, int64_t, lde_d)
 
 #define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN)                            \
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
@@ -329,10 +392,27 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
                  ctzl(sizeof(ETYPE)), env->vl, GETPC());                 \
 }
 
+#define GEN_VEXT_ST_US_SEG(NAME, ETYPE, STORE_FN)                        \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
+                         CPURISCVState *env, uint32_t desc)              \
+{                                                                        \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, false,     \
+                             STORE_FN, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                        \
+                                                                         \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
+                  CPURISCVState *env, uint32_t desc)                     \
+{                                                                        \
+    vext_ldst_us_segment(vd, base, env, desc, STORE_FN,                  \
+                         ctzl(sizeof(ETYPE)), env->vl, GETPC());         \
+}
+
 GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_US(vse16_v, int16_t, ste_h)
-GEN_VEXT_ST_US(vse32_v, int32_t, ste_w)
-GEN_VEXT_ST_US(vse64_v, int64_t, ste_d)
+GEN_VEXT_ST_US_SEG(vssege8_v, int8_t, ste_b)
+GEN_VEXT_ST_US_SEG(vse16_v, int16_t, ste_h)
+GEN_VEXT_ST_US_SEG(vse32_v, int32_t, ste_w)
+GEN_VEXT_ST_US_SEG(vse64_v, int64_t, ste_d)
 
 /*
  * unit stride mask load and store, EEW = 1
-- 
2.34.1


