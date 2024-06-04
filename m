Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74367C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sES62-0007sH-Qh; Tue, 04 Jun 2024 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sES61-0007s3-Dp
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:12:53 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sES5z-0007Gv-Hg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:12:53 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4400904c39bso18610731cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 04:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717499570; x=1718104370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnPt8cycCdpqSQog5ipFdAl+O8XxfegVTBuZmXTTVHo=;
 b=ZFIxj2x1+0OOHQ8ABDA03sX56Whm/eFTmKIELBSPFbA7H8P/MVK/wn2HehKKGvwT8Y
 9IKKvBPQAJXo0nMLdTUyoZkJsJ0McooxsmYULmO9Axsf9e8y96sJ1fQtNOWBlj/KS0m+
 FQAtrU1yvYt8fL7FA2NwwfdfHWbRpA6q8eBgPvKKOlgxb7Jonx1TByhzwDXxor5c7fPm
 rew+j0hS+Cy45pA+zP1pp7FXATc6Ntm7h+hIGp5P9+C2tdVeBD+LLUcmwKT8rQfnR1x9
 +EbXRE4yA7xqjdSIsbcO/UoSfCmEYhIHYINWOn9rnVphcdHqH9TVKZsVkY2vc9BAEwAe
 ZwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717499570; x=1718104370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnPt8cycCdpqSQog5ipFdAl+O8XxfegVTBuZmXTTVHo=;
 b=KJYIG2K5JVZgQfJrG4o1jPz7eiqBfBTdt63mz2yg8ReAnt5nhSkQQ+BujT8DZz1GvT
 D1El9PT75LpEZ1IYZqC9O87U716FQPOATgEQETXwbpwG8SZRsRZQhooxqD8+u/8+/NpR
 +IymCv4CBuWp562mqZtq4HZ4V4WulmOHE7rwaOEVHH83EQ1PDdGeaDP43K4jOT+cegkE
 bvFz5QaQhATesnWt6oVytKxbpvfDaXcO2k2TJBD/IVP8ZLlmJSoDLOwEnKqSqXnQJBkN
 G/DRj7Lm7eyHK2Bt9KskQHXlmro9b6107Q/abVOZ4RChkcsU7i6eThdh9sFblEXWAIbn
 OZ4Q==
X-Gm-Message-State: AOJu0YzCzFrc0ARdFNAWwfeDn/5Vu8yrNycLovDm/VuMNt8K3jAR2c9X
 c7e1xM3N51JOnRX6xew3BYcX41jaEtAfBZmulNFZLYOMBl6aXkHg7TETaDwr9eZVc8/xpPTOnal
 8E4rXeeVZ0/ozuxH+F7vjUL5qeLs=
X-Google-Smtp-Source: AGHT+IGmOZYO2aC3kTFyseFMemawm3sblpVlOywsM0ga/ZzTYElnSMTOvalRq7r3VDJuE6R1B/BqJTo4GBYRSvws284=
X-Received: by 2002:a05:622a:2c3:b0:440:177b:9cd4 with SMTP id
 d75a77b69052e-4401897a342mr43755581cf.0.1717499570120; Tue, 04 Jun 2024
 04:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240529224252.80395-1-dongwon.kim@intel.com>
In-Reply-To: <20240529224252.80395-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 15:12:38 +0400
Message-ID: <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c770b8061a0e876a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c770b8061a0e876a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 30, 2024 at 2:44=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon <dongwon.kim@intel.com>
>
> Make sure rendering of the current frame is finished before switching
> the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object to be
> signaled.
>

Can you expand on what this solves?


>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/egl-helpers.c |  2 --
>  ui/gtk.c         | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 99b2ebbe23..dafeb36074 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>          fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display,
>                                                sync);
>          qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
> -        eglDestroySyncKHR(qemu_egl_display, sync);
> -        qemu_dmabuf_set_sync(dmabuf, NULL);
>

If this function is called multiple times, it will now set a new fence_fd
each time, and potentially leak older fd. Maybe it could first check if a
fence_fd exists instead.

     }
