Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC94CC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIF-0000aS-E8; Sat, 02 Aug 2025 19:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLID-0000Yl-J7
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:33 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIA-00013b-NE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:33 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6197e13b6b8so1135982eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175929; x=1754780729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoPWka5IGjXwmhHjvxnZ9KVWvPEaQtzh37FeYd1Lbz4=;
 b=ahx7g35Vknsy1g0sYNwNwQw8L+LQn2bXflaa0qLbMs/7PGigK7TJD6y8ypLKXnebC3
 iqfS2Ja+pPxqWO9SetnK1Lmz7vwhnKnVQL6swtejgu23VfD6iKzf5+nUUmS624uu6+mC
 EZGuC3vm4LwDWa/M3KWIMDFnZOXqS1AZsnz1MkGHh1ZQsgul1eCqoHG7Xm5xZZZtwe5G
 r0DY7TA4cxznkOyC++kiXUK08ktWoCe3RRjuT5uc6PEkEos3tnzhU5S08eMceKw00ZbE
 BZvIRV5zJNgWy/kxgC1G/CXLiPbqKItbbVp8h1hE4hn9wB5RBfagBn+SxcTCE3hYQnjF
 0RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175929; x=1754780729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoPWka5IGjXwmhHjvxnZ9KVWvPEaQtzh37FeYd1Lbz4=;
 b=WCy8zp5zBcHmD6Ahw5IJ025+sTe5aS2S3wW0eyjvTNzGLoKI1kHz3HdwPXkLcq79HD
 QkcbMHXHmpeyVbIL+bTbdWcMuEd4Wh3xrnoEFXflv27YKPWSIO0Dkhe61tRUV/g1FKpm
 UMmuVttKQaCDTMPZF2DGFsyh82Y8OJhmLl17UzoH7z8qlx8Bcp4aBBIol2yl40JKPkn3
 xrMdYIRjPqUyIvEadWH5CsAIyzekga4Y2qluyyN14VRQER8IfUWy7s4i2GID2EKNO7r/
 QRWkUMX2xJL2yTWCaYhktSRQbbtCj1rB158zGMGgmUaYk4J5MGwDuW5uQ1LuX13GZbs5
 RYkg==
X-Gm-Message-State: AOJu0Yz30lqFwpdALQzEcaPPBZyZw7rn8etIENeFGOPdGOG/xumnnw8z
 H6vexaqDinn2v+iHgmHOwaii94P/WDlfEYpiwkWHzfYcVoZA4FxfjzfQmtcrDKThJk4GmW44euY
 CjlZN3dg=
X-Gm-Gg: ASbGncuoRTcck3PKQCrOxlWTrGWifX+C/Ni6eg6tRhedd/x7qlX7ME0W7PTxyhgjVjr
 gKkYct/DdbiQTpBya6O4V9NDb1EEV71d9ZXjimbGE7FTSNDZFkiG7NSCuf6kw/Lil8a2eLnKJdE
 X12wbcxgBCpvxBlx8nf/IyXxvTKAX44vLu4/ezn4igLn2MQWMDLxgYG272lLugPdssrUnklslj4
 IRguEpWRp8Yf3FN8c7e62egCieJwdgirfEel2fLrrNj91XuzMqzr/6hB54tF8ChSBZikV16awuv
 37kZO1OXFtOH4oF+smvhuNMRXCKv2j2pP7s934JRCOxvMrQ1d58p5y8YNV25chYWnO8KHzQ4sNI
 o5ck/vISzvwd0DLtR7Zjue3lDEvNczc54NHBxLZNk07v5u1XrMvFe
X-Google-Smtp-Source: AGHT+IF+QNIeqdN2ERc7f4rjT6yjgjl+Ux1WUin5fMaXotUZ/w4TZROuRNEIXFp5MC+MP8lGjlrHWw==
X-Received: by 2002:a05:6820:992:b0:619:950f:2413 with SMTP id
 006d021491bc7-619950f26a5mr1586827eaf.2.1754175929269; 
 Sat, 02 Aug 2025 16:05:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/95] linux-user: Move get_elf_cpu_model to
 target/elfload.c
