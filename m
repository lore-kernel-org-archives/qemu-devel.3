Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E51C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgNTT-0003xp-Pr; Tue, 20 Aug 2024 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgNTR-0003wg-NK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:56:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgNTP-0001b1-Df
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:56:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so4335729a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724154985; x=1724759785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpf6SQjLnvnDQMNl6j510hoMjaPvsD0MT/Ogv/sHXtU=;
 b=Ml91QxHgRCws4/5QhgeBQdjKoPBpW0/PuLRYt7M1v4PSOLySE5rUP4ZuWccWWrksHr
 sttVoK4QkgiEfCo9rgRPbGjCjLpxLWIMg23zVmrko3N+3G1D9+kfY3kLglD+zQiQMeR5
 ZmDA4Ark9ZTDufRhlAApYwM7VotIsNg8jtTcl/HWwO8yn1O08DyN8Pm1J492SBfsBuMc
 JxpDKoLhRfs3czpGLv7RgtRLmX+IDF9vaLHBEkyI9Zwy/KCshCnfRq6BMBrT40PGLcUR
 /zS2ZVmP671KH1oAIkVDhOhAPYrEBrdR1sl6L4pGLOFM3uMjJhpSwq8LghqURmuczU1o
 xMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724154985; x=1724759785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cpf6SQjLnvnDQMNl6j510hoMjaPvsD0MT/Ogv/sHXtU=;
 b=bwliPi/qo72N+Rhb21hXlBvpfS0V0MNYOs++LU9Pu2rHA+Oy4LO6xD5sLOevbhUsEP
 r1PrAu9chBel6WeiTnDeNMLSwe80iZWUcOckOCG7ovOrbNyeFaH+HrqaZnmGSroTD46G
 YxZVRYVe51lnPJq54LR/T63eDee9Rid79s4g/hj6y1KvynY0gG+U9x3t+qZ9gRJZSkyi
 MPVnsNZP8HCc1jul5i1xMr5uyig4ATNN/gdhqq17rgiDobbCzP5H6/MB8p/I70p4r2x6
 FUbvNnpspLH25Dw0aUhy1uPqaLrE3IEsbrxi9tPYvI4NlSv9LGghRAebwctzUsJZv2a/
 WgNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVAVO2ddu7OAoQ3eR6gOoBWpAC6GSt1jUxiDr2vgN1VWCu5ingHrh+o9dNDGjxUFghrZsGkLfCXUtdAp+aw3XqEkuD8VE=
X-Gm-Message-State: AOJu0YyPLFeYdp1HnpCD01GCeEMeD+phnoU2IK4V5sKyfhE8Egnp0fAm
 fBEV56J0LW0ZoPeb3EO0CpUdpwhMGu75GzbueQVmfUpqVhxV0KZARw2NN0MnX3zK8bmYCFbGxIU
 uogei0B0yl8rACg0cy/bK3q6ptkZqXaVDlbawQQ==
X-Google-Smtp-Source: AGHT+IHLMv9fdUA79UUFY5YHx48657b0ToroVGwQicJpmNyKLRo2Sg9+nXezg2BE3qFe6/l70cGxQESLrvxEwCqx97g=
X-Received: by 2002:a05:6402:26c5:b0:5be:e1bc:2304 with SMTP id
 4fb4d7f45d1cf-5bee1bc25e6mr6007249a12.7.1724154985156; Tue, 20 Aug 2024
 04:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
 <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
 <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
In-Reply-To: <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 12:56:14 +0100
Message-ID: <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 20 Aug 2024 at 12:40, David Hildenbrand <david@redhat.com> wrote:
>
> On 14.08.24 14:32, Juraj Marcin wrote:
> > On Tue, Aug 13, 2024 at 6:37=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> >>
> >> On Tue, 13 Aug 2024 at 16:39, Juraj Marcin <jmarcin@redhat.com> wrote:
> >>>
> >>> Some devices need to distinguish cold start reset from waking up from=
 a
> >>> suspended state. This patch adds new value to the enum, and updates t=
he
> >>> i386 wakeup method to use this new reset type.
> >>>
> >>> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> >>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>   docs/devel/reset.rst    | 8 ++++++++
> >>>   hw/i386/pc.c            | 2 +-
> >>>   include/hw/resettable.h | 2 ++
> >>>   3 files changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> >>> index 9746a4e8a0..a7c9467313 100644
> >>> --- a/docs/devel/reset.rst
> >>> +++ b/docs/devel/reset.rst
> >>> @@ -44,6 +44,14 @@ The Resettable interface handles reset types with =
an enum ``ResetType``:
> >>>     value on each cold reset, such as RNG seed information, and which=
 they
