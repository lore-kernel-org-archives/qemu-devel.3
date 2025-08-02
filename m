Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933FDC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNj-0000fs-60; Sat, 02 Aug 2025 19:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNQ-0008BA-4e
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:01 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNO-0001eO-7v
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:55 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-741b1fe0d43so13009a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176253; x=1754781053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2ibNlDU/It0+v2WxVACXlLnTyz0/s7ExcXTNLC1sCA=;
 b=JPexPOMAb7KVDONjQ2vxxY/kL/WLn29PUGWnkdNJqZHa1yMcJusyhbVzMapObDO07f
 XJNni+gZPIQOTMuKhcd6Q/cHOLsFqpYuHmboaNkwqRvesnW8Oj/ADO7pOsagTlaI/oYp
 zaNaWq9Vrx0Yd13ZSH4jqDFmz0XVwqo+aZFPusQXgl0wQv5n7pAefv+vHXe557GmhU6K
 syy/dCluJrdMMgEWQ1oqeK/mqbZiRjkf/XjLVPDnKML75SbmbZCOBJbJCl+COULszGbK
 XBi/XFJkSMLsTZbRuAdN7H5hYKhVdXPlr3pSo4oIxip2/qj7S39Om0HSonZHi2zDrl90
 pfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176253; x=1754781053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2ibNlDU/It0+v2WxVACXlLnTyz0/s7ExcXTNLC1sCA=;
 b=KCLZCkFPU86hA7uxx6TTBOOJzBoh2JiK9pNYvEkA6LQDw33DvRI9CB4n81SDsgNam9
 m61AjyTsRErBZbGwsFvPx2pb7sLQ4+14Xt95qYq4NmD5coUaVnKqbNIcpNc0vGFGNh8W
 Elcd6xNyIvJms5mRF0BihFQArp6VD95RY9OSwIAXmORqTH8vqqTVgS5gO1GllJsdYtHO
 hxO+S1lS9yX9rq6WwahOmuowZGgx8nxGueIDYRV3xSVyvb3f8Oq2lRU/2u+1ZUJE8ps2
 NBsLKN0JqXwZEJH0hbjBPhe4lPg3VJ14HZ0KvZexSB9ZP82T0fSaVPxfjxN47TlHM/v6
 PNrw==
X-Gm-Message-State: AOJu0YwzbG+GxfeL7hcz/mFickxwvgS79+I5Wp/lu2I2FzLSfISeI8+o
 kMUsfrZ8d9ybICxAgN+PIHRUNNwouyezxcx6Mf2B3duqn8IcHoqTZcCajtkQ31XorHrLlExQfE9
 ueMaKSC8=
X-Gm-Gg: ASbGncuSdx1XVi/2C+vv78OcdB0CYf5ghYXDQK95rtTAnFT2kjCbFTBH6kTBrhBZ85N
 vW6tuJOE/WVUJ6JfUmXx457A7nswsG5uT3fZEF8xc8z2OT4Uw2HkfuP43oGM+Qhnv/BO5WU8xbh
 Yo6ip8/PDU2Iae16Pq4hftSypYg7Xr2FjKtQhJUyAVHfOt7ulEl9HqBOhLZEZG/o9KfZfj0lrwW
 XTtwQZyVB4KaYGgKhfaoCA+8JUh2RG55H7VL0SHdYtLQSml2ttk1UIWGNx9LeDZIeoq/66Vqfhb
 C9SHsLbb+KKAsQ4B6LfsDWCK4lwni+lWe4MsZQNkVXNv2j489+wc8NnW4XccHuDzoldzd99bHBu
 RmrfHuLEH9UngfIQEB470tnA0BKeCQTFUd3ySEdHu40L6YehFnsPD
X-Google-Smtp-Source: AGHT+IFBzuIE8skU/1YNu0hA19H1PklZOmDZq3YUg9J62cbqMS2UC0kzcQGwRrgZoOfjPfOYRq8xxw==
X-Received: by 2002:a05:6808:68cb:10b0:433:fd5b:ca8b with SMTP id
 5614622812f47-433fd5be091mr692799b6e.2.1754176252968; 
 Sat, 02 Aug 2025 16:10:52 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 44/95] linux-user: Remove do_init_main_thread
Date: Sun,  3 Aug 2025 09:04:08 +1000
Message-ID: <20250802230459.412251-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

All targets have been converted, so we can call init_main_thread
directly.  Remove do_init_main_thread and HAVE_INIT_MAIN_THREAD.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  1 -
 linux-user/qemu.h    |  2 --
 linux-user/elfload.c | 46 --------------------------------------------
 linux-user/main.c    |  2 +-
 4 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e0291cc3b0..6482c7c90c 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -82,7 +82,6 @@ struct linux_binprm {
     int (*core_dump)(int, const CPUArchState *); /* coredump routine */
 };
 
-void do_init_main_thread(CPUState *cs, struct image_info *infop);
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr);
 int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 8a9500d4f4..e4dca0c20f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -359,8 +359,6 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
-typedef struct target_pt_regs target_pt_regs;
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
 void init_main_thread(CPUState *cs, struct image_info *info);
 
 #endif /* QEMU_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4417c2d99a..fce4c05674 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,8 +149,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define HAVE_INIT_MAIN_THREAD
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -293,8 +291,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_NREG    18
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -395,8 +391,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_NREG    34
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -438,8 +432,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 #endif /* TARGET_SPARC */
 
 #ifdef TARGET_PPC
@@ -485,8 +477,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -533,8 +523,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -581,8 +569,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -640,8 +626,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE        4096
 
 #define USE_ELF_CORE_DUMP
@@ -673,8 +657,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
@@ -701,8 +683,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -746,8 +726,6 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -786,8 +764,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE        8192
 
 #endif /* TARGET_ALPHA */
@@ -798,8 +774,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -849,8 +823,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE 4096
 
 #endif /* TARGET_RISCV */
@@ -864,8 +836,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define LO_COMMPAGE  0
 
 static bool init_guest_commpage(void)
@@ -905,8 +875,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -954,8 +922,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
-#define HAVE_INIT_MAIN_THREAD
-
 #endif /* TARGET_HEXAGON */
 
 #ifndef ELF_MACHINE
@@ -3438,15 +3404,3 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
-
-void do_init_main_thread(CPUState *cs, struct image_info *infop)
-{
-#ifdef HAVE_INIT_MAIN_THREAD
-    init_main_thread(cs, infop);
-#else
-    target_pt_regs regs = { };
-
-    init_thread(&regs, infop);
-    target_cpu_copy_regs(cpu_env(cs), &regs);
-#endif
-}
diff --git a/linux-user/main.c b/linux-user/main.c
index e21842bde9..6edeeecef3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1037,7 +1037,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init();
 
-    do_init_main_thread(cpu, info);
+    init_main_thread(cpu, info);
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-- 
2.43.0


