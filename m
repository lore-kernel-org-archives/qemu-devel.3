Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5574FD65C6D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBX9e-0003T8-Hj; Thu, 14 Nov 2024 05:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBX9Y-0003Sb-6e
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:32:44 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBX9V-0005td-MO
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:32:43 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso4274205ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731580359; x=1732185159;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUcS7xHNS/AIdEVeGwDv8iR0VwSii73wpmKr9mrhXzw=;
 b=bo+3iveuIgIK3JYZl0s7903i9jRjCCE++R6l64OeEU7mKIeDuaNz3b5VMWLjvr6nzI
 ggKZ9e2QP2Wjp5zwXp0IORPwzmi5vrhZqiK8DSfUxZWQ+bp7O2eZ5tPgadC6WMfFxM9L
 SAOgaa3WebZ0fiI+OGYbTOt1u49iQiWPfaLoxy9ktLeQSWUH316K9JaQ2LHEk/O9iNht
 ysycV4bXFaJ8G88DWL5Yu11VuG6QS0sBJz1uwVz5eg/za8eWsKuFQa5T3UuFWjzpKRfL
 uYY4CPjDfvowPF/cxxqk/jmNXw6/zrBMy8KVFY6wUT0NmtZo3tyRfnEXMqdHsqaiAKp5
 xntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731580359; x=1732185159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUcS7xHNS/AIdEVeGwDv8iR0VwSii73wpmKr9mrhXzw=;
 b=eup2wy5j2blYuJWI3Kct1TUUKqMMwn/MM5dlbDiZeEhbhTVbeQNNhbdsuGHpZ40FhM
 c9+288BU1UEtICCA8YyRoFQ1+6Xj4nD/20X6msmJC0ObDUh3BfAaXz397+Dqy0mfRzd8
 d4FdZDuxi0K7kntLFD8KeqGQ9oUUfjpmCURyyVF8AeH0OJMLdpXG6a8ikVC/4ulo21oV
 ay4DSYBm8sQFrUrv9tQv/DnbAOusZ8ixB70dcKdW39Fu/WldOJT/OpavygsTPoCptO90
 fx0tAJtHIecgXrdu1FvWx4UHY7VxJbuDR/zSU1CUBJDfkweX7ev1mKbnJUxoBnLzzqm6
 Y8KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzFBDGIU0sS1k7R8xLyhecSSqdzCUdANpQ5Vnwh53J/fis76nfXVy73Q5GkDXJEqYzyKJZlPLjz2GO@nongnu.org
X-Gm-Message-State: AOJu0YwJYMQUZd8XM7DVMLQpNE3sSA1ZW5+XVcZQT0+FksxBWPNsCGDW
 EY7kedeIJWaT+5KkIIvIOBf0dEYNgjD+SIpB/wDDjnbY2tuE/aDywpGBp2TDLKga5U8C/uGeWUU
 ke7oMV2pP5liELT4FBbMZRlYT4JuxvB7WLjpU
X-Google-Smtp-Source: AGHT+IEwf6daURU98PoTrjFvkbBGYAbnaMv2GJadseNyBobVdUk3nS1BzeHl20PfUw9JQ6QaByk/cWCL+/lY3rXU1NA=
X-Received: by 2002:a17:902:facf:b0:210:e75f:e6b0 with SMTP id
 d9443c01a7336-21183e0dd11mr238339635ad.40.1731580358775; Thu, 14 Nov 2024
 02:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <c0983059-ab11-4bc5-ab60-c5b23d1c290e@redhat.com>
In-Reply-To: <c0983059-ab11-4bc5-ab60-c5b23d1c290e@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 14 Nov 2024 11:32:27 +0100
Message-ID: <CAGCz3vv+5y=YGqZaXnGkVj0zA9fX-n3BOZyuPQC+dRMKN8VJZw@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="0000000000002f73e90626dcf89e"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::634;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x634.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000002f73e90626dcf89e
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 17:38, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/13/24 15:23, Phil Dennis-Jordan wrote:
> > macOS's Cocoa event handling must be done on the initial (main) thread
> > of the process. Furthermore, if library or application code uses
> > libdispatch, the main dispatch queue must be handling events on the main
> > thread as well.
> >
> > So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> > in different ways: the Cocoa UI replaces the default qemu_main function
> > with one that spins Qemu's internal main event loop off onto a
> > background thread. SDL (which uses Cocoa internally) on the other hand
> > uses a polling approach within Qemu's main event loop. Events are
> > polled during the SDL UI's dpy_refresh callback, which happens to run
> > on the main thread by default.
> >
> > As UIs are mutually exclusive, this works OK as long as nothing else
> > needs platform-native event handling. In the next patch, a new device is
> > introduced based on the ParavirtualizedGraphics.framework in macOS.
> > This uses libdispatch internally, and only works when events are being
> > handled on the main runloop. With the current system, it works when
> > using either the Cocoa or the SDL UI. However, it does not when running
> > headless. Moreover, any attempt to install a similar scheme to the
> > Cocoa UI's main thread replacement fails when combined with the SDL
> > UI.
> >
> > This change tidies up main thread management to be more flexible.
> >
> >   * The qemu_main global function pointer is a custom function for the
> >     main thread, and it may now be NULL. When it is, the main thread
> >     runs the main Qemu loop. This represents the traditional setup.
> >   * When non-null, spawning the main Qemu event loop on a separate
> >     thread is now done centrally rather than inside the Cocoa UI code.
> >   * For most platforms, qemu_main is indeed NULL by default, but on
> >     Darwin, it defaults to a function that runs the CFRunLoop.
> >   * The Cocoa UI sets qemu_main to a function which runs the
> >     NSApplication event handling runloop, as is usual for a Cocoa app.
> >   * The SDL UI overrides the qemu_main function to NULL, thus
> >     specifying that Qemu's main loop must run on the main
> >     thread.
> >   * The GTK UI also overrides the qemu_main function to NULL.
> >   * For other UIs, or in the absence of UIs, the platform's default
> >     behaviour is followed.
> >
> > This means that on macOS, the platform's runloop events are always
> > handled, regardless of chosen UI. The new PV graphics device will
> > thus work in all configurations. There is no functional change on other
> > operating systems.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> I checked what GTK+ does and, either way, you have to create another
> thread: timers are handled with a CFRunLoopTimer, but file descriptors
> are polled in a separate thread and sent to the main thread with a
> single CFRunLoopSource.  It's a bit nicer that the main thread is in
> charge, but it's more complex and probably slower too.
>

