Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FD4C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQex-0004pm-SL; Wed, 25 Sep 2024 07:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQev-0004ij-AP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQes-0000fe-Az
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso66035915e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265492; x=1727870292;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtGkopdKmACra+ZusDozjoRQCojrFRSlC41p5jp/2j4=;
 b=iF86XNpAHWSvxDHydU2ZqQYobtDGnUwqD7tZvHF+fIu16m/X4ddRojbHwzx/WB3+CX
 4VqzkVcUCyEYmps375h4pTSb9eQjyWKVWM1BvAscGYMfXm0chj2ltyM+lilnIhUm1LI+
 SQ8YBs2BVGRSPgKdn5ptI0UX15hYcNGFmEKdfEhSy/4R4Q02qi34mlMVL4RVZsPIA0G5
 3hEHtJPSHUNThrDovLLbgpXuomAwgWnX7uL8CUDzCveKRB8sFSe0oqRN7SbzDFcy3HL6
 7wN51jcoPQJqlgN/98IyeKV1zsyYzALdBe5g45GZGIOtT0OjHpGtIFSPpD+EDarVfu8E
 TUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265492; x=1727870292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtGkopdKmACra+ZusDozjoRQCojrFRSlC41p5jp/2j4=;
 b=EjMRYB5XShTQp14g0k2idLkbrJL9F48KEhby0vwDKvizwS5efnmMxZJk/xNZAlBABX
 ktnTQtMNvwGXO51TrWN4kSd666NYcEUnTiEexB9tKuJJ4LXRizsrI5YjHQEbpba4STOC
 rjwIb09e4D7jRjxP1WcEACK4Dx+6h8fm85SSiUH4lISvg8P7CLuCRK6PoD9z+EsrKD7P
 SJFsEIGOHH3HFhMNpeuwNvAxB56BUre9j9v3YLIi6F+tF9Jl2+ZZZ+fi1zqjriET9M0X
 9SCIi+UlDrcBJEiGMAuCV48Uvp6IRBdMLaV2zPIA4q+NHiOkkoPm7uLk2qwfPPe2FEWT
 4YQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVltW6O/Rl5OZFc4ji7m/wfdslmR3TPsTQWFmX+dakwAAgDQCPyvIeL+Ophxc9ZZ3bPhiArUUJaVhi@nongnu.org
X-Gm-Message-State: AOJu0YwTflFtGvCDBlHSu9quXQmx4qQUWBVTp2JysDbuHWO+gQXsDP4r
 nOJPtzRY5sQFrufA50izIrC9mmmnGWQsJv/h+TxQw97rp5uvVBe04gN15i0i7yw=
X-Google-Smtp-Source: AGHT+IFhL092edHCW4xuMf9mHyMI94P6tb9NFCNzQQ35FnaHhhH5xd2GPI5LR2MU74x0fjr/B9JcVA==
X-Received: by 2002:a05:600c:1994:b0:42c:b377:3f76 with SMTP id
 5b1f17b1804b1-42e9611922dmr18621905e9.17.1727265492373; 
 Wed, 25 Sep 2024 04:58:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] target/riscv: Add Ssdbltrp CSRs handling
Date: Wed, 25 Sep 2024 13:57:59 +0200
Message-ID: <20240925115808.77874-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925115808.77874-1-cleger@rivosinc.com>
References: <20240925115808.77874-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
{H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
presence of the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 16 ++++++++++++++
 target/riscv/csr.c        | 45 ++++++++++++++++++++++++++++++---------
 5 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a84e719d3f..ee984bf270 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index da1723496c..3a5588d4df 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -558,6 +558,7 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -588,6 +589,7 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SDT         0x01000000
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -777,11 +779,13 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_DTE                        (1ULL << 59)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
 
 /* For RV32 */
+#define MENVCFGH_DTE                       BIT(27)
 #define MENVCFGH_ADUE                      BIT(29)
 #define MENVCFGH_PBMTE                     BIT(30)
 #define MENVCFGH_STCE                      BIT(31)
@@ -795,11 +799,13 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_DTE                        MENVCFG_DTE
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
 
 /* For RV32 */
+#define HENVCFGH_DTE                        MENVCFGH_DTE
 #define HENVCFGH_ADUE                       MENVCFGH_ADUE
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ae2a945b5f..dd804f95d4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -77,6 +77,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9d0400035f..395d8235ce 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -63,6 +63,22 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        return false;
+    }
+    if (virt) {
+        return (env->henvcfg & HENVCFG_DTE) != 0;
+    } else {
+        return (env->menvcfg & MENVCFG_DTE) != 0;
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e5de72453c..d8280ec956 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
     return hmode32(env, csrno);
 }
 
+static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
@@ -1402,7 +1411,7 @@ static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
       (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
-    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS | SSTATUS_SDT;
 
 /*
  * Spec allows for bits 13:63 to be either read-only or writable.
@@ -1600,6 +1609,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         mask |= MSTATUS_VS;
     }
 
+    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
+        mask |= MSTATUS_SDT;
+        if ((val & MSTATUS_SDT) != 0) {
+            mstatus &= ~MSTATUS_SIE;
+            val &= ~MSTATUS_SIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -2354,7 +2371,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2374,7 +2392,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -2425,9 +2444,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
      * henvcfg.adue is read_only 0 when menvcfg.adue = 0
+     * henvcfg.dte is read_only 0 when menvcfg.dte = 0
      */
-    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                           env->menvcfg);
+    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                             HENVCFG_DTE) | env->menvcfg);
     return RISCV_EXCP_NONE;
 }
 
@@ -2435,6 +2455,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    uint64_t menvcfg_mask;
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -2443,7 +2464,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+            menvcfg_mask |= HENVCFG_DTE;
+        }
+        mask |= env->menvcfg & menvcfg_mask;
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2461,8 +2486,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -2470,7 +2495,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+                                    HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -5246,7 +5271,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.45.2


