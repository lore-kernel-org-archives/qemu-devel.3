Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIjD-00015N-Oa; Mon, 15 Apr 2024 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwIjA-00013O-Mi
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwIj8-00047n-Ll
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713173653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h4l8VztMw0abcXi1YILBdp9opUngkhnyyqGJzkB91iU=;
 b=BEr6dEypnNiT3yztiAN1bSKet4uxnkUOSS36Uq8L0Sx4e1YwhBe3jbCp7R4EmhB6ciuSUy
 ar7d9mkJXLcVdjFx1Mzbf5sOvAePwu/p6Xv8S5kOSGv1vqRrRPpNTDb6Qz1BwTC+akGt5R
 37u/457VYQpzbWqLbBREeSGm70E5v+8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Msz8mMAvPViTZsOJeQgmgg-1; Mon, 15 Apr 2024 05:34:11 -0400
X-MC-Unique: Msz8mMAvPViTZsOJeQgmgg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-417fb8195d7so9385955e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173650; x=1713778450;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4l8VztMw0abcXi1YILBdp9opUngkhnyyqGJzkB91iU=;
 b=qypYkV53t+Td8iT+p0kxxjPb5nh7jc/deqaAGvrlu/MIjRGakYV0kLH1AjLjngEx/L
 O4AKvx4A+Mtu3xlIk493wBJbg631mygsmN4ZrTsZly1OWfyMq7SHCGIyRL0O3/gdJzdp
 +jtmzSy50VzwKusJbjkgZjUsM0Abd9PleQ1xuPfnokRxNhF+yoI6aNV78k0x7HtJtIZ+
 l/44Hx6JsPuq22/71LWd57OymXrQUSazDzWpsgNlpne/hrDR6xOo2XrB9miau+CFRU68
 aQxk4vRSkW/0uoS8fr3PTRlt1EU6GyH7Fp4kvQ3kZepGYQSoHwBgP32TfIDpZQYHz00P
 poEQ==
X-Gm-Message-State: AOJu0YwErBBP7YDhpxfYJq7hMMsNPcvVdWN1+i9/pMrWY+9oF/pJgjGw
 jGkEcN2qMXRW/ET5HqZ9x9cda5QA1NlD5BG6VE/LCwdJYkxtBIE9+gXlTPz30M3nPEEQCsv39+D
 3J8Jft+rO9aZF9q0BuO+9M3L41RindZfrRIHzayk9kD/J6DglABi+2fgoGk5QzL1udsOAwomjn5
 kLo3UBgK/9EfsAZ6QJuIwSn2u/YO21IQ==
X-Received: by 2002:a05:600c:5252:b0:418:1031:2a84 with SMTP id
 fc18-20020a05600c525200b0041810312a84mr4585073wmb.17.1713173649851; 
 Mon, 15 Apr 2024 02:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfmQtnM7t7PJ88zSm1TgFbXHhuCw4H6YrbF0LSvQwKCsDRFZEbV/poIlN3cE2na/XimmPCfA==
X-Received: by 2002:a05:600c:5252:b0:418:1031:2a84 with SMTP id
 fc18-20020a05600c525200b0041810312a84mr4585049wmb.17.1713173649175; 
 Mon, 15 Apr 2024 02:34:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c1c0700b004187d900766sm173618wms.43.2024.04.15.02.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 02:34:08 -0700 (PDT)
Date: Mon, 15 Apr 2024 05:34:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>, qemu-stable@nongnu.org,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v8] virtio-pci: fix use of a released vector
Message-ID: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

During the booting process of the non-standard image, the behavior of the
called function in qemu is as follows:

1. vhost_net_stop() was triggered by guest image. This will call the function
virtio_pci_set_guest_notifiers() with assgin= false,
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR

3.vhost_net_start() was called (at this time, the configure vector is
still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
assgin=true, so the irqfd for vector 0 is still not "init" during this process

4. The system continues to boot and sets the vector back to 0. After that
msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash

To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.

(gdb) bt
0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
    at pthread_kill.c:44
1  0x00007fc87148ec53 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at pthread_kill.c:78
2  0x00007fc87143e956 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
4  0x00007fc87142871b in __assert_fail_base
    (fmt=0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=<optimized out>) at assert.c:92
5  0x00007fc871437536 in __GI___assert_fail
    (assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=0x5606413f06f0 <__PRETTY_FUNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=0x560642cae1f0) at ../accel/kvm/kvm-all.c:1837
7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
    (proxy=0x560643c65f00, queue_no=4294967295, vector=0, msg=..., n=0x560643c6e4c8)
    at ../hw/virtio/virtio-pci.c:1005
8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=0x560643c65f00, vector=0, msg=...)
    at ../hw/virtio/virtio-pci.c:1070
