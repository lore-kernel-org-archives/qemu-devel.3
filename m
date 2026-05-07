Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45061CD37AF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SB-000849-H4; Thu, 07 May 2026 19:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S1-0007U7-2u
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:17 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ry-0002Ay-4c
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:16 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbd23bc684so909721a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197691; x=1778802491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuGasVrTDp5bV7ix67mPvlZpXL4SBKk180Og/sZBgEE=;
 b=Uh1dPXSS5M77rtXVaCs93QYqmWYBnx6QfD53DZAEOCPP8MHmV1l5Ico19VTOOQcmIF
 4qjy+4SAeFJanN3uoW3sXztqf5M0ydUJinAxpYX8gwgQWwwAT+8cXPC9IZ/fzB9KaCMZ
 hqg+090l2IJE6nHGtN3MqBp1/d/XNLxndK+upeyr36lZpgxCeNsoHw7F7sC2hbxtSIVX
 aUeJK/sKYBp3+oYXsZrTgrPmxihFX/jp6JzXPJ1gJ4wKX31sgD5UP+Rb4780/u+p93K/
 VLaiuizcnr6NNL/hrfPQpetrgAwayECuMaJCDI3Q+N16PJbVSOmSJzCESFMPvLqOJz3J
 RScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197691; x=1778802491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PuGasVrTDp5bV7ix67mPvlZpXL4SBKk180Og/sZBgEE=;
 b=DSZuBWYKDXq+vzNWvH5RDBv5260xP90cJtoLlKzZrqydmZbATW2LBcPZLB/B0w8gc3
 CwJR3BB0tsLoNWZYvNtjPEqnPnvJucacM0bUtUEjcYeqRgs4Sc9COIpKMlZMx3YAVkk3
 mcgasF1HfsO9t6j2knv8wH/a9B6/eNeNdF9ClA1KZ0VLREzi64Mz56XgKosWIO2s+cCn
 6kuB9nlONiLW3nuLq1k5of5ajgWGvTjJivwu7XXFxkBiTji9tJfoKxc/sYmBS1Lt9BNO
 R2om8vfkyD7RfcApHHgy+T/c7dIEiJJoAUKqcFQnhNi9aAJMrbeHmyAPuQeEn4ZwHlWw
 Q/+A==
X-Gm-Message-State: AOJu0YwoeUb5pDcFhEdEVd9i50v5tDErTYS/19Uot2Cjm12cp0EOd6EH
 17/IO830baU1D3RWqmYX8MA9NqJJDg1dCDIxbR8R1/G7xYGhAXhvWyVezTmpmrH7z4aBxZAGNis
 mj6eY
X-Gm-Gg: AeBDietS2Y2Mtu9V32mEZKRelTxItKePoqrf2alvcgcb99QTXjuU2hOJ4AQsrDwqwwX
 VxooCW2jfrvCQV1urRwaUtbXWZRfQayeZw7HPf1GoDqrc2oBHfgv7H0Cic42Zr3qH4c9mNlwmxr
 Xnl6I722QEJeKl7wdbahuS9p8nFCTBTN31yez633aZ+uiLqF61j84f3IYU5tRKtszRlbYTzfkLh
 iFoJvO02eQjPhTQApD9QSxbEkuU9b+vlDWoLsXKUSjduJwNPet2XMM25KwTdNmANEO1duLFBoep
 tAZ8KJbHcSX2LHhiQFJJ9Tmae8ThOgZ0oPT1SM6c8bENn1HQq1O8XOyjFiO9JJgxZ7pQMkYEoU7
 oKtNojSXwfPltp3PLfMDHwJTSvzZaw7KRxYnGmdeuQaISmXpD8m2EqgTjC7vVhhp7s4yLmO+BOS
 qrEBAb9x65ACqmVpdjWmHInRkfcLheZqnomGAgICVMwju/ug==
X-Received: by 2002:a05:6820:4c0e:b0:694:a362:e3ba with SMTP id
 006d021491bc7-69998d32a61mr5811684eaf.48.1778197691382; 
 Thu, 07 May 2026 16:48:11 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 57/60] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Thu,  7 May 2026 18:44:10 -0500
Message-ID: <20260507234413.643512-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a43b6367a4..7a47af9f5a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 875716d18f..83967da12d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
-- 
2.43.0


