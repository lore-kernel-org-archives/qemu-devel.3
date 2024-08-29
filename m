Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3FBC87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjorp-0001wk-GD; Thu, 29 Aug 2024 19:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjorn-0001of-M5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:47:51 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjorm-0004hG-0S
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:47:51 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-846bdc20098so7496241.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975266; x=1725580066; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6xFt0V//u3BPnOQ9ZFSxYl6jkcPRCehUOAYOMbVY0o=;
 b=Q58l+BoziKeRg+YiLgnnDjKKH4ZMCAhGAqZcfEUZfOEKa1liFSw/2yms92uJtJejSs
 2EGrmeAg2MGaM/e8kXEf87MWeaT4L1uRqPr3fWmAokbyJcPn7R0245n7b5k4w9GreLCf
 Pxl3fx7O3VnKWp689ULGuYN23WgK8R/XPACgENViKX3jW6IwLr3S7UQH24+DJDOO0Wum
 jvVgueN2oWOSasTFrTQki3j8BRbZid9kDy5aWdx5B8KoT73DXGnamIHOe2RxZjinoJKG
 LDS0fTOQiZE2o6blz0PQRv4zt+8/eUWz+HbwFUbz5tsupc+829mL6pT6w06IWVZXoSMK
 9RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975266; x=1725580066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6xFt0V//u3BPnOQ9ZFSxYl6jkcPRCehUOAYOMbVY0o=;
 b=T3rtOI7Epqod/N9VlHqwMoI32LF2OIg2+nZ83jEFSqCjHwFDRlIONhR2PWiuogq0pQ
 jvG7XG3ETmMrov4tVSKMnbWhlzSH+Shwz9cCSu2vYhLYuHYQqaro+vP6QqYpV5Lo5EwX
 S4Qj7WZlg5HUGQd+MjPHKmyN1rXxFS2/H14L+N9QnKk7Pe6MtT8mfxYv1KnzuoN7KMtf
 P1IwlSAg/H4Odi2VI6jh4oFSLK9kJFrZNd5Oz2Qy+vpDEw7L1ubnMoaafp3WQakmQn3c
 sXahJhC4ZUMk7QMs1jX9GDZNglylE0hwCa3AYryvvIE0yDiAgC3D0UdtqCYT0fueke7q
 OMdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRTW5iBTKJvhEPzkXwiKkooj917KKmFuYsvkeSALm8kWbR+GTjXFuKEdFDyMQli21Q7KO8RDbVpdj7@nongnu.org
X-Gm-Message-State: AOJu0Yyb+Bakgcp0qG75MqzSPO61SYE1Cs5Ry+EF53FiCSttOKHWJzHF
 lHxleS1gsuU4HYiex/4RSfMg2f0VRPcVDEuQwolkvAhDATJ0IVOhf57Pn2c6uFfg5Z+sZisQV+3
 YuxIcO67CMKIM4ei4AbolsaIpIew=
X-Google-Smtp-Source: AGHT+IEYNYzKc7EKKkEqYp1Bf5rx/5GthTNUaHh3vMfFJjgcFm3nWtCFK5n0EXQQhfLLp3bOxC0RIlU7wOUu2JzKQE0=
X-Received: by 2002:a05:6122:3190:b0:4f5:23e4:b7c with SMTP id
 71dfb90a1353d-4ffdc04f272mr4769108e0c.0.1724975266204; Thu, 29 Aug 2024
 16:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:47:20 +1000
Message-ID: <CAKmqyKPg7JaFaNyZtaAcdQHYy-JqdO+QBF5ragY6kC7WdkCU4Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] fifo8: rename fifo8_peekpop_buf() to
 fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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
> This is to emphasise that the function returns a pointer to the internal =
FIFO
> buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>