> >>>     must not reinitialize on a snapshot-load reset.
> >>>
> >>> +``RESET_TYPE_WAKEUP``
> >>> +  This type is called for a reset when the system is being woken-up =
from a
> >>> +  suspended state using the ``qemu_system_wakeup()`` function. If th=
e machine
> >>> +  needs to reset its devices in its ``MachineClass::wakeup()`` metho=
d, this
> >>> +  reset type should be used, so devices can differentiate system wak=
e-up from
> >>> +  other reset types. For example, a virtio-mem device must not unplu=
g its
> >>> +  memory during wake-up as that would clear the guest RAM.
> >>> +
> >>>   Devices which implement reset methods must treat any unknown ``Rese=
tType``
> >>>   as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount o=
f
> >>>   existing code we need to change if we add more types in future.
> >>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >>> index ccb9731c91..49efd0a997 100644
> >>> --- a/hw/i386/pc.c
> >>> +++ b/hw/i386/pc.c
> >>> @@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *mach=
ine, ResetType type)
> >>>   static void pc_machine_wakeup(MachineState *machine)
> >>>   {
> >>>       cpu_synchronize_all_states();
> >>> -    pc_machine_reset(machine, RESET_TYPE_COLD);
> >>> +    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
> >>>       cpu_synchronize_all_post_reset();
> >>>   }
> >>
> >> I'm happy (following discussion in the previous thread)
> >> that 'wakeup' is the right reset event to be using here.
> >> But looking at the existing code for qemu_system_wakeup()
> >> something seems odd here. qemu_system_wakeup() calls
> >> the MachineClass::wakeup method if it's set, and does
> >> nothing if it's not. The PC implementation of that calls
> >> pc_machine_reset(), which does a qemu_devices_reset(),
> >> which does a complete three-phase reset of the system.
> >> But if the machine doesn't implement wakeup then we
> >> never reset the system at all.
> >>
> >> Shouldn't qemu_system_wakeup() do a qemu_devices_reset()
> >> if there's no MachineClass::wakeup, in a similar way to
> >> how qemu_system_reset() does a qemu_devices_reset()
> >> if there's no MachineClass::reset method ? Having the
> >> wakeup event be "sometimes this will do a RESET_TYPE_WAKEUP
> >> but sometimes it won't" doesn't seem right to me...
>
> One thing one could consider would probably be to send a WARM reset to
> all devices. The main issue here is that other devices will default to a
> COLD device then, and that's precisely what the other machines that
> implement suspend+resume do not want. And ...
>
> >
> >  From my understanding that I have gathered from the code (but please,
> > someone correct me if I am wrong), this is machine specific. Some
> > machine types might not support suspend+wake-up at all. The support
> > has to be explicitly advertised through qemu_register_wakeup_support()
> > (for example, aarch64 with a generic virt machine type does not
> > advertise support). Even if the machine type advertises
> > suspend+wake-up support, it might not need to do anything machine
> > specific. This is the case of pSeries PowerPC machine (sPAPR) that
> > advertises support, but does not implement MachineClass::wakeup()
> > method as nothing needs to change in the machine state. [1]
> >
> > So, if a restart during wake-up happens, it can be differentiated with
> > the wake-up reset type, and if the machine type does not need to reset
> > its devices during wake-up, there is no reset that needs to be
> > differentiated.
>
> ... if the machine does not do any resets during suspend+wakeup, this
> implies that there is not even a warm reset.
>
> I guess we should make that clearer in the documentation: it's up to a
> machine implementation whether it wants to trigger a WARM reset during
> suspend+wakeup. If not, not resets will be performed at all.
>
> @Peter, does that sound reasonable?

Well, so far we've established that we need a "WAKEUP" reset
type, but not that we need a "WARM" reset type. The latter
would be something we'd need to trigger for quite a lot of
reset-causes where we currently default to COLD reset, so
I don't think we should do that until we need it.

If suspend-and-wakeup really is supposed to be a reset event
on some machines but not on others, that sounds unhelpfully
nonstandard, but then hardware designers rarely make choices
to make our lives easier :-) And yes, we should make sure
that's clear in the documentation.

I think with adding new reset events it's going to be
important that we're clear about what they are (and in
particular what the triggering events that cause them
are) so that we have a solid guide for what it means.
The thing in particular I'm hoping to avoid here is that
we vaguely define, for example, a "warm" reset type and then
different parts of the system interpret "warm" in different
ways.

thanks
-- PMM

