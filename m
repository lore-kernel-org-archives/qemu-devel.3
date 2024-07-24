Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9EFC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZNi-000260-6V; Wed, 24 Jul 2024 06:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWZNf-00025R-Uo
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:38:00 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWZNe-00018y-8i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:37:59 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e0885b4f1d5so3848494276.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721817477; x=1722422277; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ei5UjbnrtX7qsuankbPZDqqT6CsIuKjvGfdSX4MUYkc=;
 b=mih7/z/roxse3ILHxwKGvK9Ikj5JzfG7lfYGD8oQSkr3rsLKJY6vFUUC1SGdGWug25
 XoVv/6+W7CH8Dxk8VKekbyZgt8vopCbqrUD22cWQvEunrrE/zmKyamyE2thiYpmJz6VC
 ACtziSGXu4l3Ga78Fzb3gMo6FKJ1leM60FqmDH2j8zRTT+JgLuYef98CVRnt5ydbt5b6
 gKda2S+QwQHc1sJo7kG3vv17qSFxR11cQtSekLXq2AW/bOKtMTohgALg1jWEC0BNj1qI
 cxuJ0BhJ6kH7/kYWGcmsmIbzlJgywE8Jx7eUQ3AAWMOomlkmdNali6pk3w0rXC8Vg4yb
 2udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721817477; x=1722422277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ei5UjbnrtX7qsuankbPZDqqT6CsIuKjvGfdSX4MUYkc=;
 b=FtgXBULp5SeaB2TBVwskG55ktq3DScl/bmeJ8FH0bDK6lISvXIMM5Hifv0CPnteA1f
 28Q4rxx+8s+LthzfNI2LLSpti8HUwZ1x7ApeXY8avkze5tAIswqhw+DuUbqhdhTrSudp
 sbd63LmPDJYHdT8VBR+bJYYWiyKCLUKUGLRNp3cIbx5lY4VBPEotRl2W/0zPS/rUiID1
 8DWeWPvV+bNgHwnAdbPgDenOz8EApXzKeNYDyHOnehKShMX1f3nmnww7boYdO1m3JWim
 MwHXNK7RJ0aOthA7BTUo4z67HaGtFarpsRe4TIiWBnq44ItmkEgzxgZYXn/rUDn6SOmt
 IemA==
X-Gm-Message-State: AOJu0Yz1RKAMoZMq6blRscX2d5+mXKLAJzxVGAxxH64sqkvNUwPou/2G
 WvWiTCmuTXYAeg1LEN0cA+5etHq94nHoA/TP/CFzhfXSOF6FKXUbSf1LD0JzxCUUN23mtVal8Mt
 dx108ZiTY6BQNd62tl2KCgSU239k=
X-Google-Smtp-Source: AGHT+IGO+U8RCUDd3XCZMDS8AVSleTwRsHCh0iIorfFQ3fzFAOzbOufwccQNIOcsJ37714bxupXcIhyP0kXsf3mJNwY=
X-Received: by 2002:a05:6902:178d:b0:e08:664c:dd36 with SMTP id
 3f1490d57ef6-e087b921d5bmr12213982276.36.1721817472377; Wed, 24 Jul 2024
 03:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240723220258.3170957-1-dongwon.kim@intel.com>
In-Reply-To: <20240723220258.3170957-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Jul 2024 14:37:41 +0400
Message-ID: <CAJ+F1C+kk4ZBjf8bq2haA4WgzEoSrN2GBYoC5Lc-r17VmRNA6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Consolidate create-sync and create-fence
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cf2c83061dfbde9b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2e.google.com
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

--000000000000cf2c83061dfbde9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 24, 2024 at 2:05=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Sync object itself is never used as is so can be removed
> from QemuDmaBuf struct. So now sync is only temporarily needed
> when creating fence for the object which means what was done in
> egl_dmabuf_create_sync can now be a part of egl_dmabuf_create_fence
> function. And egl_dmabuf_create_fence returns fence_fd so the
> better function name will be egl_dmabuf_create_fence_fd.
>
> v3: create fence only if current QemuDmaBuf->fence_fd =3D -1
>     to make sure there is no fence currently bound to the
>     QemuDmaBuf
>

Why not check it from egl_dmabuf_create_fence_fd() ? calling the function
twice can still potentially leak.

Also, please gather the v1/v2/v3/... summary on the cover letter.

thanks


> Dongwon Kim (2):
>   ui/egl-helpers: Consolidates create-sync and create-fence
>   ui/dmabuf: Remove 'sync' from QemuDmaBuf struct
>
>  include/ui/dmabuf.h      |  2 --
>  include/ui/egl-helpers.h |  3 +--
>  ui/dmabuf.c              | 14 --------------
>  ui/egl-helpers.c         | 24 +++++++++---------------
>  ui/gtk-egl.c             | 17 ++++-------------
>  ui/gtk-gl-area.c         | 12 +++---------
>  6 files changed, 17 insertions(+), 55 deletions(-)
>
> --
> 2.43.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000cf2c83061dfbde9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 24, 2024 at 2:05=E2=80=AFAM &lt;<=
a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Dongwon =
Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.=
kim@intel.com</a>&gt;<br>
<br>
Sync object itself is never used as is so can be removed<br>
from QemuDmaBuf struct. So now sync is only temporarily needed<br>
when creating fence for the object which means what was done in<br>
egl_dmabuf_create_sync can now be a part of egl_dmabuf_create_fence<br>
function. And egl_dmabuf_create_fence returns fence_fd so the<br>
better function name will be egl_dmabuf_create_fence_fd.<br>
<br>
v3: create fence only if current QemuDmaBuf-&gt;fence_fd =3D -1<br>
=C2=A0 =C2=A0 to make sure there is no fence currently bound to the<br>
=C2=A0 =C2=A0 QemuDmaBuf<br></blockquote><div><br></div><div>Why not check =
it from=C2=A0egl_dmabuf_create_fence_fd() ? calling the function twice can =
still potentially leak. <br></div><div><br></div><div>Also, please gather t=
he v1/v2/v3/... summary on the cover letter.</div><div><br></div><div>thank=
s</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Dongwon Kim (2):<br>
=C2=A0 ui/egl-helpers: Consolidates create-sync and create-fence<br>
=C2=A0 ui/dmabuf: Remove &#39;sync&#39; from QemuDmaBuf struct<br>
<br>
=C2=A0include/ui/dmabuf.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 --<br>
=C2=A0include/ui/egl-helpers.h |=C2=A0 3 +--<br>
=C2=A0ui/dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ----=
----------<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 +++++++++-----=
----------<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 ++++=
-------------<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++---------<b=
r>
=C2=A06 files changed, 17 insertions(+), 55 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000cf2c83061dfbde9b--

