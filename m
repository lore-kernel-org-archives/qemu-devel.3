Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E86DC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 07:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmSqN-0006WM-0b; Mon, 24 Feb 2025 02:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tmSqL-0006Vx-3M
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:25:33 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tmSqF-0002rG-AR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:25:32 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4721bfdb565so56991791cf.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 23:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740381925; x=1740986725; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5f7AzMHMjbASeKwGkjBrM7dEY9LM6cqKsYWBL8ZdZo=;
 b=jl1ZdE9PkgETUOApQqCo1HmQeO/EiOa9Aw3S0VlocOHrqm2pxkooOUZ2Vu4g93+yEy
 PKARQY9pYTP0BLAL+V6q/qNx+suui6I1ZZMItoNSAgQ2Zr+8UOS9BMvatxksv9Ilw8TV
 6imGFtR2+0ABv/HpCgg9w3WG508y8En+lFaXIuL+R82jOAZQdeg8dBuh5C73dmwM9PTw
 BHIzRSI3YfV09piMMxA8mx7wMYj9S5X+YHwOMFGiTlfWautbxl6jt3ESLhvJFewbJk+v
 ZafMwp3j8FrFIg74WDUniqnACcoRCz2/EZPZiqU3OgPoT/iL3r6duRG2Oi0o1VxbXVDc
 NX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740381925; x=1740986725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5f7AzMHMjbASeKwGkjBrM7dEY9LM6cqKsYWBL8ZdZo=;
 b=BFs32WoOgCU32PA/yWE38xJRlUXRhAScmKWsqgpXjJu6Lpvz4sCq1B1hdIbyKweD4A
 t8e8i4HmKjmCTEubV+5u6Yru6c/rHcIJRBMBRb1rgATo1F6gmiJGskt6fnMEeU6HHo3f
 3eZ62c7av5L0H8n8Hff6nl4eIgUkwEaCizRnIRZCoOc03rWSLhxu3GGPzs3a25MJLZp3
 c43Ms7mUYY+wF9a7JmSM35LW9mvWVvyq6QXbMVaMrfRDvTfKTbkOwkg6QLltgHrX/Url
 kxgkvatqmWkkO3T2kwXuoaoLZPW4rjbByZt72ez2ltKpjGEcHD706VLQA0zN7vCApNpf
 rmfw==
X-Gm-Message-State: AOJu0YwWV++M9iNLSYwv3gPNaGjy3jLDsxKL2awWJhrVxh01Sz3XrcIw
 B++a3XbI1RIfB5Pz47oJa0D863lpampJRbTHr7RhwoxODpVaojNRwzfs/XsFDljfyCX5vkV6T5r
 V7UP66RDNALQdN5L9OTI8an/F886N5C6u1pA=
X-Gm-Gg: ASbGncsSlM+ptgNl3ra0p9dZqroJnWnVxm70vRffr8b/TYsSWB0/4S7+MJ4qfCjGpn1
 4sQbdMcWISXn614WKAuuvDi9w4PRp/qboZ3sHFxL+4ASr2SKT730rxuw47GGeZ0JPfWj1TNn4mh
 snGH51j3Ey
X-Google-Smtp-Source: AGHT+IFZJu1Q7W/n48UnW1LWR29xwJjqDGBmdOrnVTvKwPj4hsxaIfJ/TOhXVgE+aDwj7s710QJ5U1qcHbMSvcZnRtI=
X-Received: by 2002:a05:622a:178b:b0:472:1848:4fa6 with SMTP id
 d75a77b69052e-472228c8d55mr158174361cf.15.1740381925394; Sun, 23 Feb 2025
 23:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20250223145407.259924-1-r.peniaev@gmail.com>
 <20250223145407.259924-6-r.peniaev@gmail.com>
In-Reply-To: <20250223145407.259924-6-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Feb 2025 11:25:13 +0400
X-Gm-Features: AWEUYZm1rOgzlI-om4JMgbVZzyQQgo-hlIqo89yg8dLHKf0iU--PQvB39j0iFFc
Message-ID: <CAJ+F1CKMor3asfyOnNj6bVWFmzi10wtJxNuHzhcy4PqWysZU9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] ui/console-vc: implement DCH (delete) and ICH
 (insert) commands
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
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

