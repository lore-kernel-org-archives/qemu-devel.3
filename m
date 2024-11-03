Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3114D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7aky-0006KX-SY; Sun, 03 Nov 2024 08:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aks-0006C6-DT; Sun, 03 Nov 2024 08:34:59 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akq-0001Fz-Pl; Sun, 03 Nov 2024 08:34:58 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso469338066b.3; 
 Sun, 03 Nov 2024 05:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640894; x=1731245694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LrsAVgiHNYWHzjycHLAubvkskxhUaO0hAeiKijzufc=;
 b=OTfSeM0ieNxm+o8dhgsRUtA+iYXAx9H3tr8HaGNErkOoru+iciDxeCJR7O/G4wVjJS
 5uacOl8ruRuJH38Lbe2LHMGH5S9pGIN0xcSu11UW05oddPoHbNZHvAKzoyW0V6ibvM4l
 K8GOk+qG9Mu2IrM2hb4PsdWJb/FoIqQ4yeZVuZnHb0ktWTpjezyLKJEJFYcbbUT2GNiX
 71jFnXfNVeHL37JFA4F2AvY0xnkJEK03gBITtwJhh6uF0R0lkZB44tCIrZEQ0gRTy9L0
 EQ7W/fmh1Ubbw5QWUws2v7nNvx12YrN7zpOzzl7KbJcztBKtfEWxrfyuIkdtO9hRjJRo
 MYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640894; x=1731245694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LrsAVgiHNYWHzjycHLAubvkskxhUaO0hAeiKijzufc=;
 b=AxozvTQ/BatnJw50K19h9qsiqHwWG83SPrMJgwRHThi3vDww3JL/q4dyAIbbeHPO2d
 czOBCkmD1ZX8kNY8728/clzb+vifK2iwUP0xdG6EKU/k/PW/r9VlyTGjywvc+DwjUlNC
 zm2AUHV8kNo4qdzZ4Mq/SDCY988/kw+9V62dLfbQWSeVRhBhce+4aPcT1Igrea/Kt/BA
 PMt6xEaBJSvETZMm7DbJEqR95fWYQfy7o2vkY6uReBYs+Hb8Ghp+U0Fh4ugP7hCSmfJt
 NXAMkq5lqDd64s32zR15fXSGW6WYIPPw2qaBJ7Hsyi7kO2A7sDUJ0yrCeEdf9P9+Txkz
 cH5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI2nbwgoLGGAyU3qFvF8jGiiS1o3uN28aXUmNNQkB9RNVXtdaikuj6N1sMh3Ke/p1iidULd36JGVQj@nongnu.org,
 AJvYcCXHAfLRJ5YpuLaylcPmDfuyyJ8Ki548tkv7NFq0scRmL8dWJY7fKkjDArS1m3p1Toh7rsHhFbMkmJA=@nongnu.org
X-Gm-Message-State: AOJu0YxCsOqOX3JS73J+wEPO6xjQC08bcXBspfh4VnP8gi9EIJRidknP
 oWYYjm6A7WwqzJXtt2JLDPgcjDBpX9uXU2VtY1H2Um4LiDLBgeo2TPyZEA==
X-Google-Smtp-Source: AGHT+IGGqec/lBlZhlqUjJJtcC2SRULsfxWaoxXKs3/e50EAVjutNghDuXtXSNX6EdSwnl2VhJBuPQ==
X-Received: by 2002:a17:907:9413:b0:a9a:1f8:6c9b with SMTP id
 a640c23a62f3a-a9de5fe7455mr2899437166b.37.1730640893838; 
 Sun, 03 Nov 2024 05:34:53 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:53 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 09/26] hw/ppc/ppce500_ccsr: Trace access to CCSR region
Date: Sun,  3 Nov 2024 14:33:55 +0100
Message-ID: <20241103133412.73536-10-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The CCSR space is just a container which is meant to be covered by platform
device memory regions. However, QEMU only implements a subset of these devices.
Add some tracing to see which unimplemented devices a guest attempts to access.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/ppce500_ccsr.c | 25 ++++++++++++++++++++++++-
 hw/ppc/trace-events   |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
index b1fb4090c0..31efc7bee8 100644
--- a/hw/ppc/ppce500_ccsr.c
+++ b/hw/ppc/ppce500_ccsr.c
@@ -13,12 +13,35 @@
 
 #include "qemu/osdep.h"
 #include "ppce500_ccsr.h"
+#include "trace.h"
+
+static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t value = 0;
+
+    trace_ppce500_ccsr_io_read(addr, value, size);
+
+    return value;
+}
+
+static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+    trace_ppce500_ccsr_io_write(addr, value, size);
+}
+
+static const MemoryRegionOps ppce500_ccsr_ops = {
+    .read = ppce500_ccsr_io_read,
+    .write = ppce500_ccsr_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
 
 static void ppce500_ccsr_init(Object *obj)
 {
     PPCE500CCSRState *s = CCSR(obj);
 
-    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
+    memory_region_init_io(&s->ccsr_space, obj, &ppce500_ccsr_ops, obj,
+                          "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->ccsr_space);
 }
 
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 1f125ce841..ca4c231c9f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -143,6 +143,9 @@ ppc_irq_cpu(const char *action) "%s"
 ppc_dcr_read(uint32_t addr, uint32_t val) "DRCN[0x%x] -> 0x%x"
 ppc_dcr_write(uint32_t addr, uint32_t val) "DRCN[0x%x] <- 0x%x"
 
+ppce500_ccsr_io_read(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] -> 0x%08x (size: 0x%" PRIu8 ")"
+ppce500_ccsr_io_write(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] <- 0x%08x (size: 0x%" PRIu8 ")"
+
 # prep_systemio.c
 prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 prep_systemio_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
-- 
2.47.0


