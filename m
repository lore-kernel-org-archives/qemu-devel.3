Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF69C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3k-0004cs-G5; Fri, 21 Feb 2025 07:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3e-0004bp-7h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3b-000727-Bk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0XVE7dDqExIfNSqEU8DxvlpmcQMz4iRneIR4IAtIjk=;
 b=YRtMdUQRLHyfhUmGHmzfnw0X8PZYmHlsp/N2z/fvBd6MWcKQcKQhMY37GZZMW8wq/6M9DF
 cOJC5QsCJhN8juyLw4lnPz3YzNNaeb4YeOb2okG+SDEJr7AwAK2pZaidM72AVFsFNhxqLz
 2hjeRsm/qgLG23dsu4oo65xiLrghP/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-40TqBTOUN1ORNuqiZkb8JA-1; Fri, 21 Feb 2025 07:23:00 -0500
X-MC-Unique: 40TqBTOUN1ORNuqiZkb8JA-1
X-Mimecast-MFC-AGG-ID: 40TqBTOUN1ORNuqiZkb8JA_1740140579
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso10953635e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140578; x=1740745378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0XVE7dDqExIfNSqEU8DxvlpmcQMz4iRneIR4IAtIjk=;
 b=XyuqLAgmJQQOJ1UBbPDj+lUDOyjW+NjLFObGCAf1JD4NW7VpsPztMtk0ESbptfNlD3
 iTl1QI3cJNR15en9wOtnhLMGPQDpUUA5SIs/L3CN9OPrLEAR86BckkeWUHksP5UjTcRS
 32sm6Jgk1ZfFAzaXISGiqhtuVvIzEdLPPSmGb85cgwekuMY3w9ELMif71qbVnf9wBxQk
 Qba6KOJLHQkP1xMKVlUSPNJN0lUHZfL+wmwHJOBbQJijXH+AaPzWKzujY7jgHhYMG2Yn
 qgdWG6IoXv7vO83e2+sX9f0RR8KRXROFZdtLmdOQaJCfW0ndnPU6zqWK6ISC8stk8nY8
 5ovQ==
X-Gm-Message-State: AOJu0YzYRRzUmoVXnEZWFQgJGv+2qpNxeCgh/Ncg7ZJxmNbtypCQ8hW0
 wRIKCbv4pw7Y3A/YZlch+OiUJweAGnnWIGu8XQbyXLuGY4d9yHzRpPXdroIV6t+gLGPiA2c4wyb
 H6SDKwSqdE9A7PyFe8FtdDHQq24D7XZW8QDlbnBJ7gaHDK4bXU2gFrSfVd1sqg5FsWqPRnpXRae
 T1d/+wi8L6zJGsFCi5wDNhUUdq1uYeTA==
X-Gm-Gg: ASbGncv2Xvd0SUCr34BiFMeLj5K49rsIz6azWBtEn4bMhaG3mAfwOzOG3Lr+K6Q+QMa
 zN/dufX0tCHUyFJKsfyBS3vdE6IEyOiX3g3OgSTfBgCfzuqp0jm/VvdC4L3pjoGphJTkLIJmFTw
 BqM0GhxgzzzyNF71xTptlusxLzDLGMg2i+2+KCfr3bqTMgbdGk/MJD1t0Wzbhwsg+VGBmpQuTW5
 z5yg2x8lqnDmPeU2kDeo3bCqXyWiKOsaq0P5p1UpxzTR7mvu81TeusMOpfZI3AtkUiJ+ZFCZeD8
 +PszEw==
X-Received: by 2002:a05:600c:19c7:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-439ae1d7c76mr21777695e9.1.1740140578286; 
 Fri, 21 Feb 2025 04:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHILvs6eZM2erNuLxpktrsk0IO0exqVd6D3UQox2wttJkm2Rk9KctrHPoxbRZadUuT96La0Q==
X-Received: by 2002:a05:600c:19c7:b0:439:a1c7:7b27 with SMTP id
 5b1f17b1804b1-439ae1d7c76mr21777385e9.1.1740140577838; 
 Fri, 21 Feb 2025 04:22:57 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4344sm23576279f8f.13.2025.02.21.04.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:57 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL 07/41] s390x/pci: Check for multifunction after device
 realization
Message-ID: <2c968f465392316d09e44f4a9f7e378999e5c011.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The SR-IOV PFs set the multifunction bit during device realization so
check them after that. There is no functional change because we
explicitly ignore the multifunction bit for SR-IOV devices.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-5-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c396d55c72..913d72cc74 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -971,21 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     "this device");
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pdev = PCI_DEVICE(dev);
-
-        /*
-         * Multifunction is not supported due to the lack of CLP. However,
-         * do not check for multifunction capability for SR-IOV devices because
-         * SR-IOV devices automatically add the multifunction capability whether
-         * the user intends to use the functions other than the PF.
-         */
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
-            !pdev->exp.sriov_cap) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
 
         if (!s390_pci_alloc_idx(s, pbdev)) {
@@ -1076,6 +1062,18 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
+        /*
+         * Multifunction is not supported due to the lack of CLP. However,
+         * do not check for multifunction capability for SR-IOV devices because
+         * SR-IOV devices automatically add the multifunction capability whether
+         * the user intends to use the functions other than the PF.
+         */
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
+            !pdev->exp.sriov_cap) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */
-- 
MST