On Sun, Feb 23, 2025 at 6:56=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> This patch implements DCH (delete character) and ICH (insert
> character) commands.
>
> DCH - Delete Character:
>    "As characters are deleted, the remaining characters between the
>     cursor and right margin move to the left. Character attributes move
>     with the characters. The terminal adds blank spaces with no visual
>     character attributes at the right margin. DCH has no effect outside
>     the scrolling margins" [1].
>
> ICH - Insert Character:
>    "The ICH sequence inserts Pn blank characters with the normal
>     character attribute. The cursor remains at the beginning of the
>     blank characters. Text between the cursor and right margin moves to
>     the right. Characters scrolled past the right margin are lost. ICH
>     has no effect outside the scrolling margins" [2].
>
> Without these commands console is barely usable.
>
> [1] https://vt100.net/docs/vt510-rm/DCH.html
> [1] https://vt100.net/docs/vt510-rm/ICH.html
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  ui/console-vc.c | 108 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 6 deletions(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 522adc2806c8..bc667897d1bc 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -598,21 +598,29 @@ static void vc_clear_xy(VCChardev *vc, int x, int y=
)
>      vc_update_xy(vc, x, y);
>  }
>
> -static void vc_put_one(VCChardev *vc, int ch)
> +static void vc_insert_xy(VCChardev *vc, int ch, int x, int y)
>  {
>      QemuTextConsole *s =3D vc->console;
>      TextCell *c;
>      int y1;
> +
> +    y1 =3D (s->y_base + y) % s->total_height;
> +    c =3D &s->cells[y1 * s->width + x];
> +    c->ch =3D ch;
> +    c->t_attrib =3D vc->t_attrib;
> +    vc_update_xy(vc, x, y);
> +}
> +
> +static void vc_put_one(VCChardev *vc, int ch)
> +{
> +    QemuTextConsole *s =3D vc->console;
> +
>      if (s->x >=3D s->width) {
>          /* line wrap */
>          s->x =3D 0;
>          vc_put_lf(vc);
>      }
> -    y1 =3D (s->y_base + s->y) % s->total_height;
> -    c =3D &s->cells[y1 * s->width + s->x];
> -    c->ch =3D ch;
> -    c->t_attrib =3D vc->t_attrib;
> -    vc_update_xy(vc, s->x, s->y);
> +    vc_insert_xy(vc, ch, s->x, s->y);
>      s->x++;
>  }
>
> @@ -645,6 +653,88 @@ static void vc_set_cursor(VCChardev *vc, int x, int =
y)
>      s->y =3D y;
>  }
>
> +/**
> + * vc_csi_P() - (DCH) deletes one or more characters from the cursor
> + * position to the right. As characters are deleted, the remaining
> + * characters between the cursor and right margin move to the
> + * left. Character attributes move with the characters.
> + */
> +static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
> +{
> +    QemuTextConsole *s =3D vc->console;
> +    TextCell *c1, *c2;
> +    unsigned int x1, x2, y;
> +    unsigned int end, len;
> +
> +    if (!nr) {
> +        nr =3D 1;
> +    }
> +    if (nr > s->width - s->x) {
> +        nr =3D s->width - s->x;
> +        if (!nr) {
> +            return;
> +        }
> +    }
> +
> +    x1 =3D s->x;
> +    x2 =3D s->x + nr;
> +    len =3D s->width - x2;
> +    if (len) {
> +        y =3D (s->y_base + s->y) % s->total_height;
> +        c1 =3D &s->cells[y * s->width + x1];
> +        c2 =3D &s->cells[y * s->width + x2];
> +        memmove(c1, c2, len * sizeof(*c1));
> +        for (end =3D x1 + len; x1 < end; x1++) {
> +            vc_update_xy(vc, x1, s->y);
> +        }
> +    }
> +    /* Clear the rest */
> +    for (; x1 < s->width; x1++) {
> +        vc_clear_xy(vc, x1, s->y);
> +    }
> +}
> +
> +/**
> + * vc_csi_at() - (ICH) inserts `nr` blank characters with the normal
> + * character attribute. The cursor remains at the beginning of the

What is "normal character attribute"?

Should you set it to  TEXT_ATTRIBUTES_DEFAULT while inserting blank chars?

> + * blank characters. Text between the cursor and right margin moves to
> + * the right. Characters scrolled past the right margin are lost.
> + */
> +static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
> +{
> +    QemuTextConsole *s =3D vc->console;
> +    TextCell *c1, *c2;
> +    unsigned int x1, x2, y;
> +    unsigned int end, len;
> +
> +    if (!nr) {
> +        nr =3D 1;
> +    }
> +    if (nr > s->width - s->x) {
> +        nr =3D s->width - s->x;
> +        if (!nr) {
> +            return;
> +        }
> +    }
> +
> +    x1 =3D s->x + nr;
> +    x2 =3D s->x;
> +    len =3D s->width - x1;
> +    if (len) {
> +        y =3D (s->y_base + s->y) % s->total_height;
> +        c1 =3D &s->cells[y * s->width + x1];
> +        c2 =3D &s->cells[y * s->width + x2];
> +        memmove(c1, c2, len * sizeof(*c1));
> +        for (end =3D x1 + len; x1 < end; x1++) {
> +            vc_update_xy(vc, x1, s->y);
> +        }
> +    }
> +    /* Insert spaces */
> +    for (x1 =3D s->x; x1 < s->x + nr; x1++) {
> +        vc_insert_xy(vc, ' ', x1, s->y);
> +    }
> +}
> +
>  /**
>   * vc_save_cursor() - saves cursor position and character attributes.
>   */
> @@ -847,6 +937,9 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  }
>                  break;
> +            case 'P':
> +                vc_csi_P(vc, vc->esc_params[0]);
> +                break;
>              case 'm':
>                  vc_handle_escape(vc);
>                  break;
> @@ -870,6 +963,9 @@ static void vc_putchar(VCChardev *vc, int ch)
>              case 'u':
>                  vc_restore_cursor(vc);
>                  break;
> +            case '@':
> +                vc_csi_at(vc, vc->esc_params[0]);
> +                break;
>              default:
>                  trace_console_putchar_unhandled(ch);
>                  break;
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

