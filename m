Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3766C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 06:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVQmq-0001vz-98; Thu, 01 Feb 2024 01:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rVQmo-0001vm-10
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:42:58 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rVQml-0001HK-60
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:42:57 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42ab7522bf6so2899731cf.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 22:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706769773; x=1707374573; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vK3euHrVD3OszPyMZW1tBZmcPq2GoJAVrVGjAjvYsL8=;
 b=egRsiq9btWkly7oN4FnqjBqj/WeAXtSA+4UplPFz0G9ozLg7gOWrc0dR16fGMjjsJh
 tmIZ97o1zpo/rRWpZyoKzeDEdpoxrpEoFmzoMe2dLgPOKnkMAPBO9+5HjmJGQH4luWjO
 D+6Cw3zPSfVY/CwoUis+tz9bFMKHaN4tFyfb41ApZEfmvpXQx4QVljrGd20FFfqcDXry
 f91W2hyPq2Cd3CZ3F+OT3nX11qNPqtQ69Bptvmt6PwKnHU2gn7Lxr1WbHcPhoF4xC+dg
 PRfRJTfDKoIhGv8jm9LTkOhMqgb3NmyPXqxSLs2zlgD4DgXHAxnFdNKMt7+f6DYiYJuB
 sFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706769773; x=1707374573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vK3euHrVD3OszPyMZW1tBZmcPq2GoJAVrVGjAjvYsL8=;
 b=S5wnLT/MLE5pTxwldkD4bvp50jxH0m2a0vR0WNPSXw5VZp060RDbMnF5myx6adYKXp
 mVBlsRAADRgUJxB9XV4maSFX9mXv+EH2fhCOIDMNIy1R5wHXO35lB5kelw+V/dihLGev
 OhBJsv/y5TCmj/ZQ63yLn2e+PmwXtdMgxtUViBllZ8iJg7HdY2sxbbybiok5ZeQucgp1
 N52rWpCIqfWxNVuldNCQZvueRC0XCCTsre5GA2x43O4B72q/rDL94uWNjRIc3J9GQ4LR
 jNGueejjumCBRjERkZJqUf8K647OGMXUFlkVeucIXn0Bd1Hr2bcEXkut/VccuHOZaeQ3
 xyMA==
X-Gm-Message-State: AOJu0Yw2ACnFwXbAaq5ezwbhEi7rqWIfkLNRuPRNSYvV/SWPPOnK7AAs
 mTkHamYLh4oN+CStlZkk4KOZgS7TiXFtnNaXNrEJHXDcLzzCuincckICKsTMymNADI80+DgAyuy
 v1AGVLLlqgD75IOF/91p53OcTca4=
X-Google-Smtp-Source: AGHT+IHg1bCJy1lZ2a04mJYldBsu4pZPnhAgj8IUtaNQuwHbk3I2IPYbLe3jUgf3G2DzjctkuLXfCl7oa8WdTCWHCt0=
X-Received: by 2002:a05:622a:13d2:b0:42b:e02b:c33a with SMTP id
 p18-20020a05622a13d200b0042be02bc33amr3866197qtk.28.1706769773459; Wed, 31
 Jan 2024 22:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
 <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 1 Feb 2024 10:42:41 +0400
Message-ID: <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

Hi

On Wed, Jan 31, 2024 at 10:56=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.co=
m> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > https://docs.gtk.org/gtk3/method.Widget.is_visible.html
>
> This is what we had tried first but it didn't seem to work for the case o=
f window minimization.
> I see the visible flag for the GTK widget didn't seem to be toggled for s=
ome reason. And when

Right, because minimize !=3D visible. You can still get window preview
with alt-tab and other compositor drawings.

Iow, it should keep rendering even when minimized.

> closing window, vc->window widget is destroyed so it is not possible to c=
heck the flag using
> this GTK function. Having extra flag bound to VC was most intuitive for t=
he logic I wanted to
> implement.
>
> Thanks!!
> DW
>
> > Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associ=
ated
> > VC is invisible
> >
> > Hi Dongwon
> >
> > On Wed, Jan 31, 2024 at 3:50=E2=80=AFAM <dongwon.kim@intel.com> wrote:
> > >
> > > From: Dongwon Kim <dongwon.kim@intel.com>
> > >
> > > A new flag "visible" is added to show visibility status of the gfx co=
nsole.
> > > The flag is set to 'true' when the VC is visible but set to 'false'
> > > when it is hidden or closed. When the VC is invisible, drawing guest
> > > frames should be skipped as it will never be completed and it would
> > > potentially lock up the guest display especially when blob scanout is=
 used.
