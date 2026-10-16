Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C64CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWLf-0000HA-0T; Thu, 15 Oct 2026 21:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLX-0000G6-F2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLV-0004Cp-Bt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso43549585ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112572; x=1792717372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YFPhT6aOCuG9UYnv1AULvKlN1lwEIlGrbq+GhNIGTo=;
 b=CfkUeXeBsS1/DmXqjInR/yu+7oAXSUJZ/EKm4xkuEdwAGUppspwHp34B5bMrXqjsMN
 DEtGN57ppJlLBNDDJkJkqLMfLXtBR2CUANRsWbjvBCRIoDV5DmIYBO/V7YQ/eTMTbcJk
 B4sgFi6u10CGG1Ca+ww9Ma5JGDb6XEKL0DMHdCQp+DxpEWYlopLNxUr0BsjzqVV+MN07
 A2cbaNrVAv/7KUqwmWqXirCknznWLzEdOTwlAhwsoak9mKoNXebfL4XBPVhodlfA87v/
 0gaODCsbpXC/xJuD2xlWbwkVetj0L8NHbwANkExO9TW0MWAHmAz9VTxlbFAmSb5SyqJ3
 TOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112572; x=1792717372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YFPhT6aOCuG9UYnv1AULvKlN1lwEIlGrbq+GhNIGTo=;
 b=t67d5+fWnWnRPNd1YiHjWrhXuFXmnRrtV8a3aq87C1dY0U5TFdKaBLrCZnXNJ8D9NF
 S5q9FhyzPkg/1Gy8Qdz6cu1G2FqHZ93iMcQ2mA5jBCaPWW4zbRWPCt58bvoh9I64GLTD
 E4SfZpOHblklR0mLFWl7ce3FlA9FOc3+soUJUFl7GkKZaL7FdfQ9rDrnwH50eLEg4qhN
 hyZIWaZ3+3/jkFjPpLVVi3uW8fkLwkf1jOzraFRcN0itZEg1Lb8PDBSqkiVCbzHU7wkO
 hH8YeijJ0+/04/aNDgfIhfkUsphOwwwIgZ0X+KKFhg+Xqwd7nV9EWyPlYsv7G7KEAFBF
 oDrA==
X-Gm-Message-State: AFq9FYJepfSHMKG4sNePWqg2WVRrTxvlVExYqGPdp24dvu08IbI6lB6o
 nIixfF2OhR2W6vczGWQk4XOyLtr7N2Ak66nNNbJ2COQViyufZA7GphQ0mhgr5w==
X-Gm-Gg: AYBFou0S43TVba5oMT6zwxrFiiLG6L8ll9Um5TdYdPX+/CHgrRBHk2kchEuNkqwz63h
 OjMv8Cilg7N93kYWbM/hmYplkWoRXuywbQjSD2gd429XSiHeDLOMQI07uWDPaDNuqi269E0Cowa
 ycbeRs6V98a8Jo1dAlSU36D4K92//IBzliuNRL0G/4pkYxEQSb76D0vMB0xnvJxDZblnZEPEU94
 oSdSMfO2eUITUmm+Is6vC7CjQq+qP3bxE4+U/i1tpQ9g6Pfyu5sPLt/7cVfSkB6zJ6nigPZBNv7
 uHxvh6YByxUFa3Zbx+bOEiSmlcVG/NITjVjyGalhC6OxLdwIGbTgSpvyemKmic1F9f3VevPqAV9
 WXcxBPjvKdLvaTdA+GiXsS0TuVu7ygUQTS0cjwaPehQFmYFOrwR0A5qNhB1tT0JUSrC+pS8zDrz
 NTbJpzYSTckRcWChSgu28QTMLh9sb9ueac+a1jktq7YhbP2Tz3xn/16QUZeeu06g16SPFd9eMWQ
 AJK211Mp1cFMJDWcg==
X-Received: by 2002:a17:903:15c7:b0:2e6:1a6c:abd4 with SMTP id
 d9443c01a7336-2e84280e026mr192298985ad.2.1792112571567; 
 Thu, 15 Oct 2026 18:02:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:02:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Gong Shuai <gsh517025@gmail.com>,
 TianCheng TANG <lyndra@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/50] target/riscv: Restore LCOFI handling in interrupt CSRs
Date: Fri, 16 Oct 2026 11:01:49 +1000
Message-ID: <20261016010237.1102834-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

Commit 27f9566dcd98 dropped bits 13-15 from the LOCAL_INTERRUPTS
macro and hence also from individual masks such as all_ints,
sip_writable_mask etc.

As a result, even with sscofpmf and ssaia enabled, the LCOFI never got
delivered to the host OS and guest OS respectively.

Add back bit 13 in all the affected masks, but gate it on Sscofpmf being
implemented. For the virtual interrupt paths, i.e., mvip/mvien,
hvip/hvien/vsip/vsie registers, bit 13 is additionally gated on Smaia
and Ssaia respectively. Bits 14, 15 can be added when those interrupt
sources get defined.

Cc: qemu-stable@nongnu.org
Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Suggested-by: Gong Shuai <gsh517025@gmail.com>
Suggested-by: TianCheng TANG <lyndra@linux.alibaba.com>
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Message-ID: <20260921145334.419651-1-mayuresh.chitale@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 88 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77..a3351428cb 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1815,7 +1815,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
-    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
+    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS;
 static const uint64_t vs_delegable_ints =
     (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
@@ -1877,6 +1877,42 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
 static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
+/*
+ * Selects the extensions that need to be checked when accessing various
+ * interrupt registers.
+ */
+typedef enum {
+    /* Accessing mideleg, mie, mip, and alias paths  */
+    AIA_NONE,
+    /* Accessing mvien, mvip non-alias path */
+    AIA_SMAIA,
+    /* Accessing hvien, hvip, vsie, vsip paths */
+    AIA_SSAIA,
+} AIAExt;
+
+/*
+ * This function can be extended later to configure mask for standard local
+ * interrupt bits 14 and 15, once those get defined in the Priv Spec.
+ */
+static uint64_t std_impl_intr_mask(CPURISCVState *env, AIAExt ext)
+{
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+
+    if (ext == AIA_SMAIA && !cfg->ext_smaia) {
+        return 0;
+    }
+
+    if (ext == AIA_SSAIA && !cfg->ext_ssaia) {
+        return 0;
+    }
+
+    if (!cfg->ext_sscofpmf) {
+        return 0;
+    }
+
+    return MIP_LCOFIP;
+}
+
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
                                 target_ulong *val)
