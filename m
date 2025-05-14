Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 02:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF1bV-0003iS-4u; Tue, 13 May 2025 22:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uF1bU-0003iG-8d
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:12:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uF1bS-0006Oc-FI
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:12:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso399937b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 19:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747188732; x=1747793532; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kZvarWixJcVphn00xCn2gg5zamtkHpUp8ymohw2eDjQ=;
 b=Op6JZAcLu+K2Z7wunCHrGBDZXMVWbLtDBprgXFiHSvbgPZTTga48JsHhv+qGi1MVBk
 JiCtgP1T5rk68/M4IZ64ph0ZZU5yWPzrGOtJYwWLysAYT8GWk5KUH16hIOJnUugjhSLy
 fnrmbSdyyaGJSeKy9G//bW12y+BDgdp2LoDAGY8ZqXXsWQYRMpNMBhzHE42qy5Rxi84x
 J9IbT9fEWO93omb84eTvuWdK31uS1AsPQlZ84/MYjFmsbHVuxhk3QHb8YFKtur5ogb4G
 WgBOZsB/EwKog9PGuqUH+JCwV395oQaOXCz5rIIiK1K7CoURres1WMRrytHCwmhTpMBo
 cKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747188732; x=1747793532;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZvarWixJcVphn00xCn2gg5zamtkHpUp8ymohw2eDjQ=;
 b=QF1hEcYBOVRimB9DNzcByPkRzhzKuEY3OALeeKSJNdjllK53L/k+d/eUW3Ex5d8XU7
 XuWCleVlDWcs7xyqqaetRSQ4ccbrkBZ0hQ1AEcmGIk5dY8JVP5PgBu6kzfkamz1fWOdU
 PvIcQ+ro/kh2qW0nmESLwO3FQow6xqxeri9PZ9L+szNDF6ypD0sN1k901/JqjGL5d+k6
 4/KKFUuEni/Mz7g3lI8t2ffRj898PScSuzql3Y/KQNSE5Igm4YujCCwc3Ox63WbDd1ts
 45YMtdhsrVjs8UOTikEnJUVJ45vVAOaLRijh1Kd606NWeCZZKW31dlr1cC7SRM+3N8rK
 AhnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViN8S8xl4oy88hDjxf4s4O7+LtFjcsAbHPFas56rb3g05oINXNDSdLG1ZTIuw2c2Ksi1nWBpXFJ/n9@nongnu.org
X-Gm-Message-State: AOJu0YyK6S+qF/slZTkxFy1fwDf804+R2mkJAQh3eUULLdg9pjYs6hnB
 rHMvBfoYgt/vdJqoyR5y2Xwcur/1fvHzTtFlwgdfni9cVH35XnQ9
X-Gm-Gg: ASbGncvNlboF7peD89tgEpvXiOU/UN+nLOQkXi0+hunXdp9vfhSnYH0oRtw7Mm+MRUM
 h8Oj8EEqo0+apFagJh7b5bN7JuXLxYbfsQQXV7uxQ/KXlhvkGi1B6J+gKmjyeLdPU3qEFRRuHSW
 vsrWGFCrHkp9UVzS2OrR5Mu6FjJyVP09O9F0xQrcuTGx+h7eHS+/39QT5wNyJ8k35YmC+AiGGz5
 bYKzuccqfGu2O6fkQriCM8TeXQAt7IGRy0wdu25Xb7GLcJBOE1eBru5bjHTJUHZEp8RYvqWCRW6
 aFv84Ire21EDJqsiwE3OFhHHNBtetv3pXckBl7T2WLZNzrVV2pXkz2jm0KQfMkcY
X-Google-Smtp-Source: AGHT+IH+ifpy+IOIsnkqRapYP1uGmMvQxbLd2CHtZA4AGqqap0W/9DFClZAXtBIQ16jF0cwRA1AVkQ==
X-Received: by 2002:a05:6a00:3ccc:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-74278fc018emr8933047b3a.5.1747188732334; 
 Tue, 13 May 2025 19:12:12 -0700 (PDT)
