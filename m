Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD355C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2M4-0003So-Ft; Wed, 17 Jul 2024 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2M2-0003Li-O9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2M1-0005eG-7O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso47289075e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213867; x=1721818667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U3x05a4v+4MAIH1ElGBtlNNkjkLnxPJovuCbksbMLE=;
 b=yF6Mi2mHwe+979jIUulF8Qdr9JvDLS6E6n/fqdbuLBpc3ZSTncwfjr4wjVk9D2uHYg
 XW1iZ2pW7T9UaXjL9fdKkRSu3PZfjge1hSHjZzRtTMUa7muXVOvg9oLaxwnHYOYCiasE
 Zz0u+IM1LlzFqCOSHBQHYx/oW3W48FM81kJF/PeKIIzCmwBX3Tq5HEBZ7BGelcJfKFqy
 rVnDR9WrC9G8R34Qk1dbXhLl6vqEBIIJZykG26E8mFdwz6NRzIlvri1pLczxzohN5DD5
 tM+72+jd99L3LjbKKWg33hcJYG6U+RR8Vf+hRtBFPaeu66BxahQFwJCIGpavqtbj3XSP
 Ul+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213867; x=1721818667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U3x05a4v+4MAIH1ElGBtlNNkjkLnxPJovuCbksbMLE=;
 b=a9qYUol0+i5Hf3STCaGr5YYeK+tfENDF6vd5I1nZz+UfMd6XtcgXO/vBwJVS8T+TD1
 /9tthOLwLwJvGTHwqLmj8gKHzPlSQ+ixz+uFqX3u/Vmd3jj2Yh8N2VhyXqi1huLsSwmH
 FSCjzQ5huPte8B6FBYxkuTGMXfi0l6L1hORvqHWEDi/AUFIl7uG9qs3uH1tH0S0FZf4m
 wMGlZQ0D6J85ylj4hQUQsvKx2Gqr4lYPmlBCScWeH8nXs39oGcy4irn0l+5mE4iXfaOS
 t4QLgJLUjRRJCbyWLSL+7urpSgGX/FtqEd+i1p84M/qA/ulmhpIUUUTCEuVqtLu8jBjk
 h1kQ==
X-Gm-Message-State: AOJu0YwshEpDdJlsC9Kboje4Z+4aLX/JX9Sr8f+KANdjf9TXwEUGDnv9
 qQWTzOtddQVuVlj9GBLDz/Z0rkvPQtFRafoUQrQoGYq4lrGDwk5sP9vF21Dh5H/ae7jBq4ZFbWv
 EwuulRA==
X-Google-Smtp-Source: AGHT+IHxngnjKg7fVWUFSr9kiakzmQEkrJNVV0j1ecEUfXo1D2P5XEiEJ/L1pSkAh+LaSK7WHkj6lg==
X-Received: by 2002:a05:600c:3b24:b0:426:5269:982e with SMTP id
 5b1f17b1804b1-427c2cc9861mr8336775e9.5.1721213867618; 
 Wed, 17 Jul 2024 03:57:47 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf3c8sm11269615f8f.34.2024.07.17.03.57.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/8] target/m68k: Restrict semihosting to TCG
Date: Wed, 17 Jul 2024 12:57:19 +0200
Message-ID: <20240717105723.58965-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the m68k target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 9eae71486f..23aae24ebe 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,3 +1,3 @@
 config M68K
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.41.0


