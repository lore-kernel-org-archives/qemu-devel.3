Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394A1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOi8X-0003a9-DX; Tue, 02 Jul 2024 14:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOi8J-0003LH-Mo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:21:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOi8B-0001QD-UJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:21:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f3f9so1313437a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719944486; x=1720549286; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J5pHvK+/7K1mMyOz0VxaRhz2ZlJ78AmxoX9zR6YhqAw=;
 b=Nrk/Ky3t0IV62l1o5zMilSPtSlQp0laW5DPqVI2fecNabHNOzsh8no/i8HE8wx0nbP
 tZdv3qJlcl/kyEJl2KsDzsJxb5eravECb9xpWYze4Dt++I+qbhaQF/X2kk1fuAQKtSN1
 hKd76Q0Iyt2VsK979+SfI7yyctXiURsUUCyEnW/EMmMBKl0AAjEQckFJYIprfViYPZs0
 xwN/Vb1PwddyWSGnexSQ0CgKSkI/xBrTh4gbckX4idxfkvJGbvLIMHLdPoIJMW66VgFU
 o8o9CQiMAt+1X0XZYn0WQMRLiLzwrBKfH9SW7XorhOfEFnc7kXQaCsxt3btQ/4KtAEJy
 6q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944486; x=1720549286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5pHvK+/7K1mMyOz0VxaRhz2ZlJ78AmxoX9zR6YhqAw=;
 b=f95Tf0E0E5X/F7gfr9lUwctJ2io0en5Lj4k4hmORoOhYT5ziSY5IajXWFX4DOwy6Rg
 PYwtJ3scm0maVdCbXb8BDz96D1QIOoEA6Wsu22zqBBDOLjjmXWhiuxil37LxR/lai3B5
 BUydaRdWUOyVKxPou7PS2LOQ3Qce3/0nCUPLRNgZ8+GNeEcyAo34eLree6g4TT+VhZck
 l9RvOoPB5aYvgnJs16ah8MJzfBoaHvzSOQWLZnUg1ppQiu6PfaBTuxdVbSODXNbJHfQG
 ovzqRFN9oPluxoZH9egfplZ+GVppxGmYXTmIoEZKWJ7A7tgX2iyLgzK5631pscS8Rf+W
 pjxA==
X-Gm-Message-State: AOJu0YzNFslX0LP4QmmUj+9oNMw8CLIc7H9m39EO6YZw772Bxl5MxW3f
 imLre4tBOfZBjKRpLpAnvwUrE1E25rqsVRSlsGrEsz3Vj73UI9Bazx38unebZ5hSp4BnRW3mfCt
 SoxMsQCs6Oo02zHFHH8L9ZKHx/xbweCo=
X-Google-Smtp-Source: AGHT+IHdIGVocsJs3xNkuXGRlf6YiLhbrTW8P4yomA5P+Bg17IpEN9HBgBGAoBgzgdlq4T6CFGmqh07OT2uc5GgmKbM=
X-Received: by 2002:a17:906:d930:b0:a6f:cf64:a5d9 with SMTP id
 a640c23a62f3a-a75144f66abmr546421366b.49.1719944485578; Tue, 02 Jul 2024
 11:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240630163225.2973081-1-zheyuma97@gmail.com>
 <CAFEAcA81ymhA+bGLpfT_jmZ+=D9t+h_wg7QgWkgSFR4EKRGPqg@mail.gmail.com>
