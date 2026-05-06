Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CBCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrG-0000g3-Jh; Wed, 06 May 2026 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcql-0000Ob-V0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:48 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqj-00019v-OC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:43 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a40502e63bso6629531e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076219; x=1778681019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D7xz2BU2ssYT4B/I5t9sqXWgCa5HXT8/ZgAiIOFSxWk=;
 b=PxlfGAkHPE4Y+jeKCdkCWaOKl96E6fpzDsn1Wt2bt0Lk1LxXskwXFuS6ac3hiQ4OZc
 PxoJNV5biWxD0ADKwsyOVyrmv+yZDtHGXy8Re3UNrBsI8ucum+PUvCbCGPxGgZ6pG8VQ
 T6MkLA1Q/Aeq6cP0IMDzlMO7MKdNqMyFwQroEHf/fvPlKHCU+MjwrdfugSU5Y5Y030Yw
 6q/bPaomXJlq3aHMyQ4w0oaStlHTHVPmTzaIhMyvHc5UbkPAs8ODmb3jbduGu90sWdkZ
 GF/1yELjcnwr5mdni7BiqcKIWHgV6Hd/9vBCeli6so3waiq4aeQNe7yB6WurfrSVNDeM
 vzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076219; x=1778681019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D7xz2BU2ssYT4B/I5t9sqXWgCa5HXT8/ZgAiIOFSxWk=;
 b=FRXPiz7Lc89jlPaecFUlwG5HTu4hRvzZi/U1wcZ45pa3aAK6/oEv2ycF7Bsv86VcH+
 tH047x64+Y2cJj3KdxBjY2oLseZ32Df69ut/aWAd5JWkg1omgeDPP3i/7rkUeqdz582F
 X1BSKxWjkS/ZtbU4YTtd8l1D6E9IwKcnsCI5KrxpFSSFj4nCul0OM2kWbi9MZANxSs+b
 l1FM9bvU+uIlzNAM8HUXpnOpPtFIUx4ldSADTCEKupFC6R7s7Xh1ly9Svl5RDpaDNu9b
 qf0YYHFAqF5/Hm5Vsvuoqx9EkdTrBQQS9kCnyiCITG+HfZv7f71e4o2mVKPaDpnHDQOy
 aZTw==
X-Gm-Message-State: AOJu0YzdSMYRhBP5Yq1AaiDESC5EezqyQ+QNrnxokwtxItkIZdT9gK73
 QDyKAiTvpKcPb9PZAzKgZNIeeIy89wrT9BExIdYmbXqMjXfLBI4Z0XLHfGz2CUXgbtmu7s6RbMc
 qznzuOBs=
X-Gm-Gg: AeBDieuECCT28uXjg/S1Qq0SSUdluuIZFBG7tf2FUU7vO7IWwFCOBmGbFKcmIfoxH62
 h3NuOtmm+aqMMv1hEFUfAKrZHQbch2qFOVO4Nns6LE1fyHMZ/9vYnr7nGyywXDlJECQZ3rqq7kX
 PkjOhOgr9+AsZO9nH5Jv+0d1fqog24WGPtZ/9e0P7gN3ag4odxfzV9Z/crO/HWJ0DCz1jX6rogx
 8zQew6kUCOpPYoruNPDi/p6rA+99/cfgLfP2cOM2PS+Z97AOzs10RyCS5q2O8GV/ltkvCbA8wwQ
 m89TmN2c6a4jNjguB3RN6U/iFw+8XK18yf+8euBm1sFudIuBV0gpJV0mkqF1vhq4mehvGRkEwow
 hFUsyKmgVqYvMr3RrXGGiJ0iXdveR1FN0LeH7rLQrRPNkDogUgSeH1m1f9OT/NluD5uJ/wgdUUX
 rVwvs9liFZJ08F5xNyD12K82NKokorSIeybzVOKmxecWOu5V35kbPyp5p1uLPPWgFgHsVlb9rIp
 +CjJX1Y+qw=
X-Received: by 2002:a05:6512:3190:b0:5a3:d1d0:543e with SMTP id
 2adb3069b0e04-5a887ceb431mr1268084e87.36.1778076216843; 
 Wed, 06 May 2026 07:03:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505285e765sm12329164f8f.10.2026.05.06.07.03.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 063/110] target/i386: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Wed,  6 May 2026 15:54:35 +0200
Message-ID: <20260506135524.20617-64-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Restrict x86_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-28-philmd@linaro.org>
---
 target/i386/cpu.c     | 29 +++++++++++++++++++++++++++++
 target/i386/monitor.c | 30 ------------------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index efe7ba014d3..97c66c22262 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -41,6 +41,7 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
+#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
@@ -10843,6 +10844,33 @@ static const Property x86_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
+{
+    CPUArchState *env = mon_get_cpu_env(mon);
+    int64_t ret = env->eip + env->segs[R_CS].base;
+
+    if (!(env->hflags & HF_CS64_MASK)) {
+        ret = (int32_t)ret;
+    }
+    return ret;
+}
+
+static const MonitorDef x86_monitor_defs[] = {
+#define SEG(name, seg) \
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
+    SEG("cs", R_CS)
+    SEG("ds", R_DS)
+    SEG("es", R_ES)
+    SEG("ss", R_SS)
+    SEG("fs", R_FS)
+    SEG("gs", R_GS)
+    { "pc", 0, monitor_get_pc, },
+    { NULL },
+#undef SEG
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10856,6 +10884,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .monitor_defs = x86_monitor_defs,
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 1befb8ea824..a536712c755 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -591,33 +591,3 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
                            flags);
     }
 }
-
-static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    int64_t ret = env->eip + env->segs[R_CS].base;
-
-    if (!(env->hflags & HF_CS64_MASK)) {
-        ret = (int32_t)ret;
-    }
-    return ret;
-}
-
-const MonitorDef monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


