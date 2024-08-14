Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8C1C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 12:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seDBl-00051N-VO; Wed, 14 Aug 2024 08:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1seDBh-0004qO-Dl
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1seDBf-0002CV-E5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723638789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Tlp6b5IFC7GwPxJeEHaxbBS24bb+9eJoPudWhL56zQ=;
 b=DIo60mG4Gb+XtZXzucUwqgelfbwccoy3tAaHK8NJaVS77JlZnyD4s5MMZBGT+UrYRFqPsn
 8sKZAFRi5Klf0SnJNaoVQNp16AHrbFhWTEUcZd4Ees5JU+2lchuAZG38vMEhIV1vgBeGzQ
 wxwg0lqJ1XL3SzM/SSJwEl51XsFkUE0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-vqnUmYzmNumyaL_Frn7-eg-1; Wed, 14 Aug 2024 08:33:06 -0400
X-MC-Unique: vqnUmYzmNumyaL_Frn7-eg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-709399c7828so10352247a34.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 05:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723638786; x=1724243586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Tlp6b5IFC7GwPxJeEHaxbBS24bb+9eJoPudWhL56zQ=;
 b=fTySVsBYTBjaTpzbDBri9NgAre0kcaLhN219nHEOXfHy1XfMwZOd11b1K76Wvo0N1y
 4cbsM3+vzeI/b7nPSziDgh7jjbWDU2Cr/FMhd9jOLjraWIqdj3ivZOzP/SfK3BnmvvR7
 Xl7DQHQo7zS4Ay32xWjgU4vGJPSsujDFI44x/qqB0D8nI1juXSTacBsjdI8vREFVnJQQ
 sE6Wqt/FeJrjKUeNcZpmEwDbS9VGZETzBkv5xkMuKyMZAAoSTthq6Hl/y9+/JVFE+jg9
 GfP18uKVKd6+Enig6oVnVwumSIKXHZWhYFIcx9KLwuwnyYnBPBdopmEjEwYdKHbf7uxm
 xbYA==
X-Gm-Message-State: AOJu0Yxclt98uPsulkoFgSgnoQilrAq4bO6S2WC422sKs4HeTLElI1eZ
 V6OWryquAqbN7tjVJMpYN7n3Idi2CJLmlOzI86ecDTF8Ro0IHvPJPYv3y0sfx5+JOSgaSyEVCZ0
 t3qKMc8gjWCfFCIZ2slxKG9Ysg0zvK8FCf5yvg9BYv4805vk2fx21BpTHsbVuvTjGoPWg9Jiknf
 Utbnwy4DZrIK0WCUzkb4YvLAVFjxQ=
X-Received: by 2002:a05:6830:3156:b0:709:46be:66df with SMTP id
 46e09a7af769-70c9d932ad9mr2170737a34.11.1723638785743; 
 Wed, 14 Aug 2024 05:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqrTjEbVjMoQ059B7kbIg1Pix18Ebr05WsltagdI4dIIorJ+ziNDLKSCPcUf+cCM+dflUq/3VBWizSSC57VkA=
X-Received: by 2002:a05:6830:3156:b0:709:46be:66df with SMTP id
 46e09a7af769-70c9d932ad9mr2170710a34.11.1723638785300; Wed, 14 Aug 2024
 05:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
In-Reply-To: <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Wed, 14 Aug 2024 14:32:54 +0200
Message-ID: <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 13, 2024 at 6:37=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 13 Aug 2024 at 16:39, Juraj Marcin <jmarcin@redhat.com> wrote:
> >
> > Some devices need to distinguish cold start reset from waking up from a
> > suspended state. This patch adds new value to the enum, and updates the
> > i386 wakeup method to use this new reset type.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >  docs/devel/reset.rst    | 8 ++++++++
> >  hw/i386/pc.c            | 2 +-
> >  include/hw/resettable.h | 2 ++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> > index 9746a4e8a0..a7c9467313 100644
> > --- a/docs/devel/reset.rst
> > +++ b/docs/devel/reset.rst
> > @@ -44,6 +44,14 @@ The Resettable interface handles reset types with an=
 enum ``ResetType``:
> >    value on each cold reset, such as RNG seed information, and which th=
ey
> >    must not reinitialize on a snapshot-load reset.
> >
> > +``RESET_TYPE_WAKEUP``
> > +  This type is called for a reset when the system is being woken-up fr=
om a
> > +  suspended state using the ``qemu_system_wakeup()`` function. If the =
machine
> > +  needs to reset its devices in its ``MachineClass::wakeup()`` method,=
 this
> > +  reset type should be used, so devices can differentiate system wake-=
up from
> > +  other reset types. For example, a virtio-mem device must not unplug =
its
> > +  memory during wake-up as that would clear the guest RAM.
> > +
> >  Devices which implement reset methods must treat any unknown ``ResetTy=
pe``
> >  as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
> >  existing code we need to change if we add more types in future.
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index ccb9731c91..49efd0a997 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *machin=
e, ResetType type)
> >  static void pc_machine_wakeup(MachineState *machine)
> >  {
> >      cpu_synchronize_all_states();
> > -    pc_machine_reset(machine, RESET_TYPE_COLD);
> > +    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
> >      cpu_synchronize_all_post_reset();
> >  }
>
> I'm happy (following discussion in the previous thread)
> that 'wakeup' is the right reset event to be using here.
> But looking at the existing code for qemu_system_wakeup()
> something seems odd here. qemu_system_wakeup() calls
> the MachineClass::wakeup method if it's set, and does
> nothing if it's not. The PC implementation of that calls
> pc_machine_reset(), which does a qemu_devices_reset(),
> which does a complete three-phase reset of the system.
> But if the machine doesn't implement wakeup then we
> never reset the system at all.
>
> Shouldn't qemu_system_wakeup() do a qemu_devices_reset()
> if there's no MachineClass::wakeup, in a similar way to
> how qemu_system_reset() does a qemu_devices_reset()
> if there's no MachineClass::reset method ? Having the
> wakeup event be "sometimes this will do a RESET_TYPE_WAKEUP
> but sometimes it won't" doesn't seem right to me...

From my understanding that I have gathered from the code (but please,
someone correct me if I am wrong), this is machine specific. Some
machine types might not support suspend+wake-up at all. The support
has to be explicitly advertised through qemu_register_wakeup_support()
(for example, aarch64 with a generic virt machine type does not
advertise support). Even if the machine type advertises
suspend+wake-up support, it might not need to do anything machine
specific. This is the case of pSeries PowerPC machine (sPAPR) that
advertises support, but does not implement MachineClass::wakeup()
method as nothing needs to change in the machine state. [1]

So, if a restart during wake-up happens, it can be differentiated with
the wake-up reset type, and if the machine type does not need to reset
its devices during wake-up, there is no reset that needs to be
differentiated.

[1]: https://gitlab.com/qemu-project/qemu/-/blob/a733f37aef3b7d1d33bfe2716a=
f88cdfd67ba64e/hw/ppc/spapr.c?#L3155

>
> thanks
> -- PMM
>

--=20
Juraj Marcin


