Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC92E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPiU-0005Dp-Bt; Wed, 11 Dec 2024 11:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPi0-0002Gn-2s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:08 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhy-0002OQ-4v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:07 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d900c27af7so44389876d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935025; x=1734539825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4hQ/k3bgfabyL+FoFt8yRR+YCYyEP8pytxrqcBvzgQ=;
 b=Vusrzw4M9C1jka/tlHsfd764JmctcGsQiuYrTcMieTFDJEXnxK7t/u9CKBWCIKYC8G
 YAAEHUq7VSK5XUtbU8wZ+5u2Z2N3au0aFi98A3cvJv4KpLp/+rGPtacPs4MIBJRtsikO
 OwjasVZWL+6zj8K4TYdyHJsdufRMybkEVifcWLBiXjKoKn+HBuiIRHcnrWAGRNRzJGj6
 EiJhkt2h80Fq0WwT8Jkg/T0xPYkU+KHEur9WV1TFwZqULJPjCgwD0piiiKB8ULoTvznh
 uKnYYBRaNWSbvVLZZbgNZ6rYKtWhFsvBQZULELAQQTrLW2jLNgD9qM/LdpKZmcktFwnv
 WJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935025; x=1734539825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4hQ/k3bgfabyL+FoFt8yRR+YCYyEP8pytxrqcBvzgQ=;
 b=TBbNP+w70AjP+HBHFteMljNNYJAnL7bzwOc9Jnbwf/qnKLBYB6TXqSDhD2odfOyqIw
 D+qBI17D06XIcu+1gCsnrbjqfkZJKmc7DvdfzvOLNs11sRxQBi7ZJ6ApGbV6VizPUi5S
 3lHDddMPAX9Vnb+aL3icL6KbZosM0Yu1yyNNzuTNWV1l6wcf5D28u5++yuAoPDA9MWBp
 LHsabjjCgCr6Asr133l5WAnYYgavLPzYSwIVGRxuYlaWlaEZ+eT7jU4nfYcsRA9tONs5
 /jkYuyFUinccTneqZXCEP/OH1uWGppgZThZUEnV2Lk5aj+l+IG9zE1J6IMxshnCcFt4w
 MAPw==
X-Gm-Message-State: AOJu0YzB71YQmeuN1I9a1iO0QG8Jnv183LHmG7j2KW970ULboduIVQ8u
 PQIdGptvdP7e2nEOp4tCg+ughxl1ps0OtxchMar0h98d0zgKJTDVLg2d8BDuzA0TWEbk++XyFsF
 OM7RAb36U
X-Gm-Gg: ASbGncvKVp4w1Sb2OO3VQ4rU5/2xRJxg+sHe+c3n2b2Mr/8HKDPl4DZBzrEODUM+Y2v
 Tqoh9hTYFcyt8S8K7bm0SSsPU51CzFwkHf4nTWZV11lvDSofCb8wLJimzG8b7fFP+xN+aBA0xZK
 Ba9cUQggsl04m6xoVwctk8/TPbdm9nfdG3FNhfLLKWK5iyawG06PVemyX5yLMRDcY0uOvYgNUDe
 YDD7Kzb2ZmM0PBZbc1KSrPmP7r+bUSLRFuoHqPCNxI+RrDRpFylEWajfgagBg==
X-Google-Smtp-Source: AGHT+IGjy+fiHMcYpcfvaG3XvPpMIrLT8YdWE8/cCKGLpKasr9107I7qBpqOsvsZEmKT3vraftzBag==
X-Received: by 2002:a05:6214:da3:b0:6d8:8874:2131 with SMTP id
 6a1803df08f44-6dae29ef9acmr4914916d6.13.1733935025139; 
 Wed, 11 Dec 2024 08:37:05 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:37:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 67/69] target/arm: Introduce gen_gvec_urecpe,
 gen_gvec_ursqrte
Date: Wed, 11 Dec 2024 10:30:34 -0600
Message-ID: <20241211163036.2297116-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
 target/arm/helper.h             |  3 +++
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/vec_helper.c     | 22 ++++++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1132a5cab6..9919b1367b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1121,6 +1121,9 @@ DEF_HELPER_FLAGS_4(gvec_uminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b996de2c15..9b9abf1992 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -608,6 +608,11 @@ void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
 void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
                    uint32_t oprsz, uint32_t maxsz);
 
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01c9d5436d..01867f8ace 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2711,3 +2711,19 @@ void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
     uint64_t s_bit = 1ull << ((8 << vece) - 1);
     tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
 }
+
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_urecpe_s);
+}
+
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_ursqrte_s);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index f9ca889bec..c4fecb8fd6 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3070,7 +3070,7 @@ static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_recpe_u32);
+    return do_2misc_vec(s, a, gen_gvec_urecpe);
 }
 
 static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3078,7 @@ static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_rsqrte_u32);
+    return do_2misc_vec(s, a, gen_gvec_ursqrte);
 }
 
 #define WRAP_1OP_ENV_FN(WRAPNAME, FUNC) \
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0f4b5670f3..c824e8307b 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3105,3 +3105,25 @@ void HELPER(gvec_rbit_b)(void *vd, void *vn, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_urecpe_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_recpe_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ursqrte_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_rsqrte_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.43.0


