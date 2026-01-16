Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69A2D4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjPh-0003hz-7o; Fri, 16 Jan 2026 07:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPS-0003eh-2d
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPP-00009o-Ss
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so13264955e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568314; x=1769173114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOsYTkHMDWaZJQZPkrAXk9jzTOl3OFsQkdgtD7kLcAY=;
 b=Argoz/zn4ZDyh6i2nvmE89Hq49QOg5SbG2wWpS3trnJd9+P1mcme4df7ShlgVBDYar
 r3/RxJpiJbhq6TmKgAFgNnyyaTtrt7cdyxtihQOsqMuPP/lf83cwHPw2akrphAfGBlII
 0IIWsSFUdEc60G91FJgBwPm+tpLfZXUCj++opPMRQ8038itetgpd9D3ZJ+tYvU3M2tA2
 UGFE3TxsSD8fIiJb2mtrct9kQJdBt8MXvvI8TTioLZ/zdDRSxFmxwWk4QhOq0LAHpm9v
 cgsjpI3H2/MKhi63QZWSqpQShm9w4RQeSJFObzGfNtP3NNUZUr1BJjWmMhTwyNVd2+zR
 iJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568314; x=1769173114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AOsYTkHMDWaZJQZPkrAXk9jzTOl3OFsQkdgtD7kLcAY=;
 b=M00oA1s5IZt6vCiUUmp82YsWWXROy1GDKZOVEjvXuc/nanO9jwjT1AwYC07FZTlepv
 tKSyk7b1S/KwicYWDhzQXtfW3qQ5G1YxL7XtQoJv0sthU2R0NDS3maADm42sfcb+TJbA
 KnnRIScdZ8wB0opdq/LT860t59ZAbeS2Y9SlgwJz0BcvpVmpQu3D71+rycS7kthyFEYE
 vdN9trihnpq/MjfW0qWKE5WnK9t+bh3p9UPWth0JZXPvnOk2d9WrloT42NlPX+SI4uwb
 T/vviW1vX5gfIxk3GQ2CaBdM8/oo0Z1k7krWqBSGX2Ojp8BVYS+m+SGz1RXVDDGLLCcp
 GVQA==
X-Gm-Message-State: AOJu0Ywv0YVrNeIN51jYm2B578FfXNC6vUCrXmLegpr3cfTMc2Yd5Xt1
 ovIS/M02bE2wKbd3T7PcQYpyRfeP+3CtkR1CwD4jekkilVO1vGk0XQmjzJcLodN+OSoRHko7BlE
 NxddR
X-Gm-Gg: AY/fxX602NPbt/6tD/E96Mxr+IUMZxO6xr57Yhxr0lpUjC4sk0xftAi+uCLa2XcY4/D
 D5/B8HMPlmPSi8PnKJLV86ou8IPe5svFdnrIprCIE+Z/q8jx0Cv8cjAbpxSKghny4nSaI9v28J2
 p3IgqOKqP6zmXeZfJfOYrbuH+HbHAZBx9WQszQze7Bka8vhv/mn6RMVtDoIobqXqFAgJ2KBBaVS
 it+D2U71xaJf96OT8ShYYWEsQyZ+hStqUwWqcPulNINl3j0k+7d9VwkpnEFqz1ew16xZuVe2GGP
 W7sjWAvlr2J1t5jL4KJGhT0Gf82AfqYLn0NcVvFlXYJh50qwqv8rrCDE9AGkzBzCbIqPdtIJ7LR
 VTyrwdbSisxOQM33r8KqXwJnGRtnqaBVFcfqr1bdPEpOn+ipH+IBGH+qnQ6LA6t65L/dy5p3wX6
 /VV+qGMkiFTfB8fCYhyxCNPRwlstH5UtDgQjlX401KJQQ5RohRrFIibRpmsHn9wrJbjn3zx8RrF
 1p8pgQ98BCIiNFN4MfTjlOmmlnn8rrxFIAHMsqBeakd/A==
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-4801e66fcc5mr31827705e9.10.1768568313587; 
 Fri, 16 Jan 2026 04:58:33 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm15387565e9.16.2026.01.16.04.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:58:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/4] mshv: Clean up includes
Date: Fri, 16 Jan 2026 12:58:27 +0000
Message-ID: <20260116125830.926296-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116125830.926296-1-peter.maydell@linaro.org>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes '--git' 'mshv' 'accel/mshv' 'target/i386/mshv' 'include/system/mshv.h'

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/mshv/irq.c            | 3 +--
 accel/mshv/mshv-all.c       | 1 -
 include/system/mshv.h       | 1 -
 target/i386/mshv/mshv-cpu.c | 1 -
 target/i386/mshv/x86.c      | 1 -
 5 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index adf8f337d9..3c238c33c3 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -10,8 +10,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "linux/mshv.h"
 #include "qemu/osdep.h"
+#include "linux/mshv.h"
 #include "qemu/error-report.h"
 #include "hw/hyperv/hvhdk_mini.h"
 #include "hw/hyperv/hvgdk_mini.h"
@@ -20,7 +20,6 @@
 #include "system/mshv.h"
 #include "system/mshv_int.h"
 #include "trace.h"
-#include <stdint.h>
 #include <sys/ioctl.h>
 
 #define MSHV_IRQFD_RESAMPLE_FLAG (1 << MSHV_IRQFD_BIT_RESAMPLE)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 4675cb886f..bed0fa298e 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -41,7 +41,6 @@
 #include "system/reset.h"
 #include "trace.h"
 #include <err.h>
-#include <stdint.h>
 #include <sys/ioctl.h>
 
 #define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 8b1fc20c80..75286baf16 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -14,7 +14,6 @@
 #ifndef QEMU_MSHV_H
 #define QEMU_MSHV_H
 
-#include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/hyperv/hyperv-proto.h"
 #include "hw/hyperv/hvhdk.h"
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1c3db02188..586383b882 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
-#include "qemu/typedefs.h"
 
 #include "system/mshv.h"
 #include "system/mshv_int.h"
diff --git a/target/i386/mshv/x86.c b/target/i386/mshv/x86.c
index d574b3bc52..0700cc05ef 100644
--- a/target/i386/mshv/x86.c
+++ b/target/i386/mshv/x86.c
@@ -13,7 +13,6 @@
 #include "cpu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
-#include "qemu/typedefs.h"
 #include "qemu/error-report.h"
 #include "system/mshv.h"
 
-- 
2.47.3


