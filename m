Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B638FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLZ-0005Qv-9b; Thu, 01 May 2025 02:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL3-0005BR-BI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL1-00075d-Dl
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so664449b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080640; x=1746685440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUi/Pm8PBuXUf0tGsedeIwPfTJbQS6s9US0oEnWDi/c=;
 b=cvVWlPV+l9P3DpYf/mC0gJfckXzIi8oExGdnY8y4NgqTFoCF7kPMnX7jfINWbHXN4X
 Wo7QP//Q0SpJQF7IpFLaWK+gaDDjLguOH67lZOTVoisOLFq5qvOrdw9n61Hu5qhwU3ZS
 kPO7O7WgJSMZg/bG0Jpp7c2TANE7jwY+WwXMKC1rfq8SXUC9FI7izo4Fgq0L9z3cHu4y
 LPVNOG0YGYYD1Da6McMMXPVfK3I5zdlXM5VoHFJXOyqD2viqFsVa7DAiamK4YFpwUV2g
 YXeDF9jVKi1y33hjkpXK1LoR3j1lvmCZJycd95fRVlYqGkUcO500vSLl7fLN2wyPe/ZF
 DNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080640; x=1746685440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUi/Pm8PBuXUf0tGsedeIwPfTJbQS6s9US0oEnWDi/c=;
 b=QoHPTgRy30xRRmO0yIft3O2ZnMwVcHWDODhPGJKzcfo/CURcncFSudmAtS9jOfOYHA
 sTTmRN1IG1APS94C4lUXR+XQpC5Hyvfrdem2ylBYIBlpH7gUoDAJv8l07qkp1aFPWhxl
 3DipoE7YEEDwfNs1rEp92mFgg7beFC5CfxQt6d9AHfUvCgDNWQMRePUpS1XGhua4RhzU
 YoDm+rDWNYIX/8Ys13saLl36nQlDyBScfQPbCfk2NjsWyPTKvrade4dGcYJTuSITCoZ6
 OXzVvIHOcgWsmXVMaVsb8PgFCkbgELOdM3mgg8TzXrcCqBPBs/+eE4P1TszQl7rdOXCP
 vHfQ==
X-Gm-Message-State: AOJu0YyjHYLt0N7K7fQ7injgxZloNfLtwHnzx43OsCxDKDdN/sZsAYJD
 RLuZoBXTSzVG2D0pz6uoH3zQ+U77I6yhv05YUM3q/dSO4LwxWkZTqWF//0PdlMPkiWEWRxxbDLt
 a
X-Gm-Gg: ASbGncup1nANhYqDDH5sEiTEUNGbNP2HzarBc5EqRr0ceS11/BfQv+8aleCxpOVIg5G
 UQVhHdPfvsUBFT2lrvkxA0w6IDyWyC/E7ZNBY9BrtusItyfNOH2rN3/SHJ0aYea4PM0wYGvEpln
 mYInkLbj4ahDYBp3HDbjEtDUS/jZMdTc/jtIhreVBexSPdXU5FMOnB7kER6f3PdpRKFdtWNVn96
 1yf8jxTjrXNrqP0+zoct0ya7fE6G/gv93hPMDNyMR0n1jyJRYM6dsMHhlNx/HUhP06wq9Hm59mQ
 LfrITKX4zGTG2CYyiRQhlJ9Q4q2WPciLY7nT0pT+
X-Google-Smtp-Source: AGHT+IEKCWILcumjzPYh4K88LZx1Ow96si8ow9v9pGjanxvrTsUmYYaf0THPQ+j/vY9E0cJ9TrpOqw==
X-Received: by 2002:a05:6a20:3942:b0:1f5:7007:9eb8 with SMTP id
 adf61e73a8af0-20bd6a55a1fmr1761624637.16.1746080640303; 
 Wed, 30 Apr 2025 23:24:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/33] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Wed, 30 Apr 2025 23:23:21 -0700
Message-ID: <20250501062344.2526061-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Need to stub cpu64 finalize functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


