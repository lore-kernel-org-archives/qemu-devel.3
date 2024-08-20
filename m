Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770A5C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMcF-0005mD-Ry; Tue, 20 Aug 2024 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMcA-0005WS-Rg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc9-0000Pr-1H
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724151683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXVdVyAGLa6m6oolnKsdCGWtNqK/VAT91pUhfTnctK0=;
 b=XI5v4r2eOE6ZCe0f10m1esTqBbpk+NIC+fb0TQgflC1W6XMGEc6AadHd/OnqiJbrzOqTZT
 mlClrRItkUg09iUvuF53jVQPohgLzeASJly22VinRaHjyLSm4cns2Zupuw2VycPJ6XyJX8
 hPES8+j+i+uW78H2md1t9Kbbj2Cnksc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-9v1OeKdfP8eMTny2X06Rzg-1; Tue, 20 Aug 2024 07:01:20 -0400
X-MC-Unique: 9v1OeKdfP8eMTny2X06Rzg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42816096cb8so58647465e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151679; x=1724756479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXVdVyAGLa6m6oolnKsdCGWtNqK/VAT91pUhfTnctK0=;
 b=VCQre+J+AaCuK01pcZe/eHNlm7a6qekn7ADeZUV9WInF1uYvNfzTL/PAH6/G1tw294
 hHPDifV/MqmgVetuZvUz1J4y3tBw5UR+nmJkl580EgqeNByB4nRWuaJ2q0jbjynDh+hs
 lllLY1Ii644jEtNzFMaEbJZ1tOHJiYmkppcDfgMG76bLrc7C845uDdH6l6eIgCI78I9l
 gso8CPTcL2G4qyUhFQm570kFB5uxRsSXsybLE1eoIWh1hScLsYZaTK8peLxBYqUcqGhb
 qiBt6HPiY32lg9PJUYpcW1qTmRqdhkvWsO6m//t3yRdH/fE2zKcIFnOCMkhCimwioSh+
 K8SA==
X-Gm-Message-State: AOJu0YxeRr38WAfG7ogCMRYYgDk3Ct0wwXPON8cDaDPI/J2Vt4yRB1jt
 kqRce0w3CILW0mnRd084CQgGokmNX38Uc8k5VRupt6RU9uHeIipmmdFwnrQ47copaS/1wqKt52c
 LhroRmKJTKtioNnvsSg+9P+2JcoOeTZZkA6dgCFR2NzLHVTFsIg9Ri7n6ZZEzWTaHpOwSbKRhFE
 3ps5P2TNPRylU0vLZEEAyB8kUGrolW9Q==
X-Received: by 2002:a05:600c:3b26:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-429ed7b6a3dmr112492855e9.17.1724151678758; 
 Tue, 20 Aug 2024 04:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/KtJuUwNEGgINW/7Jup2pqo+f2cuHHb3G2IuTpk3BqEtCYJkfav5HqvdgXLHBtY31zlXnDw==
X-Received: by 2002:a05:600c:3b26:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-429ed7b6a3dmr112492235e9.17.1724151677870; 
 Tue, 20 Aug 2024 04:01:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189839f5csm12977995f8f.7.2024.08.20.04.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 04:01:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:01:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/3] virtio-pci: Fix the use of an uninitialized irqfd
Message-ID: <a8e63ff289d137197ad7a701a587cc432872d798.1724151593.git.mst@redhat.com>
References: <cover.1724151593.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724151593.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In this bug, they are using the virtio_input device. The guest notifier was
not supported for this device, The function virtio_pci_set_guest_notifiers()
was not called, and the vector_irqfd was not initialized.

So the fix is adding the check for vector_irqfd in virtio_pci_get_notifier()

The function virtio_pci_get_notifier() can be used in various devices.
It could also be called when VIRTIO_CONFIG_S_DRIVER_OK is not set. In this situation,
the vector_irqfd being NULL is acceptable. We can allow the device continue to boot

If the vector_irqfd still hasn't been initialized after VIRTIO_CONFIG_S_DRIVER_OK
is set, it means that the function set_guest_notifiers was not called before the
driver started. This indicates that the device is not using the notifier.
At this point, we will let the check fail.

This fix is verified in vyatta,MacOS,NixOS,fedora system.

The bt tree for this bug is:
Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7c817be006c0 (LWP 1269146)]
kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
817         if (irqfd->users == 0) {
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
Message-Id: <20240806093715.65105-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba..524b63e5c7 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -866,6 +866,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtQueue *vq;
 
+    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
+        return -1;
+
     if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
         *n = virtio_config_get_guest_notifier(vdev);
         *vector = vdev->config_vector;
-- 
MST


