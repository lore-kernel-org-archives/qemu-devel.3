Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A763DC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfOK-0003Xp-Ur; Fri, 17 Jan 2025 00:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNd-0001Pw-2P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNb-0006Df-AR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb94cceso20820495ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093530; x=1737698330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6PYrAaud1A8fkgX2672cOm89fY4AZSHQAdDHt+jLww=;
 b=QxNpZzNctjZR/kPwzi8uovtnGR7FuW+gZds1pm3ippzazf8kIYcBqo0aCbg5YGlgTf
 3RUyR0SlGQT4+tRK4OM6buKpPm0c6wcNibjGrccB6pdpJLlb5GaxBN/4rRlp4Gsy6csQ
 yNPnWiTYGzjnp7YcScCRHqRaFwSXVKvLkMahcgbY8Pj9MfXDdleqzThYI2eJkxoI0S1N
 NA/FECgmz4pvvXXRMtmh/9192+N14jzdCLDbXMm8MGydTosYcObqmFInBqHFwRWCrz07
 Jf4S48tA8Vm7sU5fxNYBNuEL5WjDXJA7ajE/6igpjhWB6EEivRd4M6/GVG5TO6jxY487
 e1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093530; x=1737698330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6PYrAaud1A8fkgX2672cOm89fY4AZSHQAdDHt+jLww=;
 b=gfVQau1zO47OVNDAkNSqk7ec8M1FtTmLGavToOj+q06/yvzKH17NFeDyZtxHrCxaUH
 Xj61UlUcfK/buzkHjkM3H1EuE1FEkpwa4IT8+AosJN0BmF1jkGAJ5DA1eXf3cEwwFApr
 IicGbXj5XBBW6vrlMOyKbz18J9k/BpvdXxfHVuJXnwWEk4A2uMbkQ2dDhCSfvYCmoYBk
 JFy/Go2lE6Y95CF2F28Mbs/a6znUpJ+ZB0jMgk0iwSgTD86woTX0MBcGJUd77+AJ9GFn
 UQH6QtfR6Madk+fjqeD/GePIwVpZ4LhbRja65eM+5hE/icpSIeCLmlz651GRvU1la53R
 VKGA==
X-Gm-Message-State: AOJu0YwLEnuE7XIWdG91FbqwJDS/neY1JzenG0VXh/wVx0hsHjjLFA1C
 DTgCszzgN4IVlcv6PAIkXSZjtVHdbazfU0qkm6iBsq25AynMdp3iyX8U5A==
X-Gm-Gg: ASbGncuwfBS8yNC7mh5kCSR0PnbOEoW/mn0XA9C1p5EtN6ucBEPOk2Cmp5j5JsFKHGZ
 blZdv8TA+mluPU6aIOChNHaj00xPC9tEVWx7TnSwsTDcxumgXpS0VNG4a18+BizZJWbIkFSBIk+
 FaDL3/76tyuoVVPA9IKjTTKZpwH6tF7p6SIufnv7T1/TOctYebvYDlCwWr7JP0HJJAFe/vrzOEn
 cXpsgT0gTeVR/m930d0LnPBSavVUh4BGCuiRnW1KpFTnHL2kA1db2dT55XHmO3iR6jJO/UJ8HRZ
 0qTdhdR4Ul2dX6oXYvc8H5dGw23hk3hbonnE9nvPIC/pCSNJblxXUhu4gZLD
X-Google-Smtp-Source: AGHT+IHjdVNQDaWMQuI3y9ijLMlZ9FsLb+bP1nFl+kg9zdaQ+Q6fEvhsVp3/FeqF/GprLvQT+gMapw==
X-Received: by 2002:a17:903:230b:b0:216:554a:212c with SMTP id
 d9443c01a7336-21c355f703amr19157055ad.46.1737093529698; 
 Thu, 16 Jan 2025 21:58:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/50] hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events
Date: Fri, 17 Jan 2025 15:55:52 +1000
Message-ID: <20250117055552.108376-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250116223609.81594-1-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 15 +++------------
 hw/char/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 11a0e1a7b7..ec5db5a597 100644
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
index 3ee7cfcdff..b2e3d25ae3 100644
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


