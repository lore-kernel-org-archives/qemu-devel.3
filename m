Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A63CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt89-00024w-GG; Mon, 08 Apr 2024 13:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt88-00024P-0e
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt86-0003h5-5W
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a53b331400so621597a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598601; x=1713203401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfjee8xnAWAqUG6v01hjOGqeRqgvt7J3PQW0EStNCoU=;
 b=SPjpghaViSqRrMMP76lghwJVRsiceli3s9fC7zfFfZEdzN6jpTKBBB9hec4Pl1zpxt
 H0rqVwdbizDCQRtgtKqeExb2p0ejVGo/Zy6jjuEL4L/Woqio0coJro8WVr7cTbfJiN2W
 +h1Fdo8ZxvaTROeFZxAhyeWWfX39qG/ETNdmeR1DgbgAUZgzqleNgUF1ELHODnbMpE8a
 OmL+W54zZxnEEwBmxKbnt/O6xLcLmjIObnqsRy0ddpm6jKr0GWz/BTMf+pX7AA4oLENW
 Dyceyn5bmOV+i7KXxv/EUEq91C+QCbwEkd2so3MyJtXG03KYAzjkYUCgKa1i4gK+cYwY
 ln9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598601; x=1713203401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bfjee8xnAWAqUG6v01hjOGqeRqgvt7J3PQW0EStNCoU=;
 b=HpFX2BQMHkDAI9bIg87NvMdIFJlPMbrwnWt4sZffo3JczUrm5lGxCX6qfM/g7gsO54
 jinkusJfJJdXLQrWiXJim7d1L9kWxe+n4AXQTQoSYz/EkFgPiAcQcDgMp0DyKlEUkCwG
 J1kg7nGA3NVuCsdaQxz/AxzaKJ30EgdN+JS/6Jq7jBt+lxqyqjMV0jygyhNt9j4guqZN
 X4kPCBAneT23O7rcAPZJtcW7rKG+1yFRPjxvYDE//axKZ5QTKBgmbN+FayPTfaONaJPh
 FB1Km5OW3SkDD/2YhAyYLoWhkYA4fs1kGVp+9dQsbVs0z2QKDbeXvYixxEjFvFcaAWhx
 NRYw==
X-Gm-Message-State: AOJu0Yx771OLrfujNEo156aa9CZuUIWecPQ/+v2GKUVCBz1L0Rvj9EFy
 J5AkxKpfKqSqiO4mkHSJeTvR8PY1KSBY9wM0GiAFMI22UQt/G1SKu+hRHbOD8PrpbNCLqE1rbsj
 a
X-Google-Smtp-Source: AGHT+IGk6lzP/PfMuA9KgBb9nV6BTuETO64H1abAR7PIZAZRDxjYn60o/BaBVBuyxny/X8iLHbdQkQ==
X-Received: by 2002:a17:90a:1c96:b0:2a0:4c3b:2c39 with SMTP id
 t22-20020a17090a1c9600b002a04c3b2c39mr7526161pjt.23.1712598600960; 
 Mon, 08 Apr 2024 10:50:00 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/35] accel/tcg: Add insn_start to DisasContextBase
Date: Mon,  8 Apr 2024 07:49:14 -1000
Message-Id: <20240408174929.862917-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

This is currently target-specific for many; begin making it
target independent.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 3 +++
 accel/tcg/translator.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51624feb10..ceaeca8c91 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -74,6 +74,8 @@ typedef enum DisasJumpType {
  * @singlestep_enabled: "Hardware" single stepping enabled.
  * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @insn_start: The last op emitted by the insn_start hook,
+ *              which is expected to be INDEX_op_insn_start.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -87,6 +89,7 @@ typedef struct DisasContextBase {
     bool singlestep_enabled;
     int8_t saved_can_do_io;
     bool plugin_enabled;
+    struct TCGOp *insn_start;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..ae61c154c2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -140,6 +140,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->saved_can_do_io = -1;
+    db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
@@ -157,6 +158,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     while (true) {
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
+        db->insn_start = tcg_last_op();
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
-- 
2.34.1


