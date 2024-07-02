Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C60C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 06:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOXBC-00063b-Ls; Tue, 02 Jul 2024 02:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOXBA-00063S-Oj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 02:39:52 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOXB9-0004kF-1f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 02:39:52 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4466327f401so11899361cf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719902390; x=1720507190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqkXcRHbXbAV/c0smhkzvGP9LsIHccBY/ry36e/xXDQ=;
 b=Bx3MCvP17GGJLkYG2/2ekJYmvPgoAXEvamhkIkcZjFJVmbjCVr7qDYxkFZtPH7rCaZ
 tvvl1KE0b8Jtvp4GXhWDpCsmxUjj7Ac5RvAGlwW8kjvlHXu0IhLs62LF3b+CKolx3jVl
 ellmi/Gb7TPUS2FB0EdWA6lJxAOLSKznr1IGP37m4v1zHXeL6VzJABCU5k4ElmgI1c9W
 ew2lVvIp6k0aLg+BeIYAv8qlvBIURd5BVdxEIBPUDV6obRFCLfS1vMUWeG9hhRn+wkyl
 R7wA1IrJt0jSUABVKbutZ128uw2uNgxZ1MKCUBJaK6zMmb6oYtihTGS41CfEAM1TPMuv
 Dygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719902390; x=1720507190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqkXcRHbXbAV/c0smhkzvGP9LsIHccBY/ry36e/xXDQ=;
 b=w+nkW2q4A0VXHu0jQitb4Cjc8X8KmukSkkUhyHxYCJ7Xfcdtp0G8/QFIvLxOAxj1LK
 4vev4W81T0r+b2+pARb8bxq3pvLruiBTDQsvARveqUvikXU3ZDlzuKzvD467TT8Y3hd7
 oRUn6GcGxaE0wxx6SDMJjp58Q0EUERjMWqQssc4lR27cgHjpmM6KsQH6fiA8bEwdk3QW
 N/ArQrMezs4CpxbYjWYatg+lyuq/JcKUyu+LZShpXvUpw6f11oCvy4GottPPj1YcdlEC
 b7SkVUw+GfqrenOsZUddWGa5opqTuygt/ll1bNI56MkztIIYRbBWNhj17epvuo6HUDFD
 r41A==
X-Gm-Message-State: AOJu0YxTc3OCCZvuQG3EQpN4McZyrKyAPWJdo2WgQLPG8lxOfbAgfRHW
 zYkkGc8+IEOFLgZQ4Wwoezk6wvZrAU36xEQj4LC5WCFfXac+R+mhza/01+8BCK6P9edhArMsDoS
 ZMWRusiY2DRQrLq6Anffi3YEqDCc=
X-Google-Smtp-Source: AGHT+IEC+0OX3mmOaLjYSDVqv+cfoX/aTvB4dYwRSyPntzYsaapdJHf5F9mNh+IzEOGgDAjp41iDJOGKQM03nEaKplU=
X-Received: by 2002:a05:622a:14a:b0:446:5c05:ebee with SMTP id
 d75a77b69052e-44662c99a48mr84173561cf.11.1719902389823; Mon, 01 Jul 2024
 23:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240702000715.2624292-1-dongwon.kim@intel.com>
In-Reply-To: <20240702000715.2624292-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 10:39:37 +0400
Message-ID: <CAJ+F1CK+EfJ2gjfjPPVbHCPHMNL-obDUBa1p23t=7jCMNRjEXA@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Attach fullscreen toggling cb to all detached VCs
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fe74ca061c3dfa3f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

--000000000000fe74ca061c3dfa3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 2, 2024 at 4:09=E2=80=AFAM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Enable hotkey for toggling window fullscreening for all individual
> untabified VCs
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(/rant I wish we had more common code with gd_menu_full_screen.. and
overall cleaner..)


