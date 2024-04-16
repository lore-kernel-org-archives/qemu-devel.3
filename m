Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6CAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiem-0004sV-EE; Tue, 16 Apr 2024 09:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwieV-0004nM-Rd
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:15:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwieU-0002kh-36
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:15:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56fffb1d14bso6462045a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713273308; x=1713878108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmya1LfXZTf7z00Wm99G8Z5U3unPBDxqf746p8W1s+8=;
 b=gc3CwbXumTtDY5JXeMQAwSYjS+p6PeWF0/x3FKovcSsxIIBZ3wuqvSrTyz9szvBALE
 0I6tCKTgqLRrTVR3KXcUlmo9TB2ZWE5hYt9vAdSEd5+kjGzFo10mWk83YZsi/Q8sCfBf
 228a4NdnRZSDcYsnRzy55Tmy4hGliRBsoqvECVEFqV+kXIk+HZDqRNeuugctfEc6d1F+
 pRA7GeFcnLEUUkkfWk8cPe33tXJqnY+9hCay3R0sQXpdwwWlILJAXEkJWt70pWwo734t
 F2ndT/vs3wht6FteyPkawYnTA6oZT8t+6ftdM2Vc/bkgdW6jADIpAPFY8rgQt3Sl3cnR
 ouzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713273308; x=1713878108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmya1LfXZTf7z00Wm99G8Z5U3unPBDxqf746p8W1s+8=;
 b=gURx0pMUr7lNw8qTbsnHUj8bQi42+5UD1DKTimsfrYF1t1kw7n9sVYeDd8f9FWJiTV
 XrOzV4aDMOvFdljAUHskFUiWAMgpkL/3JLegrOWFFYSEBq52lUqXvzDHLoeFtTtUUMyy
 yTT6FK5j2jM++5aD2z4nuQ/IQwvaZwmQaixa38bE7aWzhF/Uk3Nyyxxp1WayYkV9FAYw
 k5nrsl5aBv0ZKAirT+fVxsNlVmkHRifwC3MjhNDq+fufc5KdXHbc8LL/qJg7aEFRzFPG
 NtrY6xWB9hb023JXLuf4qRr0mASrUGUDcQVZ00x9Itu9KmSuaYUKS/ZhlebMhxFVFVPJ
 ezXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb8sfnMVUmgKKTfeI7GNy/h2acys1cWglymaLW5hBnpMG8ytLkDig4SP0LXk3l+5aLxYtCpXrdGa23vpkbwbH4P1tKCO4=
X-Gm-Message-State: AOJu0YzBqQ0jfA9doI+bFkvXtx6wcWUx2Mvx0SylLjxS3qfI/HJYf58B
 kSYWQqqIoBALs3niv7VYfLo0zr8AfUWQ9li6pG3/wHAEL+asdE/PECyXm8hY5MU+PzbWDGl4iGk
 BqwKoMXWcOtonOFCuGAtFf61Bn8F6leFBMygXhdXlGjQpyMXS
X-Google-Smtp-Source: AGHT+IGsbmyH3BzyICndrALY8nIxkV5EkQWkirAxRJ98USaLPtiitDNDErdCXVD7sPEMrKywsHF3PrWJRp8DX30of2I=
X-Received: by 2002:a50:935a:0:b0:56d:e765:4356 with SMTP id
 n26-20020a50935a000000b0056de7654356mr1917486eda.3.1713273308238; Tue, 16 Apr
 2024 06:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240416122919.597819-1-lulu@redhat.com>
 <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
 <CACLfguXs-YkMBZK9cNkuaG9dQzvUDY-znMGQN6JL8VR8ci8yng@mail.gmail.com>
In-Reply-To: <CACLfguXs-YkMBZK9cNkuaG9dQzvUDY-znMGQN6JL8VR8ci8yng@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 14:14:57 +0100
Message-ID: <CAFEAcA-bXhCqTCiT5NshAzDb17c8+jqdmtOigfSbJ5ozckAUQg@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Apr 2024 at 13:41, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:30=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 16 Apr 2024 at 13:29, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > In function kvm_virtio_pci_vector_use_one(), in the undo label,
> > > the function will get the vector incorrectly while using
> > > VIRTIO_CONFIG_IRQ_IDX
> > > To fix this, we remove this label and simplify the failure process
> > >
> > > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 19 +++----------------
> > >  1 file changed, 3 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index b138fa127a..565bdb0897 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPC=
IProxy *proxy, int queue_no)
> > >      }
> > >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> > >      if (ret < 0) {
> > > -        goto undo;
> > > +        return ret;
> > >      }
> > >      /*
> > >       * If guest supports masking, set up irqfd now.
> > > @@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(VirtIO=
PCIProxy *proxy, int queue_no)
> > >          ret =3D kvm_virtio_pci_irqfd_use(proxy, n, vector);
> > >          if (ret < 0) {
> > >              kvm_virtio_pci_vq_vector_release(proxy, vector);
> > > -            goto undo;
> > > +            kvm_virtio_pci_irqfd_release(proxy, n, vector);
> >
> > Are you sure this is right? The kvm_virtio_pci_irqfd_use()
> > just failed, so why do we need to call
> > kvm_virtio_pci_irqfd_release() ?

> This version should be correct.  when kvm_virtio_pci_irqfd_use() fail
> we need to call kvm_virtio_pci_vq_vector_release() and
> kvm_virtio_pci_irqfd_release()
> but for kvm_virtio_pci_vq_vector_use fail we can simple return,

But *why* do we need to call kvm_virtio_pci_irqfd_release()?

In most API designs, this kind of pairing of "get/use/allocate
something" and "free/release something" function only
requires you to do the "release" if the "get" succeeded,
because if the "get" fails it's supposed to fail in way that
means "I didn't do anything". Is this API not following that
standard pattern ?

> in old version there is a error in failure process.
> while the kvm_virtio_pci_vq_vector_use fail it  call the
> kvm_virtio_pci_irqfd_release,but at this time this is irqfd
> is not using now

thanks
-- PMM

