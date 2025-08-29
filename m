Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3A1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNib-0004Ud-Mw; Sat, 30 Aug 2025 11:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XZ-0003FG-6f
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:49 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XV-000326-Gf
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7722f2f2aa4so1413750b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506343; x=1757111143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsoQMsrVjyuGG6ZN+wMiGIbmgF1Jyx473twY5pZoe2U=;
 b=wC0lOI8HniL+/btzwQ+wShkrssion4eEhPkN+HvE9gmiYG2Alsovufa+UMWddWW96b
 ZEOkgy4tlWROFETdRueijxjdOg1BGtcNDuCuWRA1ML90C0aMmwXFTraJPSLB3mZJuZnf
 1PtATZt289kG9FeqAuAi8TdGxnU5PxAjQHM2BGNQvBBoXp/ca4gHAHQw27nSdRT8Zqho
 qHYqX3bm8pkAaiGD1klcBDk3eOXC4GagGSngOlfKDuXJ5PtV3KWLlwFYq7pfDFUg/pyi
 MZ+rIWuS5uZflxEptOmqslMB6WmttvzdDFKatEVvDtu3tUeeMxtEpJEo4VeF9LdhETZc
 fsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506343; x=1757111143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsoQMsrVjyuGG6ZN+wMiGIbmgF1Jyx473twY5pZoe2U=;
 b=aZCrg990ctiqNvZqcJkyDvRof7RcqREuvzj5XqDJt0i1tC51ZmA3Tw479eGiLUaoRj
 wf3Y1+gLVnzrEE4LhHxqy+Xys/fbf3sgUeRKTwx0igesvYFaBkMHlUdL2X2stoDtm/lg
 CUr2yvKgYnfe0BWOgLtOUC8bw4SzASff4v5brGNl9r96+822221xdNJU2BSZqwFGSu/4
 PhrxEJZgUE1sm0tkrSH769Xdex8ZvZSBMpCylWyNzga7ujaRSnoAUYv8VSvaAqGnB1dH
 j+C7m6lc7HEn2caz1W2MVdnlYmmdVeYeaR8EuQhWrm8jzCbKb/uqIQpfdWs3PgB/mGTW
 D1ng==
X-Gm-Message-State: AOJu0Yx5fRGfQPIvijm/gRW3B0ijxVyjPYDV1DIfjd7CjHmu41CxdPE8
 XD0zoAr8jHcg+Q3JujYv7Q4v8MWklGCF89oOFgmRa9CxGxhnIZ/NtWJwE647akKhUJlt5zS/PkO
 qHhcvGLk=
X-Gm-Gg: ASbGncv6TcPQRAEV/Gfm7f6c7ta6zJa8rp5UoX36SQlInNIPlVnBzsWFE+4nBqdP1DX
 qkRgrhe0ZfG/F2tTR/IiYWtXfDlqbgbggCfMxSgXLtaGlau+WosgcFP5ukJBk6dLscOsaVj7+O1
 wHtbS/9x7KDZcOPy4m7c/gKw1TtTqG4gU44x7Uzd+5l1X9Yww5nN3b3ST9feA3hlCzTbuYWm0zE
 8HesnpldGvt+cZLhU375fwgyS7s+LCHdv+UOsBhxwsTkoah2064iN6C0nUR1BMqr8R+w+iXtap3
 7kVFjeDl4S5V8bViQXwoXDDjOsm4HOTHsc0c9KHsoZEeG5dbKevU2ZtyBhIF95fvZSuJMH7mW2b
 WkJ5VcW8RLuTdqwDnVei51uSQgX0VLdXjXEd+4UQCa4daAdL1zz/p7We0FS0rlzNWbtn5//E=
X-Google-Smtp-Source: AGHT+IFv39DWESwntg1BlGiGmdtDQWeBJWUevEShFnpzBLXNSqX5I6+g0chApMb1Fe94NNlf4sDdNQ==
X-Received: by 2002:a05:6a20:2586:b0:220:3870:c61e with SMTP id
 adf61e73a8af0-243d6dcea40mr347643637.4.1756506343492; 
 Fri, 29 Aug 2025 15:25:43 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 29/91] linux-user: Move elf_core_copy_regs to sh4/elfload.c
Date: Sat, 30 Aug 2025 08:23:25 +1000
Message-ID: <20250829222427.289668-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h |  9 +++++++++
 linux-user/elfload.c        | 33 ---------------------------------
 linux-user/sh4/elfload.c    | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index badd0f5371..f7443ddbac 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -9,5 +9,14 @@
 #define SH4_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/sh/include/asm/elf.h.  */
+#define ELF_NREG                23
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8c3ef41312..69532faddb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -433,39 +433,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG 23
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/* See linux kernel: arch/sh/include/asm/ptrace.h.  */
-enum {
-    TARGET_REG_PC = 16,
-    TARGET_REG_PR = 17,
-    TARGET_REG_SR = 18,
-    TARGET_REG_GBR = 19,
-    TARGET_REG_MACH = 20,
-    TARGET_REG_MACL = 21,
-    TARGET_REG_SYSCALL = 22
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
-{
-    for (int i = 0; i < 16; i++) {
-        r->regs[i] = tswapreg(env->gregs[i]);
-    }
-
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
-    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
-    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
-    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
-    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
-    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 99ad4f6334..71cae9703e 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -36,3 +37,31 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     return hwcap;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+/* See linux kernel: arch/sh/include/asm/ptrace.h.  */
+enum {
+    TARGET_REG_PC = 16,
+    TARGET_REG_PR = 17,
+    TARGET_REG_SR = 18,
+    TARGET_REG_GBR = 19,
+    TARGET_REG_MACH = 20,
+    TARGET_REG_MACL = 21,
+    TARGET_REG_SYSCALL = 22
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
+{
+    for (int i = 0; i < 16; i++) {
+        r->regs[i] = tswapreg(env->gregs[i]);
+    }
+
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
+    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
+    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
+    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
+    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
+    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
+}
-- 
2.43.0


