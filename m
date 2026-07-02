Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB80CC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFy-0006j7-Or; Thu, 02 Jul 2026 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFw-0006fR-Vl
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFq-0000U1-HU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:30 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38101f85591so588883a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025004; x=1783629804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+eNalsxbXOGNL3JZjaK5JO1lGbe25n/3QvXCNAlxtk=;
 b=XKBiy1y7p+BV9+gixmb8i+F9olGtKRcFjUHj4b13mp1WJWmVg0bjKlRf126OChy7nZ
 kLIlgmuYJ7RGDl6S2T+P1g6H/VXk/tr20HWtwBvA5iZKaAndfXZny5F8xjtYE8R5m5xo
 4ZgapdUfV3D8vRh8HHNI4jHWfyF4SSfOyDcb8m1fM8L1twihvBYACNhY1clFzPN/eHDw
 wk1MuyasKaSvNEqUO+zvBOk8K7Rc0anycwODS2phnfhfbzsks6ncCHR4VWaHEiVyjywC
 6Zk5hy210OqJSe2eM9pj3daXM1OhD7awL8Yn7tdnj5trTlB0OboBC1ntlTqt+NGEBKZt
 DL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025004; x=1783629804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+eNalsxbXOGNL3JZjaK5JO1lGbe25n/3QvXCNAlxtk=;
 b=iNTfKuyQXe86GlghQaOzH0LRqdh+Hj9WtlKCxrCm23Y9WsTKNm5sykXreDe+N0TGE8
 0gIa2IYmHSAuAkbZmIlyGUtsGXhEQIMSL375sBt0b3XyZUDHCCTEaas9nGUFQFc4exBe
 bZzI+F7+e1O5wRhL1EKHFzPqNO/5tsvmSd9Y0kE2XkjdMlTs3CeSBzUDtz5oCfata6K5
 Cmxf0MQszgz4ZZPd6KZY56n5uRFHW8n43tGYLRXH8PEhIgja1N6iLmnxtzKHzMOGcyN2
 VIqtMA4PivyFRyOiD/nYeU/sbvcOoRVTw9ejZKW5pdXseLE/+rNQliWTHeAkY0JPsjyk
 dmPQ==
X-Gm-Message-State: AOJu0Yyd4RW98ADD1ZdWO5HkdTQ7oFGqzv0d7tcMvGbfbDnaDiuZbA0f
 n7tuNJvznnPphr0dse8B/Uz1kTheXhJfONl5txWDZxM+0c07WEwUTaKl00yZ+Uwlar8J+8UKnjZ
 CdoNH
X-Gm-Gg: AfdE7cnDfbdvzcOewA4+CwuhhvgKZXOYYpE+bRkg+3RCtA7JSQHtReeERJgCtwjjXx+
 JejAH1y/hgCf+DME8ETC5LdKkJmjRVBIVnwUQRX4+uP6gchfhWYbfkjAML6d1HLYB2AafWoJSFc
 R//kmoDo91aocaCCnxgw8+5m4+GnDR9wvmBHL/yBaeUk7COuPIbC2CdBYIl61ebRkZELW/93pQO
 XN4jze5TfXYtMiNeLQKEh9bx4r7C9cQJYwkW3kJpcnp6w3Lk2mKkUAqY2ISdxntZXihnz85pGpD
 wkZlJ5aWgh+HAMtb9lsx51K1Q1bNkzoLKOXQsKXHY6AYMceWfd7/5ItocNjq6w02yZhm0btZ/eQ
 tY3coHvwvAm2lqwy2QbGO62QVUqCNggTue3swsg6iuaw+dB0JOdwRfJounRTINaQUWvaOrW/EYS
 uv6Vo37HfXS0pX7IkK+Gc3NJPpG7PrEbsTEFmfUO8drZGX+sp/uA==
X-Received: by 2002:a05:6a20:3ca2:b0:3a2:c9a1:2c26 with SMTP id
 adf61e73a8af0-3c01c5e9a0bmr1487611637.7.1783025003703; 
 Thu, 02 Jul 2026 13:43:23 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/15] target/arm: Implement SMOP4[AS] (2-way)
Date: Thu,  2 Jul 2026 13:43:08 -0700
Message-ID: <20260702204314.79224-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 target/arm/tcg/helper-sme-defs.h |  3 +++
 target/arm/tcg/sme_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sme.c   | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode        |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 780b8f162a..ddf771e446 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -379,3 +379,6 @@ DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 DEF_HELPER_FLAGS_5(sme_fmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme_smop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 123f459342..32fe867a3b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2938,3 +2938,19 @@ void HELPER(sme_ah_fmop4s_sh)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_ah_fmop4s_sh);
 }
+
+#define IMOP4_2WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
+static void inner_##NAME(void *vd, void *vn, void *vm, void *vinfo)     \
+{                                                                       \
+    TYPEN *n = vn; TYPEM *m = vm; TYPED *d = vd;                        \
+    *d OP##= (TYPED)n[0] * m[0] + (TYPED)n[1] * m[1];                   \
+}                                                                       \
+void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, uint32_t desc) \
+{                                                                       \
+    sme_mop4(vza, vzn, vzm, NULL, desc, sizeof(TYPED), inner_##NAME);   \
+}
+
+IMOP4_2WAY(smop4a_sh, +, int32_t, int16_t, int16_t)
+IMOP4_2WAY(smop4s_sh, -, int32_t, int16_t, int16_t)
+
+#undef IMOP4_2WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b198c7c855..b948591dd3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2092,3 +2092,21 @@ TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
            do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
 TRANS_FEAT(FMOP4A_hb, aa64_sme_mop4_f8f16,
            do_mop4_fp8, a, MO_16, gen_helper_sme_fmop4a_hb)
+
+static bool do_mop4_int(DisasContext *s, arg_mop4 *a, MemOp esz,
+                        gen_helper_gvec_3 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(SMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_smop4s_sh : gen_helper_sme_smop4a_sh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4b7a99e203..20a2febd63 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1116,3 +1116,5 @@ FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
 
 FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
+
+SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
-- 
2.43.0


