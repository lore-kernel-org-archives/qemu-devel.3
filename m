Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8129BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFz-0006jP-8z; Thu, 02 Jul 2026 16:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFw-0006fK-ST
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFq-0000US-IV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-847a5528b33so1248273b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025005; x=1783629805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUvfYWqQa4430Z8IazmhDPOpdaKVQE0WFkSEepOUgzg=;
 b=GIk+m3Zv8zcF1+DvdEQDtfBFo+GcPff/fjTSifbqLTw/MVU+nfQxLX1QSBum7lVPXx
 Z4Tua2dV1+Cp8dejQ1Kvm3U0jyhy1+9rbuc4YfZzKNwbC8//qrRPeK7dupI1obvK++WB
 S4E0nEn1UpwepMKf/L+eU6XO3ZOzrU/g9t2pc6WtOG1KIOxVOnFf7QLHIWFjF+pG15wp
 yNCv9QuDra/9Rz0UbTTMR+LUe4j0Ckk1XrYn/tKo+UO58rkysYzvMiQgPAa5tvpxcAkj
 GzBovyoXt57hguCuWTEBFRk15yTJWvLiqVcTcZVBH1+/5WgjYLvzWKo/af8uTZSg7RyK
 8cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025005; x=1783629805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUvfYWqQa4430Z8IazmhDPOpdaKVQE0WFkSEepOUgzg=;
 b=kmPR29Wlk7CB8u8BzEWwgPbY7bMzfMxDfMvtZzYQ7KSJswm0B1ZsKGT8oIbnggcnZb
 KPw9EhYr+LFXig4rFEGG5DNoA3U9GlcJHfE6YYtVx5BvlCrJBJVobOkRL6YSpx/WbmHs
 YFoAcCwVQB6okJrGKgIkZA448FAb09929dNDYAjMX84EVw6bEY9aSVaksnaPe3WF/jeq
 97XmX3y8RYa+FZJHz8WDKIX6yxCcCOR3f08k9V096QtvuoXZzFrdUXxrkOrfuhL7IEb2
 Qmnlz+PZz1KM3Fitd/FGzcgD8E12T1ecyDTwQap9PyonBIufQPPuiNeDnOz57/rW/bTG
 mqLQ==
X-Gm-Message-State: AOJu0YwSXB/ebKjZYqIuCTqwdYu+7lFWNAdIDS3pVHkx9I+qk4nY6IZc
 pLmRA7Ce1tdcTig5iufNNgOk9Y0ajB8WryI4gYUtu4piCZ3aV90uBOoItyFWv/mLyhO6OhvrEym
 kYtQN
X-Gm-Gg: AfdE7ck1UMsg725ANC8syYKRuh+xL9asp5bsxtlcfu1rDWazZeq6d0HafrJCIKhtAnO
 xM9UAZLrax1IPLPSicez26KgbbKGK/4GUkzOIUWJ3cI/SSWLS+njJuOXkeVEYasJOoYYT5QuVhs
 U4LPSlWHjRrTFXt9RbvCDfLoAWrt9x/BDcLwVcyP6dHhw811VmQxPRKjYaVZzOnYmH2c37UmDTm
 n7Gonjd7L/Geqx5qnKNZkFoSKqEf/m1bNWq6abdYHk0HNRe9qwOfadAe+C1oXFnB23B+5iVFeCt
 bfSTvYBtSM/yOhXlcK2Gr1YrOp/RDFk3LkIJLrvkIgH+nhlhUWv0MReFUGWFiKF7/QwLCF2UH7P
 2hc0tAEWrIjxksc13DSHLPxVYboI0tIFauconqs+4T0nd0Tzqi+IsrtmM6vN8tkguI9C61Dds/V
 yKxhxEHmW2yxrZ6LptyAcJ13G155DhFg8LVNOOyKRFNcHPK+wwyQ==
X-Received: by 2002:a05:6a00:a90:b0:842:72af:b3b7 with SMTP id
 d2e1a72fcca58-847c512d33bmr7183829b3a.33.1783025004630; 
 Thu, 02 Jul 2026 13:43:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/15] target/arm: Implement SMOP4[AS] (4-way)
Date: Thu,  2 Jul 2026 13:43:09 -0700
Message-ID: <20260702204314.79224-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-sme-defs.h |  4 ++++
 target/arm/tcg/sme_helper.c      | 19 +++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  4 ++++
 target/arm/tcg/sme.decode        |  2 ++
 5 files changed, 34 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index bceaa10a0e..3bc96ea3ac 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1822,6 +1822,11 @@ static inline bool isar_feature_aa64_sme_mop4_f8f16(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 20a2febd63..16f86a9d2d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1118,3 +1118,5 @@ FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
+SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0


