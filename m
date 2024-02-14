Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862DEC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEH-0003l3-UU; Wed, 14 Feb 2024 06:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEF-0003jo-Uy
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEE-0006zL-5q
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yp293q1k7EwGS1/MtUhndzXz8BO3g1U19jHZpbrZKu0=;
 b=KQ0OTjqwCPaHTkBkAOIps/mxBQdlmCBoXQKQeXtZnVrMP3FrRHUckDMySYVo7QA5+l+KVL
 mSoqb1usmFuMJGpzaYIbfBcbbltoosyn1NuqjlvJhmlfSbX3TxZjK91GNGHohhSMWZ+zm3
 lOQQQWu2VVHYQNV6+9mfSYxunakgLLo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-l-cR1vU4PrCnCmRDyjNDDw-1; Wed, 14 Feb 2024 06:15:00 -0500
X-MC-Unique: l-cR1vU4PrCnCmRDyjNDDw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3ccb68f284so149575566b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909298; x=1708514098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp293q1k7EwGS1/MtUhndzXz8BO3g1U19jHZpbrZKu0=;
 b=blOe3gNkEaCQraUkWY47kGujgkADCObC9UxftSLljdbLs2JiiKLbTgN11SVeFGczLV
 X8pIBAQKd1P3TpN9jgAXn7c/4RhfBwqfgoETwJj/w8ejRX/WX/jRcequswTW6KfkwNDZ
 exfXI6gFI+ReZ6hXaduchpV0tdSwUsRBaKr19sVTVuopU1h6WHCqkrdon7Ufscd0xfyV
 XCZfz5lJub3P16WMdNzGCiaFgFkxVlInAJ6ViX5+9xw92iU9VlcBBUyJUortZyzqoUfP
 ZNkrG4FIZpiMfWIPNLhNw8/+SQVqxXBUjzGHnNXN4o/9il32aT7DablAdGNR2WI/Wai9
 zv7A==
X-Gm-Message-State: AOJu0Yz6/wp4vow2Tqv10fnZeCs8TVjhmcN9lhDN6EzY8xc19SoILfSl
 5TBIZESSTJOk/eMNFPt1EDr5SC3qLo1dE7HF0eHCWtyAnASnxTbgI2pWK8JLsPQ4OZF3lG8OJkW
 HIcbmRVAShDhPyW7ZLTALgKTMTR2O1W+99t0Luano0y2ZZDnjrp9xUk1DGXUoNtzj5Co49TYQyK
 1KYoy2ZfIsueEzwchsLjEvwP6J5w6OeQ==
X-Received: by 2002:a17:906:aad6:b0:a3c:a655:3a3c with SMTP id
 kt22-20020a170906aad600b00a3ca6553a3cmr1383214ejb.16.1707909298465; 
 Wed, 14 Feb 2024 03:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ1nWWXcLhhi9eMYz/sfekc+bCed9WsdeAryIGsfCIiw9HVRh5P7YXnnh6vXbGlwYxB2rBXg==
X-Received: by 2002:a17:906:aad6:b0:a3c:a655:3a3c with SMTP id
 kt22-20020a170906aad600b00a3ca6553a3cmr1383191ejb.16.1707909298096; 
 Wed, 14 Feb 2024 03:14:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW+P8qx6GekVbYdyaGPBPviA4m64AxuHE/c6dMCIOfU6ngZvzYuKpy425ABYNVzwYepgCcTjPVawSxYQ5pEv4Q0fMptOqLxuDzELyDEPI6qo1+MsUQUquHSFiWd4fUVsTYzGaAkbQIpwKRakrap7apu37YUmnxaXXiyUKeJiJ4ia4I=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vg9-20020a170907d30900b00a3cf4e8fdf5sm1756740ejc.150.2024.02.14.03.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:57 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 32/60] hw/isa/vt82c686: Implement relocation and toggling of
 SuperI/O functions
Message-ID: <35a6380b4ed27f8355330b1fb0918b20c728d30e.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

The VIA south bridges are able to relocate and toggle (enable or disable) their
SuperI/O functions. So far this is hardcoded such that all functions are always
enabled and are located at fixed addresses.

Some PC BIOSes seem to probe for I/O occupancy before activating such a function
and issue an error in case of a conflict. Since the functions are currently
enabled on reset, conflicts are always detected. Prevent that by implementing
relocation and toggling of the SuperI/O functions.

Note that all SuperI/O functions are now deactivated upon reset (except for
VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
enabled by default). Rely on firmware to configure the functions accordingly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240114123911.4877-12-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/vt82c686.c | 65 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index d3e0f6d01f..485bb685b7 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -15,6 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/vt82c686.h"
+#include "hw/block/fdc.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/char/serial.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
@@ -323,6 +326,17 @@ static uint64_t via_superio_cfg_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
+static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
+{
+    ISASuperIOClass *ic = ISA_SUPERIO_GET_CLASS(s);
+
+    isa_parallel_set_enabled(s->superio.parallel[0], (data & 0x3) != 3);
+    for (int i = 0; i < ic->serial.count; i++) {
+        isa_serial_set_enabled(s->superio.serial[i], data & BIT(i + 2));
+    }
+    isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));
+}
+
 static void via_superio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -368,7 +382,25 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd ... 0xff:
         /* ignore write to read only registers */
         return;
-    /* case 0xe6 ... 0xe8: Should set base port of parallel and serial */
+    case 0xe2:
+        data &= 0x1f;
+        via_superio_devices_enable(sc, data);
+        break;
+    case 0xe3:
+        data &= 0xfc;
+        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
+        break;
+    case 0xe6:
+        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
+        break;
+    case 0xe7:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
+        break;
+    case 0xe8:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[1], data << 2);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -395,9 +427,14 @@ static void vt82c686b_superio_reset(DeviceState *dev)
     /* Device ID */
     vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
     vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
-    /* Function select - all disabled */
+    /*
+     * Function select - only serial enabled
+     * Fuloong 2e's rescue-yl prints to the serial console w/o enabling it. This
+     * suggests that the serial ports are enabled by default, so override the
+     * datasheet.
+     */
     vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
+    vt82c686b_superio_cfg_write(s, 1, 0x0f, 1);
     /* Floppy ctrl base addr 0x3f0-7 */
     vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
     vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
@@ -465,6 +502,21 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd:
         /* ignore write to read only registers */
         return;
+    case 0xf2:
+        data &= 0x17;
+        via_superio_devices_enable(sc, data);
+        break;
+    case 0xf4:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
+        break;
+    case 0xf6:
+        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
+        break;
+    case 0xf7:
+        data &= 0xfc;
+        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -513,12 +565,6 @@ static void vt8231_superio_init(Object *obj)
     VIA_SUPERIO(obj)->io_ops = &vt8231_superio_cfg_ops;
 }
 
-static uint16_t vt8231_superio_serial_iobase(ISASuperIODevice *sio,
-                                             uint8_t index)
-{
-        return 0x2f8; /* FIXME: This should be settable via registers f2-f4 */
-}
-
 static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -526,7 +572,6 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vt8231_superio_reset;
     sc->serial.count = 1;
-    sc->serial.get_iobase = vt8231_superio_serial_iobase;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
-- 
MST


