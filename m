Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A186C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOy5O-0004yk-VO; Wed, 03 Jul 2024 07:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOy5M-0004xS-KG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:23:40 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOy5K-0000Pk-EN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:23:40 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e03b0e73f14so378092276.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720005816; x=1720610616; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rKVhzfZPL5+YvCvtSriRAAf0XoTEpPTQl6tEmKVUec=;
 b=Uu67DHjQtu1GDME4U6PlOA7aRpSCyjOUOJeoZ3i+nN7vUo9YwexU4w1R1KL7JXmFNn
 qaat20G4PiJSUC63w8ze0RqLhdb/nbWsXkmEx2LqkAzW1Us/UPm4qEH8bggg1+lqdw5s
 00noC2Afz/j59SpwVyzvwMqDjwX+5KaiWyO0DajKGTMLcJqkYfOpWyAdJK5y0lhLSjIh
 557rfMfryeNEzng3S7OdiuXDEI+SFnJ4ni3UYu/RM16B1uVTSL33Qqfapc0bblEFgyY9
 HkY3JBAblBO9tP6yoYFBCpUFZcPYn0Qp7y/GePJU0Pu9bGtTh7BwBTlUfSch2BVvDC5m
 3K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720005816; x=1720610616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rKVhzfZPL5+YvCvtSriRAAf0XoTEpPTQl6tEmKVUec=;
 b=CLKL937gUrhOT7pCh3CIQib++cYIFzAs90uSNbsdHVpCkzUk2hb3ocdf58+il/fYDr
 IWwrug7GmnPb13bhJxgdmDOrXS+QyYHwFVFybyZdD2E9velhlxck+j/YGAIo6Klpnba8
 s8XdQhwWsa6fXUSr8DYissCkY5xUD8GRaA9oZdXUoYNjm52qQD53YuyFgZN8jEAeTDxn
 YR9WOnBeifZtz+aTcbsfnItTZGAEQ2/FytZiI8W0gq9deOgiPsdEPqQFMaxQvi7+9ZYD
 tao62rxOfXR+/pWX06ANY2Xw780cMVR00nkPcxb/AlV0oNxvuwVcKpFpouIslZ0NsPzB
 UMQA==
X-Gm-Message-State: AOJu0YzabQX0zpsiGwI/mz25ihg8aB8Q7LYdUfxvCZqVOWoVh7llj+FK
 MFGniLexuYn1Q+peIIooXRrrvWbMI1SBy4nOqdKxyC9lz1afbIqTOKIoBdkjmq36B+aJbC5jLcQ
 4JowzFgues3pWEDlwW4ucDWaA8wc=
X-Google-Smtp-Source: AGHT+IGZtkuuFLGUD7n9PbTmgXEk58qsZYIbW36lP2sDFtUz04yC54rvMBu/bnHQuqwuZDqP3tijWNxqTXzbxYWIJIs=
X-Received: by 2002:a25:f453:0:b0:e03:2239:23e9 with SMTP id
 3f1490d57ef6-e036ec8baa8mr11590852276.58.1720005815861; Wed, 03 Jul 2024
 04:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240702205503.2774745-1-dongwon.kim@intel.com>
 <20240702205503.2774745-2-dongwon.kim@intel.com>
In-Reply-To: <20240702205503.2774745-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jul 2024 15:23:24 +0400
Message-ID: <CAJ+F1C+ssSiGR3tOzK9Sj_8gn2k-rX3_w=WKG1-n35uVBSn9PA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/egl-helpers: Consolidate create-sync and
 create-fence
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aa884a061c560fff"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2b.google.com
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

