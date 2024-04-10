Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46A9CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaeD-0004bB-7w; Wed, 10 Apr 2024 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruaeB-0004b0-3z
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruae9-0004jd-4R
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712765879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTl4I1/beG1qqSkEoGZ5eFzz/E7L5AcMYMcsCMSkkuM=;
 b=OKPOW1LSQ7l+x1ZE9N2dYM4nqiSJAxztDKZ5AdAZ3fxheugV1nVMTnvhKN+UmAO9mBaTDV
 940VccvgMN6+ipxH2SzZ7biKj1gMSN63IQt0hUQBUbEWPS/agr3e0K7YcF1etNP621bPfn
 TOtDWjh+OQPpkFJNcI/zWgelXvdWdcU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-egEu-9rjPf6JL0fwV_2kZQ-1; Wed, 10 Apr 2024 12:17:57 -0400
X-MC-Unique: egEu-9rjPf6JL0fwV_2kZQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46852c2239so462532166b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765876; x=1713370676;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTl4I1/beG1qqSkEoGZ5eFzz/E7L5AcMYMcsCMSkkuM=;
 b=VdGDnGjE2ztmNPG0tAxwHfaqCIB7XRyelUaVjRPU3pEoXABfpc8L7WRLtrjnKk86Fy
 wVEE9VY9nAf0sjOCM+Fvalg2D/5mixNSdYx7YsH6ivgvW0UM4LlBB8ow+m4htQnygCF5
 uvJYUgUves6X8NlvxyIaEP3BdKp3qxOoskKE3H5wYO9qWAYPAHCPtwPIJ4wbwu+ame2o
 KL1Nn6ZSVzcuVzsL7Whu8GY4NJeL0Xyb26v6WuJF9Lo6K29fzfTb7yQpna9wjEv+UWOx
 taUkzEKb1vVGJrPUnjHGYwLZsrrCryFg0qhaRDfhCO5gkWmXWdEO/J5x8JCFUKamUOi5
 GoUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyyzd1ZFafCYSyuVxK0ola50vrE5fFY3sY6qUJRnlidFnLgnojGZcW++Ycj7y3zLPJsxx+FTK/YqjGIZJJNfKHuodl9Tk=
X-Gm-Message-State: AOJu0Yx4rP+wy64jceT8qTYnKx+vuY5wCNQktpu6Nnv2moupOCCp5VR+
 IU5MMBvL0PHAsKQ3iOYpBiG3iPCFJEruACsWJMo3/zikcIBOkiaEAkhg5RcBf1kciyYyH3oxH/S
 QfIqq/Vin259XJKFQamZj8a9RQm6KVq5pRs0fUbL7dygreGHy3t04
X-Received: by 2002:a17:906:34d9:b0:a51:bca7:3a96 with SMTP id
 h25-20020a17090634d900b00a51bca73a96mr2231580ejb.72.1712765875791; 
 Wed, 10 Apr 2024 09:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNoEI/fSx8ctsJYforStT6d6FwF1yz+NS8XqgTekvLFyQvU9X0VVLlmtDdlGJBrZ88Hy6TPA==
X-Received: by 2002:a17:906:34d9:b0:a51:bca7:3a96 with SMTP id
 h25-20020a17090634d900b00a51bca73a96mr2231562ejb.72.1712765875246; 
 Wed, 10 Apr 2024 09:17:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:47e9:fd17:db85:3d32:e452])
 by smtp.gmail.com with ESMTPSA id
 qb2-20020a1709077e8200b00a51c5c76023sm5107356ejc.194.2024.04.10.09.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 09:17:54 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:17:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] virtio-pci: Fix the crash that the vector was used
 after released.
Message-ID: <20240410121618-mutt-send-email-mst@kernel.org>
References: <20240410161203.437079-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410161203.437079-1-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

