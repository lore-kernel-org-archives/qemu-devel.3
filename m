Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE71C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ0-0000PO-J8; Wed, 07 May 2025 19:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPg-0008Fr-FT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPd-0002Sw-Kj
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e6880d106so3268555ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661372; x=1747266172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtoWRnhexqhEbtmi9AyX1L5MqLgfQdzBe/SXZsSvaEY=;
 b=b2yw7Rh+kiR2ES73G0RQMKV6fVL9FQhr8QNq/XlIJBNlQSI48I1XszFaES21KcQWae
 /yGZiy2wdO+Cp99fzAOE2dbZZqx3g3/HFJXeIH6T3o0wDbOGNMNX7tHUe3UOWJMygYHT
 TXFDhZ/+R/3lssQ7zGEBp5HCKsicx2baS5zTwbw4ffKiPXdRV00kwcJVW/evcv3o8ERC
 2Q1xIos8E9NVdFuQpECWvMgypgf9TBlcp5BZBNjM6WfxrJhwFlEjhiXKGJ/bIneeBDvG
 glxIkKbx1Blz5x+FPt8dgIhLmrcpTQaHqye921g9x4liWHutn0lQrfRYZD+mGmZsZen7
 2pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661372; x=1747266172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtoWRnhexqhEbtmi9AyX1L5MqLgfQdzBe/SXZsSvaEY=;
 b=YbGloXFvQye7LL9kZUceGemU2rvzIHNalI7mMtjiwBeZhmrShUVusAFK7llxhDoGRe
 SWHbtmlw8YSs2RS+syRFZ5XYhGC7LFyzEharNwPT5xg3im66lNv4mitYxGCyhC5VN0PL
 mFZEczqSiRJZkjjcLW1rWsfqVOUwGh3ZFbtJeWDxt+mveMni74r6M3oZVKcNjIlj5xso
 RTfrCCAXOcGxCdmIyi7KJmTjfaBChDQ+R23PU2hxfvfrPRXXBDPzQonAKc2DPxmtw+E/
 VsES241yS69RMsCXy3Q5qriIfjvz9YYYJxQVlrSQN0Qxo+EgVqRH4fUmz8HzVp8VA8ZK
 WKTg==
X-Gm-Message-State: AOJu0YypS3U3oqPaME6U2LJ9r7a8kSTLHj0W9iXc6mD6GtCXbsHOpKz5
 fnZFn8BzSgBqRxYYOYADdwiQ7u89MZpYAuwNNUXtUVbvo7JqdrOZLMgAoRIAMWx4vig3BoWqOeQ
 EZwr3vQ==
X-Gm-Gg: ASbGncvj2PT02ppfxGyXDR+RGj/rWenR/16Pe2DEZGHf2lnhLm/fMQ/4QSowcmaeVBx
 kDr9CvRgOjz1pRXxbxOQtA5N580hWVtQfR3HGOOYB4SOY6vLGNlP2Y3XtvvzqLicAim3b6t+FHe
 XsnDpBCBR8niOI+WtxMg/OnatsbPu48RjRQ/Y7gIskdPHrojrh5ZWAlVMUU8/J3jm9oiCsDTrJW
 oJ2lXPw0zLBwcS3z+CvzIY53nDaWqk92J2hDU6HVduW2o+168spTHJJwqNe7GEQv2D1G4QFS/+s
 y0UDeZipPRKXjzFbSHcngZKwtX9nVlNekvj5PlRgRkXWM16Mrhw=
X-Google-Smtp-Source: AGHT+IGz/1Yr+OHRltxAQC9cICgktOobj+PQsbldqBW/j2h25G+9WHd6ECUvH2fDziFXcVGW5vntTQ==
X-Received: by 2002:a17:902:ca95:b0:22e:7971:4d48 with SMTP id
 d9443c01a7336-22e79714f3bmr29689785ad.45.1746661372116; 
 Wed, 07 May 2025 16:42:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 10/49] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Wed,  7 May 2025 16:42:01 -0700
Message-ID: <20250507234241.957746-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b97746faa87..a604e4ccac8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1877,7 +1877,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1913,7 +1912,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
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


