Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F30C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 18:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdvrK-0003Op-6H; Tue, 13 Aug 2024 14:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sdvrI-0003Nc-Fm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:03:00 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sdvrG-0002hR-Ja
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:03:00 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db504ab5f3so3470255b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723572177; x=1724176977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YLvE1JC3daxR+kSJIM0ZsvDuhfgqoHsFEoMrwwhN2c=;
 b=PZFThkY9jSbyMRx8Iy/9YXPkl8U6YrB7qXpWfZux1E9pqwmKSx9MtyVffhSX3zZWT4
 GsrD51xt+5+vgleURNX382nViaEVKHZXw/+56tPofCeefjnkPcl58SZHnW4uNwvZQUFr
 0AytBC/VUc+C+RXARIsyHTJqfJ6f5S8QDMqBrrglcYkvyZxSJ6GwQiXGAXfVHnFYBWdK
 2Pa5ueoQXmLFkr4mjKLz9o2lKLXdNr5+95DMqCh6qGMCM4X8cv3UZVEddRh9htkSCHs4
 +zcX+OD84v59ZifqBLvuIgA+cf/msAiCwjd0Q9X4HIcB+7c3X2QSAS/ExU8n/6t/aEa4
 CUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723572177; x=1724176977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YLvE1JC3daxR+kSJIM0ZsvDuhfgqoHsFEoMrwwhN2c=;
 b=k6f5qMtwKfjatN2vMo82l8DwJROo7qegyN0u417eDXzKzpPyVdtofiqq/AyymTpglL
 YbHOXAkw3zBoI3DsDVbBx6xDuPKwgnH+sOaRyKgldQWfEUHT4VYUuTwlgXXbztf47/WV
 fYAk4koEoddAX6AGIocyRjgSI/sAFgbnGZT+fhYGarKfKB1Ir48qG49tD0C4Beb9Hy3L
 1BwMEEw4iDYNdvzRR9c+VR6HCIZbrbxtSfEny8toEdA2dQnlG4ZoBGqrASjDegoa8nVi
 qID5jK6uubjP1O3n9ClIqrEwZa2vSN3dlqdH4zFZh9Hkk1ai0lmKbpZ/7QMvHjlRrShY
 agqQ==
X-Gm-Message-State: AOJu0Ywm6jzqCvTkZ8FPsfW7KUJ3asZUxehpU6VhRbCh0nZ7IYN7e57n
 JrQG2YwMfp2HDUaSowdQFjHyvUrowQ61Wd92VvUmxuv2jMB187N45dLEMvDWnCLFlwg/dpJos83
 2ih7vTi3+c4tGnJduG9Rfbg1LFGk=
X-Google-Smtp-Source: AGHT+IHB6WtuxtAd0TqNp24Y2Nk33tBZrIgJE3ySWpiNLdLRLFwt0WQZHLAbneKprRpjpsLSLPUcZbLWXsDdkkPSaPI=
X-Received: by 2002:a05:6358:5241:b0:1ac:f373:d952 with SMTP id
 e5c5f4694b2df-1b1aad59c28mr27864755d.27.1723572176730; Tue, 13 Aug 2024
 11:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-3-dorjoychy111@gmail.com> <ZrobFFVV4tN6dueh@redhat.com>
