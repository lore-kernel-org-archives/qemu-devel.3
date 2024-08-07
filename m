Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC69DC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDM-00042R-6x; Tue, 06 Aug 2024 20:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCm-0002Xi-U8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCj-00017d-Vo
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so946336b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989220; x=1723594020;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXmmy9sQ6FdCwxmbQ1lXp5QB1YPROEJt1Bgbzc7d8Dg=;
 b=zPcjJ3XMQRS6CaW+WU7ji5XbkdClpChBXkxXYhOIxh0PjYp2a3uhCqtalah4uwiA9O
 sLT37RJqJ0lenwqPscNS1ua5OJzZ3VEuG1FFT141bpwNSD0ElI2H/FOyY2V3cn4dTKuo
 thJEHm9fwVm7Ts+4Nj5R1f2LtMQb0BU8Y5EY0+PJXRkiw086SCrEg/bq63MN7S4H2D2M
 qQzKtIbunkbZMZGHU9RIQogbH3ypCBEujVdcozzvErZlYXg549jn644nkbAv0mwtbu8c
 BFoJK+cPczWBO7ussOwRPyC24ZYfCbnFY4em2hJ6Qp1m+LDYhgSK4fSd+R17K2gNblCz
 3mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989220; x=1723594020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXmmy9sQ6FdCwxmbQ1lXp5QB1YPROEJt1Bgbzc7d8Dg=;
 b=xVJE5yWw9oO0nZbZ/wFXGOYywV0nnfwVMPS+y5+voZyFFIDipIn1xzHRJQWPnN7W93
 2zCQ55fbmj9VZgI4cjd7DWZac4LVEFCH4cEqmvx1xvuuM467hJynCvuRVcpfOBN4BCwJ
 otj8fNEtxN5xpt5rZIhD0LWZEWn3lHkVwcfVeHEevPoZoMh8dwfgTunr/jyBCpRGhX5K
 01StBm/Aa2bp4SfbpbbO0lLgTKcCLPIB0tj4l9j+j87emeEssMbIquNIivjd3ILzvif3
 u737q9iN9fPV8ck3o1LFpTIfMIpEZq3v9flmUMBalFmfrTT3se8ZXvJ/UXgl247+1XWB
 yKHA==
X-Gm-Message-State: AOJu0Yz20a+tgxJ1lAGe+TvZCh/aXLphHTI21sHedq2dMvNcjNtjxTTQ
 5xwMZxjUnD7jqv12dJiBACxQiGDCIi0YqWEykidrN9oAt7rPrwIt3KdQtfm4A1/lCvUJBB4rzbs
 f
X-Google-Smtp-Source: AGHT+IFaq+yBNmaqVl0EqWI71cpUKaSbRzE4rn2E7uHRPOwGF/mSLBtgbkkxKIL3pF51ju3TZP761Q==
X-Received: by 2002:a05:6a20:3950:b0:1c4:9886:b511 with SMTP id
 adf61e73a8af0-1c69954a2fdmr19486907637.2.1722989220116; 
 Tue, 06 Aug 2024 17:07:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:06:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 03/20] target/riscv: Introduce elp state and enabling
 controls for zicfilp
Date: Tue,  6 Aug 2024 17:06:34 -0700
Message-ID: <20240807000652.1417776-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

zicfilp introduces a new state elp ("expected landing pad") in cpu.
During normal execution, elp is idle (NO_LP_EXPECTED) i.e not expecting
landing pad. On an indirect call, elp moves LP_EXPECTED. When elp is
LP_EXPECTED, only a subsquent landing pad instruction can set state back
to NO_LP_EXPECTED. On reset, elp is set to NO_LP_EXPECTED.

zicfilp is enabled via bit2 in *envcfg CSRs. Enabling control for M-mode
is in mseccfg CSR at bit position 10.

On trap, elp state is saved away in *status.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h | 12 ++++++++++++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 target/riscv/pmp.c      |  5 +++++
 target/riscv/pmp.h      |  3 ++-
 6 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5dfb3f39ab..82fa85a8d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -994,6 +994,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
+    /* on reset elp is set to NO_LP_EXPECTED */
+    env->elp = NO_LP_EXPECTED;
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..ae436a3179 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -222,6 +222,8 @@ struct CPUArchState {
 
     target_ulong jvt;
 
+    /* elp state for zicfilp extension */
+    cfi_elp      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c257c5ed7d..127f2179dc 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -545,6 +545,8 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SPELP       0x00800000 /* zicfilp */
+#define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -575,12 +577,19 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
 #define SSTATUS32_SD        0x80000000
 #define SSTATUS64_SD        0x8000000000000000ULL
 
+/* enum for branch tracking state in cpu/hart */
+typedef enum {
+    NO_LP_EXPECTED = 0,
+    LP_EXPECTED = 1,
+} cfi_elp;
+
 /* hstatus CSR bits */
 #define HSTATUS_VSBE         0x00000020
 #define HSTATUS_GVA          0x00000040
@@ -747,6 +756,7 @@ typedef enum RISCVException {
 
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
+#define MENVCFG_LPE                        BIT(2) /* zicfilp */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -760,11 +770,13 @@ typedef enum RISCVException {
 #define MENVCFGH_STCE                      BIT(31)
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
+#define SENVCFG_LPE                        MENVCFG_LPE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
+#define HENVCFG_LPE                        MENVCFG_LPE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 432c59dc66..5771a14848 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1400,6 +1400,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    /* If cfi lp extension is available, then apply cfi lp mask */
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= (MSTATUS_MPELP | MSTATUS_SPELP);
+    }
+
     mstatus = (mstatus & ~mask) | (val & mask);
 
     env->mstatus = mstatus;
@@ -2101,6 +2106,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= MENVCFG_LPE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2153,6 +2162,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SENVCFG_LPE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2190,6 +2203,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= HENVCFG_LPE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2654,6 +2671,10 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
         mask |= SSTATUS64_UXL;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
 }
@@ -2665,6 +2686,11 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     /* TODO: Use SXL not MXL. */
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
@@ -2680,6 +2706,11 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
             mask |= SSTATUS64_UXL;
         }
     }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9eea397e72..1111d08d08 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -598,6 +598,11 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
         val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
     }
 
+    /* M-mode forward cfi to be enabled if cfi extension is implemented */
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        val |= (val & MSECCFG_MLPE);
+    }
+
     env->mseccfg = val;
 }
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index f5c10ce85c..e0530a17a3 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -44,7 +44,8 @@ typedef enum {
     MSECCFG_MMWP  = 1 << 1,
     MSECCFG_RLB   = 1 << 2,
     MSECCFG_USEED = 1 << 8,
-    MSECCFG_SSEED = 1 << 9
+    MSECCFG_SSEED = 1 << 9,
+    MSECCFG_MLPE =  1 << 10,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.44.0


