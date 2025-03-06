Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B57C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDSX-0007lV-6S; Thu, 06 Mar 2025 10:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSO-0007jq-2Z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSK-0006Fk-56
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bdc607c16so6556855e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276094; x=1741880894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M9A95hGDz5OZUoNsympsnyo0yFXJkzG7hpn3X+K4ObM=;
 b=dAbFVFq7kq8b49w8+fUpHWcCb9U8aFnyNRJUH2vKa5Fc5TXF0DWTioMOm9YZkQiZg8
 2Nqsuul9x1DJ4myHjgvt+HPv86wjXAVYcx43hg4eX+1aVEL3JN96gwtKogqAZNOkpJJW
 tY/x9vwRETkV98V1PhghPkLjR0t8YEsiMoZAh4H80u5iRXvFC8nyQgEI8NWQzVekWCbi
 6QvT7OTQfHMZrpTXGVIIqiYRS2Q3ofSD7o3Gh+CI+GnezuyTtcp9jEeh56hnun3VxWJc
 jyxU3bO9JeRuaKlit+ZLB8OdTpNNqWSFUZD9LabMhJ7fHS3OjqvyuGFASCdYmrdTXaJu
 OKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276094; x=1741880894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9A95hGDz5OZUoNsympsnyo0yFXJkzG7hpn3X+K4ObM=;
 b=gzABuwbg3zhnb1NQ8YoM+SQNTyIy/5znFVR+VxCeKjMNDUMx9NxzP9zZHLCjRIInSn
 0UFLBUVe73umomVPBWy98bZ5w/yl7ve6AhKH3cJHiej593Y/8ztT7efmffcx7ZfvQ4LK
 LuJyQ3O7ij3hDpLJawZCf40I1ZcOV8Zz1Q+t0PkrGcw5lFbgpF/YkUE1DS4Fy9F1lfOj
 fgN7S23AFjqnaqXGxxjENnZ19PPM474blKAaQIgUoZdzZIx9leBYPnmBngLa/3P8h07a
 Xzv3HTjb0GViQNORbv8mZfMDPXorq4aFDt66i0ug8mkH8GfWJH7xf43nvlUUHwSwMHhN
 oTdQ==
X-Gm-Message-State: AOJu0YyeJ4GkO9rrj2aPgPSssZjXBBFf2MsC4mkkwMkK8LLyDFhm/NbL
 YNIpbvgoorsGYJPrhiEbe75QICxNXCGxBFioxnx+PWJmDNOI3a2dHUNv1g1/Y53fVBeNUZtLSCj
 Nir0=
X-Gm-Gg: ASbGnctpySGg1KsURS0HHgetDaqHjMhZ7KjU5T7tvNscqypq90Z4piUPOIwXwiGtyvR
 Tt/nhWlMezzammYsPPnQFLFY4Hb/d3xMuluOaS5KRd/FpKDomodb4JYjOybMmaizpbPyy8YYfAx
 we20au6gphvTCsc3mp0j+0YdREXxr5RnBUi8N+sWYAEKEHJP2mR00YczrAiAh+G+pEUzZTnvW72
 /qa/Zr8tqDD65H+XRFRE8U4rbjrlLXwMlI830z3yhUMoHBHSnRrzw5SEUJ9eGiCuGLEN31nVSNH
 Xk+bFsiXZEXvvJQSnyvPxdZrrde1QbagCpgk12GLSfVvNKNY/Iz4erwteBrL9Cj+j+PVXOmzjxa
 QhOS6owPC4lx9wjZf2Gw=
X-Google-Smtp-Source: AGHT+IFz6mzpqHceLw8FKO7IXH1mBQK5UFN4W3Xbql906zu/kOUOh+xpQKO4rgdDnNnGIKjdQrRgdA==
X-Received: by 2002:a05:600c:354a:b0:439:6ab6:5d45 with SMTP id
 5b1f17b1804b1-43bd2ae5e59mr54759715e9.28.1741276094257; 
 Thu, 06 Mar 2025 07:48:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5b33sm55877805e9.22.2025.03.06.07.48.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/54] accel/tcg: Build tcg_flags helpers as common code
Date: Thu,  6 Mar 2025 16:46:50 +0100
Message-ID: <20250306154737.70886-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

While cpu-exec.c is build for each target,tcg_flags helpers
aren't target specific. Move them to cpu-exec-common.c to
build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-8-philmd@linaro.org>
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


