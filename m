Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A597FC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV4mh-0004XN-KJ; Wed, 31 Jan 2024 02:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rV4mX-0004RO-Gk
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:13:17 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rV4mU-0004s7-Nl
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:13:12 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a9f4935a6so4742611cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 23:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706685189; x=1707289989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qX/ouYGIanFoVN5c4hQ+DriYI2uuSYLP1IPJJSmT3yc=;
 b=Ipw2XOb8X0N4OmiAaPU2E+vaUojQWWtMuHk7wxPoR19QIS0/ESklXjYmKxMu76zi5B
 UQihqs5GYKnTdBd4SHyKsA0rQa8db1kDjWGtfKHlEzn4Lr1T6+2/tvTYDPDUCi6+SrZ2
 2nsoFONs7szqztyW0Vgi+n1C8BCKUR2YI5jGxWkgJBdshS7hfG2qtjM796HnDmEe95Uh
 dz5mrxDlJpq1Ctz5qA1QQyqOsXoA6CJI/jHdCYegXVl/dCJjDrE02DHTH8j2IYNS0ygu
 EKqHnHM9NMIBTW4uaizmVK9t+HK2RFxnR0E2byfvS4lTJWJBtESXvkneORtDX4blVjSA
 00rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706685189; x=1707289989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qX/ouYGIanFoVN5c4hQ+DriYI2uuSYLP1IPJJSmT3yc=;
 b=L6VvQDvRlVMf6uAV+KPlW5clPA/st1DdGUZmEk0TP8sjvK71m1tk2jpzhtdYfy6P0B
 rIDpJhVd+Bn3OLSoACFNROqiK7kJBEVjvSmbZY+eLlQSpgPb7tuWxNiZylFoKceLDC/U
 Xl/gdZ68PO8tXGt6/mlf3jh9albMB0YzbbTnQU0gnmSvqxco8Aby+H/Gprv81CTzdq6i
 CnzaoWdivU2l9Zb3F75WtuIw+PxFI7iL44JvNYXxmQtF3nDKp3XCkkZqUxCBLE7agnyh
 oE8cBeU8gsIN3GAHGDp1g8i5JSQGYQQu0eX/EeGO25sHryjgx2vtFEL2ayemJwBtRnYy
 Qhlw==
X-Gm-Message-State: AOJu0Yx8xElhS8K7IYMtXFC+pQ2JZkZe5FQi5TylT0b5xfderUDlECDQ
 44yOMSpW7fZbwyavrtPb8u5kS4OEAjuvVDAegD9eNbpssNJW6ThTh0RzXntGMHl61ZtAkHUsSn6
 Lud8kNBHhrcMCbIQocHPZfg1vG2U=
X-Google-Smtp-Source: AGHT+IGS/s36iEpp23cyCmH0pRs6ruCDDo4MboP7SFPTFed4gioxfTpBIj9v77usL5mcmNIxncF2lc4qjU+mzv8eTU4=
X-Received: by 2002:ac8:5bc1:0:b0:42a:75dc:6eca with SMTP id
 b1-20020ac85bc1000000b0042a75dc6ecamr3983904qtb.44.1706685188859; Tue, 30 Jan
 2024 23:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-3-dongwon.kim@intel.com>
In-Reply-To: <20240130234840.53122-3-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jan 2024 11:12:57 +0400
Message-ID: <CAJ+F1CKH6oWkvN44de_FT0hG5vKd8pKapn62OM+DfmQggnDcHg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ui/gtk: set the ui size to 0 when invisible
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Wed, Jan 31, 2024 at 3:50=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> UI size is set to 0 when the VC is invisible, which will prevent
> the further scanout update by notifying the guest that the display
> is not in active state. Then it is restored to the original size
> whenever the VC becomes visible again.

This can have unwanted results on multi monitor setups, such as moving
windows or icons around on different monitors.

Switching tabs or minimizing the display window shouldn't cause a
guest display reconfiguration.

What is the benefit of disabling the monitor here? Is it for
performance reasons?

>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 02eb667d8a..651ed3492f 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1314,10 +1314,12 @@ static void gd_menu_switch_vc(GtkMenuItem *item, =
void *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc;
>      GtkNotebook *nb =3D GTK_NOTEBOOK(s->notebook);
> +    GdkWindow *window;
>      gint page;
>
>      vc =3D gd_vc_find_current(s);
>      vc->gfx.visible =3D false;
> +    gd_set_ui_size(vc, 0, 0);
>
>      vc =3D gd_vc_find_by_menu(s);
>      gtk_release_modifiers(s);
> @@ -1325,6 +1327,9 @@ static void gd_menu_switch_vc(GtkMenuItem *item, vo=
id *opaque)
>          page =3D gtk_notebook_page_num(nb, vc->tab_item);
>          gtk_notebook_set_current_page(nb, page);
>          gtk_widget_grab_focus(vc->focus);
> +        window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> +        gd_set_ui_size(vc, gdk_window_get_width(window),
> +                       gdk_window_get_height(window));
>          vc->gfx.visible =3D true;
>      }
>  }
> @@ -1356,6 +1361,7 @@ static gboolean gd_tab_window_close(GtkWidget *widg=
et, GdkEvent *event,
>      GtkDisplayState *s =3D vc->s;
>
>      vc->gfx.visible =3D false;
> +    gd_set_ui_size(vc, 0, 0);
>      gtk_widget_set_sensitive(vc->menu_item, true);
>      gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
>      gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
> @@ -1391,6 +1397,7 @@ static gboolean gd_win_grab(void *opaque)
>  static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> +    GdkWindow *window;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
>      if (vc->type =3D=3D GD_VC_GFX &&
> @@ -1429,6 +1436,10 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>          gd_update_geometry_hints(vc);
>          gd_update_caption(s);
>      }
> +
> +    window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> +    gd_set_ui_size(vc, gdk_window_get_width(window),
> +                   gdk_window_get_height(window));
>      vc->gfx.visible =3D true;
>  }
>
> @@ -1753,7 +1764,9 @@ static gboolean gd_configure(GtkWidget *widget,
>  {
>      VirtualConsole *vc =3D opaque;
>
> -    gd_set_ui_size(vc, cfg->width, cfg->height);
> +    if (vc->gfx.visible) {
> +        gd_set_ui_size(vc, cfg->width, cfg->height);
> +    }
>      return FALSE;
>  }
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

