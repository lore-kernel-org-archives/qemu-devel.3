Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B6E8B368
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 21:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnOEV-0006iD-Ci; Tue, 03 Feb 2026 16:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnOET-0006hv-3a
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnOER-0001w9-8A
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770155205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xo0UBSMKiKA6GyuwC2w3N3wU2m4EHy1rXG4imWHslxc=;
 b=bphVExuBUWyQCgZ7SLBNIVrMiEqblMvnmJnfn7oOrxKBC46lggiCcAQ9JmaqBwWU/v31FM
 GbJvSxg40ebLEe4yAz7Ds1dSFkb1NDVkdc/SAP485vGn60dIwAkzq781196s4rdlWp39zB
 jZEIw79/+PT08JZ4mczPKFRols9Tsro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-kDO0KCg8NImKegVbAHLSfw-1; Tue, 03 Feb 2026 16:46:44 -0500
X-MC-Unique: kDO0KCg8NImKegVbAHLSfw-1
X-Mimecast-MFC-AGG-ID: kDO0KCg8NImKegVbAHLSfw_1770155203
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so33259395e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770155203; x=1770760003; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xo0UBSMKiKA6GyuwC2w3N3wU2m4EHy1rXG4imWHslxc=;
 b=dG80byuihnJms8c3Je2OWvvShuP3DTpuoNnqAf+WnP2vTHsAlD2Fwum5L8BSoJInSD
 nok5JXJ1VRtwofvDs6DGj6F1uPDlFrGrnm4FhOGwF6on103yLc1trPvthY7yUBCFVlN6
 dqZ3d5wOPmfF+kBzTrtaBnGRNoA/B9lWrK7YG5Tj0MoXuiwOBT3frvt4RkW89xbKECVB
 aBK8HoYqlryYGd7z/t/e3R2N/qfy0yDJGJ9V2McP9vxBEl2lpdvHJLdmkF4oc5I5UXp2
 kFo/SfTXqB6jFeAy5W2hK+oNZQ3RbgqNmtRn/bzy+DiGj+MRZS/WlMUe51egp6Bb++Mm
 KHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770155203; x=1770760003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xo0UBSMKiKA6GyuwC2w3N3wU2m4EHy1rXG4imWHslxc=;
 b=E0frO3SJI2muaf29GzJQi+3kXOHPDKqUxxv3UjtPhc37BNIRxf3lMhs0mXBl27lx4O
 8OSBBDqzg6ySZBHz83zz+m6XKpmKDtt9Mo2Yw27IOzijZEKZe6dTLDuhsVq5Az7bgZuS
 6T7LhIGFAoHO1fDbb1x+PJ1AKDtPmhi8MuwmnN7OMXD5yVPblNKQNEyvnUwnF69dPY1X
 atCpKtW0+kB+XGrs69Sl+pKz/edk7Wa3Upp0LreZgGKKgyo4kJOpYIMv8dFUlsZwWaNb
 TdeQXG9+MYmvnYOFlJGn2M+Dm8n3F8EkBvuQyz5jqjIwRGQ61is8HHECVQsDiBUI1tSd
 wvpQ==
X-Gm-Message-State: AOJu0YyH92hlYsGrCVIhetCmy+ziJ7bMEdnXs1Ku5+mJ/m01KzZdcGRc
 l4BdZGtyZm8yIvZmniyTrH7Div4tHokOcu0+Z0uEVBl7ZcrPcr5kQCiHj6mJa0ow97i8/kl2F96
 Os2xyxlkuqnpBVQCD3cRfG4DU6NGb9wl6XYFxNFk3gKzX0rbOhozgYK0t
X-Gm-Gg: AZuq6aJRNsaiwYbNtr+zf8gTjLzPbj8y/PVo1LttfzqQrIP6Px8iJhdrzQ3jBFTUst3
 0LQtlxtnTArpn+AA05cZwAHU8XSasM1ghUXK8KYkasFBq3tTaEM0oFKclTnUG+M0nxJFes8PGS1
 JdzC+0Ej0g53NUclDtSzhMDGqhP+qDl2tJqzsz3WwTqVEbTEz0NfBUUbmQXt6xYEpc+nHK5Sa3z
 Z5WA1gJ8kVZruALjf72O4rR2+J9qNxOelX1Idaf00QTHMOjEB3kWEoApYMFabHBRwqdPrBUr+SM
 Hra/Uxd0JSrm7YBYwYQXyOPGFCqbic0SsaQZ0xxRL5T8o/5p8glIY/63olUXWnsbbs4mnflR74R
 FRgC8bvJ28HArZIu115Q8r8zm4qYAmR6l5Q==
X-Received: by 2002:a05:600c:8b30:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4830e96d513mr12622875e9.23.1770155202943; 
 Tue, 03 Feb 2026 13:46:42 -0800 (PST)
X-Received: by 2002:a05:600c:8b30:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4830e96d513mr12622615e9.23.1770155202451; 
 Tue, 03 Feb 2026 13:46:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512e0edsm93061205e9.7.2026.02.03.13.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:46:41 -0800 (PST)
Date: Tue, 3 Feb 2026 16:46:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com,
 manos.pitsidianakis@linaro.org, slp@redhat.com, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v11 7/7] vhost-user-device: Add shared memory BAR
