Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 06:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOtS8-00072v-UE; Wed, 03 Jul 2024 02:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOtS3-00072T-0d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:26:47 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOtS0-0005Tn-LH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:26:46 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4450292a50bso40095711cf.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719987991; x=1720592791; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=59vUkda7i8jtRuwL5zs1wmR9zebJWb3kG60NpsVWhcg=;
 b=NefZRtYmBaXu1OxWb1HqnegSHe+c0VNxtMlU3NoFHG5ZqgXjc+3X4M6dQ0+mCpH4BK
 k+nWeE/XP6hKMBujTg5SvfsDZ62lp9SujswBDGVL6YujOwfGsPty++887n6jA4+PiDkB
 IiqmlruFATYJ9roiCCSpUEed8ytphhJx3tVK4jryTmthTN+9D3h8XU1n2eciI94fREuJ
 p43EfEDVrPmS9dNCXsPTfvh1RzMNEuPgsZB/8HQ7Yq1DPDOJ2sIudQJdjStswgrqjbV1
 Yk+bPZRZEXlPsII6eBYwO44d9NGuG172rr+c4LCa6ORwIGYj+FKdstefisWvrcjsVOKP
 PTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719987991; x=1720592791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=59vUkda7i8jtRuwL5zs1wmR9zebJWb3kG60NpsVWhcg=;
 b=GxQ+II2GIYKZV30Z6iigneca+Wraig7zDGRkmfl3QItJ+Tpmas0b8B6O8yLzSQDBVJ
 e3Vlhv0D3NCIbbhV6j74eEIb23ZRtoSBoJbmUqlC97EJsmkvZMurlYBlpI4ACMJIS6lc
 bLgoCu4Hp1pmC8qBa5ZiXN/m0nhuG+B13JD030M9B4R4+vgZRVX8KLwb3FaJzwUORKgh
 JNxfg+D7VV+INn0ICdVKumcmnMw7kbds9oLP1FzsKUdE9qnfupaeeyjoCm4mzGl+4qro
 44sOz4T8fDhWffI2hmquezlMVebg+gsDBRhV0wciYU1+bofHrij3orTklYJC1kA8+HK0
 k1Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtue8NzoNvKdp9gYp7KEr3WrBRJSsBZElrSUuB4dO7RMpmTGbC0t6zuxI6zFOa5Zu3mkf/F6R7Ykf6FsnT5IWlUA4lG8Q=
X-Gm-Message-State: AOJu0YwG31L251Ri7carjDljkb/9HimiiKMUHxZLu+ohmLFKoR4NJ+gB
 P2zcdG/7rUUsQqOq+FNs8+jxTSh+yBFZlSW5VUVnpJo94NQ+SUvlca/ioXcRiP4fdXZygdLxpI9
 0kJfYzOa8QM4nPd9aPITKskUgZyM=
X-Google-Smtp-Source: AGHT+IH0HDU5rn+3YAP9zY9SPy3KICeCkxjTJe9orHlvOfDwLMchdNPGtX8l4tBv/zcyfdKwHkMq7rIXDVAG+SeVh+A=
X-Received: by 2002:a05:622a:134b:b0:446:49f6:8ac6 with SMTP id
 d75a77b69052e-44662e2f1f0mr167525391cf.37.1719987990813; Tue, 02 Jul 2024
 23:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
 <71ea0f44-fea9-45ca-8ce0-064e8581c7cf@intel.com>
