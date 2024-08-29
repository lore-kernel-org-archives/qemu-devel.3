Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C53CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjosR-0004cQ-Bi; Thu, 29 Aug 2024 19:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjosP-0004UQ-1a
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:48:29 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjosN-0004nT-Bd
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:48:28 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-498d1e97214so472232137.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975306; x=1725580106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P6iRzUkcp0LIyUJ9qc5jf1cUUFWKqEb0iLDAoUZRes=;
 b=UnVakCo1giwJO5j9fCh5jCZiEotO2Cm6vKPOvBYpO8VK16hOhRi5USYuFM5tTe0dKZ
 7YWQ98eUowbcdat1mZjiMsVupgGgOsQOO97xVpG2kY/jaWp7qkOA75iW/Jh2qw2wqS1P
 OonSHFKznur0vhzGXkiMP0RiIDrpUV4izhdCcF9TqsRpufJ9B6Og3YLTs8wGMr2wG343
 J/cv34q7Epmvt2BQd43y3Q9z6qtj1AfpOzmVWiNQl60Eu1qUzpyj/8yzgVFvT/6xUStA
 w7UdD8iW6ioBJFgNu3wfKp4oqfxsnbJdIPMFAD9t6EuTSqFto8gS58dGvyQKX2yn6BYG
 +ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975306; x=1725580106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1P6iRzUkcp0LIyUJ9qc5jf1cUUFWKqEb0iLDAoUZRes=;
 b=jbo6TGyS5piKYcXOf603AcfxLkoIE+Uh4aMx74m0n2R9UJzYmGAa27M00JijE2nIQ6
 w4vY6y9MnZQIci1gmvHx23+i80xh+HVZKLgqEdqG0/FNNj20uf01w7hmqt9XexjytV13
 xL1//nvanBrfcvaRHOkf7E7lFfpRpvQtf/96wN9RX78FfLnIEYcMJWWL+E6M07qQkgHw
 JYr44LjXTu3fl8GRxSrHuNma//neGLDkHpB1ylw2dnX5tWJJcyk+jTu7fMi4kyHBwNyI
 4fv2P92MD3R7Wz02QmuJuTp+CLQ9Ezw+pPBZnXtHu+2aXXWuiRym7z2HlCsLvY1P0cmL
 lhBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnoW/nbDS1qfTAqifJHfxgUDiAwJFGGIQXAqV5oYUZKrutUsSdMOkEZSLa2qcEgEfYHJKNKd9rsjfv@nongnu.org
X-Gm-Message-State: AOJu0YxxkThPrgb/g/3CkdIyqPWMl8Yvz7xzx7Vj9ZUO8tHaTqWWxDut
 27v4jQwrLoYnodiaU279+qGrhHcRmBpSJl58wM/MG0MBFzccEIlrbpzYVmSQm/uzPdJJllVFQsH
 ijEo6iUECLeLC/1acCae90ICWhPo=
X-Google-Smtp-Source: AGHT+IHTpLyzQkJ/SDohcJTPUOcVcosYwAS8gV26QThvsPaf6fu+VUSm8lmnlA+bs0IOAym8+/G6ToR7qkUQLBBaZz8=
X-Received: by 2002:a05:6102:3050:b0:498:cf81:3a40 with SMTP id
 ada2fe7eead31-49a5ae8a57cmr5695142137.17.1724975305996; Thu, 29 Aug 2024
 16:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:47:59 +1000
Message-ID: <CAKmqyKNL8QZ_WQabDs65hMEXpFH3cHhPrJboJ-4tO_2NdTv6jw@mail.gmail.com>
Subject: Re: [PATCH 2/9] fifo8: introduce head variable for
 fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Wed, Aug 28, 2024 at 10:25=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Rather than operate on fifo->head directly, introduce a new head variable=
 which is
> set to the value of fifo->head and use it instead. This is to allow futur=
e
> adjustment of the head position within the internal FIFO buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/fifo8.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 61bce9d9a0..5faa814a6e 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -75,11 +75,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fif=
o, uint32_t max,
>                                             uint32_t *numptr, bool do_pop=
)
>  {
>      uint8_t *ret;
> -    uint32_t num;
> +    uint32_t num, head;
>
>      assert(max > 0 && max <=3D fifo->num);
> -    num =3D MIN(fifo->capacity - fifo->head, max);
> -    ret =3D &fifo->data[fifo->head];
> +    head =3D fifo->head;
> +    num =3D MIN(fifo->capacity - head, max);
> +    ret =3D &fifo->data[head];
>
>      if (do_pop) {
>          fifo->head +=3D num;
> --
> 2.39.2
>
>

