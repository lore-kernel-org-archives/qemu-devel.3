Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36194C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOk-0007Av-NT; Tue, 06 May 2025 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOh-00075S-UR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOf-00014c-Op
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso36639595e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542148; x=1747146948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CH1Srr4JCmgTAhKtUcLKUjH9lbZ+smzDwHaNm7k7wPI=;
 b=b6gFz2X0Z7fOtvwLqepzYbnoBpAgTQaGi8s7TUf7+KbvskdxSEaHOQxDH8W3wUUJ4b
 SOhQJ5cBet2DqpkUeNYI3pAxbpfKeOVaZs86OUZLGUZaQbF9oDU9vJWnPRU3W7/kmRls
 lggVg1EWAGia1dbbM6wFd8Gc6HHZ8iwZH3yhDXHBl7ucX5T/BjUAk3Y7MsMNiIJ3IKyp
 7ZDceL0FGfulYzCuGOcBW5HVhD9Q6NmzJQAr8l53u/X1a/ae2cD9i6Hd7S6QkV0dGen/
 XF+8Tj1Dnn4rumfIpwORPy2wHSN9yryK3KkgtyphcOaA7hmDUM+PU8NVNoZ8TZWhZZ8Q
 iWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542148; x=1747146948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CH1Srr4JCmgTAhKtUcLKUjH9lbZ+smzDwHaNm7k7wPI=;
 b=IKItjMMN/FWyX2ouKg5FbE63I3/YbPN/NIfQsQ8DUaVrWomeS8uSJ09Fscm6z5X66D
 zBHuet8ZErtUikLhNqA5R8hO/0BWCr4igqUjYoBw9NgamOgiarjZ3IqBxZyKMxuPQ12I
 +A2Me69pjq3uaVgGvALktWQ/m+j3nGy8WCGY9iNDw6rqmmHuRpthTp07/nXlRxMwahwN
 4gwQSkmxAOebaAbDofZZNRiOiIfxyrQA8NIia+BOSgZop8M3bqvT3XpbS+ajAI7q14n9
 Y9c1I9pc7sgI0LVuFFclYxIC+ZClSeVcecrUwlINo82VaGarglRrIE3ZKUEKg7m5g4Y4
 6EFg==
X-Gm-Message-State: AOJu0Yxbnql32zeTaVa+GNUwzYHrzaZuPqV7COMaNeTfqErI759I1WYK
 WuiKd+SJt29GNnkNxS2IjX5sCCm5uSarfWR7aDseXsr/w2l4CxrYXBjWmTQW7uYnztOjHhP1ym5
 v
X-Gm-Gg: ASbGncsOnD4v052S2BTFpKwEE1II83vzzWx7bSZTq/6c9KQGUo3lTMHERjp+wmPxmJl
 dEfAFz/yjJbFKqJF9aIANJjH2X98QmO+RGOzk0jBsgjo54983c7CdxhA/JEugKUMoQv/pCeAFYB
 x1TFY8tktVfnZz9AfCxktHyWKRLfFFU8iiAlp4uxvCBf60BqaNPcn7QHljw1OQfMRJdtkUEyB2T
 NNL03e6X2GFlwlx4B+0apcHOQszy9RSECD+tfDOqLIYkwNzg7ke0n27qXpEbFsRHjIjYAgPCgjt
 Lbol3G5jwk20EhZ5VBpbTiPDAB6dZUN7qWhKgCDCsjlhDqvUOvoNq3w7tc/H9c6GMkiik0KvtdH
 9s49G3FQM09oBp7ptjxKO
X-Google-Smtp-Source: AGHT+IEgf2wkcvNyO34K9CNXtPXjYyB/UnFyY0pVmwIj6Tc0POLgdDX5toJI0mQ5g7pTPHdY7Cu2Xg==
X-Received: by 2002:a05:600c:3507:b0:43d:d06:3798 with SMTP id
 5b1f17b1804b1-441d0531294mr22404805e9.20.1746542147680; 
 Tue, 06 May 2025 07:35:47 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a2874asm170357015e9.26.2025.05.06.07.35.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/22] system/hvf: Expose hvf_enabled() to common code
Date: Tue,  6 May 2025 16:34:56 +0200
Message-ID: <20250506143512.4315-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Currently hvf_enabled() is restricted to target-specific code.
By defining CONFIG_HVF_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250403235821.9909-28-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS             |  1 +
 include/system/hvf.h    | 14 +++++++++-----
 accel/stubs/hvf-stub.c  | 12 ++++++++++++
 accel/stubs/meson.build |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 accel/stubs/hvf-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e748b6375ee..2f7fd460a4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -526,6 +526,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
+F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d50049e1a1a..7b45a2e1988 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif /* !CONFIG_HVF */
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif /* COMPILING_PER_TARGET */
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
new file mode 100644
index 00000000000..42eadc5ca92
--- /dev/null
+++ b/accel/stubs/hvf-stub.c
@@ -0,0 +1,12 @@
+/*
+ * HVF stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool hvf_allowed;
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 91a2d219258..8ca1a4529e2 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -2,5 +2,6 @@ system_stubs_ss = ss.source_set()
 system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.47.1


