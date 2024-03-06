Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA11AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmVz-0008NU-CX; Wed, 06 Mar 2024 03:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhmVo-0008Mx-3x; Wed, 06 Mar 2024 03:20:29 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhmVd-0001l6-Cm; Wed, 06 Mar 2024 03:20:27 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42a35c720b8so25018671cf.3; 
 Wed, 06 Mar 2024 00:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709713215; x=1710318015; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4Vk53yqROFfkXvTFw4/gxHrhQ3keaDLl7Eby9dqlWE=;
 b=fbRFY8fJXEzCHITKOhRB8cAP9TXu9XntaOAv9u6NKqTw5sSJAVKdezI27r6OUu56rB
 cT2FnJ/eLxFHuo4at1uML/7f1NAkUPdxlIG2cWJOEF50tIUb6DjjiUCVsjqjdSkxioob
 7rI2m5LIKzO6tfEYXhCcqvSrjvKQXddOeBXvwntLJQX59k32b3xKoXfjSXF2RFS4s8wM
 KlhwwfY6dgCCCA8vg59EW7gok8s6r20bxwTPNdm4EL+Di9eFyagjiLoWiB11Pv/7k2BB
 IALuNGka0/Gy0jnUHik3hfCPKdGdMTnYLhmUrSmwVpQfDcoh+o35DXmzbCGxLFB3NaU9
 FrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709713215; x=1710318015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4Vk53yqROFfkXvTFw4/gxHrhQ3keaDLl7Eby9dqlWE=;
 b=l/gsqM3vVdUE68YNr4nivMjkt8bvRmqWH1ZPTjdGu8LMcYikLTLjBCfibsdLrZ/7lt
 jIIzGMk05iys0WbsQ94EH2EGVa0ZetDH9oyPaEixYz2ZwSSJVTnDX1vNUPjUVhFTl7pY
 GQo1culHLkG37mwk5IP4ONEm5IArPVu88srRoQuYu5HQ/NchhfKIhvUZqkS/PsnE/V5/
 nM6BfXRoGXnLlD0pK3T4ljaleUfUVpD1y0mi1gfXZYbjuxtGTiqz0SFOYWKbGMIhYtWF
 9isQm1ZBB42QJh1hRAiEYhHQujEqq6NJNIhyt//k/xpZ0YvcyXZCtbP4izmeggeFAX0d
 o+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLp1gQqXN/MnqFnRBpMmouA18/Y22UBxaSRUFFIWypwBzYswwEokxt7R7Oq5Fy7jv3P3++wU/wiwF4P4M0VNPiO3+Bi0CJTA==
X-Gm-Message-State: AOJu0YyxWZ9ch0gxYxjZZiVirKyr6Un3K05R7NiqAN+I5RthVZ5wbpDl
 /MQ2ph78S0FJfyapS7jNkDJDY98J8W96WvtN6LDoEef6JxzzSEvxchQeePj8KG4ogVl4PY+m8Av
 oEDFrcmi290cuEvDRPetRm340Twg=
X-Google-Smtp-Source: AGHT+IFIHsLKLFyCF9Iprbv/jmtqhhZ15Pme/zW9P1euX7ft2hK0ngdvUzbPtWXC9Afh/T7Dj3989v6N9PALxT/hYUQ=
X-Received: by 2002:ac8:598e:0:b0:42e:7ea3:46ce with SMTP id
 e14-20020ac8598e000000b0042e7ea346cemr4758060qte.43.1709713215420; Wed, 06
 Mar 2024 00:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20240306081505.2258405-1-armbru@redhat.com>
In-Reply-To: <20240306081505.2258405-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Mar 2024 12:20:03 +0400
Message-ID: <CAJ+F1CKR1zy0S7iM8S0S78GZYt90+six48kgs36z+vJVhxdvng@mail.gmail.com>
Subject: Re: [PATCH] char: Slightly better error reporting when chardev is in
 use
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 6, 2024 at 12:15=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Both
>
>     $ qemu-system-x86_64 -chardev null,id=3Dchr0,mux=3Don -mon chardev=3D=
chr0 -mon chardev=3Dchr0 -mon chardev=3Dchr0 -mon chardev=3Dchr0 -mon chard=
ev=3Dchr0
>
> and
>
>     $ qemu-system-x86_64 -chardev null,id=3Dchr0 -mon chardev=3Dchr0 -mon=
 chardev=3Dchr0
> fail with
>
>     qemu-system-x86_64: -mon chardev=3Dchr0: Device 'chr0' is in use
>
> Improve to
>
>     qemu-system-x86_64: -mon chardev=3Dchr0: too many uses of multiplexed=
 chardev 'chr0' (maximum is 4)
>
> and
>
>     qemu-system-x86_64: -mon chardev=3Dchr0: chardev 'chr0' is already in=
 use
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-fe.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 20222a4cad..66cee8475a 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -199,13 +199,18 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, E=
rror **errp)
>              MuxChardev *d =3D MUX_CHARDEV(s);
>
>              if (d->mux_cnt >=3D MAX_MUX) {
> -                goto unavailable;
> +                error_setg(errp,
> +                           "too many uses of multiplexed chardev '%s'"
> +                           " (maximum is " stringify(MAX_MUX) ")",
> +                           s->label);
> +                return false;
>              }
>
>              d->backends[d->mux_cnt] =3D b;
>              tag =3D d->mux_cnt++;
>          } else if (s->be) {
> -            goto unavailable;
> +            error_setg(errp, "chardev '%s' is already in use", s->label)=
;
> +            return false;
>          } else {
>              s->be =3D b;
>          }
> @@ -215,10 +220,6 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Er=
ror **errp)
>      b->tag =3D tag;
>      b->chr =3D s;
>      return true;
> -
> -unavailable:
> -    error_setg(errp, QERR_DEVICE_IN_USE, s->label);

QERR_DEVICE_IN_USE is now left with a single user in blockdev.c. Is it wort=
h it?


--=20
Marc-Andr=C3=A9 Lureau

