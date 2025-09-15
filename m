Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E09CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0CV-0005Rs-F6; Sun, 14 Sep 2025 23:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0CT-0005RI-QJ
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:48:21 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0CL-00015t-Qr
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:48:21 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62f1987d49fso2123490a12.2
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757908090; x=1758512890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iawfd9cFPCW8mpYo62qTBw1pYZplG+hUrXadHwm8/Jk=;
 b=ISltFL94lRhEKGlt1N+mqHcXv3aSoIKoAwkfEDx0HvrDhlD6gsuVIRxizvHjvgMzEd
 Q+TZyVk8X+ezhcgZJa84tiSq2lkwlBiSl23b9WVlPFb50YNT6IbxcDqQSycXCrM727oB
 3Rmd3ja7qSuuV8cn5YtLY4FZEXb4Pkc5Bsu3XvCqE0k/hOOaNJog10ygtiUvLlVOO0Xj
 huKizcWXG8p9/06qtsxR2th/EB8cWXeVltl2LSpx4GmWakJoBi9mdAB/itjfUWUijQxt
 /Dd1ahUrb3gFUPVgynvJ3KbGyYspDB7oGwN37NB5zLkvLd+UjQIS9k/7wedwS6S56dcg
 Np/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757908090; x=1758512890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iawfd9cFPCW8mpYo62qTBw1pYZplG+hUrXadHwm8/Jk=;
 b=DWWcN+vsfSMWfaQA9CnnUPdy0fF5MO3mMzAv4UAhXOM/y2sdDXRuzHUxHvZW00htmM
 U42H7k7Tn2HrEH3LMq3zoUeBy9Onq5KHIa8jIUDER1GSqYJbUS0Qnz9oL+DwpecNPU0o
 fYT5H4861+J5W2TL2PFyBeL4at0UNnOSLVLZ+6Sy7Lzv68tRdyLkEOH3nvhA0nH031gm
 Je3i56r6SQjuMW6l04zGVFKkWCMtGIpRKj1Cl6blAg7rUVDeKAWvzWqS+F8Qb/xcv1ov
 8CrlrmURgrEIoK86Xzxau9dB+EU2+IT8i8QYcvwTxXzLfYcr4683M6mmO2K8Zl88lvUk
 MuMA==
X-Gm-Message-State: AOJu0YzhiAC1i8vCP6Vnd4yXhAm8+Mmpj4kAid1215THrjG0cyOMLXSo
 afMGlu/+IMZPBF9DTB88D8qmdlRxNmlxl1WC8no8WEHSdIj8dum4NKz/sdvAxkKi5wo1NCcPA95
 YghjT7iQw6Qb3MuopDfcqXXw6eJM4qVE=
X-Gm-Gg: ASbGncsLXiwcybx8PtQoWYcIKqVsVqa/Bu65hgfePDUAzuLypJdDqSPsfA59FFoRW68
 DDZnj1DyGo8yztdaGbbihiW0t6IuRA9kxwWE5TKKGeSM2qNAu434RyKpWDIX2dNL4HBZ+vBE786
 KmecnmCiB7+Q3z/8smsScparknHiEpAU8kiPpMdpOy15Wt3F/KhP1KKep5l/O0CcPbOTRdyvzBy
 Fa3ApbcqFsar66R+/jYeAkZptMMXNRUbyO4X+BSUHh8+Q7q
X-Google-Smtp-Source: AGHT+IFwrHQMYf/I0cAmyhYk/NejqlzGBrAOhmSCSC2FXcA885daPoBXMOfLmrJ5oCT2ZotuKvUCX0dkkLRNuWYKElw=
X-Received: by 2002:a17:907:60d0:b0:b04:48c5:340 with SMTP id
 a640c23a62f3a-b07c354e86bmr960698666b.9.1757908090312; Sun, 14 Sep 2025
 20:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250911160647.5710-1-frank.chang@sifive.com>
 <20250911160647.5710-5-frank.chang@sifive.com>
In-Reply-To: <20250911160647.5710-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:47:44 +1000
X-Gm-Features: Ac12FXy6qX06_lr3WkZYXdOllkrLISFzTr2288WUN8ArS1i78BLMQPrg3OISfQ8
Message-ID: <CAKmqyKNMMH8KtJZEM+Ji8Cm6J_NQYtEHdwZnga3yfb2y3H6g1g@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/char: sifive_uart: Add newline to error message
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 12, 2025 at 2:08=E2=80=AFAM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Adds a missing newline character to the error message.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index baef0bd9c28..e7357d585a1 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -113,7 +113,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState=
 *s, const uint8_t *buf,
>
>      if (size > fifo8_num_free(&s->tx_fifo)) {
>          size =3D fifo8_num_free(&s->tx_fifo);
> -        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
> +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n=
");
>      }
>
>      if (size > 0) {
> --
> 2.49.0
>
>

