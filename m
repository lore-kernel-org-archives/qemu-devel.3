Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71126C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsk-0002po-7X; Wed, 07 Feb 2024 06:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsi-0002pX-Ss
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsh-0003OV-CI
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=BhNYxEYc/qJHRXKgBcvGB4w/SQCUVcrw4uvMgwmx0iktCRhkQY4UrwRRva1DWHKY56dwAp
 a4o0KHPhOe9kjWf4dMog0jYqZTzkd9unDTbibnG5FIomWg+uoi6JCXqp17SoSMhP0bYBCg
 8VkIChWkWmty9fd9COQB+i7gtQujPr4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-8gmOZVFcNC67slQrFb9tCA-1; Wed, 07 Feb 2024 06:14:17 -0500
X-MC-Unique: 8gmOZVFcNC67slQrFb9tCA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a37f4a71019so24844266b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304456; x=1707909256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=c+W7tEJLDGH6E+CbR4Td0fypzUWCVJ+1a+wT8KMdIYPY0FjYqKsdc4/t9ch6QF5UrO
 eNOqWR9t+ikwPZhcqXcJhFUpWompFR4eUkF97zK0xu8cQ/c5hSSjkOaIs0NhTNDMRAFH
 EyXwYotupfJSy1OwmhTboPQER0GXAcCrkFFz+L0pBU70T+Dkfa0aFFpDInSxRBPubJiu
 Vf43R8QYsfDi97UNES6RnYjQMsCTPG81Ve2l78KG7zMgkDLNKnUkIuqnR1idX/nytfmm
 cXqALq2A1Hib1YX7qxa1DLu65/z0oKCrlWr4OoML/fW+yfngXofF244AM/wSd+TeIB+U
 b/Ug==
X-Gm-Message-State: AOJu0YxnMyjK53M0O8Ot75JbexxYeDESBGTlqe0kiIL2pPf1e8llT19V
 7h5aqm0FhW7xvVTYxNiz4cBPnzHaVH6WMAwNbphoksp/+PYx91jZAG9SFoypVWFY737l8Xy3SFW
 WAytzPn1SfBJNPrshGEs7W9DYCK3PxxlsDzhPOLl+KbZ53MsulndU1QmiKmUA4wNvfUCO6BgZmu
 AbfvWSidjJo36N9lxT6zejaQhzMa2UozHcsDky
X-Received: by 2002:a17:906:3295:b0:a38:2739:d849 with SMTP id
 21-20020a170906329500b00a382739d849mr3053866ejw.16.1707304455773; 
 Wed, 07 Feb 2024 03:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzZ6FAe7n4m61ThP0ekV/i0Pn+t+H1YQ8MaInRVCIztpfBvYuf45zyWWewXBXjmo/a3Rn5aw==
X-Received: by 2002:a17:906:3295:b0:a38:2739:d849 with SMTP id
 21-20020a170906329500b00a382739d849mr3053856ejw.16.1707304455342; 
 Wed, 07 Feb 2024 03:14:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVMFNL9tIAkCCXmKiul8xkizkSvCKWkvexRgT7RyQihhCT6iBjLQOdmJdsEgVKj6DIkCAS58J+cSkusQq7VDK36xJnxYSE4bgjAgmMRq00uqH0scCyd8achdxX2huB5GA==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 cf17-20020a170906b2d100b00a38382c34c9sm635358ejb.120.2024.02.07.03.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/8] usb: inline device creation functions
Date: Wed,  7 Feb 2024 12:14:03 +0100
Message-ID: <20240207111411.115040-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


