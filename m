Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15213C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdS-0005M9-SN; Tue, 21 Jan 2025 06:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdP-0005K9-GD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:31 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdG-0003NF-Bn
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so27433875e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459676; x=1738064476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UK2TrLeD2Zn1+uH64aqzpAn7UZ7ZT3zI/v5l0LjGSTY=;
 b=CToApptADlKARC2KiWU1ItmAYUZk/B/+7UhFTecRAYVkFTd+8gEFiLuyjqSsaYaDpt
 VsY8Xy0pgcjgsc0N7+Yco0QtL9gwVBDX1HNAm8sjiImu4N6f9mET0W93ouXtkdWZLLH4
 HGDzOBLyZHRZbszixj3Onu1h5+3CpsJAAhgM9paDDkO6fhuhjOo/bXX2e8i/GBRufj3C
 q3zQbXgLG49iBVV8tL3b0aQvwNS1e4GIjh+U27qxGyTJ4ZKtvvAoRow1qY+Ogqad5n9H
 rec8fitlw1kfB9osyTsPsXgKbueMRhXalCh5Fl4ABVbCf0mrRbQHYUxFpL7r6Gh9e0Ys
 /ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459676; x=1738064476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK2TrLeD2Zn1+uH64aqzpAn7UZ7ZT3zI/v5l0LjGSTY=;
 b=JoDqfFNhGS45buuJODURnZRfA3fKVaVOgB18pRhwlGkrBEfzN9tLUt3kIlNP02RvmC
 2v23SMt4UkAorkTwF7g6a4oupFHZW143Cl4ffbY3HFO2rK3gqeBVc6rBO2jZo3aCwDFc
 0WKBrHPvIhdVDBW0EEWtaf0Rr0AS10x94CSgxr4Pr1p5ZYzL0ZVxVHJBsp4tRaZPx7a3
 tPm8KQ4qMAQPPoKqjlhTeXnLXK5Qi3tqFqxKGCh/fVsL7y2QyJNJFv23hou5knwGwxgh
 Vv1DlTGXtdusfA3JBWBlloR7hCcK2hkHFFCr88+iCQrQd5JJSXrKUoG2WsNaj95KLBQa
 dcJw==
X-Gm-Message-State: AOJu0YzF5Kcj3z/XM0lhLofPRSsPDOqByyf877DHZadVwBhkjxXn0r20
 5wM0PVgEdsMjxRq9nQQwnCnV7FdR1UlZRHQg6YvamPVrkKwo5MTeKWWJKv5VnhZ5BfCl0BbU2Mi
 zKpU=
X-Gm-Gg: ASbGncspnAuF3MR3MAZzvbyFRO4uF12z1Kj2OzkkQ3/77/+/TGcE8R5RsLx5E5revwU
 fYJET1XhyEKBVKoWfngVE5tz66i+APRX8iZgtWufWcRrWT4+wFvKnECXpGNPo4v83MOQ7hvWPpZ
 nOsLAz+Ojwckgwi1CpEwqr4v8zkMvxTGwlpbgSgQ/6/02NN44KBmyc/iFRzTn3TotLppzXxIDH3
 7R+kA3og1GVAdy+IK5PaPEGPsZD4Z/xjT2xprRmxwnGRHdcW1YHnHkfTxnwBve63O+gNUez5LgQ
 WoXjVctta0IeMJ8uvv/6PN6jMX0dPDHSfLW0o4DXbIcz
X-Google-Smtp-Source: AGHT+IEGMsuskHAZZ9w4pwzHFYH3HntWs1FX387Dlx0h/AuPPOB/Ktl0DAeXr4nCplNVVZ5CWeOAQQ==
X-Received: by 2002:a05:6000:2a7:b0:38a:615c:8225 with SMTP id
 ffacd0b85a97d-38bf577ff42mr16730772f8f.15.1737459676557; 
 Tue, 21 Jan 2025 03:41:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327ded8sm12932429f8f.89.2025.01.21.03.41.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/11] user: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:49 +0100
Message-ID: <20250121114056.53949-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/alpha/target_proc.h | 2 +-
 bsd-user/signal.c              | 4 ++--
 linux-user/signal.c            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index dac37dffc9d..da437ee0e56 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -15,7 +15,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
     const char *p, *q;
     int t;
 
-    p = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env))));
+    p = object_class_get_name(OBJECT_CLASS(env_cpu(cpu_env)->cc));
     q = strchr(p, '-');
     t = q - p;
     assert(t < sizeof(model));
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b4e1458237a..4e32cd64f18 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -1021,7 +1021,7 @@ void process_pending_signals(CPUArchState *env)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -1037,7 +1037,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 087c4d270e4..53b40e82261 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -743,7 +743,7 @@ void force_sigsegv(int oldsig)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -759,7 +759,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
-- 
2.47.1


