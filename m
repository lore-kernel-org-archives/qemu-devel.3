Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPp-0008Nz-31; Sat, 16 May 2026 20:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOr-0007Fa-RS
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOl-00053x-Ap
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso476956b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977825; x=1779582625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYbs//xfSmd30lTvUPo/vUUuHjT2oeSDx/AoUqmlW8E=;
 b=hsQV22zAJjU7H8vbX5ljjg/WdWMZfSOHu2SjAkXd614bp0dQFGXV0JYWhtDIrsY5tf
 1mINda9FINQeQfDVg9f1ZRr4rW1PDYddicjxYyvoR+uD4lakrgcjOq8NeZOPr9nRsq5B
 webWQl/otWSUt93/hxUK88l7TdOsIttDiUyhXFCsooePQ9Pa2cM2rYV2tCgxp77HM3Bq
 w/ciA3MXXfmvmkhDXAgMFtncklTlS+ZlvUfrxXDAaxkXAPWag2Lw7xco37S6jmTKV4t7
 QHz6Vlu1W5muuYhkcAjqOKJs5gpg2RsRd7Hi7Y/diCQlnTBk5rUrbgLIQvvSzdAWxGIS
 An5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977825; x=1779582625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JYbs//xfSmd30lTvUPo/vUUuHjT2oeSDx/AoUqmlW8E=;
 b=e7DbsxCbFUUtwywK7UhvbvQkaIrLO3OwsQg6m9VmD7e71EuaiXxnvN5avBbzpX3CFa
 lDOWjC0V5Ctsf55fmeBxI3QPwnFudacSLlmjZhMvj70KyOKj/oGwv7LV2R5TIzcAqD0+
 eESrdVTAg0jZchzPmS8heTbp2xVH4+C3CKFDoVtX9PxZ9YQCgJtuJZKpSsOEZL6IPBQg
 +a0m/EfI9gE2szu5vCU/weJSii1PaeIn2EDf3dN39UYCEBphck4N3xfqlZNmhbLut3uI
 2FT3B9azcZqcSfi21ZG7biACklcze8cdPZgE1yHg13EhUcHNlDwEKjQ1JS71oxLtjNVl
 PYAQ==
X-Gm-Message-State: AOJu0YyMqL0WtEcyjaxozM+GCksoGOtxOR2qVZVh951XoexroxujHoO1
 VE9ID6vJ3oUGUYMZIzjqej+7RUddDizSHPvADUP1EEmGFJc8pylNiUDCCrOpFWa3jYB+Zo3itzT
 FtPCr
X-Gm-Gg: Acq92OEfOoTNnKy81UjkZS6mQtJ/3lIOXevRNwQ/3h9D23ZumAQvH9WvH86igjDfUEO
 mRFemLsKjKbGmG9yhWXMK0g4cV4D2U53Sn4j7Z4SURbN1XbIkD7NluwFZIGk9H/6xOsCkZLVpNQ
 6ozaD2DUGp3OOukplelM+vUBVbo8Z5JN4E4dJaTSOt/c+nrSY0KeDiNH+SWe1X65FxN0spEwy3b
 y35C7Y9hE9viEgNUOYc88LxAFekh9gFmRYHKdMQBABgzCzUmR4kyqNHH6Cgb6fCqdOWg3Vpml9c
 LuuXoiD7GQciOrZcBuLaGbIkAU/EIjlt2gPm4BOB3Nq/0XE+q0qQKjdyxWgCwBm0QQKC/1CFr9y
 YZvLTJS0pRsb9fob0jxcEg7EuB4s7DLfOvPigt42YEcNxCpzUqwi68lnDyJdtx223PuU3QDZRe1
 sujgqo0LFwkw9Gc8sebAetlC9vmZht9oFmL/fX31k=
X-Received: by 2002:a05:6a00:3689:b0:827:3e19:574b with SMTP id
 d2e1a72fcca58-83f33dfe64bmr9680158b3a.43.1778977824901; 
 Sat, 16 May 2026 17:30:24 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 24/63] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Sat, 16 May 2026 17:29:23 -0700
Message-ID: <20260517003002.321430-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  6 ++++++
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..fd09bbc5cf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1643,6 +1643,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 0caaf63749..18ff483bb0 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -4,3 +4,4 @@
  */
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 33f12d45bb..7719d43d64 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -130,3 +130,19 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
     clear_tail(vd, 16, simd_maxsz(desc));
 }
+
+void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_b16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index db32230595..9bab5feb93 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -4067,6 +4068,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
+static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, vsz, vsz,
+                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, false)
+TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, false)
+TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, true)
+TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, true)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 078a085a79..e7984fa8e0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -108,6 +108,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rn_e0       ........ .. ...... ...... rn:5 rd:5             &rr_esz esz=0
 @rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
@@ -1090,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
+BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
+BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
+BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


