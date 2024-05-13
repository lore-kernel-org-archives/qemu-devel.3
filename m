Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA38FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QRC-0006Ri-82; Mon, 13 May 2024 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPR-0002uU-Iw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPH-0001Nf-Ku
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so2956305e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586454; x=1716191254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hthpAUDZCE7MsS8KK7tEgLctoSvSemW+A0a2D7pgGUw=;
 b=OR3wn0BRMhmpVe8Uajcned/Y2FWjYVOPCwkhZf+XSdzJkNz4gfCM9gQo8mOIlwWWMO
 KXjo5Gbd2QRo11btCU8e+6qotrc8n2Qdjhk6r0/MNJ86yKmQaYAGTXiUkT5XSJ7UHRUe
 wsNH0AtEk+mXackoax8Pdp2KOikRv7q55b2aFeBBJo65TC9U1PzEClgihW+cDbEBb62F
 HCRmQwtlJuX455xIm/IQWZd1XJRKbKsVI0fFeKDZ5KNkSsMmP9ZZchdCYD5thfbiLKKh
 XPMSU/wDUOe22p0/zAlNgPfNjGwP5q0uXaCMC0i5OyxRSmpSnj1fC88Zh5NQglYJDTlF
 Scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586454; x=1716191254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hthpAUDZCE7MsS8KK7tEgLctoSvSemW+A0a2D7pgGUw=;
 b=d7ct5tc/Ljk6ns8IE4mlO+MwMHnCRMmI8LBNXDEsV1V1c7F++spLJ4Wgy6EdAmcMNw
 Qv1urtMxekzls9K8sJDRJ/yxh5EhMwAoVItcitlFntzk9ydKN7C/L8WUP1o8jiYd9+TB
 XBF//3BqUHn0AMDdTAkEb3+3BbiU96/FOa+KJsjd4PL0lmJrBHE7qgdaI+fFmtAnNeAv
 hXOU9M+JC3SHthu4BLcmP+gCKKFx5AXhvvmH7f1TiA8r7jlMFK6jzvC9APicyn8SahxW
 Smf8pwwwchhbJ7oL8AJkY22lhkbLhLUyhwoz13Fgl6meTOFjvZe9UVUHk/SIvLRwx1sZ
 KDwQ==
X-Gm-Message-State: AOJu0YzOirNms7ZsqMN6e2gWSb/R3PokDMG9rammA63AajGLCnkL3zVR
 ux7DhKHKtPbpRz+clrW6WGT3RPEMvTQgcqKybjsFO8ObfxdciFgcZpwR3eVS9WDaxZeanWCc1BV
 LB7Q=
X-Google-Smtp-Source: AGHT+IGEGOuoK8fKBF7O+5EUlYt/cEpwYk3x3JBil3MjSZqr9mfk5PcG6nIzjzYkTBzqgFxMJ9JRGg==
X-Received: by 2002:a05:600c:450e:b0:41e:c9ad:c729 with SMTP id
 5b1f17b1804b1-41feac59d29mr66574075e9.28.1715586454192; 
 Mon, 13 May 2024 00:47:34 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 21/45] target/hppa: Use TCG_COND_TST* in do_log_cond
Date: Mon, 13 May 2024 09:46:53 +0200
Message-Id: <20240513074717.130949-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

We can directly test bits of a 32-bit comparison without
zero or sign-extending an intermediate result.
We can directly test bit 0 for odd/even.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 78 ++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 421b0df9d4..e4e8034c5f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -914,65 +914,41 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
                              TCGv_i64 res)
 {
     TCGCond tc;
-    bool ext_uns;
+    uint64_t imm;
 
-    switch (cf) {
-    case 0:  /* never */
-    case 9:  /* undef, C */
-    case 11: /* undef, C & !Z */
-    case 12: /* undef, V */
-        return cond_make_f();
-
-    case 1:  /* true */
-    case 8:  /* undef, !C */
-    case 10: /* undef, !C | Z */
-    case 13: /* undef, !V */
-        return cond_make_t();
-
-    case 2:  /* == */
-        tc = TCG_COND_EQ;
-        ext_uns = true;
+    switch (cf >> 1) {
+    case 0:  /* never / always */
+    case 4:  /* undef, C */
+    case 5:  /* undef, C & !Z */
+    case 6:  /* undef, V */
+        return cf & 1 ? cond_make_t() : cond_make_f();
+    case 1:  /* == / <> */
+        tc = d ? TCG_COND_EQ : TCG_COND_TSTEQ;
+        imm = d ? 0 : UINT32_MAX;
         break;
-    case 3:  /* <> */
-        tc = TCG_COND_NE;
-        ext_uns = true;
+    case 2:  /* < / >= */
+        tc = d ? TCG_COND_LT : TCG_COND_TSTNE;
+        imm = d ? 0 : 1ull << 31;
         break;
-    case 4:  /* < */
-        tc = TCG_COND_LT;
-        ext_uns = false;
+    case 3:  /* <= / > */
+        tc = cf & 1 ? TCG_COND_GT : TCG_COND_LE;
+        if (!d) {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+            tcg_gen_ext32s_i64(tmp, res);
+            return cond_make_ti(tc, tmp, 0);
+        }
+        return cond_make_vi(tc, res, 0);
+    case 7: /* OD / EV */
+        tc = TCG_COND_TSTNE;
+        imm = 1;
         break;
-    case 5:  /* >= */
-        tc = TCG_COND_GE;
-        ext_uns = false;
-        break;
-    case 6:  /* <= */
-        tc = TCG_COND_LE;
-        ext_uns = false;
-        break;
-    case 7:  /* > */
-        tc = TCG_COND_GT;
-        ext_uns = false;
-        break;
-
-    case 14: /* OD */
-    case 15: /* EV */
-        return do_cond(ctx, cf, d, res, NULL, NULL);
-
     default:
         g_assert_not_reached();
     }
-
-    if (!d) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-
-        if (ext_uns) {
-            tcg_gen_ext32u_i64(tmp, res);
-        } else {
-            tcg_gen_ext32s_i64(tmp, res);
-        }
-        return cond_make_ti(tc, tmp, 0);
+    if (cf & 1) {
+        tc = tcg_invert_cond(tc);
     }
-    return cond_make_vi(tc, res, 0);
+    return cond_make_vi(tc, res, imm);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
-- 
2.34.1


