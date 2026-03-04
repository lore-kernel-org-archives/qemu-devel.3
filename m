Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761E1EF8FE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmFB-00080a-BU; Wed, 04 Mar 2026 08:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxmF4-0007ph-NN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxmF1-00028W-8N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772630776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbGRTxsnC4Qo/ve0Mm1ICfb+uW/E6lI+zpOLAUNxUhA=;
 b=RNoajOfsnEVFsOjYJjLq/lyBlBbXiHvsJilqEFX6Py7hz0k4vYwZx5gz7YZDdT+k+HPvjv
 KB9zVbz6FAjC5M4HdJT1V1v3ioqwVF2N+ibCuNAupMHff/p+zIZwnQs0WVisGComHXqBi+
 cpO0ctubFIFOooeVezUsmJ/Jn98UZzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-VdbreKghOWeUNoqWsNuNXg-1; Wed, 04 Mar 2026 08:26:15 -0500
X-MC-Unique: VdbreKghOWeUNoqWsNuNXg-1
X-Mimecast-MFC-AGG-ID: VdbreKghOWeUNoqWsNuNXg_1772630774
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so53480335e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772630774; x=1773235574; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kbGRTxsnC4Qo/ve0Mm1ICfb+uW/E6lI+zpOLAUNxUhA=;
 b=qD7+FEPjCViYOyrC1kYTH80KqusBaZgpy4GD6NF6nlL1LIcXT8FfeAh6nTjpzjso6F
 tK9RotyEzndhGwyquiR7uHy14tMsOxSaWbrqhNlFrSDX5nK6rxz74DvwvdD6pxUPb1Yk
 CSq03sgygToVTz5Nq9UfpFUseivPBMT80VtME9ipUsSkDjxuBxELEiikKpGspt068yuL
 k0xH8H6poqJmTCJFE3n6nfCbJ33FgRSLtOEoAUPuHAzqYr9Q03BI2A+yD7PVJ9wXUNFX
 /Lj0laIr+z9G+X2KxiFZdhVPBVd9p4GPdu3C6c/8M01acD+zhzflXjH3kgDEgjBMh1UN
 1/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630774; x=1773235574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbGRTxsnC4Qo/ve0Mm1ICfb+uW/E6lI+zpOLAUNxUhA=;
 b=ewHtM2XTGo/gI4RMOBJa9vuzXCAJNgC5LxZ3iqDWaDvPT8TkyDBPP/N14PG6aR93kV
 TN/o0wMM9MMBvbX9Eg6Ru3Reg+8MmWxddCG0/BsyGH2rBkfmOj3/h2IhYb8U6nhKc1FS
 8EyHIXd9j7xaR6IrJ40aUH4nF78kOXYbeMm/wx0xYlaEC9MYpzG2d266GSIgfyVpNyqk
 cwLK7qGYMJ/Nw9cXkVP1p9VYKQEQd3BRm9G93smGd1hpAcDMRVQx1l2YHZtYMaLB6qJS
 BIUywtNPJmhxUkXhdzA/3+W/zxuKijeqB9f88BrtRlc/Y93sF0vosVO1BEuuOD/2T3tc
 4ySQ==
X-Gm-Message-State: AOJu0YxY9DEakwEaesKIDssHu4+fUeATtTo1mRGubi6dmQBYGhdatdh9
 hPdvVcL59PkfEZvOlCgc90GXeKuVMW/NXMYk4PMgeyMPIKN3BXwtv3eF6Jf8KCY6+X6ExWnLmwY
 O8zPgTNMWT+Vk+3Xuv4kPB9aHCTCFh0IXAFHi0h1Cs8tEIYhgOlaJWss/
