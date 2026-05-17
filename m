Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E70CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPT9-00036b-A3; Sat, 16 May 2026 20:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSJ-0007B7-TH
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:12 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSF-0006tO-26
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:06 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so795629a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978042; x=1779582842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa3HEHnmujGMzO7KfPn4oNwAR87TmXmXSZa7aCzJKgA=;
 b=W1/tAeE4c5y4HzheFwKIJwayffdMWPWLD5C3cybF0cINmIYnZWewXQHMNKfv+7s6qM
 7cT+U7cKLC3aus3yRrKqrujFYogdshMbQBXERNOweqDDn3tlIc4iaPNLsbqfiFM2O1HI
 55tkKtgm8ZS+65PkRrLsvMP3WG4QJeie34dh+upDgvI6v3NhASQ6jzsraH13XFczlcW0
 na99JEbkGT920ub+GZwOlUgobcHZT9IVfjA9DNJxZNzv/59VUZbdNYO9730XiAxwHKsF
 2MvadSicZ9Cdfl8hH8zpH+5QU2GwnEJhnfDpOga3P8GhKULWfw1QoOYXmwCp51PiZFSu
 JiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978042; x=1779582842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oa3HEHnmujGMzO7KfPn4oNwAR87TmXmXSZa7aCzJKgA=;
 b=jMh4bZQsFFO76AE8vuaX5s2vl9rEpG7rV/7u/dnsCDojzHRpXlVi4vYy03S5lCuATX
 aJMM+EljlXRjESoBYqu8+fKPC3Aceh5MFKVImP6lG/f8ceowAIyJ4PkYvV8nebcXAQjy
 I2niJBXh+z+j5Q2AkhAKoRW+5/c6pj7rw0rBsvdVINsd1CMg4gvRLkfMFqCpW/88HBQK
 cx3KzclOvbB2dWThssGmwegT9EdcQ3dWMA0w7QMXcMQbBToBuFRL2baQAw7u3gfuCe22
 yg5XQv2b41mXTCxMZdI2DaZhrpjBLwCZOddpGESTECBmfCCmOcP1umJFM3hD/jFlp9Wy
 gCVw==
X-Gm-Message-State: AOJu0Yz6DCaOQZHBe0RyODW++JsoCcH7mon9mxznVQobUwsRFYplNmmW
 jRWcco4tw/kNm+v0mUo+v2GRexl8G5cmaLJtgnYIARHWL9fP5PItqifXZxRg4DeQRPIY8g840Z8
 BZCUY
X-Gm-Gg: Acq92OE/FJBt3mW8tFO5JG+GWBjnmffFue1vwl+sBmr2/fMAe0dZsgbL4Zlhjby91kG
 G7TwkZ8FPma68927gdfuK+8/eI1s5grZlr4BmNzs5nKUXh9bI9M2WLpOnQljmfrtj6xinkOL0ps
 Y15CS/cfx/kVDQRRfXmEVLWvzZ826ZRyL42GBF9GDCfmpZhk3VqrOtQsxh9q2tdMx8gAnEgYZP5
 liXia2WUnAjapJLNflfgp2NapgxCqvZKSQ5gwNYPu0fTw0GBSrGfz7ZTXWbcM3wHeWovu1bBevd
 vMOLyjMq4uqE4uOIDHnZ9x/N3d03C8jEDGpp2dXQqKEDIRcyCwGfuOctz2KGfl0deHdjaNLahvR
 UOspzP0+dB1kdkxzKtVlmft82lAoG1r5mB5NNMaxCiFC0ncMppaKFNnt1arDPVZ/vQHjjAiGz4E
 gzBGLyWDNY/XuktLOXtEqqQwLNs3KxTpcSB69A99o=
X-Received: by 2002:a05:6a20:7294:b0:398:9d5f:e093 with SMTP id
 adf61e73a8af0-3b22e75954bmr10779513637.19.1778978041677; 
 Sat, 16 May 2026 17:34:01 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:34:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 61/63] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Sat, 16 May 2026 17:30:00 -0700
Message-ID: <20260517003002.321430-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
index 7a47af9f5a..492f70fc8d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 83967da12d..2580246a1d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


