Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C46CCD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhK-0000BQ-9o; Tue, 16 Jun 2026 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhI-0008P5-K4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:08 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhG-0003MZ-4J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c85a2c012e5so1466637a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604425; x=1782209225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcMnKyII8r/lV77qN3Eve6DZ7u06AOKMdhC9UZhkf9M=;
 b=QvnT7iFG+h/NocYYSwu+QrjZFK8p8Z0LCV7GLp7bv2G+l99I8E/51dtuYpJlnPYsiC
 mke+Sje7okzjaVaT25FgDyQ0cBZuXj1UlutJXoYtkr4HzwyVOGWHfFDyhS3Nz7jHMhi5
 qG5TBHVKg11N6EhiDzudkcn0O41toM70I/G3+J2msPVyuufz3MYrrhhDqlB+p1JDJUFV
 9zlEADr9tlCP1k2gd3R4VVOkjF8tEfCzYsoml2HgyfHu3p/fk6DhjqD64OMs4hLHL4AD
 1B+FRtRptvip7S5W6G4xPKDh2DdNDkImQFX6U73piah7MHvu+1Cay1M7Gjn9BiqowPUi
 bF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604425; x=1782209225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcMnKyII8r/lV77qN3Eve6DZ7u06AOKMdhC9UZhkf9M=;
 b=n1l1i0sNUk6+ThRiEvzmrEwGV0xsB2u7O83R1t3VA0oHDepfLAk2Bqxt+ay3+CEI2/
 z+mUSY3AwKDUzwBvUqKBgjSNt5BPI9BOCzWSrOG8U/1pbU7+QLA9RaDidBc0qpSUDpN2
 b/5WJpPE20rMhlVc/xy/JP7otwrnwFUAKOeWjO9xj3cHc48AZ8FCrQVV9+e4hAhjKoYf
 g9Rkzf0LEtHnd4ekE+8NvvvGM/epWRqwrF+VNsLk9yvvlqxHXG4ZqlKGLM1f25F0RFfw
 9AKe3MpTtnRoW8W89uGJE3U9zRfZVKfDEe0H6HKkfoSQlUeQMVuKEaXBmdweRWVcrkU1
 pBxA==
X-Gm-Message-State: AOJu0YynUiEcCA4kWm58MRrW9PkiKLZC1zBgBvXBLz01wJCFdcQnmVNs
 cpPLsCuZ3vrvFQTjPhB/X2v8kecHNuRG98J3CQ/uXozNpCYXKWbU2qiZxFP7APLQ
X-Gm-Gg: Acq92OFv+F9PSPp3BV5UDKzynj8RnZEMpadHCErNsSil7ohCgspUxaZCMO9ueVgELX4
 gGAYQzaNLbHv3AtZgGp9DfqW7SutpMyQwNs0spYOI1qlS0WXDtACHqIOqfnlKH+2HQMAMmmY0TZ
 pQ/jWDrj883RE9I9+Tgo2dRTxmHpclC5LzwfBqRLj2a3yWQaGNHMi+GKJL6qeVs/ooJEDhleaBA
 6urJ3+iHIqNK07BJCK6qS+x58/ckyWq5//8ar8Kac5pcyX9bsBEXH1pUSqCUd/lQRQufu0Ml3Mm
 dTDBvsQfucGrb/aEsgeGSziEud8s+9O+gsmbEjfiEqc3aR8dqxzGve1JsdruNFdWJw8OuQis69D
 +PyjNtJz06T/tBlGVag4WjibPbFncQteGltGugJoXDk8V3iZCyh+vHjrHDv3F0P8wkdImqNxpCR
 MaE0VQKYWcH3rgMuYkWw0hf5t4NmsKBCsbPacCLVxA
X-Received: by 2002:a05:6a21:1405:b0:39c:787:f197 with SMTP id
 adf61e73a8af0-3b7e49d08b1mr3068188637.36.1781604424805; 
 Tue, 16 Jun 2026 03:07:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/83] target/riscv: Fix arguments to board IMSIC emulation
 callbacks
Date: Tue, 16 Jun 2026 20:04:29 +1000
Message-ID: <20260616100527.1939565-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

In hw/ the relevant RISCVIMSICState fields
eidelivery, eithreshold, eistate are uint32_t.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-16-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 42 ++++++++++++++++++++-------------------
 hw/intc/riscv_imsic.c     | 34 +++++++++++++++----------------
 target/riscv/cpu_helper.c | 12 ++++-------
 target/riscv/csr.c        | 24 ++++++++++++----------
 4 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c338df1598..380749f9a8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -201,6 +201,24 @@ FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, ALTFMT, 8, 1)
 FIELD(VTYPE, RESERVED, 9, sizeof(uint64_t) * 8 - 10)
 
