Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA8CCA101A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skCEE-00005u-MO; Fri, 30 Aug 2024 20:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCEC-0008WL-Ks
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:44:32 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCEB-00018I-4t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:44:32 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c2460e885dso1534a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725065069; x=1725669869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyIg6xumofS8yWOcMOMK9lSXf7/ULQbvQz2KFAKY7ro=;
 b=j+3RhPCfv61Z9VBrPXkr8rNpQzuk8y5J72MlilY4+Rx+TXSjZahjoQI+zNfSX6YwLy
 yuGyGuqyqvcz0uvCZ009ZlgdJfhrf/fxSC7Qy7L8sJXlEHGJNvA21eyP9zEfDQAeKfAL
 kpmttG1psvn2ApVRCr8+1KG5xptN7my829wEOS9qXp4LDrqB9i3wKjS44pWgo014+yZV
 1+25lciG5b6+aVubUTiHOOEDsVvqud7CxSEs9HLtb97ZgT9nlamxBBGtYP8GDI3LJaYz
 eKDjGXioVPrcsoTAB33nbVcmgYZnuOxuGikXaiV3Th27sIrRB7PmR0pLAMZwcG8vH60M
 Lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725065069; x=1725669869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyIg6xumofS8yWOcMOMK9lSXf7/ULQbvQz2KFAKY7ro=;
 b=PE+9ZgBYrAdYCaAe/r7PZ7wnLbQG/sO0o9shSkDfNpfM+7oNvepKEs3PtgHCoh6kd2
 cFXrZ7folnwOPd7Dto7l/0Whnm9X86bacGWhzkRPCzjAmKr6+Wgo+P0FDUeStb0AehSL
 MZ3qgNsiR+g/ijrrg8WVj+QetZH0I4/BP8vA2URnc/bCyy/kmXL4eOWt0G8SndEtWpdf
 8poujzTehVqtfl70rQZhRtfn1o2Jg/M2iesMH746kEw1S1Qs2j4lzy5L/Pyz/wYx9g8u
 A2lAdEQY148lYrftymm8CbT/gAxolgOn+4c50lYHogf9Y172MXdYB3lqYR92kfsNtUA5
 hf7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA3HtrdXYEmcLYVr6CrGrOyW5tX/Vt3/M2UWYvCTzemwmAeauMj6xlwDWmTkBhhTECTUkCijHNvPlj@nongnu.org
X-Gm-Message-State: AOJu0Ywnw2gwM7QbY0WXeZ5JO9k3LrXtYa8F8GYVhL2XpYI+5sGAl7wZ
 4/UI5gtSzGG38nJIQbMR2qvDIyrhJ928ZRnDvitW7WNv5EpuAcvKlkDE28ojdLYJjbvkqQ2oMl+
 qScLZbwtMKvFi+zI7pvM25soVEUkJMGeIYT0U
X-Google-Smtp-Source: AGHT+IG6ikeL+Ynstw3GxLxdLN4vVjZ0dKokB408bgzF7yyYat+gvFnKbm4Uz8Nq0NalMxVGIBUG4mBaSt4gH3cyFJQ=
X-Received: by 2002:a05:6402:3546:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5c2443f5bd1mr64807a12.4.1725065069237; Fri, 30 Aug 2024
 17:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:44:18 -0700
Message-ID: <CAGWr4cTNcTqxHHY5yTxhWVp4F3VGnmKiyRz4FFoeAz525YBEtg@mail.gmail.com>
Subject: Re: [PATCH 8/9] fifo8: introduce fifo8_peek() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=tavip@google.com; helo=mail-ed1-x52a.google.com
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
> This allows uses to peek the byte at the current head of the FIFO.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  include/qemu/fifo8.h | 11 +++++++++++
>  util/fifo8.c         |  6 ++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index d09984b146..4f768d4ee3 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -62,6 +62,17 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, =
uint32_t num);
>   */
>  uint8_t fifo8_pop(Fifo8 *fifo);
>
> +/**
> + * fifo8_peek:
> + * @fifo: fifo to peek from
> + *
> + * Peek the data byte at the current head of the FIFO. Clients are respo=
nsible
> + * for checking for emptyness using fifo8_is_empty().
> + *
> + * Returns: The peeked data byte.
> + */
> +uint8_t fifo8_peek(Fifo8 *fifo);
> +
>  /**
>   * fifo8_pop_buf:
>   * @fifo: FIFO to pop from
> diff --git a/util/fifo8.c b/util/fifo8.c
> index a8f5cea158..a26da66ad2 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -71,6 +71,12 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>      return ret;
>  }
>
> +uint8_t fifo8_peek(Fifo8 *fifo)
> +{
> +    assert(fifo->num > 0);
> +    return fifo->data[fifo->head];
> +}
> +
>  static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
>                                             uint32_t skip, uint32_t *nump=
tr,
>                                             bool do_pop)
> --
> 2.39.2
>