--000000000000aa884a061c560fff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 3, 2024 at 12:57=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> There is no reason to split those two operations so combining
> two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.
>
> v2: egl_dmabuf_create_fence -> egl_dmabuf_create_fence_fd
>     (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/egl-helpers.h |  3 +--
>  ui/egl-helpers.c         | 27 +++++++++++----------------
>  ui/gtk-egl.c             | 15 +++------------
>  ui/gtk-gl-area.c         | 10 ++--------
>  4 files changed, 17 insertions(+), 38 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 4b8c0d2281..221548e3c9 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint
> *stride, EGLint *fourcc,
>
>  void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
>  void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
> -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
> -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
> +int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf);
>
>  #endif
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 99b2ebbe23..ddbf52bf5f 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
>      qemu_dmabuf_set_texture(dmabuf, 0);
>  }
>
> -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
> +int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf)
>  {
>      EGLSyncKHR sync;
> +    int fence_fd =3D -1;
>
>      if (epoxy_has_egl_extension(qemu_egl_display,
>                                  "EGL_KHR_fence_sync") &&
>          epoxy_has_egl_extension(qemu_egl_display,
> -                                "EGL_ANDROID_native_fence_sync")) {
> +                                "EGL_ANDROID_native_fence_sync") &&
> +        qemu_dmabuf_get_fence_fd(dmabuf) =3D=3D -1) {
>          sync =3D eglCreateSyncKHR(qemu_egl_display,
>                                  EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
>          if (sync !=3D EGL_NO_SYNC_KHR) {
> -            qemu_dmabuf_set_sync(dmabuf, sync);
> +            fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display,
> +                                                  sync);
> +            if (fence_fd >=3D 0) {
> +                qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
> +            }
> +            eglDestroySyncKHR(qemu_egl_display, sync);
>          }
>      }
> -}
> -
> -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
> -{
> -    void *sync =3D qemu_dmabuf_get_sync(dmabuf);
> -    int fence_fd;
>
> -    if (sync) {
> -        fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display,
> -                                              sync);
> -        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
> -        eglDestroySyncKHR(qemu_egl_display, sync);
> -        qemu_dmabuf_set_sync(dmabuf, NULL);
> -    }
> +    return fence_fd;
>  }
>
>  #endif /* CONFIG_GBM */
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 9831c10e1b..8869cdee4f 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)
>      GdkWindow *window;
>  #ifdef CONFIG_GBM
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> -    int fence_fd;
>  #endif
>      int ww, wh, ws;
>
> @@ -99,13 +98,12 @@ void gd_egl_draw(VirtualConsole *vc)
>          glFlush();
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
> -            egl_dmabuf_create_fence(dmabuf);
> -            fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
> +            int fence_fd =3D egl_dmabuf_create_fence_fd(dmabuf);
>              if (fence_fd >=3D 0) {
>                  qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc=
);
> -                return;
> +            } else {
> +                graphic_hw_gl_block(vc->gfx.dcl.con, false);
>              }
>

If gd_egl_draw()/gd_egl_refresh() is called multiple times before the
flushed callback, create_fence_fd() is going to return -1 and unblock the
hw. This is probably not desired. I think you need to comment on the code
to explain the interaction between dmabuf_get_draw_submitted,
gd_egl_flush(), fences and hw_block, I can't make sense of it.

thanks


