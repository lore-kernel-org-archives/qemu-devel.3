Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED1DC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVxV-0006On-M2; Tue, 30 Jun 2026 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwp-00067X-Ug
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:19 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwk-0004uh-6V
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:10 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8894387780so1849665a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1782816244; x=1783421044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtIyYpzeM5Kwvua36guWtYHkqs/SjveRWH6ItRKTCCs=;
 b=UefcmMURa/pLU7DgXqr1Tq6VXyRDGNT2YpxdwupEkU8TiUWJPlgzVW4QalB4DqxVoE
 Dh6NnDT3BJgkYs7gpnFQo7Ho7esj+sG/YaVEuFhnMvQtM05k/ArTLdp9y+TZ6c5EkOGU
 9Vn+ar00UvXRGc3muYkK2gNUwP/9qf+GjBZuvvoYQmq0+jhJFfDMn4b+ZFxNO5r1LS4O
 q8XWgbISw6UU0X8oVL+pNcrhzf10uRY6jzMxVlwA/LN2LlvICG504LUTDLTm8ITIbYPq
 Wj+lZpjPhImVKym/EhWo+RCozDt/Z1UAs7ot0VKn2aLADVCy8nTL336Rd9V8EE2ln+jm
 MWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816244; x=1783421044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtIyYpzeM5Kwvua36guWtYHkqs/SjveRWH6ItRKTCCs=;
 b=PeJj3SXKKSOCEn3bC+rOvPi33X11JwXxrkcS/T7rT5GY93K4i76qGGkKmqlwohAcmW
 K/mxSbkn31c58xBWUHLPCGFH29QhV58VqYXx+P/566VuVcB6lsDYMLlmlIfsDvor8iK2
 WiOED/DKIqrZvS9TTPEiblSjCFsBK5Pu4DDANa2h9sq+qnXnifcac5hDQUcN/3Hq8hui
 VmiaYJWfrQTgUOlJPPhKrb+/C3R6+kUx5mrXDIbURjow8HjrUKyVCI30lCqx7GuIrdG9
 LSSATIr/QfsZhKUfN9MdmETDzcBX0F2a5d/6NOf1PiZhT5whu2QbA3mFL+10QuIAiyaQ
 wUsg==
X-Gm-Message-State: AOJu0Yz5P2hvDmwl++K2yd0lYnO1kCadBCPoHFVruYvQ12xP0uyZ6ygp
 UxZbr/cph/lA5cRXVhDIGXnQRspa6zzigT8Y1xPm+El62CqpEnMgZthFBSarqIq3gxl1gtsFZcs
 YIEtRKdEDo551vS/k+HIDO96EHpu+nvEfRnYRLREKZ/9ekwDbRKw8lj9oeHttXK/eZG8Da4Iqk/
 cAp4qr59xSs/2N/FivKUg1ejbHzD+wAJ/FnyeeZ43t3MPhJF8u
X-Gm-Gg: AfdE7cnOMLT/brzCrsedngZSKoWejZs1+LSRbTnVBbePb0ZAtMhT4NhCFbNrWGO5vkd
 JYSQEOiWU/E1q+UlG/5stDdmk3pf/Ca15ftWB+1v8uL2KNY81w7oYcNwnHnFYbCm2S6MpDsw69h
 Gaqzth84ucgpuiZ0PkWnAOhvYi+AHHg6iAhKdt2ZVjh/LOQ2NWZLHc7VKlA2k2i8jMmi41wr2Dt
 YGS0VYa0Wi76FxkYwXfKm72bbzsOOSh91CkJEi6pncR1NzfnexWpP9bFRg1q9zxo0rTGn3j2zWB
 Z/j+oR9rmpKaadLNVLiy7tQug2bLTDL13ArBSoMWCZb7ti0jmBB6m3g9KF69TV3QcMi4AVqqE5B
 Kd4qS6KxMtcL4BmE9+/4l5xgo/Dsq12SKvTqPRclfxZYbgY9tpi7FaW6UGqW4DPZOqA/ayf8ZWD
 fAdJ3ZAk/A7H5FUZS1ysBUyMyquiGol4Pju5vr7Ic=
X-Received: by 2002:a05:6a21:4c03:b0:3bf:bde7:d671 with SMTP id
 adf61e73a8af0-3bfc50a7f6amr2633327637.20.1782816243692; 
 Tue, 30 Jun 2026 03:44:03 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbf95be56sm1274745a12.16.2026.06.30.03.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:44:02 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 3/5] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
Date: Tue, 30 Jun 2026 18:43:48 +0800
Message-ID: <20260630104350.748267-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630104350.748267-1-frank.chang@sifive.com>
References: <20260630104350.748267-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
 target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 23262b1d036..a22e2cae6ce 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
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
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e321ca26161..e28d8a3d9fd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
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


