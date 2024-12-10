Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771F4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xS-000446-GH; Tue, 10 Dec 2024 11:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2x2-0002wA-8f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:15 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wx-0006SC-KF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:07 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53f22fd6887so3120678e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847542; x=1734452342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBi50fBjO71qRLAMWMSi4czuRa2YaRF8EoteBaucdNo=;
 b=ocvRYwMpabIoR+r0Bp7LNthyF4acAP/KvrSPx1SsuxJSQlhpfoqzQK0Jv3WaAfXysb
 BeeIC1dthtjJ1OhkW3fS/FhaKVzmEYrGEwTfA/8UuuEsOxtPnMNRX7g8st8IB6paZlNO
 BMz6eP3LnWPDt8qVgUCtbKsQ8WLQqb7aA8jH3a/Z7QVq5RxwdENuIVjdw6TM5ckBWb2V
 gYYks8xM3DUe5zD5asFAeNcEjVcWMaUDEhrOurM+0+nMv4paNo/32XFTFAHtrOpZeBYV
 JDHN57ukB2pxTsDqlVkcL7LJmLxTJ5saMcKpZJ34uck7FBjTvWCagkXBfTEqU0yCktM+
 wsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847542; x=1734452342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBi50fBjO71qRLAMWMSi4czuRa2YaRF8EoteBaucdNo=;
 b=cbzTUZxQh+FE2aTjnJcSbefQ4oFsNxbrMgrVjy6RWRH+LO3Ui3Dxv8tXMdEkR/TC1Y
 A7NUqdJ70Z7xFEZgwvYGlosEZEVt8FFAQ88FatXzL/cBPhQ1e6qLw3P5nvuX+CQVkbyI
 ydszR4CHgYnukyQLEwKfGaEXUQ30PZcOnn5cw9BBIzapLgAOVC6Pklo4Y3RKRRGJp8qD
 ZElyx2nQEbKfrtEfJwi8/+M8k2suvnQMG0j/OpKZ0Tq+uqkBsM11quvt7mSIUqjWJWYP
 3M+rPGsUdPQPSrWHt+CX0vx+9kojNkdFpKSrgW9nVxoO3Q9y3Xr8jRvjKgR0ePhldpNL
 tBLg==
X-Gm-Message-State: AOJu0Yw0GoD02HCZTtl0+APp81mv4GUnaL0LeApo/vsCJPkVPdD/rNuK
 NW6E1VFiMNbWdviO1mr4VTAOnUfmdaAY3v8zd+bEn+G4p4xB5w9EzwId4L+W3Kz0nSrnhhwimoC
 5E73zrh2f
X-Gm-Gg: ASbGncsLWsCfV083jgotyeYATy5hNH6767XBelWaDPpIdJPZ4pLXd6BzOJK4LRMoOv7
 Hx6Q8lFdBMDS3CVEIuYrQNwwQowP14LesUMrH6/ySkuuZVNJR8kG5pGibIlbtq/Rvg/S+mkd7q/
 EIFJuBigjHtF9gleflhj756AFFv3WB4Ti/3CAIh4eg2Pc3P2hTMlTQoAlX244hvbmX5IV+fSGx0
 A5QDKPqFFeOgm/owzjEqy4xqX4doGavdgQ/adYMkMSy2kLkIiqOXA+eHhk=
X-Google-Smtp-Source: AGHT+IGA52e8ZxRUjKfPaolQqyj+qHZWY8+ruwx80HjCZX0wDcQ1kPOgVkBaEzinu/ycGECqoTcmGQ==
X-Received: by 2002:a05:6512:3b20:b0:53e:398c:bf8f with SMTP id
 2adb3069b0e04-53e398cc15cmr6304937e87.32.1733847541830; 
 Tue, 10 Dec 2024 08:19:01 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 20/69] target/arm: Introduce fp_access_check_scalar_hsd
Date: Tue, 10 Dec 2024 10:16:44 -0600
Message-ID: <20241210161733.1830573-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

Provide a simple way to check for float64, float32,
and float16 support, as well as the fpu enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 62 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9c6365f5ef..4e47b8a804 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1239,6 +1239,27 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+/*
+ * Return <0 for non-supported element sizes, with MO_16 controlled by
+ * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
+ */
+static int fp_access_check_scalar_hsd(DisasContext *s, MemOp esz)
+{
+    switch (esz) {
+    case MO_64:
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return -1;
+        }
+        break;
+    default:
+        return -1;
+    }
+    return fp_access_check(s);
+}
+
 /*
  * Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
@@ -6628,22 +6649,10 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
 {
     TCGv_i64 t_true, t_false;
     DisasCompare64 c;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
 
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-
-    if (!fp_access_check(s)) {
-        return true;
+    if (check <= 0) {
+        return check == 0;
     }
 
     /* Zero extend sreg & hreg inputs to 64 bits now.  */
@@ -6894,22 +6903,15 @@ TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
 
 static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
 {
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-    if (fp_access_check(s)) {
-        uint64_t imm = vfp_expand_imm(a->esz, a->imm);
-        write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+    uint64_t imm;
+
+    if (check <= 0) {
+        return check == 0;
     }
+
+    imm = vfp_expand_imm(a->esz, a->imm);
+    write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
     return true;
 }
 
-- 
2.43.0


