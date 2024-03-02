Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE694C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjO-0002Nr-47; Sat, 02 Mar 2024 00:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjI-0002Ky-Oz
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:12 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjD-0007TY-Hv
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:12 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a11b231ec5so88016eaf.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356566; x=1709961366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRnj6RNj8pIhlV8KrPPZGUlyyYXlw3LRarbXZSGYsp4=;
 b=HMbPzgFSIyGDcQMGjNljL1OAUP/ZoyXpHuCYIFGNKGhINQKg0mY+sChvJ5+wOGty38
 8O+kQrNUe3PjPjqU0fM5syRHI05gcZuvnNNlaxvuwuGNRGrxIK9K/0rcak0JnKkfpUOe
 My2rOGlJQCK6ny0CYX7v5B8OZbZu2xZyVzJpYmfWtoBpKfHN2LwwMQO2Qud465M8qkgT
 cV5moJ5uYUswpaAuMNxT2B09Xvn6dXAAzL0eRV2XZt75dSM9HK09jE23ySBBy/uoRoNJ
 QCsYe7y6HZTIA/WTrJSMmmDNQypz92pxl2uHR2/GKnny0G+pMNRCgAsS5rmur/wS8tSQ
 aqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356566; x=1709961366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRnj6RNj8pIhlV8KrPPZGUlyyYXlw3LRarbXZSGYsp4=;
 b=WgElo3L+E95obFtZj1fGcjEpd+SU4OinURYfUvNN09VynQ4eN3KbMHPwmpAE0GkUq8
 o/PEs3LY9d96yCOD4mGPtn1QNLCmnzP5YZfA/eFLFcKjfKb0WdP4r/rSifwZc8hHVaxl
 kuX3Y8NbZQrP/K+O9toOkPADpyFMZxp93ztMm2BIMshC8eAfOi14SyNbV1F95DaKJEgG
 Lm4zHQh7upEL2D011ThIazlkf48e7u7OaULZ2mK033QfWKQCc1ni/N2N48//xTJcTZqk
 DPPMMPaL+/0gusebKk4EXxnVERRL0XkvL+hIwpWuJOUkxOjTpthNt4SodJE/L0jM1dpV
 47xQ==
X-Gm-Message-State: AOJu0YxHC4JhsONKDscfjxwuaeJV2nbN6V5WxjoyX/ZQrOUHFs2TpiXo
 JWDTsSHmdsUJyMS/1fYsGFObTRf74pWJd9pLb5CDKuc4HlvpxcOuRQsfDEofIq5msMc4rlgxne+
 E
X-Google-Smtp-Source: AGHT+IHxB8qJTgkR1n3xTaSeCWbd3NgFsmmVRurqrsMYraR6VBvdlrI042hUVnVSI6rPLlGz64RPjQ==
X-Received: by 2002:a05:6808:1789:b0:3c1:b170:7e0a with SMTP id
 bg9-20020a056808178900b003c1b1707e0amr4634496oib.38.1709356566029; 
 Fri, 01 Mar 2024 21:16:06 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 01/41] linux-user/sparc: Add more hwcap bits for sparc64
Date: Fri,  1 Mar 2024 19:15:21 -1000
Message-Id: <20240302051601.53649-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Supply HWCAP_SPARC_V8PLUS, HWCAP_SPARC_MUL32, HWCAP_SPARC_DIV32,
HWCAP_SPARC_POPC, HWCAP_SPARC_FSMULD, HWCAP_SPARC_VIS, HWCAP_SPARC_VIS2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 48 +++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8eef893d0..6041270f1c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -963,24 +963,44 @@ const char *elf_hwcap2_str(uint32_t bit)
 #endif /* TARGET_ARM */
 
 #ifdef TARGET_SPARC
-#ifdef TARGET_SPARC64
 
-#define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
-                    | HWCAP_SPARC_MULDIV | HWCAP_SPARC_V9)
-#ifndef TARGET_ABI32
-#define elf_check_arch(x) ( (x) == EM_SPARCV9 || (x) == EM_SPARC32PLUS )
+#ifndef TARGET_SPARC64
+# define ELF_CLASS  ELFCLASS32
+# define ELF_ARCH   EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS  ELFCLASS32
+# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
-#define elf_check_arch(x) ( (x) == EM_SPARC32PLUS || (x) == EM_SPARC )
+# define ELF_CLASS  ELFCLASS64
+# define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_SPARCV9
-#else
-#define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
-                    | HWCAP_SPARC_MULDIV)
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_SPARC
-#endif /* TARGET_SPARC64 */
+#include "elf.h"
+
+#define ELF_HWCAP get_elf_hwcap()
+
+static uint32_t get_elf_hwcap(void)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(thread_cpu);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+#endif
+
+    return r;
+}
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.34.1