X-Gm-Gg: ATEYQzyn4c9zYByeGWwxPO3RL+PtQEHcj8jgV5g8aguDqdC3K5g1xqMiKdWcbLufkFS
 EP+Czf2wECsxwTFMjckDwqVg5zDqd9C6exFUIqlrK59verWer6TSyeR8fIKnH94dK59IWkBSH1i
 Hq+Zfwndg4Qw2Nz+gBD7eKH7v89NKnogX/S/kXnwvgyIqLyuUBbcRJ26/pxyhfcm3wqxf6kDPGx
 p8dDbhHp7Uiv11usXoWaeiw6Kzr8nhaG4oTl9qw2UG2NA3lSbt7F1Abe9h49wIHslrn0n8sukzU
 yWNd3zU8h4oOwqdZh3ih6dwjFdXgKA67s1yx2mXsY4p6a7+X2WIcFbUGjk14xjNfp3ubG/oKJx2
 QogBzUekGWkHPSMC73S2VP6++1F6pajVExn6SRPmGVIFxdBFdZVWEJ/7z7cNut0MggIFwvOE=
X-Received: by 2002:a05:600c:c4a5:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-48519826fadmr33825805e9.5.1772630774216; 
 Wed, 04 Mar 2026 05:26:14 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-48519826fadmr33825245e9.5.1772630773707; 
 Wed, 04 Mar 2026 05:26:13 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c2ef2sm53639885e9.5.2026.03.04.05.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:26:13 -0800 (PST)
Date: Wed, 4 Mar 2026 14:26:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 7/7] vhost-user-device: Add shared memory BAR
Message-ID: <aagv94qy56VjyNba@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-8-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 02:03:34PM +0100, Albert Esteve wrote:
>Add shared memory BAR support to vhost-user-device-pci
>to enable direct file mapping for VIRTIO Shared
>Memory Regions.
>
>The implementation creates a consolidated shared
>memory BAR that contains all VIRTIO Shared
>Memory Regions as subregions. Each region is
>configured with its proper shmid, size, and
>offset within the BAR. The number and size of
>regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
>message sent by vhost-user-base during realization
>after virtio_init().
>
>Specifiically, it uses BAR 3 to avoid conflicts, as

nit: s/Specifiically/Specifically

Discussed offline, this should be BAR 4 IIUC.

