Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09C2C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNrL-0001VK-Np; Thu, 03 Jul 2025 13:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNr8-0001K4-3M
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNr5-0001td-LJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso865275e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564173; x=1752168973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MPU0TKBYtEFG1xkEVwMxLJwA3rZpWlg2w7MDgOvBBA=;
 b=LYlbtbFi8yHs1RwLeFjKn1jAh8V00zmHh+JthF1oYWXA4FStRGZ+MnFJnx5TLV4Lsi
 m9UitPn5aVO7o7ayLHDZkhJpKUcdcWTnQS0a+EAdEaqhCWS+NQj57+uetFdPc5xjKkVX
 Ss/3xITHoCaWHdtCkaD921A/GxPTEbtJc7ZtAdThGT1GYPjoqcEXsaIHesjyAaVOz0Sa
 M+By0p9HhaTyFYk99wlWL+p/ZYH6J1UjjLNlEEmKswggmh3ejnLD3lBJ6tH/a6jLYUMW
 aNlZJq13jqeDwBxOST8YDoBt2O/Mka8zzHIpJOiniWCsS/4AxMacFzUBGXo9DEITm3T+
 oJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564173; x=1752168973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MPU0TKBYtEFG1xkEVwMxLJwA3rZpWlg2w7MDgOvBBA=;
 b=lLLwqSFn1H1gM5RH9vqDJ3FxeAB0TTPp8oWolR7vLnxX00q3HMmgM7BumoiHQJ2xRH
 xM6hbPOSKWuj6rG1Za4g2VcLBcg9dQca3s6jYK0Ml6G0LdCAgYZ9mjoUwMKwWg3YavPM
 CX+akTqnGLKBP++EKcFCQIuWT6z1I52R5PNQBqje8llcK0G2aq2+HHYJgvTzo36ZqDWl
 EZGGqDWELL4zVFtphAuK5mbWOMXcy4cUYmKeyN+hFnxjdpvHD2IcirHFOxAf1deijCxn
 zHQkumhLundyBKBCMX6FkbeuuTNQnzUkE0CCZwwL7EXi/CuC56/ptrUH3CVXs6JemrTS
 bHpg==
X-Gm-Message-State: AOJu0Yw9UCLdKdMEPbyr+Wd0bK7SgQQ/dpsh/IRfJF9h1dDIQ3ZIDQLj
 qM5JQbrv9sQWMW45ouJhsbfox6sFOWfDQdpaVoOIclaXaWhyL+l7hu7TTex937V15yFf4gyhUuO
 8JdyxCoA=
X-Gm-Gg: ASbGncv2yxRxUyRtfVc9DIwfS8pPkbKJm6dZMg1OCCMjtgdEuaP9E9lutAkRDlMKQ3A
 xpfsLEpPJZsHz70P3q8qr3EjwPdp16xjvWoyu23yy9n88I5LGYZ9doz8ufJGhCRgjuneVOtM8bG
 /KkGICxf/EpBjd8EYyYkvAdiXrZyDqJ1JXaMDly0FRplpqTI9FLkjqgHSukbs9kLr9X3SFGDDtl
 OAQ/sYe/7pwM4oQqE79tmmX2QiTngeFKbRphY1B24pKUYa+IwS+1/mfOSD1hbGvk6Aahnnr9xnb
 /6KKu1nj1zMklsWyjgZwekPp7mOh2eiBb2gIxMwrkdCuWeIyULkJLFwhgI/s6W+Nrm4lR0DBCJd
 Y8XSV4H8IIZiQ/CyYEIFqj3KFKbbcSBpibGuC
X-Google-Smtp-Source: AGHT+IF1KdJk6c4ueSnjnRty/oc46EojwVkf/EW5AwRmuKQECJq5AW7BgV+yFnxaCbwEOJm8eBUtQQ==
X-Received: by 2002:a05:600c:c8f:b0:453:9bf:6f79 with SMTP id
 5b1f17b1804b1-454a9cd69d9mr43963695e9.26.1751564173127; 
 Thu, 03 Jul 2025 10:36:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997de2asm32406255e9.12.2025.07.03.10.36.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:36:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 37/39] accel: Rename 'system/accel-ops.h' ->
 'accel/accel-cpu-ops.h'
Date: Thu,  3 Jul 2025 19:32:43 +0200
Message-ID: <20250703173248.44995-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Unfortunately "system/accel-ops.h" handlers are not only
system-specific. For example, the cpu_reset_hold() hook
is part of the vCPU creation, after it is realized.

Mechanical rename to drop 'system' using:

  $ sed -i -e s_system/accel-ops.h_accel/accel-cpu-ops.h_g \
              $(git grep -l system/accel-ops.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/{system/accel-ops.h => accel/accel-cpu-ops.h} | 8 ++++----
 accel/accel-common.c                                  | 2 +-
 accel/accel-system.c                                  | 2 +-
 accel/hvf/hvf-accel-ops.c                             | 2 +-
 accel/kvm/kvm-accel-ops.c                             | 2 +-
 accel/qtest/qtest.c                                   | 2 +-
 accel/tcg/tcg-accel-ops.c                             | 2 +-
 accel/xen/xen-all.c                                   | 2 +-
 cpu-target.c                                          | 2 +-
 gdbstub/system.c                                      | 2 +-
 system/cpus.c                                         | 2 +-
 target/i386/nvmm/nvmm-accel-ops.c                     | 2 +-
 target/i386/whpx/whpx-accel-ops.c                     | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)
 rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (96%)

diff --git a/include/system/accel-ops.h b/include/accel/accel-cpu-ops.h
similarity index 96%
rename from include/system/accel-ops.h
rename to include/accel/accel-cpu-ops.h
index 17c80887016..a045d7c5d4a 100644
--- a/include/system/accel-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -1,5 +1,5 @@
 /*
- * Accelerator OPS, used for cpus.c module
+ * Accelerator per-vCPU handlers
  *
  * Copyright 2021 SUSE LLC
  *
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_OPS_H
-#define ACCEL_OPS_H
+#ifndef ACCEL_CPU_OPS_H
+#define ACCEL_CPU_OPS_H
 
 #include "qemu/accel.h"
 #include "exec/vaddr.h"
@@ -88,4 +88,4 @@ struct AccelOpsClass {
 
 void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 
-#endif /* ACCEL_OPS_H */
+#endif /* ACCEL_CPU_OPS_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b3fbe3216aa..b490612447b 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 637e2390f35..451567e1a50 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-internal.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index a0248942f3a..b13937b29e1 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -54,7 +54,7 @@
 #include "gdbstub/enums.h"
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 2a744092749..2c8f4fecb17 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 2b831260201..a7fc8bee6dd 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -18,7 +18,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/accel.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/qtest.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index bc809ad5640..8f071d2cfeb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index bd0ff64befc..55a60bb42c2 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -19,7 +19,7 @@
 #include "chardev/char.h"
 #include "qemu/accel.h"
 #include "accel/dummy-cpus.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
 #include "system/runstate.h"
diff --git a/cpu-target.c b/cpu-target.c
index 1c90a307593..2049eb1d0f6 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
 #include "exec/tswap.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 03934deed49..1c48915b6a5 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -20,7 +20,7 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
diff --git a/system/cpus.c b/system/cpus.c
index f90b8be9eee..dae66a1bc4d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -31,7 +31,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/hw_accel.h"
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index a5517b0abf3..3799260bbde 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 31cf15f0045..2b51b35bfa6 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
-- 
2.49.0