Just to clarify: is this supposed to be happening inside the GTK+ library
itself? i.e. GTK should spawn its own thread to poll file descriptors that
are owned by GTK? (As opposed to the file descriptors used by QEMU's own
event loop - what on Linux are eventfds, but on macOS I think are just
pipes*.)

This doesn't describe what I'm seeing when I run with -display gtk on
macOS. There's no extra thread created. There's a dock icon, but it's
non-interactive ("Application not responding"), there aren't any menus, and
there's no window. QEMU's own simulation is running in the background - I
can reach a guest via the network. So I guess there's some function in GTK
we're supposed to be calling that will make it crank the native event loop
on macOS, but this isn't being done?

Or do you mean there exists a global "block here forever" function in GTK
we can call from the main thread and which will make everything spring into
life, but that brings with it the same requirement as with the Cocoa UI:
moving everything that was originally on the main thread onto a background
thread. (I've done some searching for GTK docs and other background info
but anything I've found has been rather thin on this topic. The ui/gtk*.c
source is also not particularly enlightening - it seems to imply that
something in the background ought to be handling events somewhere.)

[* The event loop in QEMU on macOS probably ought to use a kqueue, with
EVFILT_USER where eventfds are used on Linux, except the rough equivalent
of ioeventfds are Mach ports which can be handled via EVFILT_MACHPORT, but
I digress.]

As long as it's clear that any handlers that go through the CFRunLoop
> run outside the BQL, as is already the case for the Cocoa UI, I see no
> problem with this approach.
>

I'm not entirely sure what you're getting at here, to be honest. The UI
thread can definitely not assume to be holding the BQL all the time; we'd
have to treat it more like an AIOContext. It could pave the way towards
putting the display and UI subsystems on their own AIOContext or
AIOContext-like-thing, rather than hogging the BQL for expensive image
operations.

