Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7B0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNi-0000Yy-Ca; Sat, 02 Aug 2025 19:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNT-0008FD-S6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNR-0001eo-7k
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:58 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-433f3bc84e0so624016b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176256; x=1754781056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7dWmvmY3TGPS29fFTMACdsuEioHhfDQLXwYkGyXN3U=;
 b=z7j6T4v5BsXdP0aJSJ7g4wOkjgdckw5Bg+Zn7dSG9xj0Re7nU8qyUxD8yKROSf7OZa
 B4beu8Scmu1ZcZHzIqGlS59gQCdersI89BJzu+COtbrlWwyeM/euisF6H1oXoExFgbQA
 XYO/EKgaLDjGXh05ME+IeEaB40ILdAdlJuzj4EBoZCDhTVKPQE6OzkR7mQ3D68spjSJq
 Tu+w3SZyy83sDJnVL9LiujX1BwwMQhOBRyME5D92MAsysNOvsDWY/sQKKTARoUUIgbOz
 AjgsuDjEFbqXeI0Ja1VZCNgXZE2pX8eFKoyp6dXMRK6+5FFalL94HdED8EiA2Kr+o0uN
 WszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176256; x=1754781056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7dWmvmY3TGPS29fFTMACdsuEioHhfDQLXwYkGyXN3U=;
 b=V74UUPYyywNlabbBRfJqiWPmLVoSXh1fP2FrPIgSwWx+MIzgSvyyu0EtBYcDCHi6FP
 pmLYCnhh8lhNjn1E4XdVnPQpvLpwZOuYX8cSvmqMcRXNJLJoXprtPZsS6f59Eihu83Jr
 J13L6Dv0i/LkYIqtAIVvCEGEvMGdmpo42i22vQ6/kjGtvGmIxaX3xE0dYW1cfRnG4ctj
 bcbunFX3xf9toNu8TYCfuCjidCQvpGGO0cns+YkP5ov8n7mUUsuCBFV/kIIP1CLxiKXr
 65OSwBpNCa/5q9CHOSwC9THeJpnFkqoCs3q8lnZ++9Sanq4zhvptu5LSRVGb4u9ugkJQ
 V33w==
X-Gm-Message-State: AOJu0Yx1bRrvHcDph136Mr482qKnRshGugNUrq0FOu4XH4SZWsUZpiFq
 pAyvRHWbHM+2nU18qL4xB23B8Yw2Hn8aqdyAB61eIfRUFBV7WyoZqRiBdw0QctX3k/c8PWyvbM4
 9ueHpDa8=
X-Gm-Gg: ASbGncuC+cMwl4PYiw8N8e3Y7HVfg5/f7gvmSSJQ38sN8vba5GpnMjBsDZMQCnQTUgJ
 kd1ek1KT+1HoE/YoP6/BZz1O1LpEmGfqSMYUS1IQXNT64RVz94iUfDpZ/zLWt4xWDIJpMA7ZyjI
 8+nSotelsHEBMe7IyzpZP4KAkErvpH2N+CFj8wBbvI2EN3OHubK2JHJFAKVzqcFnXyrJHxD0j6f
 cJ0WmaHzRjQ7W9d7C3/nh9epCjE5D/4hfUkT/wSaOi4xlBehHOwpyUcbEA8QocxQDh5zVIY8M9N
 0lbujo2ginG9vPDb5bbVkmuwJ1sUo3XAe2a2h1j7lWTwfmRWaejh6pc3rH7pDmNRjQT8TgBNtcP
 o7IhSSR3oI5lUjqJzV4aOx2YSdVwvcp5/cUMm2feo4KokO2usJU+qYDjC4+NZZzbuAUsQytXzvA
 ==
X-Google-Smtp-Source: AGHT+IFeBB+9xftPX+JihRK6cStIYBQwYQ1El2WMmxXKnNBFMA4sHYnsumfxtyAoGTlKcN+cwZDJaA==
X-Received: by 2002:a05:6808:508f:b0:406:2bb4:cd77 with SMTP id
 5614622812f47-433f021238fmr2735372b6e.5.1754176255927; 
 Sat, 02 Aug 2025 16:10:55 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/95] linux-user: Remove target_elf_greg_t
Date: Sun,  3 Aug 2025 09:04:09 +1000
Message-ID: <20250802230459.412251-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

This typedef is synonymous with target_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fce4c05674..70a1e402d3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -131,10 +131,8 @@ int info_is_fdpic(struct image_info *info)
 #endif
 
 #ifdef TARGET_ABI_MIPSN32
-typedef abi_ullong      target_elf_greg_t;
 #define tswapreg(ptr)   tswap64(ptr)
 #else
-typedef abi_ulong       target_elf_greg_t;
 #define tswapreg(ptr)   tswapal(ptr)
 #endif
 
@@ -154,7 +152,7 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH       EM_X86_64
 
 #define ELF_NREG    27
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /*
  * Note that ELF_NREG should be 29 as there should be place for
@@ -231,7 +229,7 @@ static bool init_guest_commpage(void)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    17
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /*
  * Note that ELF_NREG should be 19 as there should be place for
@@ -292,7 +290,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    18
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
 {
@@ -392,7 +390,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS64
 
 #define ELF_NREG    34
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs,
                                const CPUARMState *env)
@@ -479,7 +477,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *env)
 {
@@ -525,7 +523,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_EF_R0 = 0,
@@ -571,7 +569,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/mips/include/asm/reg.h.  */
 enum {
@@ -630,7 +628,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 
 #define USE_ELF_CORE_DUMP
 #define ELF_NREG 38
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
@@ -662,7 +660,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG 34 /* gprs and pc, sr */
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs,
                                const CPUOpenRISCState *env)
@@ -685,7 +683,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/sh/include/asm/ptrace.h.  */
 enum {
@@ -728,7 +726,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
 {
@@ -776,7 +774,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_REG_PSWM = 0,
@@ -877,7 +875,7 @@ static bool init_guest_commpage(void)
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_REG_PC,
@@ -2864,7 +2862,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * Next you define type of register set used for dumping.  ELF specification
  * says that it needs to be array of elf_greg_t that has size of ELF_NREG.
  *
- * typedef <target_regtype> target_elf_greg_t;
  * #define ELF_NREG <number of registers>
  * typedef taret_elf_greg_t target_elf_gregset_t[ELF_NREG];
  *
-- 
2.43.0


