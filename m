Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121FFC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbWq-0008Ei-Ts; Thu, 28 Aug 2025 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRw-000355-Rs
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRu-0007KC-FS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso827022b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382988; x=1756987788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Yeqk1iK19b2EBj0f/JY11rNKkg49He2X3YM6LJtukE=;
 b=x7SldFF16hdZhhlpdkIw58xQ5jZ9C+OxBcfCMz0YSeckQJKFREMQ+Hj0aAz11zVXs0
 RCg4ASV3eJpMo8EA4MHt9IeQ0d6bgD6BeIrmQ6fBLlll7eGEtfcMi+sUTcfwkDlC2VFA
 5qYjsS8CmNabmR1loNl6EC4oQkyoSx+VjwKydOPx6OOKq3KWzB4FBGiZ6z1xAM5AgSgw
 lg1vKf+9R8hXuvEPcEWbCf5ersCEynbgkjiKKUfnYL1Rs+ciDOIcdeYID6Z26bjoOI1i
 k5yT0oWAF2LX4ccPqkmQ1vjBC5n7eB3bgHxpA0Xjqu60P4w3S6t3KuOMjjIxQGmTSt5r
 B5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382988; x=1756987788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Yeqk1iK19b2EBj0f/JY11rNKkg49He2X3YM6LJtukE=;
 b=J6vEkXvPgPio1iKqgftKRKtqQ7P1qmPzZ9ZFVhy11sedju8xvFRG549YAJwnCAi+qg
 2vWVhYJC1I4M6o6qG5oafh3V7LdE24dPp63FO/MI0+wn9xPEmLff3SaeSdMKxrD2r7Qm
 o7px2Yr74YV2AHRJ657xWb3zttEWzFdCmYdXO+VEbkOtVK0tFFE33M3qtcWAwQnkqdBy
 V9qy6nPJ1it45qE1+HpTsP6UetJYELDBJKFB7lVzpJdrSEEVTBTVKcCxfwWQDbmWy6u1
 f33pXSufgwmAYeGmY6S7dHuXps0+uRBeSPhIc84omEW5cOAO+A1cfE3N8aPevxdYG1b0
 X5LQ==
X-Gm-Message-State: AOJu0YwYJqJ2xin184drm6sCfYZ0x2dp7RCBKw+1VfmF5fvMF2iBKP+2
 7SnRd6tcBmWyHkeK16sWyQeL0/hLeuw0e+aBnQWsRE5E2cpOJMkZlqpMuyzVlTayqzQisXTNpR1
 2V0h0lpk=
X-Gm-Gg: ASbGncv2iX0dsi6mNu/UR7HjrZOwPnrWoDqwX61PnxD98ZfrZEzRFwBmOqt+R6BkvaE
 zcbQRJ8qqpVvCHXBygjxcFRWB9ZB1QyTdtV7iB0BjRGMzJUGZG3kL/vJFoDYL7Uv/odBmWKCEKF
 KuHIF9IKnTfYAVlEELGYXC5pg/5JvBop10u/mtt0eVm+T9e7xpdkGr8ln6noNxjhIzajYVoaqoS
 i1E06Ubgnxr5MD4gVio24GfVRQhYGWX4YXt21MLgQzFYRuw5zlInlMCR6Upx5Gk2yTjb8xS0FZ/
 CXhXUDsJt6bvnHSaNG+3LUcFUu3uyZ3RYBzNbAXeHqnP3liuWd5+X7+8dvaPh++3EDf/ObVPFet
 glJAllPM6YVZd5YuS1IAy8ddk2A==
X-Google-Smtp-Source: AGHT+IFWL7WkP7C0uSpj2mbuWPXIm/TtKkQvbAeMYQFWxzMamqgXjtlQXyl7YqR6GQm7cw5WGHuu7w==
X-Received: by 2002:a05:6a20:3f15:b0:243:969d:a7f2 with SMTP id
 adf61e73a8af0-243969dc829mr9109701637.45.1756382988342; 
 Thu, 28 Aug 2025 05:09:48 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 28/87] linux-user: Move elf_core_copy_regs to
 xtensa/elfload.c
Date: Thu, 28 Aug 2025 22:07:37 +1000
Message-ID: <20250828120836.195358-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_elf.h | 10 +++++++++
 linux-user/elfload.c           | 39 ----------------------------------
 linux-user/xtensa/elfload.c    | 35 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 2c55c22e14..43e241aac1 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
+#define ELF_NREG                128
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7c783b74d4..5cdbdc20d9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -531,45 +531,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG 128
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
-{
-    unsigned i;
-
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
-    xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
-    }
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index e35ba69a10..49e709a094 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -3,9 +3,44 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return XTENSA_DEFAULT_CPU_MODEL;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+enum {
+    TARGET_REG_PC,
+    TARGET_REG_PS,
+    TARGET_REG_LBEG,
+    TARGET_REG_LEND,
+    TARGET_REG_LCOUNT,
+    TARGET_REG_SAR,
+    TARGET_REG_WINDOWSTART,
+    TARGET_REG_WINDOWBASE,
+    TARGET_REG_THREADPTR,
+    TARGET_REG_AR0 = 64,
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
+{
+    unsigned i;
+
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    xtensa_sync_phys_from_window((CPUXtensaState *)env);
+    for (i = 0; i < env->config->nareg; ++i) {
+        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+    }
+}
-- 
2.43.0


