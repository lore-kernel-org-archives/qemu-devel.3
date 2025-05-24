Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F76C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 14:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIqK7-00018J-Jd; Sat, 24 May 2025 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIqK4-00017i-FQ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIqK2-0000ra-2T
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748098681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4E1ZvnP686yfPCWGBT9jfRwrth/FrJnN3MjfxYwNaE=;
 b=h3R5qgk6uBRD6I/HoRLMiMlcSw/sqc25zdjSqooaGpZN2eSkgF9rCqS9LNasJGLiLNl+OE
 qOSnX7gco1hS5+FkjFivBx+E4RqR2+fU0J1fXitQgOyCoaxnfSQDy5nnhIMfJix+B/9hoP
 9Zf42HGkjNmpHDM4gwVYGc9LMDBmRfY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-aBQZkhOBPVO4SHbgdsSmPQ-1; Sat, 24 May 2025 10:57:59 -0400
X-MC-Unique: aBQZkhOBPVO4SHbgdsSmPQ-1
X-Mimecast-MFC-AGG-ID: aBQZkhOBPVO4SHbgdsSmPQ_1748098679
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4766c80d57eso13960691cf.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 07:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748098679; x=1748703479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4E1ZvnP686yfPCWGBT9jfRwrth/FrJnN3MjfxYwNaE=;
 b=FIaSNhZ6kDPuiB+TCK0elFzIdxHd4TfKGcohi1oA+rab54Z0kKY9h2+b7T7mzWO9GD
 qXkP+QiockZWveBCCG+fo9RcaX24PFHzeYzOiW+uiqWtpS/Eqq1+h60ZchOaO8OY/UeF
 bwsLutoathvAoCJMYAJFcbn4UIAqWXXOXop6oO0uCo8YpGaKLGZDBqKLGg641KrQNeSo
 1Gzk/BIwZuWMMRdISg9lRmxotpgRWPf7DeHeow8fnAkaWS7qsx/JqWaX1pH1I2nlu1Cy
 UNZVfXGlGbASawrNmPcKrJ6x4zQDB947fS6g4Wq+lsjj9KfiWuqlSPhInxeeSYd/CMJO
 elfg==
X-Gm-Message-State: AOJu0YxHAYq8N+PqDMyHbvCuCOe0lWhNmhMgNlA7D6Pfo+r9Iv5Qlxl4
 l4tr1e4PvhhTnbJx0Sqo0D8ewioKbBFtZd21Y81QzYf+KQNiYrilslxkbbu5Gic1hQH68WZhiNP
 EqV6fwTwXnHEdMvseKETWlscf75tHmoUefvtVzRofMYNW+op5+N3n89PX5uMvtXtwomec5EGytd
 qVP4+oDdnBWlYoJIzy3vBgd8YWETCOS5w=
X-Gm-Gg: ASbGncuMSpRYel3wGPWtSwjawgOLwitDpsI3XLM+l+5X1iSJ8eFX0uq5eB8RCX/JB0/
 m78KdlP2HEfE1aZLZ5lgzG68kqQej+JAx0pYgAzZN74sXufbcOjJPUli3yrDJun82JWTd2Am5VA
 uu1/VKy6+zIBj9pfw6Qc4DF1xgUA==
X-Received: by 2002:a05:622a:4ccc:b0:494:9fca:8f8f with SMTP id
 d75a77b69052e-49f464571edmr49097591cf.3.1748098678691; 
 Sat, 24 May 2025 07:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbhKY7MLcXhYlbbwZA/6wCzTpuwgriX+XLEC3nXlx+rO+wcnH52om6zMkn/LmoncLtGLDcQkhQ5Y7F6Ix1Aus=
X-Received: by 2002:a05:622a:4ccc:b0:494:9fca:8f8f with SMTP id
 d75a77b69052e-49f464571edmr49097281cf.3.1748098678245; Sat, 24 May 2025
 07:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-5-vivek.kasireddy@intel.com>
In-Reply-To: <20250515024734.758335-5-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 24 May 2025 16:57:47 +0200
X-Gm-Features: AX0GCFtsx1onKxDN8rIdKYAl9DczZ_9eu0qVySzZsoATc_khVa6QxtC3oOnBcs4
Message-ID: <CAMxuvazk2UMmneKa3=WSyXpqj+GOzFLzSFJ-stb8X4qN=0p3NQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] ui/spice: Add an option to submit gl_draw requests
 at fixed rate
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: multipart/alternative; boundary="000000000000bfe17f0635e2f010"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000bfe17f0635e2f010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 15, 2025 at 4:49=E2=80=AFAM Vivek Kasireddy <vivek.kasireddy@in=
tel.com>
wrote:

