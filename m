Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EB5C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuB-00042g-RW; Fri, 23 Feb 2024 10:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjS-0006El-CT; Fri, 23 Feb 2024 10:45:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjQ-0006QD-ME; Fri, 23 Feb 2024 10:45:02 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso3032435ad.2; 
 Fri, 23 Feb 2024 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703098; x=1709307898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ijrS4DhFtvxM8qHOFOs6E83bMjRZxUnmUO16CHqrQ=;
 b=N/OdPl0FVR/K9x43L9xutbQsSCoL8mCE+/5WjVGRFvogA6rwS8uTl25K7FHY+odU7B
 QqnlDbi+Z/Yl9zCH+/fiBQE8Fj0T6JzVbHu/bDMRpSIGgOxHfH9YBFs4oO8Ib9cgeFk0
 l9l91YoEZT0TsZB8sJCdCI0SDXReuGZoh6LdnOX5VyWWMqPQnqDLdr7/vZvvkwpiofJ2
 aNfgsG/+YD7ecTwPvnsWNmO9hKfhjRjJ0Qr+3Tt0KjW0WAIcIZGke5COK9E1MQUgEOjj
 Vke0P2AKxe766H0pbcwo9jQ30h8Mme2U1WB40eD9C55/76IVck6bBW5uQe0gfTqgMFEM
 Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703098; x=1709307898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2ijrS4DhFtvxM8qHOFOs6E83bMjRZxUnmUO16CHqrQ=;
 b=rmy21SJtn+EhC63/m20ZtHlJT8YuBqdklRpTg7U/8J20yuShzlO3ppNzqh2JKxkENd
 2wxpsy+ct+HLQstnVQ//zmQMCtqvRHM0k0QlEzTHHvh6qgWg7LLiNbURBohYA+VJjYHZ
 RYuIQBabdyZ2Q/D0ywohjxkn4V82w77tC0Hve74Qx031skSHB6q5xN0MQF4Gf3Cyxu5H
 V3H/g+Pl7LyKFjOWk2W4oSXBBxpsFyOzF9QAddp5B1QfjRNgAjc6BZTGQnEaZZvQQSo7
 jkmpdO7rE2LVDjzjTYmCrf0/Q/rvx66JkGttb7P4UyGr2vc9kSYT7bYTMy7KdkCFj9TR
 UwDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7bZ6HuZJ9j9KFsyGCe8HH1bOIRfFsKAazQxYG7FqQQGkOQkHszQEUD5ySLyfJ8ucKJ9HcgutLNAbGoDEB6F7Nr88R
X-Gm-Message-State: AOJu0Yy01Jtsl4ArPUWYJLzbHBFYR0U6zfQaywA3niNkeZsQBexx+iOU
 nIpgEE/RCjjqxdaJRrFpuncTy25JaVTQMnlL6tw2bqcn1Eo4po8LCXDFzbiZ
X-Google-Smtp-Source: AGHT+IGO2lWo7Gv+xmbxZCM+/SpQ2Vqyue+qzABkxMsKl6iX67PB2jqAZqZ4mjcRBsexS7st/I55/g==
X-Received: by 2002:a17:903:2487:b0:1db:c1fd:de77 with SMTP id
 p7-20020a170903248700b001dbc1fdde77mr192906plw.38.1708703093739; 
 Fri, 23 Feb 2024 07:44:53 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 26/47] ppc/pnv: Use resettable interface to reset child I2C
 buses
Date: Sat, 24 Feb 2024 01:41:45 +1000
Message-ID: <20240223154211.1001692-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The QEMU I2C buses and devices use the resettable
interface for resetting while the PNV I2C controller
and parent buses and devices have not yet transitioned
to this new interface and use the old reset strategy.
This was preventing the I2C buses and devices wired
to the PNV I2C controller from being reset.

The short term fix for this is to have the PNV I2C
Controller's reset function explicitly call the resettable
interface function, bus_cold_reset(), on all child
I2C buses.

The long term fix should be to transition all PNV parent
devices and buses to use the resettable interface so that
all child buses and devices are automatically reset.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_i2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 656a48eebe..774946d6b2 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -629,6 +629,19 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
+static void pnv_i2c_sys_reset(void *dev)
+{
+    int port;
+    PnvI2C *i2c = PNV_I2C(dev);
+
+    pnv_i2c_reset(dev);
+
+    /* reset all buses connected to this i2c controller */
+    for (port = 0; port < i2c->num_busses; port++) {
+        bus_cold_reset(BUS(i2c->busses[port]));
+    }
+}
+
 static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 {
     PnvI2C *i2c = PNV_I2C(dev);
@@ -654,7 +667,7 @@ static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 
     fifo8_create(&i2c->fifo, PNV_I2C_FIFO_SIZE);
 
-    qemu_register_reset(pnv_i2c_reset, dev);
+    qemu_register_reset(pnv_i2c_sys_reset, dev);
 
     qdev_init_gpio_out(DEVICE(dev), &i2c->psi_irq, 1);
 }
-- 
2.42.0