On Thu, Apr 11, 2024 at 12:12:00AM +0800, Cindy Lu wrote:
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
> 
> 1. vhost_net_stop() was triggered by guest image. This will call the function
> virtio_pci_set_guest_notifiers() with assgin= false,
> virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0
> 
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR
> 
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
> assgin=true, so the irqfd for vector 0 is still not "init" during this process
> 
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash
> 
> To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.
> 
> (gdb) bt
> 0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
>     at pthread_kill.c:44
> 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at pthread_kill.c:78
> 2  0x00007fc87143e956 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> 4  0x00007fc87142871b in __assert_fail_base
>     (fmt=0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=<optimized out>) at assert.c:92
> 5  0x00007fc871437536 in __GI___assert_fail
>     (assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=0x5606413f06f0 <__PRETTY_FUNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=0x560642cae1f0) at ../accel/kvm/kvm-all.c:1837
> 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
>     (proxy=0x560643c65f00, queue_no=4294967295, vector=0, msg=..., n=0x560643c6e4c8)
>     at ../hw/virtio/virtio-pci.c:1005
> 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=0x560643c65f00, vector=0, msg=...)
>     at ../hw/virtio/virtio-pci.c:1070
> 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=0x560643c65f00, vector=0, is_masked=false)
>     at ../hw/pci/msix.c:120
> 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=0x560643c65f00, vector=0, was_masked=true)
>     at ../hw/pci/msix.c:140
> 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=0x560643c65f00, addr=12, val=0, size=4)
>     at ../hw/pci/msix.c:231
> 12 0x0000560640f26d83 in memory_region_write_accessor
>     (mr=0x560643c66540, addr=12, value=0x7fc86b7bc628, size=4, shift=0, mask=4294967295, attrs=...)
>     at ../system/memory.c:497
> 13 0x0000560640f270a6 in access_with_adjusted_size
> 
>      (addr=12, value=0x7fc86b7bc628, size=4, access_size_min=1, access_size_max=4, access_fn=0x560640f26c8d <memory_region_write_accessor>, mr=0x560643c66540, attrs=...) at ../system/memory.c:573
> 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=0x560643c66540, addr=12, data=0, op=MO_32, attrs=...)
>     at ../system/memory.c:1521
> 15 0x0000560640f37bac in flatview_write_continue
>     (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., ptr=0x7fc871e9c028, len=4, addr1=12, l=4, mr=0x560643c66540)
>     at ../system/physmem.c:2714
> 16 0x0000560640f37d0f in flatview_write
>     (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4) at ../system/physmem.c:2756
> 17 0x0000560640f380bf in address_space_write
>     (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4)
>     at ../system/physmem.c:2863
> 18 0x0000560640f3812c in address_space_rw
>     (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4, is_write=true) at ../system/physmem.c:2873
> --Type <RET> for more, q to quit, c to continue without paging--
> 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=0x560642f205e0) at ../accel/kvm/kvm-all.c:2915
> 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=0x560642f205e0) at ../accel/kvm/kvm-accel-ops.c:51
> 21 0x00005606411949f4 in qemu_thread_start (args=0x560642f292b0) at ../util/qemu-thread-posix.c:541
> 22 0x00007fc87148cdcd in start_thread (arg=<optimized out>) at pthread_create.c:442
> 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> (gdb)
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..b3b1a4a66f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1570,7 +1570,22 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>          } else {
>              val = VIRTIO_NO_VECTOR;
>          }
> +        vector = vdev->config_vector;
>          vdev->config_vector = val;
> +        /*
> +         * If the value was changed after DRIVER_OK was set, it means that
> +         * we need to release the old vector and set up the new vector.
> +         */
> +        if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            /*check if use the irqfd*/
> +            (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled())) {
> +            if (val != VIRTIO_NO_VECTOR) {
> +                kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX);
> +            }
> +            if (vector != VIRTIO_NO_VECTOR) {
> +                kvm_virtio_pci_vector_release_one(proxy, VIRTIO_CONFIG_IRQ_IDX);
> +            }
> +        }
>          break;
>      case VIRTIO_PCI_COMMON_STATUS:
>          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1611,6 +1626,21 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>              val = VIRTIO_NO_VECTOR;
>          }
>          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +
> +        /*
> +         * If the value was changed after DRIVER_OK was set, it means that
> +         * we need to release the old vector and set up the new vector.
> +         */
> +        if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            /*check if use the irqfd*/

by comment style

> +            (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled())) {
> +            if (val != VIRTIO_NO_VECTOR) {
> +                kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel);
> +            }
> +            if (vector != VIRTIO_NO_VECTOR) {
> +                kvm_virtio_pci_vector_release_one(proxy, vdev->queue_sel);
> +            }

does it matter in which order to do this?
if we release 1st there's more of a chance use will succeeed.

I would also check val != vector
if value did not change there is nothing to do.

> +        }
>          break;
>      case VIRTIO_PCI_COMMON_Q_ENABLE:
>          if (val == 1) {
> -- 
> 2.43.0


