Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CA6C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXl-00071L-OK; Sat, 25 Jan 2025 12:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXN-0006SM-B9
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXJ-0000Ny-VH
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so35237635e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824492; x=1738429292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJfpeIGSlIY2S2DSWTPOeODntCTV2idscj4/VsOkESE=;
 b=RutOTLh0DLQbhpzYUyhEN5Lb7Tv+DgtEGwJTX7fw/jVQ0ASnm+z9ZyEfItl/ncJFxt
 nhgZXUAjkSPnA4bGRL9lEjlZ3E5ZhmEP7G9U2TYhuvqYsIQyPd3RuH3EyNFkago9fpB3
 l2BPEw4YCAVlldS1jxyM70U3JITshyVxXk7DYUd+cMe0/OLqVLaMevVeh11maoNlqM4V
 DeNaJ86LGaHh4ZY3hhKw4oFOu2TwlQtf5YL4lgj8XkbdhT9vy6WGRRNCzW5ApT+5N5My
 UXqBuBAxHJ91igtWqZL64MQPYf4WeAaIGRfnNsW1n23I9jKMnC4QUhF2DZZsnAt427t7
 6znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824492; x=1738429292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJfpeIGSlIY2S2DSWTPOeODntCTV2idscj4/VsOkESE=;
 b=m5u5RZkGSBw47eXGChQ0+GsP21RvC5hyaVoB+/jAvAL9yw51BZrSXXzH4Rbm0Go7xP
 pmIKYrqEuvYlnp/zygPUmdFGwpU28PKdF/ebXjf1aRXPOM9Gx6yll1lQycUSPnVmwzTS
 6eerS7PAqvEa8St2cvnHJxDq34Z8CZXX2BvrGIU5w306hs7w1vphVANA7J51VUPB7yOi
 SKd0kRZVfNjy9ZczaH5oZVX7S4PU5FwELcCeD/gQ5fISAomZ3byN5R5GIXPMS7WKOTHQ
 pcM5hCODwf9eKBt46UjsOyHESHn1DVy/M25qW9tj+q2wBgM/SCSX14K0r56vpAU8czyI
 dpJA==
X-Gm-Message-State: AOJu0YxAxRnYo82f9QhdbVYFcRDHzXZOnW0yN/bWVIXIWUR7iNfRtkjB
 wdy9rJbh8FAtiQczd2D48UJUA1eDKL/Cu1GJEJ8iJBFY7/Fu3PRMr0pqKx1r/kpaq8bU6CsUIdq
 otcs=
X-Gm-Gg: ASbGnctZI8eHmljM8qaX4UTWalljbzbw3SjxnHp9cGkx3+c5xmNTpAK6Jpg3gRE6trq
 G91C9wRog//vvqVrJtXHpxnztl+IjZ833QfJauy/mUhF0HJkeVHNlzRtPpR/GKjmrslsEt+OHPl
 8ssZK+9+Uau4diA+6t5mekXH7BrqcZv19jlTA+dZp0Lgm1jyXO075ZVK9sWY86icQQSgj20XJlB
 KqxeD4pzRLk0inEVG1WDsJw9g29qeIxGb0Rukfe0lwtb54faS+SYwkINGNfgj8vFR+4fIbmW2P1
 rsbO92evM75xnkCUDLZv2KHo3KJMTWg+V7QkN+TuFOtb5RN9Lbvyc98=
X-Google-Smtp-Source: AGHT+IEfZJDGMx6G0H3MwsVALGREhLxo5cSNDsxjeFy5MWU+eTJw2nySolKWIiDgGNRIM59db6gZEw==
X-Received: by 2002:a5d:6d02:0:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38bf56555a0mr33108088f8f.10.1737824491984; 
 Sat, 25 Jan 2025 09:01:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176449sm6084870f8f.11.2025.01.25.09.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/24] cpus: Restrict cpu_has_work() to system emulation
Date: Sat, 25 Jan 2025 18:01:02 +0100
Message-ID: <20250125170125.32855-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This method is not used on user emulation, because there
is always work to do there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2402706c7d9..e094d54949d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -748,6 +748,20 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
+/**
+ * cpu_has_work:
+ * @cpu: The vCPU to check.
+ *
+ * Checks whether the CPU has work to do.
+ *
+ * Returns: %true if the CPU has work, %false otherwise.
+ */
+static inline bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 #endif /* CONFIG_USER_ONLY */
 
 /**
@@ -814,20 +828,6 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
-/**
- * cpu_has_work:
- * @cpu: The vCPU to check.
- *
- * Checks whether the CPU has work to do.
- *
- * Returns: %true if the CPU has work, %false otherwise.
- */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
-
 /**
  * qemu_cpu_is_self:
  * @cpu: The vCPU to check against.
-- 
2.47.1


