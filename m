Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE4C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLg-0004mL-Qd; Fri, 17 Jan 2025 00:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLf-0004mA-S8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLd-0005yL-Qh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:51 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166f1e589cso42349565ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093408; x=1737698208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuyQiDoru+qCPjpY3UyeHVk5PYipS+bemP8SrwBH21M=;
 b=Ni14LseM0ud5/cNNsujBPcTPQ1008v8+NdMfuTwHBA5Yc6zjECZ3Z4iCPlY/4ZLca1
 yEuoJYbDbENtMGY4lY8hHmj5roKRilAycpbPkWy5dDQ169Jw3S6BBDssm3snjV7tilUm
 2sP5Jy+BbDFa9yECxSQknq7YytW2+6S9tGKKzKT9idpGsbprR915ahBEYPYhPEVDBWdz
 iNJffxyrboGLDi8JvXdnfpuMV0KPh2IQb8bVVcezMQVX3ImXuot4b82Hw8RM+gWlLSIF
 /KD5n6hvaoAhBlLV4Sf/lkXWEAkPskFEOexLrMZExAsOBmRxeGdQeJ4U5sVRTyHTvSw+
 3/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093408; x=1737698208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuyQiDoru+qCPjpY3UyeHVk5PYipS+bemP8SrwBH21M=;
 b=T0fkMgGoKArFcSu7CdMI0GqHv2Q6p9xIGy/2UBkiqeCPCmgFZVJvuKUesgQ6saIO/f
 vUBahuLcfmo5zy1qj78t3lZRKwMsD5SSQ3Vk8C5wcAt7GXYYdfckGM6u7wpFUBHMf13j
 wS3B8NvXjzlwGg7G1hzeoK3DxNnQhfyUtCdD2VjncYGG1eWLrwJ2h8/vggRCAhhGdYOn
 hSioPxRBhVhIvdzWONLt8btqyzk6FsFOYxWBpuGbbjaau4Kf3dFiDgxkk25xl77qTao1
 kgjoYNYPEWciw3g+RS9TnNRanLTjK5zQ6NqDV52/HgnCjct1qt5JdzTMTQ8joiVdhRPY
 D/vg==
X-Gm-Message-State: AOJu0YxxSeuxQZd9M8IRqWmVjzwiXWte4vF9Zc6ZyduLxvCTyf3jhDYk
 Ififvd/t5QUGLJP64IMjtY7LywasEGh2KIjJ1qAYQxtgUlt7+cPmArATaA==
X-Gm-Gg: ASbGncuzue3nCBz1wJ+VDcSvedxKILMEmmKsQbXy2uspFPG/Hfb2KZ/t8ruvYWfghNX
 BF5ZPCY3RBEbjCblsDLRLAiFBATneFD/Iyxe0xXOOteS925V3TJFYMoRtfDDsQPrSXX4Z7fxK0B
 5NKy3C1ucHvXuATR2aG5niWA4kqOQPIVyf6ngDBIfLi187I7+glJdHhFKKrK49zuIA/4p3JXnph
 DcH2PcZrh+R+OMoWZ8mbYavkYdkVob/Lsq3jxwpxytxW6qqH8bLaEue/vbpHjyn/iJN+3lb4KaY
 K26HZjrOC9HAup4AG6n/R8uK7XwOmxLnQkaIMELQpwzttHlu3DLJo5CMWudU
X-Google-Smtp-Source: AGHT+IHRrd7tAAEzwohNr3QzMA24mBiNc0aXpVEA3k65PvqAiU+X+vjaTN7nhLPDY9JHbWXqp/PhZQ==
X-Received: by 2002:a17:902:d2c5:b0:21a:8d70:3865 with SMTP id
 d9443c01a7336-21c355b658emr24579895ad.14.1737093408279; 
 Thu, 16 Jan 2025 21:56:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/50] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v1.0
Date: Fri, 17 Jan 2025 15:55:16 +1000
Message-ID: <20250117055552.108376-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106102346.1100149-3-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      |  8 ++++++++
 target/riscv/cpu_bits.h |  4 ++++
 target/riscv/cpu_cfg.h  |  3 +++
 target/riscv/pmp.h      |  1 +
 target/riscv/csr.c      | 33 +++++++++++++++++++++++++++++++--
 target/riscv/pmp.c      | 14 +++++++++++---
 6 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c78e97af50..ad33e96ddf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -128,6 +128,14 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+/* Enum holds PMM field values for Zjpm v1.0 extension */
