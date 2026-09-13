Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C6EC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5gH7-0008WP-IT; Sun, 13 Sep 2026 05:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5gH4-0008Vn-Pf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 05:13:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5gH2-0001cE-Pt
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 05:13:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2dd4b3c752fso17055635ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 02:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789290799; cv=none;
 d=google.com; s=arc-20260327;
 b=Io35ma0pWIVu3EutOxuC2+xPf0CjZWKUDJ8db01m7VQa6JMMOACBTegu9afQ0FT6I4
 M7GWyDCiYhe+G2NW/3y6suUzufGNzts+ZqV3GcjNP3fXaY6sg6ZMHXW2fud0rAJZPtSm
 eKvDzh7bDkfaPjpiLeCfaumacH12RAeZrDWCybMCz32is8rQtZVYkja5vwmSyC1GrDzb
 bGWi3P0uQ4ApGf+hE5wwaM5oBnqkpDaa/tJqyEA9EvuC1OSoMwkOqDysKFx+E2P7Z+9q
 4UqMcKeIrX3U1yvv9sxOPnZY8Ol/4wgjdBWu6qqp1K147oKQY0o6HBK2sc4AON52/L0C
 gwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/cD8kH5vtqNP40/4GQSXcPUZePWnYFyoqiyaQU1pz8E=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=qPKstN1GtaOlNFHZCRAXaPNZieXP9wihm/ue/zZXoR083+L/D+sFUU5zp8pcEjC707
 ILsazpG4Howj32vWRscFM8DOi7LzxZjOrWGym+WZKphJEd6S9zrXsvDXkoCrgzsgsXSZ
 DJDAt5S92fDBgPgC4FFqrOuD729PdITotMjDw4SwQN/ywhi0fIUIxkJp1GL7qbg1yRxJ
 6SAKge3NH6S/5csKf/pi2qnIXjp82Muy40PGp7pKjMBqf1VFqGNz5VR9d+sJSJpwVTt5
 PRsAwz4DCscYYUw4dBi7vsOKSbfxULnEyFijDs/YZYLOzCNU0pQVI0RlEYtXYiyhfPFC
 zcrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789290799; x=1789895599; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/cD8kH5vtqNP40/4GQSXcPUZePWnYFyoqiyaQU1pz8E=;
 b=gVgSduHxIXailZ+tvoumbNnNTaeJ+AgtVPyRSayFfDIa7OWKe0lx9uW0aEywuvVspt
 fFS3DLPppIfFyKgfHPpr318vT9542SUN8yu580sSQuPb0S/OmMfKykdfD4ZvS69SEAP8
 JN5ibdFVDF7RSef9v+SMyDRSwwhpcaz5Qgr9L4cpiBjo7yEp8pkHSeT6eZaghtUIXnm4
 fcQasqhyBv2HhTl8IOMfiX81mRKjIDqW/hwQ1mXTKgNhLLc0169li4HTH1+G3hKu1D5X
 Prv/JwbjNCtGdYlScfJgVE2biH1g81L39IfbC/npZCl4DDYDgAjoPrnbFn/Qd/+AjNCW
 94NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789290799; x=1789895599;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/cD8kH5vtqNP40/4GQSXcPUZePWnYFyoqiyaQU1pz8E=;
 b=LWFK6CxCTkjuiH+E5+vuaOMiDNPy4eV1uJYeq2QEr1JTo/BMhupIldGYe8qPMVU99/
 LV3zYwXaQvFGB4RTqWqB7GeCN0cUjWfC9r6sgjJhJYpOaprvcMckpqDaEZeFE8REJeud
 iZ/RwEuydD1p9gY6EHDBxXLjRV/ytuUA13VU36Mo78gRvaUt5BroJ0GJjoBHADpBXf3k
 vuzSp+S7qSzjm4XCP70u39hL2qv8yro1s1/R17tCvQzqm/Mx0m1P2HFXmk2xJkCAEo5s
 TeVV6NLfSIBXryW2VffqiB7tqDypW4ylOi8PtDJ+yySAYKLUeSKDLxrDVws12DBcwfWF
 OiWQ==
X-Gm-Message-State: AFuF++nv+T9wquN2hev93+Lccq/W/LzMq1/2RdkPtww8rQ8uk9Mwtlkw
 NK6SUE4qlCnFuCAQTs51BsF7V7Q5mm/yG+XIfCm2ljwYSRpO0xaQ30W72CKusLx9NIQlrkiGptU
 TuRmhJWRYgkA6AaeaFNOiAFONrGaHk0o=
X-Gm-Gg: AYBFou1Zbp/y6hF4m2QsN/Iw5mOuzg/O64Ac3GPr2+/Sk1ZPqJqDweGm8iTalugUPrR
 SAjGYzq4m6MP0dNCvrJyNpDKEsIss1in1Y+yNKF/lmtXjkqAuIoSBZybA1Z5Te0NuG638wO/Sym
 hUGakQ4kKhVVxEmTvPPtXT6AyfO931NwW51DLHTWagA6eWUQ/Wdvjbna/c3gOyhc/q44AwngPcu
 kqK18/QJUK/Yw6Nq3S1TiVdrkqUlIhFDu3UKY9ea/kVjpF2YKpR5KSJgic84INW4ngskHv2Joke
 ydneCc00Xwzzzmu4+bKwjB65XcBUMwc8qxYC/upVrefnLTtZLCtUBltMqRZhkfZdaHm+/Ccztj0
 U9u4SUXPtUko=
