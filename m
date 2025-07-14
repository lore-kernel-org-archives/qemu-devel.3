Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8EFC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMJ-000223-KF; Mon, 14 Jul 2025 19:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIr-0004nL-9x
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIl-0005uw-Db
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VVYFAZpDz35U6k3Zkt3LihPzSlnPDiy3RZ7fk4hpjY=;
 b=OcRKHWbmHVTnh/pHMIRJtuGAd3iIrhhDGsZf0Qppe3hXrWGaC1jtlOnajgvG7UtN5wLCPr
 8oGofGy3B0Jxt1JOatIWObT1iH0f7JnefhVtOop1NTG1lLQZSk97W4AtY2QzJPk5cyy5gN
 8s3M0MYRHQcIQw8KZ2qb4wWdjSYe8Pg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-MdXefwbnM5WLgqV0WKweag-1; Mon, 14 Jul 2025 19:09:36 -0400
X-MC-Unique: MdXefwbnM5WLgqV0WKweag-1
X-Mimecast-MFC-AGG-ID: MdXefwbnM5WLgqV0WKweag_1752534576
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso30883505e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534575; x=1753139375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VVYFAZpDz35U6k3Zkt3LihPzSlnPDiy3RZ7fk4hpjY=;
 b=ad6TRbtuiM9bQJYRyPAJAe9DgvYUrJn/NJcdVUmNqF4izoNxQVoJR/xfZAqjBbS+Tr
 481c05WfXNrYNxLqvpcCTeTOm+QYAqVPknYcLmM9Y8gSgfhplRikuE8FCWKZjLr732t6
 IK/Ued7OeeY8c8b1i7W3TnmI5E3qDZPELf9V+O9OO/mw66nK0s3aXTTHZBullOmAJRCQ
 CBqDoPFNB5yFaRjubSzrXk/Yuv5ctMb+uMScrBztZSXg2S3F4KToLdCrsTtycAQohQkd
 5RbmF6ht3QHKl3zVsGesGbyhB7g1kBW0nqw9h2ckjyDsL45tyAuZ96b2kUQoMOg3iyc6
 1ouA==
X-Gm-Message-State: AOJu0Yy+lxA97+elZvU535g7QxlAqOEkthRsOGYTk3a6QvdsA+4R8jwj
 nc2tvKiqOxxQOvabc4S/snEFSeVcicI65mL9hjInowtbNGRY0Pkamk28TyMgX/vcwBnJZpW35/i
 DvLvy3L/tLVFjhHRuf5ZdlHM/L8WmNIJ6Jx0aNkSieBOyD2iyeXCx6fjy+bb6wxYuBCoeJ/pgII
 PM4OAHF42fPVHIoMXQ72mMFKM0G14/pHMfNA==
X-Gm-Gg: ASbGncurzwZRkxzhTmEfI78cox+SQsksfOs9ajxDBnyH/V1v2IbWPuoE/+FWwMg2G69
 xgEVYXTnititro3j0N4AfFP6/3C/UeMELTT4UgywLxlsenMohI0TFTx/k0eB1Dr8YvzP8VzCIrw
 T3ES6UH8ibvSyIGSzZCGYqG47jsl0Zso0zYyNKd3NQ4gVRfzbc/BiXYdB7oF6vMAF8jnctkkzUJ
 oWdJB9yiTzg9gUJ4+LTp6A7yqcjpbVC/9cYZ1UnbhV6Ezm8GzjD2Q7LN+4s7YpAb+e22Vt/B8oS
 iyG3B/5qKiyQZXsJy7HQP4jYGfTYoLqi
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:885e with SMTP id
 5b1f17b1804b1-4561e5a8f83mr39095745e9.3.1752534575476; 
 Mon, 14 Jul 2025 16:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCaGuCUzpnOO1L1GfLPMZrDCnMsDId2hz+FtM4lmOzBw+ihjturbDq374aErhiXb5sRkon0A==
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:885e with SMTP id
 5b1f17b1804b1-4561e5a8f83mr39095525e9.3.1752534575014; 
 Mon, 14 Jul 2025 16:09:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd474a9csm144014855e9.16.2025.07.14.16.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 76/97] hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
Message-ID: <eb71cd8a131ba9ecf51890292b9db5155f216167.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Some sysbus devices have conditional mmio regions. This
happens for instance with the hw/acpi/ged device. In that case
it becomes difficult to predict which index a specific MMIO
region corresponds to when one needs to mmio map the region.
Introduce a new helper that takes the name of the region instead
of its index. If the region is not found this returns -1.
Otherwise it maps the corresponding index and returns this latter.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-31-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/sysbus.h |  1 +
 hw/core/sysbus.c    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 7dc88aaa27..18fde8a7b4 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -82,6 +82,7 @@ void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
 bool sysbus_is_irq_connected(SysBusDevice *dev, int n);
 qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
+int sysbus_mmio_map_name(SysBusDevice *dev, const char*name, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e71367adfb..ec69e877a2 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -151,6 +151,17 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
     sysbus_mmio_map_common(dev, n, addr, false, 0);
 }
 
+int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
+{
+    for (int i = 0; i < dev->num_mmio; i++) {
+        if (!strcmp(dev->mmio[i].memory->name, name)) {
+            sysbus_mmio_map(dev, i, addr);
+            return i;
+        }
+    }
+    return -1;
+}
+
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority)
 {
-- 
MST


