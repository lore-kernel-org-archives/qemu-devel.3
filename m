Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803CBC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUI-0005iB-6v; Tue, 04 Jun 2024 15:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUG-0005gh-CP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUD-0000jJ-P9
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2Wvy0LGpm4pxtnl88LpvbhL/o1XmX9DIATppvWqzCs=;
 b=RCz7Y62+qN/S2XORY8iNbU7XJaB2Z+pt9NtqsGk/DfM3LkZCm16Qrp8p74hMofaRvNX0ML
 h0/fHcfp2QJVUM7CvXzkxH9C0bvogG2hNaHAVCzAEm5vdmlV0WiA4YK4YKvvoeFux1Ppb2
 CoJDjXCKGcQAxZZ3xPUu+bN4JZQJLb0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-wwLki5eDOgOrX8tzsZX_2w-1; Tue, 04 Jun 2024 15:06:17 -0400
X-MC-Unique: wwLki5eDOgOrX8tzsZX_2w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42129affd18so29150885e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527976; x=1718132776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2Wvy0LGpm4pxtnl88LpvbhL/o1XmX9DIATppvWqzCs=;
 b=BTq0mgOWTwCNJyhJ7H64qw/z8vKOjec85jAinm50wt1d5IF0EQyikoeD7LRjAp9p7H
 SlSMpxCBkgwIYjWs5pvQFBy5VXNaAUvNflFUwbDHaRQkZ0Z9qBkCzqbvXWrAwOQNKb0k
 XZORZOADoCwwlfUgnkUHwLnr/LMRATUxt/ee6NYffAScFl1mEIQ7x/nJk4IpabLWo7Fp
 ZlveRBvFHBgPz6c4eKNXpfNOLTkwLvlg9Mvv/a3hnqTnHUcJQneYsnFgBG6YiiamwCPC
 VovOoPz2fFJbKAzKK9v9eG8ULjCv2VjZ1QTplIxGtgjGOnxn/RyK3wy+/reoXKbYgJ6q
 5WQg==
X-Gm-Message-State: AOJu0YxiQBQaXwUfGMkb7Xb8+SJSqucj2kD23o5Br4UVfQIMip4KVWmS
 R//cI5GMIbmZAot/mMCgVlzX0qiF4PuwXQQ5HKwpNSa/tePZPPkPiPRStjbx5KCQvKvL3XJMwfK
 vb1DwL51Yrtx4e3VWeUAOoqFtxEriPdMI4GwPCDRM4G14NdMN87kVW2dNDw9naNZNdM19QZk1XR
 8RIF8a48a5b87bmC6ZcD2/Q20n/Xliig==
X-Received: by 2002:a05:600c:3d8c:b0:41b:f979:e19b with SMTP id
 5b1f17b1804b1-42156354bf2mr3566275e9.39.1717527975902; 
 Tue, 04 Jun 2024 12:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLiVd5yPSkOWa/vx0BNdG7irCuPKIAPteu5qGfNJGDptGsgBDi5QIFQqenEsSOSgWApwpZQ==
X-Received: by 2002:a05:600c:3d8c:b0:41b:f979:e19b with SMTP id
 5b1f17b1804b1-42156354bf2mr3566095e9.39.1717527975438; 
 Tue, 04 Jun 2024 12:06:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42148ae3262sm40513905e9.7.2024.06.04.12.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:14 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/46] virtio-pci: Fix the use of an uninitialized irqfd.
Message-ID: <7eeb62b0ce3a8f64647bf53f93903abd1fbb0b94.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The crash was reported in MAC OS and NixOS, here is the link for this bug
https://gitlab.com/qemu-project/qemu/-/issues/2334
https://gitlab.com/qemu-project/qemu/-/issues/2321

The root cause is that the function virtio_pci_set_guest_notifiers() only
initializes the irqfd when the use_guest_notifier_mask and guest_notifier_mask
are set.
However, this check is missing in virtio_pci_set_vector().
So the fix is to add this check.

This fix is verified in vyatta,MacOS,NixOS,fedora system.

The bt tree for this bug is:
Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7c817be006c0 (LWP 1269146)]
kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
817	    if (irqfd->users == 0) {
(gdb) thread apply all bt
...
Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497
3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/system/memory.c:573
4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528
5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qemu-9.0.0/system/physmem.c:2713
6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743
7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/physmem.c:2894
9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/physmem.c:2904
10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-thread-posix.c:541
13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6

Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20240522051042.985825-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b1d02f4b3d..a7faee5b33 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1431,6 +1431,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
 {
     bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
         msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     if (new_vector == old_vector) {
         return;
@@ -1441,7 +1442,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
      * set, we need to release the old vector and set up the new one.
      * Otherwise just need to set the new vector on the device.
      */
-    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
+    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR &&
+        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
         kvm_virtio_pci_vector_release_one(proxy, queue_no);
     }
     /* Set the new vector on the device. */
@@ -1451,7 +1453,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
         virtio_queue_set_vector(vdev, queue_no, new_vector);
     }
     /* If the new vector changed need to set it up. */
-    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
+    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR &&
+        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
         kvm_virtio_pci_vector_use_one(proxy, queue_no);
     }
 }
-- 
MST


