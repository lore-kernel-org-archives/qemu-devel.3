Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2997CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkFz-0000py-UF; Tue, 28 Oct 2025 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDkFw-0000pf-W0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:01:01 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDkFp-00084C-RD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:01:00 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so1242066766b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761660048; x=1762264848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPF20KQj9Kkit6qF0zFz1hQQjDow0Vd9RI3Nb+hupNg=;
 b=ZmK97Z3nWzEW04YBncCZA0Yib2MITiJ2d8AXK5XO2r74n+OmrRHEBURsU8qAmeJOBY
 pGqTK0joURZ+Y5yoUj7l8wzozTmm6is8IzJNnFIhT7pPeNtZitGP6EZxS/QfOE+JqmeW
 svvr06+e0crg2hNgGJQHfhl4Xp6OMUBkMwZoZT/jnmRNyFs+UeJW07NG/elPF0XWNF4W
 5zBDFfQeDzGfShEfSu1DxGhPuQ/10v4Y3vWIgBsA+cH+1td1+RlD0rqGp0e+YB23Fqjq
 zIUoh/+M2v/GRoCzXxx0FcB3lNr7NLb/9UMgsOlPJPcZEMWcT5SSf5+vgq3VEaXtzAmH
 GOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761660048; x=1762264848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPF20KQj9Kkit6qF0zFz1hQQjDow0Vd9RI3Nb+hupNg=;
 b=Wu7Ircr82PC4eOu24UdQYngfWsWfPiKtjyRGI2u4qpCNvMoiLCepANT4ZHGFCFZ+FH
 aVxmX86JpeZXhbH8yC/tCdtOC/nU8M33pxgJCgf4TjnOAKPebFxQgFK4Douuqr89J+uZ
 r0fJsk7KuauCqjvc6RBJSmSdXZFuj31bn662KTghvPrnHGfncP941ssafo+UsTjGcGVb
 wTSWf5Y88mNgvudo/x3vLZkyegTHQ8nx1QnWRA4ltx605ZPNkc5EWyZl3+SEkvoaJNtT
 Z+IgEM8REr4BhSJTtSOV2JdjkjnXuIUoPjmnzaIPRChJRn1xO9M+Ya8r2bpHnUsZUVss
 eI9w==
X-Gm-Message-State: AOJu0YxgCarvTkB4ychQhNVToJoYzPi/1FXEnN5ZLcWQvxfQ7s8PYe0M
 eRmkG9el5t5Yh0lUHUXOzO2S50TGgqSF4p9nPPbiRvssqSK4OQSYv8QJUr6y7fSkenrYVDkEQqo
 JG2Ha6FYJfIOgiC9LDpFkvlA/mSyx1Mk=
X-Gm-Gg: ASbGncuBTbEF0tazElAf+cE27KHvGygLWbZVGoMhZqSLP0hhe/QwKO7U6jdyfwiu6tE
 +mBNpD2bdk8HI8OqEcQEUdaBRNJPr1GEjIEAXF5kBGKKT2y1zcKGCwfhaRik0KChwY4eqsJT0NY
 atEug+v4LEO/FYaG6xi6gLjEEnXwS/h09/aMAh0b33Khuc98VU3M4kq87KUgqkbAeqI7NYSpXxy
 /PUMR+5goQ80g2TrXLX3s0l8hIjZipDx3E2q4MWx3tp2F2o8jwYTOspEBVYAIEoN5TBVzRg7Sqf
 XZgRB3PQt5Xqidy8
X-Google-Smtp-Source: AGHT+IHL7oV3gHvsuvxeU87DSv6JUFIK6Im3Y9dkyDgT3xXGSfxzjuJwqXQFza45Rcybup8J5NrxeosB/9Ge5wTdeYk=
X-Received: by 2002:a17:906:4fce:b0:b04:3bfe:5b20 with SMTP id
 a640c23a62f3a-b6dba584b73mr372551766b.30.1761660047355; Tue, 28 Oct 2025
 07:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-8-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-8-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 18:00:33 +0400
X-Gm-Features: AWmQ_blGdRx3ZkIR1RejAr68S8_JFTYQd_KtUTiMkkeP8IXQ4naiViitfZY_Gcs
Message-ID: <CAJ+F1CJj+00rCtuNkpSfcFN5Amvbe_JiKAXQ8XnBcOHcL5Duaw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62d.google.com
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

On Wed, Oct 22, 2025 at 7:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> qemu_chr_write() dispatches to ChardevClass::chr_write(),
> and is expected to propagate the backend error, not some
> unrelated one produce by "best effort" logfile or replay.
> Preserve and return the relevant %errno.

Indeed.. imho we should avoid using errno, it's too easy to clutter.
Even qemu mutex, which may use trace, may change it...

patch lgtm anyway
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  chardev/char.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 5c8130b2435..2af402d9855 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -113,6 +113,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>                                   int *offset, bool write_all)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
> +    int saved_errno;
>      int res =3D 0;
>      *offset =3D 0;
>
> @@ -138,6 +139,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>              break;
>          }
>      }
> +    saved_errno =3D errno;
>      if (*offset > 0) {
>          /*
>           * If some data was written by backend, we should
> @@ -154,6 +156,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>           */
>          qemu_chr_write_log(s, buf, len);
>      }
> +    errno =3D saved_errno;
>      qemu_mutex_unlock(&s->chr_write_lock);
>
>      return res;
> @@ -186,7 +189,9 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, in=
t len, bool write_all)
>      res =3D qemu_chr_write_buffer(s, buf, len, &offset, write_all);
>
>      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
> +        int saved_errno =3D errno;
>          replay_char_write_event_save(res, offset);
> +        errno =3D saved_errno;
>      }
>
>      if (res < 0 && offset =3D=3D 0) {
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

