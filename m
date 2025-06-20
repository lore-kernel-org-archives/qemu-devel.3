Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C2CC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfKt-0001fm-5a; Fri, 20 Jun 2025 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKT-0001Hw-IR
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKR-0004Hd-Ny
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453636fa0ceso13437325e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439702; x=1751044502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQF4H7S4J/KumkA9IIMkTsQov5jwGOrtTGEPyYAegEw=;
 b=Hk7rKxAh2CM0nZKz1kgvmrliotU5/IsSRglmEE8Y7aJihoAuDTER7W3v4LaRD0+hYQ
 cuiyXsRr9tG2OkWA9p81nf4gvuSGus1CdCdkvo7oEoWtqwWMXkGCO7w0RsAmz1Eocqec
 eveFa3Y6yAq8Kk4mYYxuyxzQEbdhWXA4l1ku4SDZE2XQJq0L9MFN+5vY5xV6EfWOcPgU
 BNMvFPfYfP3+JnwMWplIOwnAk5A3zqzSBDQajfLWBs9nXZDcT8StMdjtFAhGa5Hsy4Bt
 /VkjqtYS+MEowHSNw9zRCGhKite1qlJGDFkEoypa1QXBlA/DNktXY/SDNuMUhXzfrTS4
 9l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439702; x=1751044502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQF4H7S4J/KumkA9IIMkTsQov5jwGOrtTGEPyYAegEw=;
 b=FQdDLwlbYGWPyGPY+T5UxJV8pSHlSCFdZ8r5FtEtBZ+qntjARxM1W1Mn/KrgkZyt5m
 OFuwYOQfASywzG2uMfzY6527Wr6wVm1tU3MEKf3eYiW/7qtW6F70XTZVAe8AObF/0hCf
 v0o+ipiNbNYDRaTeoklIfGiBDl34wGfclA3S2meSL4n27tUFjUExBVSCVj5AfhuhX+Me
 geqhv/IXCPPvJP6LbfrkOjTYz1PdrUDHOEwOhmI9LpWYV1R26ZNZa/wah0he5Q0AYPZf
 aHI0C6rRhBZwKUJrZ9ylr3mDnmX7nvgisBt4N9bH+RzzDPMZz+U0gSZGddyqrNJI+SBn
 rk6w==
X-Gm-Message-State: AOJu0YxXQyHpFIv7Wkmkufyow1TARq/irpdusU8QvUGwSNvYlFmeH8T0
 5sW1d1Jwhhi7gBcVqOVL4QpvcDw0O3SAIixghKh2BazfgDHSzBRKPS4Q0jzBX2JHwMLDJ3+TLy8
 aCfc/TcM=
X-Gm-Gg: ASbGncsIhVI0NyXqRqRZr8BBzuIn4wVK389XRHKET6g74v7x4RFCZ0L4u32TF2kMq3e
 +6diPlC0VwYDkKFZ3l0VsvmUiQ6VGKWDyzY/7EcbSy/qNl/r0vvEt20ziOstpuoO2SQCw7QmdHZ
 qxL0L0dasB41gxu321SRzjVoqlvxC4sNDniXn/bsA6C8+4CLY2z3bhXKFO22r3WzjJLV5V+K12d
 7GJwKk8cRe5Rsx7QZrOtRmXdO384DWAfkfyuBo1Wg7FccD3y4cTPkoTV0fExJa8TDlpKMAQ+KrV
 XsGNT2gg5w4UwSLoeFF3X0hpV9TNh5r4rAE/GsBE8kpNJap9IsBwfMqMDNQV6TJ5+zisloJQObp
 npi5aV04HF/H+mICxUW+TJIaZ8ZER7F+t9O4OAIrPErIgv3M=
X-Google-Smtp-Source: AGHT+IGgo7xyMUNzSqjyeGJPvBAGdbsmN3AQw7WpdXo5VOc6+5vhP7P041tYB50GyISJgxzgYobtwA==
X-Received: by 2002:adf:8b02:0:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3a6d1330d62mr2259561f8f.50.1750439701688; 
 Fri, 20 Jun 2025 10:15:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd816sm31376135e9.24.2025.06.20.10.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 16/48] accel/tcg: Factor tcg_dump_flush_info() out
Date: Fri, 20 Jun 2025 19:13:09 +0200
Message-ID: <20250620171342.92678-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h |  2 ++
 accel/tcg/monitor.c         | 27 +++++++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..fb265d0cefa 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_dump_flush_info(GString *buf);
+
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 1c182b6bfb5..5f74881f2a3 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -146,11 +146,26 @@ static void tcg_dump_info(GString *buf)
     g_string_append_printf(buf, "[TCG profiler not compiled]\n");
 }
 
+void tcg_dump_flush_info(GString *buf)
+{
+    size_t flush_full, flush_part, flush_elide;
+
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+}
+
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
     struct qht_stats hst;
-    size_t nb_tbs, flush_full, flush_part, flush_elide;
+    size_t nb_tbs;
 
     tcg_tb_foreach(tb_tree_stats_iter, &tst);
     nb_tbs = tst.nb_tbs;
@@ -187,15 +202,7 @@ static void dump_exec_info(GString *buf)
     qht_statistics_destroy(&hst);
 
     g_string_append_printf(buf, "\nStatistics:\n");
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+    tcg_dump_flush_info(buf);
     tcg_dump_info(buf);
 }
 
-- 
2.49.0


