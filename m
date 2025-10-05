Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0ACCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFZ-00030Q-TT; Sun, 05 Oct 2025 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFX-0002mV-4p
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFU-0006dP-8y
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23LWX8Qf1h5uWc6TSJ5v/9otVvLkJLt+t300V2hS7WI=;
 b=Bgn4n+9QhzhQLKueqb0IPqMXBDcUj+h0euq8/SUUstK0A9TLwHc/TmK1VBfXmY4qx37zXW
 Hqb4oh0b1gNLkT5Fmdnreg9wVofbpTsVX8iRpailPMeKlhAUpockuxdANvF6MQFa2eiQeI
 m9z+yhXT6RsY5UpKB06m59SyaVM9Qb4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-DxQnO7wQPlWEFaN7QzBe0A-1; Sun, 05 Oct 2025 15:18:21 -0400
X-MC-Unique: DxQnO7wQPlWEFaN7QzBe0A-1
X-Mimecast-MFC-AGG-ID: DxQnO7wQPlWEFaN7QzBe0A_1759691900
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e31191379so26935165e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691900; x=1760296700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23LWX8Qf1h5uWc6TSJ5v/9otVvLkJLt+t300V2hS7WI=;
 b=X0e3JY8IyBCKOWdATyKmQ7JNQp/CpMPiijppL90Lgl/yYYTCYI08y4LargkiynDtO1
 codSYR+E1o6FdRhWN++0QBZxQY7q0zgi1VauAVNJj7WqJmBdJb0g/WS3thX0kkypOXGL
 IT+EdFmZLAk50gmPHbrCHhAuKGLO1zPpyx/S/eDafLWIPJlDRA6UuAlLnw9Sldl1iiz7
 PjOQwswEW6a2XQlJyoEooAgI6/e7xshsEv84lDnGChB9X8D3oYwA3zZaAyhyugD7mFp9
 Nei9Mvf76m1mfH1a9d7H6brvXmgJRt1ztFUqz78JqpUs/sBEsTzp7HLYuAs9NcGEZ/b+
 lkHw==
X-Gm-Message-State: AOJu0YzGnpPXdfqsP0zN30T8HgLlQPZnrfKrf7SZREHUb0pzsZwLt8b/
 0zJFGITfD2pK0vzm9O/VdVSM5Gr5bwKqDTES4nrq/gbInJp4cjkqC/Du9WysnwxzHnD588+K02z
 02PMigJmFHTxvHS63X2WlJeH8p3c2zvWTA8/4Incu8j/kvWkOh571RvC+XbHbvGxWxNV1cWMd33
 BK7ehoLBGltZhHlPzcIjXiX51KaNGPGxq/uQ==
X-Gm-Gg: ASbGnctr4tSTIeBSBIkzmkBOAS78YbHrplG5KF8ZXltwkMdHZHVNsaLFf/3K1uCpUJ+
 bzRWWTFzOdK9tA8SqpKmm7SgTwCzwT9cVZdopLp78llQHDO2D0aXxb9EFC5K+Br/2KWjvcmxsVa
 0LvIbpQzgQHXeFYo3TTfE3BVnU0LKMadzfD6kam+X2mGMGG+/NGPX5JM1E1WVtcUy7Y5K38mxij
 zfAdlGX2P5xO0g3Oo9rh7p4QyqVEqcnfRdZJsqiRjtOfQU5nj2O3ErG1XGDc7oy0/+1e9X2qxs+
 EQWB5NA6mam14UZjCaEBcCuanCqNBxXhmBp1GMU=
X-Received: by 2002:a05:600c:8506:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-46e7113f6e2mr72103915e9.18.1759691899831; 
 Sun, 05 Oct 2025 12:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7+wSypRsjnnvOqhBiK7Zp4NlVB8/bPJEr1L6RKBqSEZRxSa16BQiei4vXxjYNkxZ913eWcw==
X-Received: by 2002:a05:600c:8506:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-46e7113f6e2mr72103755e9.18.1759691899285; 
 Sun, 05 Oct 2025 12:18:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm17261149f8f.29.2025.10.05.12.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:18 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 61/75] amd_iommu: Unmap all address spaces under the AMD IOMMU
 on reset
Message-ID: <53fb70ad6219bd2b3ed17e2b87ceab722e69d5b9.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Support dropping all existing mappings on reset. When the guest kernel
reboots it will create new ones, but other components that run before
the kernel (e.g. OVMF) should not be able to use existing mappings from
the previous boot.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-13-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4376e977f8..497f18c540 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -847,6 +847,77 @@ next:
     }
 }
 
+/*
+ * Unmap entire range that the notifier registered for i.e. the full AS.
+ *
+ * This is seemingly technically equivalent to directly calling
+ * memory_region_unmap_iommu_notifier_range(), but it allows to check for
+ * notifier boundaries and issue notifications with ranges within those bounds.
+ */
+static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
+{
+
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+    hwaddr remain;
+    DMAMap map;
+
+    assert(start <= end);
+    remain = end - start + 1;
+
+    /*
+     * Divide the notifier range into chunks that are aligned and do not exceed
+     * the notifier boundaries.
+     */
+    while (remain >= AMDVI_PAGE_SIZE) {
+
+        IOMMUTLBEvent event;
+
+        uint64_t mask = dma_aligned_pow2_mask(start, end, 64);
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+
+        IOMMUTLBEntry entry = {
+            .target_as = &address_space_memory,
+            .iova = start,
+            .translated_addr = 0,   /* irrelevant for unmap case */
+            .addr_mask = mask,
+            .perm = IOMMU_NONE,
+        };
+        event.entry = entry;
+
+        /* Call notifier registered for updates on this address space */
+        memory_region_notify_iommu_one(n, &event);
+
+        start += mask + 1;
+        remain -= mask + 1;
+    }
+
+    assert(!remain);
+
+    map.iova = n->start;
+    map.size = n->end - n->start;
+
+    iova_tree_remove(as->iova_tree, map);
+}
+
+/*
+ * For all the address spaces with notifiers registered, unmap the entire range
+ * the notifier registered for i.e. clear all the address spaces managed by the
+ * IOMMU.
+ */
+static void amdvi_address_space_unmap_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+    IOMMUNotifier *n;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            amdvi_address_space_unmap(as, n);
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2099,6 +2170,9 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     msi_reset(&s->pci->dev);
     amdvi_init(s);
+
+    /* Discard all mappings on device reset */
+    amdvi_address_space_unmap_all(s);
 }
 
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
-- 
MST


