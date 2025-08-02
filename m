Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E5FC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJl-00052H-HD; Sat, 02 Aug 2025 19:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJh-0004mp-D4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:05 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJf-0001D8-QJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:05 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-433f43f0012so260235b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176022; x=1754780822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wIvTYAiiT1df2UjL/R0r+8svJREkoZn9cbNcggG3h4=;
 b=jhrWcmTFYJOFhHN0pFsUZyzd7g5SvQEH9n02kRrjKWyaLF3eKJey5kVIg72vQF92+K
 jX6v4VqjvnmjAbpA2wjdSY1njWdQXQ5KDNj4aOecqLc9Jxo6EzMfbX58kWFgnkirrE84
 oFgfL52xG1CUF3jtnWqU57Dw6Oz2Zz1+UuN8F6dBuG0tO8J+nVKTr8siMdmj4AX/LOeU
 8IHwRdr2OfBfTfJXHOJJyfgfSDnxhMgkuG6Su/sxd1gz2VyFaj9L+f4iPg/b4SrjSJ7C
 g72WYYtkT0I2gIzMpvz45f7bH4dRJ5Nm+R5GKrHqnLVREMKrGOa8yflfET/A/bkpUPuR
 u0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176022; x=1754780822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wIvTYAiiT1df2UjL/R0r+8svJREkoZn9cbNcggG3h4=;
 b=CBiEtPoVlVQhDz4kh1ZoRUa7j2US3jNkGFlysXfoJbH0sJloC8gyYKcGOoUiok0dsd
 KrHl2gKYqWc/67peiLGhdRl8YZ80XkbtFwYE0WpGwBsu9sKebfObktVn/XhQ+PSHo4aj
 EjD2+wGX9XVb9g7leqx1gew1x2M+q5sRUQqMkTlaxoenXN2LoOK5dJQew8hkaNbAsmCr
 +DjWfID1um8umfT7iN1dkZj0pnid9CmiW1gujAG/IdCPMKeVT+S5jZR76hSqZe3NmhXn
 qnCKTBx2nzMg3sN9lpWR/450190GuCAVnJgm/IcbJaBXjHme/24gkj0R5c50ZAIqlDai
 h97g==
X-Gm-Message-State: AOJu0Yy71arjWyJ7Qb9WzSJPBjdpe9wu6Swi04kBIS2l4qQUu9mT3f6O
 QzGUWQcV825NA2U1X6viZjh7dS7oZxfmNCb77X9fqIMBjJxgdvAxnxa85tKvjb/Qe6qErwYEYhA
 Ij/RZ638=
X-Gm-Gg: ASbGnctjnlu/C+PrHNMQFlPikhD8E5NZkyBtBppHnKqiXTOL4LNccCDVL1zN+xkK2QY
 xxBRqQH1+Hl1eYTBjqhwSwiY1OAfSJNh1IZTq74tEPC748hY7i3aMbo7FM5W5EJjX1FvdIwwyHD
 ATgAID/z0Z/gerdP634am4N4Gk8DgnqdXFiuPuqnjkqjuI9Du0s1dGcrSq04+i15b58Q9vj84Qk
 /OyN7jrtgQJPUTDpXa6V/TS79uulabrUwX1EUvCyY8lJXN5tpasTozdlYncIX7xRZiJHrRltpPt
 5qFEQcMn8P3VrLhJDejQzHZN++BzZ+P43zirMWRr3sHrHR+yI5TEmd6Yvi0Tamt8gq/ra8Fa9tc
 h+NByG5iz6ddmpRY8NmTPrWyblVLEdtcNt+xhk3B8cD9XiqFFoA0f
X-Google-Smtp-Source: AGHT+IFfgShuWWC4sejKo2MYszOifFgRzCCROY1K0b4uKU5JEyuXrGsN2Gi2H7xII5BgiAj5CiEHew==
X-Received: by 2002:a05:6808:4f62:b0:408:e6e0:910a with SMTP id
 5614622812f47-433f0343a37mr3211646b6e.22.1754176022600; 
 Sat, 02 Aug 2025 16:07:02 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 32/95] linux-user/loongarch64: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:56 +1000
Message-ID: <20250802230459.412251-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Note that init_thread had set crmd in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because loongarch_cpu_reset_hold initializes CRMD properly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c              |  9 +--------
 linux-user/loongarch64/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a30431c7a2..0feccfbe91 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -533,14 +533,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define VDSO_HEADER "vdso.c.inc"
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /*Set crmd PG,DA = 1,0 */
-    regs->csr.crmd = 2 << 3;
-    regs->csr.era = infop->entry;
-    regs->regs[3] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index ec8a06c88c..a0a4cbb7cc 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -120,13 +120,10 @@ void cpu_loop(CPULoongArchState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        env->gpr[i] = regs->regs[i];
-    }
-    env->pc = regs->csr.era;
+    CPUArchState *env = cpu_env(cs);
 
+    env->pc = info->entry;
+    env->gpr[3] = info->start_stack;
 }
-- 
2.43.0


