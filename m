Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05119C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P0j-0005Xs-Jo; Thu, 17 Apr 2025 09:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0U-0005Pp-Kb
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0R-0007rr-Ea
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so625230f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895411; x=1745500211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LSiEResFhtBUnjPfL11WGVWKJwbPc3LTYNgceKSoZ8=;
 b=mwrBI/cN7MVV7Z8nK/fKEWDEmZjNED0OTZ/MMqNrfKmeO9Rnm6+1w/7MAFIXC7hFqs
 Fm4ZVTkO/l04gVWQ9LXHtMczo55IeUDn+5aIi1gVNNK/FX3uX8xBL7sLKCYy20OFdMzE
 psUHtW0m2QWpgDwHacRVmoZT2PllQ7k4Q70pqxySJzT/uua/OztyxxDGRTdvM9pT5WC9
 7qk8i7dQrUVIH/mLRXcNeJZRnHYqNtnPhKTnd5i+BTYtMHnb8p+/Xei82PYT1oh4SAUw
 4MrwdIytzqGWbnOe1LkdlLylrzFs7Ol1cAUT4zGKuHsvLJS4i/Kd0ZxfuurxdTHlKODR
 at8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895411; x=1745500211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LSiEResFhtBUnjPfL11WGVWKJwbPc3LTYNgceKSoZ8=;
 b=V+TP96WBRACY/zUl8EiXMC2cBbBtXcIM5IYA32dfwZHEGk+sY/M8egheSGlNbFKXte
 WJekHjzO8bd3zelT1z405iJVdC0bWMOlYLmEsr2TZel4D+ufJrMHmog1hZkkdCZUZIWT
 qWE/mNEM6oVFGrYkPTRPfsMw37Ja3P23oBKTohUgIQhO7HIzh4PhLquaBcv+zyw1eKoZ
 pEu4uSI5krEP/BCq/oW+e/p0B57AShqjBOhVWagYyiMbe77NjOhSvk83nyZH3qiaPExI
 rS8qaaokHV38Oio+eCZqqGiZfx+9tqRADk9Sk8n7LQJ9lpwsZRTfXF04uEUKOa2LBKhU
 A2ug==
X-Gm-Message-State: AOJu0YwXdd4uZEc4eOTmStEKn3iSdg6WFxXKtMotOxbXYsf1sLRcMW4U
 IKplj19DSSwqlgjQrjf61AF5s1iopyyBFO1+T8pJm4hcE5mwcr1m2PqyWmFszXkNnQ/wOne7EG9
 R
X-Gm-Gg: ASbGncvp7GB9wF4Ka91ULNDaSL3TCIYznZE+/SYZ0foDALlfnWtsz0VoCaANHUIQKL2
 3Y6mkwW+Dm20MAJpXLbfDZ/av64RbVh7IL9efkRD1G8uJeNenKT8wxzQZ6PYQv2H2vuOToivLe6
 1yM9IDOaT0e1UaZXnttYM0QrAx2W2+CJOe4SGgsY+AJH8GBfIAoVaTVxXtWxpzms5z3LeTq9rnY
 gY0dOOaLC5pi6rVPF0z0EzqXDVXKW3ZbOJu3OrUsFMpZJKKuuSF58Bc45wIQRDeWaZxaizfdMjo
 BIiHM8eDA/de9wAvodbX7mFRh6DPHcwCnTb+AyFz0dgF0Vv12rmxa2HRxuqNxwRdG8+N+56wcnb
 Xt5/+B/ySrkg9p8E=
X-Google-Smtp-Source: AGHT+IFzAaJCfyug7bRIPjdKMtiHUl2rcE5+qLVlLbkg0GDUUj+lZIvqV0ernpglZVRU9+0cW3jrZA==
X-Received: by 2002:a5d:64c8:0:b0:39c:16a0:feef with SMTP id
 ffacd0b85a97d-39ee5b98dc2mr5610586f8f.38.1744895410868; 
 Thu, 17 Apr 2025 06:10:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ce30sm20629741f8f.62.2025.04.17.06.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] linux-user/elfload: Use target_needs_bswap()
Date: Thu, 17 Apr 2025 15:09:57 +0200
Message-ID: <20250417131004.47205-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Check whether we need to swap at runtime using
target_needs_bswap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/elfload.c | 63 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 99811af5e7b..fbfdec2f17c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -12,6 +12,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
+#include "exec/tswap.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
 #include "signal-common.h"