+typedef enum {
+    PMM_FIELD_DISABLED = 0,
+    PMM_FIELD_RESERVED = 1,
+    PMM_FIELD_PMLEN7   = 2,
+    PMM_FIELD_PMLEN16  = 3,
+} RISCVPmPmm;
+
 typedef struct riscv_cpu_implied_exts_rule {
 #ifndef CONFIG_USER_ONLY
     /*
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c5b3de6469..797dd6985b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -575,6 +575,7 @@ typedef enum {
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HUKTE        0x01000000
 #define HSTATUS_VSXL         0x300000000
+#define HSTATUS_HUPMM        0x3000000000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
@@ -735,6 +736,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -751,6 +753,7 @@ typedef enum RISCVException {
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 #define SENVCFG_UKTE                       BIT(8)
+#define SENVCFG_PMM                        MENVCFG_PMM
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
@@ -758,6 +761,7 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_PMM                        MENVCFG_PMM
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fe0c4173d2..a36d3fada3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -129,6 +129,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index e0530a17a3..271cf24169 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -46,6 +46,7 @@ typedef enum {
     MSECCFG_USEED = 1 << 8,
     MSECCFG_SSEED = 1 << 9,
     MSECCFG_MLPE =  1 << 10,
+    MSECCFG_PMM = 3ULL << 32,
 } mseccfg_field_t;
 
 typedef struct {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 48abcab487..6b8cef52fe 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -575,6 +575,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2379,6 +2382,12 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfiss) {
             mask |= MENVCFG_SSE;
         }
+
+        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+        if (env_archcpu(env)->cfg.ext_smnpm &&
+            get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
+            mask |= MENVCFG_PMM;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2425,6 +2434,12 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
     RISCVException ret;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (env_archcpu(env)->cfg.ext_ssnpm &&
+        riscv_cpu_mxl(env) == MXL_RV64 &&
+        get_field(val, SENVCFG_PMM) != PMM_FIELD_RESERVED) {
+        mask |= SENVCFG_PMM;
+    }
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
@@ -2493,6 +2508,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
             get_field(env->menvcfg, MENVCFG_SSE)) {
             mask |= HENVCFG_SSE;
         }
+
+        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+        if (env_archcpu(env)->cfg.ext_ssnpm &&
+            get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
+            mask |= HENVCFG_PMM;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -3529,10 +3550,18 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    uint64_t mask = (target_ulong)-1;
     if (!env_archcpu(env)->cfg.ext_svukte) {
-        val = val & (~HSTATUS_HUKTE);
+        mask &= ~HSTATUS_HUKTE;
     }
-    env->hstatus = val;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (!env_archcpu(env)->cfg.ext_ssnpm ||
+        riscv_cpu_mxl(env) != MXL_RV64 ||
+        get_field(val, HSTATUS_HUPMM) == PMM_FIELD_RESERVED) {
+        mask &= ~HSTATUS_HUPMM;
+    }
+    env->hstatus = (env->hstatus & ~mask) | (val & mask);
+
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
                       "QEMU does not support mixed HSXLEN options.");
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a1b36664fc..a185c246d6 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -575,6 +575,13 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
+    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (riscv_cpu_cfg(env)->ext_smmpm &&
+        riscv_cpu_mxl(env) == MXL_RV64 &&
+        get_field(val, MSECCFG_PMM) != PMM_FIELD_RESERVED) {
+        mask |= MSECCFG_PMM;
+    }
 
     trace_mseccfg_csr_write(env->mhartid, val);
 
@@ -590,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
-        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
-        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
+        val |= (env->mseccfg & mask);
+        if ((val ^ env->mseccfg) & mask) {
             tlb_flush(env_cpu(env));
         }
     } else {
-        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
+        mask |= MSECCFG_RLB;
+        val &= ~(mask);
     }
 
     /* M-mode forward cfi to be enabled if cfi extension is implemented */
-- 
2.47.1


