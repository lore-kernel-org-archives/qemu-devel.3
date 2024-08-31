Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8941ECA101B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skCHa-0004N4-0k; Fri, 30 Aug 2024 20:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCHY-0004Lq-FK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:48:00 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCHW-0001Ve-Pu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:48:00 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5334491702cso880e87.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725065277; x=1725670077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vP/y1ZMerDHp4COn4HnK7u+HklpE6UWJtRFaARIpN94=;
 b=MP5Z5twq0Ye9uzatDa/Qi545DTalF16Pd5P7i5ucYAjkVyWmAIKZsfqSPFceO1htQx
 g80Njt6zxoN94AWlEcgtvjC7Cq3rhlKMYf7ME/poyjVTkUGTFVDncrxf7tA0grZuBjzD
 h5aANywjqNC/y8ejUmp2mqu+ls5rWk4stWK5pRroox+S+oAQEv5mxwxL5P+p1GhKEUfU
 ynPh6Rrw/emJaUAMb5cQBjbqjO2i8fA57LbM5CL8EirR4REyu4wEZIa9n87znmWfhgJF
 dgedljIr0Y9deTTLWJeSnAefLGqLEwa6Yg3fW1OaZLWafmq5KSAg5hbD7byHX/utw752
 g3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725065277; x=1725670077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vP/y1ZMerDHp4COn4HnK7u+HklpE6UWJtRFaARIpN94=;
 b=XE+XhcADewN/dPcRVGq7epjBMyR5yl+w3ZZQxXzp/heqnde8cY5tFH+82R47JNlykz
 hzBf3Wv528LxevYy7z1A4jYsbhevQhyWHWY2kSq68eaLJbamuR5OLPtX4+l2wOM3hYhO
 cpUkG+M02+LTGCNuNQRBsUnXhI3rSHDjl2Le2SpiRH8DY+2qa8sniY8IwoUXh3ZGqRmG
 CUl1iHO43uyAiSd2IuBH+IileRNnrVVyzYeal2/A3pJh1u3rr5aIiVkc2wkg3Oiyn1Si
 b/skXWiu37jzd1L1/YJ0/CHlb3pJnsloOpfXG13g4HFL5kwP+c6bLdi49H0WXxJ5n2ey
 qfEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWluuAH9b2vbClN2Ry+QMrn6JFyHny7FH1vjEytt7U0dzEBzHq7sUVC95zGWDXXfZXlYJRSNhHEeRb5@nongnu.org
X-Gm-Message-State: AOJu0YxxckSgsR52KCYgmX4XFs0PN0haiUqPI36T6sEhPpI2hfn+92Un
 GhO+g4bcdO01z15T2Dsr/QJRmEIKr7+4XTicdTqBOenltMTTZ2pEWa7G4Ldy9DVIcUPAMpzsvl2
 LYxLv1rbe2B/vwgqumCoccsVD/gw5FDd3LKqUcescw07GNEZv1tlb
X-Google-Smtp-Source: AGHT+IFBQOVudzY5te1z1A/EapuNJn0WVp6mrmIYa7Q2x+ZDYN0QKBNOJc/Ka6aPcKIOHISVtuzxlQ1Ar3eiIweC9NY=
X-Received: by 2002:a05:600c:1da5:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-42c7877149cmr280745e9.7.1725064969190; Fri, 30 Aug 2024
 17:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:42:38 -0700
Message-ID: <CAGWr4cQkygq2cLO5ZzKMb_6VuY8kUZXbb7_HjCabVNikwjT0CA@mail.gmail.com>
Subject: Re: [PATCH 7/9] fifo8: add fifo8_peek_buf() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=tavip@google.com; helo=mail-lf1-x12a.google.com
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
> This is a wrapper function around fifo8_peekpop_buf() that allows the cal=
ler to
> peek into FIFO, including handling the case where there is a wraparound o=
f the
> internal FIFO buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  include/qemu/fifo8.h | 14 ++++++++++++++
>  util/fifo8.c         |  5 +++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index d1d06754d8..d09984b146 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -76,6 +76,20 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>   */
>  uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
>
> +/**
> + * fifo8_peek_buf:
> + * @fifo: FIFO to read from
> + * @dest: the buffer to write the data into (can be NULL)
> + * @destlen: size of @dest and maximum number of bytes to peek
> + *
> + * Peek a number of elements from the FIFO up to a maximum of @destlen.
> + * The peeked data is copied into the @dest buffer.
> + * Care is taken when the data wraps around in the ring buffer.
> + *
> + * Returns: number of bytes peeked.
> + */
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
> +
>  /**
>   * fifo8_pop_bufptr:
>   * @fifo: FIFO to pop from
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 1031ffbe7e..a8f5cea158 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -140,6 +140,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, u=
int32_t destlen)
>      return fifo8_peekpop_buf(fifo, dest, destlen, true);
>  }
>
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    return fifo8_peekpop_buf(fifo, dest, destlen, false);
> +}
> +
>  void fifo8_drop(Fifo8 *fifo, uint32_t len)
>  {
>      len -=3D fifo8_pop_buf(fifo, NULL, len);
> --
> 2.39.2
>

