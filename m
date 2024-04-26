Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3BEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RV1-0007MW-9K; Fri, 26 Apr 2024 15:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUz-00079M-1w
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:45 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUr-0003qt-2P
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:44 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso3829503a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160675; x=1714765475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRQC9Ufjc2oRJM0oXSiGkyeAlDlLBhL0/a+ZOEekFQY=;
 b=bSeDSl62Q5IsRYUSHWOc0O+wj2f7ulfnbkS5th5Jd8qXXcOkIhlsgvgdLX1TAgrzKj
 +h9aqHtlvoxHMenAI1tEXoXiVSztGRIP/M46eJxCGCgXxHBm1P0mouYuuIGNJVAI2oTd
 ng06hDIOYkBPduteJPbHz5o1N/XWY1b7fsTJLcxTsB/Qg87ioZYere1bawvPey8388Y6
 dV2wCsJtN1yuqcNvOKZbuf5tAZe+VsuGfSGwimDxDKkMUnAvYgDTwDzUG8yUH9Z472eR
 pefiaygnWmPcLslLszqapCxc9oCdjViaHNbiBTAht3VDTZ55DhBSOygtVL3bY0d9XrHp
 gecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160675; x=1714765475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRQC9Ufjc2oRJM0oXSiGkyeAlDlLBhL0/a+ZOEekFQY=;
 b=RQZafC+zIDwWGp2grOQjpsIlcR6mPuyHB3/Co/3RYL+BL6jtz3IQecISW6q9nbQDZc
 ptscylUJDsQ+/qSM+L4ebKPn8VlKHFUOdketSSSmg6XJPm3s8RSK9rdQA/jn1oW/Giub
 DDNZ6TRvxRPvlWeGfFpBM8GKc+EY0ZQKpZ8UT08jn+16ZWJFq0oUMXB+oTkhq0Qf5yvV
 p1bg6sbc17L3lCXkK3Waey5+Fh/tLX9RpziiCw05gpvQVR+aTd7qxA7r16HosKXM1OR6
 Cpi2HUzAA1Zs3Mu38byjOmzYIet2V56/ia2LX3BhpxN92w3Bf6ZKlzZbDLWcflS06zR1
 A3vg==
X-Gm-Message-State: AOJu0Yx1NTmyZ173kWLBoRfGzoZtNZHCuDzWFP/rELnK8jT1lIqrEVFD
 XJb9YM5a9wi+vubWPasWmPgiVIoi8nepLaW5I4YQEEtGGaS7n7y7LTxQa4y+H0Rg+OqUavhdyx+
 A/Oc=
X-Google-Smtp-Source: AGHT+IEBypxG1+3HiSiPhWQJ3NZrPvjKaHrXTATJvdQw5YQtIgcD72BF9xRa13gBLJwXdO6XRCJddA==
X-Received: by 2002:a17:906:3918:b0:a58:7e41:c65a with SMTP id
 f24-20020a170906391800b00a587e41c65amr2633724eje.25.1714160675220; 
 Fri, 26 Apr 2024 12:44:35 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 f1-20020a170906ef0100b00a587cfd7a37sm4742921ejs.84.2024.04.26.12.44.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:44:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PULL 26/38] exec: Declare target_words_bigendian() in 'exec/tswap.h'
Date: Fri, 26 Apr 2024 21:41:46 +0200
Message-ID: <20240426194200.43723-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

We usually check target endianess before swapping values,
so target_words_bigendian() declaration makes sense in
"exec/tswap.h" with the target swapping helpers.

Remove "hw/core/cpu.h" when it was only included to get
the target_words_bigendian() declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-16-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tswap.h     | 12 +++++++++++-
 include/hw/core/cpu.h    | 11 -----------
 cpu-target.c             |  1 +
 disas/disas.c            |  1 +
 hw/audio/virtio-snd.c    |  2 +-
 hw/core/cpu-sysemu.c     |  2 +-
 hw/core/generic-loader.c |  2 +-
 hw/display/vga.c         |  2 +-
 hw/virtio/virtio.c       |  1 +
 9 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 5089cd6a4c..b7a4191347 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -8,9 +8,19 @@
 #ifndef TSWAP_H
 #define TSWAP_H
 
-#include "hw/core/cpu.h"
 #include "qemu/bswap.h"
 
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise. Note that in target-specific code, you can use
+ * TARGET_BIG_ENDIAN directly instead. On the other hand, common
+ * code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very well
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 /*
  * If we're in target-specific code, we can hard-code the swapping
  * condition, otherwise we have to do (slower) run-time checks.
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index cead8f01a6..d89b2cffcb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1168,17 +1168,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-/**
- * target_words_bigendian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
- */
-bool target_words_bigendian(void);
-
 const char *target_name(void);
 
 #ifdef COMPILING_PER_TARGET
diff --git a/cpu-target.c b/cpu-target.c
index 4c0621bf33..f88649c299 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -35,6 +35,7 @@
 #endif
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
+#include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
diff --git a/disas/disas.c b/disas/disas.c
index 7e3b0bb46c..ec14715ecd 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -6,6 +6,7 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "exec/memory.h"
 
 /* Filled in by elfload.c.  Simplistic, but will do for now. */
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..6a2ee085c0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -20,11 +20,11 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "include/qemu/lockable.h"
+#include "exec/tswap.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
-#include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index d0d6a910f9..2a9a2a4eb5 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index d4b5c501d8..ea8628b892 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index e91a76bf76..30facc6c8e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..893a072c9d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "exec/tswap.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
-- 
2.41.0


