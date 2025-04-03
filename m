Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E43C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sgd-0000QL-2M; Thu, 03 Apr 2025 18:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sga-0000Gn-HP
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgY-0003ys-Rd
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso9928745e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717917; x=1744322717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9hjvUeWbVz+/CYEuU3h1CcQqcFWfFRSfQhQvW00JOQ=;
 b=B98AKiPKVm24ZJrn4Pgm++BkkXxHSQSamlDbL8t5ih69hvarkeZ/Oum3s02rg7fryU
 EYgvhhz2eXKy8x1tOYyJs/mArJRR9jBjWsoLjKU1hjiAx/fqPCPnZj+5h52eYqkdge/c
 aQroYmkWF9u7pfbBY8o0U/XuUzQSs6KuCDqOuu2K1T1vzVadYuGfvudoVW5SpLPOBJX9
 8esmmzVPc3Lgyj5Q9Su3NvJZyv5nx22DwotikFVhZtx2CldX2OMZoYFjncBS7e+wjScf
 p3/cHW+NuPf9HseMr1JZ8OhY8S8mzbjXczd6SjM9NIoTZZbTmIEa+wULyeiqvuGSLaN8
 NyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717917; x=1744322717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9hjvUeWbVz+/CYEuU3h1CcQqcFWfFRSfQhQvW00JOQ=;
 b=Ke3EUz1GSQIKQ2GTI6DIdwtMAsQEG/y9dNYmY+ATf3Ho9hwSiKRFMWwlVIkGku5dyM
 gW9zJrKteQE8FHJM4eRP+pS46GZxrPhixgvAKjCNHyBzBLyzBoOv2gPSP0CqEgZPIUuD
 rhV5Inls/pI1Y3wp92W15SZ4WNRyfWItGRn8dHVnZQZwFJCSGSkdG7qXNCf4UNNfg5Py
 NEHXrGOMAkYoNJ2o7tTIbax0XaQPWQJYZn/tKvDK6/k4vU2sJVvztIhQC5sYtgxF+5cV
 hPJIASh8WK+MAqKZY9DbBNUpAATrJ6qjf20rUfEOieev2B4KgLIDhjt/2nHxzdkNGvoo
 Mb+w==
X-Gm-Message-State: AOJu0YyFCCOoNOcupzlqXaN4yc/QYJ0KLX60Ks8XMQWbv6rYOCJLO+0h
 x9DU/DeW9j8df1aurOwrELOcC0hTY2vAFd3pTvMmgeyg52Ek3qP4cJHeQ/L7HaK7WaZ70oluA03
 z
X-Gm-Gg: ASbGncuSx7bYUChWUTj6QZjtxd/wCmgBrSj5C4k1IQm3eJTJy3Ngap7KNON4Xc7Cm1p
 WXQosE5PL5R9oGhNEQa+INZk0FDeNHza8I3nLM8FlAyuJo0vKIYhG+r4FZRs9u72AiPtTiJdNFq
 gy+XgNDVMFXOXEk+Ra3q1CWGn4wlCKEHezW4XXL5lKFKg+66S6cxLqXRxrfcjyj9F8dlIx0DbKs
 JqJylsJEmFQzpZXPiVd4jnSkVCLEhkHYpVVYxx9XGUP2qRoK9K9jW62I4H3QkuLGZmOtrpw8i84
 2V7XCUnv+F6eVzYzCYzMRj4nndLf/Uf1LdzhfckO7NQx049LD0qL2wTy/im5DHW6u9U9gioW+fR
 w6moSleB7ljmmlGMjH0KJa+Pn
X-Google-Smtp-Source: AGHT+IEZL0dZVEzKHPrsX1jEJkmQ6QTIw3uOLUo/w3bssSwpimc72WKm3ryUn6b/NYrPRKzEBuOaDA==
X-Received: by 2002:a05:600c:1f0c:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-43ecf85f4bamr6368125e9.9.1743717916825; 
 Thu, 03 Apr 2025 15:05:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0d06sm32774765e9.35.2025.04.03.15.05.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 11/19] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Fri,  4 Apr 2025 00:04:11 +0200
Message-ID: <20250403220420.78937-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7467255f6e4..c007b9a1902 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,7 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


