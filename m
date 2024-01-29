Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3173C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURqb-0002pV-5R; Mon, 29 Jan 2024 08:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpy-0002SE-KJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURpt-0000lz-In
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Nw+XG2iLy3sRXrIY0iWr13edbR83tRmpX3QxJPQulo=;
 b=IBfu5hVeSHgLypz+z+NxFo2lqhUs3+Hag4mziL+yKM2AlYH+TRIfXaU9bCqjswZgzcfEhJ
 bXqWma75r4KtsM1BAB1KADHyx8iLnTXfyX2GefvnLzmxTw95bfsa3AQHri+fdUKyULgnM5
 ihiMR9R5d054Vh0Fu5u2JtRSUqBhM/U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-5JePgY_KPnaQL9WlSFhDUA-1; Mon, 29 Jan 2024 08:38:01 -0500
X-MC-Unique: 5JePgY_KPnaQL9WlSFhDUA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2f1d0c3389so134430466b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535480; x=1707140280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Nw+XG2iLy3sRXrIY0iWr13edbR83tRmpX3QxJPQulo=;
 b=Db+0/S5BhnAYCp8xZ/AgWrNV0izk41qpgfPcN7AJpngcMixVjNuXNGe/0PziiBUxII
 loY++hMnbMlI+sq+5UH78VwHim6f+U13wbOgp9VXrh4BRnSO1Qt7buyqDYSqmwRK9CUH
 y0TmOOOpAEWL7YwS8fAQkLoS26Qkz2dXxp7HNak2A3rktponjSsWKDmPEV4bHdZGYjHQ
 HJWJ4HkaOT/2RhTxQFvk7yBi+lyBYTxLk32PHgRHzxZuVj9DDH8tC+uxTnF2FiRvnEXD
 w8TT23vPDYiZycmwi4QR0GJj9tioQnMZojZxO7Zgpssda1V/cZdQfF2nWumfzdlyaitx
 brOA==
X-Gm-Message-State: AOJu0YwD+lrkQjLwU2y+EYY7faa3RctN7M1C2ljm0b8GpVtW8Rs9apHH
 V0GrrGOEpjY1bLbWtsGG99bfzhbKWBwXkVneoIoYB81j6e4GAq2lOUjljvTDMh9WgUKf2hUJmo7
 P+TOOkYd64xGKyTii9NlshIPzKLfl4xzCXXQTR+rwV/wZ419csecO8vz9qJP1V8HxAgWxNVsSnw
 +Bah4JmVhvTUCiKNypjcXmKEDzULRtxtby/dyQ
X-Received: by 2002:a17:906:c446:b0:a35:e5f4:fef7 with SMTP id
 ck6-20020a170906c44600b00a35e5f4fef7mr986641ejb.68.1706535479859; 
 Mon, 29 Jan 2024 05:37:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7/Mn6u7wsNFynCBR3kv5IpeR1pKoAmfnpphDkV1IKm0RL0FswrO1ct5jpEilXPSj8FAn0Ww==
X-Received: by 2002:a17:906:c446:b0:a35:e5f4:fef7 with SMTP id
 ck6-20020a170906c44600b00a35e5f4fef7mr986632ejb.68.1706535479596; 
 Mon, 29 Jan 2024 05:37:59 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 hu22-20020a170907a09600b00a31641972c4sm3924139ejc.21.2024.01.29.05.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:37:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 3/4] usb: inline device creation functions
Date: Mon, 29 Jan 2024 14:37:47 +0100
Message-ID: <20240129133751.1106716-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129133751.1106716-1-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/usb.h | 26 +++++++++++++++++++++++---
 hw/usb/bus.c     | 23 -----------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 32c23a5ca2a..bd76c514d17 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -500,9 +500,6 @@ void usb_bus_release(USBBus *bus);
 USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(void));
-USBDevice *usb_new(const char *name);
-bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
-USBDevice *usb_create_simple(USBBus *bus, const char *name);
 USBDevice *usbdevice_create(const char *cmdline);
 void usb_register_port(USBBus *bus, USBPort *port, void *opaque, int index,
                        USBPortOps *ops, int speedmask);
@@ -582,4 +579,27 @@ void usb_pcap_init(FILE *fp);
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


