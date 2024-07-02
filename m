Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6875C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYx0-0003mJ-RX; Tue, 02 Jul 2024 04:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOYwx-0003lv-17
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:33:20 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOYws-0002hl-0d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:33:17 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4465b40496cso17031111cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719909192; x=1720513992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p2C+3RezIVO2n0vhfGa7sg641DiKZXNL8p22aPZdTJs=;
 b=lJM/SM9yTNPXDwbo1AXm25DnDGzBQ8sNEHDUp66tld0Z3UjStNKl0AI+kbCFypobbT
 jRboO9Y1DtfyHqGQzbVVRkwfhZrsZh6Yj0gVu2lW2fSt6NWkV6H/GPQbqXm9K8AyOCPH
 MzbW92X6gGVumjhY/diq/DszIDA5PkAM9ler22ORswvLg2k15XJrn5BeMHlNNGUr9ZSx
 Y91mIA9jCYi3y8vZCIL43mgWfRoW9dqRvWmO6Qam2mHOfpMyBE3jrOlGxoQhd+4N/Mw3
 BJXo/HgQpEXYIZgPbK1gk5OGIkI74Xs69qhNnWxhbEOA1SEZifKdLyfuMHWYqnPUpWwp
 SqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719909192; x=1720513992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2C+3RezIVO2n0vhfGa7sg641DiKZXNL8p22aPZdTJs=;
 b=UNBYLTW7yKHR/g+Ndvuhsw0H/wyt8XTrEVKsnp9HoFtVLZSUse5nQGjBUdLulN3QNQ
 HVXXvw4kYWp9ltFh5cLg56clrpl0FniZmnvERjLQC+GZu5mdQ7IBzLYsohoOC3mGIlEX
 wYYlFOyErj6HQ6ne1QhV14DNqaVY2jWUUMiWZEKShbju0Nk5Hkuv/QdAi2pjfam+Snw8
 HJ0fIwMmiafXDWK7Mlx3KGeGZxxqkJ0APbV0CT7GbW7h2bOzSyxl337md005FSV5TKPE
 fR1ZYGgmDTAsF9XZnf6y/JUwpsVXcKyMjCfXoOMZtHzx72C/ZHDXMm/yqwoWY+E+U3xU
 FcPQ==
X-Gm-Message-State: AOJu0YxIiMl+C+FkcegDBYYCNo63V62TgSEBg+3/5drGY/ppOYg7FX8B
 lNov/mS1/SpMAgefjrEdV+dVShOYc/cmV5m+e6r0dKVZPnS5P/h6cO8H8cUzJSSvbSvsvdhFp1+
 skkYx50YpLhmS9L6DWy0Yuz5REYk=
X-Google-Smtp-Source: AGHT+IH8/tbOka1D6k9F7cbvjHkZNGfRqFNB7+SaDO6xkM0bXX6e65JHosscqqtYDCiOU00oDo7jO+94C7jfrj2h2F0=
X-Received: by 2002:a05:622a:11cd:b0:445:5726:1545 with SMTP id
 d75a77b69052e-44662d93a9amr95017521cf.11.1719909192217; Tue, 02 Jul 2024
 01:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <20240620231727.235841-3-dongwon.kim@intel.com>
In-Reply-To: <20240620231727.235841-3-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 12:32:59 +0400
Message-ID: <CAJ+F1C+zF24yTBcx_2X_0e+NZhqxzxk3HDXRzc9eDyWp7uYyCA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] ui/egl-helpers: Consolidates create-sync and
 create-fence
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000072b9e0061c3f9063"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

--00000000000072b9e0061c3f9063
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 21, 2024 at 3:19=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> There is no reason to split those two operations so combining
> two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Can you send this change as a different patch series, or earlier in the
series?

You should also remove qemu_dmabuf_{set,get}_sync() and associated fields

---
>  include/ui/egl-helpers.h |  3 +--
>  ui/egl-helpers.c         | 27 +++++++++++----------------
>  ui/gtk-egl.c             | 19 +++++++------------
>  ui/gtk-gl-area.c         | 10 ++--------
>  4 files changed, 21 insertions(+), 38 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 4b8c0d2281..606d6c8288 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint
> *stride, EGLint *fourcc,
>
>  void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
>  void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
> -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
> -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
> +int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
>
>  #endif
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 99b2ebbe23..e16f2cb23d 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
>      qemu_dmabuf_set_texture(dmabuf, 0);
>  }
>
> -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
> +int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
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
>

