Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B2C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjp3K-0006lf-PE; Thu, 29 Aug 2024 19:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp3I-0006d0-Mj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:59:44 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp3H-0005lE-5j
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:59:44 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-842fe7187b3so378270241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975982; x=1725580782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdEmML8dQca++rwXiq/7V17cQc8CXZesqmruXrdHq9s=;
 b=bnMUkSdrYpibwrVFxZEEscBe9oNWYjw5Kd7q1HxNOOEnWug/l0ftHJlkkSB6L104W/
 1oQzYtoRtnBapakXKQOMCVq92MAYjwLIQmrN96sXycz/9sa0TK7GAys7tIp8N1TvCP2i
 B1cL8cAJ4n8+PnERRPJXgBC0P5BAiB6ZOI1vTz6CDkgU7nOkIhvSwbzrnuG/kiX6ovR4
 w3uof0vTAuk96FC+qzrBA5+Gw9io/tftFXrOrqdMaFW4FRG4FBbZmKqfqA4N76Kpt04o
 PUrQN3dgX3bzwfZSuhRo+Hn/67c4BS2cX9JRTy546v4CI/nxkR0EDDC3HQW4nxkpiIUy
 jpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975982; x=1725580782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdEmML8dQca++rwXiq/7V17cQc8CXZesqmruXrdHq9s=;
 b=bjRrRmyC7n04zA1TQOj8YOC5iZuGqUsaS/9cq3FFcMowVwg/a3a37u61JXo7IEOKVX
 4p75lYvhlB3rnNzP/0yhL6IP6gmXs5Pk5hCi5+dNOTntebKCHNPoN5Nl9GJlpN4DAAOs
 LeyNNHSBegfafoVEUI9am/THN4EAqTv+mWDj6BtJXRmaskO8cIVTRS1ukVrriKZGiyt8
 +jh1n7F16qeeRm11ScVMwfqQrJHmVJgPY8RFbPUoN+R/oXOii+UK8i1hA9T104stD9Jx
 vmHib+1GS8SjchhLSSj3GsPJjVDGSopBsTubyOLipbm07laMxBxL2VNparSXnJMrXB8m
 Ry5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmU/6E3Ic1nRiSFfB7D4H848uVxT1hEZkKwCg2WSviRVkL/fMoTMuwhwnNZsTHh3TtK/iLTDvaK0oB@nongnu.org
X-Gm-Message-State: AOJu0YxHE8ocydDTtssuBNLAFmh3N4OArvHxB+0dgImlODboV9vQfh09
 SXVLDiTyV3pBOnVhRpfrujwlrTv1pMv1bnKHo3P5oarYLNJNvr9mHj/KIBMNGLh2DWE9lb1PcJS
 KCZbnSuS9lNlIln9wiFLso0HzIV4=
X-Google-Smtp-Source: AGHT+IFeRC7hQydc+oyI1GcDSG+r82DPwcsdj9EZ69ZkUo+M4IM84gF+Uok50E++zuSi65lUeZq37wnalmBB4obAFeQ=
X-Received: by 2002:a05:6122:2a45:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-4fff169e144mr4599723e0c.10.1724975981806; Thu, 29 Aug 2024
 16:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:59:16 +1000
Message-ID: <CAKmqyKMbsArhqcNdUcg95h5Y3BwXFyqbTXcBnpJADM7ac74qTw@mail.gmail.com>
Subject: Re: [PATCH 8/9] fifo8: introduce fifo8_peek() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Wed, Aug 28, 2024 at 10:26=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> This allows uses to peek the byte at the current head of the FIFO.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>

