Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B74CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnl-0003UT-WA; Mon, 12 Jan 2026 17:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnU-0001qi-UM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnT-0003fN-Do
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso28468215e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258441; x=1768863241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/pnimPG9R8XWMr4Jh5OyK9ONvCYCh5KRvpbaYIrsAcY=;
 b=kVKfjrSYBlPnrry+mEXtJUfhNpUMxxb13E1tynBsMXXokCgX/yBjLK49wHrI5lwIfK
 +Jczqpme4vW9xd3DYkO1p2hETOo9xTmSeXt53hRW14hcUgDybWtYPawczHSnje0CK2Wf
 x0gEIQws3XKygS0Dgh7c9vCVdtwKblXE+06mJfvzdhioPzHqYz2MS00jQQq8xsWOAEsX
 GwkvRM7Gyu5C1G5SsIuRcSyf1bxRi/9H0JYFLgKwI54MNfJfbsRL5Frz5D3eHPIlbnKR
 /ko4+R7qTczTvTD+59Ge0aRqKbimaOIAhFuEez6LlJDRDJbMZfwI5/Wgsc4bB2VXuKSs
 q1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258441; x=1768863241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/pnimPG9R8XWMr4Jh5OyK9ONvCYCh5KRvpbaYIrsAcY=;
 b=MGUFeNgIW6MGwIC71/pMtCMzFa2F9NH3WoyWYc8LtmOjYEzcfoyApjCB6ak8Y6ECGf
 PKkILcxkvaOsRVD9cR/Jt5Xt/V6HbM35f8y+oi989NdjlhYZHzs77mJykJOdCpHt6M+t
 Y0i/q3u2+2kx3exZypPohWW8Wtf4969cJAlx3u5Q2akS/oF+9azwcv1T3QCk1OajIR6m
 uMrllobkyZXQhh7uwvoBAvcwvSrpgJ00en+j176g+rrF1GOMF71PukHhJfk95I755L0d
 5hlgN3o1rrZ1CDpd0c6VxvFFfCsgpMEdtcX/QWUGmRSgu85wYNWP/fTGIs7LsBv7l4Q8
 asIQ==
X-Gm-Message-State: AOJu0YxEVjkkpBb6gWdd9UCAbixn0w7HVB6hGOWM9JW1qJLi0oonjZPH
 yck2JBYFIWf7qrJFSQAow3wpviBdAwP088fvPJt5e1PDrF1CrE019L+u8EFtdW3wPMmALmtu6pj
 5gfXP8ao=
X-Gm-Gg: AY/fxX4hLBswViFJsCkWmNhl7jj3Y6cM2RcmCBg21HYRFhuEsFFl8ndiTWGXceDRa8t
 Th5DEJUcPxNvXdptEjzbweDg1Bk6f0RLIWEpnE+xF4HZcTIjSKvRzaYvonCZMBZq5mkDj+7uJZj
 r6Q8t3PQhsBF5lXy4YFhwOOtgwASW2vMQEVTlsdfbQvZTm9J42rXzvDn/+GlxcndP1QqiXtJTmK
 QSb2Dv+qfA5hHwqknZN1oY8wYislRIBLYb8PXmnxwxtSP6NPB4GTloMvzZ97TuxCKDXuJSqffPU
 7pVN8HVOh8Vapmw8R6wau5RlgiMRdBZtjDNxwKgJWLuWgEHiU2H6Nl0GpbLbYnV0QWbC2V4xh4j
 Vk521N55NW3RYarI0lPM2yiIFpc54bc6MvC0/dMhaE3Dlx+9yA0rWHZ/XUMSI641Els7Djt+6gW
 yPyUY5cGlgXirYjaTx/m/Gem3XzM2d7uOS/QA36M9wDbkUkt7trRU6WwQiFFhF
X-Google-Smtp-Source: AGHT+IGvNF9bA9iSMht78O00lwrlRz6ZQ9tPoU2ylLhe8KevPva4Ib7lwL5Y93u6jscsXxvpkwagMg==
X-Received: by 2002:a05:600c:8b43:b0:47d:264e:b37d with SMTP id
 5b1f17b1804b1-47d84b36a01mr221683935e9.22.1768258441461; 
 Mon, 12 Jan 2026 14:54:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ecf6a5466sm91705475e9.11.2026.01.12.14.54.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/61] target/rx: Use little-endian variant of cpu_ld/st_data*()
Date: Mon, 12 Jan 2026 23:48:39 +0100
Message-ID: <20260112224857.42068-45-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We only build the RX target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=rx; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251126202200.23100-5-philmd@linaro.org>
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 9a78f1457f5..daaeeec1b5c 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
     } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        cpu_stl_le_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
         env->psw_ipl = env->ack_ipl;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         qemu_set_irq(env->ack, env->ack_irq);
@@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         const char *expname = "unknown exception";
 
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
+        cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
-            env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
+            env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
         if (vec == 30) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 2b190a4b2cf..ca3e9e85fc7 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
                                  abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
-    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
 void helper_sstr(CPURXState *env, uint32_t sz)
-- 
2.52.0


