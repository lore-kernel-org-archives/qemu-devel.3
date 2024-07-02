Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C6CC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOalL-0002wN-I5; Tue, 02 Jul 2024 06:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOalJ-0002vq-8T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:29:25 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOalH-0006PB-Cf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:29:24 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-643f3130ed1so35498537b3.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719916162; x=1720520962; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8XyhcEusxrSNlemHcNXEZd7Bic1q3HPmqodZXgsGde4=;
 b=bRUbxxoTXt2B7hW7s6uDsSB5LGOUwFlrQj0kpn7ud5+tRVepJVaHB0SOl6F/Pufe52
 809jLlU66m16SjT1XRN0gujwxLc8xrgLgnkOV5qj0rs9wg3me0LqgqZVNHg0rwsAKcOZ
 0Mfz1Dwal+E+z/8P9WvBu/757r0JrpsasxnJIcvRuMyuGWyufwXncvkRTPYxYQgVMW6u
 dM0ugpVLLIJaa4RpaDi/AW0rdOIjIv1/wg519B+oXhV2MKUm29uzGEgUqqdYrjjhfsyW
 cJ9ezaQ27vxq3+V+RnExXH85Eqjn2OWQGwyhOtzJp28X8K8BJfFXiWe9ZytX4h58E9xW
 Skmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719916162; x=1720520962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XyhcEusxrSNlemHcNXEZd7Bic1q3HPmqodZXgsGde4=;
 b=B0hT+KL4nbaozM/MzjeleAbF7DNdeB8eUmbPuju6y1DroODdTElfnO0OhHst5Y/jha
 +76m3elmQYbElA3vVyWGPmQLwqCbUmQHchQKXXFw8OceYU/UfAg2t21mPDMq8QcBMfl6
 xmowQ3onxnRzqKUzITZdlMVqQW9iGRJ6ltC4oCXf+pnng43IQaecFDf+6mV/qcbr7TeE
 w9bA9+ALqLR3aS2Q7SvpI4rLD2mgm/1ikszDexI1K0Zj+KnfrzcUZ9n4SGeD1BiYWrUq
 ZtqfejdH50eQ4c5koowYIiXGdptW0jilRmR+v4RjGJcUIzM45km4ZM/3po+sfjQjVEqg
 HSKQ==
X-Gm-Message-State: AOJu0Yzu6jo4EOqJQJBpJydoyq0IeBU8Jksrhp9SZv2im3uXE/WlStj6
 vc+j4JxqHY5d45uh0fsnj99+/ONPBn/42K3HYEtE5402ltgw/5hpGcGCBcjfKv0QkxwBZ0GGLPd
 4G++dtAL0mSzX4Sild4wyjQD4TSw=
X-Google-Smtp-Source: AGHT+IHcCOUOl6TaV9KREuenXWjPdHSqq1Ux8OA/kCoUj35oLtAJHVmvRN87eN4Q/wuVrN7LQF3Tc5S9sSn1Tslx8S8=
X-Received: by 2002:a81:d80b:0:b0:64b:1f4e:409f with SMTP id
 00721157ae682-64c736fcfefmr78643327b3.49.1719916162240; Tue, 02 Jul 2024
 03:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240620231727.235841-1-dongwon.kim@intel.com>
In-Reply-To: <20240620231727.235841-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 14:29:10 +0400
Message-ID: <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous
 guest display render
To: dongwon.kim@intel.com, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e4daff061c412f24"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112c.google.com
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

--000000000000e4daff061c412f24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 21, 2024 at 3:20=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Introducing new virtio-gpu param, 'render_sync' when guest scanout blob
> is used (blob=3Dtrue). The new param is used to specify when to start
> rendering a guest scanout frame.
>
> By default (and so far) rendering of the guest frame is started in
> the draw event to make sure guest display update is sychronized with
> host's vsync. But this method inevitably brings some extra wait because
> most of time, the draw event is not happening right after the guest
> scanout frame is flushed.
>

> This delay often makes the guest stuck at certain frame for too long and
> causes general performance degradation of graphic workloads on the guest'=
s
> side especially when the display update rate is high. This unwanted perf
> drop can be reduced if the guest scanout frame is rendered as soon as it =
is
> flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl display
> pipeline can be unblocked a lot earlier in this case so that guest can
> move to the next display frame right away.
>
> However, this "asynchrounous" render mode may cause some waste of resourc=
es
> as the guest could produce more frames than what are actually displayed
> on the host display. This is similar as running rendering apps with no
> vblank
> or vsync option. This is why this feature should stay as optional.
>

Indeed, I don't see much point in doing so, it's pure waste. If you want to
benchmark something perhaps. But then, why not simply run a benchmark
offscreen?


