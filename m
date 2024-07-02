Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0F3C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzx-0005Bl-Ac; Tue, 02 Jul 2024 16:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzO-0004gj-Us
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzJ-0001cq-5B
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=ESPmpGLujqDwpQEDFOExhdCrHlMpbO4zx4yBdm6R5lsu+3XOWZr255BJfGLSVckP/QwW7J
 BF2jMYczKctMURSVTai0VIktDF5kTaGXTl/WyijnPSRoQ2VtXwQ5SvV/w6KOsRm1JdJP7N
 mDR2WxnbBiYwQxRV6jlbo0KmFYrzf3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ubkQjEnpMQuSYrxIz8shtA-1; Tue, 02 Jul 2024 16:20:27 -0400
X-MC-Unique: ubkQjEnpMQuSYrxIz8shtA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36792df120fso631f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951625; x=1720556425;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=KfHNou1c79A1sCwpFvdTu1uK6Az29hHBYuX/9A5nrNyO8XZoWkIkD1nER6+VA0AAP2
 VswCQTCKhJWMRtZE+Q74xrNJeOirum99uvqwxxu6UR7c4HgbdGCDJFnNtLzRDpW0GpYg
 TIXV0oCAWLIGHHS6dTTJDndQRSwb0vdR9s0L1DXeuwW3/6KmC9J034aU1QJxbc0MZplp
 UbzK/mgUStUb1daNHmxWSGElcku4BaadWJIyQqwP5ecIvSmyNFzGy9dpGzlW+uzikPfg
 4HSRFwhGAvsQs6BtzYtbFIMlEXjnGguLqHQRAFFTlotFK4fnL4Prp7Sw76GEL61Tlm9g
 y5HQ==
X-Gm-Message-State: AOJu0Yzvn1SJKm7/YiVSn9XwebHbUJK3vfHg6Ufhw+1/5796oZwlXJMj
 fjpu6Cpcp6Sf8l7FM9Yqr0kem7Zb9Y28sa7F7s8SUNWS8T7ny4zXG3ZQgUemIwdcto+hya9FbAR
 Mr3gCvh/dxCWi0HTcz9D1ih8bhlBmC9yCDYvxKD8EZMumotlqB1lkDpv/hgS8h7GAvPDw0Gv4gC
 92e4fG5Bpv4E8ruHO1ssPbXPb35XY9Lg==
X-Received: by 2002:adf:f80d:0:b0:366:e838:f5d4 with SMTP id
 ffacd0b85a97d-36775699f64mr6297508f8f.3.1719951625385; 
 Tue, 02 Jul 2024 13:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtcMd5O/pXLMknhkluuufgitGUFtQ2bqrE/6Juv7xgGbYM6R5ulbkQU+EdzhJLn+peDKkirA==
X-Received: by 2002:adf:f80d:0:b0:366:e838:f5d4 with SMTP id
 ffacd0b85a97d-36775699f64mr6297494f8f.3.1719951624832; 
 Tue, 02 Jul 2024 13:20:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367892a4817sm2551072f8f.10.2024.07.02.13.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:24 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL v2 78/88] virtio-iommu: Clear IOMMUDevice when VFIO device is
 unplugged
Message-ID: <41a79d1e945643a2cd26fd48db518cb3ecdaac5e.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Cédric Le Goater <clg@redhat.com>

When a VFIO device is hoplugged in a VM using virtio-iommu, IOMMUPciBus
and IOMMUDevice cache entries are created in the .get_address_space()
handler of the machine IOMMU device. However, these entries are never
destroyed, not even when the VFIO device is detached from the machine.
This can lead to an assert if the device is reattached again.

When reattached, the .get_address_space() handler reuses an
IOMMUDevice entry allocated when the VFIO device was first attached.
virtio_iommu_set_host_iova_ranges() is called later on from the
.set_iommu_device() handler an fails with an assert on 'probe_done'
because the device appears to have been already probed when this is
not the case.

The IOMMUDevice entry is allocated in pci_device_iommu_address_space()
called from under vfio_realize(), the VFIO PCI realize handler. Since
pci_device_unset_iommu_device() is called from vfio_exitfn(), a sub
function of the PCIDevice unrealize() handler, it seems that the
.unset_iommu_device() handler is the best place to release resources
allocated at realize time. Clear the IOMMUDevice cache entry there to
fix hotplug.

Fixes: 817ef10da23c ("virtio-iommu: Implement set|unset]_iommu_device() callbacks")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240701101453.203985-1-clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ed7426afc7..7c54c6b5e2 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -467,6 +467,26 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
+static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->resv_regions = NULL;
+    g_free(sdev);
+    sbus->pbdev[devfn] = NULL;
+}
+
 static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct hiod_key *key1 = v1;
@@ -650,6 +670,7 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     }
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
+    virtio_iommu_device_clear(viommu, bus, devfn);
 }
 
 static const PCIIOMMUOps virtio_iommu_ops = {
-- 
MST