+#ifndef CONFIG_USER_ONLY
+/* machine specific AIA ireg read-modify-write callback */
+#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen)                 \
+    ((uint32_t)((((__xlen) & 0xff) << 24) |                                    \
+                (((__vgein) & 0x3f) << 20) |                                   \
+                (((__virt) & 0x1) << 18) |                                     \
+                (((__priv) & 0x3) << 16) |                                     \
+                  (__isel & 0xffff)))
+#define AIA_IREG_ISEL(__ireg) ((__ireg) & 0xffff)
+#define AIA_IREG_PRIV(__ireg) (((__ireg) >> 16) & 0x3)
+#define AIA_IREG_VIRT(__ireg) (((__ireg) >> 18) & 0x1)
+#define AIA_IREG_VGEIN(__ireg) (((__ireg) >> 20) & 0x3f)
+#define AIA_IREG_XLEN(__ireg) (((__ireg) >> 24) & 0xff)
+
+typedef int (*aia_ireg_rmw_fn)(void *arg, uint32_t reg, uint64_t *val,
+                               uint64_t new_val, uint64_t write_mask);
+#endif
+
 typedef struct PMUCTRState {
     /* Current value of a counter */
     uint64_t mhpmcounter_val;
@@ -466,20 +484,8 @@ struct CPUArchState {
     void *rdtime_fn_arg;
 
     /* machine specific AIA ireg read-modify-write callback */
-#define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
-    ((((__xlen) & 0xff) << 24) | \
-     (((__vgein) & 0x3f) << 20) | \
-     (((__virt) & 0x1) << 18) | \
-     (((__priv) & 0x3) << 16) | \
-     (__isel & 0xffff))
-#define AIA_IREG_ISEL(__ireg)                  ((__ireg) & 0xffff)
-#define AIA_IREG_PRIV(__ireg)                  (((__ireg) >> 16) & 0x3)
-#define AIA_IREG_VIRT(__ireg)                  (((__ireg) >> 18) & 0x1)
-#define AIA_IREG_VGEIN(__ireg)                 (((__ireg) >> 20) & 0x3f)
-#define AIA_IREG_XLEN(__ireg)                  (((__ireg) >> 24) & 0xff)
-    int (*aia_ireg_rmw_fn[4])(void *arg, target_ulong reg,
-        target_ulong *val, target_ulong new_val, target_ulong write_mask);
-    void *aia_ireg_rmw_fn_arg[4];
+    aia_ireg_rmw_fn aia_ireg_rmw_cb[4];
+    void *aia_ireg_rmw_cb_arg[4];
 
     /* True if in debugger mode.  */
     bool debugger;
@@ -648,12 +654,8 @@ void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, privilege_mode_t priv,
-                                   int (*rmw_fn)(void *arg,
-                                                 target_ulong reg,
-                                                 target_ulong *val,
-                                                 target_ulong new_val,
-                                                 target_ulong write_mask),
+void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
+                                   aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ac59496c22..1c86ecdb2c 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -88,11 +88,11 @@ static void riscv_imsic_update(RISCVIMSICState *imsic, uint32_t page)
 }
 
 static int riscv_imsic_eidelivery_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                      target_ulong *val,
-                                      target_ulong new_val,
-                                      target_ulong wr_mask)
+                                      uint64_t *val,
+                                      uint64_t new_val,
+                                      uint64_t wr_mask)
 {
-    target_ulong old_val = imsic->eidelivery[page];
+    uint32_t old_val = imsic->eidelivery[page];
 
     if (val) {
         *val = old_val;
@@ -106,11 +106,11 @@ static int riscv_imsic_eidelivery_rmw(RISCVIMSICState *imsic, uint32_t page,
 }
 
 static int riscv_imsic_eithreshold_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                      target_ulong *val,
-                                      target_ulong new_val,
-                                      target_ulong wr_mask)
+                                      uint64_t *val,
+                                      uint64_t new_val,
+                                      uint64_t wr_mask)
 {
-    target_ulong old_val = imsic->eithreshold[page];
+    uint32_t old_val = imsic->eithreshold[page];
 
     if (val) {
         *val = old_val;
@@ -124,8 +124,8 @@ static int riscv_imsic_eithreshold_rmw(RISCVIMSICState *imsic, uint32_t page,
 }
 
 static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
-                                 target_ulong *val, target_ulong new_val,
-                                 target_ulong wr_mask)
+                                 uint64_t *val, uint64_t new_val,
+                                 uint64_t wr_mask)
 {
     uint32_t base, topei = riscv_imsic_topei(imsic, page);
 
@@ -149,11 +149,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
 
 static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
                                uint32_t xlen, uint32_t page,
-                               uint32_t num, bool pend, target_ulong *val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint32_t num, bool pend, uint64_t *val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint32_t i, base, prev;
-    target_ulong mask;
+    uint64_t mask;
     uint32_t state = (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_ENABLED;
 
     if (xlen != 32) {
@@ -178,7 +178,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
             continue;
         }
 
-        mask = (target_ulong)1 << i;
+        mask = 1ull << i;
         if (wr_mask & mask) {
             if (new_val & mask) {
                 prev = qatomic_fetch_or(&imsic->eistate[base + i], state);
@@ -197,8 +197,8 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
     return 0;
 }
 
-static int riscv_imsic_rmw(void *arg, target_ulong reg, target_ulong *val,
-                           target_ulong new_val, target_ulong wr_mask)
+static int riscv_imsic_rmw(void *arg, uint32_t reg, uint64_t *val,
+                           uint64_t new_val, uint64_t wr_mask)
 {
     RISCVIMSICState *imsic = arg;
     uint32_t isel, priv, virt, vgein, xlen, page;
@@ -400,7 +400,7 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         }
 
         if (!kvm_irqchip_in_kernel()) {
-            riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
+            riscv_cpu_set_aia_ireg_rmw_cb(env, (imsic->mmode) ? PRV_M : PRV_S,
                                           riscv_imsic_rmw, imsic);
         }
     }
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4529341696..ae0490a086 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -816,17 +816,13 @@ void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
     env->rdtime_fn_arg = arg;
 }
 
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, privilege_mode_t priv,
-                                   int (*rmw_fn)(void *arg,
-                                                 target_ulong reg,
-                                                 target_ulong *val,
-                                                 target_ulong new_val,
-                                                 target_ulong write_mask),
+void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
+                                   aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
 {
     if (priv <= PRV_M) {
-        env->aia_ireg_rmw_fn[priv] = rmw_fn;
-        env->aia_ireg_rmw_fn_arg[priv] = rmw_fn_arg;
+        env->aia_ireg_rmw_cb[priv] = rmw_fn;
+        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
     }
 }
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 29db646589..4dd6c93e51 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2673,6 +2673,7 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
     uint8_t *iprio;
     privilege_mode_t priv;
     uint32_t vgein;
+    uint64_t wide_val;
 
     /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
@@ -2717,16 +2718,17 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
         }
     } else if (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST) {
         /* IMSIC registers only available when machine implements it. */
-        if (env->aia_ireg_rmw_fn[priv]) {
+        if (env->aia_ireg_rmw_cb[priv]) {
             /* Selected guest interrupt file should not be zero */
             if (virt && (!vgein || env->geilen < vgein)) {
                 goto done;
             }
             /* Call machine specific IMSIC register emulation */
-            ret = env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
+            ret = env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
                                     AIA_MAKE_IREG(isel, priv, virt, vgein,
                                                   riscv_cpu_mxl_bits(env)),
-                                    val, new_val, wr_mask);
+                                    &wide_val, new_val, wr_mask);
+            *val = wide_val;
         }
     } else {
         isel_reserved = true;
@@ -2959,6 +2961,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     int ret = -EINVAL;
     privilege_mode_t priv;
     uint32_t vgein;
+    uint64_t wide_val;
 
     /* Translate CSR number for VS-mode */
     csrno = aia_xlate_vs_csrno(env, csrno);
@@ -2984,7 +2987,7 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     };
 
     /* IMSIC CSRs only available when machine implements IMSIC. */
