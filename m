Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E46C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElVH-0005VG-6y; Wed, 05 Jun 2024 03:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sElVF-0005TU-H3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:56:13 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sElVC-0004iB-9Q
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:56:13 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43ffbc0927fso26088911cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717574169; x=1718178969; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nkWRUDKSrbRyqIQzS5opt5ecdJLC0lE6XP7Rf4JBl9M=;
 b=ezL9yY/ZESsELBX01cxQ90bpBnZ0OSADJkHALqkQL+E+8KhvuP3P+XOiIAr5NAZ7CR
 AcjFT5usLAoNP0hDw1JkX/XoGJtF4vVi28y9qG2nHYTWIEFaZcIGM9KaMP6UUjDfn+vL
 opAg0gYQWt0a7AlaoKdZLR5yVbPLeV+gz14Vmy3sszoVBM3gTKv0wN9pdPBew/rAGxT1
 7XWyWO/WeoSPlC6iuRnFyGm/07xoSJUWeoCrFwlkJ1gfJybcUnwgHeIkXIePUtXYTYa6
 AejrSRv9+NNyj+NZQ3LDjPrZ/YxtE0WCXAf1SdvA07gPJNmUHIDiyJ+3Dx7B75ouonCb
 DOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574169; x=1718178969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nkWRUDKSrbRyqIQzS5opt5ecdJLC0lE6XP7Rf4JBl9M=;
 b=jJLNK2hOpoq7yfS9ItyGdXll9WXZl0VJo4bIaJfg6KunMhibAE5L9A9AjA3larvnSD
 PKhYUxI0q+gTwNF1hcfxOZkTUo97d7Oj09TLb5ngP/y1lJDI5IL2ccbXuWD0lt0YWqcA
 +U+j3ypxUmVJndDXrgg37ONLHVS2V78c8jFJQvUBJO1icsEefIQbcnpKTKSi46OXTees
 hqxzlHZZ+BXDfEv2Ckgx1n1F2d5i/xvaMVXBARoCBiBazT47YOqtTTUHZzPIekK8T4ca
 c7L/OmviU8DxYv21/c4iSiiGmdZCeiK//BcJlDWCJMZy+cispZNlgLAJ4Xed9e+WCsbk
 QjIQ==
X-Gm-Message-State: AOJu0YxyGNnuSJXIiW+ratM962Up9UsWzXLdFpN3rhMXDrEoEsizup9n
 vA3Hh5H60V88GJzrW76ZUb0AcX0yUKKYbt+0oKkoJV7YV77jzyT3H6S6COqDUXNU3V3976sYcUf
 Grv+/gLWpYLUFrRZw8QFzDPNclsZ9L24K
X-Google-Smtp-Source: AGHT+IEDHbqj/2ZuNRY/+2pOwMMw9gYD5qZzl7XsCDMTeQ/ugeH4VbHGqEFqAjYqiPFRwylfiXMm+JWc4z1tQCPpQpU=
X-Received: by 2002:a05:622a:13d2:b0:440:27db:e855 with SMTP id
 d75a77b69052e-4402b6c8f5amr20378491cf.57.1717574169010; Wed, 05 Jun 2024
 00:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
In-Reply-To: <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 11:55:57 +0400
Message-ID: <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000382864061a1fe6c2"
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

--000000000000382864061a1fe6c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:

> On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, May 30, 2024 at 2:44=E2=80=AFAM <dongwon.kim@intel.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     From: Dongwon <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>=
>
> >
> >     Make sure rendering of the current frame is finished before switchi=
ng
> >     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object t=
o
> be
> >     signaled.
> >
> >
> > Can you expand on what this solves?
>
> In current scheme, guest waits for the fence to be signaled for each
> frame it submits before moving to the next frame. If the guest=E2=80=99s =
state
> is saved while it is still waiting for the fence, The guest will
> continue to  wait for the fence that was signaled while ago when it is
> restored to the point. One way to prevent it is to get it finish the
> current frame before changing the state.
>

After the UI sets a fence, hw_ops->gl_block(true) gets called, which will
block virtio-gpu/virgl from processing commands (until the fence is
signaled and gl_block/false called again).

But this "blocking" state is not saved. So how does this affect
save/restore? Please give more details, thanks


