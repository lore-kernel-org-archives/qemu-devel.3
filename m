Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BE7C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJw-0005kt-12; Sat, 02 Aug 2025 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJs-0005bx-7X
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:16 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJq-0001Dw-O5
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:15 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61998205433so132662eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176033; x=1754780833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCC1Bj0ds8VpE2M603U1zvLp3zKKtAPXp9DANJJjBMA=;
 b=YUJDkmeBjNeRkQ1ARjOf4bP5EwkaMl3Mz1SAbUlUoS65ifw5ckgx+OytFd1YmwLz8t
 MfVYGf3QY6eaWVHScgPtP5O75ISz6/I6gBsUyXEGDBwIThCZzEKaFoVUmTpi/gT0OUM2
 MDnqaxhG44EtOG9vdXlz9rUpMXPzn+dbLnE7PJMYcQY0BCPjbeHxfrQhkW1IJ3FRLeht
 gwm/snI7cF9Ub9XJ9wHHetvXAoUA2EDSFrmp/nrByj/4KPPEoDkUMBoiJLF18HX3z/pg
 RW7IUDey3xa/IbErAmM6dRtCqlmC6FqU6zeqANOlPl9iR6/M6MQy8j20M9EO+iDT1T9P
 pz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176033; x=1754780833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCC1Bj0ds8VpE2M603U1zvLp3zKKtAPXp9DANJJjBMA=;
 b=STC8S66UW4srg9Zl6SRcdoxS+5KxYf6HuLT0bzkkqVLTw0Tg8iS7Z7eSpqZcBdLWGk
 W5vlGJ8ErpkWKFBFkD8F5U/yhQb36rpQPeUd7jmqJPV/PZQaNcKRLBIjG0K3zCrkt2wL
 4mGHKQun0fbQgOOlD/wWXMxe4utganK8IMI8F71rY3ENwtFMDJ1xbFrbYWBJvV2vvEz3
 egBojZfEgO+TFqia05ev3QxI7WeHbeRX+T8lMJr0m4F1ln/OmZj+5I9Z4I8jnOftE1ct
 UpPxchxhq5YXfMHAd+Orv5ws3viWoEYXOSiviadYoy8hbqpqJ/MyomGjEt6BCWThRO3a
 PmQA==
X-Gm-Message-State: AOJu0YxI8CrruDh8DOrCh+z8pJrRp0zP7LF8fPWwvNN4hYY3GQ++HG3O
 Psum7CnRMfwmub9tKTXWIe8PFXimSZurQgi8YvR+RPwHcbebaLe8p1BUjwcHsIE32Reyh7pr/KS
 pQ3yoVTk=
X-Gm-Gg: ASbGnctdy2VJre/3qN6aO5XtrvMNHMriopXyMEYqWSKN/hsL6MkKcmOFuI8XfT4Ry+F
 4SjV4ijcfdt2F+slHYn1u/crhMeKhP3FulhkQbkGMsmtfZR3dkGdK0kN9GVWOMNQXDeBCPymLY6
 /NYe6+qYXJUSxEH97TqcKGPTEAvnPWv47Kw9+zK1wqsY1iVbVl/XHkR4bQ+O7PoeakfFJHP8RVb
 JV/L52tYDkgYyTF+2pT8RizpK8GngaAdUWaCU+j3GGwcDuQrx8etOMgovC7W8igBl+9j6OcX0UQ
 eihOd6qrrxbtmhM4h5UnooyUwLFX5bUBry1+34Fqb1y/am724Rbrb6zK/FZJs5fDG0W11+NtuFI
 U3PIDJjZyKag30bCMkygBAVDiKhyDUb0Bl2c0gJMNbzXQAQorQ3VT9KbGPuRCXeU=
X-Google-Smtp-Source: AGHT+IHzvQa7xoeGxl/+nEeULGycgi4BjVO9OQN9Zm2sK505ybBmVXQTp0opq/son2mlM92oWF6Hxg==
X-Received: by 2002:a05:6820:290a:b0:615:a91b:8e7b with SMTP id
 006d021491bc7-6198f24aaf0mr2940821eaf.4.1754176033643; 
 Sat, 02 Aug 2025 16:07:13 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 35/95] linux-user/openrisc: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:59 +1000
Message-ID: <20250802230459.412251-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c           |  7 +------
 linux-user/openrisc/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3f9ec49359..03c9539774 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -673,12 +673,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->gpr[1] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 306b4f8eb4..8c72347a99 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,13 +83,10 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for (i = 0; i < 32; i++) {
-        cpu_set_gpr(env, i, regs->gpr[i]);
-    }
-    env->pc = regs->pc;
-    cpu_set_sr(env, regs->sr);
+    env->pc = info->entry;
+    cpu_set_gpr(env, 1, info->start_stack);
 }
-- 
2.43.0