Date: Sun,  3 Aug 2025 09:03:29 +1000
Message-ID: <20250802230459.412251-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

Rename from cpu_get_model to emphasize that this is an elf-specific
function.  Declare the function once in loader.h.

This frees up target_elf.h for other uses.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h     |  5 +---
 linux-user/alpha/target_elf.h       |  5 +---
 linux-user/arm/target_elf.h         |  5 +---
 linux-user/hexagon/target_elf.h     | 29 -------------------
 linux-user/hppa/target_elf.h        |  5 +---
 linux-user/i386/target_elf.h        |  5 +---
 linux-user/loader.h                 |  3 ++
 linux-user/loongarch64/target_elf.h |  5 +---
 linux-user/m68k/target_elf.h        |  9 ------
 linux-user/microblaze/target_elf.h  |  5 +---
 linux-user/mips/target_elf.h        | 11 +-------
 linux-user/mips64/target_elf.h      | 27 +-----------------
 linux-user/openrisc/target_elf.h    |  5 +---
 linux-user/ppc/target_elf.h         |  9 +-----
 linux-user/riscv/target_elf.h       |  5 +---
 linux-user/s390x/target_elf.h       |  5 +---
 linux-user/sh4/target_elf.h         |  5 +---
 linux-user/sparc/target_elf.h       |  9 +-----
 linux-user/x86_64/target_elf.h      |  5 +---
 linux-user/xtensa/target_elf.h      |  5 ----
 linux-user/aarch64/elfload.c        | 10 +++++++
 linux-user/alpha/elfload.c          | 10 +++++++
 linux-user/arm/elfload.c            | 10 +++++++
 linux-user/hexagon/elfload.c        | 34 +++++++++++++++++++++++
 linux-user/hppa/elfload.c           | 10 +++++++
 linux-user/i386/elfload.c           | 10 +++++++
 linux-user/loongarch64/elfload.c    | 10 +++++++
 linux-user/m68k/elfload.c           | 17 ++++++++++++
 linux-user/main.c                   |  3 +-
 linux-user/microblaze/elfload.c     | 10 +++++++
 linux-user/mips/elfload.c           | 43 +++++++++++++++++++++++++++++
 linux-user/openrisc/elfload.c       | 10 +++++++
 linux-user/ppc/elfload.c            | 14 ++++++++++
 linux-user/riscv/elfload.c          | 10 +++++++
 linux-user/s390x/elfload.c          | 10 +++++++
 linux-user/sh4/elfload.c            | 10 +++++++
 linux-user/sparc/elfload.c          | 14 ++++++++++
 linux-user/x86_64/elfload.c         | 10 +++++++
 linux-user/xtensa/elfload.c         | 10 +++++++
 39 files changed, 272 insertions(+), 145 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index a7eb962fba..d955b3d07f 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index b77d638f6d..52b68680ad 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "ev67";
