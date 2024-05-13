Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA70C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 08:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Qxp-0002O8-8w; Mon, 13 May 2024 04:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s6Qxl-0002Nn-8z
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:23:13 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s6Qxj-00014B-Dw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 04:23:13 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7f74cca5a35so1380425241.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715588590; x=1716193390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHBnxrcE3WUc8Goe4VOJknp+vQuDgX05+IoYJwbFg/k=;
 b=L/nehH1/lGHNd/5+4utncDS5a8Jy1A8Y7LZgvzL7egjYR0ZdUgfFLVvcEC3VP3mTOE
 mxewYaVtFZtY76wUVeAVZLIUKP6OMN7XV51AoXaDh///MbKLBBjFzhUdgcyR7ItACtWv
 BV0Mqhb10KY+NVoyoaKEJx1GnSIIFxNnOgXtQ/p26VEgDdTDacwfUZmi5WsEHq5XBA24
 4LfZBmbIKYhLc1SsqGkgCHOrEcSK0xCErvizF3fGfRrybOHLUFDtEffL/x0LK1x94zFW
 zKBNXJj5DgUtvBRsfOLLQETnbSK/Xf+crBZGVnDwSeZdoHyTU5RoVL2I6oEHPVawyJbp
 2A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715588590; x=1716193390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHBnxrcE3WUc8Goe4VOJknp+vQuDgX05+IoYJwbFg/k=;
 b=D5UaLrF7Uxe5nOwlZa4ponmu2IjYEQ1uUPv15fOz6OfVnKqz4dapXnXpAw82LGjAXP
 LZ6otSn/m4Unbu7+CODsNF5UuMls0cZ/TAPURXBwRD95sosgUuj60ss+Ewq5PSuTmSvR
 4jSphe2Eqzm2XU8ovH1NYQn/I9CnnXsgWPHP/zgxPO/3s/m+ATPE77GB72rQb+pfWxV5
 Eke2rVa5l8XWuf44Wk1K4lWzehWTXSjVnO4q1nJG4yJeYCNKlBeFrYXjl4aTqz3MpLA/
 eMOxsVQnufmB6FW32aDQsmL0cayDNFfqNbsq4NA/+fTw/93aRc2ODu5MdoQtEZG5uRml
 TrKA==
X-Gm-Message-State: AOJu0YzqGqeU/YxY5hn/zv9ddBrNTdF2eQJud62XK2QrWRq76hih34mS
 bGECI+n7+sPuoMrvPmuz70ca9AWkKbpMqPRspRBlrsEv1dK/87mx3m+BdKHUZEd/djfKUehPah3
 y/0YJHvzafkg27ZphU1lM/aMrgKI=
X-Google-Smtp-Source: AGHT+IGaHgojeAlU8Lt9aqQyjnlTPnyDKJysfQWEAQu1fXJ3xTOk1VM2c33cMyZx0ZpCMOSAMBtVSYAAzNISci/jvrc=
X-Received: by 2002:a05:6102:2ad0:b0:47e:cdce:b760 with SMTP id
 ada2fe7eead31-48077e8407dmr9395127137.22.1715588589933; Mon, 13 May 2024
 01:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240512090429.29123-1-hikalium@hikalium.com>
 <20240512111435.30121-1-hikalium@hikalium.com>
 <20240512111435.30121-3-hikalium@hikalium.com>
In-Reply-To: <20240512111435.30121-3-hikalium@hikalium.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 May 2024 12:22:59 +0400
Message-ID: <CAJ+F1CJzOucq5Om5fnEs9Psqvq-5xxFp9cgxDrxOVztQWesaEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ui/gtk: Fix mouse/motion event scaling issue with
 GTK display backend
To: hikalium <hikalium@hikalium.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x92b.google.com
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

On Sun, May 12, 2024 at 3:16=E2=80=AFPM hikalium <hikalium@hikalium.com> wr=
ote:
>
> Remove gtk_widget_get_scale_factor() usage from the calculation of
> the motion events in the GTK backend to make it work correctly on
> environments that have `gtk_widget_get_scale_factor() !=3D 1`.
>
> This scale factor usage had been introduced in the commit f14aab420c and
> at that time the window size was used for calculating the things and it
> was working correctly. However, in the commit 2f31663ed4 the logic
> switched to use the widget size instead of window size and because of
> the change the usage of scale factor becomes invalid (since widgets use
> `vc->gfx.scale_{x, y}` for scaling).
>
> Tested on Crostini on ChromeOS (15823.51.0) with an external display.
>
> Fixes: 2f31663ed4 ("ui/gtk: use widget size for cursor motion event")
> Fixes: f14aab420c ("ui: fix incorrect pointer position on highdpi with
> gtk")
>

Thanks for the fix, I am okay with it.

But the QEMU displays are not working well with HiDPI. By treating
size & position with logical units, we can't let the guest handle
HiDPI. Imho, we should fix the code differently so the guest has the
non-scaled units.

This is not as trivial, since widget geometry and drawing code is a
bit more involved. And in theory we should adopt the same behaviour
for other display backends.

> Signed-off-by: hikalium <hikalium@hikalium.com>
> ---
>  ui/gtk.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index ebae888d4f..4386198c95 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -887,7 +887,7 @@ static gboolean gd_motion_event(GtkWidget *widget, Gd=
kEventMotion *motion,
>      int x, y;
>      int mx, my;
>      int fbh, fbw;
> -    int ww, wh, ws;
> +    int ww, wh;
>
>      if (!vc->gfx.ds) {
>          return TRUE;
> @@ -895,11 +895,15 @@ static gboolean gd_motion_event(GtkWidget *widget, =
GdkEventMotion *motion,
>
>      fbw =3D surface_width(vc->gfx.ds) * vc->gfx.scale_x;
>      fbh =3D surface_height(vc->gfx.ds) * vc->gfx.scale_y;
> -
>      ww =3D gtk_widget_get_allocated_width(widget);
>      wh =3D gtk_widget_get_allocated_height(widget);
> -    ws =3D gtk_widget_get_scale_factor(widget);
>
> +    /*
> +     * `widget` may not have the same size with the frame buffer.
> +     * In such cases, some paddings are needed around the `vc`.
> +     * To achieve that, `vc` will be displayed at (mx, my)
> +     * so that it is displayed at the center of the widget.
> +     */
>      mx =3D my =3D 0;
>      if (ww > fbw) {
>          mx =3D (ww - fbw) / 2;
> @@ -908,8 +912,12 @@ static gboolean gd_motion_event(GtkWidget *widget, G=
dkEventMotion *motion,
>          my =3D (wh - fbh) / 2;
>      }
>
> -    x =3D (motion->x - mx) / vc->gfx.scale_x * ws;
> -    y =3D (motion->y - my) / vc->gfx.scale_y * ws;
> +    /*
> +     * `motion` is reported in `widget` coordinates
> +     * so translating it to the coordinates in `vc`.
> +     */
> +    x =3D (motion->x - mx) / vc->gfx.scale_x;
> +    y =3D (motion->y - my) / vc->gfx.scale_y;
>
>      trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x=
, y);
>
> --
> 2.39.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

