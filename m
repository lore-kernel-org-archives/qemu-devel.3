Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9BFC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nr-00039l-1v; Wed, 03 Jul 2024 18:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8np-0002a6-6W
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ni-0007P9-B3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=HL8yTB28u1rUpzQRZplp0nHuAk0xEFUpO1iQFuYivAdMK/xLfJRGnGahO7Fha54vflbjGF
 daRL476UeHnznkVvWlcTMCS01s2OzK1YbRXBpNY7Vxr/2+nQloer/GDhkFiDn9WjgF83g5
 CqOofWJr2VtfFlKJpAAoOfoiaOVjNLk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-01SiHKRjOve5eOJGJFbcyQ-1; Wed, 03 Jul 2024 18:50:07 -0400
X-MC-Unique: 01SiHKRjOve5eOJGJFbcyQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678ff75122so52125f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047005; x=1720651805;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=IySrL4OOx8NlA3m6dav6TUB79OXYl3Wxt1mJWyo281LvvV16/PlQJOXRIc0A5Ca65G
 5xp6rAPSSgT/NgQuJ3ej6str8lor9M5PnIJgvCol/BqxkV68QAxgJ5DsRjQO8lVI6G0E
 19OPjsHhW2D/LcaxCJqFyhSpLDt07Owy3/YxqLSTunIlgS9RJ1vvOHvrXrQ4Z5rBjkeV
 lF86xbT0n4ixSgkwZvS+lhQ4dAPl6+AuxaNJoXOlwV4/d9+2aJ6HAlwnitt4/19IAFmT
 wXaiKbIFqxFlrdRWgM91XMk1zH1o7GEChhmapVAoF30nku8jor6xY7mPcsaxO1tEtkWs
 7/Bw==
X-Gm-Message-State: AOJu0Yx3LBIbEQTG5JGRLLjx0JpuQE12CxdiWF3HZXnJLqfszck05Z8U
 PjZoFRzAV17l3We5bwW/V+fDomjwYxgk32vu+FKSLyuAft/YVxoM+DgFlqJUuOlIRajTdbCldcj
 P83/JZppL6K8msX6kyaNi2N74MKGCRhwnBJaCFH6Vszr0mwhEeLC83jdUmzw/KTOltYhJgRluB/
 zgnktUdJOFSFfjr0k1NwhGwJaN2Sf06g==
X-Received: by 2002:a5d:4d4e:0:b0:367:900c:c0a3 with SMTP id
 ffacd0b85a97d-3679dd15be0mr14789f8f.4.1720047005357; 
 Wed, 03 Jul 2024 15:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE42dKA7uESBquH/igR/A8qDsT9V2sfQCdLMEsgJwRfsfIdN24Iw7nIriyz48t2jOSlpT09Yw==
X-Received: by 2002:a5d:4d4e:0:b0:367:900c:c0a3 with SMTP id
 ffacd0b85a97d-3679dd15be0mr14780f8f.4.1720047004708; 
 Wed, 03 Jul 2024 15:50:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cdc5csm16868540f8f.18.2024.07.03.15.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:03 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL v3 75/85] virtio-iommu: Clear IOMMUDevice when VFIO device is
 unplugged
Message-ID: <1b889d6e39c32d709f1114699a014b381bcf1cb1.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


