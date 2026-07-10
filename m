Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8295DC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4R3-0001F4-A2; Fri, 10 Jul 2026 02:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qg-00017j-H5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qe-0001tb-6o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso3796605ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663777; x=1784268577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=goBibbm903IrHGlQ25HxbHDhM5i9maTD/frlb0Y55Zo=;
 b=JLPMm1Ky4u0ZWns9oDStOM8HyXFbMdw8R6lq/h9zCFZXTlUQgjrc225yJ9+/t7Slk7
 6S699NQlA+bTTiZdORxv3RMI3c3wc3RlW4FOBB0z2eV0vhxL8pxVqALRhgE6FFd1xGX0
 wA85opmkUwoNF3eXoEoasSPu7hn0nJ10Qx/hA2xTMT2xjFwW8XIppnAKNGrQileTH4Ge
 qgUueINr4ICUrN1L4VPtkd+M9J1YevTSUc0SO7pXArN1QmYDBezP/TpCx4slBBhH9Nu5
 kJ/gJ54u4pmIeroqZ43mlCAZMC2bNmsHMSDl/yNZjGMO9uYFait3ff+3yvGtR34rxA0s
 C1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663777; x=1784268577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=goBibbm903IrHGlQ25HxbHDhM5i9maTD/frlb0Y55Zo=;
 b=nEinW1g+tN4bPBH3OrjPPxSipbNuizUolp/1ikAmBsraJbxxCCFC0UGYN0T3mbVgol
 N0fzK0O/c4cM8+5cmQdz1GLwJIEphk5Xp/k+GjHMaW9Pctt1HCoUOwJxw5ILM2Z+vXNg
 21g2Vg3BReQzjFV0hupiZKrzlgMqXGNqiYYsMy67SxASmf8n8Z3EvrMQjFZ8AHGA0nsK
 J7lXD9ehe6V30tw5OSq2EEpzuvpeHcUTLXD7siqmWdYh5e8GXjrt0s8iTTKZqLmgh6Da
 g3Sn8C7XPhy8lyNZny/A1Q7cYId1+Lkep5V1qJ+1/An7wAFrt5YcYrs5cEkq3lr9pP4I
 wqXw==
X-Gm-Message-State: AOJu0YwjkEl33K5FDzqTBt/Vjo6gwJXMDOqvdMr6DqL1WjpuRAPI8ReI
 ulokWX/nphR2ASrXWgNFBCQ9hxaY+13dQvaLaa7FtPrIu567lkYnSdUYx+PaeWzKiZ+g9fpNHfg
 oGeiUxMZ+UzOXUm50L3tZ4h+XF/NOBgKIpvTjvfm+bK4L/BU6Djk1pkspQxadJuFQ3hD2hg9UNp
 EilZOCexwBPe8OMd7Vm82UrTxbnBzPsbJNwfsKojE/k4shvSRk
X-Gm-Gg: AfdE7cmKIXCdTb6xZtpxODKfQqDdWRk++mjGNZdmdplNBxQctnCBUyC+/MzIv5Jz/HN
 lPCr9g1bRccjOteWGNjJ35LKxUz26ZhedoqWrx55v2vmAvbvTolZj5uMdxN8AW9b22qQN1g2EIc
 Y7xVw9iyH2HH6/RoCAi+AY/vPBnptv3EXiGVx56afRs+jgMo1Wc5Yz+yQDxE1E1Si+AjRRByahP
 QEdE9mqkvo4+hDR3H9t2fmISE/lzLstHqa0PiwnkY5vfcrPTGLeg5kagNDmB6ad7CrNNB3DhWoW
 AGCWsAT/8U75n2FfrbjnJx71zVZJsj5TgIwiFDQBcj0ViGE45E82RjwlUIAArBTso08zH9TCw92
 sin9qmZGDfKtVsnaqz373LKEqj3ZHXnCXcpiY7nYjDrwgmbjoDTiLlv8gsMeIioKD0J5MD1EjxV
 vVioYerjTDV4srQx5aK9M4w8REHg0M7/8o4JurT7g=
X-Received: by 2002:a17:903:11c7:b0:2c9:deec:f564 with SMTP id
 d9443c01a7336-2ccea373a8cmr110909905ad.13.1783663777346; 
 Thu, 09 Jul 2026 23:09:37 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:36 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/7] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
Date: Fri, 10 Jul 2026 14:09:10 +0800
Message-ID: <20260710060914.1227027-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from vector load/store instructions.

We will skip the host fast-path and fall back to the slow TLB-path to
raise misaligned load/store exceptions for the misaligned accesses when
Zicclsm extension is disabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 18 +++++-
 target/riscv/tcg/vector_helper.c            | 65 ++++++++++++++++-----
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 23262b1d036..a22e2cae6ce 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -1191,26 +1191,38 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Use the helper function if either:
      * - vstart is not 0.
      */
-
     bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
         MemOp atomicity = MO_ATOM_NONE;
+        MemOp alignment = MO_UNALN;
+
+        /*
+         * If Zicclsm is disabled, require alignment based on element size.
+         * Use MO_ALIGN_* based on log2_esz (0 = MO_UNALN, 1 = MO_ALIGN_2, etc).
+         */
+        if (!s->cfg_ptr->ext_zicclsm) {
+            alignment = log2_esz << MO_ASHIFT;
+        }
+
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
+
         for (int i = 0; i < size; i += 8) {
             TCGv addr = get_address(s, rs1, i);
             if (is_load) {
-                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
                 tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
             } else {
                 tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
+                                    MO_LEUQ | atomicity | alignment);
             }
             if (i == size - 8) {
                 tcg_gen_movi_i32(cpu_vstart, 0);
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e321ca26161..e28d8a3d9fd 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -199,20 +199,34 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
+static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
+{
+    int mmu_idx = riscv_env_mmu_index(env, false);
+    MemOp memop = size_memop(size) | mo_endian_env(env);
+
+    if (!riscv_cpu_cfg(env)->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
+
+    return make_memop_idx(memop, mmu_idx);
+}
+
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
                                    uint32_t idx, void *vd, uintptr_t retaddr);
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
-#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
+#define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
-    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -220,20 +234,27 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     *cur = (ETYPE)LDSUF##_p(host);                          \
 }
 
-GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
+GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
+GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
+GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
-#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
+GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
+GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
+
+#define GEN_VEXT_TLB_ST_ELEM(NAME, ETYPE, H, STSUF)         \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE data = *((ETYPE *)vd + H(idx));                   \
-    cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
+    MemOpIdx oi = vext_make_memop_idx(env, sizeof(ETYPE));  \
+    cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
 }                                                           \
-                                                            \
+
+#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
 static inline QEMU_ALWAYS_INLINE                            \
 void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
@@ -241,10 +262,15 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
     STSUF##_p(host, data);                                  \
 }
 
-GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
+GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
+GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
+GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
+
+GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
+GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
@@ -398,7 +424,16 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
 
-    if (flags == 0) {
+    bool misaligned = addr & (esz - 1);
+
+    /*
+     * Allow the host fast-pash when:
+     *   1. Page permission/pmp/watchpoint are checked and we have a contigous
+     *      host mapping.
+     *   2. Zicclsm is enabled or load/store is not a misaligned access.
+     * Otherwise, we will fall back to the slow TLB-path.
+     */
+    if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
         if (nf == 1) {
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
-- 
2.43.0


