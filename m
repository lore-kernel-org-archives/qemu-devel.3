Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93724CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnI-0007rW-Jc; Wed, 24 Sep 2025 15:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ulu-0006v3-8u
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujo-0007mb-53
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-32e715cbad3so190442a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740468; x=1759345268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zfQ6Ek+RL90OKpISh7ii2ukdZCuPaJC9b2Qi7cmtOQ=;
 b=qc5N/N5O5pj3JmzR6IX6IAE3BGHKqSXaB4MZk4IBhAPc1yxl98ZKg3GtQgFCVgbmC3
 kop//9JWF7HGqsR3aL6r+8tj7HWDNPTnfKMPtDH2sFvsUXAwZVDI2+PCKG0IErEX7dA4
 EYg7jkVpcwDo78qbf4o8SqGmIfUByIB5JaXzwPX2bNFK1Gb+V6/MfFfH/W+VcZ6vBkKu
 cxWBkuOw0TC9rTMz6iB20QcuR0hYVcK3AUfaVvZsTlc5JYxvUEbhpPJD5PKe0+Flr9Ta
 iNtuVz80hkF54G/j6jtn46sfEoriD/TcZo4dwAIQ7+59cF+2eCyaWNgh0YpxjWRoRd/j
 /uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740468; x=1759345268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zfQ6Ek+RL90OKpISh7ii2ukdZCuPaJC9b2Qi7cmtOQ=;
 b=c+I7SiLaJetCXYK3yvqaobeiuFCRqhfOyA5/2GMFbPicW/H11u00zdmKCeVw7NqMAC
 jCUzr/gwn4CBBlip3m6ilXbgwJr/XmnobavHoeSNu0jP8g7s666dHS11pN3p0NejBYQf
 jpemE6ZA14v5B0BWbDummtglEGSlcv+pu07pcFDkH/F9VgO0iRdC1V8+GEI/a6qc4KZ7
 xs72RGpMBCuzxAlgIjnbjrN9DUyPBVNJjyHY9AdQDgXzCThdBYeuQjtk/KoPOxBvrwE3
 QFt3hUZjKnlqLzJRZy4cEnsyej0pW9OPTQxYoBhAF9YcvilXyjr3tJcmTugHvmNvWty3
 gYPQ==
X-Gm-Message-State: AOJu0Ywn3PcWlUnH+L9D0nJ2+MlmCWIarZKyMsaqP/zdMb+WjxWLtECm
 bLxG2b+W/JfY3kbQysV7EiSskez4qSWt2ZcNBuSLJa0kqg3FlaZvU+wK7hpI+yUHyXcstLklXFc
 +ryeB
X-Gm-Gg: ASbGnctbsRlLaKA00o3LhlGBqe+fLRrsYWOByfm7AFKaNjmRfY1cAHexg2QEsBXeuXn
 rXXfb2CvIv1e4QVbXuMkqnwRvmpIat808CC4W3ZC9GK3Xb04NciDdSfTLrymrVcg9P3OXMn9o0g
 SupusQmVh2tPTCDtnljOPPWjnTNF63u5j1AhezD0cx3zDXyZPMdHZxQjWTB1/GonLt2mScmQDFT
 A9t5qyP6bCjj0XjP+LDJaEgcKXxTQO58YbdSB1nLbmX8tni/+UQ7o+f8EZYh7hs14QGr2dSOI/N
 7s1K1niUB6gA/fXQFXk+E5qwxoIDHJI/fdfQaG8Sn2peuLTmiJdZ5/XSJIOpLY5mQKzbobzOgya
 BPodaPu9V7BzbEhQSpXz0Taj25p97
X-Google-Smtp-Source: AGHT+IGr3+KLsWr3rrQRWgABZRP1peKSl2jFU/iGl7REJ8LNZQcgNTNa5L5Su73kiR4sDyeUTdf/kw==
X-Received: by 2002:a17:90b:2786:b0:32d:3895:656b with SMTP id
 98e67ed59e1d1-3342a22b08dmr950085a91.12.1758740467804; 
 Wed, 24 Sep 2025 12:01:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] linux-user: Create vdso_sigreturn_region_{start,end}
Date: Wed, 24 Sep 2025 12:00:34 -0700
Message-ID: <20250924190106.7089-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

