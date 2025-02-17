Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12529C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 11:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjziP-0003eE-NM; Mon, 17 Feb 2025 06:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tjziN-0003dM-Qi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:55:07 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tjziM-0002Tm-0d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:55:07 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-471f16f4b73so6671171cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 03:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739793304; x=1740398104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiQbsePGizEeW1k4o93v0zTlwG1UoOlrzsKnA8rGeBA=;
 b=BKHqbpyCvbDe6njSxCNcgDqY9H6Y/7EsV0xHgD1rwVmKKn62f4BmgjdDsF9Zobkduf
 Dejcd7OwsDQTybImn3UaYu7dDCTVE9x8XAh1Db68paT0h5/sTujs2aW6y0zMM5tjxIRD
 qyxPi12b2YoPgdyNpUAndqjK0QKqXO3Hhg5SbAu+aDoP78ceWuGmTXFUh56mr3NG/LHW
 jqw4Y2TsLDsAC2nYANtenwTUCwgJ1Q/ndHCZONguF1aeeTy7joTTklPyMZFGGQZAWmA5
 vIYUw0zPRCFcsEQMf7sZb4K5/y6sxuLfwcISMJ6lZOrGNDOQwiC6SnE2FfKOvcFKtfg8
 XoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739793304; x=1740398104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiQbsePGizEeW1k4o93v0zTlwG1UoOlrzsKnA8rGeBA=;
 b=s7QDoIX2B0TcHkisT/eptbQPEpCuuZDOqgNia7cZ7Fnh8kUCd/GenZsG8Q+rw4dpwx
 6TKaOfTP1dDY06Q+i0CRxgFUUCWc5kTp5Vc3zSnPIDyVdmDgCIMtznwTZyzqKjxSKZ5j
 agPcfdMF0zPCdO9+nbXC+Z6DkS9n7ojL+Bavv92ne7rkVosn4R+KqjtMwBLyHj8NS1N/
 ytWBrdRfrFDpz6KQteKaFVfA+Pvl2iQFefquHZ5CkwgBV1K+MA5gpQqnxiTBsrMd0Lno
 dhQPq+HW0bI5sWylaR3LzZLSqr/xC9gmMZCtQGY/l1XuBqk7cJa7z2chyC+LIcKKmZ41
 VmHA==
X-Gm-Message-State: AOJu0YwWDSVFobbs2I06m/tyUOHYG1DerN5ctalsLcqAtVS8BenE696A
 meXoc41wHYIwM8ASztNIMw4urY/CkoqYEm/DMpuB9WjWBkX/WB54fLsAtTiYGTyMBSZGi7rVbwe
 3P7D805ALmClrw8w0ZaaeFO1DyUP6ph5FYNo=
X-Gm-Gg: ASbGncsbPwsQQxHsmfvxymyTL0vVHFIANu2QhzNv/kiwoyMZax4LaBRADy3Zy/EB51z
 xw9VdtIWTDspYCHj/VB+zFIl2C4UpakU35SFV40Dy4lhND78tecFqUNQ8UHjxKp2A6ALyVTcy1x
 e8sOmRJ9RnZBTkKh6ONBd7HmPklZ8JoA==
X-Google-Smtp-Source: AGHT+IEnNwalJmJ7WZkUYl7VvXAQ3vD9/3EjOuMUimFttzqEdEG0QAvm3ZTbGBagELcVed1D0EXb/F7gJ/P/qVu2wTo=
X-Received: by 2002:a05:622a:81:b0:471:9774:a03a with SMTP id
 d75a77b69052e-471dbd1a1d5mr134318231cf.15.1739793304210; Mon, 17 Feb 2025
 03:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20250217111518.93617-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250217111518.93617-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Feb 2025 15:54:52 +0400
X-Gm-Features: AWEUYZlOrTma7X4ZUBtgZYrACJP125cRomQPCzZD2n8JUUC8RZD0QOVztPso3wE
Message-ID: <CAJ+F1CLqHphYkrk-M+mRT8_+a7487gGo530vfCou-8i-vpbjHg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl: only compile dmabuf support if CONFIG_GBM
To: qemu-devel@nongnu.org
Cc: pierre-eric.pelloux-prayer@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

Hi

On Mon, Feb 17, 2025 at 3:16=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fix SDL backend compilation for win32.
>
> Fixes: commit 31287d1af4 ("ui/sdl2: Implement dpy dmabuf functions")

Pierre-Eric, I realize this is not yet upstream. Can you update your
patch? thanks


>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/sdl2-gl.c | 2 ++
>  ui/sdl2.c    | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 31f8fbe032..6bceeed565 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -251,6 +251,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl=
,
>      SDL_GL_SwapWindow(scon->real_window);
>  }
>
> +#ifdef CONFIG_GBM
>  void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>                              QemuDmaBuf *dmabuf)
>  {
> @@ -312,3 +313,4 @@ void sdl2_gl_console_init(struct sdl2_console *scon)
>      scon->surface =3D NULL;
>      scon->hidden =3D hidden;
>  }
> +#endif /* CONFIG_GBM */
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9439745443..8c9df23343 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -806,9 +806,11 @@ static const DisplayChangeListenerOps dcl_gl_ops =3D=
 {
>      .dpy_gl_scanout_texture  =3D sdl2_gl_scanout_texture,
>      .dpy_gl_update           =3D sdl2_gl_scanout_flush,
>
> +#ifdef CONFIG_GBM
>      .dpy_gl_scanout_dmabuf   =3D sdl2_gl_scanout_dmabuf,
>      .dpy_gl_release_dmabuf   =3D sdl2_gl_release_dmabuf,
>      .dpy_has_dmabuf          =3D sdl2_gl_has_dmabuf,
> +#endif
>  };
>
>  static bool
> @@ -939,7 +941,9 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>          sdl2_console[i].kbd =3D qkbd_state_init(con);
>          if (display_opengl) {
>              qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> +#ifdef CONFIG_GBM
>              sdl2_gl_console_init(&sdl2_console[i]);
> +#endif
>          }
>          register_displaychangelistener(&sdl2_console[i].dcl);
>
> --
> 2.47.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

