Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E82C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3d-0002en-S7; Tue, 13 Feb 2024 10:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3N-0002RN-Rn
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3D-0005Nm-Iz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=SyPsFRbRhWI4JTumQ8fLa2dyGLrEkOg9/xpJJSSFzJytLlnGJuKo/6XSVsWEC1WMuYet+1
 lGAVMPsN92Vx4rqmPJB0dtZ9vpaMU/s0C1dj/1rGZWLYhheLcrB+CoM2O88ThkCqS1xpls
 9x4OlpJP6puGtc/dgq0VRAKxNRwdw4I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-jP8SABUqMWC85kS63xBIuA-1; Tue, 13 Feb 2024 10:50:25 -0500
X-MC-Unique: jP8SABUqMWC85kS63xBIuA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7817253831cso606723785a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839421; x=1708444221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=feN5tEPIzWMHymSbdbl/KL28bHxeRf0PHLUq4IBsniclzIa0X92bClxPmTGLOEVTMh
 QZghCutNy81u/6kkeSYp2kCli6NVNtaV4w0z79SHeWulZQton8Oc9rzVfPaRU1fOq8kB
 r1swcOmoZ70YuaCmu2fNyv1YzXwGqr3hboKdTaECfdbX4JBlFGsz33Z62R4IB/UVZ7co
 JQtO5UVTLP6ZmZc2hgSm2/R0H/ybdKSrJQuCAEYaL8+ibRulfV/8YQtYvQccLXwHObvq
 fc8e6VSSo12iB9nzoFHC8EAR3veJHGVDFW5GB/L0WDvBR9ZbIF2eDLXSQlp2qeDLNUGF
 Zo0g==
X-Gm-Message-State: AOJu0YwK5C6oqgaG7+C8CAfEwJyTuOxmOEUn3OPNm2Aft/XpCuiJGM8n
 pTBOvS+1EMXabWocZk0wr7h5y2HsJ3Bo7he27AbMYygDRS71l6l0cElz7suO4ZgMI//U/lVZaTR
 G/4ncQCl3VtFwvSB5Dkn2sEu8JMEZFAG2RWfeU1BRDtX+tkwtNLeqU8BKEdDt/lkhtMwSResHme
 kMKW+/n06OmnlXiTKBnL7b9fAQ3fGZp3MjSQlw
X-Received: by 2002:ae9:f718:0:b0:787:1652:b0a3 with SMTP id
 s24-20020ae9f718000000b007871652b0a3mr3615926qkg.5.1707839421640; 
 Tue, 13 Feb 2024 07:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBkOjsNAmx88pwT6h6gGSotrMDsN0sF9nsh+Spo79sqZiHzqwcFQF81BKKBFx7Ayw1P32mXw==
X-Received: by 2002:ae9:f718:0:b0:787:1652:b0a3 with SMTP id
 s24-20020ae9f718000000b007871652b0a3mr3615900qkg.5.1707839421205; 
 Tue, 13 Feb 2024 07:50:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWECz1jLmLP9Gd8hR+1E6UmBQ9b7sucJjTMkYVuA7DLTykMQx1IrYlbwQZBQfXc1I2+eXt2QXL0oB+F7xfnGEqBRBVpd9WXCuPuhR9a5J48Lon9r9ejFWrMArjJRmRtS5wxj5tes1lKgNwYJAU1VHSjNgci
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a05620a004800b0078718e1f581sm829115qkt.68.2024.02.13.07.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, shentey@gmail.com, balaton@eik.bme.hu,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/9] usb: inline device creation functions
Date: Tue, 13 Feb 2024 16:49:56 +0100
Message-ID: <20240213155005.109954-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Allow boards to use the device creation functions even if USB itself
is not available; of course the functions will fail inexorably, but
this can be okay if the calls are conditional on the existence of
some USB host controller device.  This is for example the case for
hw/mips/loongson3_virt.c.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/usb.h | 27 ++++++++++++++++++++++++---
 hw/usb/bus.c     | 23 -----------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 32c23a5ca2a..cfeead28403 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -30,6 +30,7 @@
 #include "qemu/iov.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 /* Constants related to the USB / PCI interaction */
 #define USB_SBRN    0x60 /* Serial Bus Release Number Register */
@@ -500,9 +501,6 @@ void usb_bus_release(USBBus *bus);
 USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(void));
-USBDevice *usb_new(const char *name);
-bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
-USBDevice *usb_create_simple(USBBus *bus, const char *name);
 USBDevice *usbdevice_create(const char *cmdline);
 void usb_register_port(USBBus *bus, USBPort *port, void *opaque, int index,
                        USBPortOps *ops, int speedmask);
@@ -582,4 +580,27 @@ void usb_pcap_init(FILE *fp);
 void usb_pcap_ctrl(USBPacket *p, bool setup);
 void usb_pcap_data(USBPacket *p, bool setup);
 
+static inline USBDevice *usb_new(const char *name)
+{
+    return USB_DEVICE(qdev_new(name));
+}
+
+static inline USBDevice *usb_try_new(const char *name)
+{
+    return USB_DEVICE(qdev_try_new(name));
+}
+
+static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
+}
+
+static inline USBDevice *usb_create_simple(USBBus *bus, const char *name)
+{
+    USBDevice *dev = usb_new(name);
+
+    usb_realize_and_unref(dev, bus, &error_abort);
+    return dev;
+}
+
 #endif
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 59c39945ddd..76fda41b7ec 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -329,29 +329,6 @@ void usb_legacy_register(const char *typename, const char *usbdevice_name,
     }
 }
 
-USBDevice *usb_new(const char *name)
-{
-    return USB_DEVICE(qdev_new(name));
-}
-
-static USBDevice *usb_try_new(const char *name)
-{
-    return USB_DEVICE(qdev_try_new(name));
-}
-
-bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
-{
-    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
-}
-
-USBDevice *usb_create_simple(USBBus *bus, const char *name)
-{
-    USBDevice *dev = usb_new(name);
-
-    usb_realize_and_unref(dev, bus, &error_abort);
-    return dev;
-}
-
 static void usb_fill_port(USBPort *port, void *opaque, int index,
                           USBPortOps *ops, int speedmask)
 {
-- 
2.43.0


