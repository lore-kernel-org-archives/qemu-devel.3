Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57CCD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMX-00054p-4Y; Tue, 12 Nov 2024 13:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMS-00052S-3Y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:32 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMO-0001v5-5l
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:31 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so4004500f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435086; x=1732039886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM2ZSeJRoX/j6Un6zic7nNQ/NMvb/n81U1A/iot7Isw=;
 b=qyRe20BrCStj5hbduR5TLk3vYh4Ma3XGSa817nf0jT0YlPgUUJ+bycGaqIDIFxjESL
 hJj+KI7r8J8gPpL0xot43Bq1kWIGWUg0LxWSjlgSo8SMDr4adh+vYhnZvh2TY4TWgpTk
 Ih3W/DUJNksr2c9GIYudxsT4ntUMtsvS0aJUd1giIDjp6i98utZ8ipPixFf42dSlGCaj
 epXuFNcJ7jBYEgivhvlGlzX4TJeTJeUjjrmDADzmZXY8wqr00c+zCK9ixjN6dczW5sKA
 eTpRM2qPhq9B99DRgribL7+hu8BYfPqJjFYy/Yf++Bd2w1MQtoSATilnEtZz8yFjCdzt
 vq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435086; x=1732039886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xM2ZSeJRoX/j6Un6zic7nNQ/NMvb/n81U1A/iot7Isw=;
 b=vrAlchPKNHXNxa4b/zhuhba+dgLNjRCNx4rqJjNTU+iA6IcPPWZgCFNNu0hSqewzPC
 vT1DqC586eDLiHPYV45qPadB019Oe1QfVMWnM0BZGAMFFy2X8Q5OgKZpjgJJg2KSHk4f
 3o+CeJHrVlktQXPkpBaD9L7Ok0OGF+4cLuIvZbckYvSXwH4tYPg5ZXMjIuzCjEmeFF+r
 S8VVPepk1xLKLdyUBkelErDdq3kvaRR49ZevHS2NasYEAc6TsRZPaB7WXOoTsYcHsoSO
 BiJmDiytKt978S2zIvGvVE/TqjwW3mF272Pa2IgdkNp+ewfJggS/Cxh513vvo/FuujRK
 b4pw==
X-Gm-Message-State: AOJu0YzbeyoY+appPiMpSGdd1bg5ONnv/jVDKq2OTRvy7SVMbttJlD/c
 p7SoBfiD2hjM0t1cjju1owmdopnNnIXj9D7QtBlLSmv/Ue5I4aADOBtMjFLcVek2sFHWSrW1iYg
 L
X-Google-Smtp-Source: AGHT+IG9uVZEhBAhRnBex9WXjjO3XeEIQrZQVWx7UHJ5Ux2BernQ7Du9ektBAkKzRc+mtRVP9N5U4A==
X-Received: by 2002:a05:6000:712:b0:37d:4ebe:164d with SMTP id
 ffacd0b85a97d-3820df7ae61mr55661f8f.47.1731435085814; 
 Tue, 12 Nov 2024 10:11:25 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda1433esm15896532f8f.111.2024.11.12.10.11.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/20] hw/net/xilinx_ethlite: Map MDIO registers (as
 unimplemented)
Date: Tue, 12 Nov 2024 19:10:30 +0100
Message-ID: <20241112181044.92193-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Rather than handling the MDIO registers as RAM, map them
as unimplemented I/O within the device MR.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-0000000081001fff (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index e6f6179fce..76b1e7d826 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -25,13 +25,17 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/misc/unimp.h"
 #include "net/net.h"
 #include "trace.h"
 
+#define A_MDIO_BASE   0x07e4
+
 #define R_TX_BUF0     0
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
@@ -71,6 +75,7 @@ struct XlnxXpsEthLite
     unsigned int txbuf;
     unsigned int rxbuf;
 
+    UnimplementedDeviceState mdio;
     uint32_t regs[R_MAX];
 };
 
@@ -231,6 +236,14 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
+                           TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
+    qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
+    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
-- 
2.45.2


