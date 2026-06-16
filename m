Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD9DCD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgd-0005b9-Ez; Tue, 16 Jun 2026 06:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgc-0005Zk-KG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:26 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgZ-000382-6D
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:26 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so4252824a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604381; x=1782209181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmrbFqSQfj+2KHG6KE7ufOnTgtaligS6RtPxzv2NkK4=;
 b=lkkwD+dQ52ce9t2GByFPtQbqM+9CNiBBnr0X2CjPbu0sPePeeJGyQ4H8NJp9QOeH00
 7IOEgspkLx42NzRM5AbGH0vUUiViFk4Lhu9zTMOkmdAkaMoDGWWZnEFoE5vGp6srOsjL
 W3YII1nfZlu9H/clSLJotbqaMe4332KHvUlwbEjCRrLa8yTUqIHVE7YVgnAprAXdkVjZ
 fzk1komOXhmyCNiWpegUCGiOaPwD7rPM9XaEr9b1j4j0VOO8U6dh9JXs/DFfxFlFI4zD
 T7XD4Glp8RHJsB0Pd9Evk2u0cKjc/d8FPLE7okKCi0UMRqL0n5otZFIJOh4K8oymCJie
 mhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604381; x=1782209181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmrbFqSQfj+2KHG6KE7ufOnTgtaligS6RtPxzv2NkK4=;
 b=TCAQbkNpTqFG01dVfpp1SAnZ5KlDeESnzUDlZrFK7cDXR08W+aIuCYAZ77ljmoCDRT
 tDpymU149Y+RikpFU50o9Ks8kVY7ca8/foh8anWIf2l2G9QpfNVIKhZO6vPPBNfmFONh
 n7rYAAcmasibf4ZNc2o9sNjkCarUTCGs3KAhJH2BB7qhz3L3LkQbly3hCC+zW9qkGiBV
 jVaaah8mtmY7TBpzA5ah+4S1CNAaNKiELY521WP3X+zePOfBpryBDRaxu6lRC+2XAC9b
 eLS7mI3pLAHGer03UmYsEznSJW9PvJQmu9xE3zeaZ//IpTDf/9Oxb6ukyC3z40qox4va
 X1Ug==
X-Gm-Message-State: AOJu0Yys8WHxzOrBEAwdaong9yW7wz10Gd2L06dLvdRqiEmEt1ZZnlZN
 p8NDu4cRgzrL2CtaMHLv1BV1AG6ehunj8qBnfLZA7ZCJiuoWRW/gkjvvcd2Ruddw
X-Gm-Gg: Acq92OHPzlSze2jxGVlYkLKIEfynG2Hz6M7KlLADMwDjtw6oWHGWBN80vO5EwzCnbEB
 9UpCHklBLqdkahaDWoKsCjHl/QuNGU++MlRVt3ZtlNPqMvEbbtd6CZSGtQW1G//caRxeZClY4B9
 KAlzo6outvfi6dICc2scaCHK7YWYRW4cpRtXYYnGvEOgdROe6B5XA89MrxpTqU90kThafab7Jlw
 +7Vh3vMSLhA0a404oayy8CjCiSX+dvfeSFY45R/Z5NhF7Lg+uvnhiY12kRs1I0DpPVcPElBnMde
 esV6LxJNoAa5gGBoNuLAkuk3HDm+M6/Os6ERwjyi1g59YV5MPfH8ajn0bIgfjXwRtpUAVw7Aiu5
 JjBPhu6JnmR7Wy00ZxEz/OUcWFTj3cvtUdIXB+1HGkZcLLyZ9wi5Fq+NBEVIN8eHx2RNIJSvGHB
 jN/j46Cjed4LSpjvXSN9fxLoV6gSwcOAehBcQPBd6j
X-Received: by 2002:a17:90b:580c:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-37c2bc6f158mr15263834a91.1.1781604380450; 
 Tue, 16 Jun 2026 03:06:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/83] target/riscv: Fix size of vector CSRs