In-Reply-To: <CAFEAcA81ymhA+bGLpfT_jmZ+=D9t+h_wg7QgWkgSFR4EKRGPqg@mail.gmail.com>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 2 Jul 2024 20:21:10 +0200
Message-ID: <CAMhUBjkePcrX5Fg-WKc62DnorF6Enkd6LoRMT8QvaQaXTHzwvw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb: Fix memory leak in musb_reset()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000018ace2061c47c876"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000018ace2061c47c876
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Jul 1, 2024 at 2:43=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Sun, 30 Jun 2024 at 17:33, Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > The musb_reset function was causing a memory leak by not properly freei=
ng
> > the memory associated with USBPacket instances before reinitializing
> them.
> > This commit addresses the memory leak by adding calls to
> usb_packet_cleanup
> > for each USBPacket instance before reinitializing them with
> usb_packet_init.
> >
> > Asan log:
> >
> > =3D2970623=3D=3DERROR: LeakSanitizer: detected memory leaks
> > Direct leak of 256 byte(s) in 16 object(s) allocated from:
> >     #0 0x561e20629c3d in malloc
> llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
> >     #1 0x7fee91885738 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
> >     #2 0x561e21b4d0e1 in usb_packet_init hw/usb/core.c:531:5
> >     #3 0x561e21c5016b in musb_reset hw/usb/hcd-musb.c:372:9
> >     #4 0x561e21c502a9 in musb_init hw/usb/hcd-musb.c:385:5
> >     #5 0x561e21c893ef in tusb6010_realize hw/usb/tusb6010.c:827:15
> >     #6 0x561e23443355 in device_set_realized hw/core/qdev.c:510:13
> >     #7 0x561e2346ac1b in property_set_bool qom/object.c:2354:5
> >     #8 0x561e23463895 in object_property_set qom/object.c:1463:5
> >     #9 0x561e23477909 in object_property_set_qobject
> qom/qom-qobject.c:28:10
> >     #10 0x561e234645ed in object_property_set_bool qom/object.c:1533:15
> >     #11 0x561e2343c830 in qdev_realize hw/core/qdev.c:291:12
> >     #12 0x561e2343c874 in qdev_realize_and_unref hw/core/qdev.c:298:11
> >     #13 0x561e20ad5091 in sysbus_realize_and_unref
> hw/core/sysbus.c:261:12
> >     #14 0x561e22553283 in n8x0_usb_setup hw/arm/nseries.c:800:5
> >     #15 0x561e2254e99b in n8x0_init hw/arm/nseries.c:1356:5
> >     #16 0x561e22561170 in n810_init hw/arm/nseries.c:1418:5
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  hw/usb/hcd-musb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
> > index 6dca373cb1..0300aeaec6 100644
> > --- a/hw/usb/hcd-musb.c
> > +++ b/hw/usb/hcd-musb.c
> > @@ -368,6 +368,8 @@ void musb_reset(MUSBState *s)
> >          s->ep[i].maxp[1] =3D 0x40;
> >          s->ep[i].musb =3D s;
> >          s->ep[i].epnum =3D i;
> > +        usb_packet_cleanup(&s->ep[i].packey[0].p);
> > +        usb_packet_cleanup(&s->ep[i].packey[1].p);
> >          usb_packet_init(&s->ep[i].packey[0].p);
> >          usb_packet_init(&s->ep[i].packey[1].p);
> >      }
>
> I don't think it's valid to call usb_packet_cleanup() on
> a USBPacket that's never been inited, which is what will
> happen on the first reset with this patch.
>
> Looking at how hcd-ehci.c handles its s->ipacket (which has
> the same "allocated at device creation and reused for the
> whole lifetime of the device" semantics) I think what we
> want is:
>  * at device init, call usb_packet_init()
>  * at device reset, do nothing
>  * at device finalize, call usb_packet_cleanup()
>
> (There is currently no hcd-musb function for finalize
> because the only uses of it are for devices which continue
> to exist for the whole lifetime of the simulation. So we
> can ignore the last part of that.)
>
> PS: the tusb6010 and hcd-musb are both used only by deprecated
> board types which are scheduled to be deleted by the end
> of the year (basically after we get the 9.1 release out,
> and before 9.2). You might prefer to target your fuzzing
> efforts to board types which aren't deprecated.
>

Thanks for your kind reminder. I'll check the bug list and ignore
the devices which will be deprecated :)

Regards,
Zheyu

