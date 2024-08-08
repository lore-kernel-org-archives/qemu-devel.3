Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc543-0000sY-5G; Thu, 08 Aug 2024 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sc540-0000s2-Sw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sc53z-0005Ft-7v
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723130905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4/s/SNPHDS2/aGlsqN4fklHjDyLla08hCb+GJlkLxQ=;
 b=WBvWkb7GJ2Vxnsnez1AI4euc+Nvew7TDY7ASh73j7d2Q9VOgyfOAHSJ6op/dCyHRp9kPgs
 uDjQgK4msO9PiuQoUFWKVvj/GIAkL/TqXnX4Q+woS6QBODhnyAlMuCBhoVuVfAtNbkbAuD
 TRX5XhY2EslYRm+TvwLkHdk+1kn8VQM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-WJ4LKvfDM42qO2jksWnLiw-1; Thu, 08 Aug 2024 11:28:23 -0400
X-MC-Unique: WJ4LKvfDM42qO2jksWnLiw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e0bfd36cda0so3427525276.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723130903; x=1723735703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4/s/SNPHDS2/aGlsqN4fklHjDyLla08hCb+GJlkLxQ=;
 b=Sjvx4gbNvcUZRfbUDomapyqfV9SXFqWp+WH3jDouAZq2OQaWSNtYWvJP90hPX7h7+y
 LY/v57e00LWpn3B8EVXTWzvJ7jtitxUd7azHNtvzOHpKoIiyPIyvASIiywjK+Au1eiB4
 ecFoJ9ogN0Ea42aUU9coDR7lVFLOjnbCU0J8NPpN2BZzrxYN9W+BAPAUzCM013o7vq15
 RyVyEk/Wfg7i9FBdfqQ35alM+W3cFUQh3MnJnlwYqekqWakvxhEX8G0v3b8s4ZwmKSbU
 SrrTaLHbyK4FDXG9Rm9FS0qdoaqdujIqAMBAwYopQdflKyVvgJ6mUitZvZ4VG6fgD1+8
 XS+g==
X-Gm-Message-State: AOJu0YzVoC1ZDO3BjuhvbfhcT/pouG4LtDjlvN9ELf9JJfvzJk2P9UOe
 amqwSLTZOzzJRifRK8vm5IdhdhLj46HbK3lfRUbEhoJZOo3VRQJbvJSoIZJ8q69i3RLOsVAx6es
 xfBKDxzxd0Xox40kV5uEQ7ttvQ3sg0m7VXmjCZFhpBI00aX5tnFIOgaoDzQpWRxJUBI5XGyZ5rG
 cVuf9IpBPOqpU1JVpnLpG+8ywVmnQ=
X-Received: by 2002:a05:6902:210b:b0:e0e:8738:1a2c with SMTP id
 3f1490d57ef6-e0e9f944f54mr1497132276.2.1723130902798; 
 Thu, 08 Aug 2024 08:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzILw8m3xAAKhdmwa3RgNn/muNAvZX13iXC5HgQMEnK634CG5CCY/Y8r6KrP9NV8WRxTK/kpwuJwG/Y+0LHyc=
X-Received: by 2002:a05:6902:210b:b0:e0e:8738:1a2c with SMTP id
 3f1490d57ef6-e0e9f944f54mr1497108276.2.1723130902374; Thu, 08 Aug 2024
 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Thu, 8 Aug 2024 17:28:11 +0200
Message-ID: <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Aug 8, 2024 at 2:18=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
> >
> > Some devices need to distinguish cold start reset from waking up from a
> > suspended state. This patch adds new value to the enum, and updates the
> > i386 wakeup method to use this new reset type.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  docs/devel/reset.rst    | 7 +++++++
> >  hw/i386/pc.c            | 2 +-
> >  include/hw/resettable.h | 2 ++
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> > index 9746a4e8a0..30c9a0cc2b 100644
> > --- a/docs/devel/reset.rst
> > +++ b/docs/devel/reset.rst
> > @@ -44,6 +44,13 @@ The Resettable interface handles reset types with an=
 enum ``ResetType``:
> >    value on each cold reset, such as RNG seed information, and which th=
ey
> >    must not reinitialize on a snapshot-load reset.
> >
> > +``RESET_TYPE_WAKEUP``
> > +  This type is used when the machine is woken up from a suspended stat=
e (deep
> > +  sleep, suspend-to-ram). Devices that must not be reset to their init=
ial state
> > +  after wake-up (for example virtio-mem) can use this state to differe=
ntiate
> > +  cold start from wake-up can use this state to differentiate cold sta=
rt from
> > +  wake-up.
>
> I feel like this needs more clarity about what this is, since
> as a reset type it's a general behaviour, not a machine
> specific one. What exactly is "wakeup" and when does it happen?
> How does it differ from what you might call a "warm" reset,
> where the user pressed the front-panel reset button?
> Why is virtio-mem in particular interesting here?

Thank you for the feedback!

I have rewritten the paragraph:

This type is called for a reset when the system is being woken up from
a suspended state using the ``qemu_system_wakeup()`` function. If the
machine type needs to reset in its ``MachineClass::wakeup()`` method,
this reset type should be used so that devices can differentiate
system wake-up from other reset types. For example, a virtio-mem
device must not unplug its memory during wake-up, as that would clear
the guest RAM.

Is it clearer? Thank you!

>
> thanks
> -- PMM
>

--

Juraj Marcin