Date: Tue, 16 Jun 2026 20:04:16 +1000
Message-ID: <20260616100527.1939565-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the unprivileged specification:
- vtype: bits 0..7 used, bit XLEN-1 illegal, rest reserved
  => fix to 64-bits.

- vxsat: bit 0 used, vxrm which would occupy bits 1..2 is stored
  separately, and bits 3..31 are set to 0
  => fix to 8-bits.

- vxrm: 2 lowest bits are used for rounding mode, rest set to 0
  => fix to 8-bits.

- vstart: maximum value of VLMAX-1, where VLMAX is at most 2^16
  => fix to 32-bits as vstart is mapped to a TCG global.

- vl: maximum value of VLEN which is at most 2^16
  => fix to 32-bits as vl is mapped to a TCG global.

Fields are shuffled for reduced padding.

Note, the cpu/vector VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260520125406.28693-3-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      |  12 +--
 target/riscv/machine.c                  |  14 +--
 target/riscv/translate.c                |  12 ++-
 target/riscv/vector_helper.c            | 125 ++++++++++++++----------
 target/riscv/insn_trans/trans_rvv.c.inc |  22 ++---
 5 files changed, 103 insertions(+), 82 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a440b03071..981073021f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -193,7 +193,7 @@ FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, ALTFMT, 8, 1)
-FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
+FIELD(VTYPE, RESERVED, 9, sizeof(uint64_t) * 8 - 10)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
@@ -219,11 +219,11 @@ struct CPUArchState {
 
     /* vector coprocessor state. */
     uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
-    target_ulong vxrm;
-    target_ulong vxsat;
-    target_ulong vl;
-    target_ulong vstart;
-    target_ulong vtype;
+    uint64_t vtype;
+    uint32_t vl;
+    uint32_t vstart;
+    uint8_t vxrm;
+    uint8_t vxsat;
     bool vill;
 
     target_ulong pc;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 358320a7fe..45e13a0105 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -138,16 +138,16 @@ static bool vector_needed(void *opaque)
 
 static const VMStateDescription vmstate_vector = {
     .name = "cpu/vector",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = vector_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
-        VMSTATE_UINTTL(env.vxrm, RISCVCPU),
-        VMSTATE_UINTTL(env.vxsat, RISCVCPU),
-        VMSTATE_UINTTL(env.vl, RISCVCPU),
-        VMSTATE_UINTTL(env.vstart, RISCVCPU),
-        VMSTATE_UINTTL(env.vtype, RISCVCPU),
+        VMSTATE_UINT64(env.vtype, RISCVCPU),
+        VMSTATE_UINT32(env.vl, RISCVCPU),
+        VMSTATE_UINT32(env.vstart, RISCVCPU),
+        VMSTATE_UINT8(env.vxrm, RISCVCPU),
+        VMSTATE_UINT8(env.vxsat, RISCVCPU),
         VMSTATE_BOOL(env.vill, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 640691e1c5..4a557b4907 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -38,8 +38,9 @@
 #include "tcg/tcg-cpu.h"
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
+static TCGv_i32 cpu_vl, cpu_vstart;
 static TCGv load_res;
 static TCGv load_val;
 
@@ -1480,6 +1481,10 @@ void riscv_translate_init(void)
     size_t field_offset = 0;
 #endif
 
+    /* 32 bits in size, no offset needed */
+    size_t vl_offset = offsetof(CPURISCVState, vl);
+    size_t vstart_offset = offsetof(CPURISCVState, vstart);
+
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
             offsetof(CPURISCVState, gpr[i]) + field_offset,
@@ -1495,9 +1500,8 @@ void riscv_translate_init(void)
     }
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
-    cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
-    cpu_vstart = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vstart),
-                            "vstart");
+    cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
+    cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 954a85c03a..89012fccb3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -285,7 +285,7 @@ vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
     }
 }
 
