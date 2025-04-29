Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6FBC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fBi-0006ZH-Gn; Tue, 29 Apr 2025 03:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fB4-0006Oq-Qq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:14:57 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fB2-0004IW-Nt
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:14:50 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-477282401b3so72647051cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745910885; x=1746515685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFaf4yi6sulNLUyuCGwP0hwg9tuKbvqvqKoYNVI//wY=;
 b=ju5aDREJeIeFJfO90U6+88JzNGW2p91NjsZpRik7Lt/aiC2cYR9zGZQKSUiAKBX4xR
 nCTYu2WYEaeQtR0NfJ1LKxT738KxrkrAUO3fdVeQa74WToh/2X494X2pDl3R4f/FH+dH
 tGJ9tYuS+sGgnWF/w4AOs1ailDK9hLRpk7tTYC1bo2KC83yyss9W+TbnPTeELXmKwrgD
 A/zpTCL630xN1+j0Wp6zcUd4MEd6zYn5xaHU+tufZ7XNUXCIL9ewVr/eqMk42rZUCl2z
 2/1WGBeJxBLzame47B2eYDeRUQox8BNs254KibOVk2Y23VnOBmH/idR9jLeOhTjAxx7f
 s4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745910885; x=1746515685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFaf4yi6sulNLUyuCGwP0hwg9tuKbvqvqKoYNVI//wY=;
 b=Zx2KEaAu4wheojFN3gTg1htkICGU5rfJuj6qFq5UeHSqMplrpSOIFt7HHp2TvasE2/
 k0eVZOjwSw0orSLI8X3kgG6KwQc4/geDBc6tQS59mczUQV3qyHb3IT1sJxoh32EmiIt1
 56uJXUagcKIekORtQ8F9oYJfiXXRQBEsFQuhORqh0UwDZo3J9v7KNcWt6y0WBEiNYESO
 7yIs9M40ztzFKTN6l7Q8gj4xHBQojb1j1Z7uPLha8szJ19wXDoAjNNKuMQEGUY+CTP9e
 bSJ2elpsb6evQGgkTuvZvCgF/RgR0AK7maOqBv8VYAS7HmsU2rUSyCZCupKfowIfmM3z
 la3g==
X-Gm-Message-State: AOJu0YxWVfdDVCoUh8a7wKq4AGHxZpWcOzBUn8am+lRwFqIbo3QQYxAX
 GPb+J4ygYtS2e/7a4xzKgr6gBLYI8i2jvGqwG8yYRQnu5kkYA4xZgPGLp0Ub3LyaoMCxTdyMkz5
 zUtrpFc9K21KLnI4UE5Mo+tohrh0=
X-Gm-Gg: ASbGncsi4MH1TWKlShHfmHzpQACHhj8MaBO8qSNgaXEqclz2oYAJmWBW2OZTUaCUkPX
 Eb31Qf5GoLARyAsr+ws6tR2D6FGsPInQl3b3mqZlurdeLimhn+psJ7puIccFk11xgFHBOyXOMFv
 d8CmnP0AaONt2TmjCC6z5QLnb6Jv5k26O2Ub+oKrHs/eIy6whO+LciAPI=
X-Google-Smtp-Source: AGHT+IEUYpb7axjGylVe59xyypF63oskkI5b+OAjstV5If209yEj1moFDgWNhyqGJcbXjGSWGvqx/bGMhSRvWgrdZFE=
X-Received: by 2002:a05:622a:250e:b0:476:aa7a:2f78 with SMTP id
 d75a77b69052e-4886f5c0df8mr35583031cf.49.1745910885617; Tue, 29 Apr 2025
 00:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-4-vivek.kasireddy@intel.com>
In-Reply-To: <20250429060952.59508-4-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 11:14:33 +0400
X-Gm-Features: ATxdqUH-mFOZbToFBeX0ghetlGMQ4lEBlM9jBCehK-hDzFS6X__xXlXk5AtQ124
Message-ID: <CAJ+F1C+_mDLR1+kwNKBh80QR1xDMttMWKu5_6xO4hL+BV6EQYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

Hi Vivek

On Tue, Apr 29, 2025 at 10:19=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> In the specific case where the display layer (virtio-gpu) is using
> dmabuf, and if remote clients are enabled (-spice gl=3Don,port=3Dxxxx),
> it makes sense to limit the maximum (streaming) rate to 60 FPS
> using the GUI timer. This matches the behavior of GTK UI where the
> display updates are submitted at 60 FPS (assuming the underlying
> mode is WxY@60).

I guess it would make sense to make it configurable, for any UI/remote prot=
ocol.

For some UI, refresh rate is set via dpy_set_ui_info(). Unfortunately,
none of the vnc, spice or dbus protocols provide the refresh rate.

I wonder if it would make sense to set it on the GPU.. Perhaps a
"max-refresh-rate" device property?

>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  ui/spice-display.c | 53 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index bf4caf0d1b..2c4daa0707 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -842,12 +842,32 @@ static void qemu_spice_gl_block_timer(void *opaque)
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
> +                          surface_width(ssd->ds), surface_height(ssd->ds=
));
> +            ssd->gl_updates =3D 0;
> +            /* To stream at 60 FPS, the (GUI) timer delay needs to be ~1=
7 ms */
> +            dcl->update_interval =3D 1000 / (2 * GUI_REFRESH_INTERVAL_DE=
FAULT) + 1;

That expression doesn't make much sense to me.

"update_interval" is in ms. GUI_REFRESH_INTERVAL_DEFAULT is 30ms.
(iow, it's not 30fps)

If you need 60fps, just add a new constant/macro value instead?

> +        }
>          return;
>      }
>
> @@ -855,11 +875,8 @@ static void spice_gl_refresh(DisplayChangeListener *=
dcl)
>      if (ssd->gl_updates && ssd->have_surface) {
>          qemu_spice_gl_block(ssd, true);
>          glFlush();
> -        cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DON=
E, 0);
> -        spice_qxl_gl_draw_async(&ssd->qxl, 0, 0,
> -                                surface_width(ssd->ds),
> -                                surface_height(ssd->ds),
> -                                cookie);
> +        spice_gl_draw(ssd, 0, 0,
> +                      surface_width(ssd->ds), surface_height(ssd->ds));
>          ssd->gl_updates =3D 0;
>      }
>  }
> @@ -926,6 +943,20 @@ static void qemu_spice_gl_scanout_disable(DisplayCha=
ngeListener *dcl)
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
>      spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
>      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
>      ssd->have_surface =3D false;
> @@ -1029,7 +1060,6 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>      EGLint stride =3D 0, fourcc =3D 0;
>      bool render_cursor =3D false;
>      bool y_0_top =3D false; /* FIXME */
> -    uint64_t cookie;
>      int fd;
>      uint32_t width, height, texture;
>
> @@ -1107,8 +1137,11 @@ static void qemu_spice_gl_update(DisplayChangeList=
ener *dcl,
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
>  }
>
>  static const DisplayChangeListenerOps display_listener_gl_ops =3D {
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

