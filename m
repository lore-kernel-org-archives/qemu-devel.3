Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE1C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KKN-00014y-Ry; Tue, 01 Sep 2026 04:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1KKM-00014f-Pl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:58:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1KKL-00086F-0n
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:58:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495590dde14so44543325e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788253123; x=1788857923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QjL6aszT4A625HOpxmtGGfwHdsIznga6XTb4LEnmQWA=;
 b=PGY6nyVW75IhCEV/qLTonA7rOzFJPKaQJbsq7kNb7w/uB4RD3aHHfwfjjevlJRRP8k
 e9ywiyiIdlCW1b+FD8+fCF8jfyS8QuVQIO8/8KAacqXjESAx0WzXfLeYhmsdihERJ7fM
 8vHTdORGWkx4h1LC6QHk5876+4qi9WFjLZnlj9ZsQBhoYDGdGq39TOLlJCR8j32xGM8J
 TKjSGLsW526KrOT4SXwzfpYJ/fedItCrkbexIeRIqlDYrNd5vl8pOsBZWCAVup87jmiz
 tH7LB6JZhPx8JhoneqCgA56rqtB7YVHgsGYziGkAYWN9+K/zSJfFar6ERBUdXriircdo
 nBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253123; x=1788857923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QjL6aszT4A625HOpxmtGGfwHdsIznga6XTb4LEnmQWA=;
 b=ip3dINVmikh6y9DufVeYWjvpd3AA9+OCMEFkuDciuZLQdfdfuirpUg5S3x+CZ+1s7i
 lhQr400b2qVr4Y1hivRd82l4i1YvxTJk9qc+CT3S8vItxPpkWkydFlLkTGF8h21Rgxpb
 A4Z/tKeg+yXb/dRFxsZl3xS14S6693+c+T21IGyRrdwui4R3QUTMCraEMH6kBOGiBNzo
 gYmGsvUnlNADUCdopBfapLUHhqEcT/FAiJ7jBs8xck9akujiMWTcmvZ13Qqw3iTEwJqe
 uZCqq4/94nSxQfdc4jkdE5cTxz1jlnq9czPpxIvDihtVnB3OmnVteGWkwUscNHiCT63z
 lGUA==
X-Gm-Message-State: AFuF++mxgkKUHIYUI7HxlecOjHAP5RZ70C7Pv3hFsdw8BX0JtJ0+PHep
 lxJ8y3ul/Lgsvr2x2sf9I+ljwlPyQX6VLp9qYILK6UAjASai/ZwFAQXLeJGqQa+hMqw=
X-Gm-Gg: AR+sD11c9ug2XTwWlEGZQ+FS4kqcAfbiDFAch+Zc7gDn3EumWIZa6wphlIkb1g7+wfz
 qXir2qjd0BMtoIIdvZDiVic2vtU1bh4RqeJewJSB87ftnm7+L83XdnegFixZOYqMDgOERwIfnmz
 31pVqDWz28RPHDStDVBhlPsgNNCLRNAAbso0ajx7mIE0fQMl4L3+HkzAasXzkoBjo5e9w/53bBh
 49oMgsAe2P0GSRat11DskQrReqKNqUBNs+DxvljoC1+BgnD317JPNg7h4rT/U4biZCgPg9TPP8o
 JDKxp9B8nfLClbuKHU35ReKWrTwSaXtbJcwI2MUNb37Ny6NUliE+G8X27Z3mLkE6tWl2cK4pfPb
 lW6pgPbc7spSB6fX9k06EH3FGeEmqw4EKigIZnhMFkuJdz/eekPYT9DPCX8FLXuVhjJ+rst2Of1
 nKSmeIjNJGVhB35JliFjtiVNYmlhSh8ywznJKo+ju3vDUxgVWFa3rdwrPVdbItkDs+hF09k9Jsf
 fAeL73b3iamPZ3mcAxKXew+3IsXqS2CW26q5P+ONfq3xi5yrhHAhGn01VEs3tf+DBgNloCJE+A/
 c3fqeVF5iuaeRbEQMRAEvus4Yc8yVlc=
X-Received: by 2002:a05:600c:3492:b0:49b:909e:922e with SMTP id
 5b1f17b1804b1-49cdc4523d5mr128880325e9.10.1788253122984; 
 Tue, 01 Sep 2026 01:58:42 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9269f1b6sm255573305e9.4.2026.09.01.01.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:58:41 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Update FPU tag word for FXTRACT's old ST(0)
Date: Tue,  1 Sep 2026 10:58:39 +0200
Message-ID: <20260901085839.138094-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

FXTRACT writes two registers: the old ST(0) gets the exponent (it
becomes ST(1) after the push), and the new ST(0) gets the
significand. Both should end up marked valid in the FPU tag word.

helper_fxtract() only marks the new one valid, via fpush(). The old
ST(0) just keeps whatever tag it had before the instruction, even
though it was just written with the exponent. So if it happened to
be tagged empty beforehand, it is still (wrongly) tagged empty
afterwards.

Add a fpush_fxtract() helper that does the usual fpush() and also
marks the old ST(0) (now ST(1)) valid, and use it in place of plain
fpush() at all previous call sites in helper_fxtract().

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4395
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..c17ab7282b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1805,6 +1805,13 @@ void helper_fpatan(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
+/* fpush() only validates the new top. FXTRACT also needs ST(1) validated. */
+static inline void fpush_fxtract(CPUX86State *env)
+{
+    fpush(env);
+    env->fptags[(env->fpstt + 1) & 7] = 0;
+}
+
 void helper_fxtract(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
@@ -1816,22 +1823,22 @@ void helper_fxtract(CPUX86State *env)
         /* Easy way to generate -inf and raising division by 0 exception */
         ST0 = floatx80_div(floatx80_chs(floatx80_one), floatx80_zero,
                            &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = temp.d;
     } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_any_nan(ST0)) {
         if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
         ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
@@ -1847,7 +1854,7 @@ void helper_fxtract(CPUX86State *env)
         }
         /* DP exponent bias */
         ST0 = int32_to_floatx80(expdif, &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         BIASEXPONENT(temp);
         ST0 = temp.d;
     }
-- 
2.53.0


