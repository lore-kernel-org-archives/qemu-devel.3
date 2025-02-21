Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F6C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5N-0001qA-Bp; Fri, 21 Feb 2025 07:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5K-0001ZV-7Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5F-0007El-Ee
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4axH5wnLBbWmf0mZZ4eXxBRYfBLFNqsbFSXKtM6Ca1c=;
 b=YlvpTvdMAA9MYzvYwmW8GvXOHNR4mSwwg9Qz/XmmAHOhd2BiM/MXwPl33L1qK2+c6KiJY/
 vLnZFujYeeC4TzEioo6UrGjktPngwUHatqi2BiT1clhD7Dac+EGMBlANdG6L8/uYBpQvbZ
 NYWTh1Rb3PeR8vUgm5/NRHmTDQlulHA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-KD7lBZHgMmmDDH1L0mXhFQ-1; Fri, 21 Feb 2025 07:24:43 -0500
X-MC-Unique: KD7lBZHgMmmDDH1L0mXhFQ-1
X-Mimecast-MFC-AGG-ID: KD7lBZHgMmmDDH1L0mXhFQ_1740140682
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so1762004f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140682; x=1740745482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4axH5wnLBbWmf0mZZ4eXxBRYfBLFNqsbFSXKtM6Ca1c=;
 b=uHSeeLz8c3eH7RO1YwXJb4kwtsI8bRNLCA1yoXPalCf8gih/yNEAFNyq6memIrw6HB
 uROpIO+vn18mHZmTlmH/kbqi4pQWcsMV3QJksu/7S7JM0tjc22Wqlv63+rQYi2rQofN7
 KCgCm3GJ5o5j3lCuC9uCKqzoeD0UqM+vWCwpw51BpJUDNj+edx9IVRjDa/7lMhbSFPGk
 IAfaH3hkjC5dNcym3J6F/F+sGFKEkaD+Lu/sA94ivXExQK7t1ldd4L+GAAL7oLWidDGh
 KTErGwwLUk2/YkVWDBbyFZMpcTVbIxIhvYw3vY8LxUuZa2lAE0t+JOy0R4KIQHxDtDBG
 0E2A==
X-Gm-Message-State: AOJu0YynasEF/j0hDK4eoCrqsHg6p9u/S+O5naIZM6VmXCw+Pdk/o8BH
 +/OXZYoiPdGRziviJkUBIU455lnurw/xaNbiSt8fISeE+4Cv1Ab8TYyu+rNs74NK0iuUlM/YWkV
 DLhhDdONxvPBrkkWp+2ArmSnDaSDe6I4jt9xGFoBVGXeU9uRmmi9+97yDTPDpnYjKxvHIL+s6RX
 dBLkK3s/kaD1qZO0Z+82bKl9JiBWBTrA==
X-Gm-Gg: ASbGncvcSh3b/Es5t8fgqmzVjPLXkm4LBnlgs4F6B2KePXd59ESSwXrOk8DV8jR3Thc
 rr7DFjhDfFFSDF3wInxnYewTeZ6uBCjaCnDsAyE4ZCjhkXYy7kMKu9cLBiJH66J0wq8N3nwlQfS
 bAdGLmDFZVIljXY1PcwKOv2B9+pamiqAyufpO5mVLpeCxRoK3mzCwbWWmUeiIWYiM66dRl901gA
 3iwsJDop3axRKh1ZxkhQD8ZEJFkLMlsdFnHYt2+EwQgINBcs00/9lCifmH16vliKIdEm1Ro05Gc
 2vANxQ==
X-Received: by 2002:a05:6000:1fa5:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f6e7572a4mr2601437f8f.8.1740140681914; 
 Fri, 21 Feb 2025 04:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgb2QoSwEnpVJ6E6eXVMY4HLbaa7xmHAySLJUcGX1p5ru24YWlfiZSBl/WBKtwdlr3HT49Jw==
X-Received: by 2002:a05:6000:1fa5:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f6e7572a4mr2601407f8f.8.1740140681398; 
 Fri, 21 Feb 2025 04:24:41 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7b68sm22889517f8f.85.2025.02.21.04.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:40 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 37/41] hw/virtio/virtio-iommu: Migrate to 3-phase reset
Message-ID: <d261b84d354a41a38336af813f92f636d3fb3f78.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Currently the iommu may be reset before the devices
it protects. For example this happens with virtio-net.

Let's use 3-phase reset mechanism and reset the IOMMU on
exit phase after all DMA capable devices have been
reset during the 'enter' or 'hold' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>

Message-Id: <20250218182737.76722-2-eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 14 ++++++++++----
 hw/virtio/trace-events   |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f41104a952..b6e7e01ef7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1504,11 +1504,11 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
-static void virtio_iommu_device_reset(VirtIODevice *vdev)
+static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
 {
-    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
 
-    trace_virtio_iommu_device_reset();
+    trace_virtio_iommu_device_reset_exit();
 
     if (s->domains) {
         g_tree_destroy(s->domains);
@@ -1668,6 +1668,7 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_iommu_properties);
     dc->vmsd = &vmstate_virtio_iommu;
@@ -1675,7 +1676,12 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = virtio_iommu_device_realize;
     vdc->unrealize = virtio_iommu_device_unrealize;
-    vdc->reset = virtio_iommu_device_reset;
+
+    /*
+     * Use 'exit' reset phase to make sure all DMA requests
+     * have been quiesced during 'enter' or 'hold' phase
+     */
+    rc->phases.exit = virtio_iommu_device_reset_exit;
     vdc->get_config = virtio_iommu_get_config;
     vdc->set_config = virtio_iommu_set_config;
     vdc->get_features = virtio_iommu_get_features;
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 04e36ae047..76f0d458b2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -108,7 +108,7 @@ virtio_pci_notify_write(uint64_t addr, uint64_t val, unsigned int size) "0x%" PR
 virtio_pci_notify_write_pio(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
 
 # hw/virtio/virtio-iommu.c
-virtio_iommu_device_reset(void) "reset!"
+virtio_iommu_device_reset_exit(void) "reset!"
 virtio_iommu_system_reset(void) "system reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-- 
MST


