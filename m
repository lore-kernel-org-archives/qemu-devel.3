Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCE2C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguTQ-0005Jw-N0; Tue, 29 Jul 2025 20:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-00023z-VH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFV-00045n-6r
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso4194317b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833647; x=1754438447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m3TKvtNCAbmQS4pWul7R/CGLmanhLFQUfGy9U0VZ13s=;
 b=g176N5YmZgSPtTGYj/7XXbUMDFW8GcQy+RyKmFVkwY/b47ZlisAASX4O/TQM6yOM2e
 anT3Xzaj9v3owd+pfZM90sp39oRvhTXoHgqgW8VyDcWDr8tdvwuGUe0f0dqKUIJ62Yvx
 dS8gR+03nNCx4jQLKkWm80d4FlDZVn+SukWmIW9YeYzVuwXmumRTRhGKp97VEiWgTT4R
 eYfY7ELCpU7tmRyuFndBLwpofdsP4VJ+5Ll5RmVSDx+dO9qrNMRGM+9JCsrf1XHEMHFd
 FQU5fz7wgho1geR4woankddVd7SBs38tk6+GrpPlj854g6L1vVBtyL6/oZFDmF+ghFEu
 bRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833647; x=1754438447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3TKvtNCAbmQS4pWul7R/CGLmanhLFQUfGy9U0VZ13s=;
 b=K+zJ+MDQxbtbs0Cx90UZDRH8t24mbMDIQsHXJCTvGPqexJGUVR5eZfEt6179Kx0OAG
 ZRXAuENrveuCV64umsapBP+Ypdo75Eob36rUS2FdwAqSvRIDUOpcONVRCa3SIXniN+j0
 Pz+PbnYRk9j6g4GQhkdNOalhJno/hJIjAcbSYQkAQZ3CTCkP8zlaTSVytvwfPIhKdOOs
 Tozm8mq3hksZl/4Q+ZwxkBtKMkAxUjeEY/jMrmCaYO3UZIfYG9e8a+cfDsfItWWbg2Rl
 rA1BIKCCYL2JixpEsA+LmlM+CYPGAWUeDbYtUNCty/EEOaqOpUiYnOoYQ6L0vdJTVb4I
 o2cg==
X-Gm-Message-State: AOJu0YxLLsoAsjG4kK3OVgNg1iAQoEQ/yeXsVYI7GeFMgFSUOl+6kOrw
 GUSntmy53TTZGRoRflehnQomJrthPDPA4QkeKMo1HDm1K/f7VUPAck5DAQc/9W6y4vKwn/6W17C
 BlCcY
X-Gm-Gg: ASbGnctufJ8nRw73W6DREfrhUfh6g+2tx5ishp9rBNxmxe5ZCNxHQojDyFilnqkcDcP
 O96sq7HnVdtqnSydM0EmQBL2SyxyNP+zzOdX8ftUD/esg188VQMNdGWMLLYD5glafaQdeFCOoqX
 LM40/0lFwDgOJpeRfAvAL2C8FUl4ufVkL+rvhdpgamc+VKcP446vFvSxBGPhixpagrmeT2DqBm2
 oL5ewDhT/mDYT7eAnUvHJ9g6Pdv0j8sl1Oe7K+d+rdbCv3x3zYqGFm4apelWHfWyyD6Ylb0C+H6
 ibNPIvLqqP4VNA0p0nY5LP91sMI3nOizoQXMyzOijVJIe6Mw8ztp1zgTJ9kPVAkUFLg/NrKTBtd
 bwnnuPUnS8kJ0HTNeXt5db2uxqeqEL7yFQAwrh9Rq9h9VBjK3hebPWPyn58pZvQegIS+H35LQPf
 58GY6aPmwNMA==
X-Google-Smtp-Source: AGHT+IF/gvNp5ZQyePdJdYzcFTP0+bZkJiWPj1BVsV0J04Mtp+mq/ujf69LCTkxv87LuJQcqwtXXdA==
X-Received: by 2002:a05:6a20:958e:b0:23d:9fd5:9231 with SMTP id
 adf61e73a8af0-23dc10de968mr2060859637.46.1753833646030; 
 Tue, 29 Jul 2025 17:00:46 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/89] linux-user/sparc: Create init_main_thread
Date: Tue, 29 Jul 2025 13:58:59 -1000
Message-ID: <20250730000003.599084-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c        | 12 ++----------
 linux-user/sparc/cpu_loop.c | 16 +++++++---------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0fe15eab72..07f02378ad 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -444,16 +444,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Note that target_cpu_copy_regs does not read psr/tstate. */
-    regs->pc = infop->entry;
-    regs->npc = regs->pc + 4;
-    regs->y = 0;
-    regs->u_regs[14] = (infop->start_stack - 16 * sizeof(abi_ulong)
-                        - TARGET_STACK_BIAS);
-}
+#define HAVE_INIT_MAIN_THREAD
+
 #endif /* TARGET_SPARC */
 
 #ifdef TARGET_PPC
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 68f1e8ecd4..7d30cd1ff2 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -357,14 +357,12 @@ void cpu_loop (CPUSPARCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    env->pc = regs->pc;
-    env->npc = regs->npc;
-    env->y = regs->y;
-    for(i = 0; i < 8; i++)
-        env->gregs[i] = regs->u_regs[i];
-    for(i = 0; i < 8; i++)
-        env->regwptr[i] = regs->u_regs[i + 8];
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->npc = env->pc + 4;
+    env->regwptr[WREG_SP] = (info->start_stack - 16 * sizeof(abi_ulong)
+                             - TARGET_STACK_BIAS);
 }
-- 
2.43.0


