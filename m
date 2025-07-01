Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8C7C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDI-0002wn-6w; Tue, 01 Jul 2025 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDF-0002sQ-AH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcD7-00076P-QP
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45310223677so24227185e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381026; x=1751985826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=ibTulCYvsEMS/qTtlv6oNrnQhfvC1v78JqWTcI3thYJctbP+7vX0woysuc2sQHLtvn
 0ErOa6YIYq653CB4Fijpn2S1Gkm4YGqK/SmETZhsjQjlJMwk9MawOCaQ98Tan22Wof7c
 y41IijoxBXPm9qeINkpqT6A5vUAfTEEK0Duyr1vEauvuWczU/gzXqNbYzoX9vMTLqZPn
 EO0DYHHsDSbq8XlXBzbL41kIP0Lzv8w7Jjs2WZ5odjkRUvwM6j8iEhTnuk03O390X79w
 wEWFAi5AbNSvQh1s7OIisdhkpoQON5hyca0CWhl1RQeaw4r/M5Ci89DiESv33415nXch
 dncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381026; x=1751985826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=tPaKird0+5wHlIcIn6708itNAipJs4uWTkd/8Utd+u1lB13QkKPD9NB/oZQT5djlPW
 nEnNCICHz2xLEqcxR7RYPUN9KyK0uaiKKTNAyDBv3GNKDURQCPsIBwfYooLKvlxvQ6gO
 rfSsfuRpJrl6+p4nwOj1C+tPputynTRhdJ8APmUyT5CIT5PIXzPQLfQ0pb4334bD9/3m
 nW40ur6NtiIPuWE6ZQkBv/TkeLxJ0zPkzWA4sQbJnLKY/ji5puW88CPHA715W03WFD+f
 ebTJ2b34slrams5HsMFLjKLzEtBHqjnePnxKNJ8LKxx8vu29iZ+cpCAjzv9OBTa0awZO
 M/hA==
X-Gm-Message-State: AOJu0YyJZmMmsXGuVkbG4SiVfOAglemvpoTUjdFuxz+1TFi1lVnNJ6Ve
 hG/pRTDUQS/ZHqTs0/yLjEr+g9N+xV7qjGpEhenUvQjZBpcr6QcFkEDrp7kJWrNWApoGJVwKthk
 c5/Ei
X-Gm-Gg: ASbGncuVyuPxFMYjqQ2FwPTxzyRLCHCR3QOiDu10UyAZotINSzlB980WFTWlXe0yQQC
 SZSQ5M6TuqJ6AK6HZy6wxxe74Ia44u2aKusjEbKQuRfdM7RXDy6cSNiYnM3HmE5vVMbTlRDfUZM
 GLuanoHxKr8xhvXfU9a9GAL94WKp22tmIowmHGPeZbhIs0onn3+6Lc5qUYKGJsZ320k1MnDUe8e
 JCyEG/xs4C2QMaKn+0UMGGx6J9v0Yr6VYAX4ClnjX7lP5lzMUKKbp2XfyTGoi88KBa/7OhIJlrz
 K/DsP3dUQSK9e+xOhj/YOUDVUCCim+2YsCPkm5h65J87vHk3/H9toHMIgqkKR7/IkeZCoJdZJQW
 FVILb5yR2Inh+6GDd9FzKgow9iKQ09NSXgcxH
X-Google-Smtp-Source: AGHT+IFMkAtJvlPraumzpgR1tLTRb8JUOcf54OxbA7yF2dh0kjB4emNmlqf/6vD1uL189gLrzDBNrw==
X-Received: by 2002:a05:600c:1e87:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-453900db0f6mr162058525e9.18.1751381025591; 
 Tue, 01 Jul 2025 07:43:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a306a01sm177036505e9.0.2025.07.01.07.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 39/68] accel/nvmm: Expose nvmm_enabled() to common code
Date: Tue,  1 Jul 2025 16:39:47 +0200
Message-ID: <20250701144017.43487-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Currently nvmm_enabled() is restricted to target-specific code.
By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/nvmm.h       | 23 ++++++++++++-----------
 accel/stubs/nvmm-stub.c     | 12 ++++++++++++
 target/i386/nvmm/nvmm-all.c |  6 ------
 accel/stubs/meson.build     |  1 +
 4 files changed, 25 insertions(+), 17 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c

diff --git a/include/system/nvmm.h b/include/system/nvmm.h
index 6971ddb3a5a..7390def9adb 100644
--- a/include/system/nvmm.h
+++ b/include/system/nvmm.h
@@ -13,17 +13,18 @@
 #define QEMU_NVMM_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_NVMM
-
-int nvmm_enabled(void);
-
-#else /* CONFIG_NVMM */
-
-#define nvmm_enabled() (0)
-
-#endif /* CONFIG_NVMM */
-
+# ifdef CONFIG_NVMM
+#  define CONFIG_NVMM_IS_POSSIBLE
+# endif /* !CONFIG_NVMM */
+#else
+# define CONFIG_NVMM_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_NVMM_IS_POSSIBLE
+extern bool nvmm_allowed;
+#define nvmm_enabled() (nvmm_allowed)
+#else /* !CONFIG_NVMM_IS_POSSIBLE */
+#define nvmm_enabled() 0
+#endif /* !CONFIG_NVMM_IS_POSSIBLE */
+
 #endif /* QEMU_NVMM_H */
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 00000000000..cc58114ceb3
--- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,12 @@
+/*
+ * NVMM stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool nvmm_allowed;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f521c36dc53..a392d3fc232 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1192,12 +1192,6 @@ nvmm_accel_init(AccelState *as, MachineState *ms)
     return 0;
 }
 
-int
-nvmm_enabled(void)
-{
-    return nvmm_allowed;
-}
-
 static void
 nvmm_accel_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 8ca1a4529e2..4c34287215f 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,5 +3,6 @@ system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


