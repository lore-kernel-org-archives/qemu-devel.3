Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2EDC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 07:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV4iv-0001x1-8J; Wed, 31 Jan 2024 02:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rV4ig-0001ca-DC
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:09:16 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rV4id-0004Gi-52
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:09:13 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42a8a398cb2so43294381cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 23:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684949; x=1707289749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpc4cL3kzvl8tTCs9w7lKB+yt7W9tMR4Ryk7kizs/Os=;
 b=gqXr7AAqlMAoBofKF9p6jh1DXWHtJhBrmJ6VYNFP2jP9H+E29fnMbm8MxCOQoFS9Ru
 AcflQLLg2fL+Encqd+MSMBt6fXL8lO0dYOr5mfU0Rpq6f17+V6nuWGMQnOfbFSL/xcNL
 G5b/YWDQbg6NP3mPit86n+Q1vWbFu0nkuW0bLH1xeYznPuJdRjHNiPPpqg2AZoeCYs0N
 2C00JqgE3zNTIgH3VwaLhwxvCSkUAuioQYUPuTbRQK0Bjo4wvWL0T81Aow6QgZh7loh6
 73TJibPlkws6R1TgkifEuuHNWx02mFX6wI2FfgCv9lIIDCbe1pdPcwBp/4OT9ki/k3Zt
 20yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684949; x=1707289749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpc4cL3kzvl8tTCs9w7lKB+yt7W9tMR4Ryk7kizs/Os=;
 b=LANJAM5LeOFHaglBJN1Mae/Ke8rW8k+LkgEN8OI4oXBrVW+MepO/FXiXbKwJOB5ZI/
 lSPnsYQ1jM6bri3Xta/bFoUhlwrnglkUCR/cFFbTOZrtiD78AG1868i+QSNGDsGekCIA
 YBX3CkoDBdVpn70e1cO9KDFN+cJNtS3HZthhR/f0XO52fqarzFceE4XBaERCFY2JOGlv
 lvSsJp2VwmxWoM/ibWjkiZmUfexxh8fiNSUdaOIFr+iVPnUYJ+SiepkW798v+Cc5ANj0
 +Ogf0Nd4LHp/KVkCd2mMo9N6iBHj6uhRCuYYufVU12rV1v0ErRB6zLX15AnGp6bUwbWF
 oGJA==
X-Gm-Message-State: AOJu0YzbhC5UXyKb5NOu4R5N8ZaeyQRR+h4k6nNaU+F0FAaYalzxs6Ey
 Ly6p6SPtEU9GgDwPWUOVeeZXdRiF7cFhRk8uEoxwzCTquht9OgOEffaQEaSRsoy10dmh4poK7EY
 KEgfe0g0VdxSrj5n9nP+GBWiBnik=
X-Google-Smtp-Source: AGHT+IGVHaSthsluYm65axoqNSpav0OKFXzGhO5k5qvdnqMdLF0ueB6JTqOMQWzPPvvaoeMr+BLmBOK4Hoko80JBnpg=
X-Received: by 2002:a05:622a:54e:b0:42a:5150:3e46 with SMTP id
 m14-20020a05622a054e00b0042a51503e46mr934594qtx.47.1706684949356; Tue, 30 Jan
 2024 23:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
In-Reply-To: <20240130234840.53122-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jan 2024 11:08:57 +0400
Message-ID: <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Dongwon

On Wed, Jan 31, 2024 at 3:50=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> A new flag "visible" is added to show visibility status of the gfx consol=
e.
> The flag is set to 'true' when the VC is visible but set to 'false' when
> it is hidden or closed. When the VC is invisible, drawing guest frames
> should be skipped as it will never be completed and it would potentially
> lock up the guest display especially when blob scanout is used.

Can't it skip drawing when the widget is not visible instead?
https://docs.gtk.org/gtk3/method.Widget.is_visible.html

>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/gtk.h |  1 +
>  ui/gtk-egl.c     |  8 ++++++++
>  ui/gtk-gl-area.c |  8 ++++++++
>  ui/gtk.c         | 10 +++++++++-
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index aa3d637029..2de38e5724 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -57,6 +57,7 @@ typedef struct VirtualGfxConsole {
>      bool y0_top;
>      bool scanout_mode;
>      bool has_dmabuf;
> +    bool visible;
>  #endif
>  } VirtualGfxConsole;
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 3af5ac5bcf..993c283191 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -265,6 +265,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dc=
l,
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
> @@ -363,6 +367,10 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GtkWidget *area =3D vc->gfx.drawing_area;
>
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submit=
ted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 52dcac161e..04e07bd7ee 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -285,6 +285,10 @@ void gd_gl_area_scanout_flush(DisplayChangeListener =
*dcl,
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submit=
ted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
> @@ -299,6 +303,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener=
 *dcl,
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      egl_dmabuf_import_texture(dmabuf);
>      if (!dmabuf->texture) {
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..02eb667d8a 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1312,15 +1312,20 @@ static void gd_menu_quit(GtkMenuItem *item, void =
*opaque)
>  static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> -    VirtualConsole *vc =3D gd_vc_find_by_menu(s);
> +    VirtualConsole *vc;
>      GtkNotebook *nb =3D GTK_NOTEBOOK(s->notebook);
>      gint page;
>
> +    vc =3D gd_vc_find_current(s);
> +    vc->gfx.visible =3D false;
> +
> +    vc =3D gd_vc_find_by_menu(s);
>      gtk_release_modifiers(s);
>      if (vc) {
>          page =3D gtk_notebook_page_num(nb, vc->tab_item);
>          gtk_notebook_set_current_page(nb, page);
>          gtk_widget_grab_focus(vc->focus);
> +        vc->gfx.visible =3D true;
>      }
>  }
>
> @@ -1350,6 +1355,7 @@ static gboolean gd_tab_window_close(GtkWidget *widg=
et, GdkEvent *event,
>      VirtualConsole *vc =3D opaque;
>      GtkDisplayState *s =3D vc->s;
>
> +    vc->gfx.visible =3D false;
>      gtk_widget_set_sensitive(vc->menu_item, true);
>      gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
>      gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
> @@ -1423,6 +1429,7 @@ static void gd_menu_untabify(GtkMenuItem *item, voi=
d *opaque)
>          gd_update_geometry_hints(vc);
>          gd_update_caption(s);
>      }
> +    vc->gfx.visible =3D true;
>  }
>
>  static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
> @@ -2471,6 +2478,7 @@ static void gtk_display_init(DisplayState *ds, Disp=
layOptions *opts)
>  #ifdef CONFIG_GTK_CLIPBOARD
>      gd_clipboard_init(s);
>  #endif /* CONFIG_GTK_CLIPBOARD */
> +    vc->gfx.visible =3D true;
>  }
>
>  static void early_gtk_display_init(DisplayOptions *opts)
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

