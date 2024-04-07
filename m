Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AA1CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 11:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtR5m-00059i-A7; Sun, 07 Apr 2024 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtR5k-00059W-Rv
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 07:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtR5i-0001hz-Ju
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 07:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712490821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1x7BtxEdrtH4mO31iDDjdEW069HcKRZNaEjhA2UXRU=;
 b=LbN1v8nFMer4SIgaAQCLsC89mmeVj2ZYjwlMGosvhiryQPQHwADxfpx05wUI9jEswVRnnJ
 pf5RO3YVlC2f9ho8vGCGVOMjiD72Rad/7255I1bLO1TIet5/NrNJTavYlb9j7HcRtXG4ix
 mO7wtBdLVxrWwxElxPT+4vPDNLJ7ulg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-lXsUKyxxN0uceBGA1Ghlmg-1; Sun, 07 Apr 2024 07:53:39 -0400
X-MC-Unique: lXsUKyxxN0uceBGA1Ghlmg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343e00c8979so1416510f8f.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 04:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712490818; x=1713095618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1x7BtxEdrtH4mO31iDDjdEW069HcKRZNaEjhA2UXRU=;
 b=W7dDGdFNcJa/tEsuE5hi9NjU5fDygp2gwKnqft2W3MMeDLlfe37SQvV7P0sAnmpz0e
 c7OIETS9FF/c3/zCeIxCK0teCYTOoGtppbjKZxNjP2hM0NZ8A6RK05PDwIz8s1RZnBZ8
 HxzXDvT00HgQFbbBFubk0yFmHaq02J8s7o4LVvPkOm5JEL+C27xSL7I/ECIgUFBvEoRg
 aORulgsT5n97nHQJwHzlwPa66PclXLSaIwYveY/bt/jTREKLhDggG4MVaONRvhE2byqz
 YXnHutQaFOL3dU5S2Kt9b5XeEIHHa+WHaML1CBlYK72EUZ5iYnx5/XVS8lEma3qwePSi
 o+xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjgTfbWsYHpEhrA1Wah6bgU2L32Ush6R2CK4JZRDrssGEVn+0rQ33YBAFKpxW4NdliBzIBjpsVMUtLJt38qFUQO5rh76Q=
X-Gm-Message-State: AOJu0YyDul0VZXvZ5D3VRHKvT3kOFU6xVoEMOP+UwjK68adGwV7r/551
 BOxcz2Rk7jk1BH7zzcHqNzB7n/E/6x/3zL1MdX5S1/9f3vLLRfJvFRMZcqUaVqAMrJk6w79OD19
 /P3zAViDQmQW69lCKiFcWRWP9Nba1Lu4OAuQtMzXhOYF4PlK3HmlH
X-Received: by 2002:a05:600c:1f93:b0:416:2a95:6e8b with SMTP id
 je19-20020a05600c1f9300b004162a956e8bmr4518189wmb.26.1712490818298; 
 Sun, 07 Apr 2024 04:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJMASgX8hmC2zATfDLo/dE4wwg/jjRMp08PfSP1dwtZ5cfEXaCjzkRzsiGQVVLzaZfALerIA==
X-Received: by 2002:a05:600c:1f93:b0:416:2a95:6e8b with SMTP id
 je19-20020a05600c1f9300b004162a956e8bmr4518176wmb.26.1712490817469; 
 Sun, 07 Apr 2024 04:53:37 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c19ca00b0041632fcf272sm7169126wmq.22.2024.04.07.04.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 04:53:36 -0700 (PDT)
Date: Sun, 7 Apr 2024 07:53:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
Message-ID: <20240407075135-mutt-send-email-mst@kernel.org>
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
 <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 07, 2024 at 12:19:57PM +0800, Jason Wang wrote:
> On Tue, Apr 2, 2024 at 11:02 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When the guest calls virtio_stop and then virtio_reset,
> 
> Guests could not call those functions directly, it is triggered by for
> example writing to some of the registers like reset or others.
> 
> > the vector will change
> > to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. After that
> > If you want to change the vector back,
> 
> What do you mean by "change the vector back"? Something like
> 
> assign VIRTIO_MSI_NO_VECTOR to vector 0
> assign X to vector 0
> 
> And I guess what you meant is to configure the vector after DRIVER_OK.
> 
> 
> > it will cause a crash.
> >
> > To fix this, we need to call the function "kvm_virtio_pci_vector_use_one()"
> > when the vector changes back from VIRTIO_NO_VECTOR
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index e433879542..45f3ab38c3 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
> >      return 0;
> >  }
> >
> > -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
> > +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no,
> > +                                         bool recovery)
> >  {
> >      unsigned int vector;
> >      int ret;
> >      EventNotifier *n;
> >      PCIDevice *dev = &proxy->pci_dev;
> > +    VirtIOIRQFD *irqfd;
> >      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> >      VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> >
> > @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
> >      if (vector >= msix_nr_vectors_allocated(dev)) {
> >          return 0;
> >      }
> > +    /*
> > +     * if this is recovery and irqfd still in use, means the irqfd was not
> > +     * release before and don't need to set up again
> > +     */
> > +    if (recovery) {
> > +        irqfd = &proxy->vector_irqfd[vector];
> > +        if (irqfd->users != 0) {
> > +            return 0;
> > +        }
> > +    }
> >      ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
> >      if (ret < 0) {
> >          goto undo;
> >      }
> > +
> >      /*
> >       * If guest supports masking, set up irqfd now.
> >       * Otherwise, delay until unmasked in the frontend.
> > @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOPCIProxy *proxy, int nvqs)
> >          if (!virtio_queue_get_num(vdev, queue_no)) {
> >              return -1;
> >          }
> > -        ret = kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > +        ret = kvm_virtio_pci_vector_use_one(proxy, queue_no, false);
> >      }
> >      return ret;
> >  }
> >
> >  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
> >  {
> > -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX);
> > +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, false);
> >  }
> >
> >  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
> > @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> >          } else {
> >              val = VIRTIO_NO_VECTOR;
> >          }
> > +        vector = vdev->config_vector;
> >          vdev->config_vector = val;
> > +        /*check if the vector need to recovery*/
> > +        if ((val != VIRTIO_NO_VECTOR) && (vector == VIRTIO_NO_VECTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, true);
> > +        }
> 
> This looks too tricky.
> 
> Think hard of this. I think it's better to split this into two parts:
> 
> 1) a series that disables config irqfd for vhost-net, this series
> needs to be backported to -stable which needs to be conservative. It
> looks more like your V1, but let's add a boolean for pci proxy.

I don't get it. Looks like a huge change to do in stable.
All as a replacement to a small 20 line patch?

Generally I think irqfd is best used everywhere.


> 2) a series that deal with the msix vector configuration after
> driver_ok, we probably need some refactoring to do per vq use instead
> of the current loop in DRIVER_OK
> 
> Does this make sense?
> 
> Thanks


Not really let's fix the bug for starters, refactoring can be done later
as appropriate.

> >          break;
> >      case VIRTIO_PCI_COMMON_STATUS:
> >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> >              val = VIRTIO_NO_VECTOR;
> >          }
> >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +
> > +        /*check if the vector need to recovery*/
> > +        if ((val != VIRTIO_NO_VECTOR) && (vector == VIRTIO_NO_VECTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, true);
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> >          if (val == 1) {
> > --
> > 2.43.0
> >


