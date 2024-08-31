Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC9DCA101A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skBmh-0001vf-OS; Fri, 30 Aug 2024 20:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBmf-0001uI-8D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:16:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBmd-00079g-Gd
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:16:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427fc9834deso10895e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725063362; x=1725668162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRxwiv0b40VbANL9zSJFwiidNctibl2gRv8yM752zHA=;
 b=GMOP2SQrj8FJIC68SBZ1AMHJKNsQ/1hkb6l+a+CV76DAyk+F/nsL2pJSncd1mK0Qj2
 Um5mOmvmdIM7azcpd1SKPEWEc3kAoKj3A01PrcEjgJIWinndHXeUWMTv5a6mwVjtJ3DG
 wnC1Sa7wY8Hc0XO5EeTxclKzA7ob8QvR54SBoxrrWXdHqjECRgYGGsrmfEJTviosaIxG
 j2GJEXPvq8ekvbU81EHAJF+14ZEM011Ygn3QEzd+0onpaquWPeAP4HGn1LLfKPs3vMMb
 66Ya8OsBDhc+CQecI0akuVQAwxeVWTCP4CcuLGim1i/fcyHU2f6mYUWpcXzB40VLIdhP
 2TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725063362; x=1725668162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRxwiv0b40VbANL9zSJFwiidNctibl2gRv8yM752zHA=;
 b=Puxq7kf7pLTyUAARGCV01l18+mwYyUV4mmcvW9V/O+bhu6GzZLZGI7NcBZEXzLQJzu
 QxG+jOSe7LlxLvqr/q66zo97BGpmlrqNv1xWSi5ma0sD3UDicMN5KNdiyB6mLsabeaHu
 8HiQD75+TqoeGBDOyJ9UBcbGZB2Q2oIIxmT4zWFddzR6bXCKokSq6Ui6gsMyIwzwcJC2
 JSm5SmR0DIhmfYFECduVin12rAxdcdf9E5aEZI1Uj//RCxT2t98eOOMGcnvhMIA8TXWb
 Ms2xw18SMOixgg0PtmfQDZo4nGf8CZ+WP6P2fRuoJ1XShxft8L2C6+JduQqPiCyRblau
 54Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYOeS6OIhUReoJFqeyt15+UACw6toED1WnqpZOPpG3GuKzxcq9XEyf0kut0es5KfMTpQMUl3ZpEz7A@nongnu.org
X-Gm-Message-State: AOJu0YyEP7iu9ZIOD37eBcu6/ewZVrVUtA0iDXraXT54iU/G0ooAdg35
 MpqdkwGSec5wFFBe+I0edgQNCDjEqXVt0IZYP9VgzBw6HAAR3m2rtlN0Utm8AmIIGD9uuwC17bI
 P1U3F7bzy6TH8rjvfjb2u5c3D6VGKYDI10yjZSJ5UFcOvd2sgqy/o
X-Google-Smtp-Source: AGHT+IGKf2RefHTXFeAGfGhn8O2oKHXcpvPaD6hReia83TB6jW1pJ/c9zaMocOtLVR0pVgcJDsd0XEauyCDB0byi/VA=
X-Received: by 2002:a05:600c:4e4b:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-42c29f28bd5mr532805e9.0.1725063361634; Fri, 30 Aug 2024
 17:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:15:50 -0700
Message-ID: <CAGWr4cRgRpWd_-SBTzAXua3er4+ZgjOo7f6YrAwWOkohvrjCKw@mail.gmail.com>
Subject: Re: [PATCH 4/9] fifo8: replace fifo8_pop_bufptr() with
 fifo8_peekpop_bufptr() in fifo8_pop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=tavip@google.com; helo=mail-wm1-x335.google.com
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
> The upcoming peek functionality will require passing a non-zero value to
> fifo8_peekpop_bufptr().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  util/fifo8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 62d6430b05..efe0117b1f 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -116,7 +116,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, ui=
nt32_t destlen)
>      }
>
>      len =3D destlen;
> -    buf =3D fifo8_pop_bufptr(fifo, len, &n1);
> +    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
>      if (dest) {
>          memcpy(dest, buf, n1);
>      }
> @@ -125,7 +125,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, ui=
nt32_t destlen)
>      len -=3D n1;
>      len =3D MIN(len, fifo8_num_used(fifo));
>      if (len) {
> -        buf =3D fifo8_pop_bufptr(fifo, len, &n2);
> +        buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
>          if (dest) {
>              memcpy(&dest[n1], buf, n2);
>          }
> --
> 2.39.2
>

