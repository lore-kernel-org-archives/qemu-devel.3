Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90169C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPB-0005kx-Cw; Sat, 02 Aug 2025 19:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOu-0004Pl-Nu
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:29 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOt-0001tN-12
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:28 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6159466e80aso1095009eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176346; x=1754781146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uo8CXh3J3Cwo6Fet/c+x+mJdmco4tOEU2Zf5zDWJDa8=;
 b=o52N1N0CeLmqZQHFVLd3N8KI4MM8cBZgr4x5unnzfPzO51A6tZ9pqyBLkBGwn7d10z
 iySW2ONjGGD5gupwhX5YimrQ6DH+Tkl39InRJlaYVpKk79edgN7pMK3KdkpuCgwO2mQ0
 d+vofBZlXgY2RxrX29EiWzzvvlXoH4SGPKbPRnO3WPYC4Ekz7YzwecRU5I7ZRVvSY7ZT
 6/MYcKTsUEt3uhVBjbLz4fHEiATaZSlXN+OhG0MewJZ8QWH5xgNoo3E8g6NY+P4EeoRn
 aiFwsSL9Rx+73ghvpbXfsWlyXJSqvoQXsFuLZ15hQMSTSHJYS7uXOkuXS0A+sILR7Kt0
 MwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176346; x=1754781146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uo8CXh3J3Cwo6Fet/c+x+mJdmco4tOEU2Zf5zDWJDa8=;
 b=KW/luOd7VIej/7ZniolmIe5kxw4I/EjHeyH04YxEaLqbkvLVDFQIUavGnoQfVOGmo/
 1k+Qsu0v9bmBb+t0Eo+bs5dQLkC8yhvmWV3/6uJkUwgbUVH0J2wTdcqEcHAoNnBzn7+N
 /plGMeeLrSXunNqJwY/pv7Txit9gxRkrlEI/y+1yV2aQ++hqufiCbNeyt/7svcH7oU2j
 PiFzOGFzHZpAkVvhr0HFB1UyOcy6shEC5AVhJMqmzKZXp8eYalIKSRpqpZZOK9vNP9mm
 XT+pEPWgtQUedKysv2XGCFdXieLFdg54wBGVHUTJQhG9UE4sNS/0UkcVrWK7RcZvjmxB
 LtkA==
X-Gm-Message-State: AOJu0YwaHZg41ZknlmtfGwOPtYL+B2CJ31A6NhzKuK0F7xpxFTf+ejgb
 PXCAK0lKJYuwLG93+GynrkWoVwDHlYqXTjv1M1buU9CWZTNodeetsBcQb4+p110bq4vQ4YAnbq8
 ys+nm3tE=
X-Gm-Gg: ASbGncvlz9wfksYTp/WveXd9rrb8XkcuMHf+ywEZknTibyYf53EbSGAU+pEvRZoE+oz
 oN9V82/8icUhvLeuViZ1sGy5ekH4cLI9NthHPdDnnlIXXS9BqpPug10VDvWm+gZwtgg929WqVzd
 8ju37R/TKj/t+bdSyCGGpNW12Yf5IcU04eo/wTOm6wMzY3RLEFM7QWJC4sEPHh+LybrVVD5i0ho
 TCjYPPKfNt5DRApTquWWUxED72OyAeCEjGpekuW7e3LYBgVBtRYqrUnkCvUt9H2GqXcXZoTHDIN
 o/jfUCyJjDbPTKkFSS8UtKykSmr0s0yjY0vPiyMnzXMeunCfsSck8R1EMWSqPfLVHYziHnqBScd
 CnOrpwYZU4XYsvQk00WpRAcTYeed4BCVq5XNHzs80VYaCN2SZrah1
X-Google-Smtp-Source: AGHT+IEPwNHjXD+aau9Sq0h0hC2bU/ZpJJ4JpoeOC4RWnpKNF41uwCWgT2ULmjTJIJ8AzQRLQWeXPw==
X-Received: by 2002:a05:6820:f02:b0:619:bc8:d858 with SMTP id
 006d021491bc7-6198ef5f235mr3001948eaf.0.1754176345859; 
 Sat, 02 Aug 2025 16:12:25 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 72/95] linux-user: Move elf parameters to ppc/target_elf.h
Date: Sun,  3 Aug 2025 09:04:36 +1000
Message-ID: <20250802230459.412251-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h | 43 ++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 53 -------------------------------------
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index dd8a65b1fa..6bfe27fc45 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,10 +8,53 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
+#define ELF_MACHINE             PPC_ELF_MACHINE
+
+#ifdef TARGET_PPC64
+# define elf_check_arch(x)      ((x) == EM_PPC64)
+# define ELF_CLASS              ELFCLASS64
+#else
+# define ELF_CLASS              ELFCLASS32
+# define EXSTACK_DEFAULT        true
+#endif
+#define ELF_ARCH                EM_PPC
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG                48
 
+#ifndef TARGET_PPC64
+# define VDSO_HEADER  "vdso-32.c.inc"
+#elif TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-64.c.inc"
+#else
+# define VDSO_HEADER  "vdso-64le.c.inc"
+#endif
+
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ */
+#define DLINFO_ARCH_ITEMS       5
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
+        /*                                              \
+         * Handle glibc compatibility: these magic entries must \
+         * be at the lowest addresses in the final auxv.        \
+         */                                             \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
+        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
+        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
+    } while (0)
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e321ff3d14..1a24dfee7a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,59 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_PPC
-
-#define ELF_MACHINE    PPC_ELF_MACHINE
-
-#if defined(TARGET_PPC64)
-
-#define elf_check_arch(x) ( (x) == EM_PPC64 )
-
-#define ELF_CLASS       ELFCLASS64
-
-#else
-
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#endif
-
-#define ELF_ARCH        EM_PPC
-
-/*
- * The requirements here are:
- * - keep the final alignment of sp (sp & 0xf)
- * - make sure the 32-bit value at the first 16 byte aligned position of
- *   AUXV is greater than 16 for glibc compatibility.
- *   AT_IGNOREPPC is used for that.
- * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
- *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
- */
-#define DLINFO_ARCH_ITEMS       5
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
-        /*                                              \
-         * Handle glibc compatibility: these magic entries must \
-         * be at the lowest addresses in the final auxv.        \
-         */                                             \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
-        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
-        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
-    } while (0)
-
-#ifndef TARGET_PPC64
-# define VDSO_HEADER  "vdso-32.c.inc"
-#elif TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-64.c.inc"
-#else
-# define VDSO_HEADER  "vdso-64le.c.inc"
-#endif
-
-#endif
-
 #ifdef TARGET_LOONGARCH64
 
 #define ELF_CLASS   ELFCLASS64
-- 
2.43.0


