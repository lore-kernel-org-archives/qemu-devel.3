Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6538FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mb0-0006Dz-Am; Tue, 30 Apr 2024 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1maw-0006DX-VQ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mat-0001lX-VZ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so9169050a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480102; x=1715084902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhMIv0nTX41VJaDT2tW5U63m9lk1MTRg8M20jzTt/L4=;
 b=e4irXKU/y8vJ+jqQR4tKQdlZWKjHdnfUJ2wjGcgQaLevApi1ZFTWhun4ZwDHS0PBKZ
 seDIB1Al2Cv67i5JKJ7u/SQghsOYxqGHbX9hce08nViy2lZtDXU9hVVfciAWT3pEr+KS
 bLb4ikD7pxi1rPMdiE0lcL/0ruOeAtkWuZGDcWjAr/I/W/0h6yuneKUzP35ttwoOxesK
 ph4Xn71vT/AVoK4jE0vSBR8E81LLm3gEZpSEWXHATvrpr8RTaq690NUS3jTlxmAYzTtr
 wIv71vT+vPcNdnmuQAgdm+DKx2vs53KoslWek8VnlY2+2pjVML+xky9NJ+0TfaG5P1SN
 VwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480102; x=1715084902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhMIv0nTX41VJaDT2tW5U63m9lk1MTRg8M20jzTt/L4=;
 b=jO3YkaWgupqcrh9QTR+aSg5eo7zBN+gaj/aSeU2LOC2Pr/HJ6V551bv110npnIRP90
 4UMeJJj8vPHLNDqry+GSt/gsD0b93wGB2fd+OSH7FVwC8p9vvjiwQJqzc/nhNriEdJLO
 lcK/dD7Zw8XgzaI9A0tlJhGHMwMnA5+aZMhf+OU/iU6tp638KoS+pmzeaD7sm/poo7xE
 U7IIG2Q299w75HsSG6qF3zkpXhpg+LUS3AsIEFm8wgi/VrZ1KtY4W6SVvcVJLfiv++Vi
 6rlo1/wCAjmJt9lWbwOiO5jU2doZJc8Mtf7tY6FN9cQ5kIsHqo+j1AApkXra4ZclDuKR
 GILQ==
X-Gm-Message-State: AOJu0YzlqxbdmtJA4hTkg3uuMGbBcUk0zYyAZJPGWqSYBZRCrKQ9ntH0
 PgNasvzOm21WPGiQEMPaXVAVAixemupGUq9ANT169UukYRYeUyE8MATBINZmCpclA3Cjlc8h3X0
 h
X-Google-Smtp-Source: AGHT+IGW6ChIGzYhHlljIYcQapjkWL32bq8Gw8LrxJYLaC6vJAImlRGmolk4FhfR43qwwOOXnv1PvA==
X-Received: by 2002:a05:6402:1343:b0:572:940a:dc11 with SMTP id
 y3-20020a056402134300b00572940adc11mr2416392edw.0.1714480102134; 
 Tue, 30 Apr 2024 05:28:22 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 c8-20020a50d648000000b0057232df2e5dsm7131513edj.32.2024.04.30.05.28.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/13] accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to
 TCG
Date: Tue, 30 Apr 2024 14:27:56 +0200
Message-ID: <20240430122808.72025-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

So far cpu_plugin_mem_cbs_enabled() is only called from
TCG, so reduce it to accel/tcg/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <5f59c754-44e5-4743-a2dd-87ef8e13eadf@linaro.org>
---
 accel/tcg/internal-common.h | 17 +++++++++++++++++
 include/hw/core/cpu.h       | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index df317e7496..5061687900 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -24,6 +24,23 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !tcg_cflags_has(cs, CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
+/**
+ * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
+ * @cs: CPUState pointer
+ *
+ * The memory callbacks are installed if a plugin has instrumented an
+ * instruction for memory. This can be useful to know if you want to
+ * force a slow path for a series of memory accesses.
+ */
+static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    return !!cpu->plugin_mem_cbs;
+#else
+    return false;
+#endif
+}
+
 void tcg_cpu_exit(CPUState *cpu);
 
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index beb37342e9..55555be618 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1109,23 +1109,6 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 #endif
 
-/**
- * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
- * @cs: CPUState pointer
- *
- * The memory callbacks are installed if a plugin has instrumented an
- * instruction for memory. This can be useful to know if you want to
- * force a slow path for a series of memory accesses.
- */
-static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
-{
-#ifdef CONFIG_PLUGIN
-    return !!cpu->plugin_mem_cbs;
-#else
-    return false;
-#endif
-}
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
-- 
2.41.0


