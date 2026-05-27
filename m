Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316ACD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYA-000361-Ms; Wed, 27 May 2026 06:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXr-0002fT-8i
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXo-0000hC-3A
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so37323985e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877881; x=1780482681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fyhzru2QJzGx3OiH4Fu2CWJeT2XrRyL0uXKObwjgup8=;
 b=MztGSCe9HHs0bfkdrIWaJGvnKHXDIbea9qZwjCVmASyzC0XIB+rxlRqxlB1EELrg5j
 RdUcJLLaO5/R8XiM+Wnw6juhkgp4JX2SAYPGsLWwcui7w60pGBZx8nsP7VKGic0iuA0U
 4ZhkNApyHbGi65YkgXRqEpvInaddv5zCjn4am2upGW7D6V/jSWC5wvwYghtwhiY7euMp
 epFF6goip3P8tjVn4BxWNm2aISRmwle6UX20/qXC20VVbJRHFH56p+W9f7TDhmjsT3WK
 4kNrAqESyKufuo/U/uIejcFF1mFVNTehBOADTRhGbWz0hO7uDusQbTC0L5sroLApOxFT
 QqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877881; x=1780482681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fyhzru2QJzGx3OiH4Fu2CWJeT2XrRyL0uXKObwjgup8=;
 b=GMWxqj2X7+eh/5EvrI250tLPUYMq6iWVm0vLbJWjADX/ovbQWBLx0UaNsTJJTAxTd1
 zqRg82GXHHv0VTohbIlaVqXSdR5tAA5L1M1LIKVbMIaECnZWv6ENjnRh4iwJmAnQjeSH
 /RtjWVDxKol4MutMhidtqZbAAsyZwkaKd3Nq8NV/cjHkkJXcIS9yMqVNQsPHo7jqSRA5
 fx0hQmY77uxWTCw9r4e1tLEwZGSA+i4SGJ6nXlkA5JbKjpPL1oLqs0S7hrdStwmtj2qG
 KiB5knC+ZObKmxprTtt/BPhfjxFOWGKY/len5xLXL4iUQhFJT2dNm2pr9MQOCyRTc0Cz
 ItgQ==
X-Gm-Message-State: AOJu0Yz/QgrevSdpiE+xNFhb9GpnypshlCzEl/er9pNqVFZSurubQseX
 H8cHFM+9mI+Y/lTRtuF3zqLDgcZvMeKpRFY2GcKUHaJWnYDYGlt1zBIB7yeYCC+1dRnFVnJgQIk
 4SLCXB6wJ3w==
X-Gm-Gg: Acq92OHA2G9CR68r0x1RDh+BeKQdA26uB3UD7N+UXQfTtQeZnIfAcDyf+bUktl2pQ+e
 nYKKXyiwdD2Y7CrDAeG8+olktSCamK8ahfc/DrP8EysfbddptafpPIYwsE5gDLpjMQWouQZwlsG
 iAFzrGv+GzFyu319GOatc47ZTCgA9xpBVEx/mPZsMJeHCIRb+LV/oM8098NDO4kXv7AeQb3Y4ve
 c5FK7qr9C9lOH6yqvgV/j4Xzuc43vgtikECMH+8eyvrNmF3ejQ0TlPnCp5mHG8EDEVqJZVtuo+8
 IVWVFjKgdMb6SbVqJN2VlSAxKONaNiSXPppGd2/JvgFKg0Dwrre00rwf/ZCBtBI39TmgatjYhUF
 oqSjWmncaoXwhYKmG9sPhe9ANrD+8XGwWEbx8PvB2h1x3++tVpboxNxwDzguHgjd45jMmKwDj9Y
 hRYYM/iji4roBbnnSvZsf9b2hFxtWmbBS7j5I9kyOg79wsAVxEeSDoWlGLvATOxpoYeA==
X-Received: by 2002:a05:600c:46cb:b0:48d:366:b962 with SMTP id
 5b1f17b1804b1-4904248776fmr371692425e9.6.1779877880737; 
 Wed, 27 May 2026 03:31:20 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b314dsm4522664f8f.30.2026.05.27.03.31.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] configs/target: Implement per-binary TargetInfo
 structure for riscv
Date: Wed, 27 May 2026 12:30:10 +0200
Message-ID: <20260527103037.4461-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Anton Johansson <anjo@rev.ng>

Defines TargetInfo for 32- and 64-bit riscv binaries.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/meson.build       |  1 +
 3 files changed, 53 insertions(+)
 create mode 100644 configs/targets/riscv32-softmmu.c
 create mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
new file mode 100644
index 00000000000..752c813077e
--- /dev/null
+++ b/configs/targets/riscv32-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-riscv32)
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+#include "target/riscv/cpu-param.h"
+
+static const TargetInfo target_info_riscv32_system = {
+    .target_name = "riscv32",
+    .target_arch = SYS_EMU_TARGET_RISCV32,
+    .long_bits = 32,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS,
+};
+
+target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
new file mode 100644
index 00000000000..5150f0fe9d9
--- /dev/null
+++ b/configs/targets/riscv64-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-riscv64)
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+#include "target/riscv/cpu-param.h"
+
+static const TargetInfo target_info_riscv64_system = {
+    .target_name = "riscv64",
+    .target_arch = SYS_EMU_TARGET_RISCV64,
+    .long_bits = 64,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS,
+};
+
+target_info_init(target_info_riscv64_system)
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
index cca2514eb51..2ab4d27eaf5 100644
--- a/configs/targets/meson.build
+++ b/configs/targets/meson.build
@@ -1,5 +1,6 @@
 foreach target : [
       'arm-softmmu', 'aarch64-softmmu',
+      'riscv32-softmmu', 'riscv64-softmmu'
   ]
   config_target_info += {target : files(target + '.c')}
 endforeach
-- 
2.53.0


