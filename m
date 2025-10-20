Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73A2CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy8h-0005HH-Js; Mon, 20 Oct 2025 18:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8f-0005Ez-L5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:14:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy8M-0006Ui-QL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:13:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711810948aso32626375e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998419; x=1761603219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qx+WMzM5axG2TB0z/BfWBsORVg3KM288eU2VCZR6aOw=;
 b=i0KzgE4DJYYAtH+VNzAhbLkabLmBYcMQnj87r3GsCduteWgJO5dIMtIQ/WiLmh+BSb
 ifZ4aOgL41eptexG2/Ngsr+PLPdoZo92uKLM0NwSADRYTgc6S5bozIsb4l3ukGpJqwCB
 8oDrUHhcwqr2y8Dj2G5CrBe0i8yyNw6R93clGVzf9g2bk9AXwaxYJgdWWvSwihCInpuH
 gF113sd9EEDGVLLIHvMIUvLWYicBEFhSefbouEoFqWvYjggc8EIuqMTX2EnwRd8JpIap
 9pso1ffBXmriYVZZ/3LoBgILmFlv8OkrHppCc1sHAInhdNW+jsAJAnuXHXvoeoM2T8Yv
 ElvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998419; x=1761603219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx+WMzM5axG2TB0z/BfWBsORVg3KM288eU2VCZR6aOw=;
 b=GGaf0ClUTu8d3Nft3f8sWPRYLelSFzBc7qmBYhvu6W4JQ0Ae8AOPABPTuztE5oHHnG
 m3paWI3ldiwVaZEM7VdZWMYyWpNy0bquacwi5XFy3bt82XydW/uZ7NWPNjHhPwgzAWQY
 FjYeChD7kFRRs8IwV70rC4KIPMurGW0MAmYQd6qJEZUIT3UFtcpRxamAzARxgJD2/sib
 h4otDMiYpijitOeNTvrMmT06qjbVC6PGnnb/hBXpeWndBbVHIjO5aG02vFZWs39nuXrP
 SGLOEfBYkentIApB7ZaHxUrv08ZzEXW/GlJEGBTppdEWIKyAY9+Q2RZFLWIT0syrrFNI
 xqFQ==
X-Gm-Message-State: AOJu0YzOzj72LLQEU+ZxYhqvDI/VqJSU1qCaeApZ+LQ9i4+lo1h1dwJO
 AdPNOAOJQwYXYPi/UHuWFxqAqAVsMCvldi4+wuefnm7vRQbB8bHfg0VHX+Wok6j/w1lJbeHfHDL
 ObB0Pfjs=
X-Gm-Gg: ASbGnctOQNj8tS6PbC3T5etoHzzvoB1O9Dz4gO6OlS9zPWf4xrECT4Eh+CINj86WkJv
 ltJlBJr5wPhW7KGzYY6NCrhaLjAmkvawwRryZq/O+bdU3x7SSXYnecFVTozeI10GAzvfW1er5Nh
 wc/LKa/wb6pJg5jRcOS5gsTXVk18giZttHWl053VP5DnEuPDYG9AjijvfQtb/BWs3Ld4pw9Zm8w
 zqltds7z8U20wD1DPkemxnQ4CJUv0LNKoPNd0logz56ibikSbO9j+xXMOjlMTLFknMQNk6l6YlN
 hMQxr7vAKRTMSkKoLma88UkEz3IJ8lB56GJ7Z3U7K/zVqg5eKQimdIUXiFni2Aj0eaappvrSkr5
 75VQcjSxhSY47xXha9EayZXk/33TSg7dvp9FJyUSpZOniS5Lap0vkfQNmpf4X/Z8ADv9tYuqh3X
 FK0GyCPN6OZGhZNAv2wi7/L+ijIFR45fYxwvGuooTvsam78WFjOG0kjIZMTGzzUmcJivn1rXU=
X-Google-Smtp-Source: AGHT+IGDRvr/LbOEqixUZG2n5Zje6gu/Mc4pPofiEfyj/Um95u6MoGR+bMkFDUJoG6mJNm2iHNSBqg==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4711791cadfmr127289325e9.32.1760998418904; 
 Mon, 20 Oct 2025 15:13:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm17072760f8f.44.2025.10.20.15.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:13:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 11/30] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Date: Tue, 21 Oct 2025 00:13:16 +0200
Message-ID: <20251020221336.66479-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Implement the TargetInfo structure for qemu-system-arm
and qemu-system-aarch64 binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/arm-softmmu.c     | 26 ++++++++++++++++++++++++++
 configs/targets/meson.build       |  1 +
 3 files changed, 53 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
new file mode 100644
index 00000000000..4e1e2f64da1
--- /dev/null
+++ b/configs/targets/aarch64-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-aarch64)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_aarch64_system = {
+    .target_name = "aarch64",
+    .target_arch = SYS_EMU_TARGET_AARCH64,
+    .long_bits = 64,
+    .cpu_type = TYPE_ARM_CPU,
+    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
new file mode 100644
index 00000000000..9b3fdd2854a
--- /dev/null
+++ b/configs/targets/arm-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-arm)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_arm_system = {
+    .target_name = "arm",
+    .target_arch = SYS_EMU_TARGET_ARM,
+    .long_bits = 32,
+    .cpu_type = TYPE_ARM_CPU,
+    .machine_typename = TYPE_TARGET_ARM_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
index a9f6b24ec01..cca2514eb51 100644
--- a/configs/targets/meson.build
+++ b/configs/targets/meson.build
@@ -1,4 +1,5 @@
 foreach target : [
+      'arm-softmmu', 'aarch64-softmmu',
   ]
   config_target_info += {target : files(target + '.c')}
 endforeach
-- 
2.51.0


