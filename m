Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ECBC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVsAa-0005YH-0Q; Mon, 22 Jul 2024 08:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1sVsAY-0005Ry-Cj
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1sVsAV-0004ge-4q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721651369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3Z9lCmSNxceTnSmHEo2WwVjGuiRt7+eFGpSiNo7HhI=;
 b=At5ZcddMxuJTfFWGSakbnEJ4NwKumN5uIGdj2pUQwgDTfi7IsiVzqYql6tar5HCLVqk8LP
 IyNfj/y59MgO2g0OdFAYuEhZ3E/RZUY4sC6rV7oylMDkCfXtADAvfmpQyzz0031aaEQNFf
 MEiwKGCfFnE7vKnYcEvWlz7MahYKEjo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-BIMWVKXkMXuZ-Kp6F4x0LA-1; Mon, 22 Jul 2024 08:29:28 -0400
X-MC-Unique: BIMWVKXkMXuZ-Kp6F4x0LA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb4ea563dfso4833290a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721651367; x=1722256167;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v3Z9lCmSNxceTnSmHEo2WwVjGuiRt7+eFGpSiNo7HhI=;
 b=gJJ8P0CMJUCFm8+plA92nYhPaDwoCJmE7ORRbd92kDjqoDDV50AHKiE05XY+cejteo
 KzS4XsQsQP+SLzoR1N7F4RwwU/PQh6PwgCbFFPGL65YCbFrQ5/q2zaFDEI2widvkdZYw
 h/b8Qhfhkbn9jNas7pHxKolTPaCCiMDZ1XdPF6MrjOcS5d1xbOyrAY82lryjmHAmWcGE
 dldt+Y3V0Ys0Ft1yFE2TVJ0ECnP0QEM4LL8TAmCL5NMSbglIrBipOaghaNniYqLlmu/K
 TVGTbA1btf66FEhGAJqNk+Mpqa2G87EK+ojbzp1+iyHfhDWStMI00KazOdig254cbyEe
 Kywg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr4mhyRx2gl6hN+vhaI7AbhO3CpMxBBDHiBcoZxvDvVhyMdiij5yUM82KPDPOY/TzCIrG779pmju2TjD1Mfv8+TkDoOms=
X-Gm-Message-State: AOJu0Ywe1XdT36cwlr1e21RlZbwg/jgHLHFc/mJYgwCtBNhO3lYkV30Z
 8qe6leno1vd4E9k4/VQebw/nCZ46h7ZxNGK61HPR79OfWdxUZpekDrl33Qqxw0HPlMv54GbNH53
 4fAVT9aPrq53ok46vsnfSfeZnSyOT0YMrrejk8cMWVhXpOq3O2hZhJ+JuQqj5M9LL7rMQtwsjJ5
 mVxD8gsVxQOPguXVbsvgd0DR9Pp9E=
X-Received: by 2002:a17:90b:3a8b:b0:2c9:4c3:3128 with SMTP id
 98e67ed59e1d1-2cd15e412e2mr6254854a91.0.1721651367505; 
 Mon, 22 Jul 2024 05:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDTpe6LQPgQM/rgbFRklsGfJPRa8l16ugUKRngwOiHVA4P45azQtWsQcF3QbnRxiKm9ImtIC1AXF9AADtmNWw=
X-Received: by 2002:a17:90b:3a8b:b0:2c9:4c3:3128 with SMTP id
 98e67ed59e1d1-2cd15e412e2mr6254841a91.0.1721651367118; Mon, 22 Jul 2024
 05:29:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jul 2024 08:29:25 -0400
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CAJ+F1CLGQzp-CpNVZZx8w4bi9NLUc3Q+-ReOO7C8xjNxKpQhyQ@mail.gmail.com>
References: <172150520664.2040.13953223569736513482-0@git.sr.ht>
 <CAJ+F1CJrhUD5wyQDDauoTY=hok0BM7hUx99+5mK4tC4YkhtM4g@mail.gmail.com>
 <CAAiTLFVv8_i4ucbRQOSi9=ARz7kPzV--8HNzZ05zoeKvuOkt5w@mail.gmail.com>
 <CAJ+F1CLGQzp-CpNVZZx8w4bi9NLUc3Q+-ReOO7C8xjNxKpQhyQ@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 08:29:25 -0400