> In the specific case where the display layer (virtio-gpu) is using
> dmabuf, and if remote clients are enabled (-spice gl=3Don,port=3Dxxxx),
> it makes sense to limit the maximum (streaming) rate (refresh rate)
> to a fixed value using the GUI refresh timer. Otherwise, the updates
> or gl_draw requests would be sent as soon as the Guest submits a new
> frame which is not optimal as it would lead to increased network
> traffic and wastage of GPU cycles if the frames get dropped.
>

> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  include/ui/spice-display.h |  1 +
>  qemu-options.hx            |  5 ++++
>  ui/spice-core.c            | 11 ++++++++
>  ui/spice-display.c         | 54 +++++++++++++++++++++++++++++++-------
>  4 files changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
> index f4922dd74b..2fe524b59c 100644
> --- a/include/ui/spice-display.h
> +++ b/include/ui/spice-display.h
> @@ -152,6 +152,7 @@ struct SimpleSpiceCursor {
>
>  extern bool spice_opengl;
>  extern bool remote_client;
> +extern int max_refresh_rate;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r);
>  void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 97c63d9b31..4e9f4edfdc 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2282,6 +2282,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
>      "       [,disable-agent-file-xfer=3Don|off][,agent-mouse=3D[on|off]]=
\n"
>      "
>  [,playback-compression=3D[on|off]][,seamless-migration=3D[on|off]]\n"
>      "       [,video-codecs=3D<encoder>:<codec>\n"
> +    "       [,max-refresh-rate=3Drate\n"
>      "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
>      "                enable spice\n"
>      "                at least one of {port, tls-port} is mandatory\n",
> @@ -2374,6 +2375,10 @@ SRST
>          Provide the preferred codec the Spice server should use.
>          Default would be spice:mjpeg.
>
> +    ``max-refresh-rate=3Drate``
> +        Provide the maximum refresh rate (or FPS) at which the encoding
> +        requests should be sent to the Spice server. Default would be 30=
.
> +
>      ``gl=3D[on|off]``
>          Enable/disable OpenGL context. Default is off.
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 6c3bfe1d0f..d8925207b1 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -56,6 +56,8 @@ struct SpiceTimer {
>      QEMUTimer *timer;
>  };
>
> +#define MAX_REFRESH_RATE 30
> +
>  static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
>  {
>      SpiceTimer *timer;
> @@ -491,6 +493,9 @@ static QemuOptsList qemu_spice_opts =3D {
>          },{
>              .name =3D "video-codecs",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "max-refresh-rate",
> +            .type =3D QEMU_OPT_NUMBER,
>          },{
>              .name =3D "agent-mouse",
>              .type =3D QEMU_OPT_BOOL,
> @@ -813,6 +818,12 @@ static void qemu_spice_init(void)
>          }
>      }
>
> +    max_refresh_rate =3D qemu_opt_get_number(opts, "max-refresh-rate",
> MAX_REFRESH_RATE);
> +    if (max_refresh_rate < 0) {
> +        error_report("max refresh rate/fps is invalid");
> +        exit(1);
> +    }
> +
>      spice_server_set_agent_mouse
>          (spice_server, qemu_opt_get_bool(opts, "agent-mouse", 1));
>      spice_server_set_playback_compression
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 9140169015..ed91521ac2 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -32,6 +32,7 @@
>
>  bool spice_opengl;
>  bool remote_client;
> +int max_refresh_rate;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r)
>  {
> @@ -844,12 +845,32 @@ static void qemu_spice_gl_block_timer(void *opaque)
>      warn_report("spice: no gl-draw-done within one second");
>  }
>
> +static void spice_gl_draw(SimpleSpiceDisplay *ssd,
> +                           uint32_t x, uint32_t y, uint32_t w, uint32_t =
h)
> +{
> +    uint64_t cookie;
> +
> +    cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0=
);
> +    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
> +}
> +
>  static void spice_gl_refresh(DisplayChangeListener *dcl)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> -    uint64_t cookie;
>
> -    if (!ssd->ds || qemu_console_is_gl_blocked(ssd->dcl.con)) {
> +    if (!ssd->ds) {
> +        return;
> +    }
> +
> +    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
> +        if (remote_client && ssd->gl_updates && ssd->have_scanout) {
> +            glFlush();
> +            spice_gl_draw(ssd, 0, 0,
> +                          surface_width(ssd->ds),
> surface_height(ssd->ds));
> +            ssd->gl_updates =3D 0;
> +            /* To update at 60 FPS, update_interval needs to be ~16.66 m=
s
> */
> +            dcl->update_interval =3D 1000 / max_refresh_rate;
> +        }
>          return;
>      }
>
> @@ -857,11 +878,8 @@ static void spice_gl_refresh(DisplayChangeListener
> *dcl)
>      if (ssd->gl_updates && ssd->have_surface) {
>          qemu_spice_gl_block(ssd, true);
>          glFlush();
> -        cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DON=
E,
> 0);
> -        spice_qxl_gl_draw_async(&ssd->qxl, 0, 0,
> -                                surface_width(ssd->ds),
> -                                surface_height(ssd->ds),
> -                                cookie);
> +        spice_gl_draw(ssd, 0, 0,
> +                      surface_width(ssd->ds), surface_height(ssd->ds));
>          ssd->gl_updates =3D 0;
>      }
>  }
> @@ -954,6 +972,20 @@ static void
> qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>
>      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> +
> +    /*
> +     * We need to check for the case of "lost" updates, where a gl_draw
> +     * was not submitted because the timer did not get a chance to run.
> +     * One case where this happens is when the Guest VM is getting
> +     * rebooted. If the console is blocked in this situation, we need
> +     * to unblock it. Otherwise, newer updates would not take effect.
> +     */
> +    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
> +        if (remote_client && ssd->gl_updates && ssd->have_scanout) {
> +            ssd->gl_updates =3D 0;
> +            qemu_spice_gl_block(ssd, false);
> +        }
> +    }
>      spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0,
> DRM_FORMAT_INVALID,
>                              DRM_FORMAT_MOD_INVALID, false);
>      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
> @@ -1061,7 +1093,6 @@ static void
> qemu_spice_gl_update(DisplayChangeListener *dcl,
>      EGLint fourcc =3D 0;
>      bool render_cursor =3D false;
>      bool y_0_top =3D false; /* FIXME */
> -    uint64_t cookie;
>      uint32_t width, height, texture;
>
>      if (!ssd->have_scanout) {
> @@ -1159,8 +1190,11 @@ static void
> qemu_spice_gl_update(DisplayChangeListener *dcl,
>      trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
>      qemu_spice_gl_block(ssd, true);
>      glFlush();
> -    cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0=
);
> -    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
> +    if (remote_client) {
> +        ssd->gl_updates++;
> +    } else {
> +        spice_gl_draw(ssd, x, y, w, h);
> +    }
>

I think this is not the right place to handle the remote vs local case. It
should be done at the spice server level, since the server can serve
various sockets / connections (not just the one it listens to, but the one
it has been given).


>  }
>
>  static const DisplayChangeListenerOps display_listener_gl_ops =3D {
> --
> 2.49.0
>
>

--000000000000bfe17f0635e2f010
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 15, 2=
025 at 4:49=E2=80=AFAM Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasiredd=
y@intel.com">vivek.kasireddy@intel.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">In the specific case where the displa=
y layer (virtio-gpu) is using<br>
dmabuf, and if remote clients are enabled (-spice gl=3Don,port=3Dxxxx),<br>
it makes sense to limit the maximum (streaming) rate (refresh rate)<br>
to a fixed value using the GUI refresh timer. Otherwise, the updates<br>
or gl_draw requests would be sent as soon as the Guest submits a new<br>
frame which is not optimal as it would lead to increased network<br>
traffic and wastage of GPU cycles if the frames get dropped.<br></blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" ta=
rget=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" target=3D"_bl=
ank">freddy77@gmail.com</a>&gt;<br>
Cc: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_bla=
nk">dongwon.kim@intel.com</a>&gt;<br>
Signed-off-by: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.=
com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
---<br>
=C2=A0include/ui/spice-display.h |=C2=A0 1 +<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++=
++<br>
=C2=A0ui/spice-core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++++++=
+<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 54 ++++++++++++=
+++++++++++++++++++-------<br>
=C2=A04 files changed, 61 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h<br>
index f4922dd74b..2fe524b59c 100644<br>
--- a/include/ui/spice-display.h<br>
+++ b/include/ui/spice-display.h<br>
@@ -152,6 +152,7 @@ struct SimpleSpiceCursor {<br>
<br>
=C2=A0extern bool spice_opengl;<br>
=C2=A0extern bool remote_client;<br>
+extern int max_refresh_rate;<br>
<br>
=C2=A0int qemu_spice_rect_is_empty(const QXLRect* r);<br>
=C2=A0void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 97c63d9b31..4e9f4edfdc 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -2282,6 +2282,7 @@ DEF(&quot;spice&quot;, HAS_ARG, QEMU_OPTION_spice,<br=
>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,disable-agent-file-x=
fer=3Don|off][,agent-mouse=3D[on|off]]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,playback-compression=
=3D[on|off]][,seamless-migration=3D[on|off]]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,video-codecs=3D&lt;e=
ncoder&gt;:&lt;codec&gt;\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,max-refresh-rate=3Drate\n=
&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,gl=3D[on|off]][,rend=
ernode=3D&lt;file&gt;]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 enable spice\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 at least one of {port, tls-port} is mandatory\n&quot;,<br>
@@ -2374,6 +2375,10 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Provide the preferred codec the Spice ser=
ver should use.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Default would be spice:mjpeg.<br>
<br>
+=C2=A0 =C2=A0 ``max-refresh-rate=3Drate``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Provide the maximum refresh rate (or FPS) at w=
hich the encoding<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 requests should be sent to the Spice server. D=
efault would be 30.<br>
+<br>
=C2=A0 =C2=A0 =C2=A0``gl=3D[on|off]``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable/disable OpenGL context. Default is=
 off.<br>
<br>
diff --git a/ui/spice-core.c b/ui/spice-core.c<br>
index 6c3bfe1d0f..d8925207b1 100644<br>
--- a/ui/spice-core.c<br>
+++ b/ui/spice-core.c<br>
@@ -56,6 +56,8 @@ struct SpiceTimer {<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *timer;<br>
=C2=A0};<br>
<br>
+#define MAX_REFRESH_RATE 30<br>
+<br>
=C2=A0static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SpiceTimer *timer;<br>
@@ -491,6 +493,9 @@ static QemuOptsList qemu_spice_opts =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;video-codec=
s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D QEMU_OPT_STRING,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;max-refresh-rate=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_NUMBER,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;agent-mouse=
&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D QEMU_OPT_BOOL,<br=
>
@@ -813,6 +818,12 @@ static void qemu_spice_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 max_refresh_rate =3D qemu_opt_get_number(opts, &quot;max-ref=
resh-rate&quot;, MAX_REFRESH_RATE);<br>
+=C2=A0 =C2=A0 if (max_refresh_rate &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;max refresh rate/fps is inv=
alid&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0spice_server_set_agent_mouse<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(spice_server, qemu_opt_get_bool(opts, &q=
uot;agent-mouse&quot;, 1));<br>
=C2=A0 =C2=A0 =C2=A0spice_server_set_playback_compression<br>
diff --git a/ui/spice-display.c b/ui/spice-display.c<br>
index 9140169015..ed91521ac2 100644<br>
--- a/ui/spice-display.c<br>
+++ b/ui/spice-display.c<br>
@@ -32,6 +32,7 @@<br>
<br>
=C2=A0bool spice_opengl;<br>
=C2=A0bool remote_client;<br>
+int max_refresh_rate;<br>
<br>
=C2=A0int qemu_spice_rect_is_empty(const QXLRect* r)<br>
=C2=A0{<br>
@@ -844,12 +845,32 @@ static void qemu_spice_gl_block_timer(void *opaque)<b=
r>
=C2=A0 =C2=A0 =C2=A0warn_report(&quot;spice: no gl-draw-done within one sec=
ond&quot;);<br>
=C2=A0}<br>
<br>
+static void spice_gl_draw(SimpleSpiceDisplay *ssd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t x, uint32_t y, uint32_t w, uint32_t h)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t cookie;<br>
+<br>
+=C2=A0 =C2=A0 cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW=
_DONE, 0);<br>
+=C2=A0 =C2=A0 spice_qxl_gl_draw_async(&amp;ssd-&gt;qxl, x, y, w, h, cookie=
);<br>
+}<br>
+<br>
=C2=A0static void spice_gl_refresh(DisplayChangeListener *dcl)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpi=
ceDisplay, dcl);<br>
-=C2=A0 =C2=A0 uint64_t cookie;<br>
<br>
-=C2=A0 =C2=A0 if (!ssd-&gt;ds || qemu_console_is_gl_blocked(ssd-&gt;dcl.co=
n)) {<br>
+=C2=A0 =C2=A0 if (!ssd-&gt;ds) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (qemu_console_is_gl_blocked(ssd-&gt;dcl.con)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (remote_client &amp;&amp; ssd-&gt;gl_update=
s &amp;&amp; ssd-&gt;have_scanout) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 glFlush();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spice_gl_draw(ssd, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 surface_width(ssd-&gt;ds), surface_height(ssd-&gt;ds));<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssd-&gt;gl_updates =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* To update at 60 FPS, update_i=
nterval needs to be ~16.66 ms */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcl-&gt;update_interval =3D 1000=
 / max_refresh_rate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -857,11 +878,8 @@ static void spice_gl_refresh(DisplayChangeListener *dc=
l)<br>
=C2=A0 =C2=A0 =C2=A0if (ssd-&gt;gl_updates &amp;&amp; ssd-&gt;have_surface)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_spice_gl_block(ssd, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0glFlush();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKI=
E_TYPE_GL_DRAW_DONE, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 spice_qxl_gl_draw_async(&amp;ssd-&gt;qxl, 0, 0=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 surface_width(ssd-&gt;ds),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 surface_height(ssd-&gt;ds),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cookie);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spice_gl_draw(ssd, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 surface_width(ssd-&gt;ds), surface_height(ssd-&gt;ds));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssd-&gt;gl_updates =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -954,6 +972,20 @@ static void qemu_spice_gl_scanout_disable(DisplayChang=
eListener *dcl)<br>
=C2=A0 =C2=A0 =C2=A0SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpi=
ceDisplay, dcl);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_spice_gl_scanout_disable(ssd-&gt;<a href=3D"=
http://qxl.id" rel=3D"noreferrer" target=3D"_blank">qxl.id</a>);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We need to check for the case of &quot;lost&quot; up=
dates, where a gl_draw<br>
+=C2=A0 =C2=A0 =C2=A0* was not submitted because the timer did not get a ch=
ance to run.<br>
+=C2=A0 =C2=A0 =C2=A0* One case where this happens is when the Guest VM is =
getting<br>
+=C2=A0 =C2=A0 =C2=A0* rebooted. If the console is blocked in this situatio=
n, we need<br>
+=C2=A0 =C2=A0 =C2=A0* to unblock it. Otherwise, newer updates would not ta=
ke effect.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (qemu_console_is_gl_blocked(ssd-&gt;dcl.con)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (remote_client &amp;&amp; ssd-&gt;gl_update=
s &amp;&amp; ssd-&gt;have_scanout) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssd-&gt;gl_updates =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_spice_gl_block(ssd, false);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0spice_server_gl_scanout(&amp;ssd-&gt;qxl, NULL, 0, 0, N=
ULL, NULL, 0, DRM_FORMAT_INVALID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_INVALID, false);<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);<br>
@@ -1061,7 +1093,6 @@ static void qemu_spice_gl_update(DisplayChangeListene=
r *dcl,<br>
=C2=A0 =C2=A0 =C2=A0EGLint fourcc =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool render_cursor =3D false;<br>
=C2=A0 =C2=A0 =C2=A0bool y_0_top =3D false; /* FIXME */<br>
-=C2=A0 =C2=A0 uint64_t cookie;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t width, height, texture;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!ssd-&gt;have_scanout) {<br>
@@ -1159,8 +1190,11 @@ static void qemu_spice_gl_update(DisplayChangeListen=
er *dcl,<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_spice_gl_update(ssd-&gt;<a href=3D"http://qx=
l.id" rel=3D"noreferrer" target=3D"_blank">qxl.id</a>, w, h, x, y);<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_gl_block(ssd, true);<br>
=C2=A0 =C2=A0 =C2=A0glFlush();<br>
-=C2=A0 =C2=A0 cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW=
_DONE, 0);<br>
-=C2=A0 =C2=A0 spice_qxl_gl_draw_async(&amp;ssd-&gt;qxl, x, y, w, h, cookie=
);<br>
+=C2=A0 =C2=A0 if (remote_client) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssd-&gt;gl_updates++;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spice_gl_draw(ssd, x, y, w, h);<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>I think this is not th=
e right place to handle the remote vs local case. It should be done at the =
spice server level, since the server can serve various sockets / connection=
s (not just the one it listens to, but the one it has been given).</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static const DisplayChangeListenerOps display_listener_gl_ops =3D {<b=
r>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000bfe17f0635e2f010--


