Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFCFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Yal-00078N-9E; Mon, 29 Apr 2024 17:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yab-00076W-9z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YaX-0003JJ-Ep
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b9dff6be8so24521035e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426263; x=1715031063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhMIv0nTX41VJaDT2tW5U63m9lk1MTRg8M20jzTt/L4=;
 b=tC0sfCAnBc8RsG0aWErESMsHQNoIOPjwmKaH1Y45RD7Y6sAvOASMVBTBLwY14T5UHC
 YwEsNYkuQ3WmRRO020HbXr9YKK8v3c84rKavBur7zy1hCLjysEnu79Gx/56CTrN9vgdQ
 LJco/8TYJdowYbxZdfUZJRtQ/NnwjyuVsaqlOBaV9PD4XhvgzBB6o7I31GgXxlxnc8pZ
 ZOLD7kEFb0+/IcNv9fEXVWFxmRzxSfWwa5QpyqGCFr8NzjcdLaZL49j99hi6n4c/6TuM
 RHv79tpHku2G7iYIcospNsgCPb9MV9FUKa3CRdzWgOjLX5EoXoE+BYDeqxfLHsKptfeP
 iwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426263; x=1715031063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhMIv0nTX41VJaDT2tW5U63m9lk1MTRg8M20jzTt/L4=;
 b=rFAZXCavGkwf7IKql8S0W5nt5Y3QTvZwlScfOROyd9jEr+dGye43PWhyo7tjgGR9su
 qQqD42UQ/3z5vWRql1hqtU0iLyFpbOLVnfW+Wk1aXIUiEx8rmDDZ0ktKCfRuvnSkp6ab
 Jdi8J0KYvyTvQueumHGEqzQR5AToes8iJQWpW3yVlZzPTCFxHSRggjAurHxeZgBavUI4
 Oo/tOCXXyav0X/+4UxCjrCTkqab1gpNJdGfZOnUnOmW0mRhwQ/JgPFamP9L96vwzlRNB
 Y6AgKnBHCeT6GC5fWD9YT7fO8xVHNxuiuzKLs1NG2v3jVGBNTJizOSBr4s5TAtbSBVxw
 l+dg==
X-Gm-Message-State: AOJu0Yz+2n/jE5ufKtryKj0kMBMiF18SU5QdkcjtumptZxuA2TVCW1Pk
 pr/6m1qrItytIc2nwJ6Q8wd6/c0QXbmyeEzXdpaxKOhvF7O3d+Nzbd85MZNse9kNzf0GIRjmS0I
 j254=
X-Google-Smtp-Source: AGHT+IEWJXG9gu8Ew+eJsYjg7wBx7Ck2jDv9C/jKNMJLOn36Xbq9mniwkvfaZrAGp7f+FSIPOgCDPw==
X-Received: by 2002:a5d:6b08:0:b0:34b:b0ac:c63c with SMTP id
 v8-20020a5d6b08000000b0034bb0acc63cmr6937152wrw.66.1714426263310; 
 Mon, 29 Apr 2024 14:31:03 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4844000000b00349f098f4a6sm30322098wrs.53.2024.04.29.14.31.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/13] accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to
 TCG
Date: Mon, 29 Apr 2024 23:30:39 +0200
Message-ID: <20240429213050.55177-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