>
> The param 'render_sync' is set to 'true' by default and this is in line
> with traditional way while setting it to 'false' is basically enabling
> this asynchronouse mode.
>
>
As it stands now, the option should actually be on the display backend
(gtk/gtk-egl), it's not implemented for other backends.

I am not convinced this is generally useful to be an extra option though.


> Dongwon Kim (4):
>   hw/display/virtio-gpu: Introducing render_sync param
>   ui/egl-helpers: Consolidates create-sync and create-fence
>   ui/gtk-egl: Start rendering of guest blob scanout if render_sync is
>     off
>   ui/gtk-gl-draw: Start rendering of guest blob scanout if render_sync
>     is off
>
>  include/hw/virtio/virtio-gpu.h  |  3 ++
>  include/ui/dmabuf.h             |  4 +-
>  include/ui/egl-helpers.h        |  3 +-
>  hw/display/vhost-user-gpu.c     |  3 +-
>  hw/display/virtio-gpu-udmabuf.c |  3 +-
>  hw/display/virtio-gpu.c         |  2 +
>  hw/vfio/display.c               |  3 +-
>  ui/dbus-listener.c              |  2 +-
>  ui/dmabuf.c                     | 11 +++-
>  ui/egl-helpers.c                | 27 ++++------
>  ui/gtk-egl.c                    | 93 ++++++++++++++++++---------------
>  ui/gtk-gl-area.c                | 90 +++++++++++++++++++------------
>  12 files changed, 146 insertions(+), 98 deletions(-)
>
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e4daff061c412f24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 3:20=E2=80=
=AFAM &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blan=
k">dongwon.kim@intel.com</a>&gt;<br>
<br>
Introducing new virtio-gpu param, &#39;render_sync&#39; when guest scanout =
blob<br>
is used (blob=3Dtrue). The new param is used to specify when to start<br>
rendering a guest scanout frame.<br>
<br>
By default (and so far) rendering of the guest frame is started in<br>
the draw event to make sure guest display update is sychronized with<br>
host&#39;s vsync. But this method inevitably brings some extra wait because=
<br>
most of time, the draw event is not happening right after the guest<br>
scanout frame is flushed.<br></blockquote><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
This delay often makes the guest stuck at certain frame for too long and<br=
>
causes general performance degradation of graphic workloads on the guest&#3=
9;s<br>
side especially when the display update rate is high. This unwanted perf<br=
>
drop can be reduced if the guest scanout frame is rendered as soon as it is=
<br>
flushed through &#39;VIRTIO_GPU_CMD_RESOURCE_FLUSH&#39; msg. The gl display=
<br>
pipeline can be unblocked a lot earlier in this case so that guest can<br>
move to the next display frame right away.<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
However, this &quot;asynchrounous&quot; render mode may cause some waste of=
 resources<br>
as the guest could produce more frames than what are actually displayed<br>
on the host display. This is similar as running rendering apps with no vbla=
nk<br>
or vsync option. This is why this feature should stay as optional.<br></blo=
ckquote><div><br></div><div>Indeed, I don&#39;t see much point in doing so,=
 it&#39;s pure waste. If you want to benchmark something perhaps. But then,=
 why not simply run a benchmark offscreen?<br></div><div>=C2=A0<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The param &#39;render_sync&#39; is set to &#39;true&#39; by default and thi=
s is in line<br>
with traditional way while setting it to &#39;false&#39; is basically enabl=
ing<br>
this asynchronouse mode.<br>
<br></blockquote></div><div class=3D"gmail_quote"><br></div><div class=3D"g=
mail_quote">As it stands now, the option should actually be on the display =
backend (gtk/gtk-egl), it&#39;s not implemented for other backends.<br></di=
v><div class=3D"gmail_quote"><div><br></div><div>I am not convinced this is=
 generally useful to be an extra option though.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Dongwon Kim (4):<br>
=C2=A0 hw/display/virtio-gpu: Introducing render_sync param<br>
=C2=A0 ui/egl-helpers: Consolidates create-sync and create-fence<br>
=C2=A0 ui/gtk-egl: Start rendering of guest blob scanout if render_sync is<=
br>
=C2=A0 =C2=A0 off<br>
=C2=A0 ui/gtk-gl-draw: Start rendering of guest blob scanout if render_sync=
<br>
=C2=A0 =C2=A0 is off<br>
<br>
=C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 |=C2=A0 3 ++<br>
=C2=A0include/ui/dmabuf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 +-<br>
=C2=A0include/ui/egl-helpers.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0hw/display/virtio-gpu-udmabuf.c |=C2=A0 3 +-<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<=
br>
=C2=A0hw/vfio/display.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0ui/dbus-listener.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A0ui/dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 11 +++-<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 27 ++++------<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 93 ++++++++++++++++++---------------<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 90 +++++++++++++++++++------------<br>
=C2=A012 files changed, 146 insertions(+), 98 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000e4daff061c412f24--

