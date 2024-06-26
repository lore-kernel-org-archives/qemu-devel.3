Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECAC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNLb-0007uJ-Dw; Wed, 26 Jun 2024 03:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMNLY-0007rv-V8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMNLV-0006s8-Gs
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719387936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=myiQCo33L4kTVjGy1pMoitXOdG0PbHAgQfP1CC1LAws=;
 b=Su35a2Z/wIT14bt9yWiA5ao/aAGTKqPI0LCYJ9oKE30uWyVUqx8vE229ZuvlDliN/NdKGJ
 X2Wo3xmZUex/l0a6bllwW/gbExDLHd+NeE/Z6n4lXEmdZ0Awc+H8KdO6tUjwpG202QSy0o
 T/SiDBzyI/WR0/QL149SLyfFwdz8Ti0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-rLBoiTrOOuyPuSh9ORRvHQ-1; Wed, 26 Jun 2024 03:44:54 -0400
X-MC-Unique: rLBoiTrOOuyPuSh9ORRvHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4218447b900so1701295e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 00:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719387893; x=1719992693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myiQCo33L4kTVjGy1pMoitXOdG0PbHAgQfP1CC1LAws=;
 b=uLDZpi52VBN5lgX9zq5OPT6PikS1xoqABeg7IVRUgA2mlw85pbyjeR3HbppZHOyrrL
 TTtb0zujQJ0YcV4o6teCnH3819GA9hgh/r7E/m64phDFmUTlxAywxiNhMgtKKSfmR11G
 OY4BIponGRIVrcAg2+C6aff1blsoGqEOscC2QIJDF4z4zZtVFDQX7ML/un69Jrikuq5s
 u+TWCMyingoYEnQy0JOmPqwdguqHFeuG/5dp0atErPjFphrQAV9KqZxUyZjiDO0DG/jT
 OXyRbUtMeDhMjZQcU/7DL/c6xKzyi62o+N0hNf8zCca4MG6oruOlubd8OY80/Dk/AMbo
 FpZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYKD+zrEcSbey7HMaMZgepftgtAoma9Ohj0qm/YPUPFjps0SeBdgIR0/Sf6qJAuAFK3UTa+3lh6jVDOc//ES0An2tAVzo=
X-Gm-Message-State: AOJu0YzEVSBfd/eOa4nkH8dcaRJI9LBx0rVOYi7/rgxl/KOZrrafCKph
 P37VW4MvzuVWrrLhk5/NONIX/5wPUEiS4+oprk1o1Gg9EwBf+VBFMNmx43DGWtH+P4+ojECaG63
 4T9yMfyieWIR552tddzHC8Q3ykIpO5lt1KqlUDO2gsSHb3Ds6dBnibI0vNnZ8PZw=
X-Received: by 2002:a05:600c:33a7:b0:424:ac5a:fc38 with SMTP id
 5b1f17b1804b1-424ac5afe1amr15702475e9.13.1719387892784; 
 Wed, 26 Jun 2024 00:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcPjUo2q/KEiZGzY8qk1LeWoe/RcDrk7EBk8f1qlTcH8gbIOehLm8FKB3waiscr8h0KPV9Qw==
X-Received: by 2002:a05:600c:33a7:b0:424:ac5a:fc38 with SMTP id
 5b1f17b1804b1-424ac5afe1amr15702115e9.13.1719387892027; 
 Wed, 26 Jun 2024 00:44:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8266ae7sm14761185e9.20.2024.06.26.00.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 00:44:51 -0700 (PDT)
Date: Wed, 26 Jun 2024 03:44:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] virtio-pci: Fix the use of an uninitialized irqfd
Message-ID: <20240626033920-mutt-send-email-mst@kernel.org>
References: <20240626024434.10523-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626024434.10523-1-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 26, 2024 at 10:44:31AM +0800, Cindy Lu wrote:
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
> 
> The root cause is the function virtio_pci_set_guest_notifiers() was not called
> in the virtio_input device.So the vector_irqfd was not initialized
> 
> So the fix is add the check for vector_irqfd.
> 
> Change in V3

Changelog belongs after --- 

> 1) Move the vector_irqfd check to virtio_pci_get_notifier().
> The function virtio_pci_get_notifier() can also be used while vdev->status
> is not VIRTIO_CONFIG_S_DRIVER_OK. In that case, the vector_irqfd could be NULL,
> so also add the status check here.
> 2) Add the return value check for kvm_virtio_pci_vector_use_one().
> Since the return value of function virtio_pci_set_vector() is void,
> just add the error message here.
> 
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
> 
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 817         if (irqfd->users == 0) {
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
> 

all trailers including s.o.b. should be together, with no empty lines

> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b1d02f4b3d..87307b9061 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -860,6 +860,11 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>      VirtQueue *vq;
>  
> +    if ((proxy->vector_irqfd == NULL) &&

Preferable:
	if (!proxy->vector_irqfd &&

and brackets not really needed here


> +        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {

brackets not really needed here

> +        return -1;
> +    }
> +
>      if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
>          *n = virtio_config_get_guest_notifier(vdev);
>          *vector = vdev->config_vector;
> @@ -1452,7 +1457,9 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>      }
>      /* If the new vector changed need to set it up. */
>      if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> -        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +        if (kvm_virtio_pci_vector_use_one(proxy, queue_no)) {
> +            virtio_error(vdev, "fail to set the vector %d", new_vector);
> +        }
>      }
>  }


Is this an unrelated fix?

>  
> -- 
> 2.45.0