-    if (!env->aia_ireg_rmw_fn[priv]) {
+    if (!env->aia_ireg_rmw_cb[priv]) {
         goto done;
     }
 
@@ -2997,10 +3000,11 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
     }
 
     /* Call machine specific IMSIC register emulation for TOPEI */
-    ret = env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
+    ret = env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
                     AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein,
                                   riscv_cpu_mxl_bits(env)),
-                    val, new_val, wr_mask);
+                    &wide_val, new_val, wr_mask);
+    *val = wide_val;
 
 done:
     if (ret) {
@@ -4504,7 +4508,7 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
     int irq, ret;
-    target_ulong topei;
+    uint64_t topei = 0;
     uint64_t vseip, vsgein;
     uint32_t iid, iprio, hviid, hviprio, gein;
     uint32_t s, scount = 0, siid[VSTOPI_NUM_SRCS], siprio[VSTOPI_NUM_SRCS];
@@ -4519,13 +4523,13 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
         if (gein <= env->geilen && vseip) {
             siid[scount] = IRQ_S_EXT;
             siprio[scount] = IPRIO_MMAXIPRIO + 1;
-            if (env->aia_ireg_rmw_fn[PRV_S]) {
+            if (env->aia_ireg_rmw_cb[PRV_S]) {
                 /*
                  * Call machine specific IMSIC register emulation for
                  * reading TOPEI.
                  */
-                ret = env->aia_ireg_rmw_fn[PRV_S](
-                        env->aia_ireg_rmw_fn_arg[PRV_S],
+                ret = env->aia_ireg_rmw_cb[PRV_S](
+                        env->aia_ireg_rmw_cb_arg[PRV_S],
                         AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, PRV_S, true, gein,
                                       riscv_cpu_mxl_bits(env)),
                         &topei, 0, 0);
-- 
2.54.0


