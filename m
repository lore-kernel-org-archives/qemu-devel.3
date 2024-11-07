Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7738BD29FBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFR-0005vr-JI; Wed, 06 Nov 2024 20:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rF9-0005cJ-GC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:30 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rF6-0003A5-LJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso3825645e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942603; x=1731547403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZjaBp3yXkmB+ya4bJ3r80NYEVkQDTq+01qC5eD9SP8=;
 b=bfB93lzQ1Vj2lUZ3BQRBXcHVSkCQOSLic+UrCGNtQVgzKnJXxZYlVnH0AHOhiCRbjW
 Ba0OOiFXwM63UlbOR/9AHxIVuPiFdtn23w9MrU1zbo8hRqx1wbag0C90B4cu7Y44m6pm
 f1x22nMAtjgjrZx/7Xapmo9+d4OQ/xPe8uk/0ekhneItwL0VS4FcMSL/nK0ay9CxF2LE
 WnZF6Wj6sebDRtooaJb3UV8Rss9D+H4inGYtB+pZexUKXj+PmMpGkTOo/lVdtlEANBrR
 aY7uQf7zquLdmkLnjnJ2fNqWWkDTyUL5+sLOBx9X4EhwD9KGcw/6RRFq2XwjjES5hdEd
 19NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942603; x=1731547403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZjaBp3yXkmB+ya4bJ3r80NYEVkQDTq+01qC5eD9SP8=;
 b=Ylt7Z3xGi/+A/MvObzZMyavB0XpTlrr6p/7zGAk5Rt086priEBaId8WeLUbXCghUGs
 jiZgKI6i1WO5+vZpV1hJ/xiUSSVYaxW45TlgvLCs6Gg9Nb1i4lkJrPlo3NCnsUYqE6nn
 wTtGLwc5K+C2X70QRjIrSRTssmsFfHl2qYZo+XTMYB5xC5bimEoHOChRPs0VZ3QztFdH
 mfr6O6bXw5akMpYndoNUXRPvs1SRJvMzVX8yQ7fzTVXZsIP4lRJa+tosU9VNMDuTm3hH
 TmWZ+DhG9ULmpCT27jb/mhvhwUPt4Q22mxiH/R9YQ5KtNNzzX3APRcfHQfMKlZFpWalC
 Z+rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGGSDVVfcBpJAuSe2PBUPcpJWsOyeeMJkBR9/A6i+7pUdbSVK8wwisullYpvQCAxFdrBbXcTZadsUe@nongnu.org
X-Gm-Message-State: AOJu0Yx7lZA0IzUxyXC1P2CDdJXGGYa5u+vJdYnK81g1n0g9+zU835Dq
 Lh2iKNy4Mh50APDm3AOyiDe1DqujNyJOcZ+2nagMuvc8kH4bJi71BpzI0bVznvw+9moPuBc1L37
 1
X-Google-Smtp-Source: AGHT+IHEp59KFZTWjKh+P1Df4prkSP6BOcROTqgwEWM7MpZ82T1gyvH4LC5FIYQUxzb6zCHh4BFo4g==
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr174560515e9.23.1730942603239; 
 Wed, 06 Nov 2024 17:23:23 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea4ebsm238167f8f.69.2024.11.06.17.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/16] hw/ssi/xilinx_spips: Make device endianness
 configurable
Date: Thu,  7 Nov 2024 01:22:15 +0000
Message-ID: <20241107012223.94337-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ssi/xilinx_spips.h |  1 +
 hw/arm/xilinx_zynq.c          |  1 +
 hw/ssi/xilinx_spips.c         | 46 ++++++++++++++++++++++++++---------
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 7a754bf67a..451c3758b3 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -101,6 +101,7 @@ typedef struct XilinxQSPIPS XilinxQSPIPS;
 struct XlnxZynqMPQSPIPS {
     XilinxQSPIPS parent_obj;
 
+    bool little_endian_model;
     StreamSink *dma;
     int gqspi_irqline;
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7..bcc0022c17 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -142,6 +142,7 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
 
     dev = qdev_new(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    qdev_prop_set_bit(dev, "little-endian", true);
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index aeb462c3ce..5c6f0dd079 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1251,17 +1251,32 @@ static MemTxResult lqspi_write(void *opaque, hwaddr offset, uint64_t value,
     return MEMTX_ERROR;
 }
 
-static const MemoryRegionOps lqspi_ops = {
-    .read_with_attrs = lqspi_read,
-    .write_with_attrs = lqspi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps lqspi_ops[2] = {
+    {
+        .read_with_attrs = lqspi_read,
+        .write_with_attrs = lqspi_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4
+        },
     },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
+    {
+        .read_with_attrs = lqspi_read,
+        .write_with_attrs = lqspi_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
     }
 };
 
@@ -1325,8 +1340,9 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
     s->num_txrx_bytes = 4;
 
     xilinx_spips_realize(dev, errp);
-    memory_region_init_io(&s->mmlqspi, OBJECT(s), &lqspi_ops, s, "lqspi",
-                          (1 << LQSPI_ADDRESS_BITS) * 2);
+    memory_region_init_io(&s->mmlqspi, OBJECT(s),
+                          &lqspi_ops[s->little_endian_model],
+                          s, "lqspi", (1 << LQSPI_ADDRESS_BITS) * 2);
     sysbus_init_mmio(sbd, &s->mmlqspi);
 
     q->lqspi_cached_addr = ~0ULL;
@@ -1432,12 +1448,18 @@ static Property xilinx_spips_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property xilinx_qspips_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxQSPIPS, little_endian_model, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
 
     dc->realize = xilinx_qspips_realize;
+    device_class_set_props(dc, xilinx_qspips_properties);
     xsc->reg_ops = &qspips_ops;
     xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
-- 
2.45.2


