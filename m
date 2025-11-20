Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89F9CF9C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wR-0006t4-IL; Thu, 20 Nov 2025 12:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wP-0006sv-HO
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wN-0006zJ-SP
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso9058055e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661570; x=1764266370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xCot8ZMuJc0WEaRNHsFDH1bHxjKgiQSQ4OxE/tzY4Q=;
 b=vDNbNG4LgaVgbGWIfc9Ifg60U1JfRU5L3r522bpBKnIJOPRa+uGD8UH7zbz3urlwjn
 ava+Y+MuyvR+yzxY9TFJ1sc+7XtMX48ZG4vu+UBPmNEi09j6tgUdjZN/fbMK/RHEXM6J
 V5ry3jBPzdwGS4h9Y2esPVZVtM1edySoUBjRL2/kxIoLnyJVr4pgjbw5KTuvT6CDP9xz
 yBOtsbTaIhTV4smcBKOjdQlUT7sISk7XjNNZInk/p1lIj/vDwLMmTwxaAb+ZCCOoN/aL
 kWV/Z7ca76VDGWI6vywmGKYFEB4FWULZxN3ftj3B21rVRI33dnd+iJud4BZq0vSQ4/DL
 eLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661570; x=1764266370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6xCot8ZMuJc0WEaRNHsFDH1bHxjKgiQSQ4OxE/tzY4Q=;
 b=j+4WvlfVIKsxCVmJfsbJcUa/nW5PZu1ASgAVbJf7C13MNBPPkF5S67+/j1yfPwX7Oi
 qKg+tL2dyD0k1p/zFh5CIeHLvISbwA2u2Sj6Yy/JPF0PwCmkInmARW5DelWsUt9+Uh6R
 zfPzTOE5dYswxL44jO5AqYKSCJ/4XUtw6iNjur88wNTqVcxpgC0NgPnGoGT5H7tc+Qk3
 25PJn+V/6tB9zN6eozKZ9ju2lwGBQkWRVSqb8ijPNOkPsFH555+B9xF9aj7iNqwqy8rk
 NAdY6/sXv619FbtuGUXjnKzboRHgs0VSAFgggxxfqwsWHfCO8RhkXVq0KiHmQMY3ul+A
 1jEA==
X-Gm-Message-State: AOJu0YxdvGTXYpKdcgzGIiRssTQmcAkTgmZTPRw+1n6Y78Eie7tHz60D
 r1BrqwyZyzq4iIZnlfyTEQ/okuoXLSovwVPQ8duw48Cn31SvGu4EXlw2FEEEmWzEKMWjoffcump
 t4JLQuRX9ug==
X-Gm-Gg: ASbGncvCRK79f3NWt5lLYq5/Z5OZ/4wRiZ4TSKoYujF31g9RVh81zLyfNgnKQSS33vw
 h22PBd5oI8rt8GDect0iK3uvYqoiIvnTSrlhi6BPCYCP8cORz/KpjWmqkgwX5GWB23b7NILU/P9
 pscD/7rCLlyg+JYxc7wDHtMDIXTPgxyRRTpEC4T/44RGCUawrP6qFRzH8IjwqYVseBmUXo01eIX
 FV6V+r5+qzFwfP7WwIW362SH7ZZTXX7NaKt58hl5767y+LaRclzZiPSoFm5QJ/quBrbWUP2tXqI
 BqEwdZMd4GyY+tayCsx5dgwpDTV4Cm5G6o8otWogeoQ6PFgn4uOQCGYux4rfPKk88R6dcXM1ivG
 67pe6He86bCxRgR9Hn5A9CaibikxGN3lBOysp0IzzxYheS/ywAPHCKr9x/V4o/CdhWOrhJYTRFA
 y7mrU1rKrh0fM1diqiNU6bqLPyHupnqVF6ZPvg448HhDgoUBaezMOJSBz7dbVY
X-Google-Smtp-Source: AGHT+IHLLUx5/6Oa23hi3//qdiSaXxGavPp/kaQEF2RaMd0ncVuffdHM3wR6a7WMbAj6Cb11K40grw==
X-Received: by 2002:a05:600c:19ce:b0:477:9650:3184 with SMTP id
 5b1f17b1804b1-477bf0dd4bamr4098095e9.2.1763661569716; 
 Thu, 20 Nov 2025 09:59:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4eb2sm990765e9.12.2025.11.20.09.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 2/5] target/alpha: Use little-endian variant of
 cpu_ldl_code()
Date: Thu, 20 Nov 2025 18:59:11 +0100
Message-ID: <20251120175914.6515-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
References: <20251120175914.6515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Alpha is always little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..d04d086b59d 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -30,7 +30,7 @@ static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retadd
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_le_code(env, pc);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.51.0


