Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92197C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 22:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYYTO-0000ez-H9; Thu, 16 Jan 2025 17:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYTH-0000e5-Tv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:36:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYTG-00009c-6x
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:36:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so9753775e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737066972; x=1737671772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NEWcwlZ3rL0pM1lPXHd3q45mvxB7AAKYo4rVKUiR+b0=;
 b=jtRW/7Aknpi6jRHth7kSgyUQNe9nyKiVWSvz0ZQeItzSdsCFoDgDbYpELSN7qbME42
 eZb30poq+3geRgcH7q23H89IPsdbbiac2cqKnM6tkEGREK05b2lC1/PlLRgnAVyHJ8tO
 W+dObCZkfTFEToq0kvhp47TsCHedrT/w5ZcO2Kd6WDvTyiUF0DwO9IU8kQkYgoBh6jz5
 VwnQAyvV3Vo96/S59XcG+oM9cUxBb958W7X252F0eeAvYRdOM/cEfup4WNO8BgtGz6Rr
 5U/mPB70jLgClpgt0IoNgFvzvsEhoomJ3nO3NGn2e7WFQzg714AHX5rnAEe2JSoOX+G6
 DI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737066972; x=1737671772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEWcwlZ3rL0pM1lPXHd3q45mvxB7AAKYo4rVKUiR+b0=;
 b=Ah1zit7VLFl5t279QUBuBZd+qHuDAabK1DwSun8prX6ju2H8ZqUzVSBj84xKX5oTl7
 LsdJpEeym2BVjDgO7lLjlyhEzXCkBJ36nGinkVZR+d+mLFd1wh3ZmCK6I4qHZeN3TKDw
 uAluUXUpNhX1K6dYIOUn1iLY65cJoQ+wV6zQKBvF7lgvh6ewmn3TKYscrIAtIK5eWuIp
 ohWZdTUQ5W4wrXBPU2ZvKJNEb7msZI6bqzxIR4GfnML7uaZxSCNDijAbyIbO8UBUY3rQ
 Ed7Mbhn4/Eb4gir0IV98FKRs6Rmcr44XfbkBtfX+zBBquMr7kKzN39hyVzLPgz1GZg2y
 t+UA==
X-Gm-Message-State: AOJu0YyjvBKGFKDJsWeFjj4FJzI60I4bmYMm8oqKCMEW/RrF4qcFNwuL
 u7vgC5Mj3fR3wYYOlupX1BXn8dV3dneHiqKcZZr2xp8IQQrwBf7LZtT3et4QT8/JIulzb81mW7S
 EyO0=
X-Gm-Gg: ASbGnct34xdXHy5cONahk4MNjKlOXUqFesI4APuzc4bsdSCkXLGqmj9Mg7K4abp5SMe
 3xfszj8BS6MMzt/Ns1d0pFqVjDwj7nBOGLWrmGWhBhi5XAn9qMvvk3BZAa+cU6naaCRLe6fw2iJ
 HMyy6iTO3LLKbDaygcOrZTOxNy47BrPTK8bDFukfJB2NTtbHH0trsFGX6fHyBAajL16i+Y41Xt8
 nB3v7bX8manBYLPnqegjsJfrUMPx58S08RQEdfNlXcfax9IDh4dO57ekMu93cMoWOvrOtV4qu8t
 5+w0OfmebLYJZkVXiYxw2peodbLcpgA=
X-Google-Smtp-Source: AGHT+IExwbmFrREWvyWRsLco6OE8GRSYcuIIEHEpNIFLaYT/kfXpzOjBJdoAqFx5YnL5oa8Y/DguRg==
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-4389142e0e8mr3056075e9.22.1737066972163; 
 Thu, 16 Jan 2025 14:36:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904625e5sm12313865e9.32.2025.01.16.14.36.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 14:36:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events
Date: Thu, 16 Jan 2025 23:36:09 +0100
Message-ID: <20250116223609.81594-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/riscv_htif.c | 15 +++------------
 hw/char/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 11a0e1a7b7d..ec5db5a597f 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -32,14 +32,7 @@
 #include "exec/tswap.h"
 #include "system/dma.h"
 #include "system/runstate.h"
-
-#define RISCV_DEBUG_HTIF 0
-#define HTIF_DEBUG(fmt, ...)                                                   \
-    do {                                                                       \
-        if (RISCV_DEBUG_HTIF) {                                                \
-            qemu_log_mask(LOG_TRACE, "%s: " fmt "\n", __func__, ##__VA_ARGS__);\
-        }                                                                      \
-    } while (0)
+#include "trace.h"
 
 #define HTIF_DEV_SHIFT          56
 #define HTIF_CMD_SHIFT          48
@@ -159,8 +152,7 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
     uint64_t payload = val_written & 0xFFFFFFFFFFFFULL;
     int resp = 0;
 
-    HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
-        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, payload);
+    trace_htif_uart_write_to_host(device, cmd, payload);
 
     /*
      * Currently, there is a fixed mapping of devices:
@@ -251,8 +243,7 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
         }
     } else {
         qemu_log("HTIF unknown device or command\n");
-        HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
-            " payload: %016" PRIx64, device, cmd, payload & 0xFF, payload);
+        trace_htif_uart_unknown_device_command(device, cmd, payload);
     }
     /*
      * Latest bbl does not set fromhost to 0 if there is a value in tohost.
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 3ee7cfcdff2..b2e3d25ae34 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -136,3 +136,7 @@ stm32f2xx_usart_read(char *id, unsigned size, uint64_t ofs, uint64_t val) " %s s
 stm32f2xx_usart_write(char *id, unsigned size, uint64_t ofs, uint64_t val) "%s size %d ofs 0x%02" PRIx64 " <- 0x%02" PRIx64
 stm32f2xx_usart_drop(char *id) " %s dropping the chars"
 stm32f2xx_usart_receive(char *id, uint8_t chr) " %s receiving '%c'"
+
+# riscv_htif.c
+htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
+htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
-- 
2.47.1


