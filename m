Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE76C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuA-0003yH-Pu; Fri, 23 Feb 2024 10:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjJ-0005tG-VR; Fri, 23 Feb 2024 10:44:53 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjI-0006OO-4z; Fri, 23 Feb 2024 10:44:53 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc7abc692eso182305ad.2; 
 Fri, 23 Feb 2024 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703090; x=1709307890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwPtUyKyEVd6AyaLlqPC6tZGZHAetOay6q3kchulGSU=;
 b=Fi3jFPngklzXt/sylbVCrLIfdDXn8ChifHYv+jqvaSwDQqxGq4tmAtF2Z2Z86Zw914
 jRobPqcC2i+FBBIJ7UJRrJb9q1+M07B6i5z1+EFji0C+Gjya+yFaQ1D8POREQkh70L+f
 94U8nstau2Yh7/6g6JqyuddBOrcgbQJ0/Dqd+tMyaqENjVWGSxH779bq2oDhNaD6JNyy
 /lpD1CmBKnTi/i3UGb5dgQxPmKgB32SstC/88xdOSYTnTUpH2kMvtOPmwpq1DD6ISE60
 8/WUygwkiSurfWjD6cSKxEKCtl8MR//0capnrfpdlql4zDTn7yPrEzDJZUe0y4XktDDV
 gFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703090; x=1709307890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwPtUyKyEVd6AyaLlqPC6tZGZHAetOay6q3kchulGSU=;
 b=azOzkXArNFhGrFrSd3bD860cxn6t2V2SqZiNVZH7YMOA49Cn/lYfnxMqOwCYCvPiNv
 KAP/Vb77YRNAHecymcxBXYNt4T3LWsVbMdPE9+4XoD3SbfyeWblpI5DcDUIHLszo+3ST
 jd8AJPeVv7AZChe4dGSMaTBLAAUm7cgjqSJzV6gvVIrYplrO5p8FCO2GG4XxS8WoOO/i
 eICnSRNtLfYeSFj6+y2KIu9dfCrsMbqaUj1KhVR9s0ZSB9pxLYSDIwFtxL3rG+TV/NsP
 tunh9SdSyV/lntodAS3vDtcfoKGIAqKYs2K2V9y6rM4DRgcXEgrj7V735uJB3MhGiFaw
 BZtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkn1B6LUWSTCpJ/maf6RzNl1uE/H6DNPOvDlLX7sMQMPYFe7QvVLUJ+VoDGiHWUJje3On3w/AQha6hd6XBjqUu5RYT
X-Gm-Message-State: AOJu0Yzi2OP09w7IvOgFD/8YaP7bkpsue+Kkb24ZTxbZZfWC/AgqJ9RB
 fvNZ0kfk7GyTYrlDAE/RsDNoosFmeA+Pi7Oh/eL1dhw7ECVd2HyZJqIoHNO0
X-Google-Smtp-Source: AGHT+IFxEdy3U7F1c2BKq9ONa0jbKwdPlQsHEgMM0JPzkl099V9DzJsKdEHX+tjH43v0LCYPJeoX1w==
X-Received: by 2002:a17:902:db10:b0:1db:ca53:41d with SMTP id
 m16-20020a170902db1000b001dbca53041dmr179794plx.31.1708703090088; 
 Fri, 23 Feb 2024 07:44:50 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 25/47] ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug
 power control
Date: Sat, 24 Feb 2024 01:41:44 +1000
Message-ID: <20240223154211.1001692-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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


