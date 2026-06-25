Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287B9CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfk-000572-Sd; Thu, 25 Jun 2026 18:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsf1-0004al-Rb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseu-0002KR-Pk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-845537740ddso159904b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426728; x=1783031528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukzXmTkH/UG6MtnXHMAWLuPgUKOI9johr32VpU9wJfY=;
 b=zCsbUbbrW7hXf5Lu8ksupJNOwulNgbRN5hroB7XxJBljU9Htytw+8pIuBmvoB2Tz1h
 izdplmNnKVcWfrTEuJAKKfZFgKIJ2UFOhQ+jtNMvgEkqzFlc0yDBmYGkGf2i13Xf9Uic
 RbkxV3hNXvVxPmxxDl2OBgj1oQjddZ1De8kel5Eo1D+aBAbd3FPeqPVA0jpcgTktKvau
 vHvHdVkJ9gKwfZXcCSP600/sdAza9X7Me3UOVbftP9JhS9XH4stfYlW1Kc2JtMmPtDLt
 9Kvs6s64bopQqXwuG/A9iKZBx9DuDVeerN/+bhXtvuW8psKMW8R1HeKpNjULT+MsnkOq
 6hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426728; x=1783031528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ukzXmTkH/UG6MtnXHMAWLuPgUKOI9johr32VpU9wJfY=;
 b=kMYgUuHKN57ASDO5dEBLCapBvL048QevXM54dfVn9j1z9cNl0J4CtIwLdFpEig3f4/
 eKoAlgdkhWmQfjMekPqQujiNOcI4O8rC6k1NWn4gMDbWj0NGVKHVwm3iFtEPXYgdlQoc
 wUJprqErGDVk8VGOu9J04UlV/ISlWFV3cvFvde/vbH/any3CUSEwxtTmxzRcDMBAgHDi
 uQhgTs8AfI5z5cUL5wcWGu8ltrLzuOKMF9N4zN3p1v1lVVTmLJX/OejfO22wf8bkaSmE
 pU12J63q1GYqpo085+eMToF8DbWKC5h6AsL4sjNofOcbGXVEEHEMc0fDDlcixj+2BXAp
 3PKA==
X-Gm-Message-State: AOJu0YxBSG813KNmJDkjEpcfc/uZvIt2tcU8MQQ/giDX7UWBy+JbeRLT
 E+CBFA3xT5mI43HZlCl7s8c2sQZc00NTvq2jnEi1FIBTTyKrILNmdM2d0+3sNbpxKRgqOkK/yAJ
 QNj7G
X-Gm-Gg: AfdE7cnbQNudNdNpAgXRcIFUZIQmJT2qhlGDjKGJsFFVDSy8F7fo3KZxr1zKFb9RNR1
 NbU0UMpeAb8YaaL+UY5g9fCUW/2/l7/acpHgPF3aIAO4w5yEDu/7U66mIQank5bQkedltlNivao
 hYc2LfyoEMcTb3DedtSAzk4pJIRRaYthiKntYwxdLX3oiqAQMzlBQANcMfb2Fb30013fp+MFbVS
 PLgKKjl0KvXUdEqQhoHiydzxS4/8VCui/5ajqs0rcTnG6qLWv2zCHMf+uK18fSF7XzFM00cZRHx
 tZJ+MIvYCbNtkTYzTVXAlu7yIXJsAHEye1SAn0gd6fIj7SztE1t42XBm1noIEsPo9KyndwoaV/G
 gTVryiLE0gvQgwL4Dc7GUf5uXQZAZXB+vyWa581xJBjpw5znj5KkclMX+2GW+O2SknQeEQnt1Xc
 /y3TvZESW8EdvoFg3jKopXhjMBiLEe0VFwyUCmB2VmUKfm79HN7A==
X-Received: by 2002:a05:6a00:4088:b0:845:2f67:a0e6 with SMTP id
 d2e1a72fcca58-845b3c17addmr5224854b3a.46.1782426728172; 
 Thu, 25 Jun 2026 15:32:08 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/15] target/arm: Implement SMOP4[AS] (2-way)
Date: Thu, 25 Jun 2026 15:31:54 -0700
Message-ID: <20260625223200.763198-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index 43b6c32c04..a872fbb4c7 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1116,3 +1116,5 @@ FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
 
 FMOP4A_sb       1000 0000 011. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
+
+SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
-- 
2.43.0


