Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BDC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl45-0003ad-Dl; Wed, 05 Jun 2024 03:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEl44-0003Zx-DR
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEl41-0004zS-VO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WooXAGoCQQ46i+gPHkPjGL/ApJ6Fvrl9BtL/NVdx8o=;
 b=WkIvNFqUN2q5583FRQko5la6owe/u2fotHNdjjYbq2Pjka4TOPpxrGaIGJEGgTdrHHLmTD
 7v5LnNb6WUk7w6VEVuEujw5+xqnpPgZvIuN/CmP+mJI7+P3rtJGNeE2cw3524rKgFAGbtz
 5nSNd2PXl7X+zNLt5x1xjZvTRSbPOdQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-kpEdPCXGMfeXFffeyBOytw-1; Wed, 05 Jun 2024 03:28:04 -0400
X-MC-Unique: kpEdPCXGMfeXFffeyBOytw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68c5f8f523so168698066b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572482; x=1718177282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WooXAGoCQQ46i+gPHkPjGL/ApJ6Fvrl9BtL/NVdx8o=;
 b=CJZHUGK459f2bNmP+8JL3GawHeFttWHB9vcg88o9LblU8S9aj1TgD+jS/EGsmPD+dY
 DfeTXNxJgcstvsIf7+xSjqS1e+Vz3mRb2NaMI4vBhlx9Qbom12pOD42AEcLlxdKmZ9c2
 K3hgaxKgXJ51SKZJNKPbC46/K6t/h3TpQMQi6Sp8tFBRD/rPxech6BodM/IujFP3v9E3
 z14UHyMy77dpU7k4csORn9GaILsYsELOb6LFMgMcX2lFR4QbluYK0w9ALyc0PlewY+pM
 iNr0IckJnm7qQ80LPtixsBQc90U1JGK4BGR+qGUXmGXUoTED7fz6UD/37HD4HzfVBD4u
 EjdQ==
X-Gm-Message-State: AOJu0YwC9l3DRMxqK/bu8zVbA9LqEzE0ZOgqzgShKUNKriRgTP2ki5dT
 LLfkVazR8M9jbbBEIE95TWZMCZ/9yaVMvOom8rW4LL1smv5ae8VpRnX4jjRK0k2JBVFd1xv8iHM
 p0lu7cvHUPnLCSnfCnFqRm0jaiW+sZt24ogz/MWdvzV7LFKwxIhXk9oiWYi/3PxXrou/SMTDhXF
 RmM+TnLKBh7jJsFZlHMl1q22pzuv5e5g==
X-Received: by 2002:a17:906:9e1e:b0:a67:eec:91cf with SMTP id
 a640c23a62f3a-a69a00109d0mr99284866b.50.1717572481634; 
 Wed, 05 Jun 2024 00:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSsTydf7LTHcDFy3+LQIkm+BP5/CtTPGGlOa+puPfXjQzsKhTLdpo8cxV2UPorU3Mvu4IIWw==
X-Received: by 2002:a17:906:9e1e:b0:a67:eec:91cf with SMTP id
 a640c23a62f3a-a69a00109d0mr99282666b.50.1717572481086; 
 Wed, 05 Jun 2024 00:28:01 -0700 (PDT)
Received: from redhat.com ([2.55.8.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f4191cfdsm475576266b.137.2024.06.05.00.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:28:00 -0700 (PDT)
Date: Wed, 5 Jun 2024 03:27:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 04/46] virtio-pci: Fix the use of an uninitialized irqfd.
Message-ID: <20240605032741-mutt-send-email-mst@kernel.org>
References: <cover.1717527933.git.mst@redhat.com>
 <7eeb62b0ce3a8f64647bf53f93903abd1fbb0b94.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eeb62b0ce3a8f64647bf53f93903abd1fbb0b94.1717527933.git.mst@redhat.com>
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

On Tue, Jun 04, 2024 at 03:06:15PM -0400, Michael S. Tsirkin wrote:
> From: Cindy Lu <lulu@redhat.com>
> 
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
> 
> The root cause is that the function virtio_pci_set_guest_notifiers() only
> initializes the irqfd when the use_guest_notifier_mask and guest_notifier_mask
> are set.
> However, this check is missing in virtio_pci_set_vector().
> So the fix is to add this check.
> 
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
> 
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 817	    if (irqfd->users == 0) {
> (gdb) thread apply all bt
> ...
> Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
> 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497
> 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/system/memory.c:573
> 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528
> 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qemu-9.0.0/system/physmem.c:2713
> 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743
> 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/physmem.c:2894
> 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/physmem.c:2904
> 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
> 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-thread-posix.c:541
> 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> 
> Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> Message-Id: <20240522051042.985825-1-lulu@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Dropped now at author's request.

> ---
>  hw/virtio/virtio-pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b1d02f4b3d..a7faee5b33 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1431,6 +1431,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>  {
>      bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>          msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>  
>      if (new_vector == old_vector) {
>          return;
> @@ -1441,7 +1442,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>       * set, we need to release the old vector and set up the new one.
>       * Otherwise just need to set the new vector on the device.
>       */
> -    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
> +    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR &&
> +        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>          kvm_virtio_pci_vector_release_one(proxy, queue_no);
>      }
>      /* Set the new vector on the device. */
> @@ -1451,7 +1453,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>          virtio_queue_set_vector(vdev, queue_no, new_vector);
>      }
>      /* If the new vector changed need to set it up. */
> -    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> +    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR &&
> +        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>          kvm_virtio_pci_vector_use_one(proxy, queue_no);
>      }
>  }
> -- 
> MST
> 


