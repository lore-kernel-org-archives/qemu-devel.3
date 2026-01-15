Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1534AD3CC9F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIgF-0005LU-Nl; Thu, 15 Jan 2026 03:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vgIgC-0005LB-Jg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:26:08 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vgIg8-0001LO-S1
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:26:06 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-50146483bf9so11683161cf.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 00:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768465564; x=1769070364; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxZBHNhT1o2H7oHQa5pSKhIB3sBLjsNfhZdXskofB5c=;
 b=WUn15F5O88M9AUTXL0Pz5v+s+WUbcO2Tf6UYv0wUwuL5Bfvb6+oN5R1iuhhCCD0VRJ
 zwaYAWw5I5DfnDc5vd5W7xRx9hg9C3C1XqzLFvWYcLJkcIUEtAIzGbc/FEqoxpHE1hGM
 9A0nZbvGIdZejzU0KyaMdHqD3sooR15Xa9cY7NiK1zJeo2oraTjItyWWEYeABV2Z2rKh
 1Y9IoA0eKYDWXb7SYQ6//NB//x/+lGOiji4EC12EmKouNoZNFM7DmJ56Twl4OZ9ZuD8v
 PvUnGG1uVZBe2rcRaEKUg4J1dVKWv4LlYazwKIQY/T49IR7vKjaInAihvKXlUD/YwyIm
 7twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768465564; x=1769070364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UxZBHNhT1o2H7oHQa5pSKhIB3sBLjsNfhZdXskofB5c=;
 b=SsfZmnyz15YPvkUpmWF/qm+k/dSAE3wQ2DC/ksM79i+eO7izgKNEtJ3tLp4+w+yMbk
 j/6F93U/ohy7R35QJ6xe8SRPZuO5ZiTLvE2cZWHd2eZjaZs9I7PWWyb/rPJwc5z8v779
 CdivCLGp8zzBn9Sp4GkQ1ye8M3QcTwrtkUXPwjPh22MsqgrIzRsmVWtr/WciBg6Eh5oz
 KkID6Rrdlz/YK0t1f9phcrNRkjIhSTKuZmQsFBB4JZ7Oa15S7O4tzkwA4Z3T+pYhwj+l
 225uo7Fv2j/OMw+jxsliGVM8MkSuifdF6bV3pcYrfR98rzOW6F9J4JYzIj723ovzTh4h
 crLA==
X-Gm-Message-State: AOJu0YyVcxYbCb+m/UMEHsWPoz+1Nmpd4yGLsU6Wfhc4B++UYyT0ecS3
 zyCdwoBPgCEn8yL27NZf6zJobTLWmehSB1kM0ddjZ/KzSEeZQOoOxifRtkOHOi3lYHl8sqnx/8F
 IF+rwBiTynEvnn0+mJwQfpHF4geWzh01RwA==
X-Gm-Gg: AY/fxX6vIywkhbUV77mTkocerzwq/UJdvIKKPsKzw/CUnsbKBFnGNqMAXBRw9oDIY0M
 SP5ac28cIGBxEesaDc3B8NY6w+l2QkRtbKdELti6V0y1gg2dYIKPdaLjhv4K/KVBS7yP1Vptpfa
 cNmi9qZIj+COVKyHhV9I23dgPyn+i7E0B56cf9lpu3HMDFIBSc5AuRGEdM8pi4uV1+rD0hJ6Xs1
 CqhYENrjG+Zr9PB3PeP8Rb9aOZpwU8Lj7Qb+wVbep+lhokil5yXBLP/7YLb9GzU7gBxV8SI3QiC
 pPSsop5NWWpAw1CJy8RpMoMZBIs=
X-Received: by 2002:a05:622a:261b:b0:4ee:1676:faa6 with SMTP id
 d75a77b69052e-5014820827dmr80248731cf.20.1768465563531; Thu, 15 Jan 2026
 00:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Jan 2026 12:25:52 +0400
X-Gm-Features: AZwV_QiJs3wNMh0A8u-0_iQgRdi2oRcJ7u7lXrdkCE_-2l2D-R8mn2hFegH_R10
Message-ID: <CAJ+F1CJDdjL5fKKzsDUGN8y20aX5dkb7Xere_cXJ5WZw-V0HOg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Narrow DMA-BUF critical section
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

Hi Akihiko

On Thu, Jan 15, 2026 at 9:44=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> ui/gtk performs the following procedure to flush a scanout:
> 1) Queue a draw event.
> 2) The draw event gets triggered.
> 3) Blit the scanout to the framebuffer.
>
> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
> possible and unblocks it after 3).
>
> Blocking the device before 2) has two problems.
>
> First, it can leave the device blocked indefinitely because GTK
> sometimes decides to cancel 2) when the window is not visible for
> example. ui/gtk regularly repeats 1) as a workaround, but it is not
> applicable to GtkGLArea because it causes display corruption.
>
> Second, the behavior is inconsistent with the other types of scanout
> that leaves the device unblocked between 1) and 2).
>
> To fix these problems, let ui/gtk block the device after 2) instead.

Wouldn't that let the device overwrite the buffer before it is displayed?

I wish there would be a clear design for how virtio-gpu handles
display buffering.. I suppose more demanding users, like crosvm may
have documented this.

> Note that the device is still blocked during 3) for DMA-BUF; this is
> because, unlike the other scanout types, 3) can happen asynchronously
> with the device for a DMA-BUF, and the device may simulatenously
> overwrite it, resulting in tearing, if it is left unblocked.
>
> With the problems fixed, the workaround to repeat 1) is no longer
> necessary and removed.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  ui/gtk-egl.c     |  8 +-------
>  ui/gtk-gl-area.c | 23 +----------------------
>  2 files changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index ae9239999cdb..61bb8d731ac5 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
>              } else {
>                  qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
> +            graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          }
>  #endif
>          gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
> @@ -152,12 +153,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>      gd_update_monitor_refresh_rate(
>              vc, vc->window ? vc->window : vc->gfx.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_egl_draw(vc);
> -        return;
> -    }
> -
>      if (!vc->gfx.esurface) {
>          gd_egl_init(vc);
>          if (!vc->gfx.esurface) {
> @@ -408,7 +403,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_egl_set_scanout_mode(vc, true);
>          gtk_widget_queue_draw_area(area, x, y, w, h);
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index cd86022d264a..9e7ec7043037 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>              } else {
>                  qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
> +            graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          }
>  #endif
>
> @@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>
>      gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx=
.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        /*
> -         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has al=
ready
> -         * been submitted, but this function does not call gd_gl_area_dr=
aw() in
> -         * such a case due to display corruption.
> -         *
> -         * Calling gd_gl_area_draw() is necessary to prevent a situation=
 where
> -         * there is a scheduled draw event but it won't happen bacause t=
he window
> -         * is currently in inactive state (minimized or tabified). If dr=
aw is not
> -         * done for a long time, gl_block timeout and/or fence timeout (=
on the
> -         * guest) will happen eventually.
> -         *
> -         * However, it is found that calling gd_gl_area_draw() here caus=
es guest
> -         * display corruption on a Wayland Compositor. The display corru=
ption is
> -         * more serious than the possible fence timeout so gd_gl_area_dr=
aw() is
> -         * omitted for now.
> -         */
> -        return;
> -    }
> -
>      if (!vc->gfx.gls) {
>          if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
>              return;
> @@ -342,7 +322,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *=
dcl,
>
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_gl_area_set_scanout_mode(vc, true);
>      }
>
> ---
> base-commit: 667e1fff878326c35c7f5146072e60a63a9a41c8
> change-id: 20260115-gtk-424c2b910e65
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

