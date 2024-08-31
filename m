Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DE1CA101A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skBZh-0005d4-Mh; Fri, 30 Aug 2024 20:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBZf-0005cU-Ok
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:02:39 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBZd-0005mX-SS
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:02:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c247dd0899so197a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725062554; x=1725667354; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3T3zyzHLp8Zzm5fr+JoqxerymJYhri+YWjAL2LBOSM=;
 b=CD882G3vNBABDKPgH9ARtqG0iio6i541veCKn2mx7FbPO4qi7AQhZUNQOn4fpK3S4I
 ZJGS31UuqeP8qPANTa+mjrz2SweyZcKV51XwgSFS/WHsctoIvdMjCEeLMEJntXY2AVfR
 3K7hGxp/J1/X0mNmCk+HtB2MefnvHsC4PALn7GadsARLPXYobwxFGNOi7SXE6DMQUzbv
 xiXM9szuIizJdaeMUZaTVT6lEP8iisqdo111++suqC3/bP8Vd7jHE3+stXwwVL/Fvcgs
 l305ILh+sD5Bi9OzfY6RRxXrg7u8af/c7eIjkRzshrYrBtBwjx1xYaKrVD7dUUoYTT1j
 TzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725062554; x=1725667354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3T3zyzHLp8Zzm5fr+JoqxerymJYhri+YWjAL2LBOSM=;
 b=VuXOu2JkTilBbcT3YxitCZkUa3Z9lVz7bQ3X/zoZ5tR0cP7dTw/Rw8me1jGBZkXFfO
 VrfckTzyg02a1eqsnaFuUZMiJU/MTE7Su/ghVugDV0i6QfpbQ8NoC5/D0RXLYLfzh58V
 uhQuI2vbs93leE+g9gqLcAaodc4sI9tk0/V+ct4vebxVnVihn1xCZY8k88LSYpmolti8
 nHMjXL0sE2YQBBWcFUPA5J0+9gRE0hO1d9nWX9m7y0dYxoPbPw8FRM+mx7NrOZkCq8WV
 2HOk4Xj58vPZfin24QIGDmLcaZfjZV9XG7xMYjjls3QEb+QIlYU6cPi0E413duH6xEbL
 8zMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW80XpnpgKXZNb3jzjBURABycnEZ3w967sHaq0oG0Nt7kAuXgW/mJh1wrm4wj2OF7gib957C1VcqdpG@nongnu.org
X-Gm-Message-State: AOJu0Yz3YZRceYU/VpTXFcgdYPjsVQe3Oz73XFCiQ7ghqZjCAb3MW+dr
 JM4y3GOFJuJMezTFrAkL9GWZarlzk0pJNWHlsAswY4eypRHRWq0XSxjfEy+vliCmZvwDyERPxMw
 xcivOFQ92EPWi0i8cMEkmGpzQFlRInN46YGul
X-Google-Smtp-Source: AGHT+IHmGNQY2jwY+o6oB8w4fQEUWq48Ivcp8A9EYqIbGRvWFVtUJqxctORZoSl/wKeDcksgCNfLPBuOmqSUSh/sWZQ=
X-Received: by 2002:a05:6402:3584:b0:5c0:a8b1:41da with SMTP id
 4fb4d7f45d1cf-5c245b769abmr30577a12.7.1725062554243; Fri, 30 Aug 2024
 17:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:02:23 -0700
Message-ID: <CAGWr4cRPpPJDq8d0aNmhTCZuZvZODzvmB=DO70pzjK4ejRxx-w@mail.gmail.com>
Subject: Re: [PATCH 1/9] fifo8: rename fifo8_peekpop_buf() to
 fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=tavip@google.com; helo=mail-ed1-x529.google.com
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
> This is to emphasise that the function returns a pointer to the internal =
FIFO
> buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  util/fifo8.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 1ffa19d900..61bce9d9a0 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -71,8 +71,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>      return ret;
>  }
>
> -static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
> -                                        uint32_t *numptr, bool do_pop)
> +static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
> +                                           uint32_t *numptr, bool do_pop=
)
>  {
>      uint8_t *ret;
>      uint32_t num;
> @@ -94,12 +94,12 @@ static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, =
uint32_t max,
>
>  const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *nu=
mptr)
>  {
> -    return fifo8_peekpop_buf(fifo, max, numptr, false);
> +    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
>  }
>
>  const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *num=
ptr)
>  {
> -    return fifo8_peekpop_buf(fifo, max, numptr, true);
> +    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
>  }
>
>  uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> --
> 2.39.2
>