---
>  ui/gtk.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 93b13b7a30..768e66bec4 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1396,6 +1396,34 @@ static gboolean gd_win_grab(void *opaque)
>      return TRUE;
>  }
>
> +static void gd_vc_fullscreen_toggle(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +    GdkWindow *window;
> +    GdkWindowState state;
> +
> +    if (!vc->window)
> +        return;
> +
> +    window =3D gtk_widget_get_window(vc->window);
> +    state =3D gdk_window_get_state(window);
> +
> +    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
> +        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
> +
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            vc->gfx.scale_x =3D 1.0;
> +            vc->gfx.scale_y =3D 1.0;
> +            gd_update_windowsize(vc);
> +        }
> +    } else {
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
> +        }
> +        gtk_window_fullscreen(GTK_WINDOW(vc->window));
> +    }
> +}
> +
>  static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> @@ -1428,10 +1456,13 @@ static void gd_menu_untabify(GtkMenuItem *item,
> void *opaque)
>          if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
>              GtkAccelGroup *ag =3D gtk_accel_group_new();
>              gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
> -
> -            GClosure *cb =3D g_cclosure_new_swap(G_CALLBACK(gd_win_grab)=
,
> -                                               vc, NULL);
> -            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
> cb);
> +            GClosure *cb_grab =3D
> g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
> +                                                    vc, NULL);
> +            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
> cb_grab);
> +            GClosure *cb_fs =3D g_cclosure_new_swap(
> +
>  G_CALLBACK(gd_vc_fullscreen_toggle),
> +                                             vc, NULL);
> +            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0,
> cb_fs);
>          }
>
>          gd_update_geometry_hints(vc);
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fe74ca061c3dfa3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 4:09=E2=80=
=AFAM &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blan=
k">dongwon.kim@intel.com</a>&gt;<br>
<br>
Enable hotkey for toggling window fullscreening for all individual<br>
untabified VCs<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><div>=C2=A0</div><div>(/rant I wish we had more common code with gd_menu_=
full_screen.. and overall cleaner..)</div><div><br></div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/gtk.c | 39 +++++++++++++++++++++++++++++++++++----<br>
=C2=A01 file changed, 35 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index 93b13b7a30..768e66bec4 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1396,6 +1396,34 @@ static gboolean gd_win_grab(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0return TRUE;<br>
=C2=A0}<br>
<br>
+static void gd_vc_fullscreen_toggle(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 VirtualConsole *vc =3D opaque;<br>
+=C2=A0 =C2=A0 GdkWindow *window;<br>
+=C2=A0 =C2=A0 GdkWindowState state;<br>
+<br>
+=C2=A0 =C2=A0 if (!vc-&gt;window)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+<br>
+=C2=A0 =C2=A0 window =3D gtk_widget_get_window(vc-&gt;window);<br>
+=C2=A0 =C2=A0 state =3D gdk_window_get_state(window);<br>
+<br>
+=C2=A0 =C2=A0 if (state &amp; GDK_WINDOW_STATE_FULLSCREEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_window_unfullscreen(GTK_WINDOW(vc-&gt;wind=
ow));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vc-&gt;type =3D=3D GD_VC_GFX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;gfx.scale_x =3D 1.0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;gfx.scale_y =3D 1.0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gd_update_windowsize(vc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vc-&gt;type =3D=3D GD_VC_GFX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_widget_set_size_request(vc-&=
gt;gfx.drawing_area, -1, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_window_fullscreen(GTK_WINDOW(vc-&gt;window=
));<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static void gd_menu_untabify(GtkMenuItem *item, void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GtkDisplayState *s =3D opaque;<br>
@@ -1428,10 +1456,13 @@ static void gd_menu_untabify(GtkMenuItem *item, voi=
d *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qemu_console_is_graphic(vc-&gt;gfx.dc=
l.con)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GtkAccelGroup *ag =3D gtk_a=
ccel_group_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_window_add_accel_group(=
GTK_WINDOW(vc-&gt;window), ag);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GClosure *cb =3D g_cclosure_new_=
swap(G_CALLBACK(gd_win_grab),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0vc, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_accel_group_connect(ag, GDK_=
KEY_g, HOTKEY_MODIFIERS, 0, cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GClosure *cb_grab =3D g_cclosure=
_new_swap(G_CALLBACK(gd_win_grab),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_accel_group_connect(ag, GDK_=
KEY_g, HOTKEY_MODIFIERS, 0, cb_grab);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GClosure *cb_fs =3D g_cclosure_n=
ew_swap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0G_CALLBACK(gd_vc_fullscreen_toggle),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0vc, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_accel_group_connect(ag, GDK_=
KEY_f, HOTKEY_MODIFIERS, 0, cb_fs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gd_update_geometry_hints(vc);<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000fe74ca061c3dfa3f--