Message-ID: <CAAiTLFWC_88xBj9c2D2t50k0y8NP6hSGJ1gCMukx5G0GWtVRoA@mail.gmail.com>
Subject: Re: [PATCH qemu] ui/gtk: Reuse input event slots for GdkEventTouch
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "~katharine_chui" <kwchuiaa@connect.ust.hk>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Jul 22, 2024 at 3:58=E2=80=AFPM Sergio Lopez Pascual <slp@redhat.=
com> wrote:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > Adding Sergio in CC, who wrote that code. I don't have means to test i=
t,
>> > which also limits my understanding and ability to check this.
>> >
>> > On Sat, Jul 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui <
>> katharine_chui@git.sr.ht>
>> > wrote:
>> >
>> >> From: Katharine Chui <kwchuiaa@connect.ust.hk>
>> >>
>> >> There seems to be no guarantee as to how GdkEventTouch.sequence
>> >> would progress https://docs.gtk.org/gdk3/struct.EventTouch.html
>> >>
>> >>
>> > True, we also abuse the internal implementation which stores low integ=
ers
>> > in the sequence pointer.
>> >
>> > In the case of steam gamescope session, touch input would
>> >> increment the number every touch, resulting in all touch inputs
>> >> after the 10th touch to get dropped
>> >>
>> >> ...
>> >> qemu: warning: Unexpected touch slot number:  10 >=3D 10
>> >> qemu: warning: Unexpected touch slot number:  11 >=3D 10
>> >> qemu: warning: Unexpected touch slot number:  12 >=3D 10
>> >> qemu: warning: Unexpected touch slot number:  13 >=3D 10
>> >> qemu: warning: Unexpected touch slot number:  14 >=3D 10
>> >> ...
>> >>
>> >> Reuse the slots on gtk to avoid that
>> >>
>> >
>> > But doing modulo like this, there is a chance of conflict with already
>> used
>> > slots.
>> >
>> > Maybe it's time for a better gtk implementation which would handle a
>> proper
>> > sequence pointer to slot mapping.
>>
>> The problem with slots vs. sequences is that, from what I can see,
>> there's not way to obtain the slot number from EventTouch, which makes
>> me thing we're a little to high in the abstraction layer to emulate
>> multi-touch properly. And with GTK4 it seems to be even worse, because
>> it tries harder to process gestures on its own (we need them to be
>> processed by the guest instead).
>>
>> Under some compositors, we were lucky enough that indeed slots =3D=3D
>> sequences, so we could actually pass those events as that and have the
>> guest process and recognize simple gestures (i.e. pinching) properly.
>>
>> The "right" solution would be finding a way to operate at a lower level
>> than what EventTouch provides us today, but I don't know how feasible is
>> that from within the limits of the ui/gtk3.c.
>>
>> In case that's not possible, the modulo workaround is probably as good
>> as we can get.
>>
>
> Can't we map the sequence pointer to a (reusable) counter? So up to
> max-slots sequences could be mapped uniquely and we would reject events
> that do not fit within max-slots.

A slot is a "contact" in the screen (usually a finger), and should
remain the same for the events generated from that contact until it's
raised from the screen. That is, for a two-fingers pinch gesture, all
the events coming from one finger should have slot =3D=3D X, and the ones
coming from the other finger should slot =3D=3D Y, where X and Y never
change during the gesture.

In compositors where slot =3D=3D sequence, we get exactly this behavior. On
compositors where sequence is always increasing, assuming it's kept the
same for the duration of a contact, the modulo option can do the trick
just fine, as long we don't need to support more than 10 contact points
(which seems unlikely to me).

Sergio.