Message-ID: <20260203164542-mutt-send-email-mst@kernel.org>
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111091058.879669-8-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 11, 2025 at 10:10:58AM +0100, Albert Esteve wrote:
> Add shared memory BAR support to vhost-user-device-pci
> to enable direct file mapping for VIRTIO Shared
> Memory Regions.
> 
> The implementation creates a consolidated shared
> memory BAR that contains all VIRTIO Shared
> Memory Regions as subregions. Each region is
> configured with its proper shmid, size, and
> offset within the BAR. The number and size of
> regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> message sent by vhost-user-base during realization
> after virtio_init().
> 
> Specifiically, it uses BAR 3 to avoid conflicts, as
> it is currently unused.
> 
> The shared memory BAR is only created when the
> backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> has configured shared memory regions. This maintains
> backward compatibility with backends that do not
> support shared memory functionality.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user-base.c            | 47 ++++++++++++++++++++++++--
>  hw/virtio/vhost-user-test-device-pci.c | 39 +++++++++++++++++++--
>  2 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index ff67a020b4..82f49500e4 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -16,6 +16,7 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/vhost-user-base.h"
>  #include "qemu/error-report.h"
> +#include "migration/blocker.h"
>  
>  static void vub_start(VirtIODevice *vdev)
>  {
> @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBase *vub = VHOST_USER_BASE(dev);
> -    int ret;
> +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> +    g_autofree char *name = NULL;

This add a local variable "name" ...

> +    int i, ret, nregions, regions_processed = 0;
>  
>      if (!vub->chardev.chr) {
>          error_setg(errp, "vhost-user-base: missing chardev");
> @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>  
>      /* Allocate queues */
>      vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
> -    for (int i = 0; i < vub->num_vqs; i++) {
> +    for (i = 0; i < vub->num_vqs; i++) {
>          g_ptr_array_add(vub->vqs,
>                          virtio_add_queue(vdev, vub->vq_size,
>                                           vub_handle_output));
> @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>                           VHOST_BACKEND_TYPE_USER, 0, errp);
>  
>      if (ret < 0) {
> -        do_vhost_user_cleanup(vdev, vub);
> +        goto err;
> +    }
> +
> +    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
> +                                                           &nregions,
> +                                                           memory_sizes,
> +                                                           errp);
> +
> +    if (ret < 0) {
> +        goto err;
> +    }
> +
> +    for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
> +        if (memory_sizes[i]) {
> +            regions_processed++;
> +            if (vub->vhost_dev.migration_blocker == NULL) {
> +                error_setg(&vub->vhost_dev.migration_blocker,
> +                       "Migration disabled: devices with VIRTIO Shared Memory "
> +                       "Regions do not support migration yet.");
> +                ret = migrate_add_blocker_normal(
> +                    &vub->vhost_dev.migration_blocker,
> +                    errp);
> +
> +                if (ret < 0) {
> +                    goto err;
> +                }
> +            }
> +
> +            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
> +                error_setg(errp, "Shared memory %d size must be a power of 2 "
> +                                 "no smaller than the page size", i);
> +                goto err;
> +            }
> +
> +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
> +        }
>      }
>  
>      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
>                               dev, NULL, true);
> +    return;
> +err:
> +    do_vhost_user_cleanup(vdev, vub);
>  }
>  

which is never used.

this results in a build error:

https://gitlab.com/mstredhat/qemu/-/jobs/12974866799




>  static void vub_device_unrealize(DeviceState *dev)
> diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
> index b4ed0efb50..d010cb3205 100644
> --- a/hw/virtio/vhost-user-test-device-pci.c
> +++ b/hw/virtio/vhost-user-test-device-pci.c
> @@ -8,14 +8,18 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/vhost-user-base.h"
>  #include "hw/virtio/virtio-pci.h"
>  
> +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 4
> +
>  struct VHostUserDevicePCI {
>      VirtIOPCIProxy parent_obj;
>  
>      VHostUserBase vub;
> +    MemoryRegion shmembar;
>  };
>  
>  #define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base"
> @@ -25,10 +29,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev = DEVICE(&dev->vub);
> +    DeviceState *dev_state = DEVICE(&dev->vub);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
> +    VirtioSharedMemory *shmem, *next;
> +    uint64_t offset = 0, shmem_size = 0;
>  
> +    vpci_dev->modern_mem_bar_idx = 2;
>      vpci_dev->nvectors = 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +        if (shmem->mr.size > UINT64_MAX - shmem_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        shmem_size = shmem_size + shmem->mr.size;
> +    }
> +    if (shmem_size) {
> +        if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
> +            error_setg(errp, "modern-pio-notify is not supported due to PCI BAR layout limitations");
> +            return;
> +        }
> +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-shmembar", shmem_size);
> +        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +            memory_region_add_subregion(&dev->shmembar, offset, &shmem->mr);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                                   offset, shmem->mr.size, shmem->shmid);
> +            offset = offset + shmem->mr.size;
> +        }
> +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                        &dev->shmembar);
> +    }
>  }
>  
>  static void vhost_user_device_pci_class_init(ObjectClass *klass,
> -- 
> 2.49.0