In-Reply-To: <71ea0f44-fea9-45ca-8ce0-064e8581c7cf@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jul 2024 10:26:18 +0400
Message-ID: <CAJ+F1C+QPJAf1KbZSySmQYd7CF07Gk2qU89nxajdy90QRs4v3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous
 guest display render
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000035e3b6061c51e9f8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000035e3b6061c51e9f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 2, 2024 at 10:11=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> Hi Marc-Andr=C3=A9,
>
> On 7/2/2024 3:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jun 21, 2024 at 3:20=E2=80=AFAM <dongwon.kim@intel.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     From: Dongwon Kim <dongwon.kim@intel.com <mailto:
> dongwon.kim@intel.com>>
> >
> >     Introducing new virtio-gpu param, 'render_sync' when guest scanout
> blob
> >     is used (blob=3Dtrue). The new param is used to specify when to sta=
rt
> >     rendering a guest scanout frame.
> >
> >     By default (and so far) rendering of the guest frame is started in
> >     the draw event to make sure guest display update is sychronized wit=
h
> >     host's vsync. But this method inevitably brings some extra wait
> because
> >     most of time, the draw event is not happening right after the guest
> >     scanout frame is flushed.
> >
> >
> >     This delay often makes the guest stuck at certain frame for too lon=
g
> and
> >     causes general performance degradation of graphic workloads on the
> >     guest's
> >     side especially when the display update rate is high. This unwanted
> perf
> >     drop can be reduced if the guest scanout frame is rendered as soon
> >     as it is
> >     flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl display
> >     pipeline can be unblocked a lot earlier in this case so that guest
> can
> >     move to the next display frame right away.
> >
> >     However, this "asynchrounous" render mode may cause some waste of
> >     resources
> >     as the guest could produce more frames than what are actually
> displayed
> >     on the host display. This is similar as running rendering apps with
> >     no vblank
> >     or vsync option. This is why this feature should stay as optional.
> >
> >
> > Indeed, I don't see much point in doing so, it's pure waste. If you wan=
t
> > to benchmark something perhaps. But then, why not simply run a benchmar=
k
> > offscreen?
>
> Benchmark score is not the primary reason. The problem we want to avoid
> is the laggy display update due to too many asynchronous plane updates
> happening in the guest in certain situations like when moving SW mouse
> cursor rigorously on the guest. This is because the fence (as well as
> response for the resource-flush cmd) is signaled in the draw event.
>
>
Presumably, you won't get more frames displayed (perhaps even less due to
extra load), so why is it laggy? Is it because the guest is doing too much
buffering? Because the mouse event queue isn't being drained between
scanouts?


> >
> >
> >     The param 'render_sync' is set to 'true' by default and this is in
> line
> >     with traditional way while setting it to 'false' is basically
> enabling
> >     this asynchronouse mode.
> >
> >
> > As it stands now, the option should actually be on the display backend
> > (gtk/gtk-egl), it's not implemented for other backends.
>
> We can help to deploy this concept to other backends if needed.
>

Why not make it a gtk display option instead?


> >
> > I am not convinced this is generally useful to be an extra option thoug=
h.
>
> I initially thought this should be the default because the virtio-gpu
> guest should not be hold by the host for too long in any cases. And this
> new approach is comparable to the default mode with blob=3Dfalse where th=
e
> guest is released as soon as the resource flush is done. Only difference
> is the resource synchronization using the fence.
>

virgl should be blocking rendering too

Could you detail your testing setup ?

thanks


> >
> >     Dongwon Kim (4):
> >        hw/display/virtio-gpu: Introducing render_sync param
> >        ui/egl-helpers: Consolidates create-sync and create-fence
> >        ui/gtk-egl: Start rendering of guest blob scanout if render_sync
> is
> >          off
> >        ui/gtk-gl-draw: Start rendering of guest blob scanout if
> render_sync
> >          is off
> >
> >       include/hw/virtio/virtio-gpu.h  |  3 ++
> >       include/ui/dmabuf.h             |  4 +-
> >       include/ui/egl-helpers.h        |  3 +-
> >       hw/display/vhost-user-gpu.c     |  3 +-
> >       hw/display/virtio-gpu-udmabuf.c |  3 +-
> >       hw/display/virtio-gpu.c         |  2 +
> >       hw/vfio/display.c               |  3 +-
> >       ui/dbus-listener.c              |  2 +-
> >       ui/dmabuf.c                     | 11 +++-
> >       ui/egl-helpers.c                | 27 ++++------
> >       ui/gtk-egl.c                    | 93
> ++++++++++++++++++---------------
> >       ui/gtk-gl-area.c                | 90
> +++++++++++++++++++------------
> >       12 files changed, 146 insertions(+), 98 deletions(-)
> >
> >     --
> >     2.34.1
> >
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000035e3b6061c51e9f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 10:11=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On 7/2/2024 3:29 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Fri, Jun 21, 2024 at 3:20=E2=80=AFAM &lt;<a href=3D"mailto:dongwon.=
kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim=
@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=
=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</=
a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Introducing new virtio-gpu param, &#39;render_sync&=
#39; when guest scanout blob<br>
&gt;=C2=A0 =C2=A0 =C2=A0is used (blob=3Dtrue). The new param is used to spe=
cify when to start<br>
&gt;=C2=A0 =C2=A0 =C2=A0rendering a guest scanout frame.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0By default (and so far) rendering of the guest fram=
e is started in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the draw event to make sure guest display update is=
 sychronized with<br>
&gt;=C2=A0 =C2=A0 =C2=A0host&#39;s vsync. But this method inevitably brings=
 some extra wait because<br>