> >
> >
> >     Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
> >     <mailto:marcandre.lureau@redhat.com>>
> >     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com
> >     <mailto:vivek.kasireddy@intel.com>>
> >     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>>
> >     ---
> >       ui/egl-helpers.c |  2 --
> >       ui/gtk.c         | 19 +++++++++++++++++++
> >       2 files changed, 19 insertions(+), 2 deletions(-)
> >
> >     diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> >     index 99b2ebbe23..dafeb36074 100644
> >     --- a/ui/egl-helpers.c
> >     +++ b/ui/egl-helpers.c
> >     @@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf=
)
> >               fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display,
> >                                                     sync);
> >               qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
> >     -        eglDestroySyncKHR(qemu_egl_display, sync);
> >     -        qemu_dmabuf_set_sync(dmabuf, NULL);
> >
> >
> > If this function is called multiple times, it will now set a new
> > fence_fd each time, and potentially leak older fd. Maybe it could first
> > check if a fence_fd exists instead.
>
> We can make that change.
>
> >
> >           }
> >       }
> >
> >     diff --git a/ui/gtk.c b/ui/gtk.c
> >     index 93b13b7a30..cf0dd6abed 100644
> >     --- a/ui/gtk.c
> >     +++ b/ui/gtk.c
> >     @@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vcon)
> >
> >           fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
> >           if (fence_fd >=3D 0) {
> >     +        void *sync =3D qemu_dmabuf_get_sync(dmabuf);
> >               qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
> >               close(fence_fd);
> >               qemu_dmabuf_set_fence_fd(dmabuf, -1);
> >     +        eglDestroySyncKHR(qemu_egl_display, sync);
> >     +        qemu_dmabuf_set_sync(dmabuf, NULL);
> >               graphic_hw_gl_block(vc->gfx.dcl.con, false);
> >           }
> >       }
> >     @@ -682,6 +685,22 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
> >       static void gd_change_runstate(void *opaque, bool running,
> >     RunState state)
> >       {
> >           GtkDisplayState *s =3D opaque;
> >     +    QemuDmaBuf *dmabuf;
> >     +    int i;
> >     +
> >     +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> >     +        for (i =3D 0; i < s->nb_vcs; i++) {
> >     +            VirtualConsole *vc =3D &s->vc[i];
> >     +            dmabuf =3D vc->gfx.guest_fb.dmabuf;
> >     +            if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) >=3D 0)=
 {
> >     +                /* wait for the rendering to be completed */
> >     +                eglClientWaitSync(qemu_egl_display,
> >     +                                  qemu_dmabuf_get_sync(dmabuf),
> >     +                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
> >     +                                  1000000000);
> >
> >
> >   I don't think adding waiting points in the migration path is
> > appropriate. Perhaps once you explain the actual issue, it will be
> > easier to help.
> >
> >     +            }
> >     +        }
> >     +    }
> >
> >           gd_update_caption(s);
> >       }
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

--000000000000382864061a1fe6c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 9:49=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Thu, May 30, 2024 at 2:44=E2=80=AFAM &lt;<a href=3D"mailto:dongwon.=
kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Dongwon &lt;<a href=3D"mailto:dongwon.kim@int=
el.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"m=
ailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt=
;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Make sure rendering of the current frame is finishe=
d before switching<br>
&gt;=C2=A0 =C2=A0 =C2=A0the run state to RUN_STATE_SAVE_VM by waiting for e=
gl-sync object to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0signaled.<br>
&gt; <br>
&gt; <br>
&gt; Can you expand on what this solves?<br>
<br>
In current scheme, guest waits for the fence to be signaled for each <br>
frame it submits before moving to the next frame. If the guest=E2=80=99s st=
ate <br>
is saved while it is still waiting for the fence, The guest will <br>
continue to=C2=A0 wait for the fence that was signaled while ago when it is=
 <br>
restored to the point. One way to prevent it is to get it finish the <br>
current frame before changing the state.<br></blockquote><div><br></div><di=
v>After the UI sets a fence, hw_ops-&gt;gl_block(true) gets called, which w=
ill block virtio-gpu/virgl from processing commands (until the fence is sig=
naled and gl_block/false called again).</div><div><br></div><div>But this &=
quot;blocking&quot; state is not saved. So how does this affect save/restor=
e? Please give more details, thanks<br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a=
><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marcandre.lureau@redha=
t.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kas=
ireddy@intel.com" target=3D"_blank">vivek.kasireddy@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:vivek.kasireddy@intel.=
com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:do=
ngwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/egl-helpers.c |=C2=A0 2 --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
19 +++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02 files changed, 19 insertions(+), 2 deletio=
ns(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0index 99b2ebbe23..dafeb36074 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/ui/egl-helpers.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/ui/egl-helpers.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(Qe=
muDmaBuf *dmabuf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fence_fd =3D egl=
DupNativeFenceFDANDROID(qemu_egl_display,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sync);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_=
fence_fd(dmabuf, fence_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu=
_egl_display, sync);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(d=
mabuf, NULL);<br>
&gt; <br>
&gt; <br>
&gt; If this function is called multiple times, it will now set a new <br>
&gt; fence_fd each time, and potentially leak older fd. Maybe it could firs=
t <br>
&gt; check if a fence_fd exists instead.<br>
<br>
We can make that change.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/ui/gtk.c b/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 93b13b7a30..cf0dd6abed 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vc=
on)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fence_fd =3D qemu_dmabuf_get_f=
ence_fd(dmabuf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fence_fd &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *sync =3D qemu_dm=
abuf_get_sync(dmabuf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_fd_hand=
ler(fence_fd, NULL, NULL, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fence_fd);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_=
fence_fd(dmabuf, -1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu=
_egl_display, sync);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(d=
mabuf, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_bl=
ock(vc-&gt;gfx.dcl.con, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -682,6 +685,22 @@ static const DisplayGLCtxOps e=
gl_ctx_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static void gd_change_runstate(void *opaque,=
 bool running,<br>
&gt;=C2=A0 =C2=A0 =C2=A0RunState state)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GtkDisplayState *s =3D opaque;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 QemuDmaBuf *dmabuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (state =3D=3D RUN_STATE_SAVE_VM) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; s=
-&gt;nb_vcs; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtualC=
onsole *vc =3D &amp;s-&gt;vc[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf =
=3D vc-&gt;gfx.guest_fb.dmabuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dmab=
uf &amp;&amp; qemu_dmabuf_get_fence_fd(dmabuf) &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* wait for the rendering to be completed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 eglClientWaitSync(qemu_egl_display,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_=
dmabuf_get_sync(dmabuf),<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EGL_S=
YNC_FLUSH_COMMANDS_BIT_KHR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10000=
00000);<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0I don&#39;t think adding waiting points in the migration p=
ath is <br>
&gt; appropriate. Perhaps once you explain the actual issue, it will be <br=
>
&gt; easier to help.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gd_update_caption(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
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

--000000000000382864061a1fe6c2--