-static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
+static void vext_set_tail_elems_1s(uint32_t vl, void *vd,
                                    uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
@@ -388,6 +388,12 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     uint32_t evl = env->vstart + elems;
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
+    /*
+     * Maximum vector length is VLMAX == 2^16 == LMUL * VL / SEW, and
+     * occurs for LMUL == 8, SEW == 8, VL == 2^16.
+     */
+    g_assert(env->vstart < UINT16_MAX && UINT16_MAX - env->vstart >= elems);
+
     /* Check page permission/pmp/watchpoint/etc. */
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
@@ -2224,12 +2230,12 @@ GEN_VEXT_VMERGE_VX(vmerge_vxm_d, int64_t, H8)
  * define common macros for fixed point here.
  */
 typedef void opivv2_rm_fn(void *vd, void *vs1, void *vs2, int i,
-                          CPURISCVState *env, int vxrm);
+                          CPURISCVState *env, uint8_t vxrm);
 
 #define OPIVV2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)     \
 static inline void                                                  \
 do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
-          CPURISCVState *env, int vxrm)                             \
+          CPURISCVState *env, uint8_t vxrm)                         \
 {                                                                   \
     TX1 s1 = *((T1 *)vs1 + HS1(i));                                 \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
@@ -2239,7 +2245,7 @@ do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
 static inline void
 vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              CPURISCVState *env,
-             uint32_t vl, uint32_t vm, int vxrm,
+             uint32_t vl, uint32_t vm, uint8_t vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
     for (uint32_t i = env->vstart; i < vl; i++) {
@@ -2298,7 +2304,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
                  do_##NAME, ESZ);                               \
 }
 
-static inline uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a,
+static inline uint8_t saddu8(CPURISCVState *env, uint8_t vxrm, uint8_t a,
                              uint8_t b)
 {
     uint8_t res = a + b;
@@ -2309,7 +2315,7 @@ static inline uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a,
     return res;
 }
 
-static inline uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
+static inline uint16_t saddu16(CPURISCVState *env, uint8_t vxrm, uint16_t a,
                                uint16_t b)
 {
     uint16_t res = a + b;
@@ -2320,7 +2326,7 @@ static inline uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
     return res;
 }
 
-static inline uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
+static inline uint32_t saddu32(CPURISCVState *env, uint8_t vxrm, uint32_t a,
                                uint32_t b)
 {
     uint32_t res = a + b;
@@ -2331,7 +2337,7 @@ static inline uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
     return res;
 }
 
-static inline uint64_t saddu64(CPURISCVState *env, int vxrm, uint64_t a,
+static inline uint64_t saddu64(CPURISCVState *env, uint8_t vxrm, uint64_t a,
                                uint64_t b)
 {
     uint64_t res = a + b;
@@ -2352,12 +2358,12 @@ GEN_VEXT_VV_RM(vsaddu_vv_w, 4)
 GEN_VEXT_VV_RM(vsaddu_vv_d, 8)
 
 typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
-                          CPURISCVState *env, int vxrm);
+                          CPURISCVState *env, uint8_t vxrm);
 
 #define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
 static inline void                                                  \
 do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
-          CPURISCVState *env, int vxrm)                             \
+          CPURISCVState *env, uint8_t vxrm)                         \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1);           \
@@ -2366,7 +2372,7 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
 static inline void
 vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              CPURISCVState *env,