&gt;=C2=A0 =C2=A0 =C2=A0most of time, the draw event is not happening right=
 after the guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0scanout frame is flushed.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This delay often makes the guest stuck at certain f=
rame for too long and<br>
&gt;=C2=A0 =C2=A0 =C2=A0causes general performance degradation of graphic w=
orkloads on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0side especially when the display update rate is hig=
h. This unwanted perf<br>
&gt;=C2=A0 =C2=A0 =C2=A0drop can be reduced if the guest scanout frame is r=
endered as soon<br>
&gt;=C2=A0 =C2=A0 =C2=A0as it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0flushed through &#39;VIRTIO_GPU_CMD_RESOURCE_FLUSH&=
#39; msg. The gl display<br>
&gt;=C2=A0 =C2=A0 =C2=A0pipeline can be unblocked a lot earlier in this cas=
e so that guest can<br>
&gt;=C2=A0 =C2=A0 =C2=A0move to the next display frame right away.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0However, this &quot;asynchrounous&quot; render mode=
 may cause some waste of<br>
&gt;=C2=A0 =C2=A0 =C2=A0resources<br>
&gt;=C2=A0 =C2=A0 =C2=A0as the guest could produce more frames than what ar=
e actually displayed<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the host display. This is similar as running ren=
dering apps with<br>
&gt;=C2=A0 =C2=A0 =C2=A0no vblank<br>
&gt;=C2=A0 =C2=A0 =C2=A0or vsync option. This is why this feature should st=
ay as optional.<br>
&gt; <br>
&gt; <br>
&gt; Indeed, I don&#39;t see much point in doing so, it&#39;s pure waste. I=
f you want <br>
&gt; to benchmark something perhaps. But then, why not simply run a benchma=
rk <br>
&gt; offscreen?<br>
<br>
Benchmark score is not the primary reason. The problem we want to avoid <br=
>
is the laggy display update due to too many asynchronous plane updates <br>
happening in the guest in certain situations like when moving SW mouse <br>
cursor rigorously on the guest. This is because the fence (as well as <br>
response for the resource-flush cmd) is signaled in the draw event.<br>
<br></blockquote><div><br></div><div>Presumably, you won&#39;t get more fra=
mes displayed (perhaps even less due to extra load), so why is it laggy? Is=
 it because the guest is doing too much buffering? Because the mouse event =
queue isn&#39;t being drained between scanouts?</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The param &#39;render_sync&#39; is set to &#39;true=
&#39; by default and this is in line<br>
&gt;=C2=A0 =C2=A0 =C2=A0with traditional way while setting it to &#39;false=
&#39; is basically enabling<br>
&gt;=C2=A0 =C2=A0 =C2=A0this asynchronouse mode.<br>
&gt; <br>
&gt; <br>
&gt; As it stands now, the option should actually be on the display backend=
 <br>
&gt; (gtk/gtk-egl), it&#39;s not implemented for other backends.<br>
<br>
We can help to deploy this concept to other backends if needed.<br></blockq=
uote><div><br></div><div>Why not make it a gtk display option instead?</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; I am not convinced this is generally useful to be an extra option thou=
gh.<br>
<br>
I initially thought this should be the default because the virtio-gpu <br>
guest should not be hold by the host for too long in any cases. And this <b=
r>
new approach is comparable to the default mode with blob=3Dfalse where the =
<br>
guest is released as soon as the resource flush is done. Only difference <b=
r>
is the resource synchronization using the fence.<br></blockquote><div><br><=
/div><div>virgl should be blocking rendering too<br></div><div><br></div>Co=
uld you detail your testing setup ?</div><div class=3D"gmail_quote"><br></d=
iv><div class=3D"gmail_quote">thanks</div><div class=3D"gmail_quote"><br></=
div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Dongwon Kim (4):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu: Introducing render_s=
ync param<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ui/egl-helpers: Consolidates create-sync an=
d create-fence<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ui/gtk-egl: Start rendering of guest blob s=
canout if render_sync is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ui/gtk-gl-draw: Start rendering of guest bl=
ob scanout if render_sync<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is off<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 |=C2=A0=
 3 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/ui/dmabuf.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/ui/egl-helpers.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/display/virtio-gpu-udmabuf.c |=C2=A0 3 +-=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/vfio/display.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/dbus-listener.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 27 ++++------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 93 ++++++++++++++++++-------------=
--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 90 +++++++++++++++++++------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A012 files changed, 146 insertions(+), 98 dele=
tions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.34.1<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000035e3b6061c51e9f8--

