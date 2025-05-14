Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2AEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdy-0006X2-CO; Wed, 14 May 2025 07:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdl-00068v-1a
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAde-0006GF-6V
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqntS9ygfuW9rT3V57VhuvgNLMeBxoz/OQrdDTegsok=;
 b=HZ5rRjco8htx3LftCrytCZdeDm8I5NqwqDqtpN8uCXS3Xa5Q2dkF7zB0qM8+KP7NWLHWgP
 4FJcQzJrDu6eDOFCAKb3uN7fyljAyjn+X+gCSAg/12F/auMc+ZlaxMw+zwr/CWtZodHg0C
 insFaoig32SuYhvzpmVsrDW9dyOrwE8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-gWz4RwLaN8KGBEqI-nhQNg-1; Wed, 14 May 2025 07:51:01 -0400
X-MC-Unique: gWz4RwLaN8KGBEqI-nhQNg-1
X-Mimecast-MFC-AGG-ID: gWz4RwLaN8KGBEqI-nhQNg_1747223460
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so4344465e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223460; x=1747828260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqntS9ygfuW9rT3V57VhuvgNLMeBxoz/OQrdDTegsok=;
 b=AUQuPtgb5wDRan3NuNlVH/owXlAQbhEK9ohBel0noOErrHJObKYQ+mgRulkMjBGNOA
 Dp0of1bv72elB2i2t4FiWhIuyWnSXCl9/toZSkvjIqS9bUpr/tZDXLdCnmQ0jINFeKoF
 7cuSJ8++bfVocC7bUn7hFZ7mcywqlW+jIp27QRV6MKxuQLBRU0pYpgHFDIALnJCVFVOc
 kz42g53ExWIVDXNivZbj68PwOG/y955HFhWN4tOOzEk9Jib9B1SQ765t522UQV0Eg+W2
 JOul/hnQUgK2BZ1eU2ahCNWq076KoHime1bVEQSCfM+vG7Iigr4sK9e3JvPZxt1m1xRL
 cyOQ==
X-Gm-Message-State: AOJu0Ywo9dJ/9c7buS8zVrT7S/dKyw7jMoVBqyR88PrbT5Dvsk792BQp
 RHOOARd5TnJc2RwLxTLTAIvR8iweCdTbUMR3/0xmXM6cf2phzzcx6YNlfkkQnjHJrgFzB9J5F/A
 ds+ug5ZRtnN1Jqfif4TYm9wErh+Mjnn8ms+xIhbQZtiHQtU2ILpAOQkGXaph1/LH/9N17/vSZwj
 JxBU8TrOb4hlbfO83diyZ8BjLt7YssMw==
X-Gm-Gg: ASbGncv3iFVXNmhSWqAGPAc3f4QRAMp7xsheRpdIcgGSjHwBcD7W7TcJoIZ+XHSPxxn
 1Hzr+T4jrizhogkBfTrfQVA6o85MbDS8I4rYulefmGnS0m0F0f5JSSOL7TPjlMsC6jeDHGamRM2
 kSkHzEToOrDRstSi6ZIPu5HOOIm2a5XSlIWw5DMIxcYFDydJkcCgTz7gZQIoZUQTM1UB5TiTE3L
 AoT/jpCP2zk0z81NsKH4EyDWFXywcSd/jKG3KzH7I+50OR5807IYzCIaOn8ZvnTA0qhfmBPVgPo
 vbX1+Q==
X-Received: by 2002:a05:600c:8707:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-442f1a42318mr32982485e9.8.1747223459781; 
 Wed, 14 May 2025 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWNW+7T5B5w1jJh1Am4+Z7rknxs6M44KG2gHRJsm4W5BQVr7XjknJq86LBUvfxfuHaukNvlQ==
X-Received: by 2002:a05:600c:8707:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-442f1a42318mr32982195e9.8.1747223459358; 
 Wed, 14 May 2025 04:50:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e8578sm27775085e9.29.2025.05.14.04.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:58 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Bates <sbates@raithlin.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/27] pci-testdev.c: Add membar-backed option for backing
 membar
Message-ID: <8717987fb528ff704e275a1a99f59a20e0b272f5.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stephen Bates <sbates@raithlin.com>

The pci-testdev device allows for an optional BAR. We have
historically used this without backing to test that systems and OSes
can accomodate large PCI BARs. However to help test p2pdma operations
it is helpful to add an option to back this BAR with host memory.

We add a membar-backed boolean parameter and when set to true or on we
do a host RAM backing. The default is false which ensures backward
compatability.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Message-Id: <Z_6JhDtn5PlaDgB_@MKMSTEBATES01.amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/misc/pci-testdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 3f6a8bba84..ba71c5069f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -90,6 +90,7 @@ struct PCITestDevState {
     int current;
 
     uint64_t membar_size;
+    bool membar_backed;
     MemoryRegion membar;
 };
 
@@ -258,8 +259,14 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
 
     if (d->membar_size) {
-        memory_region_init(&d->membar, OBJECT(d), "pci-testdev-membar",
-                           d->membar_size);
+        if (d->membar_backed)
+            memory_region_init_ram(&d->membar, OBJECT(d),
+                                   "pci-testdev-membar-backed",
+                                   d->membar_size, NULL);
+        else
+            memory_region_init(&d->membar, OBJECT(d),
+                               "pci-testdev-membar",
+                               d->membar_size);
         pci_register_bar(pci_dev, 2,
                          PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_PREFETCH |
@@ -321,6 +328,7 @@ static void qdev_pci_testdev_reset(DeviceState *dev)
 
 static const Property pci_testdev_properties[] = {
     DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
+    DEFINE_PROP_BOOL("membar-backed", PCITestDevState, membar_backed, false),
 };
 
 static void pci_testdev_class_init(ObjectClass *klass, const void *data)
-- 
MST


