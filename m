Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6F2C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ6Y-0003d3-S8; Mon, 27 Jan 2025 09:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6M-0002mU-O6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6K-0003aY-9q
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737988111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrUUBNy0gubhcUJ84Pa8i/ojzfUVmTGn9ylddZJUNjE=;
 b=dmBAqA4DbTusyOIa43Xe+88hiFHXSLfZ0IFDjGXErbZtHI7Ef+6F2FOFUCVd7n21S61BPP
 ErpgyPI1t+XNFQu4HeYzZnW+I7FRiKuRkLBlkERW594i5iMI4HdHEfR8wwB3WjjixWQrn+
 M5yAMei3kNiNfvQvzD/+SffqTynDofE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-DSbp-K02NK2BfMi5D0AIOQ-1; Mon, 27 Jan 2025 09:28:30 -0500
X-MC-Unique: DSbp-K02NK2BfMi5D0AIOQ-1
X-Mimecast-MFC-AGG-ID: DSbp-K02NK2BfMi5D0AIOQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso21944435e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737988109; x=1738592909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrUUBNy0gubhcUJ84Pa8i/ojzfUVmTGn9ylddZJUNjE=;
 b=I0V1ZIXB/tmVW0UHfI/f9Evcpq3YsQJ6FZSOxST65JQbyApdDYaZkTwxajQSnxPd3y
 hPYo2/Q2aybVQwHqUfykabNMckpHrkNk86Noz87EE1QPLo8bIKyJJqgAgEL8mpxTXJB5
 7YpSE3wyNxQonxgI8KznDp3RUr4yyfltqhENs6hMEnbBziVOQAwqXsmWLGx9OrP8oDbC
 wYB/UR+KUzvPaDfvx0JmU8mRXswefkHZFHs5/bzK7/Z2ifQSdKhYICxVtEh0us9mRu2/
 DK6lFh1vOfkP7VLwqb4BqV4lLUNig7PZTpWSJAFCwtALve2pX07XHb34SNPJj2rA8GpM
 zYFQ==
X-Gm-Message-State: AOJu0YwBzKmgdbO1cIsB2k36qYjw6BZLtilA/gmCMSaAnFQeNNVLuZFH
 PccIGcqLB0M6m9a/EjmixPRy6E6W3wNhUiCbnbisYeLzMNEBJn24kt5ZnijjlrQt4yVhja/+2s9
 InYlIs6SD77kqJkJGcchTAt8xtDJZ2xnZ9JxKq6lBG2Tbq7tuqBqLx5j6mNM/O/BBKZAvmBVcjN
 yG4TO2KV+PvZjzWqZhUFv5r3bErCU26r2q9tc=
X-Gm-Gg: ASbGncsh7jQyPRXgX/PptZWPzrB8sz/lxAzZdRHP5BbgxtEV/N/pUmrnovs4H2g+eLb
 C1NNd5mBTRNs1YK9HHq6Rq+caJanQUwscP7uS5F4cM7Ah+Jvcuamq5r1tKJbigPr0zHvz/9du85
 gwa14+0rQ2BdBxh0zJezKsH9KQkBU/VrXa2r0+74PHqdWQXeOxGkQpy86yKxyaXLfIwjJCUTR7C
 J/qGQYNeY5QbrZ9m1zJ/BYojFC3Y//KVAJiUmd0MHwiDpqvAmseQRjRkTfMtC9xMEyhCrpbKPQH
 QkD/YPXdVraJofzr6w5+f/qsENWBRLrKLI+Cu7XbnJsCQ/Wj1wXsXmmsbpKMu1z5ZQ==
X-Received: by 2002:a05:600c:384a:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-438913db2c3mr405571485e9.13.1737988109301; 
 Mon, 27 Jan 2025 06:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI/fxi3P1i3TymQu+VgW8hWXCRQbYlmxE/I2eWnsvsI/YJWh7B/D5Z0g5DJORspqq7K41Qpg==
X-Received: by 2002:a05:600c:384a:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-438913db2c3mr405571055e9.13.1737988108900; 
 Mon, 27 Jan 2025 06:28:28 -0800 (PST)
Received: from localhost
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd4fa57csm140184745e9.4.2025.01.27.06.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 06:28:28 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v1 1/2] virtio-mem-pci: Allow setting nvectors,
 so we can use MSI-X
Date: Mon, 27 Jan 2025 15:28:23 +0100
Message-ID: <20250127142824.494644-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127142824.494644-1-david@redhat.com>
References: <20250127142824.494644-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Let's do it similar as virtio-balloon-pci. With this change, we can
use virtio-mem-pci on s390x, although plugging will still fail until
properly wired up in the machine.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c          |  3 +++
 hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8f396ef803..5e1d9e12ef 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,9 @@ GlobalProperty hw_compat_9_2[] = {
     { "virtio-balloon-pci", "vectors", "0" },
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
+    { "virtio-mem-pci", "vectors", "0" },
+    { "virtio-mem-pci-transitional", "vectors", "0" },
+    { "virtio-mem-pci-non-transitional", "vectors", "0" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 1b4e9a3284..6cc5f0fd3b 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -22,6 +22,10 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&mem_pci->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 2;
+    }
+
     virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -152,6 +156,13 @@ static void virtio_mem_pci_set_requested_size(Object *obj, Visitor *v,
     object_property_set(OBJECT(&pci_mem->vdev), name, v, errp);
 }
 
+static const Property virtio_mem_pci_class_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+};
+
 static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -164,6 +175,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
+    device_class_set_props(dc, virtio_mem_pci_class_properties);
 
     mdc->get_addr = virtio_mem_pci_get_addr;
     mdc->set_addr = virtio_mem_pci_set_addr;
-- 
2.48.1


