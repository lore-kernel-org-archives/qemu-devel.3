Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0104CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvZn-0000uL-O6; Mon, 04 May 2026 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZk-0000tA-75
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:16 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZi-0006BP-Fy
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:15 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-50fae4d1f85so57898181cf.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909873; x=1778514673; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZxjCJPWJInTrT5BdPOKvwh7m7sTcBF1+wr03EatH2gI=;
 b=ZviQ+9JbVEC4iMM685z1ObBJVvEY7oHe+bi8KyP4vlgNXSNyKNu7zRVo2pC0AIWZnR
 iMfC9j6fJTwAWjGp80xtFcx42acRh/n6heoxZYLWihllTeej4KJS13JStJS8WBBcmM7+
 2ZjcFyKnvbN9o/EQmeWMMDCEIZrNmLmkMeZ+3+nZHkb9WOcFu8fLcayED+MldhkzFyIf
 y8DZHup7OlPvSqyxq3pmwamA/iN7dNgyMMuRsOTnmP+KxHlYKd+srbGugbTZDYuxLguI
 fr68fIm1Ps+J4y3v4gd3AD6IKl+GwiBH6PFOtx6JqpxxcOCthSG9zmHHkyB+W1xmlAv2
 PK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909873; x=1778514673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZxjCJPWJInTrT5BdPOKvwh7m7sTcBF1+wr03EatH2gI=;
 b=Zh1/wWAWtlrzSYRinUxA27BFqFaeWUH2CwMiC5p+NClFETF4tWs+JvRR4HWeaAEjDA
 2JaayBeupaeFjDT50aZrZvy0g+wjh88NmY5BUki+xD5R2OkBF/Msfhd+TZd9GzlLrbGg
 i/+ngnwfsmm+zaNEnlE9tYIA4OhAd6WIF7IKM18Z5QPCbSQd8u04l3FVIoG3yIhc2eXe
 RydOxXc3AcEErDoEXHdy4Y0smiFfkMOpa8r47Fs+aIsbLk45uwK4Tyfkilg3oJLMKyS6
 N6DL0KKdmpWnPIVJtDer/nwl5/mINEHUh3rVEtA7iiAqFtM+2H7Ik00blCW9fapAXQEl
 VolQ==
X-Gm-Message-State: AOJu0Yxqv4eHL9LyUOWxy47vPU+XjFkI+9v5ap1h72jV2yxSgqS8HQTQ
 Cx2NCiEW/fIHR/I8ZgO3+cT6zjzVqN6vvl7MhTb2wQz/7Dtvn4MHp3+ptDEB0fik
X-Gm-Gg: AeBDiesTHDWHg9h4zk34EessHfb9uMmq9IjSEAa+OxOO+/versSg74BPb9ol+5QiYp8
 lwZv0yi1Ox7Y4I6hxFu98AUP2eNa2+nAbbLnGPoFeL/FlWgx4OrTITWRrjZvz17z4+Hw2fEQtxK
 +QyDEPVQs0h5LGB0I9bfspNvoULXxI8rTD/qOceMpFHkPcf3rwPZATNpfH0QI9V8x3Ig5U1DPzf
 MfmFXlRaY1TSXb9dvUfeJMjdGuJUK5USB3ol6fYGSsA9sw/5OLR3eipQ+IE7b0FAZCy878q3E4U
 u1ddO92dKUyOfpu6O9zv79+Axe9LqwFiYa899ivyxY0O5lH9UdYoWxBtiDbjg77Gllr7Xk1bRD2
 OMtPcqLJTMASJhzkwtgw4xTN0Snx4IEoHa6JssDdm+l5cnQP8wa/Y+LJAxQOFCf+Kjf4HcnmhdE
 Vg5aaBcEC82KrPuTAG2v3lTnVOw4//IK5hE/bs+ps8vPKGfulvcUw=
X-Received: by 2002:a05:622a:1b15:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-5104be062fbmr158528921cf.6.1777909873266; 
 Mon, 04 May 2026 08:51:13 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:12 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:36 -0400
Subject: [PATCH v5 03/15] target/arm: mte_check unemitted on STORE_ONLY
 load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-3-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=4552;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=yYLwhnBFaPvQITdtme0stFkgyfXUhCnT3IJ2ErgYUVs=;
 b=2EfF8uuWTh5e2J7Kby47OOAx9fZIdy/3AVZgcT6lIsN+4yiVOIy4lAdWvtV34sxRglSB7vtMO
 9okfSeCETpOAkleM5L8bes6esipF/y55bUadu8AJRqW0+taXA5y0AFs
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This feature disables generation of the mte check helper on loads when
STORE_ONLY tag checking mode is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c |  8 ++++++--
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9010491235..706ade5784 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2527,6 +2527,8 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
+FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..75c55b1a6d 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -423,6 +423,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                      */
                     DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
                 }
+                /*
+                 * Repeat for MTE_STORE_ONLY
+                 */
+                if ((el == 0 ? SCTLR_TCSO0 : SCTLR_TCSO) & sctlr) {
+                    DP_TBFLAG_A64(flags, MTE_STORE_ONLY, 1);
+                    if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                        DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+                    }
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
@@ -432,6 +441,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
             DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+            if (SCTLR_TCSO0 & sctlr) {
+                DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+            }
         }
         /*
          * For unpriv tag-setting accesses we also need ATA0. Again, in
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec..ce6249649a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -302,7 +302,8 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
                                       MemOp memop, bool is_unpriv,
                                       int core_idx)
 {
-    if (tag_checked && s->mte_active[is_unpriv]) {
+    if (tag_checked && s->mte_active[is_unpriv] &&
+        (is_write || !s->mte_store_only[is_unpriv])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -334,7 +335,8 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int total_size, MemOp single_mop)
 {
-    if (tag_checked && s->mte_active[0]) {
+    if (tag_checked && s->mte_active[0] &&
+        (is_write || !s->mte_store_only[0])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -10697,6 +10699,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 77fdc5f3a1..c74a4f6675 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -140,6 +140,8 @@ typedef struct DisasContext {
     bool ata[2];
     /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
     bool mte_active[2];
+    /* True if v8.5-MTE tag checks disabled for reads; index with is_unpriv. */
+    bool mte_store_only[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /* True if any CP15 access is trapped by HSTR_EL2 */

-- 
2.54.0


