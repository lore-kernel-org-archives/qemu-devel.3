Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53297C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOMh-0000le-3u; Thu, 18 Apr 2024 05:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rxOMM-0000kM-RA
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rxOML-0008Cr-31
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713433630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C1kGL+PY06hzztmhWP2xZLR4Z05Ym+QVqu/NuO93dw=;
 b=POQmPvC6TqL5h39VvLq8YxctR3Ie6fuEfIKsWVypfOOGnNnNlIjcPxpl/KfFbp4csoPFMc
 nhvCW1y2tkH18+n9B54iQa4ms1lmmukOib9P6JTaQD01UPdAlr6jR+0hcW9oEH1rLOk9IJ
 6vlnZlOtB0MVtY4kH3rFndRV0iEiE9Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-qu6HkvyjMmue9n-VdlvjbQ-1; Thu, 18 Apr 2024 05:47:09 -0400
X-MC-Unique: qu6HkvyjMmue9n-VdlvjbQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a5569434b26so37617266b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 02:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713433627; x=1714038427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2C1kGL+PY06hzztmhWP2xZLR4Z05Ym+QVqu/NuO93dw=;
 b=qQsTD9WxIIqWYnq083uWwH18XhV+AUqSxZTS3SjwltyYhC8sOg8jlqn8P6xY1Zp8sd
 aOo+a9wyTftGHDE+gn9YhONpZLx2GHCKpH4iuPrrBvWNWK7xHeZrekid7uI+AbHUtYHo
 xkcNsOAPSfAem5KM8kxo6a/8ve0isu/huOg7NYraDWAn3PGrkpxR55pgOjkdaE0fiy3+
 ct1nUS5zdPBlHApSMrtFYlPnF4fvhDkz4O3jNmYFvvgdeo+RxaqPhR4sEXA7P9Dt5PHf
 GhIu3YvPHsODBGO6nvJZJLRnuwLA7mwd0rko0X5nsn1qg31Fn+ZkEoryafdrFrbkLAEM
 arMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHmWzyrvV4/iDXCpdG149yRgDyuLUB6yNSk6v5t+H4TM48j8ezo76JfhEnv464ncYaiHvZ7IpYXknbXPnM1VwspSTWnw=
X-Gm-Message-State: AOJu0YyGZ0j5PcuAPEG81xXnzyU41mEkDK/dIb4+93ealCFizg6vSUgO
 wUwOrFsf1J0o9IpYiTwyW6sx6K5dK0/GdhmK0M9dOBFYXOaeiol2skKFvwqX+FGyDJeV30VplP/
 gyHTufwF3+ZOpC0+SO7Y59xdJED1jT91dzmsGctCXE5wK183bnwiwqGadbKX9QVbbXiPjDeYO6p
 G54Uw96d7QgKJmAH7JSzvuSZsuP/M4eOECQLw=
X-Received: by 2002:a17:906:1c03:b0:a51:80d0:c596 with SMTP id
 k3-20020a1709061c0300b00a5180d0c596mr1413843ejg.18.1713433627378; 
 Thu, 18 Apr 2024 02:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVMjvaKCfczY6asaSk80mXUmR5DcgwDsSXit3r8z8oARz+pfgdZgi/Vd1ShEsw+wiWCwAStqd2tAp9hnjc9+g=
X-Received: by 2002:a17:906:1c03:b0:a51:80d0:c596 with SMTP id
 k3-20020a1709061c0300b00a5180d0c596mr1413829ejg.18.1713433627084; Thu, 18 Apr
 2024 02:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240416122919.597819-1-lulu@redhat.com>
 <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
 <CACLfguXs-YkMBZK9cNkuaG9dQzvUDY-znMGQN6JL8VR8ci8yng@mail.gmail.com>
 <CAFEAcA-bXhCqTCiT5NshAzDb17c8+jqdmtOigfSbJ5ozckAUQg@mail.gmail.com>
 <20240416143608-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240416143608-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 18 Apr 2024 17:46:28 +0800
Message-ID: <CACLfguWrVtO9xPPiDVL+vcpX1x8HGMMubkjhL4GRfYUS2mnQKw@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Wed, Apr 17, 2024 at 2:38=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 16, 2024 at 02:14:57PM +0100, Peter Maydell wrote:
> > On Tue, 16 Apr 2024 at 13:41, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 8:30=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > > >
> > > > On Tue, 16 Apr 2024 at 13:29, Cindy Lu <lulu@redhat.com> wrote:
> > > > >
> > > > > In function kvm_virtio_pci_vector_use_one(), in the undo label,
> > > > > the function will get the vector incorrectly while using
> > > > > VIRTIO_CONFIG_IRQ_IDX
> > > > > To fix this, we remove this label and simplify the failure proces=
s
>
> And then what happens?  It's unclear whether it's a real or
> theoretical issue.
>
> > > > > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > > >  hw/virtio/virtio-pci.c | 19 +++----------------
> > > > >  1 file changed, 3 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > index b138fa127a..565bdb0897 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(Virt=
IOPCIProxy *proxy, int queue_no)
> > > > >      }
> > > > >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> > > > >      if (ret < 0) {
> > > > > -        goto undo;
> > > > > +        return ret;
> > > > >      }
> > > > >      /*
> > > > >       * If guest supports masking, set up irqfd now.
> > > > > @@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(Vi=
rtIOPCIProxy *proxy, int queue_no)
> > > > >          ret =3D kvm_virtio_pci_irqfd_use(proxy, n, vector);
> > > > >          if (ret < 0) {
> > > > >              kvm_virtio_pci_vq_vector_release(proxy, vector);
> > > > > -            goto undo;
> > > > > +            kvm_virtio_pci_irqfd_release(proxy, n, vector);
> > > >
> > > > Are you sure this is right? The kvm_virtio_pci_irqfd_use()
> > > > just failed, so why do we need to call
> > > > kvm_virtio_pci_irqfd_release() ?
> >
> > > This version should be correct.  when kvm_virtio_pci_irqfd_use() fail
> > > we need to call kvm_virtio_pci_vq_vector_release() and
> > > kvm_virtio_pci_irqfd_release()
> > > but for kvm_virtio_pci_vq_vector_use fail we can simple return,
> >
> > But *why* do we need to call kvm_virtio_pci_irqfd_release()?
> >
> > In most API designs, this kind of pairing of "get/use/allocate
> > something" and "free/release something" function only
> > requires you to do the "release" if the "get" succeeded,
> > because if the "get" fails it's supposed to fail in way that
> > means "I didn't do anything". Is this API not following that
> > standard pattern ?
>
>
> I am just as puzzled.
>
got it. I made a mistake here, I will send the new version
Thanks
cindy
> > > in old version there is a error in failure process.
> > > while the kvm_virtio_pci_vq_vector_use fail it  call the
> > > kvm_virtio_pci_irqfd_release,but at this time this is irqfd
> > > is not using now
> >
> > thanks
> > -- PMM
>


