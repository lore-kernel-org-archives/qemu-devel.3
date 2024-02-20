Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25724C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLBL-0000fa-JO; Tue, 20 Feb 2024 03:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLBB-0000AQ-UH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLBA-0000fx-B0
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=Ui7fKpinFA1nnD9pjqKkNE6e0SWCiKo+J+21PhAbcZN5b2Pv6K8K8djpnx08oKGm+m9qOC
 1eRsZJK2rlbCUjKVPp6Hx02O2gZv9D3xkJsoZsmJy1S2N8rVK3nPU4sE+yJOtOAZV9qlOp
 8qZSh5ZHqlZ6jcuyot17gE6SL4WnDcY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-qXZp9xpcPNGT4petVV1I_A-1; Tue, 20 Feb 2024 03:08:38 -0500
X-MC-Unique: qXZp9xpcPNGT4petVV1I_A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2bffe437b5so424042366b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416516; x=1709021316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Egdkh5QoX3O/dzVIy8K+U7p2KokwdNAc13mHN8rwZY=;
 b=lbtTsIE2zoq9juWy7StzJYr1fLqE3xjH3CDDXgh4/6ShIAfPj9yShNiVyqDhns9jfR
 f7tgMwtshaxtIKXRe637q0IUBynzWC/QbZCk4QTZFzk5SNWEHOzBYR+jJB0xyRLk6KhW
 fmiBobrGNMwPzAQMyK5cvS0l4kaze6fc5RcBgBBMkqxJQJiOST6Id8t7ANBexnrrU1ZM
 00gSlTKz4z8s3CX7k4gJ9feKNApT2ijvcGzKdfN0J7T/5vAWTS5vp+bzktNwzbtLgMhZ
 fs6W7qv6/5rfdl0NevFKHHtxDA1WNsZKYrtg9MT7HgQMu2s6wEircCY+fjcqw7pWsxfb
 TK7g==
X-Gm-Message-State: AOJu0YxlbjqQTcZ4W+TG/wValLT31GcsGHPOovUWfT0ncDWpkPpZToys
 WozGxOXKWWIJwpu93Rggr78/eraIc9i5khSu/M6ZcaBqxLGmAGlTmAIVe3nlz9R3RDeE/EKTpMf
 2CNHuJQN+T2ItsgyKZqZu8XmtLVCNdW4n6ZcWtrvM3qYtXGrd5+zac9Sb6XZBWvOT1ElsQ7rre/
 aOeR/bMAImEZk+5Qb7PGhF0EZjRe16Q4x0mV/F
X-Received: by 2002:a17:906:2491:b0:a3e:48f2:19c2 with SMTP id
 e17-20020a170906249100b00a3e48f219c2mr4533926ejb.76.1708416515814; 
 Tue, 20 Feb 2024 00:08:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHocq4fFF+9LWI+m8y74WnxLbta8MbPcEfG0bfcX2AHxTzQ3nL/uqPgjrH6YkEtbgE4Tfbv3Q==
X-Received: by 2002:a17:906:2491:b0:a3e:48f2:19c2 with SMTP id
 e17-20020a170906249100b00a3e48f219c2mr4533914ejb.76.1708416515414; 
 Tue, 20 Feb 2024 00:08:35 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a1709060d5200b00a3d12d84cffsm3686645ejh.167.2024.02.20.00.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:08:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/17] usb: inline device creation functions
Date: Tue, 20 Feb 2024 09:05:57 +0100
Message-ID: <20240220080558.365903-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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


