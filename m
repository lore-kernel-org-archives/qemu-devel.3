Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD18C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguU4-0006bQ-MU; Tue, 29 Jul 2025 20:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFG-0001j0-ON
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFE-00043H-PK
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:34 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso2359845b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833631; x=1754438431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FF/auEaLkd0ikSS1R8b8mhUCUg+ptM6YlAlQVDgVCXc=;
 b=DJTCIJxF68a3nk4utjRfS4WbiXkiYqwpr9KjrkKK8Izq3YQayd8fyQ7bem5N/exe/t
 LHORxvXwKndALI3uMlgLz4DQowUp4zQ7MBOWAdoKLbIQTCnjgtmgIOFxwk1yORVc+J3B
 DgVWFAWM+u5EAkYDff//9/SnqahWGbfMNi62nbtXY2BkqINO4hxR8+IeHTiDKT1KiDq1
 sUlkpAkajSUJlNo4/hDjoC4Qqy10+dl54ymjOSpgHAFdDmc/XwQW9QplF2zhyESayjkN
 8kvKmJvYNnqdEVFNmC3+MFTC4lOdW7PLbxjVzmvCCMNSXVgfB7FEN3pdyCSE25B2JbMt
 EOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833631; x=1754438431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FF/auEaLkd0ikSS1R8b8mhUCUg+ptM6YlAlQVDgVCXc=;
 b=f6H5s02CTIHw72JFX5DT8hYEDEL01U2+4aU8q6lJ0f4oE5RhaS3ibh8llFnkNMKUlL
 eUl9Jgctr17MUpzpLPNGGTadfipNAeoAV8bc/22+trNsVGB22A4iX12ZjNxQ+Z5Lx6t3
 sY4nx6MWE5sGJ4jX5nyN6K2BUUKN+AvSTal0QbYjgm2zIKh7n5UTU9has+KfTp1m99ML
 SD3KylviY5jtJ2k2p+A75TXJoBFGVLiTLrx/1IUowHanNTVQQdyH8TBueskZyShI+ov1
 X7wFPEwpY+0xLCds6qk9yfDIJFITRzh7qkXbn1U1wA9vK7ScJInq17k1YRqKFxI+far6
 lbRw==
X-Gm-Message-State: AOJu0YyAjRHs+nIBCYUPv51vTQ/np5rOJtUU3bqo4jJUcbJHYJq2R8i6
 buBuPcw9/nceF4WVuRhUnjR9joo4+mct0AAx4tsoGxQFoHLxYIADS9Qu1lHmmt+JQwseL64UXtE
 9hxS2
X-Gm-Gg: ASbGncuj/vTANtiHqrIdqayd+A58mQoE+e4r/PAqrNRO9BH6Ub+F26UlpAmzxyvc/tk
 eOPAjeP+zVmFYFHZAaYz6F6Bjq55uMEmebe0YX5F7jlKQuSW8T7hc6lBrNMaPOk+ZTjy7T7CgHu
 Pe8GqExZWHrKyDb9bTFqbk8igtxLl6ifGdHAxRR0EFPI4TZJHHKC2/bTBwucA+OoEWZJPIVFf5G
 JStFIr/3NtgXXTYCa1sM4H4t7ayGFcNXRMouWfRaFuo4dEMK3o5zUCATEAkG/UB9YO1CWRHwGN9
 o9yAdcJalIjIGVkzO2ITPE7mJ8kZ+Al0R6QqfiGWzOkAfxB1XhPh1P1OQssOoEGgfT0cJiTV18K
 25OCCNVrxYCjaay7H+Pdj2svjhQVgqYfSLSfK5kBBROP91dMVSY9b9eg9A1+PLzSpA1ib437dcD
 2bBrUscYjfbGFiesHYSyIC
X-Google-Smtp-Source: AGHT+IGEK8OmdwiHzIPpBUPXruUBLYtIDbAHsWRWR7pVsqluQW/WC3MU/b/fXZUYbWRaxBkZdPO34Q==
X-Received: by 2002:a05:6a00:14cb:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-76aae05b1d9mr2185490b3a.0.1753833631041; 
 Tue, 29 Jul 2025 17:00:31 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/89] linux-user: Move get_elf_platform to arm/elfload.c
Date: Tue, 29 Jul 2025 13:58:48 -1000
Message-ID: <20250730000003.599084-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Move the aarch32 get_elf_platform to arm/elfload.c; pass in CPUState.
Create a simple version in aarch64/elfload.c, which we must do at the
same time because of the ifdef dependency between TARGET_AARCH64
and TARGET_ARM.

Since all versions of get_elf_platform now have the same
signature, remove the ifdef from the declaration in loader.h

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h          |  2 --
 linux-user/aarch64/elfload.c |  5 +++++
 linux-user/arm/elfload.c     | 29 +++++++++++++++++++++++++++
 linux-user/elfload.c         | 38 ++----------------------------------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 3bfe47ef22..1cc505832b 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,8 +102,6 @@ abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
-#if defined(TARGET_I386)
 const char *get_elf_platform(CPUState *cs);
-#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 8a8bd22784..825be0a25a 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -337,3 +337,8 @@ const char *elf_hwcap2_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
+}
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index be80e04f9c..8573e46f2c 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -165,3 +165,32 @@ const char *elf_hwcap2_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    CPUARMState *env = cpu_env(cs);
+
+#if TARGET_BIG_ENDIAN
+# define END  "b"
+#else
+# define END  "l"
+#endif
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return "v8" END;
+    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return "v7m" END;
+        } else {
+            return "v7" END;
+        }
+    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+        return "v6" END;
+    } else if (arm_feature(env, ARM_FEATURE_V5)) {
+        return "v5" END;
+    } else {
+        return "v4" END;
+    }
+
+#undef END
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cbbee6608..2e1c12f247 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -316,6 +316,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 
 #ifdef TARGET_ARM
 
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
+
 #ifndef TARGET_AARCH64
 /* 32 bit ARM definitions */
 
@@ -441,37 +443,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_PLATFORM get_elf_platform()
-
-static const char *get_elf_platform(void)
-{
-    CPUARMState *env = cpu_env(thread_cpu);
-
-#if TARGET_BIG_ENDIAN
-# define END  "b"
-#else
-# define END  "l"
-#endif
-
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        return "v8" END;
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
-        if (arm_feature(env, ARM_FEATURE_M)) {
-            return "v7m" END;
-        } else {
-            return "v7" END;
-        }
-    } else if (arm_feature(env, ARM_FEATURE_V6)) {
-        return "v6" END;
-    } else if (arm_feature(env, ARM_FEATURE_V5)) {
-        return "v5" END;
-    } else {
-        return "v4" END;
-    }
-
-#undef END
-}
-
 #if TARGET_BIG_ENDIAN
 #include "elf.h"
 #include "vdso-be8.c.inc"
@@ -494,11 +465,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
-#if TARGET_BIG_ENDIAN
-# define ELF_PLATFORM    "aarch64_be"
-#else
-# define ELF_PLATFORM    "aarch64"
-#endif
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.43.0