--00000000000018ace2061c47c876
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Peter,</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 2:43=
=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">p=
eter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Sun, 30 Jun 2024 at 17:33, Zheyu Ma &lt;<a href=
=3D"mailto:zheyuma97@gmail.com" target=3D"_blank">zheyuma97@gmail.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; The musb_reset function was causing a memory leak by not properly free=
ing<br>
&gt; the memory associated with USBPacket instances before reinitializing t=
hem.<br>
&gt; This commit addresses the memory leak by adding calls to usb_packet_cl=
eanup<br>
&gt; for each USBPacket instance before reinitializing them with usb_packet=
_init.<br>
&gt;<br>
&gt; Asan log:<br>
&gt;<br>
&gt; =3D2970623=3D=3DERROR: LeakSanitizer: detected memory leaks<br>
&gt; Direct leak of 256 byte(s) in 16 object(s) allocated from:<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0x561e20629c3d in malloc llvm/compiler-rt/lib/as=
an/asan_malloc_linux.cpp:129:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0x7fee91885738 in g_malloc (/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x5e738)<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0x561e21b4d0e1 in usb_packet_init hw/usb/core.c:=
531:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0x561e21c5016b in musb_reset hw/usb/hcd-musb.c:3=
72:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0x561e21c502a9 in musb_init hw/usb/hcd-musb.c:38=
5:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5 0x561e21c893ef in tusb6010_realize hw/usb/tusb60=
10.c:827:15<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6 0x561e23443355 in device_set_realized hw/core/qd=
ev.c:510:13<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7 0x561e2346ac1b in property_set_bool qom/object.c=
:2354:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#8 0x561e23463895 in object_property_set qom/object=
.c:1463:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#9 0x561e23477909 in object_property_set_qobject qo=
m/qom-qobject.c:28:10<br>
&gt;=C2=A0 =C2=A0 =C2=A0#10 0x561e234645ed in object_property_set_bool qom/=
object.c:1533:15<br>
&gt;=C2=A0 =C2=A0 =C2=A0#11 0x561e2343c830 in qdev_realize hw/core/qdev.c:2=
91:12<br>
&gt;=C2=A0 =C2=A0 =C2=A0#12 0x561e2343c874 in qdev_realize_and_unref hw/cor=
e/qdev.c:298:11<br>
&gt;=C2=A0 =C2=A0 =C2=A0#13 0x561e20ad5091 in sysbus_realize_and_unref hw/c=
ore/sysbus.c:261:12<br>
&gt;=C2=A0 =C2=A0 =C2=A0#14 0x561e22553283 in n8x0_usb_setup hw/arm/nseries=
.c:800:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#15 0x561e2254e99b in n8x0_init hw/arm/nseries.c:13=
56:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0#16 0x561e22561170 in n810_init hw/arm/nseries.c:14=
18:5<br>
&gt;<br>
&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" tar=
get=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/hcd-musb.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c<br>
&gt; index 6dca373cb1..0300aeaec6 100644<br>
&gt; --- a/hw/usb/hcd-musb.c<br>
&gt; +++ b/hw/usb/hcd-musb.c<br>
&gt; @@ -368,6 +368,8 @@ void musb_reset(MUSBState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ep[i].maxp[1] =3D 0x40;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ep[i].musb =3D s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ep[i].epnum =3D i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_packet_cleanup(&amp;s-&gt;ep[i].packe=
y[0].p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_packet_cleanup(&amp;s-&gt;ep[i].packe=
y[1].p);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_packet_init(&amp;s-&gt;ep[i].pac=
key[0].p);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_packet_init(&amp;s-&gt;ep[i].pac=
key[1].p);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
I don&#39;t think it&#39;s valid to call usb_packet_cleanup() on<br>
a USBPacket that&#39;s never been inited, which is what will<br>
happen on the first reset with this patch.<br>
<br>
Looking at how hcd-ehci.c handles its s-&gt;ipacket (which has<br>
the same &quot;allocated at device creation and reused for the<br>
whole lifetime of the device&quot; semantics) I think what we<br>
want is:<br>
=C2=A0* at device init, call usb_packet_init()<br>
=C2=A0* at device reset, do nothing<br>
=C2=A0* at device finalize, call usb_packet_cleanup()<br>
<br>
(There is currently no hcd-musb function for finalize<br>
because the only uses of it are for devices which continue<br>
to exist for the whole lifetime of the simulation. So we<br>
can ignore the last part of that.)<br>
<br>
PS: the tusb6010 and hcd-musb are both used only by deprecated<br>
board types which are scheduled to be deleted by the end<br>
of the year (basically after we get the 9.1 release out,<br>
and before 9.2). You might prefer to target your fuzzing<br>
efforts to board types which aren&#39;t deprecated.<br></blockquote><div><b=
r></div><div>Thanks for your kind reminder. I&#39;ll check the bug list and=
 ignore the=C2=A0devices which will be deprecated :)<br><br>Regards,<br>Zhe=
yu</div></div></div>

--00000000000018ace2061c47c876--

