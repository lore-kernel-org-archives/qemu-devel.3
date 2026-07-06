Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CC4C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggin-0007RE-Vq; Mon, 06 Jul 2026 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggim-0007Mq-9E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggih-0003VJ-4q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso11319495e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334314; x=1783939114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gycfgN4ilMybUVWebBbS11Tu+/uThpasypGL0zVk09o=;
 b=baBEoOkqw2mQ3SaXCoeG2xCNVzRhFQx9rWq9kF4eY7JCjaW7r3LujusdBbWYoByHg3
 pY5+263ATmLs8nMbiUxSkv+pQyF1833H3LLdYj8qrkVyUtx7Sx6oYH5A4DEKDqI5CXRk
 WABreo3Wf8RYHMjW/U71zTwNJYgvdmZlEegPV/Z06KbcnPteH1fHLHW2geWNitT0VqOC
 /+05X8lCKmbsGa2WL2gDer2QZGGY4Sd85GuesrCiMkE47EWlHrfNcPn9/0+xvNLKz0Iv
 Vqj5EUl1roCEdZyhrIthfsY5Pu9Rj7gDZoidISwJo2BRef0s89C4JxnTRFGfCB1vVHkK
 qtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334314; x=1783939114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gycfgN4ilMybUVWebBbS11Tu+/uThpasypGL0zVk09o=;
 b=HyFQ78ZS2wTxONvueUpYNo+DBgiUPB7UbFEwA0jYwso9VsgbQzxua1uEFAz5oM0rI2
 VquQzX6t4ABFAxzrvsVWlo/8mFUn+o6hY1bb8+nQeiKQTXk/v3UwN7PPH8nl/hQti6o+
 bB2kB5tq0ecUmRlcU7X1+AhapHHR7REXY9KuhdQTifgc5u5Y2HPD++oMnxi6M6XsCLRT
 V5QdgN0jLsPmjOeHyG/zaAPvc0A0aqgot/n3xxZxGFofwSVXHHNtyL9OxQBLPfheuhQL
 cSS/cP/s1Ka/S1Swybp6rf5r8mgFubO1yYtZR3rhFeW49E+drTp1GQKOI/0AbQo664+o
 m4+g==
X-Gm-Message-State: AOJu0YxTaxc+xTJorWOfqhuIL2CiVfp3jedNT6xbmyEhj46UGQckrNLF
 fi2ARQiUjChf5DBVfGyfOJg6IqjeZLl7ukf4cbvLuCiyLMikuvX/U2wvalW5QWiGb5ZE8OsNlRt
 VYBF5OGP1qw==
X-Gm-Gg: AfdE7ckjz1GUV8a6CHKdvyqKn7kcfoylWVLHSQOFNJvIA63RxnOdyzI/FwUem+ChAOp
 MmR5l/kz5jxVxJp0YwOyL8G6yPiQtRoRqHWrfqUsbStczdxFpeUcfbX7pZ0y1XMdH26yenYa0dN
 2kh3Su4T2TxS1c9IUlJvXnevHjV9h8wYUaWKu7jUqhKQUOSiuvlZILHcln0Zhfh4x1q2yup9qVx
 odhH0dESozPLOfoIuYAt5UiFs3LXMNQbljCzrdnxR4jRUoB0gSFtdUIm9kPGvyV30EtYluPpWKM
 ujC0cEymDkhDNC6y00jUCr9Y76r/S2d7STqhp5A3G1vJ0L0WkrC1VP4+c/fE+ukb7Tu58VdUd16
 3hazO7uvhuJ2IkxXhxHMjlcn8zV9OYChB3oh3ByhOUUID+en1JMXkZjJcXHMbjdqIC66ZrLLFvK
 VvjfwLcALChj/91UUd8dmdXeHtohT6K+REMPBW/z99rPoOwiAMfTqRyXSmtrDw4/GS7JOjfQQnB
 Z4duhXlnFxxrUYOBo/wqg==
X-Received: by 2002:a05:600c:4f81:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-493d11f370bmr105569135e9.24.1783334313613; 
 Mon, 06 Jul 2026 03:38:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/49] target/arm: Implement FMOP4 (widening, 4-way fp8 to fp32)
Date: Mon,  6 Jul 2026 11:37:40 +0100
Message-ID: <20260706103752.320511-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  5 +++++
 target/arm/tcg/translate-sme.c   | 18 ++++++++++++++++++
 5 files changed, 46 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b4138e976b..e577880ab0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1822,6 +1822,11 @@ static inline bool isar_feature_aa64_sme_mop4_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f8f32(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f32(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 902e4b0ae9..f899a6cbf7 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -973,3 +973,19 @@ void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
         } while (++i & 7);
     } while (i < elements);
 }
+
+static void inner_fmop4a_sb(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    FP8MulContext *ctx = vinfo;
+
+    *d = f8dotadd_s(*n, *m, 4, *d, ctx);
+}
+
+void HELPER(sme_fmop4a_sb)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float32), inner_fmop4a_sb);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 126dcadf77..47f35a82dc 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -44,3 +44,5 @@ DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr,
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ea9f459e38..b8b507d8fb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,9 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+@mop4_o2_s0     .... .... ... m:1 .... .... .. n:1 ... . ... zad:2 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn s=0
+
 BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
@@ -1108,3 +1111,5 @@ FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
+
+FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 544a825595..386ded1b90 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2072,3 +2072,21 @@ static gen_helper_gvec_3_ptr * const fmop4_sh[3] = {
     gen_helper_sme_ah_fmop4s_sh
 };
 TRANS_FEAT(FMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, fmop4_sh)
+
+static bool do_mop4_fp8(DisasContext *s, arg_mop4 *a, MemOp esz,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, tcg_env, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
+           do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
-- 
2.43.0


