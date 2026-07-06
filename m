Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7618CC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiv-0007lX-6H; Mon, 06 Jul 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggin-0007Og-5C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggik-0003WB-61
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so26203585e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334317; x=1783939117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TO4k4EejLW8zuqEUQU8UnalfvHJeHl8H1oJ+uDmI3Z4=;
 b=h5ZkFp/u7gbLvW0DRN8W6j2E1xjBHrrIp94Gvw5xReXgeXF836NnFxI1NJxNNXvPFf
 FBoBH6vdmBfFB5NM31d0qEMWODoUJKo3eSgcbrFQZSYP2PZBtsFSG3eg37PtXXRgNjef
 6VjxIRovbqYy7hHgwkoQ8hDkvwO3ZjXaoiawYgnA0CQF61UjA7pnm+J063b7+MqKIEvJ
 JumkMYrOzN3FU8FQaFZkhWBRcs0/CDWLNPxgTHbY2ME8QkXMNGW+/z/u4eCi5J5EUszJ
 OSybVZdFkj2g/9/PbbVOtF8on1Ts1i8MwRabNq/9ZBI6QvtEsnQeZ6+SbKa1cXqY/2ev
 DK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334317; x=1783939117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TO4k4EejLW8zuqEUQU8UnalfvHJeHl8H1oJ+uDmI3Z4=;
 b=S1d9/0QbMjHyO2CQUa4WTFl1RqALYpWou7D55dYylndfRKCw1R/ty22Z3XIoq7PNJf
 24HIjcAER4Es9XmWUrNP4eE52zTqmuQpNsOnr4W98WftDTw2Hexq7x6JkSSAgLClbGgr
 pLmwkjNpW6DrjT4MdIEu8lxFTZh0s9prdL0q7t0zs8yZKgzcOTugh4jWfragj/3mXnIX
 SvmYUzoTeSDpfruQPeMzphJ/L15vQ2Zg7zGdeWhKkS7IsFGG38V53+ilG6YjSBYg4WBt
 3I7pMFXS/7v/zidc14KFcM9Jry9+/LIshiREbjpaa8EAq+IIMtViegoSBca1/F4WFGiE
 0L+w==
X-Gm-Message-State: AOJu0YwgPLiFq6bHj5ZVbeuJvVB1V9lKrR5AR3URYK+01kcSLrc/0qf5
 S0nfEHcbLy2/FJqgKiRSbZpcLcK+BqnP2PSvwXwSoz7SGg7apQJYZmvSM9PDPGzrpILf9fDUS9q
 ELIX1M1OYdw==
X-Gm-Gg: AfdE7cl1h0FnlMriDNlW3HuJn8WIURz6L0AXTuTyn8qg9QKb6CTqUnUbl+pX/NJyPFk
 8Y1BTWfn+orQE8Cpacfslz1VocECVTqh+Egyj8LVe05XfiezNSaCTze/Rw9zEhiHx3rp+0tmqFY
 2SFFqr7OKjlOpiP3bKos8D+z4uVjfDViSPns64e6bM4rwXDnUwJmdmtfjF/s5d/oi1ByYL/UBDz
 WMMHVNTwJYLS3q5sh0Me/jUlf2VpzpxlVvrHbJiHhLa8l6HuTcz/OXPW5hOVqtCAUrALKWo4G3j
 dTDrA1vibjccKQvxRm+F4ClYbmjlIPjvyQ2EqNnRQKMO7o7AZBnF1MRAhBz/l33TbnLNMHtqSWR
 2fK5wybN78wOveXWEXqo3LuTcoYNWjHN6qvGU3/QjXuHPc6pf2NTLy1pF/dhJm8DMJCwqducbCn
 OSWze8ta23GGv0gcVyEmRq181oRB9Mi4eGeiZLSVB6+jOT1Z8oaVmY/0Oqd0LmURV9lyt9P3Lwe
 kbT/BkNfFRlIITlGV8PXQ==
X-Received: by 2002:a05:600c:3e07:b0:493:da71:c1a7 with SMTP id
 5b1f17b1804b1-493db005371mr27726805e9.0.1783334316615; 
 Mon, 06 Jul 2026 03:38:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/49] target/arm: Implement SMOP4[AS] (4-way)
Date: Mon,  6 Jul 2026 11:37:43 +0100
Message-ID: <20260706103752.320511-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Message-id: 20260702204314.79224-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-sme-defs.h |  4 ++++
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/sme_helper.c      | 19 +++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  4 ++++
 5 files changed, 34 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 29b4f99aeb..fb5ed25ad0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1832,6 +1832,11 @@ static inline bool isar_feature_aa64_sme_mop4_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_i16i64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_i16i64(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index ddf771e446..070a1a2c1d 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -382,3 +382,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_4(sme_smop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 20a2febd63..16f86a9d2d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1118,3 +1118,5 @@ FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
+SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 32fe867a3b..11d9d509ec 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2954,3 +2954,22 @@ IMOP4_2WAY(smop4a_sh, +, int32_t, int16_t, int16_t)
 IMOP4_2WAY(smop4s_sh, -, int32_t, int16_t, int16_t)
 
 #undef IMOP4_2WAY
+
+#define IMOP4_4WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
+static void inner_##NAME(void *vd, void *vn, void *vm, void *vinfo)     \
+{                                                                       \
+    TYPEN *n = vn; TYPEM *m = vm; TYPED *d = vd;                        \
+    *d OP##= (TYPED)n[0] * m[0] + (TYPED)n[1] * m[1] +                  \
+             (TYPED)n[2] * m[2] + (TYPED)n[3] * m[3];                   \
+}                                                                       \
+void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, uint32_t desc) \
+{                                                                       \
+    sme_mop4(vza, vzn, vzm, NULL, desc, sizeof(TYPED), inner_##NAME);   \
+}
+
+IMOP4_4WAY(smop4a_sb, +, int32_t, int8_t, int8_t)
+IMOP4_4WAY(smop4s_sb, -, int32_t, int8_t, int8_t)
+IMOP4_4WAY(smop4a_dh, +, int64_t, int16_t, int16_t)
+IMOP4_4WAY(smop4s_dh, -, int64_t, int16_t, int16_t)
+
+#undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b948591dd3..6f3806f4de 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2110,3 +2110,7 @@ static bool do_mop4_int(DisasContext *s, arg_mop4 *a, MemOp esz,
 
 TRANS_FEAT(SMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sh : gen_helper_sme_smop4a_sh)
+TRANS_FEAT(SMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_smop4s_sb : gen_helper_sme_smop4a_sb)
+TRANS_FEAT(SMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_smop4s_dh : gen_helper_sme_smop4a_dh)
-- 
2.43.0


