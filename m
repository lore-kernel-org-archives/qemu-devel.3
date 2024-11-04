Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A9D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84H8-0003Z8-RU; Mon, 04 Nov 2024 16:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84H7-0003Y1-9i
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84H5-0005If-O7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Twycu9LeMPLWhT+3APHxCe65PWhI42c5Tsx7A0KoeC8=;
 b=UMgXrgY47RJzOBmpbkERTNfPip8HZokK4K3ACD9mdfxYgonb613yq3pyMmABI4rvvRDNC6
 bUSQH+mvEGh0oUbYZI6nKpz6b10lQ8EymrjlwnkGuVDiPWgYykyZQfKdwkO0JHn2e5xC5N
 m5Ye4RY13SWEYcStFGVkWLftEGXGvak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-hlx8OxVRMRKV95QxZyl2qg-1; Mon, 04 Nov 2024 16:06:08 -0500
X-MC-Unique: hlx8OxVRMRKV95QxZyl2qg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso39429795e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754366; x=1731359166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Twycu9LeMPLWhT+3APHxCe65PWhI42c5Tsx7A0KoeC8=;
 b=qTm7HFLRLF4nBh8WHInEwU+S2D5xIGfOe9VfCXYsFw8eo8l5ZwDRLEPOgjrYEbxK4A
 qaB8kPGyiOZeJ8yJfQqCjYr/wI/bPWKo0jt1lKyZciG4Cfpp3qygdr5REmrIjZDsKHcc
 tnx0AhzaCGkqOsPHN/6MYUvYkA+6uQwDt0X6amWOCR0vH5gXAsEAOa/7SkAMGIlZVm4N
 4KBMqNrShnGbXzwtfAw4UdsoTCHT1fIMEkFMnr/fZlm8fMhRs8NIdXakQU8oZh2pw24u
 VU69Qg3SKw+2HUtcz/cemBXwK8mrKYb3wuDbTqTntIMVqyM/d9iF1XHwqKcwB6khC+Rf
 lWKQ==
X-Gm-Message-State: AOJu0YxPtHjamBJLYF93NYznKNz9TneqZG2USbkCp9G3CqjwpEY0u/f+
 V3koeti7XCABusGjK32/nwL+ndvQGfbSLBSNyZhvTdWCY2ntI+EoryxV1o6zpM27uJ/Ue63LJn9
 Y4py2Bxu0DhfKVfC2j3LHfMBvygknB0nPXKjmNtldlRVhDi++W6f/B3WHa1CdEIRryCvhXVMxR7
 LK32LCW34fgMCp43Xpfe22np+Vrq+Ahw==
X-Received: by 2002:a05:6000:18ac:b0:37d:4f69:c9b with SMTP id
 ffacd0b85a97d-381c7a6ddd1mr15096079f8f.35.1730754366464; 
 Mon, 04 Nov 2024 13:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG403upuUw1/pSjERuBZvmBUJAi7cqFgpVdvOeZ8KP70NsIm3W+Y1VjgoyBaw8iAjV1LRramQ==
X-Received: by 2002:a05:6000:18ac:b0:37d:4f69:c9b with SMTP id
 ffacd0b85a97d-381c7a6ddd1mr15096056f8f.35.1730754366056; 
 Mon, 04 Nov 2024 13:06:06 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e7f33sm194127935e9.6.2024.11.04.13.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:05 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/65] hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
Message-ID: <97b9cb066e5f10845b4bc4d2ec657deb1e73f910.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Enable ACPI table creation for PCI Expander Bridges to be independent
of PCI internals.  Note that the UID is currently the PCI bus number.
This is motivated by the forthcoming ACPI Generic Port SRAT entries
which can be made completely independent of PCI internals.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index dfaea6cbf4..3d52ea5867 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -85,12 +85,25 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
     return pxb->numa_node;
 }
 
+static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
 static void pxb_bus_class_init(ObjectClass *class, void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
     pbc->bus_num = pxb_bus_num;
     pbc->numa_node = pxb_bus_numa_node;
+
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_uid_get, NULL, NULL, NULL);
+    object_class_property_set_description(class, "acpi_uid",
+        "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
 }
 
 static const TypeInfo pxb_bus_info = {
-- 
MST


