Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B988C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUuy-0000rw-Fs; Fri, 23 Feb 2024 07:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUub-0000fZ-QS
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuZ-0003tG-WF
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHJ+bDYLHMfaCuWzDjl8prnLt3zHpetqgQVOwKkrobE=;
 b=iybIt1S0JZ/GRZFaHSU6+e7OKVwJfMWr+lLyZHCgfdAqk0DoaU33nK+hXq9dUa8ra+9zzO
 Z7f9cNyWAniNUAGSQ4QyTxZECH1iAP9BGLad2UZFjh90FE3qjRNIxVCtSy0ytClXtIijwW
 dH41jEC/4NOtH1vF8Us5yt64JiDkzsQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Hz0VthGlMKGMEM1-F1vsVA-1; Fri, 23 Feb 2024 07:44:15 -0500
X-MC-Unique: Hz0VthGlMKGMEM1-F1vsVA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d782af89eso351700f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692254; x=1709297054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHJ+bDYLHMfaCuWzDjl8prnLt3zHpetqgQVOwKkrobE=;
 b=kfM1G1IkOVFcD0ySqE7G3qSDV0zd/OKG+PltJdSIBRwaiWPIYmC0BxIBQtxv2XmBqI
 nPDXX1bRmUohOvBCOD/vglKYPYo+0yHI71fhXNZE02tMeH7edBHN/bn811HC2/HPmyv2
 rmCLRVc22VJ1mGALCn+H70ZyQSFe/xcceUVNJARAgGCRlDuwSs0LILleWYmyhWLxEJie
 WB2ho72TL2KqTOqVvRvprlhT7+rMrcKfM3012M2XpkXvvinkEnn3LqDqPIUW+aQC3DKj
 jbC76RpSDzuq9YN2tbBRo5eMgtcrhxLfwyKXZaWE6jWFDPGqumlcGbpvYvnvPI24JPcz
 Yq4Q==
X-Gm-Message-State: AOJu0Ywc95++p8VurAbYDPu7FAXq1HTRDcSaXlZXV+zj6WfJe2ILoeJX
 0ANm6AStDf/gQ25az2wFRy2SV3nVGRMg6LPVlCmTdCv2ixWZvYPnbmOidJZY3OHHNbjRKdt5sMw
 +8jM5vn4sUFypbTzEClNkQIL820QA2S3gdO4EFU9MyvHXLYRhpZP0tCqrZzzde1goZDzKA0Ft6e
 /6wva4NIr44W7npMzJfrjqfmt1B5HrQxYg8BBk
X-Received: by 2002:a5d:640f:0:b0:33d:3c58:7c56 with SMTP id
 z15-20020a5d640f000000b0033d3c587c56mr1626992wru.54.1708692253954; 
 Fri, 23 Feb 2024 04:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1O0IwO5farjCJOZ8blbXbSJ5gAHpstrrV7o5FT3ao5La8xddeuJ+QC1cbPZ/iXZ932ZpdNQ==
X-Received: by 2002:a5d:640f:0:b0:33d:3c58:7c56 with SMTP id
 z15-20020a5d640f000000b0033d3c587c56mr1626975wru.54.1708692253655; 
 Fri, 23 Feb 2024 04:44:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600016cf00b0033da933b250sm2245600wrf.5.2024.02.23.04.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 02/10] ppc: sam460ex: do not use usb_bus_find()
Date: Fri, 23 Feb 2024 13:43:58 +0100
Message-ID: <20240223124406.234509-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

usb_bus_find() is always used with argument -1; it can be replaced with
a search of the single USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/sam460ex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1e615b8d355..4d5655ab6b4 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -273,6 +273,7 @@ static void sam460ex_init(MachineState *machine)
     DeviceState *uic[4];
     int i;
     PCIBus *pci_bus;
+    USBBus *usb_bus;
     PowerPCCPU *cpu;
     CPUPPCState *env;
     I2CBus *i2c;
@@ -420,8 +421,9 @@ static void sam460ex_init(MachineState *machine)
     sysbus_realize_and_unref(sbdev, &error_fatal);
     sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(uic[2], 30));
-    usb_create_simple(usb_bus_find(-1), "usb-kbd");
-    usb_create_simple(usb_bus_find(-1), "usb-mouse");
+    usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort));
+    usb_create_simple(usb_bus, "usb-kbd");
+    usb_create_simple(usb_bus, "usb-mouse");
 
     /* PCIe buses */
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-- 
2.43.0