-}
+
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 58ff6a0986..2abb27a733 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index 36056fc9f0..eccf207f6b 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,33 +18,4 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    static char buf[32];
-    int err;
-
-    /* For now, treat anything newer than v5 as a v73 */
-    /* FIXME - Disable instructions that are newer than the specified arch */
-    if (eflags == 0x04 ||    /* v5  */
-        eflags == 0x05 ||    /* v55 */
-        eflags == 0x60 ||    /* v60 */
-        eflags == 0x61 ||    /* v61 */
-        eflags == 0x62 ||    /* v62 */
-        eflags == 0x65 ||    /* v65 */
-        eflags == 0x66 ||    /* v66 */
-        eflags == 0x67 ||    /* v67 */
-        eflags == 0x8067 ||  /* v67t */
-        eflags == 0x68 ||    /* v68 */
-        eflags == 0x69 ||    /* v69 */
-        eflags == 0x71 ||    /* v71 */
-        eflags == 0x8071 ||  /* v71t */
-        eflags == 0x73       /* v73 */
-       ) {
-        return "v73";
-    }
-
-    err = snprintf(buf, sizeof(buf), "unknown (0x%x)", eflags);
-    return err >= 0 && err < sizeof(buf) ? buf : "unknown";
-}
-
 #endif
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 19cae8bd65..5826ca2cd2 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "hppa";
-}
+
 #endif
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 238a9aba73..e6f0d8fa4e 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index e102e6f410..75ee9975a0 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -98,6 +98,9 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+/* Note that Elf32 and Elf64 use uint32_t for e_flags. */
+const char *get_elf_cpu_model(uint32_t eflags);
+
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
 uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 95c3f05a46..39a08d35d9 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -5,8 +5,5 @@
 
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "la464";
-}
+
 #endif
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 998fe0fe2f..62ff9d38d4 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -7,14 +7,5 @@
 
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    if (eflags == 0 || (eflags & EF_M68K_M68000)) {
-        /* 680x0 */
-        return "m68040";
-    }
 
-    /* Coldfire */
-    return "any";
-}
 #endif
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 8a8f1debff..bfe2997fd2 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 71a32315a8..febf710c7a 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -7,14 +7,5 @@
 
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
-        return "mips32r6-generic";
-    }
-    if (eflags & EF_MIPS_NAN2008) {
-        return "P5600";
-    }
-    return "24Kf";
-}
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 502af9d278..02e6d14840 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -7,30 +7,5 @@
 
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    switch (eflags & EF_MIPS_MACH) {
-    case EF_MIPS_MACH_OCTEON:
-    case EF_MIPS_MACH_OCTEON2:
-    case EF_MIPS_MACH_OCTEON3:
-        return "Octeon68XX";
-    case EF_MIPS_MACH_LS2E:
-        return "Loongson-2E";
-    case EF_MIPS_MACH_LS2F:
-        return "Loongson-2F";
-    case EF_MIPS_MACH_LS3A:
-        return "Loongson-3A1000";
-    default:
-        break;
-    }
-    switch (eflags & EF_MIPS_ARCH) {
-    case EF_MIPS_ARCH_64R6:
-        return "I6400";
-    case EF_MIPS_ARCH_64R2:
-        return "MIPS64R2-generic";
-    default:
-        break;
-    }
-    return "5KEf";
-}
+
 #endif
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index 265ecd3079..b34f2ff672 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 0616618854..8c0a8ea431 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -7,12 +7,5 @@
 
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-#ifdef TARGET_PPC64
-    return "POWER9";
-#else
-    return "750";
-#endif
-}
+
 #endif
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index dedd5956f3..bfe86105d0 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index 8114b59c1d..e51b053339 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "qemu";
-}
+
 #endif
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index f485e0cef2..d17011bd75 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "sh7785";
-}
+
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index a510ceb612..7e46748d26 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -7,12 +7,5 @@
 
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-#ifdef TARGET_SPARC64
-    return "TI UltraSparc II";
-#else
-    return "Fujitsu MB86904";
-#endif
-}
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 3f628f8d66..5849f96350 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index a9a3fabd89..2c55c22e14 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,9 +8,4 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return XTENSA_DEFAULT_CPU_MODEL;
-}
-
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 73fa78ef14..1e44475c47 100644
--- a/linux-user/alpha/elfload.c
+++ b/linux-user/alpha/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "ev67";
+}
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
index 73fa78ef14..d8b545032a 100644
--- a/linux-user/hexagon/elfload.c
+++ b/linux-user/hexagon/elfload.c
@@ -1 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    static char buf[32];
+    int err;
+
+    /* For now, treat anything newer than v5 as a v73 */
+    /* FIXME - Disable instructions that are newer than the specified arch */
+    if (eflags == 0x04 ||    /* v5  */
+        eflags == 0x05 ||    /* v55 */
+        eflags == 0x60 ||    /* v60 */
+        eflags == 0x61 ||    /* v61 */
+        eflags == 0x62 ||    /* v62 */
+        eflags == 0x65 ||    /* v65 */
+        eflags == 0x66 ||    /* v66 */
+        eflags == 0x67 ||    /* v67 */
+        eflags == 0x8067 ||  /* v67t */
+        eflags == 0x68 ||    /* v68 */
+        eflags == 0x69 ||    /* v69 */
+        eflags == 0x71 ||    /* v71 */
+        eflags == 0x8071 ||  /* v71t */
+        eflags == 0x73       /* v73 */
+       ) {
+        return "v73";
+    }
+
+    err = snprintf(buf, sizeof(buf), "unknown (0x%x)", eflags);
+    return err >= 0 && err < sizeof(buf) ? buf : "unknown";
+}
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 73fa78ef14..2274fcbde4 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "hppa";
+}
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 73fa78ef14..874dc4c230 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "la464";
+}
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 73fa78ef14..561ac5b3b3 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -1 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+#include "elf.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    if (eflags == 0 || (eflags & EF_M68K_M68000)) {
+        /* 680x0 */
+        return "m68040";
+    }
+
+    /* Coldfire */
+    return "any";
+}
diff --git a/linux-user/main.c b/linux-user/main.c
index 68972f00a1..ad1a29d198 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -49,7 +49,6 @@
 #include "qemu/guest-random.h"
 #include "elf.h"
 #include "trace/control.h"
