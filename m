Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2681CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL727-0000oR-IS; Thu, 07 May 2026 18:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL725-0000ne-BA
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:25 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL723-00039c-Os
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:25 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47cacb4ed99so840419b6e.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192242; x=1778797042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h5saXKeJ4sC7voQ1+q7rH48NkObrAzcO/bR1XGYyQi0=;
 b=pbV0yZ2CHymXKAA5TPWtzfzlw8peTbox4tdqS1SVdjxZZkb5csKdDgr0b6y841LzkK
 S3y2DR+RHkx0l054sZ/CNiYgQraRV32OJIs1WnRYdjpDzgYU8WDo9Y2IGjJIolSLLA41
 Gl0L4ZWnWcIqbI9CgVL5Tp9RpqdHAzNFfG+qcBKKeYsnjwVL5QK9LCKlgcUl4laYWaBw
 kpvkm9x1wyCe1rCDPz/BzjswDQ7USGFRCzSDe8Lwp5ZhAVSlKgmGavJEewFH0ymGttMd
 FcJrpK9INKDS1B7CfqXxqg3RLumbC+0AxI0FO08ThIMD6zMihPj6IX2nl0EPpzFRujy+
 gnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192242; x=1778797042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h5saXKeJ4sC7voQ1+q7rH48NkObrAzcO/bR1XGYyQi0=;
 b=MiPAwLcy1gk5kY7Bv4w+GIZI0O1dZqEdDVWm/60gj63aWKPXIGhQ/cb0rnMT1jPB4P
 T4ch1ccYUOGjtbRgwhZUWUbGvuuWCuXnu9Y3QerHG66tPT04l1AS2AqmBN7dnVNGoCCy
 kd4pnZwnDDCsWXR96hjZZDdJZ1h/ocdxtfPs/bsSTPKalYJ/tl23LHBOgwgbZvVl2Yy6
 edJpjrPf0hy/9fIFcQYsVjyR2a0glFCXEqNPMibQCpYJ/LBqzvvTD5bmsNQ+0u4EXgQR
 Rz91sfsSMeFuUO3ONDFIPVyx2jNpFiAyCyK9VBPkUvPbgJrVZsMMzX9g8jVI/+U8913Y
 NOFQ==
X-Gm-Message-State: AOJu0YxaNBVdoyTPUq3PKqIu09Nr14MrDoSaEiSVsRZXbuomFP4QivPT
 0QP51s2lMHh85azGRBNtGP6iadZW5//8Ku+jK15zt80vr+zhm0T6P30y0BOh0CGxeTEyoFZmwfc
 KOzDM
X-Gm-Gg: AeBDiesF43DPMjjLX021zca/GnI4dWbv/aHpkJ/EI+GytSYLKsub+sjjb1Nu5fWGher
 NzZqtE29GIKzDmwwluTaHZjZ5mVnshryjNA9WbKsQS6C3jhZr53EcIpsqbEj6Vt9nv2s0u5l9M7
 LK9u/MTfcZJMjsucA3uWCrhEk9wq1k1IX5yCGymZSuMUtIpr+lTIPV8F7Y++vyJ/+1Ml/e0uOMC
 qUb4fWX1yemBT/GUs8NJWE0WVNmXGxwfgfCbDvXlrqbXoXf6zYIjGMBg+J9Z58r01VJkVwNxo2K
 QyzFI3OpEhRiWi1iz/FUSXZRdClrO75DdDP0b2oEvGlSf9ekrGyn5DmzFMmp1KHWu2m4mgQJmf6
 JmGWxXiYWnDY/QNAWOi5RyiAs9UpX/+PWEod7VunU3RwdVDReSs07PVCcT1IxV7G498tTtI+6Wp
 JKjsiUJI3EzJo4HPPTzknu7D9YYy3N987ysHnIjQ+2WlbgEQ==
X-Received: by 2002:a05:6808:1211:b0:467:eccb:b788 with SMTP id
 5614622812f47-480420bb57emr5278760b6e.9.1778192242470; 
 Thu, 07 May 2026 15:17:22 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/18] target/alpha: Use FloatExceptionFlags
Date: Thu,  7 May 2026 17:17:02 -0500
Message-ID: <20260507221717.486023-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Fixes a bug in which we were still using uint8_t.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/fpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 30f3c7fd18..9af77777da 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -40,7 +40,7 @@ void helper_setflushzero(CPUAlphaState *env, uint32_t val)
 
 static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
 {
-    uint8_t exc = get_float_exception_flags(&FP_STATUS);
+    FloatExceptionFlags exc = get_float_exception_flags(&FP_STATUS);
     uint32_t ret = 0;
 
     if (unlikely(exc)) {
@@ -455,7 +455,7 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
     float64 fa;
     int64_t ret;
     uint32_t exc = 0;
-    int flags;
+    FloatExceptionFlags flags;
 
     fa = t_to_float64(a);
     ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);
-- 
2.43.0


