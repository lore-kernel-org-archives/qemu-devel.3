Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99715C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8Bp-0003aa-Lm; Mon, 18 Mar 2024 04:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm8Bj-0003YS-MD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:17:43 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm8Bd-0003sf-LD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:17:42 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-789f3bbe3d6so91257285a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710749855; x=1711354655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XOZvYPBVWOqR5SKXkSC97yn35rc6DIsD39gcm/ym80=;
 b=goxrttfg6LyOWj5v6bkKMualrZdoXR59nGASdrY5koxk2UHsSccdUNaYuTZH1acyct
 ySnBmltdYBMrIqEHCtDnXJ0vW5IyMIL/WaBrGtNYXDabq0RlH909vXuoNLvqRImvNR60
 +dJdWI50aIYEBSlcZokPktuWVlstTfpdJAksoaRoJZ8ph8Bt72C1yGeow1ZGJZ0bFjdk
 m8semRzFrL4x6oOT95VRzq7UMSzJr3AthmAk5emOJBLVl6FTX5rJCGsKemm6zigZYAyC
 ZM+vjOUQeaWRH8P8KJcQ1S2u3JQWeeB6N11IJbXzTweXhJtkl0KzVwrW8E1O+q2z1Ion
 wUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710749855; x=1711354655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XOZvYPBVWOqR5SKXkSC97yn35rc6DIsD39gcm/ym80=;
 b=fvbyPLpbQcfVD3Z3o6/JuDa+jXekSsPU58D19ko97+Ihj9NdTOZBvb40SUNnNmI5zK
 sZwQ3nsPDg6yObEECb8bbD6L4+uXmSG3iPSsrPwvGul8Eafd/GXJJU0VYouH7jNca81s
 8XGwcSEp/FqxhowUTcR0NDFQhjHeAYvrXmnLyOXTZo2calo5AqD4Gzk4soiDOAbw0Dcd
 FjzBV+cfaVt7nBNrotxlzAB7ei0KtTQP7s3TZuTaS9NavbB6rD8934xN49AJa+6DpXqX
 3vr+STRyhyJ+/mCPni4VFKzKFVXqeURD1j7tmOiynXGlqRvn36Ry84CSXDgNN2gTH5so
 WWjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+J1opd/JreQc6UTtmR/5OcHGir901COiXiX7U521qqeanMeIGtT/zrPBn/MiOqeOTFGJ1AcyC4OmjTXP22QynqNTCsiE=
X-Gm-Message-State: AOJu0YymY/+jnPEV+t+GiBvayT+ID/Imd0cfuMGQyZCnWoDvEDYSZqy3
 +qU7favtjWd0NoniXv7Dk/3ZpDCAGLdtHO9eM7jEJnmV+gikb2/3xdFnFD5RzVQp9QkZCvg8WAd
 Me1CU0Ew3/QfbD9ejyFfma695I0Y=
X-Google-Smtp-Source: AGHT+IEw2HNTd2hvFrkYUXRdkTGu4/DsSdgDS6ZdWPd0btduCZ7xRh7LTXh7USgRhKSHxJvnqN6eYKLHKCjXxucXfyE=
X-Received: by 2002:a05:622a:14a:b0:430:c64d:45bf with SMTP id
 v10-20020a05622a014a00b00430c64d45bfmr4885358qtw.22.1710749855303; Mon, 18
 Mar 2024 01:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
 <20240318-console-v1-1-f4efbfa71253@daynix.com>
In-Reply-To: <20240318-console-v1-1-f4efbfa71253@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Mar 2024 12:17:23 +0400
Message-ID: <CAJ+F1CLFdNfqKs3EZRDz8pYtCz7=a5y_WSKFmU+0MCJQ4XV0Mw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ui/vc: Do not inherit the size of active console
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x729.google.com
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

On Mon, Mar 18, 2024 at 11:59=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> A chardev-vc used to inherit the size of a graphic console when its
> size not explicitly specified, but it often did not make sense. If a
> chardev-vc is instantiated during the startup, the active graphic
> console has no content at the time, so it will have the size of graphic
> console placeholder, which contains no useful information. It's better
> to have the standard size of text console instead.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/console-vc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 9c13cc2981b0..f22c8e23c2ed 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -990,8 +990,8 @@ static void vc_chr_open(Chardev *chr,
>      trace_console_txt_new(width, height);
>      if (width =3D=3D 0 || height =3D=3D 0) {
>          s =3D QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
> -        width =3D qemu_console_get_width(NULL, 80 * FONT_WIDTH);
> -        height =3D qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
> +        width =3D 80 * FONT_WIDTH;
> +        height =3D 24 * FONT_HEIGHT;
>      } else {
>          s =3D QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE)=
);
>      }
>
> --
> 2.44.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

