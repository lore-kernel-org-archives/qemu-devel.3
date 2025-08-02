Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC6BC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNr-0001G3-8E; Sat, 02 Aug 2025 19:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNi-0000cz-7y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:14 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNg-0001hG-7G
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:13 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-615ee07353bso1761233eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176271; x=1754781071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iw+J85S+/WOIJoq0a6UuRf83h3sfoLJC1A6vmK+E5uM=;
 b=uDA3FiyJjJ3JIBqFyRcx2WChdhdG9LRoWyzN+I1gBlmS4EU5cXWjUA5EEmhUB8nfvJ
 tHmUdwI0qMvCeqiXHZHM9rTN2AujFyt8LNZVvKNeOEonIMo+brwtgOC/4moqawdtEzGn
 I+Xa58N8hQiUmjVBzD5GtOsAdxbLVNWe1SccDx2WbxZ4KOACj7gjeJEMzrM8WDIAudQG
 LcHux1oeIsOH41+sL5Mg1cnGhzbi74uo9anguRHdk0Rm/CVm363ddIz+rEXZ2hoM/lGQ
 qmwzMDy01N3YBjKvBZ4ImJgHjCPOIOuojXhIJ3dOjcwbeKp5DIFrWu9alkczod6iTRWi
 aFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176271; x=1754781071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iw+J85S+/WOIJoq0a6UuRf83h3sfoLJC1A6vmK+E5uM=;
 b=C09yddq6kABc4U1tVSBULKVmsukzL+OsQVeMQkkiINrrrsbXnqsOBUi/HjTSTLVWIj
 h62TifrDmXA3IIWXsFCWSK+bVQsU64KiLbcEoh70URzp/PHRh55ErlTLf8EFKMuyBg6N
 DqfUwuxvVRX8XWZT3ZryKbpo4ImReZ+gJfB1H2xOHwfqZZVv2sCDOYHJFMZrSRoykIhG
 vU0XfoDNY3hJOILuQxGXJUE8mWaHeUCbN+TE6eoHIPji5fu9syUDuZ1Pxj7/ETF2B5F3
 4hH5do9W5G6cSgK91xebIdoLYAApblulxEkuPQee6K83WbThR50UjG3B/lHiwG0+cTQ5
 Xe2Q==
X-Gm-Message-State: AOJu0YwP2JDVTL3fSXrAWN9tix/397Dv7E4IiUYhV28vkjkiGOj2jZw/
 k8v//9WQ/AkDOee02Wl9siNKiMKOzQWkAn7M72zNvG/eg0e6rPmuvUfohGNzA6ZFivAHIdJpUEY
 d/C+5xeA=
X-Gm-Gg: ASbGncvRYVcA0/anHB8Cx6F1fadRC2KjrCntLLkhpOmz1G1mQPqracTVvil+QUXiBnp
 LhNE4Hc5SBE88XuDjxKt0ktrc9F7YOiuA6FRig9yAtCmTDDDKzFDLr4I9ORvli3DioEW35hK3hR
 qCrvTPcGYwb46vbnqN16HVi3el31Pl+Dl2ccxzmnPptQsHAFIU9C4UOCl3PR+kdQRE+kn6G6Kcd
 YxbJb8YF870+UGAOX3xPUO4IFKJGGFsgw7kcAs7DGTpkerdbfkEVKdfLDShTS4rx75sO9s0wpjP
 5SG5TqIGmHVs/LcGD50zjZ7SUoDZbmGxGneHh8757uAQF4nlvxW8lONdQHtBVgZLUFOGnuJ2ERI
 7e8yqmH+ozNfnSCVJ43jNmqWei2sjGH2yDdKvU6GDXAGItz/3fE2t
X-Google-Smtp-Source: AGHT+IG2jfHm6wKdiTTlNmqP9v7fNGXwgq5toXsSySEn7F+0t9ARJKKqgQsY+aL0sqGnnUCnh7WHMQ==
X-Received: by 2002:a4a:ee83:0:b0:615:9430:f01f with SMTP id
 006d021491bc7-6198f101b68mr2465757eaf.2.1754176270745; 
 Sat, 02 Aug 2025 16:11:10 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/95] linux-user: Remove USE_ELF_CORE_DUMP
Date: Sun,  3 Aug 2025 09:04:13 +1000
Message-ID: <20250802230459.412251-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Since ELF_NREG is defined if and only if USE_ELF_CORE_DUMP is
also defined, and since ELF_NREG carries useful information,
remove USE_ELF_CORE_DUMP and instead use ELF_NREG as a signal
that core dumps are supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 44 +++++---------------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e02e8541b..4e0d52f1f6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -267,7 +267,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_I386 */
@@ -292,7 +291,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
     regs[17] = tswapl(env->regs[0]); /* XXX */
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 /* The commpage only exists for 32 bit kernels */
@@ -379,7 +377,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
     regs[33] = tswapl(pstate_read((CPUARMState *)env));
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
@@ -472,7 +469,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
     regs[38] = tswapl(ccr);
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
@@ -518,7 +514,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
     regs[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
@@ -583,7 +578,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
     regs[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_MIPS */
@@ -597,7 +591,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#define USE_ELF_CORE_DUMP
 #define ELF_NREG 38
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
@@ -625,7 +618,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
@@ -680,7 +672,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
     regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif
@@ -717,7 +708,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
     regs[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
 #endif
@@ -765,7 +755,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
     regs[TARGET_REG_ORIG_R2] = 0;
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
 #define VDSO_HEADER "vdso.c.inc"
@@ -871,7 +860,6 @@ void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
     }
 }
 
-#define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
@@ -1080,9 +1068,9 @@ static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
 }
 #endif
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef ELF_NREG
 static int elf_core_dump(int, const CPUArchState *);
-#endif /* USE_ELF_CORE_DUMP */
+#endif
 static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
                          abi_ulong load_bias);
 
@@ -2792,14 +2780,14 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         g_free(elf_interpreter);
     }
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef ELF_NREG
     bprm->core_dump = &elf_core_dump;
 #endif
 
     return 0;
 }
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef ELF_NREG
 
 /*
  * Definitions to generate Intel SVR4-like core files.
@@ -2813,28 +2801,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * are marked with XXX.
  *
  * Core dump code is copied from linux kernel (fs/binfmt_elf.c).
- *
- * Porting ELF coredump for target is (quite) simple process.  First you
- * define USE_ELF_CORE_DUMP in target ELF code (where init_thread() for
- * the target resides):
- *
- * #define USE_ELF_CORE_DUMP
- *
- * Next you define type of register set used for dumping.  ELF specification
- * says that it needs to be array of elf_greg_t that has size of ELF_NREG.
- *
- * #define ELF_NREG <number of registers>
- *
- * Last step is to implement target specific function that copies registers
- * from given cpu into just specified register set.  Prototype is:
- *
- * void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
- *
- * Parameters:
- *     regs - copy register values into here (allocated and zeroed by caller)
- *     env - copy registers from here
- *
- * Example for ARM target is provided in this file.
  */
 
 struct target_elf_siginfo {
@@ -3359,4 +3325,4 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
     return ret;
 }
-#endif /* USE_ELF_CORE_DUMP */
+#endif /* ELF_NREG */
-- 
2.43.0


