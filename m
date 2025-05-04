Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76587C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv2-00027H-3F; Sun, 04 May 2025 01:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuv-00023H-NR
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRut-0004Jf-Gy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e033a3a07so34878735ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336570; x=1746941370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=HO7NUhSpWGW3sqS5z2fuDXmSJhdzOYSxk8IfJUq1QHRnturIPATl6tgHC2mEXVlBg0
 FJnA/ueVGIsZTyj98N/+LHi0vkO+F9DoKYgMBkJiWbItfp39JUvsLTTW4dkaN8yan5VX
 dwjmwpWyNEfwWPx700kGux7k0RR1lg/b4AiBQKCO/cYm+dlSnC5GTVeeO5GdDDWfGSPi
 NeCXrmg/0Q5neJvYl+Dej85vQ/84wVzALgvnmcyegZCQIesYZLNG/9U2Ods6F+dgDYy5
 3uDj6aFI9Zl36Ed36OoK1z59r/1oY9gvOXGwMRTfArbVFAAbpAEa2FHsUrFFKXG6ioz9
 rSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336570; x=1746941370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=W8htgbhEU6xgRgQUCT0AGi2aXFThEZlGAuANG0DxkeRB8GfLthQijtmdnxaUOCggmI
 9+fzOLFig0P5rhKB5a37rBxaybGCrJUgXdqkHyl/IELw0Ef8e9gXe+1Q+M0CgJG+EB4q
 62OG8Y8V8PuGB2pTF3IojFe52e/C8dFAsGXkRl6aL+6nGeNqZ6IbraSqLCtG3ewjxOb5
 V7pyPD/oqG5KnG/Sm++L4gidCG38XgoYdRtDnN6SA9VE1dGpz3gx+oJmbgLoqbch3TOP
 gcop/sFObYKuxrYI0+bY2vaUSuU9ZqfRxvz0sT6uXM/7WawNBw7BP4E7Tx/zU8Ly4ytF
 /4mg==
X-Gm-Message-State: AOJu0YzJNl6VMWvwgnsODHNqU5SQ1/bHGpRMOc3rVEg5x7Oc818rRqAD
 LaEtkvD4lqU3VIYyGX8oqTptLloeYnDqbgFCfqWitWoFcBrv6zW0YSQNLQi4HMIJiryhjTTFXg3
 zN5k=
X-Gm-Gg: ASbGnctBUs4IZk1KDUQZ2rhc7/FUtoZ1d0s68H+X4cQW8J31Y/zcNkj2rTQ4pdYIYgg
 FJQiNtK/Wm71FmAI/ns9WBRXYAZzXhXNQQr8gn9WqdMnSNl1RDBgGkg444st6S/GVFaLIQfGbWm
 R+t9tKm0OlDgfvq6Bw32ItlVNq8rS0pibxyBnrTEcgwDDeonH7x2aznGPpIfvrKwh56aImMgGX6
 AjrXIb131x5ICbYHH1raz9f6SV0ScAnRdw8mwQ936yizzIFBT6Zv5tGCa7xWlXA5DWkino46Ods
 w2BqM+apPiNpa0yWhrLOj7bgNMG0DCoF/NsJXbM7
X-Google-Smtp-Source: AGHT+IGNaTTaB8sCjmP0kKNqXdhjM/rwql0XWgva5vnqXht3KrNf9a4sAy7Da4m17fBBAvj9OgJobQ==
X-Received: by 2002:a17:903:2452:b0:225:abd2:5e39 with SMTP id
 d9443c01a7336-22e18bfb5e1mr69676795ad.30.1746336569982; 
 Sat, 03 May 2025 22:29:29 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 11/40] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Sat,  3 May 2025 22:28:45 -0700
Message-ID: <20250504052914.3525365-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Need to stub cpu64 finalize functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 00ae2778058..c3a1e8e284d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1878,7 +1878,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1914,7 +1913,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
-#endif
 
     if (kvm_enabled()) {
         kvm_arm_steal_time_finalize(cpu, &local_err);
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
new file mode 100644
index 00000000000..81be44d8462
--- /dev/null
+++ b/target/arm/cpu32-stubs.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include <glib.h>
+
+void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..c39ddc4427b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,10 +11,13 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_ss.add(when: 'TARGET_AARCH64',
+  if_true: files(
+    'cpu64.c',
+    'gdbstub64.c'),
+  if_false: files(
+    'cpu32-stubs.c'),
+)
 
 arm_system_ss = ss.source_set()
 arm_system_ss.add(files(
-- 
2.47.2


