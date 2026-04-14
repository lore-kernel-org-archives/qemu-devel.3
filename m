Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FE1F531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCS31-0000qP-3x; Mon, 13 Apr 2026 20:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2z-0000mu-B8
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2x-0000Mk-NO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so35115905e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776128070; x=1776732870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F79bcmNqJ6yqiKlKQkLmTaYUIpS0CTWwYfLuBfn6U+s=;
 b=DEykiC/AANMUaUHUEm6+ZprLZsLlojcv0y58sRULq0KTglJTKRh84uVz1UHgsCDtCh
 fxDyZ+Kv2XWjb5Nrn5m6fsmbVAzZinxRauXPgxEYC0OxYn9BcTf3Ez0o9J5xmE/jBHeW
 Ru0zm4Gtdn1jas+Yg7JKIYx8fHOJ2N4IJioKVCaPZE/Dc63zToN8l6qYIwBYjFMMjrm7
 GxdtBuQLWWvU1hYG7adJ2zTkbsnnrjBIIKN/QRpH+etcIRC4geudapQfCEZxr4mIXMMy
 lMIzLGUfzfmsbOQay6Hb+IfaTru1n0FZkOLnRcMI644X7rpSHxV3xSGTAeLfI3DMonAS
 tUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776128070; x=1776732870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F79bcmNqJ6yqiKlKQkLmTaYUIpS0CTWwYfLuBfn6U+s=;
 b=F/HA5iUarl5pJR/o1m5gsxvU1T2qG0rWV0zTJCdhP3QcS7GYllZhFydV1KYQvtsyys
 3PYccMCNhkQk7F8jpTwEe66uF5NRs86+p/YWlsKokGU4HntrP9qGi+Qp/0CcyIdB+iSq
 VTO/fnCdlfF6en/AsQ9xGUPXz0WpXEpie3fZ87aA5HRIJOUTmiYvhP77RIm4R+bfcg1D
 6m2+JWyV/tsx1z4EIwA+vPKd3ZWsz9Sgmy9v31Qwkx4iU1HERliqMytMUPt2O2EL0O8+
 L097eTEB79jgRnZJAMbXQsLxB4aXv6WGtgXm0yXiOYC3fJnt/3CVm1VOGD0bbts7AZZy
 tqWg==
X-Gm-Message-State: AOJu0YxG90azJ8whBt7V9FQr1eShxxANbjDkkdz5+vLnQr9wQuPVcbfl
 xAAHffKJJLksek17WUiuyH7y6pfrp4zjrH93bUBCYotufLk8zK1pbltQeKP64mlZVaE2NDA1Vi/
 dwWC1gnw=
X-Gm-Gg: AeBDieuJ/0iU72tD8i0c+Bq/kt6pMBy3/wUlIqNkES18fs/CtpXU2V62PdOOrnHpsk4
 pVe3g/oMylwlI5raqAoAC2uOhA1/pXpkEPSLhwjqoG7ESFqQwxblLRbPTmFlMhdN+0WVpt1KlAh
 TRxV4EBHS5/Te1zIoaslXEuNlvJCaanmTpeMADZu8QtFb89ahypM9IqoL6Tn9gbc4vEggFZVJTt
 Ly4Jhb3QnhkeHWbG1gowGB+yrJ+qoHQTcTie+lvzXJ2Z4yjI/5r6T5a206/fh1SJ7/1+ZCwwCIf
 42UcPX0FJQhaRbUR/CEzJdexg/XnpYt1dAWvxQRSA8TKxHH7QVjqsuGb5kn68/fYS7Frb5oP8mp
 /q+O/fWL7UxP3xZFGlJpWF6WqCOrAcSi3mt490S3NTTZfwDQgoecMTp+n9QIeTTdI7/WC4og1uD
 9uXZqYAk9ZsRScGNJVS4N0u0Mb4XHxS0RNjsksMQyj8Dodur92eBLrotrng+JFcjnbSHOfvfyA
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id
 5b1f17b1804b1-488d67f39admr153474105e9.11.1776128069624; 
 Mon, 13 Apr 2026 17:54:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681edd2sm112070635e9.18.2026.04.13.17.54.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:54:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/9] target/arm: Introduce mo_endian() helper
Date: Tue, 14 Apr 2026 02:53:44 +0200
Message-ID: <20260414005348.4767-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414005348.4767-1-philmd@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h      | 6 ++++++
 target/arm/tcg/mve_helper.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e92a967f575..e65014af1a7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -28,6 +28,7 @@
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
+#include "exec/memop.h"
 #include "accel/tcg/tb-cpu-state.h"
 #include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -46,6 +47,11 @@
 #define BANK_HYP    6
 #define BANK_MON    7
 
+static inline MemOp mo_endian(CPUARMState *env)
+{
+    return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
+}
+
 static inline int arm_env_mmu_index(CPUARMState *env)
 {
     return EX_TBFLAG_ANY(env->hflags, MMUIDX);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 4bea0991de9..a5a23c97056 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -299,7 +299,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
-- 
2.53.0


