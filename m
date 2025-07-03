Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C58C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqU-0000Ls-Os; Thu, 03 Jul 2025 13:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpv-0007oy-Db
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpt-0001Bf-3F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so874895e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564099; x=1752168899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOWWkYUng0bWFtZYS1mlC3Juddgqx712KerwYfB2I6g=;
 b=n6hiHk1sVWCWXE1C2BXKkkRGWN9AkhvqQKwzvKH3J5hdbr8GAcvKLU1H/KZ/pkuPIX
 2+Rw3X8mvby3rp200jecQr/4VDNvs+bPx/uVYF46sZJIhk0l/lrlOSgDAXMsWFY+uQpT
 HWKR2Z2r5Z3S8+DnunfbrANoZMQ4V+ZlNCogJwKRlPyLaK9lgR4/rTAO7nQ8/xfG7C0z
 CJQ3AsPPoOgxSr5ooIx92kefadEYv4v01wBX7SAgCszulq/SaMh9jm79hcZykSn0p93x
 tyeF6Oh9TMUbZtaChsd6xG4Uq4LdpaL+KWL1te5+RU2p4OUOdv3Vs9N2SXjGco3BduA0
 UUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564099; x=1752168899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOWWkYUng0bWFtZYS1mlC3Juddgqx712KerwYfB2I6g=;
 b=cHJD6XM809/aqJ/1w1EWb9YbhzN9XsLEszPHoFsLXFJwMfg1s5rmEFahSyYvp7RUik
 Z8DKTt924OcF3/zdCpGtmnq7N2JCUKsodW0pARy2Z2vOgPZmrcsQTG1zwuNUmC941nTw
 D1MzYQVWpgmGDYkta5vAzHuNg9z+Jnxq/lhDehJ6LGN2NJ/RHhgSWjDghTwI9FNhKqJd
 wHlQ1uhRpMavyHCl2kle0fr36uQCKxEIgAm6XPpt+r9U5VqI0ZTZQXv/zugSLXJWG8SJ
 LWDYN2E3lMhvzZVWjPf95jFt28QEN+/++pyjWLchXdNe54QWrpT6ELAGGhk54p712i9n
 Ieeg==
X-Gm-Message-State: AOJu0YxGMpTm/SCRYZ+G8QzfRky8YsuTsCF3AYOppcqDjTcwXIlJXL4y
 7hCLuzKymXfgCd17ONysO9ZGKXN02xTFm9B20Rp/herAnnW0SwnrUTTjMQC2NEwhrxqeC/NleJX
 zd14u3v0=
X-Gm-Gg: ASbGncuAhVQa40w9CVxIpxNEcgypfjKs9FxSuX1OXHr2TVWLbbpeZI+B1rF+HO/NQ0e
 86a0QZmQrcjkYSMAIYjOQWk8WkJ9Aq1Bqwv43v7KNJwFOSPhAR5xVPZQVs+c8r98qeTeOXW0x9j
 rr3X2fKbLG8Z1jJap4IIU+oB1vKwqeHwiBZ2GBD2F2JDLELMZrD2f0mz6pYpOp0NfZ0wTI32p4Y
 Rpx6fvesXLFm0pYvZkXVyezgH6QEGHef/8f35q0e/ta8psdpOGiyfwCHhXZ2/NTjqeVQf31KW++
 XARq8CKsXi/9wgPh8O5if1r9sdYfCN11n3guYpFHmNenHgjvmgvIegKqXdAsV2F0zTD1v4r47tS
 R0njL73/9Y2Wnkai/P62PfW6GwAt2Q+tyCraf
X-Google-Smtp-Source: AGHT+IEdZXugt44EZMe2Wr+pf29DApGEG1QcxUknPVsPatrBQozI0pUwQi3bhxbIkzCZ0KnzxLmUEQ==
X-Received: by 2002:a05:600c:4449:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-454ab3bc45bmr35301495e9.32.1751564098316; 
 Thu, 03 Jul 2025 10:34:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcebf7sm33304695e9.21.2025.07.03.10.34.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v6 24/39] accel/nvmm: Expose nvmm_enabled() to common code
Date: Thu,  3 Jul 2025 19:32:30 +0200
Message-ID: <20250703173248.44995-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Currently nvmm_enabled() is restricted to target-specific code.
By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/nvmm.h       | 23 ++++++++++++-----------
 accel/stubs/nvmm-stub.c     | 12 ++++++++++++
 target/i386/nvmm/nvmm-all.c |  8 +-------
 accel/stubs/meson.build     |  1 +
 4 files changed, 26 insertions(+), 18 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c

diff --git a/include/system/nvmm.h b/include/system/nvmm.h
index 6971ddb3a5a..7390def9adb 100644
--- a/include/system/nvmm.h
+++ b/include/system/nvmm.h
@@ -13,17 +13,18 @@
 #define QEMU_NVMM_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_NVMM
-
-int nvmm_enabled(void);
-
-#else /* CONFIG_NVMM */
-
-#define nvmm_enabled() (0)
-
-#endif /* CONFIG_NVMM */
-
+# ifdef CONFIG_NVMM
+#  define CONFIG_NVMM_IS_POSSIBLE
+# endif /* !CONFIG_NVMM */
+#else
+# define CONFIG_NVMM_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_NVMM_IS_POSSIBLE
+extern bool nvmm_allowed;
+#define nvmm_enabled() (nvmm_allowed)
+#else /* !CONFIG_NVMM_IS_POSSIBLE */
+#define nvmm_enabled() 0
+#endif /* !CONFIG_NVMM_IS_POSSIBLE */
+
 #endif /* QEMU_NVMM_H */
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 00000000000..cc58114ceb3
--- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,12 @@
+/*
+ * NVMM stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool nvmm_allowed;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index aea61a6fd2a..2df49d7eeb4 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -46,7 +46,7 @@ struct qemu_machine {
 
 /* -------------------------------------------------------------------------- */
 
-static bool nvmm_allowed;
+bool nvmm_allowed;
 static struct qemu_machine qemu_mach;
 
 static struct nvmm_machine *
@@ -1192,12 +1192,6 @@ nvmm_accel_init(MachineState *ms)
     return 0;
 }
 
-int
-nvmm_enabled(void)
-{
-    return nvmm_allowed;
-}
-
 static void
 nvmm_accel_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 8ca1a4529e2..4c34287215f 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,5 +3,6 @@ system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


