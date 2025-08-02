Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E815FC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOk-0003ye-MY; Sat, 02 Aug 2025 19:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO9-0003BU-NE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:41 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO7-0001lj-S6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:41 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4338d05970bso2037623b6e.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176298; x=1754781098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0u8uZtwmHhEz8h5W3U1dOIyrczeUjwPWznuKxV1wOTI=;
 b=NSl8H44Fx8DOpCTInzwluo10X6NwsaDYsnnTSCiZvrsAyrQ3459BzTE71nKYozhswF
 6UqNgd6hGGILoCqJXg0hsr1G/KnhmDVw9uzGhHp4+Jm8z9QZdWKP7sbOVVJbqiskhvdY
 Rxgdgg3ScdHBXhXsAfsORHaRmNRUAN0D0uYMCTe7W5mHF4i6TAtjqYQLhD96KdEO7S7V
 RtB0xdTotBk09N9Mqdv0TzWT6GEUq2zjjr1ernxDziZyNDh87gVfoXAcKx6eUiUwhh6h
 Bfdg5h8WdybLbUimndZ1T373hxf/Ih23BanCZpz8SFJGXr+Y3Atqq2aoKWidbvCsYncx
 HPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176298; x=1754781098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0u8uZtwmHhEz8h5W3U1dOIyrczeUjwPWznuKxV1wOTI=;
 b=GLNzDpLdSY0NXUs44LiZx7Rg7mEWIZzInDx0ZHulAs2JzERhpdBB5GHvaiZ0+clkZu
 bYWsihJJxRTw+VrjP6Zu8v3Dl/sZiTXIx3MiUhgc/AoaNtFojj4L0uL3yLctT/akCnNn
 8nwizYciDLbIu5cDpT6VkhNlCAfrG4MNtd5lCNmNlTNLi04zBu77UazNRtxI9NmydpE+
 5skF/fqrqcpdsAmiANrHz0BLkkqTNcQizEHjH+gMO96q3fy+cH3qPG9wyF8sq6qx/x35
 bARVZqhqzV5sA7a4PVv6etJgzSbjOQ4Byxe6UAlj4NUhThq+LVzLlHZHhjKV/5XvolUp
 z1+g==
X-Gm-Message-State: AOJu0YzLqoHn/UcI7zP3hkJbcsfnBCdNYwj+rTC22bPSi+cB6OVzd9ym
 AHxDsdV51kxvNBSH3KRSQVE7JUJlOOWyo3BdFH+9VaiTevydr3xu8E8ZRqJuDdbzD+Y7qo15VHf
 1z/HoVjY=
X-Gm-Gg: ASbGncuzcB0wh01VxItLOFlYTMjUUmj95ttWtFuwjA6+ZsTUNzBPWuK/mEXdtl4/ePh
 ku9wR7DAA4vJAGx5OuoA8YVJnoQdBPG5juv1bc2+pZ1bmd2LGCP5gDfpTtcetuMEcPJFrHWS832
 UgUJTAO5yOVzBARVJmJO+fc5BNqbfrNWj9wAX23AMTPVreWjqcXp0EZB0u8RLCsZ2CbDG2RDi1d
 f4NWkmKQO2N0D6fEhIberPg2Oeft0DTY2HIGFWsqtj/PAEtYBFG+NPLsyNQ6vZsWBLtL9DIqkJ9
 9kkpn+xNWJY+Tbb93BBm6BcLeEgRjHYTqLd8zxrLFGoW9v3P5dM+1s9O1EBeiCrKXbdZmK+ML8n
 v9yuQqxQxf5AJtKmqu2zGZmawby+CBlQ/YvpC7VDs6Azk57moRrG8
X-Google-Smtp-Source: AGHT+IE1fU6QGjOgfwH7bPos7x+PurjQ7FY/gwFu4vYDK2vE3szrWH++s5rvN0Kt/JBpsrc/96eIJg==
X-Received: by 2002:a05:6808:68c7:20b0:433:fd5b:caa5 with SMTP id
 5614622812f47-433fd5be0d8mr836109b6e.35.1754176298309; 
 Sat, 02 Aug 2025 16:11:38 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 58/95] linux-user: Move elf_core_copy_regs to sh4/elfload.c
Date: Sun,  3 Aug 2025 09:04:22 +1000
Message-ID: <20250802230459.412251-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h |  3 +++
 linux-user/elfload.c        | 31 -------------------------------
 linux-user/sh4/elfload.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index badd0f5371..b0f1ece1e9 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -10,4 +10,7 @@
 
 #define HAVE_ELF_HWCAP          1
 
+/* See linux kernel: arch/sh/include/asm/elf.h.  */
+#define ELF_NREG                23
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2597fb8bc0..985c3e4e80 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -425,37 +425,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG 23
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
-void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
-{
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        regs[i] = tswapl(env->gregs[i]);
-    }
-
-    regs[TARGET_REG_PC] = tswapl(env->pc);
-    regs[TARGET_REG_PR] = tswapl(env->pr);
-    regs[TARGET_REG_SR] = tswapl(env->sr);
-    regs[TARGET_REG_GBR] = tswapl(env->gbr);
-    regs[TARGET_REG_MACH] = tswapl(env->mach);
-    regs[TARGET_REG_MACL] = tswapl(env->macl);
-    regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
-}
-
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 99ad4f6334..5592036461 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -36,3 +36,31 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     return hwcap;
 }
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
+void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
+{
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        regs[i] = tswapl(env->gregs[i]);
+    }
+
+    regs[TARGET_REG_PC] = tswapl(env->pc);
+    regs[TARGET_REG_PR] = tswapl(env->pr);
+    regs[TARGET_REG_SR] = tswapl(env->sr);
+    regs[TARGET_REG_GBR] = tswapl(env->gbr);
+    regs[TARGET_REG_MACH] = tswapl(env->mach);
+    regs[TARGET_REG_MACL] = tswapl(env->macl);
+    regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
+}
-- 
2.43.0