These variables will be populated from the vdso, and used
for detecting whether we are executing the sigreturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            | 2 ++
 linux-user/signal-common.h     | 2 ++
 linux-user/elfload.c           | 5 +++++
 linux-user/gen-vdso.c          | 6 ++++++
 linux-user/signal.c            | 2 ++
 linux-user/gen-vdso-elfn.c.inc | 7 +++++--
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e42b8fa1e3..da9ad28db5 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -117,6 +117,8 @@ typedef struct {
     unsigned reloc_count;
     unsigned sigreturn_ofs;
     unsigned rt_sigreturn_ofs;
+    unsigned sigreturn_region_start_ofs;
+    unsigned sigreturn_region_end_ofs;
 } VdsoImageInfo;
 
 /* Note that both Elf32_Word and Elf64_Word are uint32_t. */
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 196d2406f8..0b04868727 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -25,6 +25,8 @@
 /* Fallback addresses into sigtramp page. */
 extern abi_ulong default_sigreturn;
 extern abi_ulong default_rt_sigreturn;
+extern abi_ulong vdso_sigreturn_region_start;
+extern abi_ulong vdso_sigreturn_region_end;
 
 void setup_sigtramp(abi_ulong tramp_page);
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 26c090c95d..28f0909d1a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1659,6 +1659,11 @@ static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
     if (vdso->rt_sigreturn_ofs) {
         default_rt_sigreturn = load_addr + vdso->rt_sigreturn_ofs;
     }
+    if (vdso->sigreturn_region_start_ofs) {
+        vdso_sigreturn_region_start =
+            load_addr + vdso->sigreturn_region_start_ofs;
+        vdso_sigreturn_region_end = load_addr + vdso->sigreturn_region_end_ofs;
+    }
 
     /* Remove write from VDSO segment. */
     target_mprotect(info->start_data, info->end_data - info->start_data,
diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index aeaa927db8..d6a2cdaa83 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -36,6 +36,8 @@ static const char *rt_sigreturn_sym;
 
 static unsigned sigreturn_addr;
 static unsigned rt_sigreturn_addr;
+static unsigned sigreturn_region_start_addr;
+static unsigned sigreturn_region_end_addr;
 
 #define N 32
 #define elfN(x)  elf32_##x
@@ -215,6 +217,10 @@ int main(int argc, char **argv)
     fprintf(outf, "    .reloc_count = ARRAY_SIZE(%s_relocs),\n", prefix);
     fprintf(outf, "    .sigreturn_ofs = 0x%x,\n", sigreturn_addr);
     fprintf(outf, "    .rt_sigreturn_ofs = 0x%x,\n", rt_sigreturn_addr);
+    fprintf(outf, "    .sigreturn_region_start_ofs = 0x%x,\n",
+            sigreturn_region_start_addr);
+    fprintf(outf, "    .sigreturn_region_end_ofs = 0x%x,\n",
+            sigreturn_region_end_addr);
     fprintf(outf, "};\n");
 
     ret = EXIT_SUCCESS;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index cd0e7398aa..804096bd44 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -50,6 +50,8 @@ static void host_signal_handler(int host_signum, siginfo_t *info,
 /* Fallback addresses into sigtramp page. */
 abi_ulong default_sigreturn;
 abi_ulong default_rt_sigreturn;
+abi_ulong vdso_sigreturn_region_start;
+abi_ulong vdso_sigreturn_region_end;
 
 /*
  * System includes define _NSIG as SIGRTMAX + 1, but qemu (like the kernel)
diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index b47019e136..c2677a146c 100644
--- a/linux-user/gen-vdso-elfn.c.inc
+++ b/linux-user/gen-vdso-elfn.c.inc
@@ -84,9 +84,12 @@ static void elfN(search_symtab)(ElfN(Shdr) *shdr, unsigned sym_idx,
 
         if (sigreturn_sym && strcmp(sigreturn_sym, name) == 0) {
             sigreturn_addr = sym.st_value;
-        }
-        if (rt_sigreturn_sym && strcmp(rt_sigreturn_sym, name) == 0) {
+        } else if (rt_sigreturn_sym && strcmp(rt_sigreturn_sym, name) == 0) {
             rt_sigreturn_addr = sym.st_value;
+        } else if (strcmp("sigreturn_region_start", name) == 0) {
+            sigreturn_region_start_addr = sym.st_value;
+        } else if (strcmp("sigreturn_region_end", name) == 0) {
+            sigreturn_region_end_addr = sym.st_value;
         }
     }
 }
-- 
2.43.0


