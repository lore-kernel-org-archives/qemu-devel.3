Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A42AD10386
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAJU-0002FE-6z; Wed, 26 Nov 2025 02:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAIY-0000ik-Vr
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:47 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAIV-0003Rv-Ka
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:46 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so33488535e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143442; x=1764748242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=KdBzWpISwyWZSFb8ew5Ot8utkLe7B28W7nI1VNlLjED09lhgVYShDGwaBX9IsOMVGh
 zGIqBd/EPC5YDRiV5wV9dU5nNXD3UcV4kGG/fVEZc8aP+86q0VN0yIqNNRDjbwxlzDSA
 CQi75QPtP3iQuseco8TlZQaGB6/uPXQqmUWwQQ4VBlbDDYjh7b5CvgdRTU5gq39BcHAf
 z06gQUR+bCvVbj6NXmA7NELTsq3kOwoKcanXBUGzr+mfR6BH87lHQ0Da30hl+XEPSu/f
 8344sbJumfjJ7Xfur/YOxl471lynoOj6XNav+Di2gAZG8l/S6cWO3RnoDBEDu7TEDCjK
 ztTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143442; x=1764748242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVumjk0F6Tq93V240FNbMOnFtVOEoBWTLGnL0WT9/nA=;
 b=lC9XCM6mx6Cxl0WrGiGlVtPuIwkVTVCFntwgy0Co5v2bGQLchvQ/UgdIafu2oSxphd
 yTVQvlxXsWIjdarD/K8sxUh2ACdClGbVXh7QXOrhpaqoN5JIFiij/fyloIo3HDKYl2pF
 hw0gTb9i+dWi9D3kUNiwgQyMlt8MrBekh7MFWe5/QDXDBf6Ue1LVkjTMbXud+dX1ZJ4p
 wFtBqfsJLUSAVl73DSHxg61SWIubDc5LSysNjvr2wVr9ftX/aQGUqKJMfUSSeZQb5kYr
 Suy5BYpfMJjL7/mYIW2EOSVjbOJfwsXK5hdUaCwHKAFCqhf4c0gk9xkVw9B2BSFz01cj
 F7cw==
X-Gm-Message-State: AOJu0YzvMpJiM+KavxHETMGQNVGVVYUUPRUb+kY6EL/G+dWEbXrfBcXX
 jqH8cR7Garspr6xVVC2c3Q8eqkaa0k/a0u3aS9cdVR0IlXJDan3zLeeaEImL7RKuT/uINYGNBvj
 Vwx7Y0rICcQ==
X-Gm-Gg: ASbGncvzWn0IxcetEFYQDhLMafl/+wKZaHxaJn2T94ag3SdjfctMBEOHI5bhwz63l2x
 Kg2MQ43Bxxf7ioTlfEHBNeVBuHB1op9s9FXSZhOHRCrMN0mdWkoXp862iSRR6b6UigOW8zQ9voF
 bbzEfShjFLR6Ok7SZHblsETJk7mmqHQgXKTshX+K3zNsDUDWoZj+LYb4k2t0O+0GYiApZrNi8/4
 Bt0688qLGdDe3iWZOdjvPB6KZnD9AubhHVBRddB3UUebP0/9Zwr1hanPqYIIjv5t8Jnv/oKvi1Z
 0x7HUXpgmSiaem3qBshHx6+UGyQwXLp/Lvwm1TWoAwtyLlBKB6GL9yblwJF8sgP1oBdjz1nr3ju
 tG+MsIimZaw6XEHxot8xz7SJsy8xyqbyUG1u9xyvGH5ykCSr2MNN2EsSB3C5J0yrA5wsJHIclf0
 tRvSM74tLhIzHT4z0hXnOOMhQ70cNgexY+gQoqEBv4vygunMofahWjXSOwN66Q
X-Google-Smtp-Source: AGHT+IHq5BuMvjhiLNMoLOizL7thaIziwm/kDXgDoW1syiZCU98ZLsDg+4utHaUdz/xqq/XULDJRrg==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-477c112f7b1mr178290295e9.29.1764143441744; 
 Tue, 25 Nov 2025 23:50:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040cfe17sm37505415e9.5.2025.11.25.23.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:50:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH-for-11.0 v2 05/12] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 08:49:56 +0100
Message-ID: <20251126075003.4826-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126075003.4826-1-philmd@linaro.org>
References: <20251126075003.4826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..83cd491eb4a 100644
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
2.51.0


