Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDDEC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P1C-0005k7-1p; Thu, 17 Apr 2025 09:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0g-0005Xu-Q5
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0d-0007w2-Kh
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so544983f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895425; x=1745500225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXZTsvplbDk/j8Hq5OCc8Z4OLE0QxnnIYztC0n6Y2e8=;
 b=fHpY5MwLdE931IqqQvYrR+Fre+zvKqtHg5fQjnq8INE62vA79rBMYg63bVtpzt1Z7d
 gCmXnCldGy+0AEgA5EudAY1LuEE19f++4nCnF+uDH/e0d2tQUngSmJTMLOk68K6w+YNL
 Zcg4Z629XjN4Xnbkbj47/pHn4wIHDacXgx+a88tCxXsPB3EzM+sbigHfZXA/6i320rfh
 6XTq8NL990D70MZ7UhX+rAPbkM+rPLtFgfXNw/Zh+ESD2WbsxW/52a4LJJCGthlLie31
 /atZprsR9VcqjSM5NvbQy3ydRGvGiu/B4Zmwe5AQAub2aYTtJsasKYIbOD96sjfPAf4x
 Z2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895425; x=1745500225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXZTsvplbDk/j8Hq5OCc8Z4OLE0QxnnIYztC0n6Y2e8=;
 b=F3FnpyqD08szY2Suw0TGoYgo31bwmoyZW8BAKzvn0WdYAmYgygZx+kCfkazoGimzV8
 d6+++xh8IK0hvotmUKQSVdgBjnmmVKR9HGnmLMlZ/Squ1xZJks4+r8+roi2xzbEfpajg
 qHwXYFt/0qGU7w58WVpESzgBwRSGFB+cjOPK+ll0lFP4TrlvPEzT6LxvqljJEQFEHMDE
 UKehL8g7pSZrlGnOww17xxEMG6H+dfiTtIAOdLWFWdNCFh8stEz8tkjRbh0t1DG4tKgz
 kzCsm7tCJNQlp+LTuQ9jcMOQ66RzXkStXI6NRwSTooqumdnsiHBVnqlm1jJrNa38JO+A
 JGBQ==
X-Gm-Message-State: AOJu0YzJWNylPAC8EiHWo8qj3dDiP5/BoziN3uFxJUKuhEcnfVtzRDIi
 wOzCJXOrpLmO5kuWaD7tJ83n4xR6a2U2OoYy/qddBzer1RdqyXRUlkW+lrX140IegWdHV4MNgic
 s
X-Gm-Gg: ASbGncs9opRa2fFosCl2UieaGUsAsHBdK5BIo75vk0J/hXpXowOqAsrQnixqZgvixqr
 Bq14MtG6lJNQfPkkTQdQx+bIVUvs8dDLiAN6yCGW3nWlb4xIXjToXINiU09vzytdaFcKGkefnRP
 zPjd//Xk0XvIiTuGBZjWg0HWIAItX6DZjdsnbBR6px0qjzJe8eHmoK31dMY8Fq+m42c4aXoQkTx
 GCEB7ah2+jSog3mVSVuy6sHFApel8P+29llnRDsQNbem7M034nyCrHXJ80fuNN7Td/65H+3E6fi
 yb28ctDIpYn9NtiUqXLrLDC3FSTG5rd9YWvrDCUX0QRzpTkq+ZGl0xSCBT0hy7B07XJZz3z6aPU
 th81whPup+cfZG7I=
X-Google-Smtp-Source: AGHT+IEBo1UY+AOQjFpXVhJW8TDLLMkzTWfvqwX4eO97AJYDZrdTS5N3fuEGqSHZ/wLBUnAjVJfNew==
X-Received: by 2002:a5d:64e2:0:b0:39d:724f:a8a0 with SMTP id
 ffacd0b85a97d-39ee5ba03e4mr4945023f8f.58.1744895424613; 
 Thu, 17 Apr 2025 06:10:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b50b897sm53357105e9.26.2025.04.17.06.10.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] target/ppc: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Thu, 17 Apr 2025 15:10:00 +0200
Message-ID: <20250417131004.47205-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c   | 12 ++++++------
 target/ppc/mem_helper.c |  6 +-----
 target/ppc/translate.c  |  6 +-----
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 077991ed535..bbab411a07c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7262,14 +7262,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 #if defined(TARGET_PPC64)
     msr |= (target_ulong)1 << MSR_TM; /* Transactional memory */
 #endif
-#if !TARGET_BIG_ENDIAN
-    msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
-    if (!((env->msr_mask >> MSR_LE) & 1)) {
-        fprintf(stderr, "Selected CPU does not support little-endian.\n");
-        exit(1);
+    if (!TARGET_BIG_ENDIAN) {
+        msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
+        if (!((env->msr_mask >> MSR_LE) & 1)) {
+            fprintf(stderr, "Selected CPU does not support little-endian.\n");
+            exit(1);
+        }
     }
 #endif
-#endif
 
 #if defined(TARGET_PPC64)
     if (mmu_is_64bit(env->mmu_model)) {
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index d7e8d678f4b..cc3ed29a35b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -32,11 +32,7 @@
 
 static inline bool needs_byteswap(const CPUPPCState *env)
 {
-#if TARGET_BIG_ENDIAN
-  return FIELD_EX64(env->msr, MSR, LE);
-#else
-  return !FIELD_EX64(env->msr, MSR, LE);
-#endif
+  return TARGET_BIG_ENDIAN ^ FIELD_EX64(env->msr, MSR, LE);
 }
 
 /*****************************************************************************/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 399107d319a..828b850b40e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -213,11 +213,7 @@ struct DisasContext {
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
-#if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
-#else
-     return !ctx->le_mode;
-#endif
+     return TARGET_BIG_ENDIAN ^ ctx->le_mode;
 }
 
 /* True when active word size < size of target_long.  */
-- 
2.47.1


