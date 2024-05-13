Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83323C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 08:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Qsg-00010Q-SO; Mon, 13 May 2024 04:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s6Qsa-0000zT-Uj
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:17:54 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s6QsN-0007oa-Bl
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:17:48 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43de92e228aso24323661cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715588256; x=1716193056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfmUkZlvcPWWCOF3Qillim9EQLuG1zAlNWBzIIzY+J0=;
 b=UvOZ+Y4N8Ro7FEhF2LnPcvCMz9vmgxL0MglCzJ6ItErOxoJODgegH/Ih7uHW+1GPov
 8TjLojDF5fqR6Oq74RFKvEPX9oSueLz2+/1noypcVKTdoZdMMdb/Wqe+FpOwWKTkbUZb
 WETQ3xGtpEORO6hUDvCKjTswquZehlS/SvIuu8TyPZACJOV+Lwe9H4JU7C5244WWDgk+
 iGxvN3BIsVFf7Gt6pCzB2eKiOacNEW2k58CprPgfWHDOnWemZKiDCM10Fcb2Ardt4GZU
 H2frd1lCtim4v8MkhgxUCp8pTRB89MgPZrrNS4hmYCvJp7U1rHgCEy/NzceBc41WTAFt
 Pm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715588256; x=1716193056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfmUkZlvcPWWCOF3Qillim9EQLuG1zAlNWBzIIzY+J0=;
 b=VgmsG6XECS88hza84KUS+AG4wLUqmJ3z513mXCG1rVPvWJYVeodSX5O0fUwCmXgM7C
 4fW2ORBYz8GT6dd0cMKegNFlF3UTecuq0eYCDqhECUDWmcHVWojoF9PbwVlajGBIJEco
 ztHv2RFqcPBBEIvMQvM3e3rTJ9R67o1GkrgFf2a6ZMwCZxwJjJgcMlXos3YcOAE4p7ez
 lZcAcAQSoOdPo79uxaLjFnY11fOJOCFdypvXaspWT2620O0Ix685QXdYw0AHUrVt1C6g
 Sk6ayOgdVbi38rRQ5Swsri+RM1gXELV9P7AIElnXw/dGTzcOqpCrJ5teUODHLrnJ9qV3
 qrPw==
X-Gm-Message-State: AOJu0Yw1CWC1lJgEptAhvh9qaMdpep7LwMOQ/mVJS6WOalvs55Xq+bDS
 DLQVUe9cwg8Zclqrwwl06grGpX8c/71eLAw9FiWCGvAQntlRh/pp8IuLAB3RNEpZO7Xjcc/v6ii
 ePgn4riBfMCfQbU2QXa7U9i/z0o0=
X-Google-Smtp-Source: AGHT+IE++uvlbPoiSHQwRINO6/wFtCtCyOdnhL6t8ctKu0xIpaIAllW5Z5hOH0yu5h2fNkDWzQARRcENk5REinhAk2w=
X-Received: by 2002:a05:622a:1193:b0:43a:f218:a63f with SMTP id
 d75a77b69052e-43dfdcc7e28mr116378431cf.66.1715588256198; Mon, 13 May 2024
 01:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240512090429.29123-1-hikalium@hikalium.com>
 <20240512111435.30121-1-hikalium@hikalium.com>
 <20240512111435.30121-2-hikalium@hikalium.com>
In-Reply-To: <20240512111435.30121-2-hikalium@hikalium.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 May 2024 12:17:24 +0400
Message-ID: <CAJ+F1CKyk7jahoZ4FTpGdVyDPq0FsURpMBFhFcD7dBi4CpCjnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ui/gtk: Add gd_motion_event trace event
To: hikalium <hikalium@hikalium.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 12, 2024 at 3:16=E2=80=AFPM hikalium <hikalium@hikalium.com> wr=
ote:
>
> Add gd_motion_event trace event for making it easy to debug
> gd_motion_event related issues.
>
> Signed-off-by: hikalium <hikalium@hikalium.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk.c        | 2 ++
>  ui/trace-events | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..ebae888d4f 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -911,6 +911,8 @@ static gboolean gd_motion_event(GtkWidget *widget, Gd=
kEventMotion *motion,
>      x =3D (motion->x - mx) / vc->gfx.scale_x * ws;
>      y =3D (motion->y - my) / vc->gfx.scale_y * ws;
>
> +    trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x=
, y);
> +
>      if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
>          if (x < 0 || y < 0 ||
>              x >=3D surface_width(vc->gfx.ds) ||
> diff --git a/ui/trace-events b/ui/trace-events
> index e6a2894303..69ff22955d 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -28,6 +28,7 @@ gd_ungrab(const char *tab, const char *device) "tab=3D%=
s, dev=3D%s"
>  gd_keymap_windowing(const char *name) "backend=3D%s"
>  gd_gl_area_create_context(void *ctx, int major, int minor) "ctx=3D%p, ma=
jor=3D%d, minor=3D%d"
>  gd_gl_area_destroy_context(void *ctx, void *current_ctx) "ctx=3D%p, curr=
ent_ctx=3D%p"
> +gd_motion_event(int ww, int wh, int ws, int x, int y) "ww=3D%d, wh=3D%d,=
 ws=3D%d, x=3D%d, y=3D%d"
>
>  # vnc-auth-sasl.c
>  # vnc-auth-vencrypt.c
> --
> 2.39.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

