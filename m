Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A839DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEI-0006In-E7; Tue, 02 Jul 2024 10:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE5-0005Rb-PY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE2-0000TY-W0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=JF7Sn9Y/mWLskAS+wPmc+NnJt06ITJwkC+aoNNa6AkkNaEJBP7DlDQspgu+ria+j4vU+ZG
 FTxpfi+F74rME1hBIz2RgIiliYzwHlrEFOarNMAfwUghD5CfCNPqd+KR4BfayEvUOgICHQ
 xrtf7l0neQCQSmJQ7IhHRGvq04m2Xm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-n8i54DblPqqukQ-NG6Yj7Q-1; Tue, 02 Jul 2024 10:11:14 -0400
X-MC-Unique: n8i54DblPqqukQ-NG6Yj7Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-424fb2df2bdso39082975e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929473; x=1720534273;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYzP7D9xykWeqZt2i0B3IIaPj2W0maOmrsq57DCD/d0=;
 b=J7+P/MHVL+vo1rP1EtJJFye+M2GQ9EZmxHVRZIP+MHJL2xPhkhrgnLuYI9OmfaNKcq
 qK4GfarD6Q4bG8PpSJTxh2HWWTQBUVjP1mzwyT8cIbbqX6FO9LLDLoOVNrMIzFoTiEzs
 eLh+u92VHm1AiEccq7GXbfllXX1Hy5AzaXyU15uTqhlumWffXeTg4R5K+/uz6K9dYQfa
 mdIMuczZS+2+AxkKQKnLX24Xue6Vspph66KPFlK3B6kl2U5basrNRhGQUm8twtbnK4YB
 T0bSVX1GYsUrOGfwnZ5EfoYn3cCg4m341RPrMblZU9qz3Dg7LJv9t5kUbayI3Kq4ia8j
 7Xjg==
X-Gm-Message-State: AOJu0YxEVlH8YmKeA2NsY6BpLjCg+FZJ1JDRN3WKoR5XMIkg/UdJEr7+
 2BvVINfyAcLbX55hV1FGY+bh3JlTVPd1N8S1TxanwO4nikCLFrI5z85bUkYSUhYA+SutEXcpU2d
 or4M2v4L94Dl9MFcHNyJyqQ67iMAlm3ilM78fCkTgkXX+Uy0kSkr5ckymOKClZ5dPiVXanr+P70
 M32pJllaTtGeJ2CCOQ6jlSPDJVrLosVA==
X-Received: by 2002:a05:600c:4248:b0:424:a31d:a046 with SMTP id
 5b1f17b1804b1-4257a007deemr85342405e9.15.1719929472786; 
 Tue, 02 Jul 2024 07:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMqCqcJp5KEfmR3ilNy0ETjMvahMtiG9//cBNzPatDFzvgcGDFDwuX/iFB5OAW0+lN+hFOQ==
X-Received: by 2002:a05:600c:4248:b0:424:a31d:a046 with SMTP id
 5b1f17b1804b1-4257a007deemr85342035e9.15.1719929472133; 
 Tue, 02 Jul 2024 07:11:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b098426sm198287055e9.32.2024.07.02.07.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:11 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 81/91] virtio-iommu: Clear IOMMUDevice when VFIO device is
 unplugged
Message-ID: <35fb409a47c4ac0ce9fca2a7f695ecf84c962228.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