X-Received: by 2002:a17:902:e887:b0:2d9:b60d:7755 with SMTP id
 d9443c01a7336-2dd2a1c3fb1mr225720505ad.1.1789290799213; Sun, 13 Sep 2026
 02:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260729134759.2877-1-dongwon.kim@intel.com>
In-Reply-To: <20260729134759.2877-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 13 Sep 2026 13:13:06 +0400
X-Gm-Features: AcwNN1XOT3H-6kuwjnFiRHLgGmzwp1V3sOHVLABYV0iN9ulBMEZcMmC9LLJD-pQ
Message-ID: <CAJ+F1C+f+uBSrJpE6Z+37MgQyuGUmUJ3b6g5t3P_OGSa-Y9y7w@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Clean up GL resources on tab detach, re-attach,
 and VC free
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 9, 2026 at 3:30=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When a VC is detached into an independent window or re-attached back
> to the main window via gd_tab_window_close(), its underlying EGL surface
> and context are destroyed and recreated.
>
> However, the associated FB objects (guest_fb, win_fb, cursor_fb),
> display surface textures, and shader instances were not being cleaned up
> during these transitions, leading to potential resource leaks.
>
> Introduce a helper function, gd_gl_release_resources(), to make the
> appropriate GL context current, delete the textures and framebuffers,
> release the shader instance, and reset state pointers.
>
> Use this helper in gd_tab_window_close(), gd_menu_untabify(), and refacto=
r
> gd_vc_free() to use it as well.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk.c | 67 +++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 0b5139ef31..c2324d273e 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1490,6 +1490,28 @@ static int gd_vc_notebook_pos(GtkDisplayState *s, =
VirtualConsole *target)
>      g_assert_not_reached();
>  }
>
> +#if defined(CONFIG_OPENGL)
> +static void gd_gl_release_resources(VirtualConsole *vc)
> +{
> +    if (vc->gfx.ectx) {
> +        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                       vc->gfx.esurface, vc->gfx.ectx);
> +    } else if (gtk_use_gl_area) {
> +        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> +    }
> +
> +    if (vc->gfx.gls) {
> +        surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
> +        qemu_gl_fini_shader(vc->gfx.gls);
> +        vc->gfx.gls =3D NULL;
> +    }
> +
> +    egl_fb_destroy(&vc->gfx.guest_fb);
> +    egl_fb_destroy(&vc->gfx.win_fb);
> +    egl_fb_destroy(&vc->gfx.cursor_fb);
> +}
> +#endif
> +
>  static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
>                                      void *opaque)
>  {
> @@ -1506,13 +1528,17 @@ static gboolean gd_tab_window_close(GtkWidget *wi=
dget, GdkEvent *event,
>      gtk_widget_destroy(vc->window);
>      vc->window =3D NULL;
>  #if defined(CONFIG_OPENGL)
> -    if (vc->gfx.esurface) {
> -        eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
> -        vc->gfx.esurface =3D NULL;
> -    }
> -    if (vc->gfx.ectx) {
> -        eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
> -        vc->gfx.ectx =3D NULL;
> +    if (vc->type =3D=3D GD_VC_GFX) {
> +        gd_gl_release_resources(vc);
> +
> +        if (vc->gfx.esurface) {
> +            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
> +            vc->gfx.esurface =3D NULL;
> +        }
> +        if (vc->gfx.ectx) {
> +            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
> +            vc->gfx.ectx =3D NULL;
> +        }
>      }
>  #endif
>
> @@ -1549,12 +1575,9 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>
>      if (vc->type =3D=3D GD_VC_GFX &&
>          qemu_console_is_graphic(vc->gfx.dcl.con)) {
> -        gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item)=
,
> -                                       FALSE);
> -    }
> -    if (!vc->window) {
> -        vc->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
>  #if defined(CONFIG_OPENGL)
> +        gd_gl_release_resources(vc);
> +
>          if (vc->gfx.esurface) {
>              eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
>              vc->gfx.esurface =3D NULL;
> @@ -1564,6 +1587,11 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>              vc->gfx.ectx =3D NULL;
>          }
>  #endif
> +        gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item)=
,
> +                                       FALSE);
> +    }
> +    if (!vc->window) {
> +        vc->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
>          gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
>
>          g_signal_connect(vc->window, "delete-event",
> @@ -2696,19 +2724,8 @@ static void gd_vc_free(void *p)
>          if (display_opengl) {
>              qemu_console_set_display_gl_ctx(vc->gfx.dcl.con, NULL);
>          }
> -        if (vc->gfx.ectx) {
> -            eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> -                           vc->gfx.esurface, vc->gfx.ectx);
> -        } else if (gtk_use_gl_area) {
> -            gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> -        }
> -        if (vc->gfx.gls) {
> -            surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
> -            qemu_gl_fini_shader(vc->gfx.gls);
> -        }
> -        egl_fb_destroy(&vc->gfx.guest_fb);
> -        egl_fb_destroy(&vc->gfx.win_fb);
> -        egl_fb_destroy(&vc->gfx.cursor_fb);
> +        gd_gl_release_resources(vc);
> +
>          if (vc->gfx.esurface) {
>              eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
>          }
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