(*By the sound of it, Win32 has an all-UI-calls-on-one-thread requirement
as well which we may be violating to some degree via the GTK and/or SDL
backends as well; my adventures with Win32 are almost 20 years back now so
I'm a bit out of the loop there.)


> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Paolo
>
>
>

--0000000000002f73e90626dcf89e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 Nov 2024 =
at 17:38, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 11/13/24 15:23, Phil Dennis-Jordan wrot=
e:<br>
&gt; macOS&#39;s Cocoa event handling must be done on the initial (main) th=
read<br>
&gt; of the process. Furthermore, if library or application code uses<br>
&gt; libdispatch, the main dispatch queue must be handling events on the ma=
in<br>
&gt; thread as well.<br>
&gt; <br>
&gt; So far, this has affected Qemu in both the Cocoa and SDL UIs, although=
<br>
&gt; in different ways: the Cocoa UI replaces the default qemu_main functio=
n<br>
&gt; with one that spins Qemu&#39;s internal main event loop off onto a<br>
&gt; background thread. SDL (which uses Cocoa internally) on the other hand=
<br>
&gt; uses a polling approach within Qemu&#39;s main event loop. Events are<=
br>
&gt; polled during the SDL UI&#39;s dpy_refresh callback, which happens to =
run<br>
&gt; on the main thread by default.<br>
&gt; <br>
&gt; As UIs are mutually exclusive, this works OK as long as nothing else<b=
r>
&gt; needs platform-native event handling. In the next patch, a new device =
is<br>
&gt; introduced based on the ParavirtualizedGraphics.framework in macOS.<br=
>
&gt; This uses libdispatch internally, and only works when events are being=
<br>
&gt; handled on the main runloop. With the current system, it works when<br=
>
&gt; using either the Cocoa or the SDL UI. However, it does not when runnin=
g<br>
&gt; headless. Moreover, any attempt to install a similar scheme to the<br>
&gt; Cocoa UI&#39;s main thread replacement fails when combined with the SD=
L<br>
&gt; UI.<br>
&gt; <br>
&gt; This change tidies up main thread management to be more flexible.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* The qemu_main global function pointer is a custom functi=
on for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0main thread, and it may now be NULL. When it is, th=
e main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0runs the main Qemu loop. This represents the tradit=
ional setup.<br>
&gt;=C2=A0 =C2=A0* When non-null, spawning the main Qemu event loop on a se=
parate<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread is now done centrally rather than inside the=
 Cocoa UI code.<br>
&gt;=C2=A0 =C2=A0* For most platforms, qemu_main is indeed NULL by default,=
 but on<br>
&gt;=C2=A0 =C2=A0 =C2=A0Darwin, it defaults to a function that runs the CFR=
unLoop.<br>
&gt;=C2=A0 =C2=A0* The Cocoa UI sets qemu_main to a function which runs the=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0NSApplication event handling runloop, as is usual f=
or a Cocoa app.<br>
&gt;=C2=A0 =C2=A0* The SDL UI overrides the qemu_main function to NULL, thu=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0specifying that Qemu&#39;s main loop must run on th=
e main<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0* The GTK UI also overrides the qemu_main function to NULL=
.<br>
&gt;=C2=A0 =C2=A0* For other UIs, or in the absence of UIs, the platform&#3=
9;s default<br>
&gt;=C2=A0 =C2=A0 =C2=A0behaviour is followed.<br>
&gt; <br>
&gt; This means that on macOS, the platform&#39;s runloop events are always=
<br>
&gt; handled, regardless of chosen UI. The new PV graphics device will<br>
&gt; thus work in all configurations. There is no functional change on othe=
r<br>
&gt; operating systems.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
I checked what GTK+ does and, either way, you have to create another <br>
thread: timers are handled with a CFRunLoopTimer, but file descriptors <br>
are polled in a separate thread and sent to the main thread with a <br>
single CFRunLoopSource.=C2=A0 It&#39;s a bit nicer that the main thread is =
in <br>
charge, but it&#39;s more complex and probably slower too.<br></blockquote>=
<div><br></div><div>Just to clarify: is this supposed to be happening insid=
e the GTK+ library itself? i.e. GTK should spawn its own thread to poll fil=
e descriptors that are owned by GTK? (As opposed to the file descriptors us=
ed by QEMU&#39;s own event loop - what on Linux are eventfds, but on macOS =
I think are just pipes*.)</div><div><br></div>This doesn&#39;t describe wha=
t I&#39;m seeing when I run with -display gtk on macOS. There&#39;s no extr=
a thread created. There&#39;s a dock icon, but it&#39;s non-interactive (&q=
uot;Application not responding&quot;), there aren&#39;t any menus, and ther=
e&#39;s no window. QEMU&#39;s own simulation is running in the background -=
 I can reach a guest via the network. So I guess there&#39;s some function =
in GTK we&#39;re supposed to be calling that will make it crank the native =
event loop on macOS, but this isn&#39;t being done?</div><div class=3D"gmai=
l_quote"><br></div><div class=3D"gmail_quote">Or do you mean there exists a=
 global &quot;block here forever&quot; function in GTK we can call from the=
 main thread and which will make everything spring into life, but that brin=
gs with it the same requirement as with the Cocoa UI: moving everything tha=
t was originally on the main thread onto a background thread. (I&#39;ve don=
e some searching for GTK docs and other background info but anything I&#39;=
ve found has been rather thin on this topic. The ui/gtk*.c source is also n=
ot particularly enlightening - it seems to imply that something in the back=
ground ought to be handling events somewhere.)<br></div><div class=3D"gmail=
_quote"><div><br></div><div>[* The event loop in QEMU on macOS probably oug=
ht to use a kqueue, with EVFILT_USER where eventfds are used on Linux, exce=
pt the rough equivalent of ioeventfds are Mach ports which can be handled v=
ia EVFILT_MACHPORT, but I digress.]</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
As long as it&#39;s clear that any handlers that go through the CFRunLoop <=
br>
run outside the BQL, as is already the case for the Cocoa UI, I see no <br>
problem with this approach.<br></blockquote><div>=C2=A0</div><div>I&#39;m n=
ot entirely sure what you&#39;re getting at here, to be honest. The UI thre=
ad can definitely not assume to be holding the BQL all the time; we&#39;d h=
ave to treat it more like an AIOContext. It could pave the way towards putt=
ing the display and UI subsystems on their own AIOContext or AIOContext-lik=
e-thing, rather than hogging the BQL for expensive image operations.<br></d=
iv><div><br></div><div>(*By the sound of it, Win32 has an all-UI-calls-on-o=
ne-thread requirement as well which we may be violating to some degree via =
the GTK and/or SDL backends as well; my adventures with Win32 are almost 20=
 years back now so I&#39;m a bit out of the loop there.)<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
<br>
Paolo<br>
<br>
<br>
</blockquote></div></div>
</div>

--0000000000002f73e90626dcf89e--

