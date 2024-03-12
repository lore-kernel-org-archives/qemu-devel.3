Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D565AC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0I4-00078N-Iq; Tue, 12 Mar 2024 07:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk0Hw-0006eW-33
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:27:21 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk0He-00010l-Vp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:27:18 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3283751276.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710242819; x=1710847619; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNEsIfuHFB3HiLUL/TgDl7Xq/yPRZNjZ7t0tQW27ii0=;
 b=URgpAtDAOOox+4+h/jdI7KRdJF/rccAV13Z4rO06o080TwLO+NHWwWUlJsaWmdLROv
 2znyZLpWTpvVrUncabUiDJi2rvRx+OINdkdUdW6EV41TDcdLii9ily7szKYMssxL9lru
 FUq0JKwcrNgiBWc3lAWMRMFT/IPfvqeAEzO25SKaG8dihxRNL4cNa0NsdhCkPsTUscsl
 RuuETxKmbohpZq2zvoss5F/l4/6fxsbUF7cBqh3WOo9Kmr2+BpAqYIKArziOY4hsqcfi
 26xXD7NBa036r0ZqYO1iZzKbwHqhomXLdMNuM7ofxGiC5yMW/44C3H9g76vt3I37yw5w
 5oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242819; x=1710847619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNEsIfuHFB3HiLUL/TgDl7Xq/yPRZNjZ7t0tQW27ii0=;
 b=cjm05py2L64hKorMqT/i8UYrlrlV9Q1/Kf0WcuJhLnN0ouIuMglKDMArAd1zUNNA2X
 0E58JFqOp6W/1GwbbLLAYZJ1+ajFn+3VP7WSCdLk3z1BGpW5N8x5cRctiveSm3a0CtVV
 nG44BqkbNnM8cTLYsO5B2N3ciQ9QhkgipGG6sOL9CgF5OBgtnT5+u189oNiCDzzuuTTT
 Dwcd/+nm9cjCO5fH2olgwAKA408oq2NqfTHRmNvS/sxc41/qpgSfWREXIQK8Sdh0IuF+
 JIpeEJrKVBNC49ex/SfERLo+UqQJJ9o9pph1QfCOeVsnG6Zbw5yYNwKUtxwwSVRp8p9b
 W8Rg==
X-Gm-Message-State: AOJu0YwMJvxa1YoiPvxq60Y/u97fOduVVeN9d7KSKyNAsfQ+dE3IGl8O
 F8f+zElCX4rrcyOSrg7fs+ZakDmAhMLsODY3CLvDBvZ3oN//wcn9TQ1auXBvrTzUF0KLnQnR+zl
 wptUncdXdiBmCA/qPmaZz2MPrdN8=
X-Google-Smtp-Source: AGHT+IHN6DvaRS106XlWd4m5QI+rZA0ZzEzkqGVSnLLaSw7OA+QSUzcoL8vo0DyYR2pN03u7EGuOYkgPKoMXNUCmStQ=
X-Received: by 2002:a25:6ad4:0:b0:dcb:ff73:2262 with SMTP id
 f203-20020a256ad4000000b00dcbff732262mr6673218ybc.36.1710242819476; Tue, 12
 Mar 2024 04:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240306222523.3236832-1-dongwon.kim@intel.com>
In-Reply-To: <20240306222523.3236832-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Mar 2024 15:26:48 +0400
Message-ID: <CAJ+F1CJEJ8neE9woTJ=SPoSdZA+T4QNC0-GccZ9N2C_cgOvNwQ@mail.gmail.com>
Subject: Re: [PATCH v3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb30.google.com
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

On Thu, Mar 7, 2024 at 2:27=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> If the guest state is paused before it gets a response for the current
> scanout frame submission (resource-flush), it won't flush new frames
> after being restored as it still waits for the old response, which is
> accepted as a scanout render done signal. So it's needed to unblock
> the current scanout render pipeline before the run state is changed
> to make sure the guest receives the response for the current frame
> submission.
>
> v2: Giving some time for the fence to be signaled before flushing
>     the pipeline
>
> v3: Prevent redundant call of gd_hw_gl_flushed by checking dmabuf
>     and fence_fd >=3D 0 in it (e.g. during and after eglClientWaitSync
>     in gd_change_runstate).
>
>     Destroy sync object later in gd_hw_fl_flushed
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/egl-helpers.c |  2 --
>  ui/gtk.c         | 31 +++++++++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 3d19dbe382..a77f9e57d9 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -385,8 +385,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>      if (dmabuf->sync) {

We may want to check that no fence_fd exists before, to avoid leaks.

I also notice that fence_fd is initialized with 0 in
vfio_display_get_dmabuf(). It would probably make sense to introduce
functions to allocate, set and get fields from QemuDmaBuf and make the
struct private, as it is too easy to do a wrong initialization...


>          dmabuf->fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display=
,
>                                                        dmabuf->sync);
> -        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
> -        dmabuf->sync =3D NULL;
>      }
>  }
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..eaca890cba 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -597,10 +597,14 @@ void gd_hw_gl_flushed(void *vcon)
>      VirtualConsole *vc =3D vcon;
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>
> -    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
> -    close(dmabuf->fence_fd);
> -    dmabuf->fence_fd =3D -1;
> -    graphic_hw_gl_block(vc->gfx.dcl.con, false);
> +    if (dmabuf && dmabuf->fence_fd >=3D 0) {

It may have failed to create the fence_fd, but succeeded in creating
the sync, in which case it will leak the sync.

Btw, can't the fence_fd be created at the same time as the sync
instead of having two functions?

I also noticed that fenced_fd is incorrectly checked for > 0 instead
of >=3D 0 in gtk-egl.c and gtk-gl-area.c. Can you fix that as well?

> +        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
> +        close(dmabuf->fence_fd);
> +        dmabuf->fence_fd =3D -1;
> +        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
> +        dmabuf->sync =3D NULL;
> +        graphic_hw_gl_block(vc->gfx.dcl.con, false);
> +    }
>  }
>
>  /** DisplayState Callbacks (opengl version) **/
> @@ -678,6 +682,25 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
>  static void gd_change_runstate(void *opaque, bool running, RunState stat=
e)
>  {
>      GtkDisplayState *s =3D opaque;
> +    int i;
> +
> +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            VirtualConsole *vc =3D &s->vc[i];
> +
> +            if (vc->gfx.guest_fb.dmabuf &&
> +                vc->gfx.guest_fb.dmabuf->fence_fd >=3D 0) {
> +                eglClientWaitSync(qemu_egl_display,
> +                                  vc->gfx.guest_fb.dmabuf->sync,
> +                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
> +                                  100000000);
> +
> +                /* force flushing current scanout blob rendering process
> +                 * just in case the fence is still not signaled */
> +                gd_hw_gl_flushed(vc);
> +            }
> +        }
> +    }
>
>      gd_update_caption(s);
>  }
> --
> 2.34.1
>
>

thanks


--=20
Marc-Andr=C3=A9 Lureau