-             uint32_t vl, uint32_t vm, int vxrm,
+             uint32_t vl, uint32_t vm, uint8_t vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
     for (uint32_t i = env->vstart; i < vl; i++) {
@@ -2435,7 +2441,8 @@ GEN_VEXT_VX_RM(vsaddu_vx_h, 2)
 GEN_VEXT_VX_RM(vsaddu_vx_w, 4)
 GEN_VEXT_VX_RM(vsaddu_vx_d, 8)
 
-static inline int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+static inline int8_t sadd8(CPURISCVState *env, uint8_t vxrm, int8_t a,
+                           int8_t b)
 {
     int8_t res = a + b;
     if ((res ^ a) & (res ^ b) & INT8_MIN) {
@@ -2445,7 +2452,7 @@ static inline int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     return res;
 }
 
-static inline int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a,
+static inline int16_t sadd16(CPURISCVState *env, uint8_t vxrm, int16_t a,
                              int16_t b)
 {
     int16_t res = a + b;
@@ -2456,7 +2463,7 @@ static inline int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a,
     return res;
 }
 
-static inline int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a,
+static inline int32_t sadd32(CPURISCVState *env, uint8_t vxrm, int32_t a,
                              int32_t b)
 {
     int32_t res = a + b;
@@ -2467,7 +2474,7 @@ static inline int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a,
     return res;
 }
 
-static inline int64_t sadd64(CPURISCVState *env, int vxrm, int64_t a,
+static inline int64_t sadd64(CPURISCVState *env, uint8_t vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = a + b;
@@ -2496,7 +2503,7 @@ GEN_VEXT_VX_RM(vsadd_vx_h, 2)
 GEN_VEXT_VX_RM(vsadd_vx_w, 4)
 GEN_VEXT_VX_RM(vsadd_vx_d, 8)
 
-static inline uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a,
+static inline uint8_t ssubu8(CPURISCVState *env, uint8_t vxrm, uint8_t a,
                              uint8_t b)
 {
     uint8_t res = a - b;
@@ -2507,7 +2514,7 @@ static inline uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a,
     return res;
 }
 
-static inline uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
+static inline uint16_t ssubu16(CPURISCVState *env, uint8_t vxrm, uint16_t a,
                                uint16_t b)
 {
     uint16_t res = a - b;
@@ -2518,7 +2525,7 @@ static inline uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
     return res;
 }
 
-static inline uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
+static inline uint32_t ssubu32(CPURISCVState *env, uint8_t vxrm, uint32_t a,
                                uint32_t b)
 {
     uint32_t res = a - b;
@@ -2529,7 +2536,7 @@ static inline uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
     return res;
 }
 
-static inline uint64_t ssubu64(CPURISCVState *env, int vxrm, uint64_t a,
+static inline uint64_t ssubu64(CPURISCVState *env, uint8_t vxrm, uint64_t a,
                                uint64_t b)
 {
     uint64_t res = a - b;
@@ -2558,7 +2565,8 @@ GEN_VEXT_VX_RM(vssubu_vx_h, 2)
 GEN_VEXT_VX_RM(vssubu_vx_w, 4)
 GEN_VEXT_VX_RM(vssubu_vx_d, 8)
 
-static inline int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+static inline int8_t ssub8(CPURISCVState *env, uint8_t vxrm, int8_t a,
+                           int8_t b)
 {
     int8_t res = a - b;
     if ((res ^ a) & (a ^ b) & INT8_MIN) {
@@ -2568,7 +2576,7 @@ static inline int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     return res;
 }
 
-static inline int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a,
+static inline int16_t ssub16(CPURISCVState *env, uint8_t vxrm, int16_t a,
                              int16_t b)
 {
     int16_t res = a - b;
@@ -2579,7 +2587,7 @@ static inline int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a,
     return res;
 }
 
-static inline int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a,
+static inline int32_t ssub32(CPURISCVState *env, uint8_t vxrm, int32_t a,
                              int32_t b)
 {
     int32_t res = a - b;
@@ -2590,7 +2598,7 @@ static inline int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a,
     return res;
 }
 
-static inline int64_t ssub64(CPURISCVState *env, int vxrm, int64_t a,
+static inline int64_t ssub64(CPURISCVState *env, uint8_t vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = a - b;
@@ -2620,7 +2628,7 @@ GEN_VEXT_VX_RM(vssub_vx_w, 4)
 GEN_VEXT_VX_RM(vssub_vx_d, 8)
 
 /* Vector Single-Width Averaging Add and Subtract */
-static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
+static inline uint8_t get_round(uint8_t vxrm, uint64_t v, uint8_t shift)
 {
     uint8_t d = extract64(v, shift, 1);
     uint8_t d1;
@@ -2632,22 +2640,30 @@ static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
 
     d1 = extract64(v, shift - 1, 1);
     D1 = extract64(v, 0, shift);
-    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
+    switch (vxrm) {
+    case 0:
+        /* round-to-nearest-up (add +0.5 LSB) */
         return d1;
-    } else if (vxrm == 1) { /* round-to-nearest-even */
+    case 1:
+        /* round-to-nearest-even */
         if (shift > 1) {
             D2 = extract64(v, 0, shift - 1);
             return d1 & ((D2 != 0) | d);
         } else {
             return d1 & d;
         }
-    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
+    case 2:
+        /* round-down (truncate) */
+        return 0;
+    case 3:
+        /* round-to-odd (OR bits into LSB, aka "jam") */
         return !d & (D1 != 0);
+    default:
+        g_assert_not_reached();
     }
-    return 0; /* round-down (truncate) */
 }
 
-static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a,
+static inline int32_t aadd32(CPURISCVState *env, uint8_t vxrm, int32_t a,
                              int32_t b)
 {
     int64_t res = (int64_t)a + b;
@@ -2656,7 +2672,7 @@ static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a,
     return (res >> 1) + round;
 }
 
-static inline int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a,
+static inline int64_t aadd64(CPURISCVState *env, uint8_t vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = a + b;
@@ -2685,7 +2701,7 @@ GEN_VEXT_VX_RM(vaadd_vx_h, 2)
 GEN_VEXT_VX_RM(vaadd_vx_w, 4)
 GEN_VEXT_VX_RM(vaadd_vx_d, 8)
 
-static inline uint32_t aaddu32(CPURISCVState *env, int vxrm,
+static inline uint32_t aaddu32(CPURISCVState *env, uint8_t vxrm,
                                uint32_t a, uint32_t b)
 {
     uint64_t res = (uint64_t)a + b;
@@ -2694,7 +2710,7 @@ static inline uint32_t aaddu32(CPURISCVState *env, int vxrm,
     return (res >> 1) + round;
 }
 
-static inline uint64_t aaddu64(CPURISCVState *env, int vxrm,
+static inline uint64_t aaddu64(CPURISCVState *env, uint8_t vxrm,
                                uint64_t a, uint64_t b)
 {
     uint64_t res = a + b;
@@ -2722,7 +2738,7 @@ GEN_VEXT_VX_RM(vaaddu_vx_h, 2)
 GEN_VEXT_VX_RM(vaaddu_vx_w, 4)
 GEN_VEXT_VX_RM(vaaddu_vx_d, 8)
 
-static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a,
+static inline int32_t asub32(CPURISCVState *env, uint8_t vxrm, int32_t a,
                              int32_t b)
 {
     int64_t res = (int64_t)a - b;
@@ -2731,7 +2747,7 @@ static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a,
     return (res >> 1) + round;
 }
 
-static inline int64_t asub64(CPURISCVState *env, int vxrm, int64_t a,
+static inline int64_t asub64(CPURISCVState *env, uint8_t vxrm, int64_t a,
                              int64_t b)
 {
     int64_t res = (int64_t)a - b;
@@ -2760,7 +2776,7 @@ GEN_VEXT_VX_RM(vasub_vx_h, 2)
 GEN_VEXT_VX_RM(vasub_vx_w, 4)
 GEN_VEXT_VX_RM(vasub_vx_d, 8)
 
-static inline uint32_t asubu32(CPURISCVState *env, int vxrm,
+static inline uint32_t asubu32(CPURISCVState *env, uint8_t vxrm,
                                uint32_t a, uint32_t b)
 {
     int64_t res = (int64_t)a - b;
@@ -2769,7 +2785,7 @@ static inline uint32_t asubu32(CPURISCVState *env, int vxrm,
     return (res >> 1) + round;
 }
 
-static inline uint64_t asubu64(CPURISCVState *env, int vxrm,
+static inline uint64_t asubu64(CPURISCVState *env, uint8_t vxrm,
                                uint64_t a, uint64_t b)
 {
     uint64_t res = (uint64_t)a - b;
@@ -2798,7 +2814,8 @@ GEN_VEXT_VX_RM(vasubu_vx_w, 4)
 GEN_VEXT_VX_RM(vasubu_vx_d, 8)
 
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
-static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+static inline int8_t vsmul8(CPURISCVState *env, uint8_t vxrm, int8_t a,
+                            int8_t b)
 {
     uint8_t round;
     int16_t res;
@@ -2818,7 +2835,7 @@ static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     }
 }
 
-static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+static int16_t vsmul16(CPURISCVState *env, uint8_t vxrm, int16_t a, int16_t b)
 {
     uint8_t round;
     int32_t res;
@@ -2838,7 +2855,7 @@ static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
     }
 }
 
-static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+static int32_t vsmul32(CPURISCVState *env, uint8_t vxrm, int32_t a, int32_t b)
 {
     uint8_t round;
     int64_t res;
@@ -2858,7 +2875,7 @@ static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
     }
 }
 
-static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+static int64_t vsmul64(CPURISCVState *env, uint8_t vxrm, int64_t a, int64_t b)
 {
     uint8_t round;
     uint64_t hi_64, lo_64;
@@ -2906,7 +2923,7 @@ GEN_VEXT_VX_RM(vsmul_vx_d, 8)
 
 /* Vector Single-Width Scaling Shift Instructions */
 static inline uint8_t
-vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
+vssrl8(CPURISCVState *env, uint8_t vxrm, uint8_t a, uint8_t b)
 {
     uint8_t round, shift = b & 0x7;
     uint8_t res;
@@ -2916,7 +2933,7 @@ vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
     return res;
 }
 static inline uint16_t
-vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
+vssrl16(CPURISCVState *env, uint8_t vxrm, uint16_t a, uint16_t b)
 {
     uint8_t round, shift = b & 0xf;
 
@@ -2924,7 +2941,7 @@ vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
     return (a >> shift) + round;
 }
 static inline uint32_t
-vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
+vssrl32(CPURISCVState *env, uint8_t vxrm, uint32_t a, uint32_t b)
 {
     uint8_t round, shift = b & 0x1f;
 
@@ -2932,7 +2949,7 @@ vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
     return (a >> shift) + round;
 }
 static inline uint64_t
-vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
+vssrl64(CPURISCVState *env, uint8_t vxrm, uint64_t a, uint64_t b)
 {
     uint8_t round, shift = b & 0x3f;
 
@@ -2958,7 +2975,7 @@ GEN_VEXT_VX_RM(vssrl_vx_w, 4)
 GEN_VEXT_VX_RM(vssrl_vx_d, 8)
 
 static inline int8_t
-vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+vssra8(CPURISCVState *env, uint8_t vxrm, int8_t a, int8_t b)
 {
     uint8_t round, shift = b & 0x7;
 
@@ -2966,7 +2983,7 @@ vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
     return (a >> shift) + round;
 }
 static inline int16_t
-vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+vssra16(CPURISCVState *env, uint8_t vxrm, int16_t a, int16_t b)
 {
     uint8_t round, shift = b & 0xf;
 
@@ -2974,7 +2991,7 @@ vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
     return (a >> shift) + round;
 }
 static inline int32_t
-vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+vssra32(CPURISCVState *env, uint8_t vxrm, int32_t a, int32_t b)
 {
     uint8_t round, shift = b & 0x1f;
 
@@ -2982,7 +2999,7 @@ vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
     return (a >> shift) + round;
 }
 static inline int64_t
-vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+vssra64(CPURISCVState *env, uint8_t vxrm, int64_t a, int64_t b)
 {
     uint8_t round, shift = b & 0x3f;
 
@@ -3010,7 +3027,7 @@ GEN_VEXT_VX_RM(vssra_vx_d, 8)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
 static inline int8_t
-vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
+vnclip8(CPURISCVState *env, uint8_t vxrm, int16_t a, int8_t b)
 {
     uint8_t round, shift = b & 0xf;
     int16_t res;
@@ -3029,7 +3046,7 @@ vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
 }
 
 static inline int16_t
-vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
+vnclip16(CPURISCVState *env, uint8_t vxrm, int32_t a, int16_t b)
 {
     uint8_t round, shift = b & 0x1f;
     int32_t res;
@@ -3048,7 +3065,7 @@ vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
 }
 
 static inline int32_t
-vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b)
+vnclip32(CPURISCVState *env, uint8_t vxrm, int64_t a, int32_t b)
 {
     uint8_t round, shift = b & 0x3f;
     int64_t res;
@@ -3081,7 +3098,7 @@ GEN_VEXT_VX_RM(vnclip_wx_h, 2)
 GEN_VEXT_VX_RM(vnclip_wx_w, 4)
 
 static inline uint8_t
-vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
+vnclipu8(CPURISCVState *env, uint8_t vxrm, uint16_t a, uint8_t b)
 {
     uint8_t round, shift = b & 0xf;
     uint16_t res;
@@ -3097,7 +3114,7 @@ vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
 }
 
 static inline uint16_t
-vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
+vnclipu16(CPURISCVState *env, uint8_t vxrm, uint32_t a, uint16_t b)
 {
     uint8_t round, shift = b & 0x1f;
     uint32_t res;
@@ -3113,7 +3130,7 @@ vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
 }
 
 static inline uint32_t
-vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
+vnclipu32(CPURISCVState *env, uint8_t vxrm, uint64_t a, uint32_t b)
 {
     uint8_t round, shift = b & 0x3f;
     uint64_t res;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9a86c6dcd4..23262b1d03 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -203,7 +203,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 
     if (rd == 0 && rs1 == 0) {
         s1 = tcg_temp_new();
-        tcg_gen_mov_tl(s1, cpu_vl);
+        tcg_gen_ext_i32_tl(s1, cpu_vl);
     } else if (rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_constant_tl(RV_VLEN_MAX);
@@ -1213,9 +1213,9 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                 tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
             }
             if (i == size - 8) {
-                tcg_gen_movi_tl(cpu_vstart, 0);
+                tcg_gen_movi_i32(cpu_vstart, 0);
             } else {
-                tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
+                tcg_gen_addi_i32(cpu_vstart, cpu_vstart, 8 >> log2_esz);
             }
         }
     } else {
@@ -2426,7 +2426,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
                            s->cfg_ptr->vlenb, data,                     \
                            (s->altfmt ? gen_helper_##BFA_HELPER :       \
                                         fns[s->sew - 1]));              \
-        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        tcg_gen_movi_i32(cpu_vstart, 0);                                \
         finalize_rvv_inst(s);                                           \
                                                                         \
         return true;                                                    \
@@ -3641,7 +3641,7 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
         vec_element_loadi(s, t1, a->rs2, 0, true);
         tcg_gen_trunc_i64_tl(dest, t1);
         gen_set_gpr(s, a->rd, dest);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3658,7 +3658,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         TCGv s1;
         TCGLabel *over = gen_new_label();
 
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
 
@@ -3670,7 +3670,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei_tail(s, a->rd, t1);
         gen_set_label(over);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3698,7 +3698,7 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
         }
 
         mark_fs_dirty(s);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3719,7 +3719,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         TCGLabel *over = gen_new_label();
 
         /* if vstart >= vl, skip vector register write back */
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3728,7 +3728,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         vec_element_storei_tail(s, a->rd, t1);
 
         gen_set_label(over);
-        tcg_gen_movi_tl(cpu_vstart, 0);
+        tcg_gen_movi_i32(cpu_vstart, 0);
         finalize_rvv_inst(s);
         return true;
     }
@@ -3793,7 +3793,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
                                                                         \
         fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
                                                                         \
-        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        tcg_gen_movi_i32(cpu_vstart, 0);                                \
         finalize_rvv_inst(s);                                           \
                                                                         \
         return true;                                                    \
-- 
2.54.0


