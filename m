Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1C1C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZ0-0004Nj-LI; Mon, 29 Jul 2024 13:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUYy-0004Gq-Td
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:36 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUYw-0000GG-Q7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:36 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-260e1b5576aso2647083fac.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275613; x=1722880413;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXmmy9sQ6FdCwxmbQ1lXp5QB1YPROEJt1Bgbzc7d8Dg=;
 b=B4a8QH6aSuL1gkJKTX4DlDAdE8yii/vMHZOCUxJ37MPxA5tlVmvC/sz3Aoi10Q7CCt
 LRsmerTz/gOxaid08tV/qq/c0Aj1C+tPcHQBw/tcI1Xru5dqwpus5TPvgLDjoE65KYFF
 UKCmY3ImO42g5gNiG+rBMbfCXoe/dgFZP3uc7Vqd3unoKRA5H6dovnouPbFtEcJ1hpJr
 uof5ZuoZlOThUjVjddVAyLkJytNgbUpsTm/qr0BFR7833uMZNvZJqz8HhupjMQcgxNUF
 DTP3ehJibyptNdA7qpUCk0hyVSVrs3MfOH1bAdF9TBNtRjU4hjgha1yEwzrRmsw0/HWY
 HcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275613; x=1722880413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXmmy9sQ6FdCwxmbQ1lXp5QB1YPROEJt1Bgbzc7d8Dg=;
 b=eh6jGY3U5fh+YtVNOgwLADugbwc921o1idd+y/TeNOKXYUnzHLXGpLFDcD2bDhDMMP
 8i8ciHhVYAhCCkmwLOuwvzc8eg8ra49rYlXdARGkMT7AoxAQxfeGPj/vyFNGvakbd6Dx
 kyGpWWzP6bB4oZouK/6tnPLMM/13hPiGH7UujK+3x4SsocyJJAOGW0uJs0EhetjfYbGf
 BnVLMHrsIsLpP2vIV+YjsqpqulK8ls4UXRV5aIMusFSSULBmb4E8Aa5IyKFmEIlXgufg
 6L3EwH1tqTWCy1/z1GkOYlRIPFh+Xz8lAFuNM1Ucsecn7m8SYeJIOjee7ekBSP5MnyS4
 ZQBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrciinrKh4OKd94VfMMpvWv3rQRQwC/emn27T1Pc1P/qX+aS2YCB7FuhYc80TG7pfKinqY3VPSzqDROOjNmHrih85EtRA=
X-Gm-Message-State: AOJu0Yw9P4Wl++UmyOx51vDtpjVT9UM7w74G4FMB9G7RZzg+LZpcVx0o
 Gyq2G0e+6S4SrHaGFfAaV4yQiGvupKVCkFh5mCLV+q/kUW3SyMc/EQKIVRfPeEA=
X-Google-Smtp-Source: AGHT+IE1Io4/lZ1qRpK0MJ49aXb8/uS8MT88tJtAouDCFAC18T6hZiI27GbUQ4EjgGPUrcvH6JQPFQ==
X-Received: by 2002:a05:6870:b293:b0:261:1ccd:358c with SMTP id
 586e51a60fabf-267d4dcabcamr10449484fac.24.1722275613396; 
 Mon, 29 Jul 2024 10:53:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:33 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 02/24] target/riscv: Introduce elp state and enabling
 controls for zicfilp
Date: Mon, 29 Jul 2024 10:53:04 -0700
Message-ID: <20240729175327.73705-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


