Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A5FC48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JM-0001rD-BE; Wed, 31 Jan 2024 03:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JK-0001r4-BA
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JH-0007op-Qw
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e80046246so3373005e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691065; x=1707295865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hwpo4Gdo6ndwqVzHgyIgbMFjcV7Bk74avs3plMLuDNI=;
 b=erd5q3ZIFNE/yhocS12ndZn4NfK80ohZPV37takLyD1JkNSav7yrPBh5dHZIvuUl2l
 0A9QmLO5AqYEoxWQNanb4IeJxO+EjAvZgTyjFqCTx55GvI3+hN57qhTNzSyL60jphgJg
 h2e5BS4fsHD06n+hy7m4GP9AGJH9IgRlwxy5xJiL8vynWyubGwdeRe4x/8vJ4vfRm4ns
 S6kL/WwKk6QdiuTL7O6OlD+0jOL1gUpfpkkg3kzQDtjEtKPASgz0J5J8dR1A8ILLOYNq
 uRiRMK9lyYwpHEQM053VlJH18mNsXT9CZckIMM7xbei6yy1Z00jyWNrzFOFNbNdWZZyb
 7kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691065; x=1707295865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hwpo4Gdo6ndwqVzHgyIgbMFjcV7Bk74avs3plMLuDNI=;
 b=QqE+BAy3dgAPYGg04aLrIxdzSAgEJyYFd62N3t10asveHThyb7zzqLXcPxYDt3iUGC
 26X88ymWEPYICsmtybxbKipGUFP7VWSAYVo2kKpcNytOWNsf10w2SZH3GerAdYlhVnrY
 cihKY1RcFV39LR8DzQ/xTWeT0s/xBvBROeU2ZhZvZ5bxfQWQLHg+NMqa45zx/sk9qSDs
 7SMKGwPYJEmbmd1n70dqu9vPhxf6/1NXVGpif+VDeCBb+4uBnplasRctQy8ZFyp+BNgl
 FBXNGZeRM151NcYsvMxcCusiHKM+CBXDBCPdyLHiHZA++CP9k3f2Fh2T5jT2Ikws7Fl3
 IHuA==
X-Gm-Message-State: AOJu0YyHDwsUnyaZxJwFv0Z5WjrNs8GcUk5ObQqrMDP0NDXzSDjY3MP9
 2rdhR0qDQFbX4uA7vWw+MzOFXen88vd6pSh2gEKCyeL6u42CcEPA6xopTUXy5Lt0+V088tTjSOs
 =
X-Google-Smtp-Source: AGHT+IG7AcxHbx8pHdTGYHF0203JbZ8B9liUYYryhPqKBzauNWMel8s/jtwY1WYqSpWQATahn73kcA==
X-Received: by 2002:a05:600c:4f82:b0:40e:fa51:3526 with SMTP id
 n2-20020a05600c4f8200b0040efa513526mr802828wmq.10.1706691065610; 
 Wed, 31 Jan 2024 00:51:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV7f3jSmk+Tcz3Whe6BMX9y/7kd7A/3k83Hj53DSUzUzVBXFvjTTF7GdHVEg98rWqBiFojLI+5NiKZ0/D/onJ9c6MbxDZCfoqkZdUYjUnUMhUbCVCPmmFb+sEJK
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:05 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/9] sparc/grlib: split out the headers for each peripherals
Date: Wed, 31 Jan 2024 09:50:39 +0100
Message-Id: <20240131085047.18458-2-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

... and move them in their right hardware directory.

Update Copyright and add SPDX-License-Identifier at the same time.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/grlib_apbuart.c                       |  6 ++--
 hw/intc/grlib_irqmp.c                         |  6 ++--
 hw/sparc/leon3.c                              |  8 +++--
 hw/timer/grlib_gptimer.c                      |  6 ++--
 include/hw/char/grlib_uart.h                  | 32 +++++++++++++++++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 16 ++++------
 include/hw/timer/grlib_gptimer.h              | 32 +++++++++++++++++++
 7 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 82ff40a530..515b65bc07 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB APB UART Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -26,7 +28,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/sparc/grlib.h"
+#include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 3bfe2544b7..11eef62457 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -3,7 +3,9 @@
  *
  * (Multiprocessor and extended interrupt not supported)
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -29,7 +31,7 @@
 #include "hw/sysbus.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/sparc/grlib.h"
+#include "hw/intc/grlib_irqmp.h"
 
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..b7d81c76f3 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,9 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -40,7 +42,9 @@
 #include "elf.h"
 #include "trace.h"
 
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
+#include "hw/char/grlib_uart.h"
+#include "hw/intc/grlib_irqmp.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 
 /* Default system clock.  */
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 5c4923c1e0..4990885451 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB GPTimer Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.h
new file mode 100644
index 0000000000..7496f8fd5e
--- /dev/null
+++ b/include/hw/char/grlib_uart.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB UART
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_UART_H
+#define GRLIB_UART_H
+
+#define TYPE_GRLIB_APB_UART "grlib-apbuart"
+
+#endif
diff --git a/include/hw/sparc/grlib.h b/include/hw/intc/grlib_irqmp.h
similarity index 86%
rename from include/hw/sparc/grlib.h
rename to include/hw/intc/grlib_irqmp.h
index ef1946c7f8..c5a90cbb3e 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB Components
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -22,8 +24,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef GRLIB_H
-#define GRLIB_H
+#ifndef GRLIB_IRQMP_H
+#define GRLIB_IRQMP_H
 
 #include "hw/sysbus.h"
 
@@ -36,10 +38,4 @@
 
 void grlib_irqmp_ack(DeviceState *dev, int intno);
 
-/* GPTimer */
-#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
-
-/* APB UART */
-#define TYPE_GRLIB_APB_UART "grlib-apbuart"
-
-#endif /* GRLIB_H */
+#endif /* GRLIB_IRQMP_H */
diff --git a/include/hw/timer/grlib_gptimer.h b/include/hw/timer/grlib_gptimer.h
new file mode 100644
index 0000000000..e56f1b8bf3
--- /dev/null
+++ b/include/hw/timer/grlib_gptimer.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB GPTimer
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_GPTIMER_H
+#define GRLIB_GPTIMER_H
+
+#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
+
+#endif
-- 
2.25.1