In-Reply-To: <ZrobFFVV4tN6dueh@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 14 Aug 2024 00:02:48 +0600
Message-ID: <CAFfO_h7nNatk=WgGiZcrTR_YEhAYniY=aeBrsxsnE_KEv+fL4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] machine/nitro-enclave: Add vhost-user-vsock device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 8:24=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, Aug 10, 2024 at 10:44:59PM +0600, Dorjoy Chowdhury wrote:
> > AWS Nitro Enclaves have built-in vhost-vsock device support which
> > enables applications in enclave VMs to communicate with the parent
> > EC2 VM over vsock. The enclave VMs have dynamic CID while the parent
> > always has CID 3. In QEMU, the vsock emulation for nitro enclave is
> > added using vhost-user-vsock as opposed to vhost-vsock. vhost-vsock
> > doesn't support sibling VM communication which is needed for nitro
> > enclaves.
> >
> > In QEMU's nitro-enclave emulation, for the vsock communication to CID
> > 3 to work, another process that does the vsock emulation in  userspace
> > must be run, for example, vhost-device-vsock[1] from rust-vmm, with
> > necessary vsock communication support in another guest VM with CID 3.
> > A new mandatory nitro-enclave machine option 'vsock' has been added.
> > The value for this option should be the chardev id from the '-chardev'
> > option for the vhost-user-vsock device to work.
> >
> > Using vhost-user-vsock also enables the possibility to implement some
> > proxying support in the vhost-user-vsock daemon that will forward all
> > the packets to the host machine instead of CID 3 so that users of
> > nitro-enclave can run the necessary applications in their host machine
> > instead of running another whole VM with CID 3.
> >
> > [1] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vso=
ck
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  backends/hostmem-memfd.c        |   2 -
> >  hw/core/machine.c               |  71 +++++++++---------
> >  hw/i386/Kconfig                 |   1 +
> >  hw/i386/nitro_enclave.c         | 123 ++++++++++++++++++++++++++++++++
> >  include/hw/boards.h             |   2 +
> >  include/hw/i386/nitro_enclave.h |   8 +++
> >  include/sysemu/hostmem.h        |   2 +
> >  7 files changed, 174 insertions(+), 35 deletions(-)
> >
>
> > diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
> > index 98690c6373..280ab4cc9b 100644
> > --- a/hw/i386/nitro_enclave.c
> > +++ b/hw/i386/nitro_enclave.c
> > @@ -11,11 +11,81 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > +#include "qom/object_interfaces.h"
> >
> > +#include "chardev/char.h"
> > +#include "hw/sysbus.h"
> >  #include "hw/core/eif.h"
> >  #include "hw/i386/x86.h"
> >  #include "hw/i386/microvm.h"
> >  #include "hw/i386/nitro_enclave.h"
> > +#include "hw/virtio/virtio-mmio.h"
> > +#include "hw/virtio/vhost-user-vsock.h"
> > +#include "sysemu/hostmem.h"
> > +
> > +static BusState *find_free_virtio_mmio_bus(void)
> > +{
> > +    BusChild *kid;
> > +    BusState *bus =3D sysbus_get_default();
> > +
> > +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> > +        DeviceState *dev =3D kid->child;
> > +        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)) {
> > +            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(OBJECT(dev));
> > +            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
> > +            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
> > +            if (QTAILQ_EMPTY(&mmio_bus->children)) {
> > +                return mmio_bus;
> > +            }
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
> > +{
> > +    DeviceState *dev =3D qdev_new(TYPE_VHOST_USER_VSOCK);
> > +    VHostUserVSock *vsock =3D VHOST_USER_VSOCK(dev);
> > +    BusState *bus;
> > +
> > +    if (!nems->vsock) {
> > +        error_report("A valid chardev id for vhost-user-vsock device m=
ust be "
> > +                     "provided using the 'vsock' machine option");
> > +        exit(1);
> > +    }
> > +
> > +    bus =3D find_free_virtio_mmio_bus();
> > +    if (!bus) {
> > +        error_report("Failed to find bus for vhost-user-vsock device")=
;
> > +        exit(1);
> > +    }
> > +
> > +    Chardev *chardev =3D qemu_chr_find(nems->vsock);
> > +    if (!chardev) {
> > +        error_report("Failed to find chardev with id %s", nems->vsock)=
;
> > +        exit(1);
> > +    }
> > +
> > +    vsock->conf.chardev.chr =3D chardev;
> > +
> > +    qdev_realize_and_unref(dev, bus, &error_fatal);
> > +}
>
> Why does this machine need to create the vhost-user-vsock device itself ?
> Doing it this way prevents the mgmt app from changing any of the other
> vsock device settings beyond 'chardev'. The entity creating QEMU can use
> -device to create the vsock device.
>

Hi Daniel. Good point. The reason to make the vhost-user-vsock device
built-in is because nitro VMs will always need it anyway (like the
virtio-nsm device which is built-in too). When an EIF image is built
using nitro-cli the "init" process in the EIF image tries to connect
to (AF_VSOCK, CID 3, port 9000) to send a heartbeat and expects a
heartbeat reply. So my understanding is that if we don't create it
inside the machine code itself, users would always need to provide the
explicit options for the device anyway. But as you point out this also
makes the device settings non-configurable.

Hey Alex, do you have any suggestions on this?

Regards,
Dorjoy