9  0x0000560640bc402e in msix_fire_vector_notifier (dev=0x560643c65f00, vector=0, is_masked=false)
    at ../hw/pci/msix.c:120
10 0x0000560640bc40f1 in msix_handle_mask_update (dev=0x560643c65f00, vector=0, was_masked=true)
    at ../hw/pci/msix.c:140
11 0x0000560640bc4503 in msix_table_mmio_write (opaque=0x560643c65f00, addr=12, val=0, size=4)
    at ../hw/pci/msix.c:231
12 0x0000560640f26d83 in memory_region_write_accessor
    (mr=0x560643c66540, addr=12, value=0x7fc86b7bc628, size=4, shift=0, mask=4294967295, attrs=...)
    at ../system/memory.c:497
13 0x0000560640f270a6 in access_with_adjusted_size

     (addr=12, value=0x7fc86b7bc628, size=4, access_size_min=1, access_size_max=4, access_fn=0x560640f26c8d <memory_region_write_accessor>, mr=0x560643c66540, attrs=...) at ../system/memory.c:573
14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=0x560643c66540, addr=12, data=0, op=MO_32, attrs=...)
    at ../system/memory.c:1521
15 0x0000560640f37bac in flatview_write_continue
    (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., ptr=0x7fc871e9c028, len=4, addr1=12, l=4, mr=0x560643c66540)
    at ../system/physmem.c:2714
16 0x0000560640f37d0f in flatview_write
    (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4) at ../system/physmem.c:2756
17 0x0000560640f380bf in address_space_write
    (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4)
    at ../system/physmem.c:2863
18 0x0000560640f3812c in address_space_rw
    (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4, is_write=true) at ../system/physmem.c:2873
--Type <RET> for more, q to quit, c to continue without paging--
19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=0x560642f205e0) at ../accel/kvm/kvm-all.c:2915
20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=0x560642f205e0) at ../accel/kvm/kvm-accel-ops.c:51
21 0x00005606411949f4 in qemu_thread_start (args=0x560642f292b0) at ../util/qemu-thread-posix.c:541
22 0x00007fc87148cdcd in start_thread (arg=<optimized out>) at pthread_create.c:442
23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
(gdb)

MST: coding style and typo fixups

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20240412062750.475180-1-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

v7->v8:
more cleanups, suggested by Philip

still untested, i just got involved to help address coding style
issues

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb6940fc0e..cb159fd078 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
     return offset;
 }
 
+static void virtio_pci_set_vector(VirtIODevice *vdev,
+                                  VirtIOPCIProxy *proxy,
+                                  int queue_no, uint16_t old_vector,
+                                  uint16_t new_vector)
+{
+    bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
+
+    if (new_vector == old_vector) {
+        return;
+    }
+
+    /*
+     * If the device uses irqfd and the vector changes after DRIVER_OK is
+     * set, we need to release the old vector and set up the new one.
+     * Otherwise just need to set the new vector on the device.
+     */
+    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
+        kvm_virtio_pci_vector_release_one(proxy, queue_no);
+    }
+    /* Set the new vector on the device. */
+    if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
+        vdev->config_vector = new_vector;
+    } else {
+        virtio_queue_set_vector(vdev, queue_no, new_vector);
+    }
+    /* If the new vector changed need to set it up. */
+    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
+        kvm_virtio_pci_vector_use_one(proxy, queue_no);
+    }
+}
+
 int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
                            uint8_t bar, uint64_t offset, uint64_t length,
                            uint8_t id)
@@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         } else {
             val = VIRTIO_NO_VECTOR;
         }
-        vdev->config_vector = val;
+        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
+                              vdev->config_vector, val);
         break;
     case VIRTIO_PCI_COMMON_STATUS:
         if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
@@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         } else {
             val = VIRTIO_NO_VECTOR;
         }
-        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
+        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, val);
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
         if (val == 1) {
-- 
MST