It should probably return qemu_dmabuf_get_fence_fd() instead. The function
should be renamed with _fd postfix since you make it return the fd.

 }
>
>  #endif /* CONFIG_GBM */
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 9831c10e1b..55199f8659 100644
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
> +            fence_fd =3D egl_dmabuf_create_fence(dmabuf);
>              if (fence_fd >=3D 0) {
>                  qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc=
);
> -                return;
> +            } else {
> +                graphic_hw_gl_block(vc->gfx.dcl.con, false);
>              }
> -            graphic_hw_gl_block(vc->gfx.dcl.con, false);
>          }
>  #endif
>      } else {
> @@ -336,7 +334,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl=
,
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GdkWindow *window;
> +#ifdef CONFIG_GBM
> +    QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> +#endif
>      int ww, wh, ws;
> +    int fence_fd;
>
>      if (!vc->gfx.scanout_mode) {
>          return;
> @@ -364,12 +366,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl=
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
> @@ -387,7 +383,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>          gtk_widget_queue_draw_area(area, x, y, w, h);
>          return;
>      }
> -
>      gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
>  }
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index b628b35451..0b11423824 100644
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
> +            fence_fd =3D egl_dmabuf_create_fence(dmabuf);
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

--00000000000072b9e0061c3f9063
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 3:19=E2=80=
=AFAM &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwo=
n.kim@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">From: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.co=
m" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
<br>
There is no reason to split those two operations so combining<br>
two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Can you send this change as a different patch series, or earlier in t=
he series?</div><div><br></div><div>You should also remove qemu_dmabuf_{set=
,get}_sync() and associated fields</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
---<br>
=C2=A0include/ui/egl-helpers.h |=C2=A0 3 +--<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 +++++++++++---=
-------------<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 ++++=
+++------------<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++--------<br>
=C2=A04 files changed, 21 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h<br>
index 4b8c0d2281..606d6c8288 100644<br>
--- a/include/ui/egl-helpers.h<br>
+++ b/include/ui/egl-helpers.h<br>
@@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *strid=
e, EGLint *fourcc,<br>
<br>
=C2=A0void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);<br>
=C2=A0void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);<br>
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);<br>
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);<br>
+int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);<br>
<br>
=C2=A0#endif<br>
<br>
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br>
index 99b2ebbe23..e16f2cb23d 100644<br>
--- a/ui/egl-helpers.c<br>
+++ b/ui/egl-helpers.c<br>
@@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)<b=
r>
=C2=A0 =C2=A0 =C2=A0qemu_dmabuf_set_texture(dmabuf, 0);<br>
=C2=A0}<br>
<br>
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)<br>
+int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)<br>
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
+=C2=A0 =C2=A0 return fence_fd;<br></blockquote><div><br></div><div>It shou=
ld probably return qemu_dmabuf_get_fence_fd() instead. The function should =
be renamed with _fd postfix since you make it return the fd.</div><br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0#endif /* CONFIG_GBM */<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index 9831c10e1b..55199f8659 100644<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence_fd =3D egl_dmabuf_create_f=
ence(dmabuf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fence_fd &gt;=3D 0) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_fd_h=
andler(fence_fd, gd_hw_gl_flushed, NULL, vc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_gl_bloc=
k(vc-&gt;gfx.dcl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_gl_block(vc-&gt;gfx.d=
cl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -336,7 +334,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtualConsole *vc =3D container_of(dcl, VirtualConsole=
, gfx.dcl);<br>
=C2=A0 =C2=A0 =C2=A0GdkWindow *window;<br>
+#ifdef CONFIG_GBM<br>
+=C2=A0 =C2=A0 QemuDmaBuf *dmabuf =3D vc-&gt;gfx.guest_fb.dmabuf;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0int ww, wh, ws;<br>
+=C2=A0 =C2=A0 int fence_fd;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vc-&gt;gfx.scanout_mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -364,12 +366,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,<=
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
@@ -387,7 +383,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,<br>
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
index b628b35451..0b11423824 100644<br>
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
ence(dmabuf);<br>
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

--00000000000072b9e0061c3f9063--