-#include "target_elf.h"
 #include "user/cpu_loop.h"
 #include "crypto/init.h"
 #include "fd-trans.h"
@@ -809,7 +808,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (cpu_model == NULL) {
-        cpu_model = cpu_get_model(get_elf_eflags(execfd));
+        cpu_model = get_elf_cpu_model(get_elf_eflags(execfd));
     }
     cpu_type = parse_cpu_option(cpu_model);
 
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 73fa78ef14..04e3b76740 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -1 +1,44 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+#include "elf.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_MIPS64
+    switch (eflags & EF_MIPS_MACH) {
+    case EF_MIPS_MACH_OCTEON:
+    case EF_MIPS_MACH_OCTEON2:
+    case EF_MIPS_MACH_OCTEON3:
+        return "Octeon68XX";
+    case EF_MIPS_MACH_LS2E:
+        return "Loongson-2E";
+    case EF_MIPS_MACH_LS2F:
+        return "Loongson-2F";
+    case EF_MIPS_MACH_LS3A:
+        return "Loongson-3A1000";
+    default:
+        break;
+    }
+    switch (eflags & EF_MIPS_ARCH) {
+    case EF_MIPS_ARCH_64R6:
+        return "I6400";
+    case EF_MIPS_ARCH_64R2:
+        return "MIPS64R2-generic";
+    default:
+        break;
+    }
+    return "5KEf";
+#else
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
+        return "mips32r6-generic";
+    }
+    if (eflags & EF_MIPS_NAN2008) {
+        return "P5600";
+    }
+    return "24Kf";
+#endif
+}
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 73fa78ef14..7775dc06fa 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -1 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_PPC64
+    return "POWER9";
+#else
+    return "750";
+#endif
+}
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 73fa78ef14..989953a247 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "qemu";
+}
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 73fa78ef14..546034ec07 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "sh7785";
+}
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 73fa78ef14..243e6f9b66 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -1 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_SPARC64
+    return "TI UltraSparc II";
+#else
+    return "Fujitsu MB86904";
+#endif
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index 73fa78ef14..e35ba69a10 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return XTENSA_DEFAULT_CPU_MODEL;
+}
-- 
2.43.0


