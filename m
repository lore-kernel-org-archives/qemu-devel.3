Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 04:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roypP-0002Fq-13; Tue, 26 Mar 2024 00:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1roypM-0002FO-Mf; Tue, 26 Mar 2024 00:54:24 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1roypJ-0000tN-Cu; Tue, 26 Mar 2024 00:54:24 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4d44216ea59so1742710e0c.2; 
 Mon, 25 Mar 2024 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711428859; x=1712033659; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOEvSzzaFpPm6kSZsVuroxblQgv56KqmmLkwoyeaY00=;
 b=mZDubjUfLpGcRCOFC0h0dydFe35sdVre2SoSDwxarBW9RI4JAchqy8u9fmONliStJv
 9sUGCrvXTIeHcvIsCVFhht1s7wKwx6c13Gbeavig3uGjlyyfQogDN7XFFRjOdCTqlDyM
 U32L9ovZ6E+z09mn6iPrnH/sh3y22dfMJzOd0mdjZQXarnq9N1N59tqYdT4bvhRoi2Op
 CqJKkiIq8LfJr2jLOav8gWjs2DPrHyylQ6qyt+0sJxHRlrHEZNTKrdSwbKUFPFMyryf2
 ae5n0v5KF947zHB1Tnsd6Sc0Mb6WCKMwUH3Arw73u46s7DcmrVW5OBuhHveWcqsBzq2z
 S9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711428859; x=1712033659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOEvSzzaFpPm6kSZsVuroxblQgv56KqmmLkwoyeaY00=;
 b=VGhA1Iia6DGQheYnO0onfwQN8J7S5HugcWVUFJ1V6ZMxenDfdMcko/f5AaDqex7Rth
 p4v/ME+tj3OfCuskJFU25eTTbG9haq3NzqBPI5CDqsiEhpkef5GuZcJvK7kIO8fTC4aK
 O4yI9aCJhS7vH5z4p+wAgzJR471x1MQK86sGER0dIQ1xhdi3PTmN4AzkSM/TfV/a2zRT
 Ncy3c4sErVcaaY1LaRvI8UcWn1tkAjAFgyGO8QgrK7H2931kwSpkv8pYSfv28rzCxopE
 8Bo92n5HP9piOb/buJgcBFmLYnXiwqmLKvyGk6sL9pFytE/rmzH6MG6PzJbVOH0U5olD
 0J0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+AdJKPl8WaMV2Gabdt6WwEFYoAdE68Tq8+tkAfBIaal4oK02dqDMMGiC0MSykvEIPeB/PO6THGl1NraEvUl2r3maP
X-Gm-Message-State: AOJu0YwNnnMrV1knqjckJfjme8lK68LAkVvKGRVaqdzsx8hKFVtnW0bX
 hF3vFiweeTL/9ZK2OzzVQ+TiAt84c7IA892W7IcF6LB0HUOIRXmgPkBjcr9CSkCSxDWVwoOdu8V
 /rCwzS9y0PdUoeSgeQkNf/Ly9za9HlPrz8ps=
X-Google-Smtp-Source: AGHT+IGscCB0yez7KmunAcyB3NYIKL+RRGnFxEQB8hLTBOq4Wl7duamsbH/fomWOxWRBHEYWADLVFAQT6RGoqsTQHAw=
X-Received: by 2002:a05:6122:1d02:b0:4d8:79c1:2a21 with SMTP id
 gc2-20020a0561221d0200b004d879c12a21mr7085156vkb.7.1711428859464; Mon, 25 Mar
 2024 21:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240325152827.73817-1-philmd@linaro.org>
 <20240325152827.73817-3-philmd@linaro.org>
In-Reply-To: <20240325152827.73817-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Mar 2024 14:53:53 +1000
Message-ID: <CAKmqyKPtYmO91rmPQUgCibxtGAPq2yZPKJsq1n-1dq5hC+XT0g@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v3 2/3] hw/misc/stm32l4x5_rcc: Inline
 clock_update() in clock_mux_update()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Mar 26, 2024 at 1:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Trivial inlining in preliminary patch to make the next
> one easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/stm32l4x5_rcc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index bc2d63528b..49b90afdf0 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -48,6 +48,8 @@ static void clock_mux_update(RccClockMuxState *mux, boo=
l bypass_source)
>      uint64_t src_freq;
>      Clock *current_source =3D mux->srcs[mux->src];
>      uint32_t freq_multiplier =3D 0;
> +    bool clk_changed =3D false;
> +
>      /*
>       * To avoid rounding errors, we use the clock period instead of the
>       * frequency.
> @@ -60,7 +62,10 @@ static void clock_mux_update(RccClockMuxState *mux, bo=
ol bypass_source)
>      }
>
>      clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
> -    clock_update(mux->out, clock_get(current_source));
> +    clk_changed |=3D clock_set(mux->out, clock_get(current_source));
> +    if (clk_changed) {
> +        clock_propagate(mux->out);
> +    }
>
>      src_freq =3D clock_get_hz(current_source);
>      /* TODO: can we simply detect if the config changed so that we reduc=
e log spam ? */
> --
> 2.41.0
>
>

