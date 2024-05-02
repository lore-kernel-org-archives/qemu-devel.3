Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1941BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Zis-0001Az-BP; Thu, 02 May 2024 12:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zia-0000uB-U2
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiY-0005vD-65
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so4474541b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668930; x=1715273730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgzvSrD01ShseB2w23SZ5Lugpibg8re+4HHYOhUXpgk=;
 b=nMKwkHNUmt2Gj+/l2gNvzY4+Ls6pPx8dF5JMf4lUTtgSwqkP4WfUbirotWD5dXkUOd
 e1xOjZ8HFeNkOyxAUlFwdfbMteqAcjMWSQnzhnVCAkUOVcztMsuafpXjZxx3gJY47sM4
 AGZZhLOvyRBTilBFZHTkNRqkjsQQ6LVYIe7U2bBw4OexZae5qXVitUbK2lu2aBhxy2C3
 pHhf2x04Mg0acZZFD3JRHvhnOwT0Yfaauh8+a/cq0b15K7SO2kL5EUeNAR666qnymZzJ
 8mrRmT9lF3Wfe88ZJHa0cr0hzSXT9TNhUEyrdnHvqJDEm8JPvuZ+Buc/sUKkXWQ4Q3K4
 p7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668930; x=1715273730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgzvSrD01ShseB2w23SZ5Lugpibg8re+4HHYOhUXpgk=;
 b=K+wJKfiokr5I51fdpskERCHyw044jtu8Z/1SEDaTYaOkZWoqb5u8nQ1XiLoUoP4z9W
 O4VOUXVtwPhRxxoZDHWIXoleMoZNJ6xs2ddXAWoHjWHlYo6GPbjVb1pnsThXQH1uL8wP
 O682D0jb7uXwCg0JFnolqLNM+4iUKAoX18pCLGiBqjEulBcxkeJ4g3xw1UThrq9onZHp
 +gZnf63MR2bAOnks4AFY/kq2C3Hrsx4mWSN5FbQINSADLBUU6kr0jnFs8jSUgkgBz2/7
 8IF3+ZsJmWBOdXfKhVFhy/yyJM1YE1m2FfaNF9Z/voqsKZmIjigHssPT/0ZEfwFGK76u
 n/Xw==
X-Gm-Message-State: AOJu0Yx5KfTDTAtwwiz6VZwWar2zatYUeERT1pkojnZs5YzWShKk2njf
 x1+Q0USWimXhobtpjpDL8H4oynLLEZVqDbsvKBCek6rosbD+LHcmWy7LHs6Uz1k/5u1meaZRPDh
 z
X-Google-Smtp-Source: AGHT+IHBOhz5P/T9biC1d8ykEnnNEY2blGNKJ4QWvyht606rPSXX4wpZUNHc/GV22C1rcafBnoC0uw==
X-Received: by 2002:a05:6a21:2d8a:b0:1a7:4944:d49 with SMTP id
 ty10-20020a056a212d8a00b001a749440d49mr409898pzb.0.1714668930627; 
 Thu, 02 May 2024 09:55:30 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 1/7] linux-user/sparc: Add more hwcap bits for sparc64
Date: Thu,  2 May 2024 09:55:22 -0700
Message-Id: <20240502165528.244004-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Supply HWCAP_SPARC_V8PLUS, HWCAP_SPARC_MUL32, HWCAP_SPARC_DIV32,
HWCAP_SPARC_POPC, HWCAP_SPARC_FSMULD, HWCAP_SPARC_VIS, HWCAP_SPARC_VIS2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 48 +++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f9461d2844..14f08b64a1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -968,24 +968,44 @@ const char *elf_hwcap2_str(uint32_t bit)
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


