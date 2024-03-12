Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F8DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZi-0004ZB-B8; Tue, 12 Mar 2024 18:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZf-0004Yi-Jk
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZd-0004G3-WB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK1DhLEmCwAUM4WVYh1w+A/omwtvVrpMmMYYh4o/i+I=;
 b=etA7GxpGGihpb+lC2svpvzqpycddIJVXpMhvAuneJ8xz1Q5XH3b1YlWckAeH0pNq2iSCIA
 cW0c2vRMIeXNa/ddTonBiVw9VosEDdyQ1penyFGpxggEDEbhXosl8k6MQ5x8zml7JMeqfg
 2ltDOHSqGjCZXqi8hgTy53d5i9X90Dw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-lWYgiSLkM16maHv1DA4wWg-1; Tue, 12 Mar 2024 18:26:16 -0400
X-MC-Unique: lWYgiSLkM16maHv1DA4wWg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5684345c0ebso290142a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282374; x=1710887174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK1DhLEmCwAUM4WVYh1w+A/omwtvVrpMmMYYh4o/i+I=;
 b=Dvuw+zTN4L0yDNopNqe3/o60pk9vNJPLGcyM32/YUH0/j5SKL85+OSzILZ9nx3Zet/
 Ngf/UrZIsXqwOGX4ccEjvSTub2vPuRakpP+2kxX0Y8EloIHYcR1fUtSz0ax6KLeSRl4n
 ey6roKmzu67ih7x2R+1uzZrMpv/N/owH5PE5pU8fWseyu6RCZq1f2U7YlDsvFnVJbO9l
 HajGi4taZD0OJjzwXx5l1UMCmiF8L/NrKl+vvAzR9/dDzH6OzYsQYZTPfdWN41A8Ipeg
 XEPXE00obgRUXGs+5uW9O4753qoruj7VJMPDjt/r+IBsvL4vUPAzC0wZlq+IocEbiUp0
 4K3g==
X-Gm-Message-State: AOJu0Yy9aznRE3GzNU0sWSM7YvkgqiykiS9ffHniwTg0SD8igx/gpfMP
 qNMC30iz00JoWU6LHyy5RJwU9ZApDuO6hK8gnKt+A4cyVoIf4H8XM+UB64Pb6AaCQ4JdbA9EEsf
 cfWC4FEFy14sW7bUdc0G8OTAvWlvl9b2SMO4jXr7ffy/HU3e+ZDmLApo5wh03TTXTu83z2SNSMX
 zdqTHXzKuiEGCd411/FkpmMzXAIP262b0N
X-Received: by 2002:a50:8a9d:0:b0:568:145a:4a22 with SMTP id
 j29-20020a508a9d000000b00568145a4a22mr860130edj.4.1710282374609; 
 Tue, 12 Mar 2024 15:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFm2A3qaPDQU67tgC1/XF2+5KDNl9m2TgWcYz9HmefGM0Eg8eHZzAght4sV3YThZwA0hiE6Q==
X-Received: by 2002:a50:8a9d:0:b0:568:145a:4a22 with SMTP id
 j29-20020a508a9d000000b00568145a4a22mr860108edj.4.1710282374252; 
 Tue, 12 Mar 2024 15:26:14 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 et3-20020a056402378300b005687a473947sm720658edb.28.2024.03.12.15.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 14/68] libvhost-user: Factor out removing all mem regions
Message-ID: <bec5820908919f70f87b57b92e4c92be128f5cfd.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's factor it out. Note that the check for MAP_FAILED was wrong as
we never set mmap_addr if mmap() failed. We'll remove the NULL check
separately.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-4-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 34 ++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 360c5366d6..e4907dfc26 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -240,6 +240,22 @@ qva_to_va(VuDev *dev, uint64_t qemu_addr)
     return NULL;
 }
 
+static void
+vu_remove_all_mem_regs(VuDev *dev)
+{
+    unsigned int i;
+
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+        void *ma = (void *)(uintptr_t)r->mmap_addr;
+
+        if (ma) {
+            munmap(ma, r->size + r->mmap_offset);
+        }
+    }
+    dev->nregions = 0;
+}
+
 static void
 vmsg_close_fds(VhostUserMsg *vmsg)
 {
@@ -1003,14 +1019,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int i;
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
 
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-        void *ma = (void *) (uintptr_t) r->mmap_addr;
-
-        if (ma) {
-            munmap(ma, r->size + r->mmap_offset);
-        }
-    }
+    vu_remove_all_mem_regs(dev);
     dev->nregions = memory->nregions;
 
     if (dev->postcopy_listening) {
@@ -2112,14 +2121,7 @@ vu_deinit(VuDev *dev)
 {
     unsigned int i;
 
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-        void *m = (void *) (uintptr_t) r->mmap_addr;
-        if (m != MAP_FAILED) {
-            munmap(m, r->size + r->mmap_offset);
-        }
-    }
-    dev->nregions = 0;
+    vu_remove_all_mem_regs(dev);
 
     for (i = 0; i < dev->max_queues; i++) {
         VuVirtq *vq = &dev->vq[i];
-- 
MST