> >
> > Can't it skip drawing when the widget is not visible instead?
> > https://docs.gtk.org/gtk3/method.Widget.is_visible.html
> >
> > >
> > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > >
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  include/ui/gtk.h |  1 +
> > >  ui/gtk-egl.c     |  8 ++++++++
> > >  ui/gtk-gl-area.c |  8 ++++++++
> > >  ui/gtk.c         | 10 +++++++++-
> > >  4 files changed, 26 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> > > aa3d637029..2de38e5724 100644
> > > --- a/include/ui/gtk.h
> > > +++ b/include/ui/gtk.h
> > > @@ -57,6 +57,7 @@ typedef struct VirtualGfxConsole {
> > >      bool y0_top;
> > >      bool scanout_mode;
> > >      bool has_dmabuf;
> > > +    bool visible;
> > >  #endif
> > >  } VirtualGfxConsole;
> > >
> > > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c index 3af5ac5bcf..993c283191
> > > 100644
> > > --- a/ui/gtk-egl.c
> > > +++ b/ui/gtk-egl.c
> > > @@ -265,6 +265,10 @@ void
> > gd_egl_scanout_dmabuf(DisplayChangeListener
> > > *dcl,  #ifdef CONFIG_GBM
> > >      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> > >
> > > +    if (!vc->gfx.visible) {
> > > +        return;
> > > +    }
> > > +
> > >      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> > >                     vc->gfx.esurface, vc->gfx.ectx);
> > >
> > > @@ -363,6 +367,10 @@ void gd_egl_flush(DisplayChangeListener *dcl,
> > >      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> > >      GtkWidget *area =3D vc->gfx.drawing_area;
> > >
> > > +    if (!vc->gfx.visible) {
> > > +        return;
> > > +    }
> > > +
> > >      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf-
> > >draw_submitted) {
> > >          graphic_hw_gl_block(vc->gfx.dcl.con, true);
> > >          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true; diff --git
> > > a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c index 52dcac161e..04e07bd7ee
> > > 100644
> > > --- a/ui/gtk-gl-area.c
> > > +++ b/ui/gtk-gl-area.c
> > > @@ -285,6 +285,10 @@ void
> > > gd_gl_area_scanout_flush(DisplayChangeListener *dcl,  {
> > >      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> > >
> > > +    if (!vc->gfx.visible) {
> > > +        return;
> > > +    }
> > > +
> > >      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf-
> > >draw_submitted) {
> > >          graphic_hw_gl_block(vc->gfx.dcl.con, true);
> > >          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true; @@ -299,6
> > > +303,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
> > > #ifdef CONFIG_GBM
> > >      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> > >
> > > +    if (!vc->gfx.visible) {
> > > +        return;
> > > +    }
> > > +
> > >      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> > >      egl_dmabuf_import_texture(dmabuf);
> > >      if (!dmabuf->texture) {
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index 810d7fc796..02eb667d8a 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -1312,15 +1312,20 @@ static void gd_menu_quit(GtkMenuItem *item,
> > > void *opaque)  static void gd_menu_switch_vc(GtkMenuItem *item, void
> > > *opaque)  {
> > >      GtkDisplayState *s =3D opaque;
> > > -    VirtualConsole *vc =3D gd_vc_find_by_menu(s);
> > > +    VirtualConsole *vc;
> > >      GtkNotebook *nb =3D GTK_NOTEBOOK(s->notebook);
> > >      gint page;
> > >
> > > +    vc =3D gd_vc_find_current(s);
> > > +    vc->gfx.visible =3D false;
> > > +
> > > +    vc =3D gd_vc_find_by_menu(s);
> > >      gtk_release_modifiers(s);
> > >      if (vc) {
> > >          page =3D gtk_notebook_page_num(nb, vc->tab_item);
> > >          gtk_notebook_set_current_page(nb, page);
> > >          gtk_widget_grab_focus(vc->focus);
> > > +        vc->gfx.visible =3D true;
> > >      }
> > >  }
> > >
> > > @@ -1350,6 +1355,7 @@ static gboolean gd_tab_window_close(GtkWidget
> > *widget, GdkEvent *event,
> > >      VirtualConsole *vc =3D opaque;
> > >      GtkDisplayState *s =3D vc->s;
> > >
> > > +    vc->gfx.visible =3D false;
> > >      gtk_widget_set_sensitive(vc->menu_item, true);
> > >      gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
> > >      gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
> > > @@ -1423,6 +1429,7 @@ static void gd_menu_untabify(GtkMenuItem *item,
> > void *opaque)
> > >          gd_update_geometry_hints(vc);
> > >          gd_update_caption(s);
> > >      }
> > > +    vc->gfx.visible =3D true;
> > >  }
> > >
> > >  static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
> > @@
> > > -2471,6 +2478,7 @@ static void gtk_display_init(DisplayState *ds,
> > > DisplayOptions *opts)  #ifdef CONFIG_GTK_CLIPBOARD
> > >      gd_clipboard_init(s);
> > >  #endif /* CONFIG_GTK_CLIPBOARD */
> > > +    vc->gfx.visible =3D true;
> > >  }
> > >
> > >  static void early_gtk_display_init(DisplayOptions *opts)
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