>  }
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 93b13b7a30..cf0dd6abed 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vcon)
>
>      fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
>      if (fence_fd >=3D 0) {
> +        void *sync =3D qemu_dmabuf_get_sync(dmabuf);
>          qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
>          close(fence_fd);
>          qemu_dmabuf_set_fence_fd(dmabuf, -1);
> +        eglDestroySyncKHR(qemu_egl_display, sync);
> +        qemu_dmabuf_set_sync(dmabuf, NULL);
>          graphic_hw_gl_block(vc->gfx.dcl.con, false);
>      }
>  }
> @@ -682,6 +685,22 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
>  static void gd_change_runstate(void *opaque, bool running, RunState stat=
e)
>  {
>      GtkDisplayState *s =3D opaque;
> +    QemuDmaBuf *dmabuf;
> +    int i;
> +
> +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            VirtualConsole *vc =3D &s->vc[i];
> +            dmabuf =3D vc->gfx.guest_fb.dmabuf;
> +            if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) >=3D 0) {
> +                /* wait for the rendering to be completed */
> +                eglClientWaitSync(qemu_egl_display,
> +                                  qemu_dmabuf_get_sync(dmabuf),
> +                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
> +                                  1000000000);
>

 I don't think adding waiting points in the migration path is appropriate.
Perhaps once you explain the actual issue, it will be easier to help.

+            }
> +        }
> +    }
>
>      gd_update_caption(s);
>  }
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c770b8061a0e876a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 2:44=E2=80=
=AFAM &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">d=
ongwon.kim@intel.com</a>&gt;<br>
<br>
Make sure rendering of the current frame is finished before switching<br>
the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object to be<br>
signaled.<br></blockquote><div><br></div><div>Can you expand on what this s=
olves?</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
---<br>
=C2=A0ui/egl-helpers.c |=C2=A0 2 --<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 +++++++++++++++++++<br=
>
=C2=A02 files changed, 19 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br>
index 99b2ebbe23..dafeb36074 100644<br>
--- a/ui/egl-helpers.c<br>
+++ b/ui/egl-helpers.c<br>
@@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fence_fd =3D eglDupNativeFenceFDANDROID(q=
emu_egl_display,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sync);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_fence_fd(dmabuf, fence_fd=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu_egl_display, sync);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(dmabuf, NULL);<br></block=
quote><div><br></div><div>If this function is called multiple times, it wil=
l now set a new fence_fd each time, and potentially leak older fd. Maybe it=
 could first check if a fence_fd exists instead.<br></div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index 93b13b7a30..cf0dd6abed 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vcon)<br>
<br>
=C2=A0 =C2=A0 =C2=A0fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);<br>
=C2=A0 =C2=A0 =C2=A0if (fence_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *sync =3D qemu_dmabuf_get_sync(dmabuf);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_fd_handler(fence_fd, NULL, NULL,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fence_fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_fence_fd(dmabuf, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu_egl_display, sync);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(dmabuf, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(vc-&gt;gfx.dcl.con, f=
alse);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -682,6 +685,22 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {<br>
=C2=A0static void gd_change_runstate(void *opaque, bool running, RunState s=
tate)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GtkDisplayState *s =3D opaque;<br>
+=C2=A0 =C2=A0 QemuDmaBuf *dmabuf;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 if (state =3D=3D RUN_STATE_SAVE_VM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;nb_vcs; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtualConsole *vc =3D &amp;s-&g=
t;vc[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf =3D vc-&gt;gfx.guest_fb.d=
mabuf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dmabuf &amp;&amp; qemu_dmabu=
f_get_fence_fd(dmabuf) &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* wait for the re=
ndering to be completed */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eglClientWaitSync(=
qemu_egl_display,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_get_sync(dmabuf),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EGL_SYNC_FLUSH_COMMANDS_BIT_K=
HR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1000000000);<br></blockquote>=
<div><br></div><div>=C2=A0I don&#39;t think adding waiting points in the mi=
gration path is appropriate. Perhaps once you explain the actual issue, it =
will be easier to help.<br></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_update_caption(s);<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000c770b8061a0e876a--