@@ -2122,9 +2123,12 @@ static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap16s(&ehdr->e_type);            /* Object file type */
     bswap16s(&ehdr->e_machine);         /* Architecture */
     bswap32s(&ehdr->e_version);         /* Object file version */
@@ -2142,8 +2146,11 @@ static void bswap_ehdr(struct elfhdr *ehdr)
 
 static void bswap_phdr(struct elf_phdr *phdr, int phnum)
 {
-    int i;
-    for (i = 0; i < phnum; ++i, ++phdr) {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
+    for (int i = 0; i < phnum; ++i, ++phdr) {
         bswap32s(&phdr->p_type);        /* Segment type */
         bswap32s(&phdr->p_flags);       /* Segment flags */
         bswaptls(&phdr->p_offset);      /* Segment file offset */
@@ -2157,8 +2164,11 @@ static void bswap_phdr(struct elf_phdr *phdr, int phnum)
 
 static void bswap_shdr(struct elf_shdr *shdr, int shnum)
 {
-    int i;
-    for (i = 0; i < shnum; ++i, ++shdr) {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
+    for (int i = 0; i < shnum; ++i, ++shdr) {
         bswap32s(&shdr->sh_name);
         bswap32s(&shdr->sh_type);
         bswaptls(&shdr->sh_flags);
@@ -2174,6 +2184,10 @@ static void bswap_shdr(struct elf_shdr *shdr, int shnum)
 
 static void bswap_sym(struct elf_sym *sym)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap32s(&sym->st_name);
     bswaptls(&sym->st_value);
     bswaptls(&sym->st_size);
@@ -2183,6 +2197,10 @@ static void bswap_sym(struct elf_sym *sym)
 #ifdef TARGET_MIPS
 static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap16s(&abiflags->version);
     bswap32s(&abiflags->ases);
     bswap32s(&abiflags->isa_ext);
@@ -2190,15 +2208,6 @@ static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
     bswap32s(&abiflags->flags2);
 }
 #endif
-#else
-static inline void bswap_ehdr(struct elfhdr *ehdr) { }
-static inline void bswap_phdr(struct elf_phdr *phdr, int phnum) { }
-static inline void bswap_shdr(struct elf_shdr *shdr, int shnum) { }
-static inline void bswap_sym(struct elf_sym *sym) { }
-#ifdef TARGET_MIPS
-static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
-#endif
-#endif
 
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
@@ -3144,11 +3153,11 @@ static bool parse_elf_properties(const ImageSource *src,
      * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
      * Swap most of them now, beyond the header and namesz.
      */
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    for (int i = 4; i < n / 4; i++) {
-        bswap32s(note.data + i);
+    if (target_needs_bswap()) {
+        for (int i = 4; i < n / 4; i++) {
+            bswap32s(note.data + i);
+        }
     }
-#endif
 
     /*
      * Note that nhdr is 3 words, and that the "name" described by namesz
@@ -4000,9 +4009,12 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     prstatus->pr_info.si_signo = tswap32(prstatus->pr_info.si_signo);
     prstatus->pr_info.si_code = tswap32(prstatus->pr_info.si_code);
     prstatus->pr_info.si_errno = tswap32(prstatus->pr_info.si_errno);
@@ -4020,6 +4032,10 @@ static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 
 static void bswap_psinfo(struct target_elf_prpsinfo *psinfo)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     psinfo->pr_flag = tswapal(psinfo->pr_flag);
     psinfo->pr_uid = tswap16(psinfo->pr_uid);
     psinfo->pr_gid = tswap16(psinfo->pr_gid);
@@ -4031,15 +4047,14 @@ static void bswap_psinfo(struct target_elf_prpsinfo *psinfo)
 
 static void bswap_note(struct elf_note *en)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap32s(&en->n_namesz);
     bswap32s(&en->n_descsz);
     bswap32s(&en->n_type);
 }
-#else
-static inline void bswap_prstatus(struct target_elf_prstatus *p) { }
-static inline void bswap_psinfo(struct target_elf_prpsinfo *p) {}
-static inline void bswap_note(struct elf_note *en) { }
-#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 /*
  * Calculate file (dump) size of given memory region.
-- 
2.47.1


