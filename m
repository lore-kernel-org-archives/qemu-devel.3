Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E3BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2y0-0007AP-1q; Tue, 10 Dec 2024 11:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xr-0005uR-4c
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:59 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xp-0006ag-AO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:58 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53df80eeeedso5538258e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847596; x=1734452396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWe0cS5erMqHnf9Y4yFydHawcmr3E5Sxjh2zbuzMCj8=;
 b=UzAAlujcLfKwstqxSOMYgvizPbXBqk3SzqnhJCgLk302PaFkSrQlcsv1wOTA1JTcKF
 5/9+D6XVLUsSzWhSJgFy9mzvqeVA4cpgM2AnFRNeBcvO4pZoD8rjtypGZHfd13PIC8TG
 dCV8IvyIL3tnBmlJcgaABidciLqMEbIFXaVYP+keJKssl4UIhCEd838mZu37P7wxOvkV
 YJGgVq0aQVLrAegHRTjnJJ6Zsb/zhyNCwrEhqO3rHJI5FMelwZW8xGJSZy0r9871oEzJ
 3HhP+uNOCrR3JEJs5OjeVAJ1uZt0YzpZtLHBRJG8gPM+cfsrAaTosKJkHUp0AfbkSBl+
 sFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847596; x=1734452396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWe0cS5erMqHnf9Y4yFydHawcmr3E5Sxjh2zbuzMCj8=;
 b=Fxo5L11Y9TvD4RlFoVuQKwXTtTb2pz8ODXQq8tkcj1grPuYpJw/hNho6m8VkO/AHxy
 hZhFUo2kL3gRC7pHeP3Cjh+qLSt2O1tSta8F9fEL/ypUwJwhIcm0OLYrjThjzpi7CPDR
 8gMSNpOsPsvBsyaf6jrvE0Zus7JHJgv2OOHH4kmcER4rvZlXXL8ZLXQMJf8NoS5vcyGv
 P1ekiAboLSHGSpK7F5okbiR8qNlU/tH0ChlQm+ADwfo77y0vQqDstJfXgSMvHuIC2oD0
 i38RqMGSudeGxrIENvUds1S0nnlYXZnhCL6iPOcKfbEfjTvl1+kDRC0Uq0m6MBGAffjD
 Jtcw==
X-Gm-Message-State: AOJu0YzINqzsCcKz1ABHkh24IwbiMSmblB2SadKS97Rp7aA5Wm7vx6OC
 j5PW7K1ImNVMWGJBW4zyDTffAzq6bl7bJcnndByHPjHpDY9eR6YePEDR4KcpupXCuOEr2aK4TUg
 G+PiIdIKL
X-Gm-Gg: ASbGncuG7clzuePABhYSlGECS4Mpe7mpnVKbkthX6juHTxPHEQYTAcnwa14W5PkHI6O
 mpaKDl8EbRMejVaQyPu3VvRiElMCxHuTPj068x6u9tRgHSeyCaFXxezzJz6eWJ7G3Fd7f3u9u+z
 eevvhZyvHMlv0h8fsjHzkiH8ZoYJrB4gYv0bjDKSkmFLItWPek5RnpUwlSAnAyYtmJnVRVxb1d0
 ZBDA9bW99b+7M77bMem5jeMSXKLTZI9XadGoHGHPipoUB5ECD/fZvt3D98=
X-Google-Smtp-Source: AGHT+IGQkFhH1ECWqbWqZx9eV8YD7XCQpjeAC/OjRB9RSV5SnH83dSjH6x/N6m22L5pi3aMBz17TIA==
X-Received: by 2002:a05:6512:23a2:b0:540:20f5:be88 with SMTP id
 2adb3069b0e04-540240ae6afmr1862193e87.5.1733847595607; 
 Tue, 10 Dec 2024 08:19:55 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 33/69] target/arm: Convert FJCVTZS to decodetree
Date: Tue, 10 Dec 2024 10:16:57 -0600
Message-ID: <20241210161733.1830573-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
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
 target/arm/tcg/translate-a64.c | 41 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 628def6c7c..152bb4b1b3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8714,6 +8714,26 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
 TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
+static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
+{
+    if (!dc_isar_feature(aa64_jscvt, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
+
+        gen_helper_fjcvtzs(t, t, fpstatus);
+
+        tcg_gen_ext32u_i64(cpu_reg(s, a->rd), t);
+        tcg_gen_extrh_i64_i32(cpu_ZF, t);
+        tcg_gen_movi_i32(cpu_CF, 0);
+        tcg_gen_movi_i32(cpu_NF, 0);
+        tcg_gen_movi_i32(cpu_VF, 0);
+    }
+    return true;
+}
+
 static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 {
     /* FMOV: gpr to or from float, double, or top half of quad fp reg,
@@ -8775,20 +8795,6 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
     }
 }
 
-static void handle_fjcvtzs(DisasContext *s, int rd, int rn)
-{
-    TCGv_i64 t = read_fp_dreg(s, rn);
-    TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
-
-    gen_helper_fjcvtzs(t, t, fpstatus);
-
-    tcg_gen_ext32u_i64(cpu_reg(s, rd), t);
-    tcg_gen_extrh_i64_i32(cpu_ZF, t);
-    tcg_gen_movi_i32(cpu_CF, 0);
-    tcg_gen_movi_i32(cpu_NF, 0);
-    tcg_gen_movi_i32(cpu_VF, 0);
-}
-
 /* Floating point <-> integer conversions
  *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
@@ -8843,13 +8849,6 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
             break;
 
         case 0b00111110: /* FJCVTZS */
-            if (!dc_isar_feature(aa64_jscvt, s)) {
-                goto do_unallocated;
-            } else if (fp_access_check(s)) {
-                handle_fjcvtzs(s, rd, rn);
-            }
-            break;
-
         default:
         do_unallocated:
             unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5e170cec7a..cd10961618 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1363,6 +1363,8 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
 FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
 FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
+FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
+
 # Floating-point data processing (1 source)
 
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
-- 
2.43.0


