Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0BFC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sl-0006Rd-1V; Thu, 23 Jan 2025 18:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6se-0006Nw-4W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sb-0003zl-B2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso10192185e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675895; x=1738280695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgM0qO1a7TmnAaVr92PdlZQNV8dbDE9Lo8CXyhKvg/4=;
 b=XRbsaPaW/Mjo1pMNwc4umgoghtu4Qy8WcsPBBfhFdo+xb1lmAOxV8cCd5fnnYGMDPy
 5IUpKlcaE/GYE9IRaxsBIyj66D/9ZinJEFAPL5tUF9Xr1729EnrCZfUa1/iitQvJDxV/
 jCPUeMLjz/01iAYwVxyNh/XfRyRe0hkRFYJe5y1oovwWZKS3Z6aF7xhLkwc1J7SmRehJ
 tyg8CfxxfatD/6k1Xoz0XIJGzLE44RoPcQMtgHnhIvkMKP5gzYXePL7VsL6D6Ovc+aLq
 Pme1tw6MVqN8aV4ptz8igF4LtnVNWUoc7VDA8mAIEh25Nmq2dNZ/4NLuzfYCADsb6pYB
 WMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675895; x=1738280695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgM0qO1a7TmnAaVr92PdlZQNV8dbDE9Lo8CXyhKvg/4=;
 b=aO4ChTAdAQ3yzHwLBciw/q+LOs9IrgNKtMRRe65yS045Qt6SHxByz7HvxYh7lUnoAv
 W2zmzDw/5o+K+rsGdKivGI29cWXJzfmac7YBrgUpP24Fno6Olm+r5ZMjv/UjV93qeR7v
 nMTp7SUUmK3Zdcs3bvA8UPKZ/3zQ6NMBHo19nceBy82Qdv1O+/8kI4BkoSiBZixq7bnM
 6FIQaxapsVE49ZBzEvZr/Nz4sZbwKziPIRKzjrzc0EwfrQywsLP5EhiCHx5XDXsQfYpB
 IOHSYSZn5jAXK7lG0yOInI1dqDXv0MPmhAuGg5mmnffzSCzfz3QgbsZiadTI7OjltTID
 tHCg==
X-Gm-Message-State: AOJu0Yw1snTyi0NWkWOet2pfTx68bwf8SCTEp7fK3x4IwvHdgaB95J10
 4kC+c0jpeTshtpgvky4vzPEW2Jd6TqWbctQtegxlX67BekQ0Q5XgUHkRq1EOpIUBLKOqvD34TWo
 mkjw=
X-Gm-Gg: ASbGncvD/9K8jnA5k1i7DzJ1iLHie5Bh9TAjjp8lBVuIwDx/ubQwiJI1U/1MVptuEwL
 TTtLNfdXTpaRoGV49vjTw6TcsStl2qgDdgO/1g2DhI6+zNlcc5iFuZVmWYV1KUhAbeUyVctRJjo
 5sXxO+PtoaIgSjeF6o5VvXhzqmASpXlMhHt9wB6Lld5SXeQkfO6Q6JOZJrr3kx54OWedFAZjUyy
 oZ7Cbi3POsOrcXVG8RgDjJPagiFSK+4CdRG1POOEq8T1FHLRGdRIJjDeGB/etNYMZnqazVpSCBV
 UGJjQYGIfH4ntFHpILQnraUFJly0mBbYscvIdZdiTSPApLDP+0V1oVs=
X-Google-Smtp-Source: AGHT+IFu3bGh+dR4gXvA0Xd23GoBCnM+yfw+G3EPNj4Vc2jg+fj1VnlHOFgKCDXygKj5XAozIyeBjA==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-438913f86dcmr267603485e9.18.1737675895459; 
 Thu, 23 Jan 2025 15:44:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a94asm7141855e9.23.2025.01.23.15.44.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/20] accel/tcg: Build tcg_flags helpers as common code
Date: Fri, 24 Jan 2025 00:44:01 +0100
Message-ID: <20250123234415.59850-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While cpu-exec.c is build for each target,tcg_flags helpers
aren't target specific. Move them to cpu-exec-common.c to
build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec-common.c | 33 +++++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c        | 32 --------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 6ecfc4e7c21..100746d555a 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/log.h"
 #include "system/cpus.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
@@ -25,6 +26,38 @@
 
 bool tcg_allowed;
 
+bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
+{
+    return cpu->tcg_cflags & flags;
+}
+
+void tcg_cflags_set(CPUState *cpu, uint32_t flags)
+{
+    cpu->tcg_cflags |= flags;
+}
+
+uint32_t curr_cflags(CPUState *cpu)
+{
+    uint32_t cflags = cpu->tcg_cflags;
+
+    /*
+     * Record gdb single-step.  We should be exiting the TB by raising
+     * EXCP_DEBUG, but to simplify other tests, disable chaining too.
+     *
+     * For singlestep and -d nochain, suppress goto_tb so that
+     * we can log -d cpu,exec after every TB.
+     */
+    if (unlikely(cpu->singlestep_enabled)) {
+        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_SINGLE_STEP | 1;
+    } else if (qatomic_read(&one_insn_per_tb)) {
+        cflags |= CF_NO_GOTO_TB | 1;
+    } else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
+        cflags |= CF_NO_GOTO_TB;
+    }
+
+    return cflags;
+}
+
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8b773d88478..be2ba199d3d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -148,38 +148,6 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 }
 #endif /* CONFIG USER ONLY */
 
-bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
-{
-    return cpu->tcg_cflags & flags;
-}
-
-void tcg_cflags_set(CPUState *cpu, uint32_t flags)
-{
-    cpu->tcg_cflags |= flags;
-}
-
-uint32_t curr_cflags(CPUState *cpu)
-{
-    uint32_t cflags = cpu->tcg_cflags;
-
-    /*
-     * Record gdb single-step.  We should be exiting the TB by raising
-     * EXCP_DEBUG, but to simplify other tests, disable chaining too.
-     *
-     * For singlestep and -d nochain, suppress goto_tb so that
-     * we can log -d cpu,exec after every TB.
-     */
-    if (unlikely(cpu->singlestep_enabled)) {
-        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_SINGLE_STEP | 1;
-    } else if (qatomic_read(&one_insn_per_tb)) {
-        cflags |= CF_NO_GOTO_TB | 1;
-    } else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        cflags |= CF_NO_GOTO_TB;
-    }
-
-    return cflags;
-}
-
 struct tb_desc {
     vaddr pc;
     uint64_t cs_base;
-- 
2.47.1


