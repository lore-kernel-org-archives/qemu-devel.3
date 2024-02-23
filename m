Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18FBC54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUwu-0005fm-I4; Fri, 23 Feb 2024 07:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuu-0000r0-PE
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuq-0003uo-4G
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xocwLyBkw11u09+Yx+wnt0tbL1R8DbbnKCk16lnu+c=;
 b=aAg+iBZTmFYvbiKYaWsBIChYObE9nMQkc6VRuTbGdXB6VCUCz+ENh0D7jo0A38TjvkhoMU
 ILO7e78KQyuk3nH00yo/ZKzDoFU2LUi3OjKF2OUyZy76rxJ+ASiVQw8eca6eOgeqI6DqVG
 6dr+H+PrhqbUvvnn6cjUgnpskz2hp4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-amNMiNwcNlm_sFHti_nxyQ-1; Fri, 23 Feb 2024 07:44:34 -0500
X-MC-Unique: amNMiNwcNlm_sFHti_nxyQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d11878726so151226f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692272; x=1709297072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xocwLyBkw11u09+Yx+wnt0tbL1R8DbbnKCk16lnu+c=;
 b=JY4H63chSuN0tVZ/GjNiMuZvuF+bxb6lvAAmxRLqPum9nBer1YyihacFRl7yJynvKy
 A7UKSKQ1WrxA8CAoRTfBk2dRXBSnlObNLyemo6ilONzQYTLoavbFJQg4vUsuZkwWU48z
 +4kZzhrbN8VUGRXdHpguqq3PkptKJb6u+ahQJ02JtJlZHOanA2ihgT21McuFQBUOz+hs
 kockgYtmYTGuWuK/B7GqoHpGmeVsb50dVgteJWzF159Az2jPZcaolTv5k/nmShQ+NpT5
 NdAgNi1Q9JJZAOdb2UGQ7BztrfwiyVa7nISMktc8Topw+Q9LRCKmdYqS4jpbHcFpLm57
 fYbg==
X-Gm-Message-State: AOJu0Yzsov6CaJW/Vq501F1XBUEFvS/K4P8BHbuKh646zE5EEDD5NvIQ
 cl3kNk95PP2bLnVmETBYN6kUg1XHCccWXeGL8WLdwUJUDCooSWxxAi8NcD8ZW0GNDkHHSh18OBr
 2C1LTody6+TZmDFyVM4Xh0SyOZ2uuG1x3aUmBbnjwnC8lVhleSCoyeBuylZe5ZcUUMMZcrjZpCr
 7yhT+IPJQzsRTD4+5m/DDSOq9D42cORoD3seRk
X-Received: by 2002:adf:f511:0:b0:33d:6bd3:9e28 with SMTP id
 q17-20020adff511000000b0033d6bd39e28mr1208229wro.70.1708692272303; 
 Fri, 23 Feb 2024 04:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy1FDbIczoEV6HKRUyBgvdGYK3IcfHpgqyvOFFYwCFyYgBakQel3X9zAOz5YEEPxJ3bHXgLA==
X-Received: by 2002:adf:f511:0:b0:33d:6bd3:9e28 with SMTP id
 q17-20020adff511000000b0033d6bd39e28mr1208218wro.70.1708692271998; 
 Fri, 23 Feb 2024 04:44:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z11-20020adfe54b000000b0033da18b05f2sm2676512wrm.32.2024.02.23.04.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 08/10] usb: remove usb_bus_find
Date: Fri, 23 Feb 2024 13:44:04 +0100
Message-ID: <20240223124406.234509-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Inline the sole remaining use, which is for the -usbdevice command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/usb.h |  1 -
 hw/usb/bus.c     | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index cfeead28403..d46d96779ad 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -498,7 +498,6 @@ struct USBBusOps {
 void usb_bus_new(USBBus *bus, size_t bus_size,
                  USBBusOps *ops, DeviceState *host);
 void usb_bus_release(USBBus *bus);
-USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(void));
 USBDevice *usbdevice_create(const char *cmdline);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 76fda41b7ec..796769fadb4 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -100,19 +100,6 @@ void usb_bus_release(USBBus *bus)
     QTAILQ_REMOVE(&busses, bus, next);
 }
 
-USBBus *usb_bus_find(int busnr)
-{
-    USBBus *bus;
-
-    if (-1 == busnr)
-        return QTAILQ_FIRST(&busses);
-    QTAILQ_FOREACH(bus, &busses, next) {
-        if (bus->busnr == busnr)
-            return bus;
-    }
-    return NULL;
-}
-
 static void usb_device_realize(USBDevice *dev, Error **errp)
 {
     USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
@@ -643,7 +630,7 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
 /* handle legacy -usbdevice cmd line option */
 USBDevice *usbdevice_create(const char *driver)
 {
-    USBBus *bus = usb_bus_find(-1 /* any */);
+    USBBus *bus = QTAILQ_FIRST(&busses);
     LegacyUSBFactory *f = NULL;
     Error *err = NULL;
     GSList *i;
-- 
2.43.0


