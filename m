Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0908ECDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfZ-0004mX-3E; Thu, 25 Jun 2026 18:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsei-0004Wr-6Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseZ-0002Jt-Ts
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-845c65e0a10so73578b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426723; x=1783031523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6F2LfCMXaCi8pVIM+BWs2Fk5pa5aZpQbg+/ah/uJvpA=;
 b=ILaoaU2LGi4rf784sRYMHMVyZCn/EUu1H8a/jWVPhvzGC1cUMQKFW1xJYK9eQJ2DFz
 WHiGL5LDu4ky+PE/pmribuc6e/X4C1yGuo2PXv+NAMDC/4Wty4B/264BdcPGjYnF0Vhi
 wLWySuxwOmF0o9Q8/uAEtuO86KPFo0E7ozJtfVR6bhGAfAXGoqhuNqb+FU+pH5bI2PWj
 BHMS5ZYio70gTV2qxIFqtCM9Zw5S2pvD7gpdqKgy+7AIij6o12XRuYLqFLWPocOxZ1kZ
 OT1WHJTTLBNCY4WdWCtSTQwOv6O345LpzVFbHkZtHOCKZiI9eVZ7yibTKq6bHMnGZbc5
 /+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426723; x=1783031523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6F2LfCMXaCi8pVIM+BWs2Fk5pa5aZpQbg+/ah/uJvpA=;
 b=SVKEh6d+7gBIsmSUb36iKJ8lXY2ac5tN0SuEUgbWb/y2lX6iYNdkPptYlRm6U+xGO9
 dRTCcpxsu4zC/q2JBWMHLfV/mReQF1z6PNAZ9jtgR26XcEdRrxRBAReoftldWZ09sHjX
 KPT5f/DcOnNhi/h2B0vHgvaceLTBeqxKtCwmKUR2ihdHj0KgKJ7cJ38NM/ikyjBEz8AU
 BWAAtmSJZrh7z+eid6lfMUDW841TONrUpMIzuatgRW5bPs2dST30FOK4rVyQiBTRnE9u
 hTKyj++ASc54/MvOQLKKpw+JujlkVNq1pVLjhQWhcWVYdcNhcIytZic7HuopigIo4Tfk
 7RVQ==
X-Gm-Message-State: AOJu0YyHOTIr54dmzTX7Ujjo6pgh6BurcM1+UZ0vmO22MEUpYi65VSUS
 iHx4iwe0cRm6SjbX+AZj6aRTw+PP/tGXtSGWbPLZP7P9buliKQ+KMrv4VM5vDEFP+rkmIYGmuWt
 Xjbav
X-Gm-Gg: AfdE7ck7g5mwFaYvc0dd8wMOTXzLW4nmIJUm3T8spEWnUKT63Tij6DwFABLry9/7/yV
 pD/DuKf/HCvemGbHyNpNWbh3mCsc0WPmJCYONnlsBw9zKPlYmX/9lvOa4681KkDMCSDOvUcWJSP
 VmrBI8eyH3h+G+KYoabm55uh+OyYEzdFg6RLFzjhM2mfTnxzOT6qq9psoo4lZCYovlBnzHNezP5
 TNlbt2cDAsSTrIFCPgNj1TJrLxFd+Szd3Ne6yFPYOT05DVzyRkkUNbQD7qjD4+3oE70j4za3Css
 kHWMygSg8FG2jvzfUgN209A2cnuYQoWqmjYrb7OrlbSzHbBLpT+32lFG/Ue/VC5DReyUm0lDBlP
 kjy/JnXxf5FPB+Rs0PxzqijYEIgWlNyE1U/72Lwh184gVyVWhT7Umom5BbqVV/mNb+1N7ohl6UT
 Vs1YG1X5Fy2dvEc+qjfIGdtOTPRNSxRfZYGh6ObkyjixMiib75Rw==
X-Received: by 2002:a05:6a00:14ca:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-845b39a28demr5319394b3a.6.1782426723107; 
 Thu, 25 Jun 2026 15:32:03 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/15] target/arm: Implement FMOP4 (non-widening) for float16
Date: Thu, 25 Jun 2026 15:31:47 -0700
Message-ID: <20260625223200.763198-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  3 +++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a0afbd4fd4..822391aeb3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1792,6 +1792,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) && isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 9e1f09ce5b..ec7389d2ae 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -356,6 +356,10 @@ DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_5(sme_fmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b08d91e6de..c4d149f7f7 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2636,6 +2636,48 @@ void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
     }
 }
 
+static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4a_hh);
+}
+
+static void inner_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(float16_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4s_hh);
+}
+
+static void inner_ah_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_ah_fmop4s_hh);
+}
+
 static void inner_fmop4a_ss(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index aab5eab9df..d19cd274ac 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2025,6 +2025,14 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const fmop4_hh[3] = {
+    gen_helper_sme_fmop4a_hh,
+    gen_helper_sme_fmop4s_hh,
+    gen_helper_sme_ah_fmop4s_hh
+};
+TRANS_FEAT(FMOP4_hh, aa64_sme_mop4_f16f16,
+           do_mop4_fp, a, MO_16, FPST_ZA_F16, fmop4_hh)
+
 static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
     gen_helper_sme_fmop4a_ss,
     gen_helper_sme_fmop4s_ss,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5a3d47cdfe..227f3d7790 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1094,7 +1094,10 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 %mop4_zm        17:3 !function=times_2_plus_16
 %mop4_zn        6:3  !function=times_2
 
+@mop4_o1        .... .... ... m:1 .... .... .. n:1 ... . s:1 ... zad:1 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
 @mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
-- 
2.43.0


