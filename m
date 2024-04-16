Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnhP-0001Il-55; Tue, 16 Apr 2024 14:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwnhN-0001Fc-Hm
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwnhL-0001Zs-GV
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713292706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xl8KL0MDjsH//7OgfngyqJ4zPZHNPgr3uFd/YoWB0Bg=;
 b=U38r85+7fKVS3Zt/ULdcJoMFLY7n1p9pW/SE1Q/BZF9AS6O0z/5BQeZYBtOJZ7DWAy3YPC
 S/fYkLsnXaRmdca5XxZx1ioB54jkHFvkpOWfYFWoCh5m9Lx7Y+XSkh4erDEHPXqBqZDeso
 CPLQXgDFSYBCjtwkXXH7ri+iRXzEhoo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-R9ClZzvlOS-_QxUobHTb1g-1; Tue, 16 Apr 2024 14:38:24 -0400
X-MC-Unique: R9ClZzvlOS-_QxUobHTb1g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-416612274e7so20183025e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713292703; x=1713897503;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xl8KL0MDjsH//7OgfngyqJ4zPZHNPgr3uFd/YoWB0Bg=;
 b=k+/+Vre3w1A9GE7m+6kLSjTx8wpUir5nYQ+D5kRGPw8tqjHbWJ5/YrO4LiE4T1eW1y
 ZfJnU2BHO8voiTo6dGtukdxLDPmwEte3dyiNRV5IHOcmpUKfaxwwgetQHJkpB8uJEw8Y
 Dnv8/99T9nLatS3l1xm/FHe/WUhkcq3ItR3KLFALHa6Ow2kebu6i85cUUyRcL2ZUzk3X
 oi/5JN8rKLnw8R45ogUEurtfne9x0eVrIfi2CoyWcSLOQmJR+mI+iu25O8WD4GJj237c
 Gd5E2QHzteD3+mAsPmFBg36xN1vEcYGVzU7vDT+WDMWqmIzoPTuXCN3AtbxwzXJdTCFs
 w/ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKNwHY/wt6mKVgQZNyHvHN/9phtGdzSPth4jQ3M74ZdYt/QYeEpnj0BbqoV0ELyK5syyD2gDxqVcpBQJcQMNIXkDPhcqI=
X-Gm-Message-State: AOJu0YzZTa6YGeLdXkdLw9Qsg+OAY7VCTXkW0LGpQQmPanxVuVqSgCc/
 8u1S9lA++2HHX3xApTMQbgeN74VNxtXeP3+Yyx7XSZwbglRTNZttGAGiVCDZ8pKRTy+tKG3bPqr
 iqJuyGrmzJu/R+pso8mD6rmpw+U8w0V6GOJ6b2ltnwJtr1GJeRjlu
X-Received: by 2002:a05:600c:4586:b0:417:c5cc:77a7 with SMTP id
 r6-20020a05600c458600b00417c5cc77a7mr8921644wmo.13.1713292703065; 
 Tue, 16 Apr 2024 11:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgOOh4KhbfjNcSjuEnPmjOGShXOyVkb9cqBzkms0Q7TNVU1YfiEf52qEAZP/bd6I7FX+Jd2g==
X-Received: by 2002:a05:600c:4586:b0:417:c5cc:77a7 with SMTP id
 r6-20020a05600c458600b00417c5cc77a7mr8921628wmo.13.1713292702532; 
 Tue, 16 Apr 2024 11:38:22 -0700 (PDT)
Received: from redhat.com ([2.52.136.49]) by smtp.gmail.com with ESMTPSA id
 gw7-20020a05600c850700b004146e58cc35sm24471232wmb.46.2024.04.16.11.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 11:38:21 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:38:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Message-ID: <20240416143608-mutt-send-email-mst@kernel.org>
References: <20240416122919.597819-1-lulu@redhat.com>
 <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
 <CACLfguXs-YkMBZK9cNkuaG9dQzvUDY-znMGQN6JL8VR8ci8yng@mail.gmail.com>
 <CAFEAcA-bXhCqTCiT5NshAzDb17c8+jqdmtOigfSbJ5ozckAUQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-bXhCqTCiT5NshAzDb17c8+jqdmtOigfSbJ5ozckAUQg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 02:14:57PM +0100, Peter Maydell wrote:
> On Tue, 16 Apr 2024 at 13:41, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 8:30 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 16 Apr 2024 at 13:29, Cindy Lu <lulu@redhat.com> wrote:
> > > >
> > > > In function kvm_virtio_pci_vector_use_one(), in the undo label,
> > > > the function will get the vector incorrectly while using
> > > > VIRTIO_CONFIG_IRQ_IDX
> > > > To fix this, we remove this label and simplify the failure process

And then what happens?  It's unclear whether it's a real or
theoretical issue.

> > > > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > > > Cc: qemu-stable@nongnu.org
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  hw/virtio/virtio-pci.c | 19 +++----------------
> > > >  1 file changed, 3 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > index b138fa127a..565bdb0897 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
> > > >      }
> > > >      ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
> > > >      if (ret < 0) {
> > > > -        goto undo;
> > > > +        return ret;
> > > >      }
> > > >      /*
> > > >       * If guest supports masking, set up irqfd now.
> > > > @@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
> > > >          ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
> > > >          if (ret < 0) {
> > > >              kvm_virtio_pci_vq_vector_release(proxy, vector);
> > > > -            goto undo;
> > > > +            kvm_virtio_pci_irqfd_release(proxy, n, vector);
> > >
> > > Are you sure this is right? The kvm_virtio_pci_irqfd_use()
> > > just failed, so why do we need to call
> > > kvm_virtio_pci_irqfd_release() ?
> 
> > This version should be correct.  when kvm_virtio_pci_irqfd_use() fail
> > we need to call kvm_virtio_pci_vq_vector_release() and
> > kvm_virtio_pci_irqfd_release()
> > but for kvm_virtio_pci_vq_vector_use fail we can simple return,
> 
> But *why* do we need to call kvm_virtio_pci_irqfd_release()?
> 
> In most API designs, this kind of pairing of "get/use/allocate
> something" and "free/release something" function only
> requires you to do the "release" if the "get" succeeded,
> because if the "get" fails it's supposed to fail in way that
> means "I didn't do anything". Is this API not following that
> standard pattern ?


I am just as puzzled.

> > in old version there is a error in failure process.
> > while the kvm_virtio_pci_vq_vector_use fail it  call the
> > kvm_virtio_pci_irqfd_release,but at this time this is irqfd
> > is not using now
> 
> thanks
> -- PMM


