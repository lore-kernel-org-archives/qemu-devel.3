Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E87CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBaj-0000uX-DF; Wed, 27 May 2026 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaC-0000gn-Mj
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaA-0001Wj-RW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso20231855e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878029; x=1780482829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u67kjyPTepS/e93MWxOon0fy/0XAdOHZfpnppxqxRLs=;
 b=DLIpx6gOgZq+dvQnhwtXj5nq+Bhmx9hfNUucwlU/lcxtaHCVIjecLylam+g+acHLq+
 6eaVc6McBXiYM9IJFkzvNyWWC5yEOlcB/nNZwfFQFcjvk7LxaAwNiQe3UOPytdLo8XFr
 m0LlL8gfHs9FnBPinbyPRVYindneJ0J/eng/nIoZeSMTRyYS7zrWzXzgIXORSIJq6qEF
 irjsRNpIW0vU+Y1bsumS5wWwWzYTxtZCIgjAzTtSnXukoUy1J6a/G2SHW57HgNDqmrfK
 XkIwSnxRvK+Bm4UvBRuD+zy+EzwKlx2cf33J80sCRWuI26QJN04PuQ/SujY60PYl5JLG
 YkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878029; x=1780482829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u67kjyPTepS/e93MWxOon0fy/0XAdOHZfpnppxqxRLs=;
 b=A1bq+SW6S0hraGsCeO0zUSDCbur1wfSG+etAj5BGCvsvsBb6ipKbQi6SYobrivLMBI
 wYoOnIPBImz/v+gB0LwDJIsTBGi478d28PP4RCmOSz6MMrLMZvSIYGwVHKx+4HVRXhuo
 lC7XjN6I183JnvWrDUJ/sydqvWoGfA1zGeW9UiawswMzunnWZL57Fxt7ZSQQiOkjjM6x
 JOa1CyiePpd/7eZDw94ukW8G/hBpJRpGXhlWtWYJSLt7jApu0R+c7+jLN6Y4foNyYmpF
 Z0vYjZvpvXm0scG0R3YWBoqfGxHre8hqZFfZpDeGYGrkE7zhyaHABefViipoORBaZQYl
 /TAw==
X-Gm-Message-State: AOJu0YzXLNgB+/DKd7zwG53n+suz+uVyeOFC+ObZ2hXtwtAVdBIXy4sN
 5kqrlplVKKC9TFaFGdbSqMevc4XhMnwwNEYdv5UQa7uRfiOYX4kz7ph5QfB/PkMPB8Tg6/OnoIM
 5WpNQES9PQw==
X-Gm-Gg: Acq92OHX2adJzblyzwgBvL1oFLnkC9W+6Hhl7DS2hYYs51zOrH6K1DQZsemZyeq5KEK
 jyuG7QTntVnLA/sq9RxQ1yUpmtjdZ3QWtkTdgZnVTDBf1JEhJUJliq5h4SplGK72mxyTmqRxVBx
 o1gPaWqNH6jJGQPq/kzrZYUxLGDxMlA6VTKO26YmU+lGktIgekKsSRgSIvbPLSYA1YFbBpjiWQY
 06Hn7mUKFI6LWnortttTv3l2NxGKCrotUjEWi3xZLXkzXFNffhmOUqZ6Temof92sScWl23W/4Yc
 dVqzIW5lulSo81W85zjB+XoCk8Zegolh4Vo5Wz/mO/StBG0n5eVacPwuTryJP0yZmKDJnf544Mo
 S5ON0VtaWjoAZpiQCIE+9P02EmvIkW3WpxYtRQND8cK9tXcy1Z5fJYrt62pdP5QEOic8Ea2HDUD
 na6U4QjsAGWuu3XPbSRn6ukWA+/zmLuValoBz9jSgGGDdSchbN9FzB+4ExJR4QAUR25yKywn+kq
 c6D
X-Received: by 2002:a05:600c:4f0f:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-49050e474d4mr359406905e9.3.1779878029003; 
 Wed, 27 May 2026 03:33:49 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm367040605e9.6.2026.05.27.03.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] target/arm: Build cpu-max.c once
Date: Wed, 27 May 2026 12:30:32 +0200
Message-ID: <20260527103037.4461-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
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

Call TargetInfo::target_aarch64() at runtime, allowing to
remove the target-specific TARGET_AARCH64 definition and
build cpu-max.c once as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-18-philmd@linaro.org>
---
 target/arm/cpu-max.c   | 8 ++------
 target/arm/meson.build | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8cf8edc6535..d38bdfcf811 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
@@ -190,12 +191,7 @@ void aa32_max_features(ARMCPU *cpu)
 static void cpu_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-
-#ifdef TARGET_AARCH64
-    const bool aarch64_enabled = true;
-#else
-    const bool aarch64_enabled = false;
-#endif /* !TARGET_AARCH64 */
+    const bool aarch64_enabled = target_aarch64();
 
     if (hwaccel_enabled()) {
         assert(aarch64_enabled);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3e02941d0d5..9408131d178 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,7 +9,6 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
-arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
@@ -20,6 +19,7 @@ arm_common_ss.add(files(
 arm_common_user_system_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
+  'cpu-max.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.53.0


