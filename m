Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B3C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgc-0006WT-6D; Fri, 24 Jan 2025 11:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZY-00064N-7J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-00063D-Lh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso15879665e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736211; x=1738341011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KQPKoJ5OpJcpnmKsSmz59ndMFucnaB6ozSHh4Jfa8B8=;
 b=RI/oDXFYI9yyKJH/o8R26TgPNZYSTgHU8z7ohuxWtcCEhnrIjJ/4diW8qAbZrVGy2g
 xXGZzdz+xY1e2s5ILhFNXb9tEwT8asiyASAsXzNqmi5rDxOioLDWqrOjfS50LOICK0/V
 V89TlgHRVfxssIWlg7ynNnH1ftFOsz27LvvSEYo4F5Xw0cBCY1rbeKewrIJeJsKgYowd
 dQMtGp/2CQ0fCDT89PalPyYPaAL6qFUgyBezKFU57KCJlcXPlCQENqq3hA8PJDp8JuME
 B6sWWsdG31t1s1rmowa+QgysflH91MZdhq+ctsL9xxR65mQci6EmtfC5+lVxJRcVGakR
 Z0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736211; x=1738341011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQPKoJ5OpJcpnmKsSmz59ndMFucnaB6ozSHh4Jfa8B8=;
 b=EzILVDbN3Ztgex+ol/cvbfy+JRntLYPWxAQrN2ifXsl5qk++LMzFpFuVxbLkDkRTcw
 TQOHMnM1CY4uH3taBTLEDRdzcQaF6aadXccjIcqa/zKplRz6MLJOwkVUgiD1j9NJVAlZ
 9toRbYuXmB+mtZdFEzCuFqkJkPU9HpUraM/jEwwv9cHKxQRtLOH9TG3DtkDGsOJuHEfA
 DbS+e0pJsczy9M55XjMkbYPR9I5aIYChS5mosBxGP99Z1mm/ErsrOoJkk4WciRCm8MrS
 DhM87gRLHRSAhRv5xBq0PWi9vrhAHG9+waM3rgCEohj6mVQ0YOw9MqV+p3gDsL4AhG79
 bRJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4sEGJjqit/snLR0b3edaJosXqhX8JcuqiyfGz2MfybBTw7qb4MAMwLD4XuOdTdl8bwuNPBgKb1Bop@nongnu.org
X-Gm-Message-State: AOJu0YwXtAFx0Hl7S3lBvC03/wWPsPkE8dIe8BygD01ftxhv4b+i7Yd3
 I0toyBEsq8GFWpAIqYNUdsTuBgSdSwqZnka3KJ8ZitxpZD/GA8188U0p9mtIGfB7ZTN52tX38/y
 t
X-Gm-Gg: ASbGncsKPkWOuAiL/V/vwbuQ2OvGB6Q1hFVpVxrNZUwZY5+xISpsbWQM2ccwWlLu+WB
 lSoWIWD5YiU12s4eaccWHZ3h4ocInnBYH4WjOUKH1NbIQmoUsWK9niIZcoDVOo28v8Ay0UH09gm
 ST10loZQtn5P4+Hk6pjxTu4zQ3dxKhblHTgWtgGHNtcLjYG6HThWp6lQTL7k6I7cH5q4jaomIya
 vEAgZJFqC+tbXdlgTXO6EtKFUhA/B4/KtdsbppOWsLoBwzWGFL1+rz/+TCE/Jx7JHBzN06IWx6I
 NejnOqR1EL0=
X-Google-Smtp-Source: AGHT+IFAi2mRuJC1E6tGQXmlIHoFQUjEIFMIRAjS9DVjflKfOK2xqQNHJq5nk8ooH9Uqg6Ii4h/uXA==
X-Received: by 2002:a05:600c:3585:b0:434:f297:8e85 with SMTP id
 5b1f17b1804b1-438913d5da1mr330585925e9.10.1737736211271; 
 Fri, 24 Jan 2025 08:30:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 73/76] target/i386: Detect flush-to-zero after rounding
Date: Fri, 24 Jan 2025 16:28:33 +0000
Message-Id: <20250124162836.2332150-74-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
flush outputs to zero when we detect underflow, which is after
rounding.  Set the detect_ftz flag accordingly.

This allows us to enable the test in fma.c which checks this
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 8 ++++----
 tests/tcg/x86_64/fma.c       | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 9bf23fdd0f6..5c233fdf5b4 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -189,13 +189,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
     set_float_default_nan_pattern(0b11000000, &env->mmx_status);
     set_float_default_nan_pattern(0b11000000, &env->sse_status);
     /*
-     * TODO: x86 does flush-to-zero detection after rounding (the SDM
+     * x86 does flush-to-zero detection after rounding (the SDM
      * section 10.2.3.3 on the FTZ bit of MXCSR says that we flush
      * when we detect underflow, which x86 does after rounding).
      */
-    set_float_detect_ftz(detect_ftz_before_rounding, &env->fp_status);
-    set_float_detect_ftz(detect_ftz_before_rounding, &env->mmx_status);
-    set_float_detect_ftz(detect_ftz_before_rounding, &env->sse_status);
+    set_float_detect_ftz(detect_ftz_after_rounding, &env->fp_status);
+    set_float_detect_ftz(detect_ftz_after_rounding, &env->mmx_status);
+    set_float_detect_ftz(detect_ftz_after_rounding, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 09c622ebc00..46f863005ed 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -79,14 +79,9 @@ static testdata tests[] = {
     /*
      * Flushing of denormal outputs to zero should also happen after
      * rounding, so setting FTZ should not affect the result or the flags.
-     * QEMU currently does not emulate this correctly because we do the
-     * flush-to-zero check before rounding, so we incorrectly produce a
-     * zero result and set Underflow as well as Precision.
      */
-#ifdef ENABLE_FAILING_TESTS
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
-#endif
 };
 
 int main(void)
-- 
2.34.1


