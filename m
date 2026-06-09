Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC5CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26N-0000Xp-MR; Tue, 09 Jun 2026 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX22B-0003gi-FH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX220-000489-0z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0c3315c5dso62663745ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032894; x=1781637694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9oKYbnPufbrbmSGaoz/PENlfl8zm2sxYN6OzTnkZK0=;
 b=BfIR95sSR4QhSsMSQKtDaXBjOZwcJMFBadfWitX3ngyZx8fThhQuf5eZKEJJPMjXvu
 IXHHP57sEYiYGZKMT7sB7LWZKT/Lzv8R8wpSgc+TxswG9u5x6EG7FVhGwHP+YQpl+OuU
 ARaiSfs91/NS+WtS8ufnNzaB2HsYphBYVEt/zEImcABWRek8htpDYNj9ZuVcL1Rh9MJ+
 iL7mTOYezsUC3jTT0a65LlO6L5vfvNalyfYjVnMURkUkvGkiAdWIWtM1n0oXCk8Ww0I4
 eaKsVHKjitgk9nOXeJ3NJGYwniP2gRJjdCqtX5tQZRc9Q1l5tVXKAPSe4YHy6M4ksczm
 QHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032894; x=1781637694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N9oKYbnPufbrbmSGaoz/PENlfl8zm2sxYN6OzTnkZK0=;
 b=XRbcx7hJO+F6TLEyTXFUAffGBiV4X3xi79m9nCErkwnvf6hgW/3pSa51PbYXG/lDBY
 661oAi5KeYp9p98PChLjjY3I2GRws9g1GuCgQOeZt1kFqyEdzhtDtHJ+OLNZ8W+uBuma
 DuHPUVb7cLo0cefnAVKSHvc22N4mUyDKLuURy88eDbxsS7qNCHboX2KUe0qh7vCo4OPK
 XK3n9SfpnQ7MHTh0xgTsJ8selHblB2NDxmYWevDcRQElERCAkPAz8wpdWqqn8CokPEtT
 chqdxsBpBcp5IDM2PpxG8DAsm6JqCSM3Ckc/4EZlcpVKsWIAgd96Jf7bd1q3S7mY2cXE
 flKQ==
X-Gm-Message-State: AOJu0Yxe+NyOgkWjL1Xgg0/Q15P/+EDSqb+yhvuyP89Sw+Q/m15zlkip
 v8dv/mdsVCsLoH8PMMpfChEB7ebbAgXBdQGLfC6Btc3x9bIbVy7LMTMwlYwlVJk6Y7sRULfWLca
 L5lq33Yw=
X-Gm-Gg: Acq92OHdwuLLGxi1/uEC58GQPuhVILxIBCa26eJnBbVuvlh33c7J2VNRjLyVBZzHWFc
 PJvMK55862bOHQayYblCqjDKYqPN5Z7Oya1WTDjW71m1OfJO26f69TK23XibJqrZxIIfDci+YNL
 XYYC7saqzt/5hHhKwJZFi8aSJ+Nnpts8Iq1CRaZntlkXt6TJ0Mud9pOyOmdbcxTDroP5+hAYLZ5
 f7TS7PzN9m18e3SQB7gcpLIuH3IX+lqj0SeY0mpSUDH9dKKkMkqGSpP7rBrKzqKVNCuRBZWzAWi
 rmsBOGvdQHDxhtIOS0KVkEs3bs7Ktd44xaSeM38Cb0YI9udcLTkRyBOauuXsZYuFwMq0yl5JWok
 VzIy5w36SgWaDbtDnm6e7k7yejnIzz4l8D01SVKlRepgaR8aRiSJ7nR6HrygJOH782++gSaw4Fm
 jbpaRBY0w4idt8WoVtpaZlZYMOS7ib6KUovSuSBa76FRRXVQN7pQ==
X-Received: by 2002:a17:903:3c48:b0:2c0:eee2:fc40 with SMTP id
 d9443c01a7336-2c1e80cede0mr250127575ad.3.1781032894344; 
 Tue, 09 Jun 2026 12:21:34 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 30/45] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Tue,  9 Jun 2026 12:20:54 -0700
Message-ID: <20260609192110.752384-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 418abf33ab..5e9eb3405b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1555,6 +1555,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0e0bc4cbfe..453bae3a0e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8355,3 +8355,36 @@ static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
     }
     return true;
 }
+
+static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
+{
+    bool fp8fma = dc_isar_feature(aa64_f8fma, s);
+    bool ssve_fp8fma = dc_isar_feature(aa64_ssve_f8fma, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8fma || (fp8fma && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8fma) {
+            s->is_nonstreaming = !ssve_fp8fma;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz,
+                           a->idxn | (a->idxm << 2), fn);
+    }
+    return true;
+}
+
+TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
+TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e2106fc7f5..71ec09393c 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
 %dtype_23_13    23:2 13:2
+%index4_19_10   19:2 10:2
 %index3_22_19   22:1 19:2
 %index3_22_17   22:1 17:2
 %index3_22_12   22:2 12:1
@@ -73,6 +74,7 @@
 &rri            rd rn imm
 &rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
+&rxx            rd rn rm idxn idxm
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
@@ -1864,6 +1866,8 @@ BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
+FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1880,6 +1884,9 @@ BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
+FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


