Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG5-0006lh-B9; Thu, 02 Jul 2026 16:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFs-0006dV-Hr
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFm-0000Sf-0U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:25 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c96cb024ee0so1267873a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025000; x=1783629800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qC9d/JZO7rR/aPLRmeFmvqNLEA1uWo25k4cs3csovVc=;
 b=RYhfF537p3BvdR9LF67qVFQ2TMvTJHG7XzT6IhKSs6UXhwl39bk5yau8C5d4ck06Vr
 uwtShWjfBO/uE0Mt4wFCAE7glonsH4GKU4VZK/TWNmVMNl95wbBJjKDjLLw0+WQQ65A5
 9eiL6o4UVqh67iwDAvi57TH/J8YRcxmUl5zkb+pdTUv3cEo2L0DpMj8/uiPlvsZo7jI7
 1Q4T0KiGE+hpZP1qFev2QoNMredwxfGZD0tQFpqP42yGO0LZg/t3gNyspQxNrDSjClEk
 pPNYDO541Elqm35E9Ei9L9PMZRiUY9iE1xKk7JyTPJ2eH51XvFvmhh65+C3lcXMjgHFN
 bB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025000; x=1783629800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qC9d/JZO7rR/aPLRmeFmvqNLEA1uWo25k4cs3csovVc=;
 b=c4MMbUxnLM0ttUjrMqkvS2mhr9r7h9GXZA0ollYtFmrpoyix7sE9QLPlRmZdUOfhka
 inedCcWMOqDOvL9GHpTlG4jIlcxYedvGWwJfLdReQc42R28AFFfVrNedMSrLHqZ0a5bJ
 jjM/Nz73XgiK44ntk7Sz5EsiPu/CqDO+W5NG45KHNypTyMViyktG8yoBdqG3tRKwGZb1
 bSSx00szfXQkm3QjbIHLQoLbagh3/8izNl43iqg8VX1B1S5/0oUOjpLdcaM6MSCBuIS0
 pauddrDczya/vMPbwI3uwCOZgByKVaiQY6jMfyjx52NtVCvyrBtsrV4N601+Jb/RUNDg
 vLOg==
X-Gm-Message-State: AOJu0Yw4EIYpsG1OmbauQrf+WZagVbG0uipbLZR67GxL5PiJWKScB4O7
 ohLWHJcsP2LkK3o80I7UY69FvDnHvxeEB7pGo/mJCCG6umRrnktwzeyZr1tpSkzI7C85w6dn4RT
 pHW3u
X-Gm-Gg: AfdE7cl4geJkyaiKDwoMuao5Z0yfbLZmiuNaeXvDUt0GbtdichLsAg/SukngIu+QuLr
 3GtIS/D3V3vOm9W85AeBvH7arKRNwU9lL3z7qTqoGdCfBYS6uYH3kEBq3+1XPaRf4YfapFeTQ8N
 VjvGPbgj/K0tF6MUYzNwPTIDQgnN7E0aC2Vwc8V9cmyr2/PrcraEpNruvrOJGRPmbIh2SVy9CFK
 +6x3jefZYj6RehEHs+QuTUQ8cJ4Csq21pNZT7GW/9Q2ua5TtLJIwwYFAITKaiRRGRc7PiswKYVH
 S21CCMSgAfnbE4k5cdrdmgfEsyrRwoLdR87Z0dDVGoxhV3sutOohSFK+QKkrS+In6Ox3E7wc+Vp
 z7y2n7tX+74Wwaq0TlhsnoWFOOjQ4hdWNdYG2uVkRopvLGhOzHHWGqW2R6y3i5M7DXenb2Q411f
 lB5aO9yjjG6WvzEcK4x8uCrsYZIbEEuwFd6W+Xgbpo1xCWL3k0yw==
X-Received: by 2002:a05:6a20:c997:b0:3bc:5284:4859 with SMTP id
 adf61e73a8af0-3bfed237941mr8541031637.13.1783024999465; 
 Thu, 02 Jul 2026 13:43:19 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 04/15] target/arm: Implement BFMOP4 (non-widening)
Date: Thu,  2 Jul 2026 13:43:03 -0700
Message-ID: <20260702204314.79224-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  1 +
 5 files changed, 60 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579a99122b..d8e0dcd0f8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1797,6 +1797,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) || isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8a2ff88d49..05ccb0d1e2 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -367,3 +367,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_fmop4a_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_bfmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 81ec7ccfa1..0de7dd84e5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2761,3 +2761,45 @@ void HELPER(sme_ah_fmop4s_dd)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_ah_fmop4s_dd);
 }
+
+static void inner_bfmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_bfmop4a_hh)(void *vza, void *vzn, void *vzm,
+                            float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_bfmop4a_hh);
+}
+
+static void inner_bfmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(bfloat16_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
+                            float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_bfmop4s_hh);
+}
+
+static void inner_ah_bfmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
+                               float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_ah_bfmop4s_hh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b6c49b9993..f833975875 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2025,6 +2025,14 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const bfmop4_hh[3] = {
+    gen_helper_sme_bfmop4a_hh,
+    gen_helper_sme_bfmop4s_hh,
+    gen_helper_sme_ah_bfmop4s_hh
+};
+TRANS_FEAT(BFMOP4_hh, aa64_sme_mop4_b16b16,
+           do_mop4_fp, a, MO_16, FPST_ZA, bfmop4_hh)
+
 static gen_helper_gvec_3_ptr * const fmop4_hh[3] = {
     gen_helper_sme_fmop4a_hh,
     gen_helper_sme_fmop4s_hh,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3b7d8e9430..6021803ca0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,7 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0