Received: from [192.168.31.160] ([117.143.176.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a97dc4sm8614681b3a.179.2025.05.13.19.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 19:12:11 -0700 (PDT)
Message-ID: <3634faaeff9d0491e6d39042a285bc8877863a44.camel@gmail.com>
Subject: Re: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Date: Wed, 14 May 2025 10:12:07 +0800
In-Reply-To: <PH8PR11MB6879321E34D2905C47F42371FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-4-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
 <PH8PR11MB6879321E34D2905C47F42371FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42b.google.com
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

On Tue, 2025-05-13 at 20:01 +0000, Kim, Dongwon wrote:
> > Hi Dongwon,
>=20
> > On Tue, 2025-05-13 at 01:26 +0000, Kim, Dongwon wrote:
> > > Hi,
> > >=20
> > > > Subject: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
> > > >=20
> > > > The code snippet updating scale_x/scale_y is general and will be
> > > > used in next
> > > > patch. Make it a function.
> > > >=20
> > > > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > > > ---
> > > > =C2=A0include/ui/gtk.h |  2 ++
> > > > =C2=A0ui/gtk.c         | 30 +++++++++++++++++++-----------
> > > > =C2=A02 files changed, 21 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> > > > aa3d637029..d3944046db 100644
> > > > --- a/include/ui/gtk.h
> > > > +++ b/include/ui/gtk.h
> > > > @@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
> > > > =C2=A0/* gtk-clipboard.c */
> > > > =C2=A0void gd_clipboard_init(GtkDisplayState *gd);
> > > >=20
> > > > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > > > int
> > > > +fbh);
> > > > +
> > > > =C2=A0#endif /* UI_GTK_H */
> > > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > > index 8f5bb4b62e..47af49e387 100644
> > > > --- a/ui/gtk.c
> > > > +++ b/ui/gtk.c
> > > > @@ -801,6 +801,24 @@ void
> > > > gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
> > > > *widget)
> > > > #endif  }
> > > >=20
> > > > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > > > int
> > > > +fbh) {
> > > > +    if (!vc) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (vc->s->full_screen) {
> > > > +        vc->gfx.scale_x =3D (double)ww / fbw;
> > > > +        vc->gfx.scale_y =3D (double)wh / fbh;
> > > > +    } else if (vc->s->free_scale) {
> > > > +        double sx, sy;
> > > > +
> > > > +        sx =3D (double)ww / fbw;
> > > > +        sy =3D (double)wh / fbh;
> > > > +
> > > > +        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
> > >=20
> > > I assume you are trying to keep the w/h ratio same here in case free-
> > > scale =3D=3D true.
> > > Why would we do that? We can easily stretch the host window to any
> > > direction then the scale-x and scale-y
> > > could be different any time.
> > >=20
> > Currently, the code doesn't clarify how we should handle aspect ratios.
> > However, I noticed that in the gd_draw_event function, when free-
> > scale=3Dtrue, it preserves a fixed aspect ratio. I believe this is a
> > reasonable approach (in my humble opinion, it's unlikely that people
> > want to see distorted images), so I've decided to retain this behavior
> > for now and align other parts to follow the same logic, ensuring a
> > consistent experience for users.
>=20
> Yeah, I didn't realize it does keep the ratio in case of gl=3Doff in the =
original code.
> The reason I brought up this is because as you may Have noticed, scale_x =
and scale_y
> have been individually configured based on width and height of the curren=
t window
> and guest surface in gtk-egl and gtk-gl-area, which is being changed with=
 your patches.
> I am not sure which one is the best either but this would definitely requ=
ire some discussion.
>=20

IMO, neither preserving nor ignoring the aspect ratio is objectively
=E2=80=9Cbetter=E2=80=9D =E2=80=94 both have its own supporters. I suggest =
we start by defining
a reasonable default and making all implementations conform to it (even
if it means changing the behaviors of a few backends). Once that=E2=80=99s =
in
place, I=E2=80=99ll add an option like "keep-aspect" or similar (per my
discussion with Balaton in the other thread) so users can select the
behavior they prefer. Does that sound acceptable?

> > Best regards,
> > Weifeng
>=20
> > > > +    }
> > > > +}
> > > > =C2=A0/**
> > > > =C2=A0=C2=A0* DOC: Coordinate handling.
> > > > =C2=A0=C2=A0*
> > > > @@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget
> > > > *widget,
> > > > cairo_t *cr, void *opaque)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ww_widget =3D
> > > > gdk_window_get_width(gtk_widget_get_window(widget));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wh_widget =3D
> > > > gdk_window_get_height(gtk_widget_get_window(widget));
> > > >=20
> > > > -    if (s->full_screen) {
> > > > -        vc->gfx.scale_x =3D (double)ww_widget / fbw;
> > > > -        vc->gfx.scale_y =3D (double)wh_widget / fbh;
> > > > -    } else if (s->free_scale) {
> > > > -        double sx, sy;
> > > > -
> > > > -        sx =3D (double)ww_widget / fbw;
> > > > -        sy =3D (double)wh_widget / fbh;
> > > > -
> > > > -        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
> > > > -    }
> > > > +    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ww_surface =3D fbw * vc->gfx.scale_x;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wh_surface =3D fbh * vc->gfx.scale_y;
> > > > --
> > > > 2.49.0
> > > >=20

