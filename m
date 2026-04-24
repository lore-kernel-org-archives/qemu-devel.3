Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA25AFB44A7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8HG-0004rh-UK; Fri, 24 Apr 2026 00:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Gs-0004QA-SU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:36:08 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Gr-0004ja-9d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:36:06 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so5594560fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005364; x=1777610164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9J0M1/wmYbZGkcej9gtpRX9Wg0EaMVJE7guK7SKevIs=;
 b=kED+mbiotN+MYwJOEUtiC6S6J93+XkUDESg+XYYJSti6gQxHEJbYaekC+iSZpRf8kb
 P/RTusA94kVLOP8+oLDmIrHp+nmcr5tglZEaT7zvSIHgNM2/chC18uN49SnpuKxofzcg
 Tvp/L/79hXAWrVOLpWXksQ986FdCBs7fBL9l1Nufc6iIy9KhOgxQrRlYgb648cSfYYJz
 4RRwBhmvfS6e0vhyBWCsktvvMh5XTpl4mvHF8oDNbAqwsXE7AJMv9slx1/G1eQ917bOp
 yDsgtWQmedl/p4gH+ujdUY1S1bLFXPtNYpvEmWbn5vykMREaRXg+ZkPDWS/N814s10NJ
 Ywrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005364; x=1777610164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9J0M1/wmYbZGkcej9gtpRX9Wg0EaMVJE7guK7SKevIs=;
 b=MGIcV5Y910eBMFHaEHloQoEq/hJZQaCCBdphLxxZoaf6MMU3a5jan6nfIDNmZmfsL3
 5Qnf/Gnb2jX6lwuDX/WACpzGaUd/8QND+4SAIrnX+a4oz9mnSk7iMcYxbiyhSuG2GXYN
 Wd38Hz4/NJ2NtdCPe6FF/aZ7MfxCZrmlzx9UqRmJknz38lOVSTG1shK4ymPTFBxkimGk
 UyWu+WOR/ruAj/7KRnYbxu5Ftrg5IC9impQnEClElhH6nE9wHGAPA+6yZKHnNQ0UwdQ8
 45Dz+Qn8Srd9ebRN+puWA8Nk2DSgSi8seXDS6Ar3f3jBgs+mkfbxV11QAO8f+6fxVYuq
 /ZKA==
X-Gm-Message-State: AOJu0Yz0W4G9bAV5tBKf8Owq2W5oX92DbdAWpSGb/z19PwBrpjTi1HLG
 QM5I4ot6KNo+apbZQBHJtbt7wDKmMS5booq9gJGLAfGdTOkt3JFLlmfuowkCFG8jxGCI0yHM5pl
 cBMLDbvU=
X-Gm-Gg: AeBDieuTIsBs6TEW7S8dz2Q5PmS1uJPLsfqes8nJ/wxUR9FRyfEdubSdjhGfGazzM9F
 X7YewkAOoqkB4L7ssz/eGPQRxMpA1K6tWbTwQ6hB1eRYMNhCTZ5cbjPUTmQpIgXBM1vtHbp0TGO
 e8NhBkmOgj7FOnWlQBkGZlpRub4sJo2OzoJ+TTyIxvpB2OzUKOVNuICYbjewEGVisf6g4x794b7
 ogI3x2iaAlidXl4CAPFr9lXoQfmhVK5KLMtRDWXx+8uAzWwgb5A9783UFNTOK0nWn6lKmIlHAdS
 B/vfXJmq/mMON+ES9eIZT+mkou1ceAn15KPOjlAU1ZU4i9s4kFJvq+qOGmztrjrGwNdxtANWVsJ
 zgCK0Tu/EeOlBHIRQDt9W4V/YNd1KId+AIfmNxxNB4QAkoj5WtOITOXw6lhLFpOzUVmr9a+7Rgg
 Puj54zw+flrow+NoyrhHdPnqYGlzJ0UPgtsaMia+P95K8wn787UMPS59bSLze78Q==
X-Received: by 2002:a05:6870:c8e:b0:42f:d5c1:dcc3 with SMTP id
 586e51a60fabf-42fd5c1eb6fmr5003092fac.19.1777005364053; 
 Thu, 23 Apr 2026 21:36:04 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm19473599fac.0.2026.04.23.21.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 40/40] target/arm: Enable FEAT_FP8 for -cpu max
Date: Fri, 24 Apr 2026 14:30:14 +1000
Message-ID: <20260424043014.46305-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9b974d6f52..4cd18f6686 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1381,6 +1381,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b38a188088..5d85bed528 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -72,6 +72,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


