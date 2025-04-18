Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD1C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pXM-0002Ys-LQ; Fri, 18 Apr 2025 13:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXC-0002WP-Sn
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXB-0008MB-5c
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso16275605e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997387; x=1745602187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OTzCxiNHZ+8AXW9TgiIPvSY8FhsX6JUubS418pDWIg=;
 b=XlmYDhMo6nCVvWUT3M8YDDzxH+kYyWOhzIx7HwZihwiorYUXxupabtEggB8cYIZpWn
 1ujq11oGH5u55snK4lMFPzEjrlhQcAT9u+VFUdulu2DmfFbgJL8LRYHNJVvdQ6dmUvD8
 WNb+TyxrL9NXjAhGoOGGF1OcxlxcRUpwJC0iCLLJqeiHHNGPWwIMlZq/RtuZAnc4VpRG
 7hLrIpks3BwRAT7d+b63UpqeC62KBJ3yku268rz7bDo8GIb5lUEjnfV9wPVXvpb5LPV0
 nJBunaJEnV053Pd+der7c1S+vBxTvqIVhWbNOXiZeIdwSVJnxEfawGD98tDaorqgu3om
 krWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997387; x=1745602187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OTzCxiNHZ+8AXW9TgiIPvSY8FhsX6JUubS418pDWIg=;
 b=UoLlfjE/igBuAbBoKofUY4zrC95ZNURkDGtJGIjj3FBOr3WKfcmTZaBHc1PTAcoD/e
 o5mKHKI24U6JDdGw2JOQRiGEeq28UK9okoM7jItdJwmI7Zm9SK4HvMJ8jrDKjP4htUZA
 S4OhFUIymj5JsbWaDzwaRmCga4CTh0zvvB2Gu4Os9Yd3a+8U3guokJd+vvLSXkIrRRZP
 VjpY1VNDiUxbw+ZUK2DC85bjlxfYzLH/ULjvhnVVpajORNNUalygzdT5IQoS0wvthuEW
 nKl+1jIyMX3UPTR4IvkejaULZorxrwRNnrKeRbFZiQCb6lEjj6xDazgVU/tzjj9opPGi
 bnjg==
X-Gm-Message-State: AOJu0Yzqf+RGLfZgaCAWIwAZmL8eWX6ErZODbqGUipKRVfw5Peml/xsR
 HMTk4ZiVhh0ENUmjbKP2nOEAWIMMxTL3iVBFkOSEldcRMIt9EQRmj7qho0nnL4qO6ToNR5qji3n
 4
X-Gm-Gg: ASbGnct2wOfH3kwvmJ11NW7lLAHTdxUd6UqplLKgFZRLWabMz5L7cjBD1SgDc2/7MEs
 wW8ZhD6zKQ49nf22T5klDR61ewx/HWv+YrZwlm1khSCJrbQV90tFuDsNGlCryeW13epkHG6u3a3
 AigWGwjajc974RGCEQXNKz36FgtPt2dllYPptmUlaD1d5U8t1u/Blz/GeQaYelrk+d2CqCTP9OU
 wHxFZpqCBvVjTl4EDzt/G0uI5FL3TOGe//eOu7smucUOOO5H2/JLRL8gJtjWPWjOkdrvGs8WZ7F
 OVEJpe9WV/eLNLndJhzeFiirN9o9Za3B669vpI6ui/hPWuN6kei3/Wy0QQvqg1ns3VjCIcFM49H
 NBa9ZCkGdkDE3d9M=
X-Google-Smtp-Source: AGHT+IHvsZnsPUZu/EAgAc4kbO1/KV6Lrwdq3u3/OLfUsxquPPBqlIn1pahw+/6D540eSdfwF3tHuQ==
X-Received: by 2002:a5d:64ae:0:b0:38f:3e1c:211d with SMTP id
 ffacd0b85a97d-39efba5081cmr3001167f8f.14.1744997387423; 
 Fri, 18 Apr 2025 10:29:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4d67sm3339815f8f.94.2025.04.18.10.29.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 08/14] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Date: Fri, 18 Apr 2025 19:29:02 +0200
Message-ID: <20250418172908.25147-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
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

Implement the TargetInfo structure for qemu-system-arm
and qemu-system-aarch64 binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/aarch64-softmmu.c | 22 ++++++++++++++++++++++
 configs/targets/arm-softmmu.c     | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
new file mode 100644
index 00000000000..03f48bad326
--- /dev/null
+++ b/configs/targets/aarch64-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-aarch64)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_aarch64_system = {
+    .target_name = "aarch64",
+    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
new file mode 100644
index 00000000000..07285f7f3b3
--- /dev/null
+++ b/configs/targets/arm-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-arm)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_arm_system = {
+    .target_name = "arm",
+    .machine_typename = TYPE_TARGET_ARM_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
-- 
2.47.1


