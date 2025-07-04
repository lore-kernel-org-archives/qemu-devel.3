Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57174C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSf-0007DO-Vh; Fri, 04 Jul 2025 06:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSc-00070o-VP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSb-0006sS-52
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so541458f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624159; x=1752228959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iCBsSrpa7kKZRsqPbYchBfWXs8TNxgSCBY8aXqIgO9o=;
 b=JzF3nY5PYBSrTRNtKGmwVRrfTAVH9EqioxgrIUegSv29aFlY3vM6lYwsm/wMZQzjHy
 Ai7++/5a9hsG9rVhwIJto3+CymiXxGg2O0sH6TzVib+tY0523P7ZlCKM9TH/N9otbclY
 MLwXS1/a0rJfuicLWeJTOZg8hdasweaqpMufeVZ65WXZ5dGo5RK7NCmeqqvE5pTvJI6X
 /FUp48vq9f8WZPIbolCE3ZmkfCObwWTRSBhcFvehJ3CE2xlK1I4/qH2RgcCj6/pLJCvP
 3j7mq2c0pIqECPdunMQZdxeBIP2tZVGzgK99sVi3cicBdZGEI8DfhEbLX4TbRYejp7rm
 QSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624159; x=1752228959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCBsSrpa7kKZRsqPbYchBfWXs8TNxgSCBY8aXqIgO9o=;
 b=IQ+4gdIHepbrJdv467qBwqEKZ3bDlssAyXGwqVkYTlYy1NP4fmcv+xsV9quPc6IAKL
 WDfkajgNkkIyjanN1JVMfr6BmMkhHt63Zzsb0WckLDg3dG2dgxBjnM5nwNQq5QhTEXEz
 Kvw+RwJxYDRzhe0zmzGla5vwkd8xyAtsPWT9WCJ8yiSYhdyc0U9aByRusHmn7mITh50P
 /Hzr/3a+yLXTxNuqLfKMcK382Xu1PGR3DngGUGL92nHjVmgnB2XmI8kkuxuvDpwgt3+K
 ICeUWARkhOsM5LJoHjHgfZ25QJHhHMJanG6SdqF91wrJcb5RhDCFgGNzes7XlKp33TmO
 xNKg==
X-Gm-Message-State: AOJu0YzlOz4qUGsIDtw3Y/aZwwFe8U6O6ctOEnyNRBR3Q6nactp9+Gdl
 GUYeuk39HAQcwtfyJTweWL3qO9MxByIUjIipvgNaqN0sPfb0KjU9XZrqZGknOKvtd2Lhayg91a3
 ovqUrFBE=
X-Gm-Gg: ASbGncuQe06u05+oM+w1UdVcIGFHYy42kvZAkUZ21Lei8kC/2vmeGPrz0LlRcG4u2NQ
 bkPY6jZg//NjSLyOo1tNhlbaHOH9bC9L4AfBjxR5yk8yKuHkRDMP1itDir1k/hovyoHIhZT2bN/
 aU8wBbMeQdfLmudzHrGGM3Uo210deYOpZR3kkk6o+lccAwMSd5y5ccVg5RTuFmcH1P3kegtXe1i
 w2NffNAP8YQlqOuH2z+0Z0A89aFx0jcBQauuaD0dyvUINxNoSAnci2NTGpwQmwblzZQRoqQ/e/Q
 NKaLWcNq31SjMHYOBKbpH8jBycGb4eKwDTaqS4GKiKpZh3lGOUCQfyni11wiukWfEcf3zwWb0hh
 CPuc2ET01QME4W0bkgpFbnHThONntAb54Fl8eAT+JwQgiRZQ=
X-Google-Smtp-Source: AGHT+IGNo6+7pqfNonk66Q+1btjZHpV+9qRaR9LGIeoqL/H8EA3GMzakhXFVXr7r9uvccoxuyRA/pg==
X-Received: by 2002:a05:6000:208a:b0:3a4:e7d3:bd9c with SMTP id
 ffacd0b85a97d-3b4964fa66bmr1668359f8f.17.1751624159153; 
 Fri, 04 Jul 2025 03:15:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bd58sm2163100f8f.18.2025.07.04.03.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/31] accel/nvmm: Expose nvmm_enabled() to common code
Date: Fri,  4 Jul 2025 12:14:19 +0200
Message-ID: <20250704101433.8813-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-25-philmd@linaro.org>
---
 MAINTAINERS                 |  1 +
 include/system/nvmm.h       | 23 ++++++++++++-----------
 accel/stubs/nvmm-stub.c     | 12 ++++++++++++
 target/i386/nvmm/nvmm-all.c |  8 +-------
 accel/stubs/meson.build     |  1 +
 5 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b1cbfe115bc..c73468b2422 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -586,6 +586,7 @@ NetBSD Virtual Machine Monitor (NVMM) CPU support
 M: Reinoud Zandijk <reinoud@netbsd.org>
 S: Maintained
 F: include/system/nvmm.h
+F: accel/stubs/nvmm-stub.c
 F: target/i386/nvmm/
 
 Hosts
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
index 00000000000..ec14837501a
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
+#include "system/nvmm.h"
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


