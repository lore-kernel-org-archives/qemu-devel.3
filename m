Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8824ECD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrZ-0000Qp-32; Sat, 30 May 2026 19:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrW-0000NX-IB
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrU-0007bo-MC
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c379e8ffso1236075ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182779; x=1780787579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GUy3BdiFH0e2kziTMnKk/rosFHDSopdGmPfzydA1pg=;
 b=HfVykE4mBVsqVtPSzaPc6PPK0WigZbkxyxfhySes5JzWsjNvJuc0euMQKa12LYKV3k
 UlKQyF3/TnpMdRczlx32qExsws7A+p4Qf2w01DLAfTAEvBtuHDZEnIbOl/o7Jna2TkF9
 //SB3ZWzHDKD2hjN0fg7AtWxGCUtaAatlG+Unc2cfd94V72lFAonLxz0pGuKkj+8AJap
 S8RhepXQid+iRORPMn6F8mpUKsZDY36waWLwn2ZjOAky9ugsIBXK9B3STEPIbiiKN6Hw
 6ujZHWe6WHISGgd8dPRsrfKoP896RWUn/gzxa7XVC+wDUiwUNYt1moeBoXOuu9RtnFeb
 P/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182779; x=1780787579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GUy3BdiFH0e2kziTMnKk/rosFHDSopdGmPfzydA1pg=;
 b=ggvnje2RNdJo5KDI9P/7b69TM+oBdcPApJ2zGBphXLZ8oalkgOvY37wTwhKCSvduOC
 Xy9jfLgcNz4yIjI9hC6TvafG+Bd1KQrtZzwEWQdtAo5cGgsHq/H0Ef5oM/bKcQHynqGz
 QFD2bpBAI2uqAzM3ETz8JCcrixENIpx6nrtNmGZcQCDEVMOer064kS9G0FbRc9INdUSZ
 NVyQpyjQuNBUra1nLS4i+sGVfh11y/Zwj0ov/JUVMKidJpSuPrzwRfx95dlHIJKCMBiL
 mcnT/ySRGSYW6pMOOML0fDxPmUrZ4SGeRbQp3MmjyyoJtY7uRgLtQ3ifB3bsqN4lBBpi
 6aWQ==
X-Gm-Message-State: AOJu0YwOGeQFyQB05iOwmoeXgnUsoFG33zvkeq6+xP1MlcWmjIQ41I+F
 WLRUDbrRYw0fIP4vJBR+IOnSndfead35aQl05XG39M4TAGJG1JX3wdTIXKyfIrr21hNyIoRgAKZ
 AfEU+3Mk=
X-Gm-Gg: Acq92OF+BlIvQ8bQ1TWWOLs3euLSNayIbKZm4Kgt8oEuO/QAkyD7cXyJByqOzdk82l0
 0leESPmqfFPEgf0nk5XTyfIiT7GIBaYii3y1XpY5UUX4O6/jY5F4DR6VUI6srRSS48Qzbg0n9OQ
 eBNTSqMae3cC19Owu/kOdr375d32ifIVgwMz5lOW5xabRjcGOq3k2ipDQJXxfkkvtYiBZDd3guC
 2/JRUZg824IFEN2fQRowROCj5k3oma5u/KbHwx+b3sYjAUX/+JGiXMPlTxEB23vMSESNvKagTOO
 1+c+gycYCQS9FBA/MWzdrTyPsPpEvz6x+xhf3nJG6zWV3jTA7gbV4sLUdnx3gusnvnLLHK0GG9c
 gNc477fWFIgtvw3pxoA3+wR+pbcHVx/qSymHBiltLHrMuhlPWRlTf6VbzwtvPDKuZEKtFGe6t4p
 T/JZE6LoKt5IM4fmFu3rIEOei/rW//3/wZDdsCLQA=
X-Received: by 2002:a05:6a21:9202:b0:3b3:23a2:edff with SMTP id
 adf61e73a8af0-3b42823c91cmr5086905637.28.1780182779208; 
 Sat, 30 May 2026 16:12:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 31/41] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Sat, 30 May 2026 16:12:19 -0700
Message-ID: <20260530231229.400441-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4342a2461e..fbf4decd74 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1560,6 +1560,11 @@ static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 95ec3a011e..96ea0b4bd2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8391,3 +8391,38 @@ TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
 TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
+static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp4 = dc_isar_feature(aa64_f8dp4, s);
+    bool ssve_fp8dp4 = dc_isar_feature(aa64_ssve_f8dp4, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp4 || (fp8dp4 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp4) {
+            s->is_nonstreaming = !ssve_fp8dp4;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           tcg_env, vsz, vsz,
+                           index, fn);
+    }
+    return true;
+}
+
+TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
+      a->rd, a->rn, a->rm, a->index)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 06bbd7fa63..c49e992f10 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1874,6 +1874,8 @@ FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
+FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 floating-point multiply-add long (indexed)
 
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
@@ -1897,6 +1899,8 @@ FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
+FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+
 ### SVE broadcast predicate element
 
 &psel           esz pd pn pm rv imm
-- 
2.43.0


