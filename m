Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60182C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjp1p-0008M9-6E; Thu, 29 Aug 2024 19:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp1n-0008Gc-Nk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:58:11 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp1m-0005hC-78
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:58:11 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4fcfcdcb4acso403706e0c.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975889; x=1725580689; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYN7NoXlQx4RzyBQ1IYjVNOdjtTZSX8x9bv6PDEq9pU=;
 b=jspXgo4flEaAAgxeRxo3oFxadCHYlht5QR9nxXcOS16aE/j7GU4f0PAkcNWfi0+CjD
 0SwCx0IWDHGaNW9gJtcL6xakvF38hPiBYYV7/aDIEt9ACiNACKkQmbEHk+dPdX65rfNI
 qgqiGUwXYFGUddxx8R+bRPTOyRzThkDFuee07q7jDYd5IxdbbMEPF1P8QihlaE7mE2Yz
 fvHjFYfy0i2E2+dFEJY7lHfb4HY99aFBHWGCg7TOogo/B15CagpiTIrCf0DtbnhZooRd
 xfohYOMMfL83F42uC+A1btUoK3M8ysgCEV824TZdR7besBTuZhcmdQDe5WUouXxPma6Q
 uy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975889; x=1725580689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYN7NoXlQx4RzyBQ1IYjVNOdjtTZSX8x9bv6PDEq9pU=;
 b=PPwJ0uqKwwTFnbQ7dxUVDvvwCk9zc13cdaTGKDoX0KuFlopfN1IgP+wolEx/4exKQq
 TuqBEpYOck8wdXF8rmyUeD1ippzJqb6CEDrlrdt51O/tqBETqd0b5esgnIWN2mU4Wdvl
 7m6h4uKlkMopK3I897i402jskSFbxOWVwRBcr4ijYYjUFV2V6xVqL28Rwj/dHBej5pUg
 sDpTR0ncgs7zGZw1lXvLx72b9yJi2sk2dULl7EDcRKsf3VNgBnNua9zF2b523P7C6oTP
 xmQKzWg9h1h9XrvOelaBFRkBVpOFfrM8yH/soE8kyfo0yPtodpff0yAr/0Ih+o6uKo6x
 IYoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXo9b4ByILpxEJBKzczFUNvBPMXhjRLymS+zQIz8NckH+6YaFilQ/M+1CDyr11FJig0rW6GaVoJkiM@nongnu.org
X-Gm-Message-State: AOJu0Yy2Wh9S0NpyyDcWHviEgFn8VyKPuQGpQEzsVS3v9pDHS26coQuv
 F/HLM18389duH+XsEN3BecdpofHfTkPfefUs2fpfq1G8PX4BmjN1PlyVpXPRt8F4rF+38GP/E6j
 1CYO2sTfW6cC7bgsQ6BtnCpvBLnA=
X-Google-Smtp-Source: AGHT+IFYS9WiDn+CwM3De86GXc4fcX/ld37WASBTkR5NE70KOVZets39QqBHbyQw+Jnx8DpWPMOXnjQVKzAPRpVsgTQ=
X-Received: by 2002:a05:6122:1782:b0:4fc:e2bf:f5e2 with SMTP id
 71dfb90a1353d-4ffe4bbabfdmr4902314e0c.7.1724975888906; Thu, 29 Aug 2024
 16:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:57:43 +1000
Message-ID: <CAKmqyKNKMK5hj5RGsb8SBTUUu5C2ysUF3SignnNPH=GULDLOxg@mail.gmail.com>
Subject: Re: [PATCH 6/9] fifo8: honour do_pop argument in fifo8_peekpop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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
> Pass the do_pop value from fifo8_peekpop_buf() to fifo8_peekpop_bufptr() =
to
> allow peeks to the FIFO buffer, including adjusting the skip parameter to
> handle the case where the internal FIFO buffer wraps around.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/fifo8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 5453cbc1b0..1031ffbe7e 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -117,7 +117,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_=
t *dest, uint32_t destlen,
>      }
>
>      len =3D destlen;
> -    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
> +    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, do_pop);
>      if (dest) {
>          memcpy(dest, buf, n1);
>      }
> @@ -126,7 +126,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_=
t *dest, uint32_t destlen,
>      len -=3D n1;
>      len =3D MIN(len, fifo8_num_used(fifo));
>      if (len) {
> -        buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
> +        buf =3D fifo8_peekpop_bufptr(fifo, len, do_pop ? 0 : n1, &n2, do=
_pop);
>          if (dest) {
>              memcpy(&dest[n1], buf, n2);
>          }
> --
> 2.39.2
>
>

