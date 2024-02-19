Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F74C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4M-0004iq-9f; Mon, 19 Feb 2024 03:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4I-0004Rd-57; Mon, 19 Feb 2024 03:32:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4F-0002XH-07; Mon, 19 Feb 2024 03:32:05 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2745969b3a.2; 
 Mon, 19 Feb 2024 00:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331520; x=1708936320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwPtUyKyEVd6AyaLlqPC6tZGZHAetOay6q3kchulGSU=;
 b=OhNbr7EiadrV2Caksoi3i3ibKMdi4lEl3ApxiZUsK5hisw4FkrHqx1Yy2lbQp1naIN
 4cJle1zheaqDW52q5PBtuitJ5WncU2q7AdwZ2naEZ4/QJ8R0bJeP2L3kjMXbksRiWnft
 /O1y0lDpGPB6PHQ96fNVYzSZHWsyduZRfUmsEiHfXYkXvZcLoB4NyveR9TzHchy1HkAo
 wkkl2nyPNf7LqDq2YBt8Wix7M3GcfK0DDo3TWjK5+vaAKcelrmLLi4ihj/ot4PSrrB0n
 1QqNOVQ3fgMonFK8n6mut/iYXfnbq0gO9U997D48MSYuWWNqDUOMmJ+akmYxKHhJ5NU8
 CV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331520; x=1708936320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwPtUyKyEVd6AyaLlqPC6tZGZHAetOay6q3kchulGSU=;
 b=bmOg8XePsiHqYxRjXkjFRAiw3UAoS3ExO+kZWFx2rKnhn5Uy6O/KnDhTTy2AbzpYgL
 /BLAkpsv4/OwpqT6V1VfzbImfbHHgRjOsTT5qg8LArwTar9UDL3En2WKYRyQWrcS6Ewx
 LGzr3GcMGWWErlrgcHk4aJfOHBHj3UWbQgzjp+jnSWjFqLCO9w3hheCUR/T7u+pdDkSM
 175fP8gWhFnVuFIIUTfn+srtJ3zRHDumus6LBuz194gaoL1J/psdw2OBOAcwNVntqZ00
 4bkCMeZH5M/jqIhI+pGTODPBXL0EtX5l4JkeGjR/jiF5PbRqQtkXGWVROUFfVVILHYVU
 rD1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8TIF4oEUwFRnT3UVcPnYMxP+8QhddnupwNleuv3qo1qanZa1osgJjAY98t1ndvPJNzi36zYl+361Olwna75ENGuF3
X-Gm-Message-State: AOJu0Yyv96G1eJrg3ma/C/UtRXxBu/flRUMw2+AwPypffqU7hOFrlmvy
 ePx+YlDVQDYSk6wkWuVeYbUVkx7x9PIaHb2kEnMYhteec9VeBfJNaPFNttU4
X-Google-Smtp-Source: AGHT+IFOx4jAkl8yw1lxKn13heUoYIpoH1uCd5iGjtyBTgj9McWTAzvqgsoA3GhYu6BNYFCPO2Qp3g==
X-Received: by 2002:a05:6a20:a814:b0:19e:39d4:284c with SMTP id
 cb20-20020a056a20a81400b0019e39d4284cmr10917704pzb.29.1708331520478; 
 Mon, 19 Feb 2024 00:32:00 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 27/49] ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug
 power control
Date: Mon, 19 Feb 2024 18:29:16 +1000
Message-ID: <20240219082938.238302-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

For power10-rainier, a pca9552 device is used for PCIe slot hotplug
power control by the Power Hypervisor code.  The code expects that
some time after it enables power to a PCIe slot by asserting one of
the pca9552 GPIO pins 0-4, it should see a "power good" signal asserted
on one of pca9552 GPIO pins 5-9.

To simulate this behavior, we simply connect the GPIO outputs for
pins 0-4 to the GPIO inputs for pins 5-9.

Each PCIe slot is assigned 3 GPIO pins on the pca9552 device, for
control of up to 5 PCIe slots.  The per-slot signal names are:

   SLOTx_EN.......PHYP uses this as an output to enable
                  slot power.  We connect this to the
                  SLOTx_PG pin to simulate a PGOOD signal.
   SLOTx_PG.......PHYP uses this as in input to detect
                  PGOOD for the slot.  For our purposes
                  we just connect this to the SLOTx_EN
                  output.
   SLOTx_Control..PHYP uses this as an output to prevent
                  a race condition in the real hotplug
                  circuitry, but we can ignore this output
                  for simulation.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 78f5c6262a..97bdfb2d1e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1900,7 +1900,19 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9552 I2C device for PCIe hotplug control
          * to engine 2, bus 1, address 0x63
          */
-        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+        I2CSlave *dev = i2c_slave_create_simple(chip10->i2c[2].busses[1],
+                                                "pca9552", 0x63);
+
+        /*
+         * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to GPIO pins 5-9
+         * (SLOTx_PG) inputs in order to fake the pgood state of PCIe slots
+         * after hypervisor code sets a SLOTx_EN pin high.
+         */
+        qdev_connect_gpio_out(DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(dev), 5));
+        qdev_connect_gpio_out(DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(dev), 6));
+        qdev_connect_gpio_out(DEVICE(dev), 2, qdev_get_gpio_in(DEVICE(dev), 7));
+        qdev_connect_gpio_out(DEVICE(dev), 3, qdev_get_gpio_in(DEVICE(dev), 8));
+        qdev_connect_gpio_out(DEVICE(dev), 4, qdev_get_gpio_in(DEVICE(dev), 9));
     }
 }
 
-- 
2.42.0


