Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A15EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIcL-0004Qa-Uc; Mon, 15 Apr 2024 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwIc9-0004LT-0e
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwIc7-0002KN-Bd
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713173218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7RgSMZo5PzLThVM1vVuGb7FMMy4sh8tZIVrtpcCXGo=;
 b=iCe482gprDdqnePjncbD7/8opa4bC+k6P1Tb5M1xrNKi5jjnO0ikvoVNQU9kbqr6QwPUCi
 XZCjA/lcQoB2THfgVbHD/CkJOMrfl+r4zyU6mdf9ogwHMDWNmdyeoew213CcnUWY/AxNri
 FgMxGvuNcQ0RhhKWvF/V30gsJw0vHGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-UCGN4EHtOwKBSXXizqY7oA-1; Mon, 15 Apr 2024 05:26:56 -0400
X-MC-Unique: UCGN4EHtOwKBSXXizqY7oA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3473168c856so1512494f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173215; x=1713778015;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7RgSMZo5PzLThVM1vVuGb7FMMy4sh8tZIVrtpcCXGo=;
 b=boMmx1HKr2/SW4wACIOw9LeFVI9vwdlu1QiFnYcI0/Qmp44LmhE4J4ZCHsjRaF2xdJ
 VXiwCIQKWHkvZR76mmJ/lcxHCbI5gwP3C2X3ckfW6BSVex0FoXGheHQVe5jy1k7HJEeN
 H4E5FtqLkkhhCsnkj+6WF2LxY7VeZMevs/EmTIqcsS+EtuaghwRcTRQB6Ja9DNff6l/2
 FUUvN7dKcQDPsSvBLEIha6Jx6C5Jz/82JuOInLDUYQmVVSrtPDn2cEPGHbA4On6FWNDy
 Lfe2VuKnx4jmg628n592FxlSLaVV+GlN+dExd04Tl+alKHSh51zM+usZvCRxWfDVz0z/
 yOaA==
X-Gm-Message-State: AOJu0Yweo0oYXIYVAfM4oTKiwkWtzmZYHeufZAbB3lj4Wzf+lx4qzCOZ
 ePJbDO0IO8arnf7dqN9oE+cfPjE/K/L/duImIJ3ZIvESfjU1azjB7nsC6aNeMPoFTbOO8Wnmkub
 Vo2aRBlAGWuxEysDl2JM8f6xVJB/Wm4ItkLqqhtQ2jhtiSF5p90Ud
X-Received: by 2002:a05:600c:4ecd:b0:417:ec11:c445 with SMTP id
 g13-20020a05600c4ecd00b00417ec11c445mr5689901wmq.13.1713173215190; 
 Mon, 15 Apr 2024 02:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFPoArlKpp2+pMjA+Hn/7A4en8XTE681bBFPFi0MTMKT7DIjKK4MBcwhXlgT1CNiac2nL7rA==
X-Received: by 2002:a05:600c:4ecd:b0:417:ec11:c445 with SMTP id
 g13-20020a05600c4ecd00b00417ec11c445mr5689883wmq.13.1713173214702; 
 Mon, 15 Apr 2024 02:26:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
 by smtp.gmail.com with ESMTPSA id
 ay36-20020a05600c1e2400b004186df974f1sm1849986wmb.33.2024.04.15.02.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 02:26:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 05:26:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7] virtio-pci: Fix the crash that the vector was used
 after released.
Message-ID: <20240415052513-mutt-send-email-mst@kernel.org>
References: <a3612104baa9fe72d9e3182e3d108bff96a9ddf4.1713172726.git.mst@redhat.com>
 <133af310-c3ea-4b2f-b4d9-846cc0684710@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <133af310-c3ea-4b2f-b4d9-846cc0684710@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Apr 15, 2024 at 11:23:46AM +0200, Philippe Mathieu-Daudé wrote:
> On 15/4/24 11:19, Michael S. Tsirkin wrote:
> > From: Cindy Lu <lulu@redhat.com>
> > 
> > During the booting process of the non-standard image, the behavior of the
> > called function in qemu is as follows:
> > 
> > 1. vhost_net_stop() was triggered by guest image. This will call the function
> > virtio_pci_set_guest_notifiers() with assgin= false,
> > virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0
> > 
> > 2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR
> > 
> > 3.vhost_net_start() was called (at this time, the configure vector is
> > still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
> > assgin=true, so the irqfd for vector 0 is still not "init" during this process
> > 
> > 4. The system continues to boot and sets the vector back to 0. After that
> > msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash
> > 
> > To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.
> 
> 
> > MST: coding style and typo fixups
> > 
> > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > To expedite fixed lots of style issues myself.
> > Completely untested - guys can you pls test and ack?
> > 
> > 
> >   hw/virtio/virtio-pci.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index cb6940fc0e..e9edd57339 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1424,6 +1424,34 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> >       return offset;
> >   }
> > +static void virtio_pci_set_and_change_vector(VirtIODevice *vdev,
> > +                                             VirtIOPCIProxy *proxy,
> > +                                             int queue_no, uint16_t old_vector,
> > +                                             uint16_t new_vector)
> > +{
> 
> Alternatively:
> 
>        if (new_vector == old_vector) {
>            return;
>        }


True. And in fact callers do not need check this.
Let me do v8.


> > +    bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> > +
> > +    /*
> > +     * If the device uses irqfd and the vector changes after DRIVER_OK is
> > +     * set, we need to release the old vector and set up the new one.
> > +     * Otherwise just need to set the new vector on the device.
> > +     */
> > +    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> > +    }
> > +    /* Set the new vector on the device. */
> > +    if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
> > +        vdev->config_vector = new_vector;
> > +    } else {
> > +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> > +    }
> > +    /* If the new vector changed need to set it up. */
> > +    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > +    }
> > +}
> > +
> >   int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
> >                              uint8_t bar, uint64_t offset, uint64_t length,
> >                              uint8_t id)
> > @@ -1570,7 +1598,12 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> >           } else {
> >               val = VIRTIO_NO_VECTOR;
> >           }
> > -        vdev->config_vector = val;
> > +        vector = vdev->config_vector;
> > +        /* Check if we need to change the vector. */
> > +        if (val != vector) {
> > +            virtio_pci_set_and_change_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> > +                                             vector, val);
> > +        }
> >           break;


