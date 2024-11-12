Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A4D42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvO1-0008Ok-3O; Tue, 12 Nov 2024 13:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNk-00087C-In
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNi-000252-Tb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so52048365e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435169; x=1732039969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGd9i6/ENCkloXaai0AVofeTZOoMIoGHzhdQpEJmiRQ=;
 b=jcFmTIjyoK6xDENyHe5EMZdXQLfagMQVaFfyKWbB+m4++zITs3+AcEg6TEDAyFF9S4
 k47+kriwiHweJw8BeUGfGdTiU0Cvfs5VHIUE8M2cVOTGZbpgNPIHUEne3nOt4qz4s2mV
 LhyuidLH426wrrMa83DmCvVqZ4WqrYIFW3ugjTOlfzUcgylW41RLRljkDM+i/AaBkFLd
 mMtg0I0Y+ZA6oDbuqPdNEFmgd+lr0EHLq3X3ILPot+UlfE8aCMim+F/dcP7jFZNT27Q4
 VFh4m55OKvL1Os8H4GZEHyYRvgWfXMZmqotj0PFYEiaqIGC8RyELGpDrj0bGoCCRbNjd
 zdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435169; x=1732039969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGd9i6/ENCkloXaai0AVofeTZOoMIoGHzhdQpEJmiRQ=;
 b=I3OD1snQ/tEKdrTH8Xl/BnmW+e4m5IuQT/y4uluLIY5OPO4RiOmLIK1ZiQgnJgHz4A
 XK/p/q4a4zBYOo8npH0cl9VTnVKGDtU0m0dKAsNQy55Nlc1+TxIsOUjnvxNDfTFKH9h/
 HqDnNY1JXAHesijriARq8Xfe8qKZKXIY/r+hSnbOfzt+SmZ51UOnXqkhZYVxpDpjNgfd
 cl7t/6m6HT6cUEmV65UP3NMGzAavR1YjN0TQXfbCJi5pEfzKT5VN8ZDAVo4BKTxbGxyH
 GC2qGIc/xWHZpXv8WGakC5nKDAHfPIfjlrsTYMiLlJtMvZ2sI6zekc2fZHX/g38yD3pg
 hPkA==
X-Gm-Message-State: AOJu0YytjEqI+Bd9i55YcD/gMKJM36iQg5g61J/gDJXmgggAVl0fUAT+
 RO+nhYkzGlMOpO84bxsEAYPBtKWP5dOo+ME8aWEeM/A8d9otqX1p0mQhodmVlAsERx1GaEnm6Cq
 F
X-Google-Smtp-Source: AGHT+IEj761L13C8DsFW7HfiCrAxRK8vWDbgclnkVXfP1rxIiOBJOrP3g1eMUKWnxff8qFHro/I5yg==
X-Received: by 2002:a05:6000:490d:b0:37d:50a4:5da4 with SMTP id
 ffacd0b85a97d-381f188ca9amr16104373f8f.50.1731435168869; 
 Tue, 12 Nov 2024 10:12:48 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970f68sm16118908f8f.11.2024.11.12.10.12.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:48 -0800 (PST)
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
Subject: [PATCH 20/20] hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
Date: Tue, 12 Nov 2024 19:10:44 +0100
Message-ID: <20241112181044.92193-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Having all its address range mapped by subregions,
s->mmio MemoryRegion effectively became a container.
Rename it as 'container' for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index da453465ca..c65001cf46 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -93,7 +93,7 @@ struct XlnxXpsEthLite
 {
     SysBusDevice parent_obj;
 
-    MemoryRegion mmio;
+    MemoryRegion container;
     qemu_irq irq;
     NICState *nic;
     NICConf conf;
@@ -306,7 +306,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
-    memory_region_init(&s->mmio, OBJECT(dev),
+    memory_region_init(&s->container, OBJECT(dev),
                        "xlnx.xps-ethernetlite", 0x2000);
 
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
@@ -314,31 +314,31 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
     qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
     sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
-    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
+    memory_region_add_subregion(&s->container, A_MDIO_BASE,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
         memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
                                i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
                                0x07f4, &error_abort);
-        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
+        memory_region_add_subregion(&s->container, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
                               &eth_porttx_ops, s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
                               4 * TX_MAX);
-        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
+        memory_region_add_subregion(&s->container, i ? A_TX_BASE1 : A_TX_BASE0,
                                     &s->port[i].txio);
 
         memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
                                i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
                                0x07f4, &error_abort);
-        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
+        memory_region_add_subregion(&s->container, 0x1000 + 0x0800 * i,
                                     &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
                               4 * RX_MAX);
-        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
+        memory_region_add_subregion(&s->container, i ? A_RX_BASE1 : A_RX_BASE0,
                                     &s->port[i].rxio);
     }
 
@@ -354,7 +354,7 @@ static void xilinx_ethlite_init(Object *obj)
     XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
 }
 
 static Property xilinx_ethlite_properties[] = {
-- 
2.45.2


