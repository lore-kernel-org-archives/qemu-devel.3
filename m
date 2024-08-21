Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A0FC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 17:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgov3-00089B-B2; Wed, 21 Aug 2024 13:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1sgouy-00087p-9u
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 13:14:45 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1sgouu-0003W3-Io
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 13:14:44 -0400
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so5045047a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 10:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724260478; x=1724865278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXy8nRmiYZ5wpHiQVlNJVfqhLoNcaRTm8ZpBVeJ9g0I=;
 b=bEmtrPwvbLoxyFW0/fx9dilTsEum5o34KJ2xzyAOk/qIDGwtp9iiGzoaI9TC6BfSjR
 ua+ECylCcJxDDx7LKCtnDPaoagf/ShHuriB7o6I8kroHam5uZeu3N+zQQAQwzCIcv6uo
 OfSFb3pNEV6GwzoaLRgBEIcY6r/MiwqiLfLytq8msVyg23H12Q2/vlKPDOK1+SNffsUi
 jfgqe3Phps+KjKcssrreajDbRIkeSTMF96ZfehFer2I1qWU1U0JlTI2h1oIksnuwM6vx
 YI/YmS5Ur21PLBLF7CpOlePi40tBXJgSmBUntVsG+QOOMgw8tk73DyFXvUVF6kF0VXGE
 0AJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbaPnbzPYQmW8+Hnbj5taF7Y2xC6+w1hI/A9SyreHfsJDajUfb0fhz4EVC5O2VBSRQVhrQpv8pMETy@nongnu.org
X-Gm-Message-State: AOJu0YyKosKIX+YzD581Y71d1668tD+M26wllLj3qUKvhwhFMcxO1gPu
 za6seXKqtBvOPHg3A5EkSzDohxgSbqnt8fai6WK3AYeY9ld6uajyWdcFXDYyf87x6fkKFYXgqir
 GpBaZq2/QNpvl6H6M4xHXb1ytBdU=
X-Google-Smtp-Source: AGHT+IEgGXK6E1mcJbC0lTNs8fizDVxrP5ks7EfZ/C4rk+XY4dLPTpF3YuLts0iiDwySQdaZNsKLFHsnPAKdsjREjk0=
X-Received: by 2002:a17:90a:9114:b0:2d3:bd5c:4ac8 with SMTP id
 98e67ed59e1d1-2d5ea4c61d0mr3369337a91.27.1724260477861; Wed, 21 Aug 2024
 10:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
 <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
 <c7116b2f-9afd-4aa1-b553-7574efedf7a4@ilande.co.uk>
In-Reply-To: <c7116b2f-9afd-4aa1-b553-7574efedf7a4@ilande.co.uk>
Date: Wed, 21 Aug 2024 10:14:26 -0700
Message-ID: <CABJXFgW+ziekfe-D+UCYyKcdhm3U1TFUuZrFa0b19kUh9LEM2A@mail.gmail.com>
Subject: Re: [PATCH] hw/char: suppress sunmouse events with no changes
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.215.182;
 envelope-from=carl.hauser@gmail.com; helo=mail-pg1-f182.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Carl Hauser <chauser@pullman.com>
From:  Carl Hauser via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

More on whether the sunmouse_prev_state needs to be migrated. I think
that if it were NOT included in the migration state the following
would hold, assuming that it would be initialized to 0 in the "to"
environment:
1. If prev_state is 0 in the "from" environment the prev_state in the
"to" environment would be correct -- and this would be the case almost
all the time.
2. If it is non-0 in the "from" environment (so the guest OS believes
there is a mouse button pressed) and the first mouse event in the "to"
environment has motion, the event will be sent correctly and the
prev_state is then correct; likely almost all of the rest of the time.
3. If it is non-0 in the "from" environment (so the guest OS believes
there is a mouse button pressed) and the first mouse event in the "to"
environment has no motion and non-zero button state the event will be
sent and there are two cases:
3a. if the button state is NOT the same as the prev state in the
"from" environment the event will have been sent correctly.
*3b. if the button state IS the same as prev_state  in the "from"
environment (so the guest OS believes there is a mouse button pressed)
the event will have been sent incorrectly and is a duplicate. The
prev_state in the "to" environment will now be correct and no further
duplicates will be sent.
*4. If it is non-0 in the "from" environment (so the guest OS believes
there is a mouse button pressed) and the first mouse event(s) in the
"to" environment has no motion and zero button state, the event will
not be sent. It is not apparent that the code that carries mouse
events from the host to the escc driver level would ever produce such
an event as the first one or ones, but if it did the state would
persist until there was mouse motion or a button press event. The
consequence would be that the guest would continue to understand that
a mouse button was pressed when it was not. The situation gets
corrected on any mouse movement or button press.

So the starred cases, 3b and 4, are the only incorrect behaviors. Both
are likely extremely rare and hard to make happen. Case 3b results in
one spurious duplicate event sent to the guest. I have only seen
Solaris misbehave in  the face of a flood of duplicate events. My
testing with linux didn't uncover any misbehavior even when flooded
with duplicates. NetBSD 10 has other mouse misbehaviors that make it
hard to tell whether or not duplicates matter there. In case 4, the
guest would continue to believe a mouse button was depressed when it
wasn't but this would be cured by any button press or movement.

It appears that this is all quite similar to the way caps_lock_mode
and num_lock_mode are handled in escc -- they are both part of the
ESCCChannelState but not part of the migration state and I would
expect would exhibit similar need to see transitions in some cases
before getting the state fully correct after a migration.

On Wed, Aug 21, 2024 at 7:18=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 20/08/2024 08:34, Richard Henderson wrote:
>
> > On 8/20/24 09:18, Carl Hauser wrote:
> >> @@ -959,6 +960,15 @@ static void sunmouse_event(void *opaque,
> >>       int ch;
> >>
> >>       trace_escc_sunmouse_event(dx, dy, buttons_state);
> >> +
> >> +    /* Don't send duplicate events without motion */
> >> +    if (dx =3D=3D 0 &&
> >> +        dy =3D=3D 0 &&
> >> +        (s->sunmouse_prev_state ^ buttons_state) =3D=3D 0) {
> >
> > Were you intending to mask vs MOUSE_EVENT_*BUTTON?
> > Otherwise this is just plain equality.
> >
> >> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> >> index 5669a5b811..bc5ba4f564 100644
> >> --- a/include/hw/char/escc.h
> >> +++ b/include/hw/char/escc.h
> >> @@ -46,6 +46,7 @@ typedef struct ESCCChannelState {
> >>       uint8_t rx, tx;
> >>       QemuInputHandlerState *hs;
> >>       char *sunkbd_layout;
> >> +    int sunmouse_prev_state;
> >
> > This adds new state that must be migrated.
> >
> > While the patch is relatively simple, I do wonder if this code could be=
 improved by
> > converting away from the legacy mouse interface to qemu_input_handler_r=
egister.
> > Especially if that might help avoid needing to add migration state that=
 isn't
> > "really" part of the device.
> >
> > Mark?
>
> Ooof I didn't even realise that qemu_add_mouse_event_handler() was legacy=
 - is that
> documented anywhere at all?
>
> At first glance (e.g.
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/input/ps2.c?ref_typ=
e=3Dheads#L789)
> it appears that movement and button events are handled separately which I=
 think would
> solve the problem.
>
> I can try and put something together quickly for Carl to test and improve=
 if that
> helps, although I'm quite tied up with client work and life in general ri=
ght now(!).
>
>
> ATB,
>
> Mark.
>
>

