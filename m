Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBCAC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz4W-0004ms-6A; Mon, 19 Feb 2024 03:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4K-0004bs-JS; Mon, 19 Feb 2024 03:32:08 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4I-0002Xc-U0; Mon, 19 Feb 2024 03:32:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d71cb97937so39750425ad.3; 
 Mon, 19 Feb 2024 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331525; x=1708936325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ijrS4DhFtvxM8qHOFOs6E83bMjRZxUnmUO16CHqrQ=;
 b=D3sXkoBLGNcSmOi6eqcOsMIqFA1wZrQEawXByHziLiYHcSyJtqA/Cv/6jGM015XIVS
 0OcjJG8M8kYxeoGm5BBvrsBG5kE0HfXtS59ZlCxjOFLWKyHiNHVRosJPRWuE/EzcLPS2
 OjBPhTCU1Fsvd7CJCBV7Au8hBmWCgvmOB9hvpyNZ93DxHlSp/sBVPk+XCXxKJ+0/kJ1a
 UKa3Rvu7F5Z3rlYFwD7A16e+fXpfW233HPCQ3k8rEGI7anQuNEtiM68KMAOcrIWxOOQX
 huAB7X8AhQqAVtsLm/1+Xx090Up3DEDdx138Fc9XUklK3v+RoPKEDijPFjRTX/Ad4yjk
 3d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331525; x=1708936325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2ijrS4DhFtvxM8qHOFOs6E83bMjRZxUnmUO16CHqrQ=;
 b=v7QLayhJH+/EkXEdow/K5WHepknck3cCRxx06j7mt+LYqQnaAD6xk8mvZ9CGj+RHjD
 Nsa9S3MRB7gn46nuAr5mZcUBtw4cWCMWUi7EtMgr1nHxuCTBzssCgYLxFvpFyiDdwST0
 VlCtfDLh8icWWZ+j2frfZx34pqHd94O42wRJv1m88+JViAudl0EUdZZDDBSmhdfVh2UI
 4zo3bqv7R+wQWbFCF3NjSejRDwLrsob3d4IBKmOc18+dOiuqZFL4lyJY20MJlpqZF7UR
 WmYC79cVdEQ+RYRaFYNM1GAS1Yk4J2fDyjui05IaHQ/PoQVEh1nveW1fTMMokLQvi+Qj
 FSow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyRw/AnLu56OpyfGWGjzBe90LhJT2lLCcpeoC6Zzc4ooyTl9uEdSoGR7w253BNN+pMhHTxPrl97SqjJ2LheYValMiv
X-Gm-Message-State: AOJu0YyMJGJfH4TUxccVuSyA0IkRkvvVhJJt0TsC/gl44bo8OyKyO1EB
 ZwAyWVNoQuTTpGWrYyNElIAkLCgGjrDy+NA0/+XTLiz/4+/SduQtYxvQnPl0
X-Google-Smtp-Source: AGHT+IFa3IXzwvqD6pSI6SDWjo5KfkJS90K24onB8yBpDru/YkeuzByOedogKPDQsVooidzbqftDIg==
X-Received: by 2002:a17:902:820b:b0:1db:729a:e2a0 with SMTP id
 x11-20020a170902820b00b001db729ae2a0mr8816002pln.47.1708331524874; 
 Mon, 19 Feb 2024 00:32:04 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 28/49] ppc/pnv: Use resettable interface to reset child I2C
 buses
Date: Mon, 19 Feb 2024 18:29:17 +1000
Message-ID: <20240219082938.238302-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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


