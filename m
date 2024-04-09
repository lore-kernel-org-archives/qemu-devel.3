Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91773C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBuV-0003Su-Mp; Tue, 09 Apr 2024 09:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBuI-0003Qc-6h
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:53:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBuF-0003Dg-Sb
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:53:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso7866123a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670778; x=1713275578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAv/jBboVXVGqv1Qr5gynsYiRrvU4aNmMVGB5m6bYL0=;
 b=fUHQ3IA2Ey4Ln4aKZ+uQojVIz3bQSIiZHRDS9GPJkSTGxdHweMLInRaA1kyH3px7Vz
 +G8KXcKuyr3dmXeRrABE7fj0zWwmUF1wvXHDKJtjMzrWEakI/QmjSCjZ1YDPPpM+vNeV
 dx4dr2VH/feIZ0baBwzfS+1pqtZ0QGAcasQH+SCvS9BWdFUUcWHORbmQM/j0H3W5WR1J
 YA0GoIL7qRmeY1GSj5QpwCyzhGXFCjrSzhqbZx2JlhS+d23c70UXd5lfkfADRWcKmDEl
 Dg/9DegfOe/guAS6bG8VfLXP/4WJIe007/w8CC3PZuhfSJ7iivM2l03nXOFCChviJ86u
 Rn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670778; x=1713275578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAv/jBboVXVGqv1Qr5gynsYiRrvU4aNmMVGB5m6bYL0=;
 b=EPHUV+YRCbY3fFtzrumq/abdMY6Vj06W+TjxLJqDq5denOozFgZK4l+r1mfWb/FxBO
 g3Lz4XcP/GbLmLChpvqxArSK9VO5MOQkA/JZ5zdki26z0zycM3UmtecKw5OOyWMSZmy1
 1hf9owzdFyXPSJ2+gt5FODCbC0I3AQhhyuhhy6l1koBXWNgdyZi99JVzpZcdG/SzAxye
 M/vECsCDJTCGN75deIRRAZg9FauMPjiChoP4YazYy4tjGS3faL5eUX6dsCkM4msTsx16
 xXLeI7ucOeXb07PserqfTcw4qxMvL3yvWM9o6XG1DM0JHs/HikDVvCXeoenldz1eMvza
 iluw==
X-Gm-Message-State: AOJu0YyG2sFYlWpBFfhf9zvYVjUJWg3Ar4KY/BSaFR/hIHRXw8XZGXhS
 7c6OLVU6R9NeVwzihzJef7V0xWxOwXC+nkmh+0dAAwZhhKrFAkDVuTIwBtoXNRVsFsYUvZzbqnm
 pkKPo6LAA/NgURxM65mGALxQgrH7ovKuQb3hNDQ==
X-Google-Smtp-Source: AGHT+IGZKcke2BFqOOel64tvmKGGJecPnKn9a/9ZBYNWzALFwB3LoxzGq/LFK7EVFlsKXFBNeNgZbr8Og3KDCcQJpP8=
X-Received: by 2002:a50:8a81:0:b0:56d:fca8:d209 with SMTP id
 j1-20020a508a81000000b0056dfca8d209mr8784536edj.10.1712670778057; Tue, 09 Apr
 2024 06:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-6-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:52:47 +0100
Message-ID: <CAFEAcA8BWKHzLnkRDx313WA+pkX7+cV36retiVdBGmH_ZfONxQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 05/11] hw/net/lan9118: Add definitions for FIFO
 allocated sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Add definitions for the TX_FIF_SZ=3D5 case, per TABLE 5-3
> "VALID TX/RX FIFO ALLOCATIONS".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/net/lan9118.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index a6a869de32..00409927fe 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -158,6 +158,17 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } whi=
le (0)
>   */
>  #define MIL_TXFIFO_SIZE         2048
>
> +/*
> + * TX and RX FIFO space is configurable through the TX FIFO Size (TX_FIF=
_SZ)
> + * field in the hardware configuration (CSR HW_CFG) register. These are =
the
> + * default configuration settings for TX_FIF_SZ =3D 5
> + * (see TABLE 5-3: VALID TX/RX FIFO ALLOCATIONS).
> + */
> +#define TX_DATA_FIFO_BYTES      4608    /* 1152 words */
> +#define TX_STATUS_FIFO_BYTES    512     /* 128 words */
> +#define RX_DATA_FIFO_BYTES      10560   /* 2640 words */
> +#define RX_STATUS_FIFO_BYTES    704     /* 176 words */

We could make these do the actual calculations, rather
than hardcoding the results:

#define TX_STATUS_FIFO_BYTES 512
#define TX_TOTAL_FIFO_BYTES(TX_FIF_SZ) (1024 * (TX_FIF_SZ))
#define RX_TOTAL_FIFO_BYTES(TX_FIF_SZ) (16384 - TX_TOTAL_FIFO_BYTES(TX_FIF_=
SZ))
#define TX_DATA_FIFO_BYTES(TX_FIF_SZ) (TX_TOTAL_FIFO_BYTES(TX_FIF_SZ)
- TX_STATUS_FIFO_BYTES)
#define RX_STATUS_FIFO_BYTES (RX_TOTAL_FIFO_BYTES(TX_FIF_SZ) >> 4)
#define RX_DATA_FIFO_BYTES(TX_FIF_SZ) \
    (RX_TOTAL_FIFO_BYTES(TX_FIF_SZ) - RX_STATUS_FIFO_BYTES(TX_FIF_SZ))

thanks
-- PMM

