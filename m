Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822D8D74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInp-0007SL-4W; Fri, 23 Jan 2026 10:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInL-00075q-Lv
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInK-00034o-2F
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:55 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso1272918f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180993; x=1769785793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDxdvyymPUYfJ1YVYQgwZ0tgWpDlX8YBdNsrFKEuuxM=;
 b=cQSYnY54a2WwgFHQWqVRyzFbF0QaEoZ9/FxzMl9JL/efBl7GGSqjOkX5KuXjzdBVfo
 lo7bYvR4lM/a4Rfw0R82YEA3jZ+qgcKh0pGZA0QC+zdBi+LCI8qfyM8z3dS4nuH12BQN
 3h457K5/ykzFgj+ELxjghpgYdjHSS9AqyyM9JOova2gbEnutbF5t+4XOEmSls5Z0VViu
 erevzOh/Og5JJh9FYSFS3wnXgL8wzVywloVRhJ02LF/me47PzQkUNb61LV9HfDZ7+aC2
 dzHEPbIC3q0mq3wRak+JTHjdKKCzBzPbTFyuoLa74hEC9v3SjCEWj1P1TC9heb2Kqs/4
 bXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180993; x=1769785793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oDxdvyymPUYfJ1YVYQgwZ0tgWpDlX8YBdNsrFKEuuxM=;
 b=SQPNEtrzZlSArWEQJG3GRBSfo6I/bOvkq6JQjIs3Oh3zO7ee161I6eN3fz69m0+xEc
 0l6/yw9BTrC8YRrXA8CFmMdRXeWAzbjFvsOrO4QR4AN0gSToKFTw1vJ7uWCuI/1AvG0Q
 2uJUg0wZxA6/xEfkvUpevdG3P91H/12z9wPCntyKePKHG2PEJZTgEA3kqby0qokmQoQB
 zF/dy3wLiiOMJlHZ6Z+XzVhw2xV7RUFPg7KAplEJxVbjw+2DKPTRWDhUjR9+Mu5NzpTh
 ANsCVp39m5sq9M6gECpiHSYdgEefhKO6+wSM94QC5YXpkMLwBN4qFy6jJA6Skc50739P
 tzwQ==
X-Gm-Message-State: AOJu0YyphVSN4ZKG6ze9awQxiS3NNJ3G/FXkZMoVaiJU2TSzGnrC8C9p
 2usRdAaobiFHjW+YUtSZ0ExCV/WmchXtQQ9a626CZ2AX8p+3VxCnk4+7hVa0b1slX7ouJdvzwo5
 EXF6upYU=
X-Gm-Gg: AZuq6aLuJIBlvzzLmkGo8L6c6j+EjrRFaEdNUL0Vt3b4pf+PIve64aZakenyDJu/h8O
 ii9l8yHjOJk0e4lDHRE7GnONVUjzF9XEliuN/FztXESeTxVAWf3A8O/SByodtwh3jKpcPpDM4NI
 Ho+HyhVGjpBVyobWp1oR3XE2l1DEc9Lo+MVrq9vOsgJmj7J6oziCWvzI/9pQyys+feqPJ47/xlg
 J/tmIZYJg6QHjNg3rWihahfKEZDnzaDf0CMMbXrgsLBWMo/UVxe5JUCgDWidXP5upapZGrKSAsD
 hcyi63GVBUd0zl15nQE7WbtwfTOcMAQwtVgBVE5yajn7h55wvodzw3JSd45KtKTutFmTBE+bPTk
 gbz85gCMMJhuk65XhWQNqP3CNmp7M3H3FSL84ZSpPVPA7Dqwh2UP2+PdqdrZeDREyxonCxvGia8
 UtLyVhbiV2p+pj0GQ3ieH/n7LUnqXxPixsmP+k0Q+tXk2j276+Cff5
X-Received: by 2002:a05:6000:200f:b0:435:b6ab:6c1a with SMTP id
 ffacd0b85a97d-435b966a98fmr2988462f8f.49.1769180992424; 
 Fri, 23 Jan 2026 07:09:52 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/22] mshv: Clean up includes
Date: Fri, 23 Jan 2026 15:09:29 +0000
Message-ID: <20260123150941.1877768-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260116125830.926296-2-peter.maydell@linaro.org
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


