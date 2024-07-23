Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D213AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGK-0008P8-Cc; Tue, 23 Jul 2024 07:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFo-00068J-CE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFm-0002ul-OO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNaBRV7Yd2JZRWzu6CicjU/g67eykdpgIsM3nElPwyU=;
 b=iQXpH2uhgOsSZ1oISXXRH6VHD2luYIhA2zBW2E00Gk7S8y/ACXRSZtOO2fTqjEsLVZX567
 iScZPWQMIk6d88fqvcuOtXM7Q/qdhk0HJ9JYtRiCW2qbrNw9qyYJ8G0LymIH5hFVvc7O7X
 i/AxbIrJPNAy06i3qSJHKkxT87uPiu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Tp-q91B-MrGLniD9WERHRQ-1; Tue, 23 Jul 2024 07:00:20 -0400
X-MC-Unique: Tp-q91B-MrGLniD9WERHRQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427df7c3a2aso20047725e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732419; x=1722337219;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNaBRV7Yd2JZRWzu6CicjU/g67eykdpgIsM3nElPwyU=;
 b=lhuFzYJa2FN+xAiiVlfWOqlFQawOPnpIu5tJ9mSN8TRVNpNLUFojnTTWaHMibfOoCT
 1lrJYfm5OlN3+t7LumLvSIThPvXq9gtadCjrrutGjjH6ZGC+0ebKAwMLTpJJ4FU6Iw4g
 3KkbmwfQjqtGsMu7yx9w+xP/al9O0+U3PTLWLsVnZrZtC6jH4Ks64gsApL0rj2JZqVGn
 +kOY9lnfY+SliV9z2a8uUPi827mBxEY6Ry+EvfycU+p7XXK+6y7RHOb3hJ44NJVcR4zM
 NzCIBr61IqERk/oCRvNZdTPiTBCAqZMvGGxh1Z15dZmO4p5q4LSH1gOVpo9kNpGSrgeR
 CUWw==
X-Gm-Message-State: AOJu0YxXvBrshfvKM5gUN7RBgtA99cjd6sJ714eL9y9M0B3enbwnIXhy
 blx/xvmmcwpuNQ3szHi77Ppgp/uS/6GTyx/qnHWnsKYsk1hxPCo5R7oLqDSjZwGyIlV/5vJxNcF
 Ifkf9UQ03FIBZpEf2YRolUcd8fReh9UPu1eBXg/9duji6a2WUfPafkoBAvAuX2L0wiDDt6JWV1Q
 8rLt6TMg7dk7OfcbrFdXZRBAbEtAwkag==
X-Received: by 2002:a05:600c:138b:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-427dc5290ffmr59045985e9.19.1721732419412; 
 Tue, 23 Jul 2024 04:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvzJmZOxWpQRfFBp7VjshzP9XB2kRIrkzhmIipSXjNXt7fmpkYodRBPdoUm4jhQhtLWf4rNg==
X-Received: by 2002:a05:600c:138b:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-427dc5290ffmr59045665e9.19.1721732418897; 
 Tue, 23 Jul 2024 04:00:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3b8ccsm199501005e9.2.2024.07.23.04.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:18 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL v2 49/61] virtio-iommu: Add trace point on
 virtio_iommu_detach_endpoint_from_domain
Message-ID: <6c027a9de3fae3b8a3a4868e17c7a28ba5372463.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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


