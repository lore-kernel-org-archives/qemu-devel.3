Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F188CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSw-0004PV-QT; Wed, 27 Aug 2025 19:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSk-0003zw-Do
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSb-0004H6-3l
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso385670b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336900; x=1756941700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnH7EpbfqSiddTyYEjwsuEsAObJWFo46bJT3sgyKWcQ=;
 b=K2RWP97rFwXk/tOjBJlAYLeMakA8H9ewLOzhsRoyp7vuS6KCxiVUxoTwF7bqAf4QMj
 oj/iw77eE1g1DwLN2ut2r+UAiCM1j4JFt3bYcV14epMNXQ+uxUWA+EcE0zB4ZjQiKnS9
 TwU+UChWHc4TZ/HNQ9Snd11xwcTP1DHOnCfnFdXJy34BgPL/diH4fw0r/oUXVOqXi6uE
 cxM+B3xi86K0jO92tSuu4855ciNH9h06KyPWEHw1gZ07pvAmRu7LxVlL4n3Wi8AQhUWy
 luGuNmH4bhl4Igio4i7LvW/5fJo7nj/RLSLsld3MMS1qnJF6rdErko1hOBJZwbd6JVA3
 QoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336900; x=1756941700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnH7EpbfqSiddTyYEjwsuEsAObJWFo46bJT3sgyKWcQ=;
 b=Io3zkNParyWVZVwkLaNCxoKF0lLI/IDpymHH4jKUNZBpbYR3odepn3O4hOIZ88mxs5
 r1cOM2c18bCTXznrSfwqODfwNMgRiD1/k8hGxmSTY4OzdUIDWthnCw3ANscuDchpPzkn
 iclJ0+v7opSop1GonickDhrcvdDbsTLinLqbPoWuiLR7tYQ1dvLxgyHMjF9eIGXzWOew
 AUoCOXnFCBp22vc8iMUAaoAPjlAYw0TSdjrvYwmkjXCLCTx87BnvTbSrP33+Qq3fSZZW
 nqUhCRl1waaPXJ4g8IccKaIFJ62OUeUSzy/37i3T5AFBNugoCciRkTmjHMNnHBelJhzW
 D50A==
X-Gm-Message-State: AOJu0YwDNW4kgS3T5fgmpvu5PaAIZiDUVQQ9ObJg6ZuMQIWk9ArOjAg3
 3U0hQXd5rVJDFpuku8NDQN8RyhcjVs5ytgNvL/BFud1hWNCEAQUGsr0ST+qSgJA2DB2RGK4RlMl
 eY2Mqij8=
X-Gm-Gg: ASbGncvG9wQnZMWNkofbtCiog6jsBIEz5I+ictFRY51c+4mL/WgKjwb2yQ2pFWStsgi
 BIW1ofrKwbPv5hZTAYQ8BnZ2dh65ptPssbwnRfFSuLyuaQB7f00VZYB2Oc8wySKIP49fa+NTz4c
 s60Asl9Zlb6w6ac/iwltJvP36XTzB2ZDtHb6PH8VMS6f6ldAJF3wM50lVPZvXYGC9Sfk7s9YoK5
 55nNyAMUNxdfWVM2Tprb4e9u0yWYdqSuTpyffczg/KknrVTEN+Wmk067MjffIZpFbxd3MtS3Gzq
 2XmWO+ElgOgEX2idBgGLGnKgMLLYm64Sz/2oHSV9xoCC0nAzoj18DjaXEamfBU3WOx/uyJf9gjT
 ski4SYvPCZYFBDfJuywTDmjyIiw==
X-Google-Smtp-Source: AGHT+IGr47SfIM8DkzP+bQ39qgC6Y8D47UMrFeEDQU1XC0r8DOShqVz+skNfgYh2Wn1JwJRS2O8mFQ==
X-Received: by 2002:a05:6a00:3909:b0:76e:8bcd:b6f4 with SMTP id
 d2e1a72fcca58-7702faa5fd2mr23916471b3a.20.1756336899475; 
 Wed, 27 Aug 2025 16:21:39 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/46] linux-user: Move get_elf_base_platform to mips/elfload.c
Date: Thu, 28 Aug 2025 09:20:00 +1000
Message-ID: <20250827232023.50398-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pass in CPUState; define HAVE_ELF_BASE_PLATFORM.
Since this was the only instance of ELF_BASE_PLATFORM, go ahead and
provide the stub definition for other platforms.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  1 +
 linux-user/mips/target_elf.h   |  1 +
 linux-user/mips64/target_elf.h |  1 +
 linux-user/elfload.c           | 40 ++++------------------------------
 linux-user/mips/elfload.c      | 30 +++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 440871466c..42cba90dea 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -106,5 +106,6 @@ abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
+const char *get_elf_base_platform(CPUState *cs);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 877f8347d7..08e699c085 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,5 +9,6 @@
 #define MIPS_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_BASE_PLATFORM  1
 
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index c0347e5cb6..24bb7fcd3f 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,5 +9,6 @@
 #define MIPS64_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_BASE_PLATFORM  1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d2d73b06fc..4facaa7e27 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -679,37 +679,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define ELF_BASE_PLATFORM get_elf_base_platform()
-
-#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
-    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
-    { return _base_platform; } } while (0)
-
-static const char *get_elf_base_platform(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-
-    /* 64 bit ISAs goes first */
-    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
-    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
-    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
-    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
-
-    /* 32 bit ISAs */
-    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
-    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
-
-    /* Fallback */
-    return "mips";
-}
-#undef MATCH_PLATFORM_INSN
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1169,10 +1138,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_HEXAGON */
 
-#ifndef ELF_BASE_PLATFORM
-#define ELF_BASE_PLATFORM (NULL)
-#endif
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
@@ -1219,6 +1184,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs) { g_assert_not_reached(); }
 #ifndef HAVE_ELF_PLATFORM
 const char *get_elf_platform(CPUState *cs) { return NULL; }
 #endif
+#ifndef HAVE_ELF_BASE_PLATFORM
+const char *get_elf_base_platform(CPUState *cs) { return NULL; }
+#endif
 
 #include "elf.h"
 
@@ -1673,7 +1641,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     u_base_platform = 0;
-    k_base_platform = ELF_BASE_PLATFORM;
+    k_base_platform = get_elf_base_platform(thread_cpu);
     if (k_base_platform) {
         size_t len = strlen(k_base_platform) + 1;
         if (STACK_GROWS_DOWN) {
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 739f71c21b..c353ccc1ad 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -92,3 +92,33 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 #undef GET_FEATURE_REG_EQU
 #undef GET_FEATURE_REG_SET
 #undef GET_FEATURE_INSN
+
+#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
+    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
+    { return _base_platform; } } while (0)
+
+const char *get_elf_base_platform(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+
+    /* 64 bit ISAs goes first */
+    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
+    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
+    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
+    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
+
+    /* 32 bit ISAs */
+    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
+    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
+
+    /* Fallback */
+    return "mips";
+}
+
+#undef MATCH_PLATFORM_INSN
-- 
2.43.0