@@ -2249,8 +2285,10 @@ static RISCVException rmw_mideleg64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & delegable_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mideleg;
     }
@@ -2300,8 +2338,10 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t mask = wr_mask & all_ints;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mie;
     }
@@ -2350,8 +2390,10 @@ static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SMAIA);
     uint64_t mask = wr_mask & mvien_writable_mask;
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->mvien;
     }
@@ -3784,9 +3826,12 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    mask |= wr_mask & std_mask;
+
     /*
      * When mvien[9]=1, mip.SEIP is read-only and reflects only
      * the external interrupt signal from the interrupt controller.
@@ -3900,9 +3945,12 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
      *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
      *  that come from hvip.
      */
-    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    AIAExt intr_virt = ((csrno == CSR_MVIP) || (csrno == CSR_MVIPH)) ?
+                          AIA_SMAIA : AIA_NONE;
+    uint64_t std_mask = std_impl_intr_mask(env, intr_virt);
+    uint64_t alias_mask = ((S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (env->mideleg | ~env->mvien)) | MIP_STIP;
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
     uint64_t wr_mask_mvip;
     uint64_t wr_mask_mip;
@@ -3931,8 +3979,8 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
         alias_mask &= ~MIP_STIP;
     }
 
-    wr_mask_mip = wr_mask & alias_mask & mvip_writable_mask;
-    wr_mask_mvip = wr_mask & nalias_mask & mvip_writable_mask;
+    wr_mask_mip = wr_mask & alias_mask & (mvip_writable_mask | std_mask);
+    wr_mask_mvip = wr_mask & nalias_mask & (mvip_writable_mask | std_mask);
 
     /*
      * For bits set in alias_mask, mvip needs to be alias of mip, so forward
@@ -4065,9 +4113,11 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t alias_mask = (LOCAL_INTERRUPTS | VS_MODE_INTERRUPTS) &
-                            env->hideleg;
-    uint64_t nalias_mask = LOCAL_INTERRUPTS & (~env->hideleg & env->hvien);
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
+    uint64_t alias_mask = (LOCAL_INTERRUPTS | VS_MODE_INTERRUPTS |
+                           std_mask) & env->hideleg;
+    uint64_t nalias_mask = (LOCAL_INTERRUPTS | std_mask) &
+                           (~env->hideleg & env->hvien);
     uint64_t rval, rval_vs, vsbits;
     uint64_t wr_mask_vsie;
     uint64_t wr_mask_mie;
@@ -4135,9 +4185,11 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
-    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
+    uint64_t alias_mask = (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS) &
+        env->mideleg;
     uint64_t sie_mask = wr_mask & nalias_mask;
     RISCVException ret;
 
@@ -4320,6 +4372,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
                                  uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t rval, mask = env->hideleg & VS_MODE_INTERRUPTS;
     uint64_t vsbits;
 
@@ -4335,7 +4388,7 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
     wr_mask |= vsbits << 1;
 
     ret = rmw_hvip64(env, csrno, &rval, new_val,
-                     wr_mask & mask & vsip_writable_mask);
+                     wr_mask & mask & (vsip_writable_mask | std_mask));
     if (ret_val) {
         rval &= mask;
         vsbits = rval & VS_MODE_INTERRUPTS;
@@ -4382,7 +4435,9 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
                                 uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
-    uint64_t mask = (env->mideleg | env->mvien) & sip_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_NONE);
+    uint64_t mask = (env->mideleg | env->mvien) &
+                    (sip_writable_mask | std_mask);
 
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -4395,7 +4450,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
 
     if (ret_val) {
         *ret_val &= (env->mideleg | env->mvien) &
-            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
+            (S_MODE_INTERRUPTS | std_mask | LOCAL_INTERRUPTS);
     }
 
     return ret;
@@ -4737,7 +4792,9 @@ static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t mask = wr_mask & hvien_writable_mask;
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
 
+    mask |= wr_mask & std_mask;
     if (ret_val) {
         *ret_val = env->hvien;
     }
@@ -4861,6 +4918,7 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
      */
     uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;
     uint64_t nalias_mask = (~env->hideleg & env->hvien);
+    uint64_t std_mask = std_impl_intr_mask(env, AIA_SSAIA);
     uint64_t wr_mask_hvip;
     uint64_t wr_mask_mip;
 
@@ -4882,8 +4940,8 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
         alias_mask &= (env->hideleg | env->hvien);
     }
 
-    wr_mask_hvip = wr_mask & nalias_mask & hvip_writable_mask;
-    wr_mask_mip = wr_mask & alias_mask & hvip_writable_mask;
+    wr_mask_hvip = wr_mask & nalias_mask & (hvip_writable_mask | std_mask);
+    wr_mask_mip = wr_mask & alias_mask & (hvip_writable_mask | std_mask);
 
     /* Aliased bits, bits 10, 6, 2 need to come from mip. */
     ret = rmw_mip64(env, csrno, &ret_mip, new_val, wr_mask_mip);
-- 
2.55.0


