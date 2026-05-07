Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F06CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72I-0000rr-Bk; Thu, 07 May 2026 18:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72G-0000qm-7A
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:36 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72E-0003E1-AU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:35 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40ede943bf0so1070424fac.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192253; x=1778797053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6mhxD7cbQ/YZv44JJy0FmHUyr5nrKMnYo0KO5fHYf+A=;
 b=jEm1CDW+k0NCN/Zx4K7xp7a7GGaiuth1ByyQvOOeLIQ0n2qivpAf+kj1xWTZxfDdYo
 IBJmQImwr9W/tt/isUgOhtyhBv920jIHsGwdLSUn97uJQ4HN3j52W6e9rpKq6kaRCsRa
 9N8CGVoBnsfPFtW4eX7U3iYAcjKM5aUU8gRcaZb3CuN3hHsLAsrhUhFBaB3uq1dQCmxo
 ecL6RWCNFgugy3ENVk29Uuo2bMJDMSmge7UqvIyrXUSoOH7JxMBEhfAo6yjtvAfN15QH
 iZLwa9nl8PoUF/IhPGpgCRmhkuHn92KIPyIfWF3zqB9YARHopVoG68Nx/hUoO0Nje0nK
 ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192253; x=1778797053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6mhxD7cbQ/YZv44JJy0FmHUyr5nrKMnYo0KO5fHYf+A=;
 b=a5GyiF5TcNB+hOdCpEJWzZU2BVE+H4U43nrnf3FmgsISrnhqy9zQJE5d9Na9swh8LE
 4zvP6at2bJ13ffQqaQYE//OyfTh/j4M6Whvx0sVrOCJ2Y6C2qjh/IZZ5DPIN11rzz1nA
 QGnbOciAfy0DalYAVcl0P0ulMy3HTnSsl5H0t+V2CjYpM0CQebBzFakZCQ99K21aPZtY
 KdQLbRsH1C8ByX246tIUkEGIsWw7zksmfqjcdaU7pRLS+upvUtMXgHkac5Ai0NgvcAHg
 p5Fr5oq8tP6XATPSRF5ynfj45k2bVVDdc+zdKnd4E/uq3mxwy0b/S7amVxxQ0Ii4tNEE
 bYyg==
X-Gm-Message-State: AOJu0Yx0Dq2VJowl14GsrtqvLAB9jXxqo4JyNfXlDMG0o1g5r5pJwEOD
 2z+ZNXh3t++C9xtw/zC40tfIq2r19fr71iFzwbCL/SHVXs8eXGw7kiv59xv+bmPjsqhHfZ6DpMq
 2uCeW
X-Gm-Gg: AeBDies/vRvr6w9KtL+Md1Z5yhLn5cXmbCCcleomFAX+sdXTuTfW2u1vW8XQy4+1jGD
 DTAS8jGejAHcBNbil7UvmrbuDsB4vOZ3cpWxLd5daeLr5VvyR2XBrIEKEIlv1+sT5OByETy8kNt
 MxfVldNGYdO4v6pDb1laD54vMwqfHKp7WyzqslzKpMRprjt8cU2hajwV4FhRMYwXVCyoQLLSFIv
 LO4B/+0RRd6mMF93uK/ZrdnTvPq2n5tRkY/H6rk5jjo2MIvySqghzgqbTDSJkRLphfm/evnP6Z9
 ammyFQ9lkF8eql5jz6Oh2BcDBFpLLzti0gHyWkS0Ah4Y+3m0txuRfbwXEr18e4PPRf1kyWHOexo
 xRY+P6R0QLONKfJWsLHHFxKCIUpo0DQmgyNQg5BcVTAL1/crUf3I1CLNw4urTf7l3ElDRzCPG+p
 VSCEc8Oaa4sd25Byq0A+tHc9/8x5CpWxa6cYwe44nN9c8dcQ==
X-Received: by 2002:a05:687c:20e7:b0:42f:ca4a:e7ab with SMTP id
 586e51a60fabf-434f65fcea6mr6931479fac.37.1778192253030; 
 Thu, 07 May 2026 15:17:33 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] fpu: Use get_float_infzeronan_rule in
 partsN_pick_nan_muladd
Date: Thu,  7 May 2026 17:17:09 -0500
Message-ID: <20260507221717.486023-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Deduplicate the uses to a local variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1d8a98358c..38b317c1a7 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -122,14 +122,14 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
+    FloatInfZeroNaNRule izn_rule = get_float_infzeronan_rule(s);
     const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    if (infzero &&
-        !(s->float_infzeronan_rule & float_infzeronan_suppress_invalid)) {
+    if (infzero && !(izn_rule & float_infzeronan_suppress_invalid)) {
         /* This is (0 * inf) + NaN or (inf * 0) + NaN */
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
@@ -147,7 +147,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
          * Inf * 0 + NaN -- some implementations return the
          * default NaN here, and some return the input NaN.
          */
-        switch (s->float_infzeronan_rule & ~float_infzeronan_suppress_invalid) {
+        switch (izn_rule & ~float_infzeronan_suppress_invalid) {
         case float_infzeronan_dnan_never:
             break;
         case float_infzeronan_dnan_always:
-- 
2.43.0


