Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C8CCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu77n-00004s-UW; Thu, 04 Sep 2025 06:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77l-0008W0-Mt
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77f-0005Pd-0s
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so8490225e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756981395; x=1757586195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zfQ6Ek+RL90OKpISh7ii2ukdZCuPaJC9b2Qi7cmtOQ=;
 b=zYRj6C1NVb+Mn1RiwrPSdXWCiLm7ZC+haXboNmTxoh1SVFyv0WJ2rpVRH+gPHVwsFH
 AOqdJe7e3nuqelQjZ9zuAzk34wbRJB0IuRAxQTqOQ0D+ZIqqwA6ztwdjQPeIsbwkL94U
 2+Yf3SWiPeZ22pPSNgc5YFMOT4Urw+PaMU89wmDY/yPruKe/Juxj+Zm5pVWGp7pwybKk
 dkven+OHbsfpIdQsuGJ1ACnUVIZuLl/kiUeY57mpPo/FdJFmWhfq/H1uyMx+zHJ6THeV
 ZZ/gzmkvX8Kj9ucr+Zii83o6Vj6lHPpdtCyOyQBxp2SO5/0y8xNtBTM/o7F/U759nJvh
 JqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756981395; x=1757586195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zfQ6Ek+RL90OKpISh7ii2ukdZCuPaJC9b2Qi7cmtOQ=;
 b=D5f3Fx9sdHQfJ7++QvUiZY9MJvXZMUUW/76+rgZidFXkWnqjOAUYZd9l7c4Ep3q4e+
 uh2vthMYharYzNcq6gQvL76GAIGJgIiOnXzvJgFG1ee0T1bfpsGgm/FsW2h+1nCa2DxC
 UZ/TG1Sd86LsMNgGRUrxpZGGdQuzAortk7kExvDNpzs6b5ICHxHTHvB7Vh1efj1IXljV
 ljXvo9X/vV8wP7bPrHVg2SoGNd5xH4E/zEYnc2ia080Rod5Hr31QXJOd05bTNp2J3Ao0
 N1gpV7YLjck1EJAaKy8BqMSpA0IpCOYFDAZ+KPMk6HVoF+Zkkki9NTu3U5ZwELyv7EDZ
 bMbQ==
X-Gm-Message-State: AOJu0Yx1SWHwAErtDsSpD4Q3+EDEw/cnlcWOQHcoqr5NogTO7Y59AuUw
 1lm1MXHg7LbKjhhslpFeyCcKBLNSkrm38ewcM2j8DjIalGauy1TfqyCqixCKXCAL+mXYJj2aBlK
 ZdhV9HYg=
X-Gm-Gg: ASbGncubkmhUE/T2Z9YLK+bUNOmJBZ92IhPD/rYcvr8tEs0dyXgvbWWBHlwd5zhRaZP
 qSr6cvbXyLBKP2WofiGarQFtQWCTlwdWC7zAkWGez1SElwLr1iGFsD7fah4su9ua2HCkc5RTrxw
 Vz/VVp0ArdI2LsUoo3V22PZ2G3gPG/GRKb+lOQ0lI70ZAOxHMEmyvIoHnvn0tRFqyB+c9TZ3ySj
 LSg5vTt9hqJ3Z43/TwZeIxGGj9J7ZBHDpBLkLqAlBmHGntsQ6c1VnrrQWxu03C6rSw/zd+59gxB
 aoOGII7f2ZEBLeKj84Ae3X7flJclDldLgcPCkjTFP4ahu3+2d3qePApuzqwUUMswhGU7BIezUTw
 R6jQubQFf0xXzBVv1a69Z4VISSvKctBDTpig2tn6av/9dew==
X-Google-Smtp-Source: AGHT+IGG23nqhZgh192viZNi89MCWHQjxifHZaGZoTevO72THq/mZGdF99KtNEHYJ/fg8V5GJl24MQ==
X-Received: by 2002:a05:600c:a43:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-45b8556a7acmr152296125e9.13.1756981395081; 
 Thu, 04 Sep 2025 03:23:15 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm147699195e9.19.2025.09.04.03.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 03:23:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: floss@arusekk.pl
Subject: [PATCH v4 1/4] linux-user: Create vdso_sigreturn_region_{start,end}
Date: Thu,  4 Sep 2025 12:23:07 +0200
Message-ID: <20250904102311.57383-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904102311.57383-1-richard.henderson@linaro.org>
References: <20250904102311.57383-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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


