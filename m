Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9892EC3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmO-0007ZR-QJ; Sun, 21 Jul 2024 20:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglJ-00024r-Kd
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglH-0005vt-6V
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNaBRV7Yd2JZRWzu6CicjU/g67eykdpgIsM3nElPwyU=;
 b=bmIYgsu370XOBbenOKyUN6VlcOWm6pF0nRxiw6DvYpEt7F58ESmjFKmz9S9HxC+9aqByYN
 yD3loQJf2MLYfWtyvS04cxGdQgxRaZ+rxvmiVtys9PiEFIoCrq01daD4uWGlPiG+Uby81z
 pm3X4ce6EhtFvtGUWH1xSVGLPH9wHp8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-GJe62vGLO6-Pvt_Al_vmqA-1; Sun, 21 Jul 2024 20:18:40 -0400
X-MC-Unique: GJe62vGLO6-Pvt_Al_vmqA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso27814285e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607519; x=1722212319;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNaBRV7Yd2JZRWzu6CicjU/g67eykdpgIsM3nElPwyU=;
 b=tY+U/InWqtLLQb5oz6WnOTtWiiidTwosFVZAH6UYT/FwUG7/GyjGHrS7q3OdDfjMd9
 EJY2Kaoqx2CyuF5ybRIMDbG3Myjpf0xJGgNq/v2+sHYVkVxk6h5oAX8eN7gmtvlSydFQ
 Dtu2isxUuMw7i7+wV8kaHpcRqwnHOR9ihoApqKSE81FiOQwW368aDVaVLgv1scVIKevy
 AeEOiNDDtP9R5SR9Xa0Lj9BBLPiq/omRdOJP+FA/y5n8NdH2GZKFPHUSW4bViIWqF3nM
 u74z0lmrdpP88X/fbEThIDUZHZkAugEib6vdu0efmezSHARI+UBH7W7Qn9oufD8/g16U
 3NIw==
X-Gm-Message-State: AOJu0Yy21my/JlsIiqj0LptVeNaUFP1ywWfdxxu1ms9TVbcmnXDhjM5a
 7E0qHNBQ9Or9KefYz741pa2wCTBLKhIA3WZ7iSS4ybYVkGlQ/OZADoUDWxfKM9yxKQci0VtSyBt
 +wdkU0Ai2Ci59T3OkZCxOfuBxv3vORYuXkuI5AgUe2WON7n3M5a8D6lblwnmZuSla/R+A521sMg
 kfRB3ZpKrCeXmzxth2CUuOGXYaPNcG8A==
X-Received: by 2002:a05:600c:5012:b0:426:5dd0:a1fc with SMTP id
 5b1f17b1804b1-427daa67bdbmr40789025e9.34.1721607518935; 
 Sun, 21 Jul 2024 17:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTQARRO7aYw9Gw8nLhPCkPXDku1VDsP8XeRloC7Xv2YVG1qPuIWV0VDrehO6FRmjGukvNiTQ==
X-Received: by 2002:a05:600c:5012:b0:426:5dd0:a1fc with SMTP id
 5b1f17b1804b1-427daa67bdbmr40788925e9.34.1721607518402; 
 Sun, 21 Jul 2024 17:18:38 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8e68ba0sm96986755e9.21.2024.07.21.17.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:37 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 50/63] virtio-iommu: Add trace point on
 virtio_iommu_detach_endpoint_from_domain
Message-ID: <40885f26a8c3d93b3e85ebc4f713ace016ac68b4.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add a trace point on virtio_iommu_detach_endpoint_from_domain().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-7-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 1 +
 hw/virtio/trace-events   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 440dfa6e92..59ef4fb217 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -308,6 +308,7 @@ static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
     if (!ep->domain) {
         return;
     }
+    trace_virtio_iommu_detach_endpoint_from_domain(domain->id, ep->id);
     g_tree_foreach(domain->mappings, virtio_iommu_notify_unmap_cb,
                    ep->iommu_mr);
     QLIST_REMOVE(ep, next);
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b7c04f0856..04e36ae047 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -116,6 +116,7 @@ virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, u
 virtio_iommu_set_config(uint8_t bypass) "bypass=0x%x"
 virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
+virtio_iommu_detach_endpoint_from_domain(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
 virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64 " phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_unmap_done(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
-- 
MST


