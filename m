Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9ECC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPru7-0005lm-Tb; Thu, 12 Jun 2025 20:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_WpLaAcKCkow0yx0pus00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--komlodi.bounces.google.com>)
 id 1uPru6-0005kz-A0
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:18 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_WpLaAcKCkow0yx0pus00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--komlodi.bounces.google.com>)
 id 1uPru4-0000WN-0x
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:18 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b2f103f6074so945371a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773054; x=1750377854; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=d0QgfeILdUyMD1NSsyF9wqtByo57i/HsEw7CLoZHHwQ=;
 b=TWyNMfq/1D69OsTULtleaNAwWsYolubi5a914+SG7TjW4wh9edEf+nnkPLWknk3nzs
 tIWKUYOIKXGqWaE5nO+Ef8c58hFaIEqBk2olpxU67jjxLUwwfzfFC9FmlLpZOBXH1CNQ
 MMs4pFbSuN695SFvAHqEnzfsMwbEgtCur4p+qZk+EnTt2+rkW6wczhSlpH9s9I6rDAJq
 h4Afod+4t/+NE9oS0TH3pg6dpgbeFBtolgeSbdjFl67Qt+PpCp8g/7Ef8oiMRi5Nhplu
 GclNFWIWrq/hAV0oWQgKnv4YDZIg8hw7XGSsj4x1PY/JwKd3oxT4ckUGl4w8bqsWeGgd
 YB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773054; x=1750377854;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d0QgfeILdUyMD1NSsyF9wqtByo57i/HsEw7CLoZHHwQ=;
 b=XPnpRsAqdO2e7sTQYOp9MEIMWDl4gJj6ujHEWf8XH27B8vXWe3Hr0dZ0PcSuvEiYiM
 P1cmXv3kTKFuk5LywN1DH9HZjy93Cr82g4s2FUaPCQPeSVzrJOm35FIspupzwIIk8qlo
 2sT5IFrla7kT0tdXJwsAVJ2vQ5UcLhBDz/dfvCoxs/cA9rEYIDu5iJwqqLKLhfFFmAIW
 ijPGA/cm07lnpRmJl5fqKzcnpn/0zrPdaEpJdG7b0g9BUdtKyBOfEN3AA4Ah9jTlTDfA
 PufBH7Q1Q+ExTXeF0Sd8tdzTGneKpoSQa47KjVJElyAdDbiVwYZb5DpTF6EYo1AxuR3f
 JlhQ==
X-Gm-Message-State: AOJu0YwFHmaMo9mqKm/eO8gYG7wMIwyTnOxH8VkekvglCcslaiOtUGgJ
 aqz409TH52vLdLgQav2LFTj2O9zhJvElQLMzcfJ+YX6NmchIp/0VdmjTyjaPA6T5ebMUEUwENno
 b+oaJ2PNTbUEdxOW2/h2Y910u+K2oCcAHf/tjQnUE+bSoy+tlhddEDF1MV9kNNt77RFIEe1WGYf
 iG74hv+wieLo2WH6QrhoQGaNv5HFa/BRVYM/r4jJZT
X-Google-Smtp-Source: AGHT+IFkwbndRCus8AHEk0L4obEO+w7S4ETJu7WgtZ9eKEPgvmWf6hXEo3DwX2varqNhaoEwWKe9HsVNcJSR
X-Received: from pgbfy15.prod.google.com
 ([2002:a05:6a02:2a8f:b0:b2e:c15e:3eb7])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:394a:b0:21c:fa68:c33a
 with SMTP id adf61e73a8af0-21facc8e6f5mr1222482637.23.1749773053909; Thu, 12
 Jun 2025 17:04:13 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:53 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-2-komlodi@google.com>
Subject: [PATCH 01/19] hw/misc/aspeed_i3c: Move to i3c directory
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3_WpLaAcKCkow0yx0pus00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build
files.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Titus Rwantare <titusr@google.com>
---
 hw/Kconfig                            | 1 +
 hw/arm/Kconfig                        | 1 +
 hw/i3c/Kconfig                        | 2 ++
 hw/{misc => i3c}/aspeed_i3c.c         | 2 +-
 hw/i3c/meson.build                    | 3 +++
 hw/i3c/trace-events                   | 7 +++++++
 hw/i3c/trace.h                        | 2 ++
 hw/meson.build                        | 1 +
 hw/misc/meson.build                   | 1 -
 hw/misc/trace-events                  | 6 ------
 include/hw/arm/aspeed_soc.h           | 2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h | 0
 meson.build                           | 1 +
 13 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 hw/i3c/Kconfig
 rename hw/{misc => i3c}/aspeed_i3c.c (99%)
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/trace-events
 create mode 100644 hw/i3c/trace.h
 rename include/hw/{misc => i3c}/aspeed_i3c.h (100%)

diff --git a/hw/Kconfig b/hw/Kconfig
index 9a86a6a28a..61b8b2a142 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -13,6 +13,7 @@ source fsi/Kconfig
 source gpio/Kconfig
 source hyperv/Kconfig
 source i2c/Kconfig
+source i3c/Kconfig
 source ide/Kconfig
 source input/Kconfig
 source intc/Kconfig
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..427d0f0271 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -530,6 +530,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select I3C
     select DPS310
     select PCA9552
     select SERIAL_MM
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
new file mode 100644
index 0000000000..e07fe445c6
--- /dev/null
+++ b/hw/i3c/Kconfig
@@ -0,0 +1,2 @@
+config I3C
+    bool
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
similarity index 99%
rename from hw/misc/aspeed_i3c.c
rename to hw/i3c/aspeed_i3c.c
index 3bef1c84dd..e56822f928 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
new file mode 100644
index 0000000000..ebf20325cb
--- /dev/null
+++ b/hw/i3c/meson.build
@@ -0,0 +1,3 @@
+i3c_ss = ss.source_set()
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
new file mode 100644
index 0000000000..3ead84eb45
--- /dev/null
+++ b/hw/i3c/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# aspeed_i3c.c
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h
new file mode 100644
index 0000000000..1e0c4eadf0
--- /dev/null
+++ b/hw/i3c/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_i3c.h"
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..31786f03d0 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -12,6 +12,7 @@ subdir('dma')
 subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
+subdir('i3c')
 subdir('ide')
 subdir('input')
 subdir('intc')
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..4a41716625 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -130,7 +130,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
-  'aspeed_i3c.c',
   'aspeed_lpc.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e3f64c0ff6..f70459b3b7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -287,12 +287,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
-# aspeed_i3c.c
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
-
 # aspeed_sdmc.c
 aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
 aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 217ef0eafd..07265f26cf 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -23,7 +23,7 @@
 #include "hw/timer/aspeed_timer.h"
 #include "hw/rtc/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/misc/aspeed_hace.h"
 #include "hw/misc/aspeed_sbc.h"
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
similarity index 100%
rename from include/hw/misc/aspeed_i3c.h
rename to include/hw/i3c/aspeed_i3c.h
diff --git a/meson.build b/meson.build
index 34729c2a3d..186effb84f 100644
--- a/meson.build
+++ b/meson.build
@@ -3651,6 +3651,7 @@ if have_system
     'hw/fsi',
     'hw/hyperv',
     'hw/i2c',
+    'hw/i3c',
     'hw/i386',
     'hw/i386/xen',
     'hw/i386/kvm',
-- 
2.50.0.rc1.591.g9c95f17f64-goog


