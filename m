Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B0CA100A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skBoc-000668-W6; Fri, 30 Aug 2024 20:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBoa-00064u-W6
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:18:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBoY-0007ED-TV
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:18:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c2443b2581so2493a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725063480; x=1725668280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFGmnYrOvZoxdjakkZLS/DUQL0szOmYt/eey9k0HTEQ=;
 b=jzz1IMssEVRuAuIa+p396GOKfEZOsYXrn4Jx52xDkZTEX5iEYKIt2JruQ2JhODO0bb
 gJtviPoOdbPKzQduQ2n9P96PrmT5dDE8H9XsdcQKoD0WxEHHMU6aR80QM+JXk84jE/Tw
 GdphAoxLd8gqKPP5pfxHPgT7N32OKcqq9FhGVyT15kV9rPJePQtI4qA+zNzB824/q9aP
 uZN3Bt0ONyz/DTuMLnoq5jedI+FA/Dh33sGqnW3ELYXzxVhKJ9shp3DoJdM4Bw2wUnha
 JewHC3mqp3UMP4H70deUEyHOotv61oKij5ff2RdFKPRnoeDzvOazA4BltW1uEbG6iS2a
 o/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725063480; x=1725668280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFGmnYrOvZoxdjakkZLS/DUQL0szOmYt/eey9k0HTEQ=;
 b=nG326cDwU3+znHO32tfh0Q9LNqYJUONHd9Ixu3lSjVRD66wbkbzCoSZEoAk+rrcS1U
 y0LfltNX7IX5DpDazSvJ/cQF9nNb/MXpddXBpkNWJVivd8ehZFYqIeEvZbXkFGzdUHSn
 y6DVcPUwEimbEcT4U1IfV0nqQ+N9d/ckg2tKZPz86ZOUb2Y3qoQmga8xIGQFiXrWpfxA
 2fGFsudungm4W9wchp/7viYy97aediRZ1sGu0yU0broV6JYRs5L1ajce0kttFUCWLSeW
 5MDTfWXo6z6AlBrM0r+1qsZQx20lD2fcQTQHcA/ksiXFpPOCJBqra6XKPYso5Q/0kXGt
 KHGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ZyDLymO0/GmgpeV2926BsG6VLqU5BtXPmMMh3CofysqXgFsDzu1mIlgEK+fEPEfvepLHS1FYKkdv@nongnu.org
X-Gm-Message-State: AOJu0Yz/CIfEcOOPPoG+tSjqtufizvRZ1l0w+EoqQk96sBqkyQZ6EwgW
 H2b+JnKtfx/hKmFvnHTnrXwwbQo+v2QJckLYtOq1hK8tWs7KjR+mubSjmm12wwiINBFth+GIoAx
 KFc+Glb+fGRLfORLa8uyBVi9p5GAYCiIQBV5yf2alWRj8O6mRWrjW
X-Google-Smtp-Source: AGHT+IERkS10VbDmsBRbb6nA6Y1K4Us4aYj+4Xsrou6sH+cXthVOi0PqcD9z5eGUAPDBZ6n25zVDMHJiiNYmSCARMy8=
X-Received: by 2002:a05:6402:5252:b0:5c0:c108:fa96 with SMTP id
 4fb4d7f45d1cf-5c245b5915cmr30285a12.1.1725063479517; Fri, 30 Aug 2024
 17:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:17:48 -0700
Message-ID: <CAGWr4cRcCOcY4dqx1MhsZhh3wjizEiK5eQs3OeEJZBLW4naDwA@mail.gmail.com>
Subject: Re: [PATCH 5/9] fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=tavip@google.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 5:23=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The fifo8_pop_buf() function will soon also be used for peek operations, =
so rename
> the function accordingly. Create a new fifo8_pop_buf() wrapper function t=
hat can
> be used by existing callers.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  util/fifo8.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index efe0117b1f..5453cbc1b0 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -105,7 +105,8 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t=
 max, uint32_t *numptr)
>      return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
>  }
>
> -uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t d=
estlen,
> +                                  bool do_pop)
>  {
>      const uint8_t *buf;
>      uint32_t n1, n2 =3D 0;
> @@ -134,6 +135,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, u=
int32_t destlen)
>      return n1 + n2;
>  }
>
> +uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    return fifo8_peekpop_buf(fifo, dest, destlen, true);
> +}
> +
>  void fifo8_drop(Fifo8 *fifo, uint32_t len)
>  {
>      len -=3D fifo8_pop_buf(fifo, NULL, len);
> --
> 2.39.2
>