>it is currently unused.
>
>The shared memory BAR is only created when the
>backend supports VHOST_USER_PROTOCOL_F_SHMEM and
>has configured shared memory regions. This maintains
>backward compatibility with backends that do not
>support shared memory functionality.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user-base.c            | 46 ++++++++++++++++++++++++--
> hw/virtio/vhost-user-test-device-pci.c | 38 +++++++++++++++++++--
> 2 files changed, 79 insertions(+), 5 deletions(-)
>
>diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
>index 01ab9ca56b..e5e8abae96 100644
>--- a/hw/virtio/vhost-user-base.c
>+++ b/hw/virtio/vhost-user-base.c
>@@ -16,6 +16,7 @@
> #include "hw/virtio/virtio-bus.h"
> #include "hw/virtio/vhost-user-base.h"
> #include "qemu/error-report.h"
>+#include "migration/blocker.h"
>
> static void vub_start(VirtIODevice *vdev)
>{
>@@ -276,7 +277,8 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostUserBase *vub = VHOST_USER_BASE(dev);
>-    int ret;
>+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
>+    int i, ret, nregions, regions_processed = 0;
>
>     if (!vub->chardev.chr) {
>         error_setg(errp, "vhost-user-base: missing chardev");
>@@ -319,7 +321,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>
>     /* Allocate queues */
>     vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
>-    for (int i = 0; i < vub->num_vqs; i++) {
>+    for (i = 0; i < vub->num_vqs; i++) {
>         g_ptr_array_add(vub->vqs,
>                         virtio_add_queue(vdev, vub->vq_size,
>                                          vub_handle_output));
>@@ -333,11 +335,49 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>                          VHOST_BACKEND_TYPE_USER, 0, errp);
>
>     if (ret < 0) {
>-        do_vhost_user_cleanup(vdev, vub);
>+        goto err;
>+    }
>+
>+    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
>+                                                           &nregions,
>+                                                           memory_sizes,
>+                                                           errp);
>+
>+    if (ret < 0) {
>+        goto err;
>+    }
>+
>+    for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
>+        if (memory_sizes[i]) {
>+            regions_processed++;
>+            if (vub->vhost_dev.migration_blocker == NULL) {
>+                error_setg(&vub->vhost_dev.migration_blocker,
>+                       "Migration disabled: devices with VIRTIO Shared Memory "
>+                       "Regions do not support migration yet.");
>+                ret = migrate_add_blocker_normal(
>+                    &vub->vhost_dev.migration_blocker,
>+                    errp);
>+
>+                if (ret < 0) {
>+                    goto err;
>+                }
>+            }
>+
>+            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
>+                error_setg(errp, "Shared memory %d size must be a power of 2 "
>+                                 "no smaller than the page size", i);

Is this error message updated?

>+                goto err;
>+            }
>+
>+            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
>+        }
>     }
>
>     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
>                              dev, NULL, true);
>+    return;
>+err:
>+    do_vhost_user_cleanup(vdev, vub);
> }
>
> static void vub_device_unrealize(DeviceState *dev)
>diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
>index 7f6d751690..22678e3277 100644
>--- a/hw/virtio/vhost-user-test-device-pci.c
>+++ b/hw/virtio/vhost-user-test-device-pci.c
>@@ -12,10 +12,13 @@
> #include "hw/virtio/vhost-user-base.h"
> #include "hw/virtio/virtio-pci.h"
>
>+#define VIRTIO_DEVICE_PCI_SHMEM_BAR 4
>+
> struct VHostUserDevicePCI {
>     VirtIOPCIProxy parent_obj;
>
>     VHostUserBase vub;
>+    MemoryRegion shmembar;
> };
>
> #define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base"
>@@ -25,10 +28,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
> static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> {
>     VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
>-    DeviceState *vdev = DEVICE(&dev->vub);
>+    DeviceState *dev_state = DEVICE(&dev->vub);
>+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
>+    VirtioSharedMemory *shmem, *next;
>+    uint64_t offset = 0, shmem_size = 0;
>

I'd add a comment here to explain this since it's not immediately clear 
IMHO.

>+    vpci_dev->modern_mem_bar_idx = 2;
>     vpci_dev->nvectors = 1;
>-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);

IIUC before this patch qdev_realize() was the last step in this 
function, so we didn't check for any error, but now should we return 
earlier if it fails?

>+
>+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {

Is QSIMPLEQ_FOREACH_SAFE really needed here? IIUC we are not modifying 
the list, so can we use QSIMPLEQ_FOREACH ?

>+        if (shmem->mr.size > UINT64_MAX - shmem_size) {

Same here about using memory_region_size().

>+            error_setg(errp, "Total shared memory required overflow");
>+            return;
>+        }
>+        shmem_size = shmem_size + shmem->mr.size;

Ditto about memory_region_size().

>+    }
>+    if (shmem_size) {
>+        if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
>+            error_setg(errp, "modern-pio-notify is not supported due to PCI BAR layout limitations");
>+            return;
>+        }
>+        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
>+                           "vhost-device-pci-shmembar", shmem_size);
>+        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {

Ditto about QSIMPLEQ_FOREACH_SAFE.

BTW my comments can eventually be fixed with a followup, overall LGTM,
but if you need to resend, maybe we can fix them now.

In any case:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


>+            memory_region_add_subregion(&dev->shmembar, offset, &shmem->mr);
>+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
>+                                   offset, shmem->mr.size, shmem->shmid);
>+            offset = offset + shmem->mr.size;
>+        }
>+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
>+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
>+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
>+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
>+                        &dev->shmembar);
>+    }
> }
>
> static void vhost_user_device_pci_class_init(ObjectClass *klass,
>-- 
>2.52.0
>


