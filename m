Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D9EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 08:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMkuw-0007Oj-Ho; Thu, 27 Jun 2024 04:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMkuu-0007My-E4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMkus-0007QT-MW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719478541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLklVkd6cVubAoDtHyrcTfSs5xhhdS/jjcxhfVvbzVY=;
 b=OwOSzETcmR4UJGikM5XsiR4lhfF3p5Mw6wtcMq1G91YBRxaD0FnSLXXOjJIwrQuYa2Lju9
 xbi17/TZQBpdVcTh+nknWPjeMDfKcnOgLxwOgM9l3QDryGdAOSJIgGg76JbVmdiyTWS7ll
 iwm3urqx4r/MP/41pwryj08isvESljQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-qA4NRb3BNOWBKT_5x7AANA-1; Thu, 27 Jun 2024 04:55:34 -0400
X-MC-Unique: qA4NRb3BNOWBKT_5x7AANA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57d0fffcb0dso664055a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719478533; x=1720083333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLklVkd6cVubAoDtHyrcTfSs5xhhdS/jjcxhfVvbzVY=;
 b=iXsrOKp3lKeIXnJKY5ugM7KQIKnXbnf6UyCegHUjaKtO8eC8u5SRz1ExaU2i/cPPZx
 ZhFi7hOWEX5RDoDatqdYFxAKOhuNcbX+A5VgIgK9oTme+hAOBNOdzFEkI4iiNaUXLD3M
 ZIxp83dFboDvWplU85r8nAs/7/pm7p62wcigeoRJELz5+ochOabLtLPw04eDgBAW1t+W
 5n38WbRi6/l0EibLu+tpFnIIltpTG6m9DeBh92cWMmAV6ZH4TJRezRrg5t2qE6yUU7vv
 bOo6PANn78z4iv8mFCNhO35dYm5jbr2VZTbbez9FmvT8mmTSFoLLEczsZ1x0Q/dRrIbv
 7Dwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEFkmRuFSI1TOsQ/+QWak+UQG/CHB4zR1gtGBYYKnFRyQXvA13SDjvHCd2fPgzxgZG/c2ewlpnmXHZbgImlqeYMSXA1c=
X-Gm-Message-State: AOJu0YwS2PM1wwjVO4SpXkGrLLKG8+0T+3ca0+LkZCaOjrxgiND2JCPF
 sssOIzFwNUfLTG6IFfNgSOylwT2bVSSNfZCWW7ElrU2bw2fsiem7vxQG39Rw/XBAmX+QJrkYnms
 S0RtmXoHpIqI+CRNg1h9hzY9nfDob9CjUj2jKmZN0yXNczZ49NDyu
X-Received: by 2002:a05:6402:51d1:b0:585:4048:129a with SMTP id
 4fb4d7f45d1cf-58540481658mr549286a12.31.1719478533395; 
 Thu, 27 Jun 2024 01:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK589CC3iwOxvBX68FtJjHQQMdh3yPoRWC/wdv92jSmIoBDoW5poYpeNJdZwxXO56GjsWeWw==
X-Received: by 2002:a05:6402:51d1:b0:585:4048:129a with SMTP id
 4fb4d7f45d1cf-58540481658mr549253a12.31.1719478532636; 
 Thu, 27 Jun 2024 01:55:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:f0a6:8439:896b:82b9:df53])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d27816f9sm589620a12.75.2024.06.27.01.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:55:32 -0700 (PDT)
Date: Thu, 27 Jun 2024 04:55:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] virtio-pci: Fix the use of an uninitialized irqfd
Message-ID: <20240627045416-mutt-send-email-mst@kernel.org>
References: <20240626024434.10523-1-lulu@redhat.com>
 <20240626033920-mutt-send-email-mst@kernel.org>
 <CACLfguUKRyrRPUDzcv+LgKk7=-3D1rL_zN_gbi8Gt0UrDfZwjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguUKRyrRPUDzcv+LgKk7=-3D1rL_zN_gbi8Gt0UrDfZwjg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On Thu, Jun 27, 2024 at 04:40:33PM +0800, Cindy Lu wrote:
> On Wed, Jun 26, 2024 at 3:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 26, 2024 at 10:44:31AM +0800, Cindy Lu wrote:
> > > The crash was reported in MAC OS and NixOS, here is the link for this bug
> > > https://gitlab.com/qemu-project/qemu/-/issues/2334
> > > https://gitlab.com/qemu-project/qemu/-/issues/2321
> > >
> > > The root cause is the function virtio_pci_set_guest_notifiers() was not called
> > > in the virtio_input device.So the vector_irqfd was not initialized
> > >
> > > So the fix is add the check for vector_irqfd.
> > >
> > > Change in V3
> >
> > Changelog belongs after ---
> >
> thanks micheal, will fix this
> > > 1) Move the vector_irqfd check to virtio_pci_get_notifier().
> > > The function virtio_pci_get_notifier() can also be used while vdev->status
> > > is not VIRTIO_CONFIG_S_DRIVER_OK. In that case, the vector_irqfd could be NULL,
> > > so also add the status check here.
> > > 2) Add the return value check for kvm_virtio_pci_vector_use_one().
> > > Since the return value of function virtio_pci_set_vector() is void,
> > > just add the error message here.
> > >
> > > This fix is verified in vyatta,MacOS,NixOS,fedora system.
> > >
> > > The bt tree for this bug is:
> > > Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> > > [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> > > kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > > 817         if (irqfd->users == 0) {
> > > (gdb) thread apply all bt
> > > ...
> > > Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> > > 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> > > 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
> > > 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497
> > > 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/system/memory.c:573
> > > 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528
> > > 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qemu-9.0.0/system/physmem.c:2713
> > > 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743
> > > 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> > > 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/physmem.c:2894
> > > 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/physmem.c:2904
> > > 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> > > 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
> > > 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-thread-posix.c:541
> > > 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> > > 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
> > >
> > > Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> > > Cc: qemu-stable@nongnu.org
> > >
> >
> > all trailers including s.o.b. should be together, with no empty lines
> >
> will change this
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index b1d02f4b3d..87307b9061 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -860,6 +860,11 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
> > >      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> > >      VirtQueue *vq;
> > >
> > > +    if ((proxy->vector_irqfd == NULL) &&
> >
> > Preferable:
> >         if (!proxy->vector_irqfd &&
> >
> > and brackets not really needed here
> >
> >
> > > +        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> >
> > brackets not really needed here
> >
> sure, will fix this
> > > +        return -1;
> > > +    }
> > > +
> > >      if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
> > >          *n = virtio_config_get_guest_notifier(vdev);
> > >          *vector = vdev->config_vector;
> > > @@ -1452,7 +1457,9 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
> > >      }
> > >      /* If the new vector changed need to set it up. */
> > >      if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> > > -        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > > +        if (kvm_virtio_pci_vector_use_one(proxy, queue_no)) {
> > > +            virtio_error(vdev, "fail to set the vector %d", new_vector);

failed.
and print errno?

> > > +        }
> > >      }
> > >  }
> >
> >
> > Is this an unrelated fix?
> >
> this is for last version's comment, there is an return value for
> function kvm_virtio_pci_vector_use_one, but
> we can do nothing here, so I just add an erorr message
> Thanks
> cindy


I'd make it a separate patch, documenting in the commit log what
is going on.

> > >
> > > --
> > > 2.45.0
> >


