Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1137BCFA445
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB88-0004YQ-4C; Thu, 20 Nov 2025 15:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB86-0004Xt-ES
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB84-0001RG-5c
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3c965ca9so777098f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669982; x=1764274782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgM8VF9g+T2JoeRRqaHzTf5tHPKfcxDzwnP0zHhd7Bo=;
 b=Et8HJeew06gSVDI7/EsDaH9b1j1vj+8XOxYcE8MyD/jLfdIF7ShB6piEr5NVJyG0rM
 NnPTnsFrNheVgJgY0DrGksNuFnUi27dr8KU2S5J2d5OkAgtwC/QUL28CoaM0SSNCoL3h
 KiDbDAeUAlQOUn7w49g3HMFwEAVEMjkTnKuscgaFIXhbPFIZ+i7/8BiocaVbaZRMh1HB
 YALQ75sawRk7RUQKktL8BVoAspZa6uzv4uxZgzh1RHUj0h34FYvO5HEFhuKEZxPDkcnN
 KhYYwe0nDAyQWM7U1nkOQvJyn8KKIOJ5knTaihnOx+7AtWDHkdNfyqgffIL+itUI5EJu
 m3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669982; x=1764274782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TgM8VF9g+T2JoeRRqaHzTf5tHPKfcxDzwnP0zHhd7Bo=;
 b=SuKGLKPAphzP2xKVLQPeLy0CXMn8Ynj9TwHO0X5nS1JTzxZpxZU4m8WVD625Rwiprj
 u3IxXKwzm4LJFPHUAoI5yO46uV3JTsIxg+5Mt0Om7ErPdwnJuGd6dWfvBstrneWznANH
 uPAaoRL+FkILHGImQOLz3xWxs73rT9uRz5Yk5sMhNa+W3gPDKRhDgqPH6tB+xqK6vaqc
 3Gb6sZOx9VX3gvV6gi/E8nGBqfI/r31mZ5L1wXK7JUBBCnXym7dFwacBHMPu+G4h1Yap
 4qRgBz9cfgRx1sCBxFShuc11SbVyz88/7yNsE2qnfOijWE3MP4RZSDBQzeFODc5MOMNr
 UTvg==
X-Gm-Message-State: AOJu0Yy19tiakgCbCCX3ZvCfpVZqgDu0RdvJAqVWmgYrYyRJKfQ+wHPp
 O9i+rWXUdVRXq85eTXbrGiYDhsZxZtF8CmhTgshA7bE6bLL0orRF/TIYWk1ijyNrJ1ZrmEGqvsv
 UNXutYssEdw==
X-Gm-Gg: ASbGncvEUZNHRWZjLwoeZZgHEPcFgVvBQNyKjOR+hdcKL5eSrnJu5qXd/9AHyr1dw4r
 wmkaQl28VCxlsMcT/uEWLDaeoBfq4R/0sDTxV+b4mH2MXjJyOMHBrul83R03MXg6XbJkXCu6fLm
 SuO54su7T0eTS8M73bQhnFNOA2jD3UJpMAZC5aYpledTSIoRi5k6ZLLUNhH2trmd4Lwtc6qeC5P
 +ltwo2s9cx8RCwgw8DCq6YnkN/ZM6tlU3OdqiJFK0c0WQmZ3c9oalHQaN8wDPz5oXHYWxsMEFaN
 l/juptda4I5jD742se4OpmoJyUinL7pQlFM8BUoK0Vro/CjRL1KoTqGhnkCn2dm/bXf4wURX/c7
 4UtVUqMghGuW3VRKJh+MXxs65VEH3lYpGdB/IB9W9Xj34KpTpkbreuaNt1klVJm99NdAFSEiQQz
 s1BDmEKpjNNxCx9w1eBxN8SenvsoiqopHGfgisUqSFOlioTbttcf0NtIxud4vpz8PjvGwJsNY=
X-Google-Smtp-Source: AGHT+IHeQt7nOtHNrNBLPV3dyibgn2d5l0naI92JVpwMvmrJGAKvB20gEWFS7fExesgLjRBaVSAczg==
X-Received: by 2002:a05:6000:3103:b0:427:854:770 with SMTP id
 ffacd0b85a97d-42cbb2aa28fmr3674997f8f.43.1763669981715; 
 Thu, 20 Nov 2025 12:19:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9061sm7123714f8f.41.2025.11.20.12.19.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 3/8] target/loongarch: Use little-endian
 variant of cpu_ldl_code()
Date: Thu, 20 Nov 2025 21:19:14 +0100
Message-ID: <20251120201919.8460-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

LoongArch instructions are always stored in little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9d..3f4b5f9258e 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,7 +140,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+        env->CSR_BADI = cpu_ldl_le_code(env, env->pc);
     }
 
     /* Save PLV and IE */
-- 
2.51.0


