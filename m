Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9CBC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO4-0002dB-GU; Sat, 02 Aug 2025 19:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNx-00020o-LP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:30 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNv-0001jx-WF
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:29 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-433f43f0012so260909b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176287; x=1754781087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NbrWdx7dvKlDxg7SyrnhQz+JWocQUC8d2l3q95mW4gQ=;
 b=ZbkQQf5yommEtfDGNFVIY4E2j1o3T++HP2EyPHCirJMJQzbxIeaRAfF5r4dehDxism
 O6/sJKzYV6BDOaMMKJ9cwl3y/lQ8YxBdpEGlNEf95z6jAF4oSXR1TxHmyMuFtCo9pUfB
 SXQ2LYFEocQOghrUFDdFXvekOgR8xlEjEKnBKZg+IIcFh3ccOwcUwnBNGXdBXuz6ErGo
 MwRM9NjYJrc/yTjf+p79IzjvVKW+LURFVSh6v7z8A7A53tM37Xo09p+RRzyYLZokaJgI
 8FTt6Sow+FCU3KLk24CT5LG13a690OTveFmznkdcWH4rhCO+QbEhCwbeWqyGuTnmk0Pe
 sKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176287; x=1754781087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbrWdx7dvKlDxg7SyrnhQz+JWocQUC8d2l3q95mW4gQ=;
 b=AbTPqMtGG7MKpB91wg6L53ZahLjl1X819DuN+4gtH/fO1aTFvoWJ6Zae9GgoD15ZsK
 HdwiQK57pR5rp9pmV8bnYnpQFAOxvJSEHL/NFdbur9wXJt4SdVPUVDFBT8YpofUYQUW5
 bPj0e9THbfBD8eV4Knn3Z8BJaGVvGRL6rBMUU6w/kc7ajQ1GMWKb57FK+OF7+SbfrAb3
 vJO2T8HwdfrNdTGSUACwcbZXzZw7Z9LJ6HXPbrXTlZpoN/7Maxp/FqX66f5MOAhqNke2
 duZgoTdkpEUFsGTBALoxi8wKxJKlwzSVnPhLYgRruklq9vTrxKkW8bXNRqvY2G0SrZIa
 pHBQ==
X-Gm-Message-State: AOJu0YxCpkU+HUq3/vFIIeGWbClnC3gMO/lYeSxNxlMNZpCx0V9HrUbw
 fsfbsdOTZTMcitPjAZlSNXsiio5dxl6ztl/v0QWjLjWoN1g1IDKRr3lbwUyD7UKzfcpmFO7sNuS
 tlNpj+N0=
X-Gm-Gg: ASbGncuOBUzK+Q4ujt30iFuTR0lRJA/zimVDsbvFyJUWh/mPpT5AXfzc9CJ+kDxKjya
 Rc4T+iHI39j0WMBpR0SAL+KAc8V0EoGII2XDxFuVdjX8JqOWKVQAZwWZWtua937u9L4s+PwiihA
 xVaKCzNR8bMgIBdAK7w0Idhy5mPL7w4hKsEmlmo37u58IEhtE+Xv5m2JFq4LRTAVojvwr2WFln1
 zIuWIi/mmap+4UxtJ4QbrvEeQbfR3CyZSBaw0jobBMk3r5nypCp5NGMt0iN6LViMVB0XfBZrDkv
 bxoKPIztivwJHAjOLRI3BeUkMMDm6oPJVTYTnMr+rsWXxWVEetntwRkK6QW4rtwdf/RHY5SKrMf
 QIMCuyORQhbuKnJGmU6MoVg1sAISFfJS6FgU8FbAzrNBW3b72+9xf
X-Google-Smtp-Source: AGHT+IE5CqQ0qlgWVF/NRfbmQ4NGdn9trcqYWg3ix/I90IZ4jZjUw5M2mxuDN4ZHRMJV9dfS4FY77Q==
X-Received: by 2002:a05:6808:f0a:b0:41c:8a9a:5083 with SMTP id
 5614622812f47-433f020f7e7mr2977833b6e.2.1754176286814; 
 Sat, 02 Aug 2025 16:11:26 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 54/95] linux-user: Move elf_core_copy_regs to
 loongarch64/elfload.c
Date: Sun,  3 Aug 2025 09:04:18 +1000
Message-ID: <20250802230459.412251-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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
 linux-user/loongarch64/target_elf.h |  3 +++
 linux-user/elfload.c                | 23 -----------------------
 linux-user/loongarch64/elfload.c    | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index eb17927325..f2d00c9232 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -9,4 +9,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 
+/* See linux kernel: arch/loongarch/include/asm/elf.h */
+#define ELF_NREG                45
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0bfcbcf78d..834120c9f2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -375,29 +375,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-/* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG 45
-
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
-void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
-{
-    int i;
-
-    regs[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        regs[TARGET_EF_R0 + i] = tswapl(env->gpr[i]);
-    }
-
-    regs[TARGET_EF_CSR_ERA] = tswapl(env->pc);
-    regs[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
-}
-
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 911352840f..c9ce8ba3da 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -61,3 +61,23 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "loongarch";
 }
+
+enum {
+    TARGET_EF_R0 = 0,
+    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
+    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
+};
+
+void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
+{
+    int i;
+
+    regs[TARGET_EF_R0] = 0;
+
+    for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        regs[TARGET_EF_R0 + i] = tswapl(env->gpr[i]);
+    }
+
+    regs[TARGET_EF_CSR_ERA] = tswapl(env->pc);
+    regs[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
+}
-- 
2.43.0


