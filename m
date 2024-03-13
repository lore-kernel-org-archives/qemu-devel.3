Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663DC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWFS-0002cr-O0; Wed, 13 Mar 2024 17:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFR-0002c6-0E
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFO-0007tU-KN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4132a5b38fbso2086485e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365689; x=1710970489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uu686tnG06TpkmPsbRE86bvugnt/Usf4psLcD+gc/E=;
 b=AxGAq4QMy5A/QgWF6JL6N7f6QdupQaZLQLmubj5JeXIupiTEq5RLWn5Ff6EmnDLSWH
 M8ZfAOBPk7puhI4zX0y2qnhy1FDXfn1QMbXHnsfxLK47k7fnz88svlMn/Fsg5sqQUzzq
 axBQfzpskT/4nn6WcC909jP/CX3DxdXCBI3hBKCXhMDWq6wpEHh6Cnx7CxKgX+4Jb7cX
 VhCrVdaOO5z7WH6mW5IIAAGH0OKlmTv7jP8/p2DkSDGcWSDK/5ItyCnGIN7WMdSKYO0n
 eVgxvk9as43UpE8NaCFAtJ8wr6DIFt8lMx0TWtFqVX/LjCvxcS4ELM3ZErJHcFKXhDBX
 43aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365689; x=1710970489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uu686tnG06TpkmPsbRE86bvugnt/Usf4psLcD+gc/E=;
 b=XyE53FnlPG2Eygr7uExSxWsOCXsSD4LSNtHKnSpGLvOMDgjdiQbw0lCOd5oXSDLUIE
 B7PTGxwJqzvnZglQ6vatdu28C7qdZrg/zVntcAjmD+bUM+X8GrIMhFOtj0mfki1UnYoT
 +cHl0rR+EyTGMKEZx/f4IW/tW4EWXLp/MEasNrhKUHQJwG90M/4GzwM8EIwzqHt2vq8p
 I/cVkVsbPqmKKbw6tG8P+ZCDOiU589T2kGJmN6howK5lRGYcFUnQ0vU+QGY4vV0Rmr+E
 kNb7feYmzCWE/f7ltf6j7QcC8MXHnmKjiyPn8PK6M16c/iPiovaYlqA7ElqOjU/o84mu
 dQ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXESPyyxYal/YLsV6qHNQX69kOpxiSDtA3z8MjXtQKM7l+lIHuggX8zIuZo/uoXcwP78cGLRynJ29Syh5bQz5dfDWQA6XY=
X-Gm-Message-State: AOJu0YyfT1kpLOVof+n5F38WcX44vTlRIVgF/As44QAIUU839/Ri3/QW
 Q6SkIN+8nA/vpMuBj1iKplYQnkiQBPoHu/3+aAzg29/B1khlzrgcZ7AqqBC/tmo=
X-Google-Smtp-Source: AGHT+IGiuF+Aa5rKZPPtadT+fLXgv7qzCfe5ZTRT4axz5tB3YN85/HvxM3f+BnzLn75/HGTqUIgB0w==
X-Received: by 2002:a5d:4c51:0:b0:33e:bf71:3665 with SMTP id
 n17-20020a5d4c51000000b0033ebf713665mr1085514wrt.8.1710365689065; 
 Wed, 13 Mar 2024 14:34:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adff04e000000b0033e239040d8sm63824wro.84.2024.03.13.14.34.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 10/12] exec/cpu-defs: Restrict SOFTMMU specific
 definitions to accel/tcg/
Date: Wed, 13 Mar 2024 22:33:37 +0100
Message-ID: <20240313213339.82071-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

CPU_TLB_foo definitions are specific to SoftMMU and
only used in accel/tcg/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 26 ++++++++++++++++++++++++++
 include/exec/cpu-defs.h     | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index b22b29c461..9b5cc9168b 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -12,6 +12,32 @@
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
 
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  ifdef TARGET_PAGE_BITS_VARY
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  else
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  endif
+# endif
+
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
+
 /*
  * Access to the various translations structures need to be serialised
  * via locks for consistency.  In user-mode emulation access to the
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 3915438b83..955cbefe81 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -54,30 +54,4 @@
 
 #include "exec/target_long.h"
 
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
-#define CPU_TLB_DYN_MIN_BITS 6
-#define CPU_TLB_DYN_DEFAULT_BITS 8
-
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
-#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
-
 #endif
-- 
2.41.0


