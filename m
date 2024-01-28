Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C181C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx1E-0005tZ-UX; Sat, 27 Jan 2024 23:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx17-0005fp-Ht
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:38 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx15-0004Pq-8P
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:36 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso743896a12.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417014; x=1707021814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tMFQE97q4aUbL8LMPU5R9Llk18uVwdymUNm4iTykmc=;
 b=WsWMU4AeaEeZF7zzGIVLcoj/nff1RQBfB53zM4UgAwgG6MHL+i0kkKxAvErUM6q9tO
 oOVTg6tXIudUJN6fp15d7hIVvxSYYFTs1IfNbg2baXin8ugQsPln8rRDdqJpDDtHoE9P
 39W6u8KR+4F30+fUrni9HDEks47vAtVuLPstZFgV1eMlgSjWPfkGNsQZoDgPJ4JBW1+u
 JW0KWDL/XH5PTk8voiIGJJe5fPLT/c8NA1VsgElO+Vp45hkKMdjgeWNKJzbaaqu1eEPi
 byAzCgANmQ60TjEUPtFAahkscRrIPJM3+W8bypy97sXQWhcM92Lvr9Tg67dKCU1L51bY
 Su9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417014; x=1707021814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tMFQE97q4aUbL8LMPU5R9Llk18uVwdymUNm4iTykmc=;
 b=ceTD9EucLUlCYLJaKo2TQu1DvJaPiAeCwH8T8wnbBSUJlWdzjT4uSSCkckjnmerEeN
 dc4pK/jdXXrB4UCmaHpBVqxhHcXtZAgnry0d5BzlY1T1qMD0Ofm7fWZ36pdIpILyPWaX
 vy/qbrc8Ku/K4PHsJtXoS7cqiqqAiJ8Zn+KPRf2iugh5adllAnzV2QIQSys4Fj3Viyxd
 6MZjs4EgJkCjrcw0FLL+BrvEKFzn0SxMpQydDRHCm327t+M0ZfZ22/5CkLEK+MD5y9zL
 IIYp6tZP6+C2kXakqHeBtVFFI55ORfoXRmi4D0KDEBfKy/PdKUqmiHWSBGRT8bNKHNqm
 MJJg==
X-Gm-Message-State: AOJu0Yxe6CMvvqGGuuRwkmFUgG6qKMp2NClG37fQCxf/Xs4rsCztuJBK
 H7UbfZhsDBFL81f/okf4KpKwo/QLGfwYvo4agjdfXDzFa0fVqlGYGMm6+PGGf81yQPmP05erzzJ
 I7B08lg==
X-Google-Smtp-Source: AGHT+IEvo4AB7scWrx8GSV37cdjKgTdZh2c1HhwaSrEVzZcN8z7QW/OxUkIzvWkH3xGP2tIZdifkCg==
X-Received: by 2002:a17:90a:4593:b0:295:2a35:13b8 with SMTP id
 v19-20020a17090a459300b002952a3513b8mr464876pjg.0.1706417013764; 
 Sat, 27 Jan 2024 20:43:33 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 30/33] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
Date: Sun, 28 Jan 2024 14:42:10 +1000
Message-Id: <20240128044213.316480-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move this x86-specific code out of the generic accel/tcg/.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 accel/tcg/cpu-exec.c                |  4 ----
 target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
 target/i386/tcg/tcg-cpu.c           |  1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index ce34b737bb..253b1f561e 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 34d10eb173..2eacd694ea 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -773,13 +773,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  */
 static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
 {
-#if defined(TARGET_I386)
-    return !(interrupt_request & CPU_INTERRUPT_POLL);
-#else
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     return !tcg_ops->need_replay_interrupt
            || tcg_ops->need_replay_interrupt(interrupt_request);
-#endif
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 1cb5a0db45..e6f42282bb 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -127,6 +127,16 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
+bool x86_need_replay_interrupt(int interrupt_request)
+{
+    /*
+     * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
+     * "real" interrupt event later. It does not need to be recorded for
+     * replay purposes.
+     */
+    return !(interrupt_request & CPU_INTERRUPT_POLL);
+}
+
 bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 8e148e9bc4..5bdcf45199 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -123,6 +123,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
+    .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.34.1