> -            graphic_hw_gl_block(vc->gfx.dcl.con, false);
>          }
>  #endif
>      } else {
> @@ -364,12 +362,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl=
,
>          egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top)=
;
>      }
>
> -#ifdef CONFIG_GBM
> -    if (vc->gfx.guest_fb.dmabuf) {
> -        egl_dmabuf_create_sync(vc->gfx.guest_fb.dmabuf);
> -    }
> -#endif
> -
>      eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
>  }
>
> @@ -387,7 +379,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>          gtk_widget_queue_draw_area(area, x, y, w, h);
>          return;
>      }
> -
>      gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
>  }
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index b628b35451..a3c21c3c59 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -77,17 +77,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
>          glBlitFramebuffer(0, y1, vc->gfx.w, y2,
>                            0, 0, ww, wh,
>                            GL_COLOR_BUFFER_BIT, GL_NEAREST);
> -#ifdef CONFIG_GBM
> -        if (dmabuf) {
> -            egl_dmabuf_create_sync(dmabuf);
> -        }
> -#endif
> -        glFlush();
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
>              int fence_fd;
> -            egl_dmabuf_create_fence(dmabuf);
> -            fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
> +            fence_fd =3D egl_dmabuf_create_fence_fd(dmabuf);
>              if (fence_fd >=3D 0) {
>                  qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc=
);
>                  return;
> @@ -95,6 +88,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>              graphic_hw_gl_block(vc->gfx.dcl.con, false);
>          }
>  #endif
> +        glFlush();
>      } else {
>          if (!vc->gfx.ds) {
>              return;
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000aa884a061c560fff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, 2024 at 12:57=E2=80=
=AFAM &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blan=
k">dongwon.kim@intel.com</a>&gt;<br>
<br>
There is no reason to split those two operations so combining<br>
two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.<br>
<br>
v2: egl_dmabuf_create_fence -&gt; egl_dmabuf_create_fence_fd<br>
=C2=A0 =C2=A0 (Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;)<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
---<br>
=C2=A0include/ui/egl-helpers.h |=C2=A0 3 +--<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 +++++++++++---=
-------------<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +++-=
-----------<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++--------<br>
=C2=A04 files changed, 17 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h<br>
index 4b8c0d2281..221548e3c9 100644<br>
--- a/include/ui/egl-helpers.h<br>
+++ b/include/ui/egl-helpers.h<br>
@@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *strid=
e, EGLint *fourcc,<br>
<br>
=C2=A0void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);<br>
=C2=A0void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);<br>
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);<br>
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);<br>
+int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf);<br>
<br>
=C2=A0#endif<br>
<br>
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br>
index 99b2ebbe23..ddbf52bf5f 100644<br>
--- a/ui/egl-helpers.c<br>
+++ b/ui/egl-helpers.c<br>
@@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)<b=
r>
=C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_texture(dmabuf, 0);<br>
=C2=A0}<br>
<br>
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)<br>
+int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0EGLSyncKHR sync;<br>
+=C2=A0 =C2=A0 int fence_fd =3D -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (epoxy_has_egl_extension(qemu_egl_display,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;EGL_KHR_fence_sync&quot;=
) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0epoxy_has_egl_extension(qemu_egl_display,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EGL_ANDROID_native_fence_sync&=
quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EGL_ANDROID_native_fence_sync&=
quot;) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_get_fence_fd(dmabuf) =3D=3D -1) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sync =3D eglCreateSyncKHR(qemu_egl_displa=
y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EGL_SYNC_NATIVE_FENCE_ANDROID,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sync !=3D EGL_NO_SYNC_KHR) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(dmabuf, syn=
c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D eglDupNativeFenceFD=
ANDROID(qemu_egl_display,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sync);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fence_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_fe=
nce_fd(dmabuf, fence_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu_egl_displ=
ay, sync);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)<br>
-{<br>
-=C2=A0 =C2=A0 void *sync =3D qemu_dmabuf_get_sync(dmabuf);<br>
-=C2=A0 =C2=A0 int fence_fd;<br>
<br>
-=C2=A0 =C2=A0 if (sync) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D eglDupNativeFenceFDANDROID(qemu_e=
gl_display,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sync);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 eglDestroySyncKHR(qemu_egl_display, sync);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dmabuf_set_sync(dmabuf, NULL);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return fence_fd;<br>
=C2=A0}<br>
<br>
=C2=A0#endif /* CONFIG_GBM */<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index 9831c10e1b..8869cdee4f 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)<br>
=C2=A0 =C2=A0 =C2=A0GdkWindow *window;<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0QemuDmaBuf *dmabuf =3D vc-&gt;gfx.guest_fb.dmabuf;<br>
-=C2=A0 =C2=A0 int fence_fd;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0int ww, wh, ws;<br>
<br>
@@ -99,13 +98,12 @@ void gd_egl_draw(VirtualConsole *vc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0glFlush();<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dmabuf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_dmabuf_create_fence(dmabuf);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D qemu_dmabuf_get_fen=
ce_fd(dmabuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fence_fd =3D egl_dmabuf_crea=
te_fence_fd(dmabuf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fence_fd &gt;=3D 0) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_fd_h=
andler(fence_fd, gd_hw_gl_flushed, NULL, vc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_gl_bloc=
k(vc-&gt;gfx.dcl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br>=
</div><div>If gd_egl_draw()/gd_egl_refresh() is called multiple times befor=
e the flushed callback, create_fence_fd() is going to return -1 and unblock=
 the hw. This is probably not desired. I think you need to comment on the c=
ode to explain the interaction between dmabuf_get_draw_submitted, gd_egl_fl=
ush(), fences and hw_block, I can&#39;t make sense of it.</div><div><br></d=
iv><div>thanks<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_gl_block(vc-&gt;gfx.d=
cl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -364,12 +362,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_blit(&amp;vc-&gt;gfx.win_fb, &amp;=
vc-&gt;gfx.guest_fb, !vc-&gt;gfx.y0_top);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-#ifdef CONFIG_GBM<br>
-=C2=A0 =C2=A0 if (vc-&gt;gfx.guest_fb.dmabuf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_dmabuf_create_sync(vc-&gt;gfx.guest_fb.dma=
buf);<br>
-=C2=A0 =C2=A0 }<br>
-#endif<br>
-<br>
=C2=A0 =C2=A0 =C2=A0eglSwapBuffers(qemu_egl_display, vc-&gt;gfx.esurface);<=
br>
=C2=A0}<br>
<br>
@@ -387,7 +379,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_widget_queue_draw_area(area, x, y, w,=
 h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_flush(&amp;vc-&gt;gfx.dcl, x, y, w, h);<=
br>
=C2=A0}<br>
<br>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index b628b35451..a3c21c3c59 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -77,17 +77,10 @@ void gd_gl_area_draw(VirtualConsole *vc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0glBlitFramebuffer(0, y1, vc-&gt;gfx.w, y2=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00, 0, ww, wh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0GL_COLOR_BUFFER_BIT, GL_NEAREST);<br>
-#ifdef CONFIG_GBM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dmabuf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_dmabuf_create_sync(dmabuf);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 glFlush();<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dmabuf) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fence_fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_dmabuf_create_fence(dmabuf);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D qemu_dmabuf_get_fen=
ce_fd(dmabuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D egl_dmabuf_create_f=
ence_fd(dmabuf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fence_fd &gt;=3D 0) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_fd_h=
andler(fence_fd, gd_hw_gl_flushed, NULL, vc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -95,6 +88,7 @@ void gd_gl_area_draw(VirtualConsole *vc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(vc-&gt;=
gfx.dcl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 glFlush();<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.ds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000aa884a061c560fff--

