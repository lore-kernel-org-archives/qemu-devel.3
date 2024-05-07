Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED72FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KuZ-00074F-7A; Tue, 07 May 2024 09:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4KuS-0006zE-2C
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4KuP-0004dN-HR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715088659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSxVLygJ03xrEvM8RQU8DJe7UVHN1OiJgL7KHQ9arvA=;
 b=N3k7i81pkSWQfyQ24xPTxcgD1XSsT/Bp8KPxBhVItitm2of1BOlBWC/N8lN9agXN8JWexS
 Kx5pKOuXFx1vKsgYHO8J6I2MRF8Zkras9IWWFP/1ILp4Z6/6PdUzQu/yH9KDRKHyJZx+By
 erggHV7UTf2QzX7ngVoR8eX6+fEy6qg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-oW2JNKmMMSSOoRdvIhKIkA-1; Tue, 07 May 2024 09:30:57 -0400
X-MC-Unique: oW2JNKmMMSSOoRdvIhKIkA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572baf39435so5119871a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 06:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088656; x=1715693456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSxVLygJ03xrEvM8RQU8DJe7UVHN1OiJgL7KHQ9arvA=;
 b=CqmtK5KmS6N65FdQkkCaJBorSaBO0f91/RlYWrWzsdXpfou6/wDLw/93PfaPYBTDTN
 RsKf6TKDjAghnmR5FC0C7nTq4GHA5HUGS6keRTn9LCDszQr8/RhMKtpgrgonwaIvoqdc
 xEPFTdUw6eoPPgofyL/KacL0wU/0bWcy85bSM101Nvr3NS3OGXaREdDuAzzZ7MLXyeym
 39qzShbInPH53yEW0AVpb3SkyirgP8NLI5/5jwhL4Yx7ryd9bna+rt1oao/3e1fThiAC
 k6ZYoPwrdhenIVhm7fpOoUWjpnbuapFWLDwp+PYUwOnmNlNcoDjRQUCLcEvI6TTb5Dsn
 gBZA==
X-Gm-Message-State: AOJu0YwS9L8CvbyTMSXjnBtcZLnYjzf5BYs7eYTjvjJ84qJC3Am4HwnT
 aUgano/TZZQik2YzrpdT8EK/kKxfFAjuBla/0L/sodJimweFLN2tbp2Q+xMySLqQq1/2Llf2zP0
 uug2Gtwb1eEdj7oM12jFyoScjLAlxKnsR64MDUh0V1dSziK9+1uz+xh+tRxUb4s4ioruwBr5Tnt
 J56+6ayr3jKVyNO8Os3u06s8UH12w=
X-Received: by 2002:aa7:c642:0:b0:572:a852:c756 with SMTP id
 4fb4d7f45d1cf-57311032728mr2265201a12.12.1715088656674; 
 Tue, 07 May 2024 06:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF22U3B+1SBBDw2SYhC7sQfWA5b6xzE3vCrQrzjZKIYrsCtTHUeQu6rrDxag2L3/L8xyTiE1BlxX7jVNVZixX0=
X-Received: by 2002:aa7:c642:0:b0:572:a852:c756 with SMTP id
 4fb4d7f45d1cf-57311032728mr2265185a12.12.1715088656266; Tue, 07 May 2024
 06:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240425015342.1033815-1-dongwon.kim@intel.com>
 <20240425015342.1033815-5-dongwon.kim@intel.com>
In-Reply-To: <20240425015342.1033815-5-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 May 2024 17:30:44 +0400
Message-ID: <CAMxuvawNf3+yG2dGtPr3ej7u0uRB-93s0Uq5DSWJTwtqM5NFDw@mail.gmail.com>
Subject: Re: [PATCH v12 4/6] ui/console: Use qemu_dmabuf_set_..() helpers
 instead
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Apr 25, 2024 at 5:58=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This commit updates all occurrences where these fields were
> set directly have been updated to utilize helper functions.
>
> v7: removed prefix, "dpy_gl_" from all helpers
>
> v8: Introduction of helpers was removed as those were already added
>     by the previous commit
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/egl-helpers.c | 16 +++++++++-------
>  ui/gtk-egl.c     |  4 ++--
>  ui/gtk-gl-area.c |  4 ++--
>  ui/gtk.c         |  6 +++---
>  4 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 3f96e63d25..99b2ebbe23 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -348,8 +348,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>          return;
>      }
>
> -    glGenTextures(1, &dmabuf->texture);
> -    texture =3D qemu_dmabuf_get_texture(dmabuf);
> +    glGenTextures(1, &texture);
> +    qemu_dmabuf_set_texture(dmabuf, texture);
>      glBindTexture(GL_TEXTURE_2D, texture);
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
> @@ -368,7 +368,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
>      }
>
>      glDeleteTextures(1, &texture);
> -    dmabuf->texture =3D 0;
> +    qemu_dmabuf_set_texture(dmabuf, 0);
>  }
>
>  void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
> @@ -382,7 +382,7 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
>          sync =3D eglCreateSyncKHR(qemu_egl_display,
>                                  EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
>          if (sync !=3D EGL_NO_SYNC_KHR) {
> -            dmabuf->sync =3D sync;
> +            qemu_dmabuf_set_sync(dmabuf, sync);
>          }
>      }
>  }
> @@ -390,12 +390,14 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
>  void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>  {
>      void *sync =3D qemu_dmabuf_get_sync(dmabuf);
> +    int fence_fd;
>
>      if (sync) {
> -        dmabuf->fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display=
,
> -                                                      sync);
> +        fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display,
> +                                              sync);
> +        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>          eglDestroySyncKHR(qemu_egl_display, sync);
> -        dmabuf->sync =3D NULL;
> +        qemu_dmabuf_set_sync(dmabuf, NULL);
>      }
>  }
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 7a45daefa1..ec0bf45482 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -87,7 +87,7 @@ void gd_egl_draw(VirtualConsole *vc)
>              if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
>                  return;
>              } else {
> -                dmabuf->draw_submitted =3D false;
> +                qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
>          }
>  #endif
> @@ -381,7 +381,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
> -        vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> +        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_egl_set_scanout_mode(vc, true);
>          gtk_widget_queue_draw_area(area, x, y, w, h);
>          return;
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2d70280803..9a3f3d0d71 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -63,7 +63,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>              if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
>                  return;
>              } else {
> -                dmabuf->draw_submitted =3D false;
> +                qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
>          }
>  #endif
> @@ -291,7 +291,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *=
dcl,
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
> -        vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> +        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_gl_area_set_scanout_mode(vc, true);
>      }
>      gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 237c913b26..3a6832eb1b 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -598,11 +598,11 @@ void gd_hw_gl_flushed(void *vcon)
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>      int fence_fd;
>
> -    if (dmabuf->fence_fd >=3D 0) {
> -        fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
> +    fence_fd =3D qemu_dmabuf_get_fence_fd(dmabuf);
> +    if (fence_fd >=3D 0) {
>          qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
>          close(fence_fd);
> -        dmabuf->fence_fd =3D -1;
> +        qemu_dmabuf_set_fence_fd(dmabuf, -1);
>          graphic_hw_gl_block(vc->gfx.dcl.con, false);
>      }
>  }
> --
> 2.34.1
>


