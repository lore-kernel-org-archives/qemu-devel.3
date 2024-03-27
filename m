Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD3DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJbU-0000oW-BH; Tue, 26 Mar 2024 23:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJbS-0000o2-Of
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJbQ-0004L9-ID
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711508722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zolu8aruGceuT1v64cktuJeg+zYoGrZVmgGVqfVmobc=;
 b=VvkbZhywAnDftqHBt3PZyUVKv3nudgSABBBdYrEXttRFW1cbRkeMLsH86R9SgM96tosEFM
 hO32BGOaMaJORo+SZZXYhtRLOjSJtGY/ngWdRN5fdwb/ED1uh4RePHjP8XlDRHCQ7a374R
 4uNMU0qqIeRthaLbF3HgoxjDG9rXhlg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-13qGQ6mrOCGdKAUwPC4ofQ-1; Tue, 26 Mar 2024 23:05:17 -0400
X-MC-Unique: 13qGQ6mrOCGdKAUwPC4ofQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1e09fba31afso24963695ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 20:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711508717; x=1712113517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zolu8aruGceuT1v64cktuJeg+zYoGrZVmgGVqfVmobc=;
 b=QiReBaa8hdPpsHwv7kXazJMffO62FMXWZLLlSf2S/IxdvnLkxzVCzuf4eq3eH06BWY
 2EnkBN1ztuXoxOSLd28C9KU+JpNB6Nrn6HAEXEQiLYTqEb9jzDcGFBz8yCbOzRHKPUI4
 bqd+wQ35a0ddgrtsD1ApEq47XYSAyQY/FEZRKkgoycYsf4ScS3sO/rNN87leaG3cx8zL
 4au+JRMXITJd3xgpcoQD9e3yOSy6Nc9HKK+641C03ETBiJp9fJ80rSyjJbn6+ygF6Fj9
 Frop2rtrDqfe57O2SWZrYSRaZYQVAh44BGoqfoMp24zp0VDWvZ6/a/8r0Hu88RSgIAFL
 UrMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsro64Z8ANJQpN3cXpMBaaZc1Csm4EDbRJ4KEgCdJsk5lmG20517iYql7HbfT1AnQRQz/lIboL0LeoELbIGtAUtIsQbjw=
X-Gm-Message-State: AOJu0YzdpKtZWgxaJdik2i9RBtUVjGonr2iMo00PSxgDbonbygtFnR7P
 RtNZDkd1crOmRbAQn3qxZWyISbcgUkH4NRSWx/ASq2M9C91yPJi/RJBF5YB2HAVUAk0CQKyqfaP
 bZEFnA1DMCYvR0xs91/JolHiMBVUcD1mThZpgnB+vWMmlg1KcSFcwaqpj5ZCYjyop6HZixWr6vS
 z58BeiOOqlWpKTmAbznuyVar2FhXY=
X-Received: by 2002:a17:902:d48c:b0:1e0:e2a4:1b1b with SMTP id
 c12-20020a170902d48c00b001e0e2a41b1bmr85792plg.0.1711508716691; 
 Tue, 26 Mar 2024 20:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1YN8Xh46DtOdiq9i/XfV3wqM6jW0QlwA41epKMr1b3AytgpLDmVkF3av48sWRZyl5vN17UWgf8Rl9Vg9jpvI=
X-Received: by 2002:a17:902:d48c:b0:1e0:e2a4:1b1b with SMTP id
 c12-20020a170902d48c00b001e0e2a41b1bmr85773plg.0.1711508716325; Tue, 26 Mar
 2024 20:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
In-Reply-To: <20240327012905.70188-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 11:05:05 +0800
Message-ID: <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Hi Cindy:

On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> we need a crash in Non-standard image, here is the jira for this https://=
issues.redhat.com/browse/RHEL-28522
> The root cause of the issue is that an IRQFD was used without initializat=
ion..
>
> During the booting process of the Vyatta image, the behavior of the calle=
d function in qemu is as follows:
>
> 1. vhost_net_stop() was called, this will call the function
> virtio_pci_set_guest_notifiers() with assgin=3D false, and
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0

Before vhost_net_stop(), do we know which vector is used by which queue?

>
> 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTORt
>
> 3.vhost_net_start() was called (at this time the configure vector is
> still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
> assgin=3D true, so the irqfd for vector 0 was not "init" during this proc=
ess

How does the configure vector differ from the virtqueue vector here?

>
> 4. The system continues to boot and msix_fire_vector_notifier() was
> called unmask the vector 0 and then met the crash
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
>
> The reason for not reproducing in RHEL/fedora guest image is because
> REHL/Fedora doesn't have the behavior of calling vhost_net_stop and then =
virtio_reset, and also won't call msix_fire_vector_notifier for vector 0 du=
ring system boot.
>
> The reason for not reproducing before configure interrupt support is beca=
use
> vector 0 is for configure interrupt,  before the support for configure in=
terrupts, the notifier process will not handle vector 0.
>
> For the device Vyatta using, it doesn't support configure interrupts at a=
ll, So we plan to disable the configure interrupts in unsupported device

Btw, let's tweak the changelog, it's a little bit hard to understand.

Thanks

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Cindy Lu (2):
>   virtio-net: disable the configure interrupt for not support device
>   virtio-pci: check if the configure interrupt enable
>
>  hw/net/virtio-net.c        |  5 ++++-
>  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----------------
>  hw/virtio/virtio.c         |  1 +
>  include/hw/virtio/virtio.h |  1 +
>  4 files changed, 29 insertions(+), 19 deletions(-)
>
> --
> 2.43.0
>


