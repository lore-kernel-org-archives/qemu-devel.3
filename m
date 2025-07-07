Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC4C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 10:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYieq-0002bD-UG; Mon, 07 Jul 2025 06:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYieg-0002ZI-Qb
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:01:00 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYieZ-0002bb-Il
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:00:56 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e819ebc3144so2541051276.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751882449; x=1752487249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaUdMQcxOXRLk47Ye9FXQboOl+cPo2mgmn2mPBloldc=;
 b=o9ffTRUWR0KWXg3sKndJB+yeB8M2+irkp6TK5yfB042J8xHXoguFPY6fPpGOifzt8m
 ywh70t4DCqJ8xNF7WLohiiS0eRQa2v4eBp8LeOoXfvfj5/hBgrnQV3VsezfTZ2Kz3VfJ
 I4qEIBbvwm7xEwL+G7Jrc0//Y/GjcJLxp5jmT132zvDhQxDRl/29k07Oi7aiWuOIc5RO
 Pe3MQz30KBhxSTYwudWvH37mleSKozq0PGwzwZpqT3AZ50Ocv307ONKQgphxLIViWp4E
 Nn8BCfVeA3qfig0eTQ239R867xcdwJxJ/kW30SCM8jx12QxRuxDwxssWqYkXHgxX2QOt
 Of8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882449; x=1752487249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaUdMQcxOXRLk47Ye9FXQboOl+cPo2mgmn2mPBloldc=;
 b=NwS20eiS3ndURwglIdthbTPQxqY8Lf8Th+TE0YDMfqvc/OfPgbtK/xbWcI63IO+d15
 Dnid0y484P2/4b5X7FoY4uW0ZCapaazIM7MgQDxw7ePLKTnJRYXNrtQ0kqkTjjZCLKWU
 BVo9jGXr2eG8bNmFzIpVbEXCvTW+6pbnkoZAwYp1uDD9dfqiRMZYB20s96oo6NU9UpNc
 GxGNWtxiJYyyX30RvUw3qo82ySyD2WUIdzybD24zrPYmDcDw+tCvX/3NYPxaG30J9uYv
 F0gX2NwKKFoGd8oNaTUlcTcG8CabvrsHwFdHfQPrmioJ1zVZVjwoODI6mlALTWdxpn2b
 uBBg==
X-Gm-Message-State: AOJu0YzgBVi4JPINnWiImM0X3lQ1f/c6sSSVpXdrmlOQHm6MEUzVLgiW
 tX2a/f0rmuL9YrhWue6a9ZazXy98Nwyq8BCI3o3RUiQWGXxb3Yw6MohvrUMhtp6LevRsrM45/82
 RRElXIS5xTLDD0E9x9s8S/2x863MAI8o+qFjiD4BjFGhKdN8q7u+A
X-Gm-Gg: ASbGncuUH02SSG/HTtuSmu5WHwCKaMtZTlUWYHuk+xaPGoUHgKzQicvBMbt4PJHVCuQ
 SzdZPNppwHdYdpS4JR3O+sNllV4nMu03HpE1VeyBHtNJjMwaxjwAozYPnJX0rECY0QPEjLpOFBv
 3Y93apKnv6/29d+04coDsp7xXIVOHz2HMy4ktCjz77xZ4w
X-Google-Smtp-Source: AGHT+IG6b8Q94+N3QYRFmIoa8JBD7Xl2Mo2qznvMNRwnS6sXzKQIx1hUN7zfTrpbprzvN51Q0BQMPNKtLBVVPHixd6k=
X-Received: by 2002:a05:690c:48c1:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-7176ca2b219mr106536697b3.14.1751882448940; Mon, 07 Jul 2025
 03:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250707095550.2049280-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250707095550.2049280-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 11:00:37 +0100
X-Gm-Features: Ac12FXwEHmXrce8Ji2bWtHYafzkoJW8rJwASOPqB4k4VtPOa6JiwlSDaaVL5BpA
Message-ID: <CAFEAcA-FX2gW49=1gNiE+9+P128EJzcYPWhM=TxjiQyM7Ts-tw@mail.gmail.com>
Subject: Re: [PATCH] tpm: "qemu -tpmdev help" should return success
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, yanqzhan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 7 Jul 2025 at 10:57, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Like other "-foo help" CLI, the qemu process should return 0 for
> "-tpmdev help".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  system/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/tpm.c b/system/tpm.c
> index 8df0f6e72b..5f12a62c4a 100644
> --- a/system/tpm.c
> +++ b/system/tpm.c
> @@ -181,7 +181,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const c=
har *optstr)
>
>      if (!strcmp(optstr, "help")) {

We have an is_help_option() utility function for this, incidentally.

>          tpm_display_backend_drivers();
> -        return -1;
> +        exit(EXIT_SUCCESS);
>      }
>      opts =3D qemu_opts_parse_noisily(opts_list, optstr, true);
>      if (!opts) {
> --
> 2.50.0

thanks
-- PMM

