Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DDEC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU6-00021z-DQ; Sat, 04 May 2024 11:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU4-000212-Md
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU3-0006E7-0R
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ec5387aed9so5050045ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837169; x=1715441969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Szn3u2DiPc63NcxLhhS13Pf/pn94U3NtwmvgmtkOMv0=;
 b=A4RgGxdokgoN1VDX1GtAlAPBdO428KEt19LREaFXJGYzx5H7HbDbbX3/5t6cQ2kJui
 PuPNcyE8NrT1+jyM9FCtUIeIgJLmcX83jCTLLo5bdXFQPurkH7iyAReFHiohvvnWUjpz
 fpEcnCPgIq5A2VgBQhl8+ZqaMjWBIuyIHEk7CzE90111DIO3Ruuok6qNM6XbdQywIgLl
 wheIHLKIJQcBEM2hsowos9jvwpg/poNyUIGkeOMHvE/0INP5Qc1HYhrY+wp/KhhvxzQ3
 W0CybZBAU1avVyAetD6E/hdVDSU2j7J5hVR9ZIl8FPWptKzoDSgC0bMMXkSWsWKKA2/f
 Tbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837169; x=1715441969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Szn3u2DiPc63NcxLhhS13Pf/pn94U3NtwmvgmtkOMv0=;
 b=rtfnDYhjk7jbCA+FAuKH0W4//yHfSE1s1zlHU2Za86yagjROFLOjtBQ83p5ECGtRTB
 4/WFJHWtOLgTDGJWtaQHKj0eYg8V7PnEW9ObFM4BMfDjuZYPWYNUSFnrkG9SRHkAVnqk
 mthnuCu9yEgHELyTPK2aHilj4TdTfAjO0pPDlEYwIu9jma9TcagRtXvHzzdTvE2JxMZT
 HPBGRPhSOsyIWn0mFR5hr/MSe1Dk1qZq8OqqlQAsJ9UCBs+WarJVx6/rVgzN3bcxxmm9
 XpS8wpwtErKid2GT5mCv39GqE48TY4+9n46DlHF/aEnXrCn8KIxX1euG9NBJC9H53AkY
 6Jbw==
X-Gm-Message-State: AOJu0Yxbu3BxijYxYQVJUHL1Xq3U3Px+P7ecWrOjUnmpVwGOxOhfgncn
 SNkIPrTGyZMrQuw9TxrxeJtarU1ZEzX5mZdKMr/avWEWyy0C/0TopfNc5bnlQNxDLD5OGT5ZLaR
 d
X-Google-Smtp-Source: AGHT+IEfjEoHJGJgxLeNU6QugQWJo4+ieNt8Da07R1ESrMs7oKJiG8B4hLa9DB+H4iTIT357h1KwIg==
X-Received: by 2002:a17:90a:ac18:b0:2b2:9d08:80a1 with SMTP id
 o24-20020a17090aac1800b002b29d0880a1mr5241359pjq.33.1714837169188; 
 Sat, 04 May 2024 08:39:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] target/alpha: Use cpu_env in preference to ALPHA_CPU
Date: Sat,  4 May 2024 08:39:18 -0700
Message-Id: <20240504153926.357845-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

ALPHA_CPU has a dynamic object type assert, which is
unnecessary considering that these are all class hooks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-2-philmd@linaro.org>
---
 target/alpha/cpu.c    | 15 ++++++---------
 target/alpha/helper.c |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 05f9ee41e9..f98d022671 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -28,25 +28,22 @@
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    cpu->env.pc = value;
+    CPUAlphaState *env = cpu_env(cs);
+    env->pc = value;
 }
 
 static vaddr alpha_cpu_get_pc(CPUState *cs)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    return cpu->env.pc;
+    CPUAlphaState *env = cpu_env(cs);
+    return env->pc;
 }
 
 static void alpha_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    cpu->env.pc = data[0];
+    CPUAlphaState *env = cpu_env(cs);
+    env->pc = data[0];
 }
 
 static bool alpha_cpu_has_work(CPUState *cs)
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d6d4353edd..c5e4958f8b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -124,7 +124,7 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
                               MMUAccessType access_type,
                               bool maperr, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong mmcsr, cause;
 
     /* Assuming !maperr, infer the missing protection. */
@@ -155,9 +155,9 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
     }
 
     /* Record the arguments that PALcode would give to the kernel. */
-    cpu->env.trap_arg0 = address;
-    cpu->env.trap_arg1 = mmcsr;
-    cpu->env.trap_arg2 = cause;
+    env->trap_arg0 = address;
+    env->trap_arg1 = mmcsr;
+    env->trap_arg2 = cause;
 }
 #else
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
-- 
2.34.1


