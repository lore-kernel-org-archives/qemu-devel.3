Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07628C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjovN-0007Qg-Oh; Thu, 29 Aug 2024 19:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjovM-0007Lp-Aj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:51:32 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjovK-0005F7-Op
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:51:32 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-498d7c77e91so402397137.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975489; x=1725580289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iuk5t4qrIc+zl+VzKdAEiFQUEF6NQp571dc4g0kiqo=;
 b=RTm7IaGOpqdO4FRtlQeUWLsVg2S9sFgicZ2tUD5Awiuc/deelNh/ZBwKCtpD9fh3uD
 7eV8MrcTPUneL2cfm1WqgDFtYr5/Jjh1jNcLiyj3/jhZs9vmy+QMUuEc2eh5D9yJ1Z94
 Agr1VPpRdgOM4juyggDM8xEHkd3W+qjhBFIFRdNe8K197DIjLkQTk/02IYy2MMTkCbc8
 dE/pxySeBErDIedZ26KWuEg1M2rdSd5qkXYBySN/XeLkmSKseGsQ/bNaigKdABQMtyqN
 dw97ZyOjfYDpb0Ney/KyFj7ROUEd1UbzYZa7Q1GmnDYavHyOU8YrQ2rQmZXenTMnfQjt
 kcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975489; x=1725580289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iuk5t4qrIc+zl+VzKdAEiFQUEF6NQp571dc4g0kiqo=;
 b=eWPr2dzQ8qJm3vSl13qJ6aFxYyOTiQXdX0mik0bfi/JJIN2Z6rJ+Q9l1EnL1y6m6Rq
 JJBxk6uYvj8O46qaqiyM9dHAe7rHcqC//O02XnA/PdTxI5x2XpNvq2kG0HvWgB/igOZq
 xy0iJ1qFfygaSo7gC2OLJGz0bpUMQnhvLPbQLJuo+ygBHuHkwxDJnO4+rFhI0vZQ2rpn
 E7ghNyDJElkL0G+aNhIF/hlj1/wbHPJpocSp3bAYvkZ7Kkappx9gWgGdpo4/A7B0YiHO
 OUlv4FXBFfsBo0KrcRo1BCaD6SdWyf8rV6BZIItcRLUELCjGRdjERcxnffXhgYxR7JyQ
 OnJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWakXOaXl92U3ei20+ZsbuOBmGniBqQNyD6CUzAD9wcg1snCpxg0NWOd330nYaOlicKTZgPJxEtAigg@nongnu.org
X-Gm-Message-State: AOJu0Ywgq9iVW4Vah1V8vPKTi4MGIWU0Ns83axrZZzmwEVz/siTVBUIV
 T1eLNNy9cclon0+b5mDJeJ8SnC0RnK1YzzKqTvpC9bEOC2I0Ktg1qynZ+1/xGztu62P1Qh/mJpm
 a3mbiIrRoEE4B9gXgIdG+2UODO9fQ3Q==
X-Google-Smtp-Source: AGHT+IGTpZ7gZfK12VX5jfCSPkhmGq5/p70H2ZHWq9Z4+WbstwVex5Q7kr59KmOIDRYJe1AzbxRZkXDuZPkHL0RrR4w=
X-Received: by 2002:a05:6102:3e92:b0:498:c4e5:bc4f with SMTP id
 ada2fe7eead31-49a5ae74dccmr6085451137.17.1724975489512; Thu, 29 Aug 2024
 16:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:51:03 +1000
Message-ID: <CAKmqyKNB9i45cMawnZdni4Z1oJYWBcqL-PSJxvcBO4v4=7FFeA@mail.gmail.com>
Subject: Re: [PATCH 3/9] fifo8: add skip parameter to fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Aug 28, 2024 at 10:24=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The skip parameter specifies the number of bytes to be skipped from the c=
urrent
> FIFO head before the peek or pop operation.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/fifo8.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 5faa814a6e..62d6430b05 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -72,18 +72,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>  }
>
>  static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
> -                                           uint32_t *numptr, bool do_pop=
)
> +                                           uint32_t skip, uint32_t *nump=
tr,
> +                                           bool do_pop)
>  {
>      uint8_t *ret;
>      uint32_t num, head;
>
>      assert(max > 0 && max <=3D fifo->num);
> -    head =3D fifo->head;
> +    assert(skip <=3D fifo->num);
> +    head =3D (fifo->head + skip) % fifo->capacity;
>      num =3D MIN(fifo->capacity - head, max);
>      ret =3D &fifo->data[head];
>
>      if (do_pop) {
> -        fifo->head +=3D num;
> +        fifo->head =3D head + num;
>          fifo->head %=3D fifo->capacity;
>          fifo->num -=3D num;
>      }
> @@ -95,12 +97,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fif=
o, uint32_t max,
>
>  const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *nu=
mptr)
>  {
> -    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
> +    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, false);
>  }
>
>  const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *num=
ptr)
>  {
> -    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
> +    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
>  }
>
>  uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> --
> 2.39.2
>
>

