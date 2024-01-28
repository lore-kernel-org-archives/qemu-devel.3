Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43240C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx1G-0005uP-Tm; Sat, 27 Jan 2024 23:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx15-0005SV-BT
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:35 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx12-0004PZ-TC
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:34 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-595d24ad466so1276761eaf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417011; x=1707021811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg3ZIcWG7UYKvaB8+csAeQhagpxbl+IqGiAj8oTWzCY=;
 b=StlyHfKMb0LHjd4ZewQe1QsID+2+iuXKlqSeFEdQnS3VgA5Xcnmo0Ol84wvZJQieVU
 /rjYBqmO2LtTNGaB/g/F3VO5RM86BKl0gIcYVe7hLZhHloybqLyZs6rRpFHvSjZWQ2rN
 ShfuE1rhSIYGyQGGE8TM8Aje67I70nuoT7/E7/OfqTOuhs94AjtpDf11znZe4kfXLYo1
 8B0ew09pDzfc9JdRoCDqoVCw73QrJrfm3MhPDK0zyWqVrfLN0rKi6Y0IJ44dcu8Yto1f
 ZpYG+39osUPCb7pZvFEsZj0ADmYO1pm715JzB26hz7MQHeR9MemaSwWswy4shTUJq4ap
 sGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417011; x=1707021811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qg3ZIcWG7UYKvaB8+csAeQhagpxbl+IqGiAj8oTWzCY=;
 b=D5hRY4HSmg0jE2+JchcC4v9A44TK2eBz7EM2j6SKlnN//967Ac9L0o+z6P0+ciGq0A
 522fc5BCcKZeYVGd9ckMMyFKT/uqslNRebTF4ejcBIpHBPYt01IUEN9a6QfaH4gENjYF
 kjfvTRQgfehkpEeBA3HIaJuLrfjYHErOUtgeaBN/+JMpcciFAlCDVj29Zcau0YmHAO5B
 6mLStscW25SKE0yyP5Yr7X3HyJay8TeOFp76n/5oA+QqtY64GhwgSPKCr/eXqhNP49qC
 ttHhn5zY4f9OC5/Gvm2ruTg3i5v0xnY4lCd5E1ct/kwLGFGn8ryVy/U1Wjt86ZTvibrO
 qSpg==
X-Gm-Message-State: AOJu0YxmVj/+r/yAUD2/C/8XKIOZRpkhKA80bUOutDs/074YelYSf5Wx
 IbbrYkE3cqtkpa1khRznZXwct/Zl2EiAl6+85bKWUtNQSh4xtfPmMhul0UPX9Kz4y82pMRrKuzG
 cXr04BA==
X-Google-Smtp-Source: AGHT+IHytXqW2/yfFlmP56TDc9ZuGQJGqJl06KeRkEMjv+HymexrcpKzJRPs4wOUYj6o2YToe3TozA==
X-Received: by 2002:a05:6358:2910:b0:176:abf:3777 with SMTP id
 y16-20020a056358291000b001760abf3777mr3576077rwb.28.1706417010678; 
 Sat, 27 Jan 2024 20:43:30 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 29/33] accel/tcg: Introduce TCGCPUOps::need_replay_interrupt()
 handler
Date: Sun, 28 Jan 2024 14:42:09 +1000
Message-Id: <20240128044213.316480-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

In order to make accel/tcg/ target agnostic,
introduce the need_replay_interrupt() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Message-Id: <20240124101639.30056-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 5 +++++
 accel/tcg/cpu-exec.c          | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 3ed279836f..013867b890 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -166,6 +166,11 @@ struct TCGCPUOps {
      */
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
+    /**
+     * @need_replay_interrupt: Return %true if @interrupt_request
+     * needs to be recorded for replay purposes.
+     */
+    bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
 #endif /* NEED_CPU_H */
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3aebf46849..34d10eb173 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -771,12 +771,14 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  * "real" interrupt event later. It does not need to be recorded for
  * replay purposes.
  */
-static inline bool need_replay_interrupt(int interrupt_request)
+static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
 {
 #if defined(TARGET_I386)
     return !(interrupt_request & CPU_INTERRUPT_POLL);
 #else
-    return true;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+    return !tcg_ops->need_replay_interrupt
+           || tcg_ops->need_replay_interrupt(interrupt_request);
 #endif
 }
 #endif /* !CONFIG_USER_ONLY */
@@ -864,7 +866,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
             if (tcg_ops->cpu_exec_interrupt &&
                 tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
-                if (need_replay_interrupt(interrupt_request)) {
+                if (need_replay_interrupt(cpu, interrupt_request)) {
                     replay_interrupt();
                 }
                 /*
-- 
2.34.1


