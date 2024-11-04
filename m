Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F08D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Hc-0005Mi-M0; Mon, 04 Nov 2024 16:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hb-0005I9-16
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HZ-0005Ke-IX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7gOmOTj6yO90oCWalWO1gQgHW7kTyMfpeF2Gcy7IQw=;
 b=Rke2f4etY+DCtydR3m+pUuSEZoUZGqkm2x5Ptweom9U5qZNtjKx9NJXZWA8ln+usHW2hAA
 ug3Jm/f/UYIqKY07boi2xc1jQ6QWF3Qd0oRjSE9QgBebM9WrvC1KxeKldpQ02YotgtSFo3
 iklMUwrPc+oTFcMhGky9hTopIwdIlNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-GYkDlQnGMqan9z4OiTD8ew-1; Mon, 04 Nov 2024 16:06:39 -0500
X-MC-Unique: GYkDlQnGMqan9z4OiTD8ew-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso32320715e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754397; x=1731359197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7gOmOTj6yO90oCWalWO1gQgHW7kTyMfpeF2Gcy7IQw=;
 b=c6IKtUiqbf8FniyEiiwzcgqtn04MiqBq3en4os4nFTcdOt61ZDBzA7MJfMZ0wzVaVp
 zOXBnf5Sd1C11tc3ctXT1aBXZw6mdkemC42J9PNXrQx/m3TNpYlmqWfTCkitgO0MhK5/
 /etLnmZXjVl35RgNjV1pwvq9RJR1yMFfK2LxRFRyaBgkYLkYhhMdyhPN8r/SmnemMg5u
 Y+cCU7po0M+i17otS65kfN6K9csLej5J+EE7CTv8zS/jMI3JeZBgShBh6p7azx1kZqLp
 8xUI3P4/TnMQUa9PX3VuekE48kyRPfq/EHE6dlelziu36WidO3C29fmm2DgeYHR5LrS+
 4pTw==
X-Gm-Message-State: AOJu0YytHnfyMRtPcWiymCvsXqHWiQ/B/qjAy4ZloaUGQkdtM9/eexY1
 U3r4jdYoioIX/WDLDi8cVO2ZMTXI+TIdMihhFNplmm751vfUQ74F8Md/CmKDfnf/UYOYZuxBp/6
 vJVfo/8PrmOnnQ3Ps9onuFxfYk7UAJ2UkE+9CVHpzcE+4VZJbsINCH9H5w8a0Qrdf5iu8a4/KWB
 hq7feKAXxIFyo8p6gnGuZxhLvQWG4gZA==
X-Received: by 2002:a05:600c:1c82:b0:430:699b:7d22 with SMTP id
 5b1f17b1804b1-4319ad14d14mr329164595e9.26.1730754397154; 
 Mon, 04 Nov 2024 13:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPzVRbgvpgcmjZt86LBj4b3pyi5Z95SzLBgi9uVzeT7fwEQ4CfG9C/Ar2N89he1amMfgVC5g==
X-Received: by 2002:a05:600c:1c82:b0:430:699b:7d22 with SMTP id
 5b1f17b1804b1-4319ad14d14mr329164375e9.26.1730754396753; 
 Mon, 04 Nov 2024 13:06:36 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852efsm164336455e9.30.2024.11.04.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:36 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/65] hw/pci-bridge/cxl_upstream: Provide x-speed and x-width
 properties.
Message-ID: <845f94de78cb6c063234176ff7c0ac8e430d19fe.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Copied from gen_pcie_root_port.c
Drop the previous code that ensured a valid value in s->width, s->speed
as now a default is provided so this will always be set.

Note this changes the default settings but it is unlikely to have a negative
effect on software as will only affect ports with now downstream device.
All other ports will use the settings from that device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 4b42984360..c347ac06f3 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,8 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
@@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static void cxl_dsp_instance_post_init(Object *obj)
-{
-    PCIESlot *s = PCIE_SLOT(obj);
-
-    if (!s->speed) {
-        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
-    }
-
-    if (!s->width) {
-        s->width = QEMU_PCI_EXP_LNK_X1;
-    }
-}
+static Property cxl_dsp_props[] = {
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_END_OF_LIST()
+};
 
 static void cxl_dsp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, cxl_dsp_props);
     k->config_write = cxl_dsp_config_write;
     k->realize = cxl_dsp_realize;
     k->exit = cxl_dsp_exitfn;
@@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
     .name = TYPE_CXL_DSP,
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
-    .instance_post_init = cxl_dsp_instance_post_init,
     .class_init = cxl_dsp_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
-- 
MST


