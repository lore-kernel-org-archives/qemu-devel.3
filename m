Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A36AC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwz-0004DF-RD; Tue, 02 Jul 2024 16:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwk-0002eo-Ir
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwi-0008Va-Dh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=Eo8c6URmF3Ff8E2/ycjD9wbKNlTtZbJKwpAlOvEZHKCrLrwQqHwpzGPKHdciv4HLfdKdNs
 LJsZbhOr0xH8AMQxBm7sdM72xVBn49vz6BaUiJ6J2mkZxakUSBn+fGkWnVyCLrnwhdvkvX
 f6JTY8iI2gUP1Kq2QdB2/r6601VJMRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-nvJltKjrPVKbTOmzhaeRWA-1; Tue, 02 Jul 2024 16:17:46 -0400
X-MC-Unique: nvJltKjrPVKbTOmzhaeRWA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso37118895e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951464; x=1720556264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=pXwJA2G/nUwzGPJqZZSsAciUhmNBoHyF6DLBnYNsJDv05cynWGqDgtEijXIHTDsFKU
 F2QmCVUZ2fLlfVb+GhDWbAOq/kaoH1JKvc5RJa13/ef5PzICTvgru7Stz6XCaPifGu6+
 n80bdI5Y1fABqPDtar9hh+pt1iWbgmpNjLyXqaUGCVGD2D6MKVgg/vqtTTvYfkg7vCYc
 TS3TgXwLNJfObN9XoPa3sc89WgYv+pMH/6lz0rmhRsk6x6u2rSJGMrKEUUEstVwQiuoA
 mSdaepJ93VCEm236Qm1RA8RoE+pZBtltjkroarddc+XE/xGaURzj9l3WcXKo4Tuujcj8
 6zEg==
X-Gm-Message-State: AOJu0Yw/KuhxXYo3TQSmiOjJa9TSgutBIkMTf+T1Fv6K+SI/8WlxIa5p
 CokmiB7PXUF5DhCarLShzjf8XQomupN+ZobAEUomjqw1y2dVYDvvr+X9eddkdIb0WXewsAdSkDM
 lHCEMw7uHY2TG0yTMfRouBpXYgPiU3+/mW11lid7p5xbc/801qNPzZoZUFVO6gI6mUXH6JYwlQl
 TVnYZMXDWSl+q6guxMA5lOELm9rLfFeA==
X-Received: by 2002:a05:600c:c88:b0:422:62db:5a02 with SMTP id
 5b1f17b1804b1-4257a05f928mr64712845e9.32.1719951464029; 
 Tue, 02 Jul 2024 13:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI0qmSpZoTU+G1mSgocUfLqCHqeB+AlNTGLbd+XjVxzOEOpUPaw75mqNITd6vAhSBNS4r/PQ==
X-Received: by 2002:a05:600c:c88:b0:422:62db:5a02 with SMTP id
 5b1f17b1804b1-4257a05f928mr64712735e9.32.1719951463510; 
 Tue, 02 Jul 2024 13:17:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm213742855e9.30.2024.07.02.13.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 37/88] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Message-ID: <a113d041e8d0b152d72a7c2bf47dd09aabf9ade2.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cindy Lu <lulu@redhat.com>

In function kvm_virtio_pci_vector_use_one(), the function will only use
the irqfd/vector for itself. Therefore, in the undo label, the failing
process is incorrect.
To fix this, we can just remove this label.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20240528084840.194538-1-lulu@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7d62e92365..5941f1a94d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -898,7 +898,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
     }
     ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
     if (ret < 0) {
-        goto undo;
+        return ret;
     }
     /*
      * If guest supports masking, set up irqfd now.
@@ -908,25 +908,11 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
         ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
         if (ret < 0) {
             kvm_virtio_pci_vq_vector_release(proxy, vector);
-            goto undo;
+            return ret;
         }
     }
 
     return 0;
-undo:
-
-    vector = virtio_queue_vector(vdev, queue_no);
-    if (vector >= msix_nr_vectors_allocated(dev)) {
-        return ret;
-    }
-    if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
-        ret = virtio_pci_get_notifier(proxy, queue_no, &n, &vector);
-        if (ret < 0) {
-            return ret;
-        }
-        kvm_virtio_pci_irqfd_release(proxy, n, vector);
-    }
-    return ret;
 }
 static int kvm_virtio_pci_vector_vq_use(VirtIOPCIProxy *proxy, int nvqs)
 {
-- 
MST


