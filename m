Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EE6CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 04:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0Z7-0003jE-0O; Mon, 15 Sep 2025 00:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0Vw-0002uw-SW
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:08:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0VY-0003Xj-AF
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:08:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b0e7bc49263so96067866b.1
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757909278; x=1758514078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7hRccTaisOnLlGXWrSjseXeJrY/CW00mlm9v4LgCgM=;
 b=PcPKhR4hPI0hFEpY2xSMSQM8+S4/LMmBItcTkUk+LOm1eLmigoZnqlavKKk/hntEg5
 2hjBsJbKXjcCoHASxQv+HyErTIH0UgW4dJHED0oTjDeeooEU/D11taNAxRdw74Xd1Jg6
 V5Uy6by3oRNdEV9Dzd0SnsC2NbDdSDM5k2bayjpEW8hDeMj0eDnj8eCkohje/+a2SgG3
 2VsdDeKwYAcBOh1I6bIMkbzfFXhSMzb7+AsI+coQo8/dY/wjK4EvAF6ez9BXY3sf9iG3
 ZVo6pgLfAhDNCYCJkp05E0IL1c511v1+/65hLlK6k+uBwgZ5C9k4Mhyr/KZ3BGOATXv1
 FADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757909278; x=1758514078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7hRccTaisOnLlGXWrSjseXeJrY/CW00mlm9v4LgCgM=;
 b=C2Jsdlnf7oUaAdPGPRGxhue0rbLVBFM6KvVF4q6/S28Jp/NO/7QnYGDaNCfWDFE13O
 T4RNqqUFPqTEwcMd+0bK9igVJam9du1BB0JU2okE1PmHFMnfLDYGOnfZ4x4U9sk92z5U
 OuXe9WcHoDFZqM9ckXxiFKfIzoonyFlu564UkBlmFQVNrczSYCER9R11yEef4C3Pxnam
 CIXJ4LZ+g8ZxKAaBd5k8RMhDQLdB5JV2hf4Z2cDNS5zUwdoMlMAYG1KXQBAk0X5sGY0T
 Cy9FcVmJjcj4C0metXIVJJ+lYYQz7gTdcRrvYn5M+3bPPx0pkh5tTzr3LiHWBboTjcoN
 ftug==
X-Gm-Message-State: AOJu0YytjIxTXK5sOpieFpM+UKgABO5EGJ+uhaCH2yD0TmM2/YctgZbp
 yeqBzTfK0G75mQpJoxa5d3hLRxAJPsWHT7xYpVOxcrbsfTM42lGoJwX2RzkSEYQ3hfhbmbAYnnq
 PrM7aY+jpIAsUz6DiMJXbEPrLe7l927w=
X-Gm-Gg: ASbGncvr1oZsyKWPujnDXAuI1xGhQP/xOV4eywwuh2il0RxjDSMN4FUHMt4YwYtFZfU
 TuI2jaoHI+MoSFwmwjxzipWOeqYt4np85XX1OXDvMFHchEB2y6YAJGC4VvkJz1wAD5ZUQp9xMSx
 9cHf1ucMZSQc+1G6bP8tLnMUgjDkBFUl6uqple+H2Xd1BRsy+XWsvZWGXsGM9zFgTvGx+plXLzE
 RP/w/08cSOoPTe2c7P2esiUktS3pYZDMGscuQ==
X-Google-Smtp-Source: AGHT+IH9nmI2V4iAzmJQ8rLm0zSLBUJwvQAmCFo0wZIDIdS12SZl7Vm/alRPO+Rgj9bXnTmugX3HNjiPvMVOphNa9k0=
X-Received: by 2002:a17:907:60d0:b0:afe:a6d3:b4a2 with SMTP id
 a640c23a62f3a-b07c353ecfdmr1176100966b.11.1757909278265; Sun, 14 Sep 2025
 21:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250911160647.5710-1-frank.chang@sifive.com>
In-Reply-To: <20250911160647.5710-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 14:07:31 +1000
X-Gm-Features: Ac12FXxvO_cI_-M5TjsOSGMYZyAB8ijeknvqUbPHk_ZVL9arQmFZiCWbDQ22pWI
Message-ID: <CAKmqyKMkXDoh6A2iY80CH5m9YKFjFjDnRvaXU=AuRD7jSPx59Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix SiFive UART character drop issue and minor
 refactors
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> This patch set fixes the SiFive UART character drop issue introduced
> after commit [1], which changed character printing from synchronous to
> asynchronous.
>
> Since UART now transmits characters asynchronously, it is possible for
> the Tx FIFO to become full, causing new characters to be ignored and
> dropped when running Linux. This happens because:
>
>   1. The Linux SiFive UART driver sets the transmit watermark level to 1
>      [2], meaning a transmit watermark interrupt is raised whenever a
>      character is enqueued into the Tx FIFO.
>   2. Upon receiving a transmit watermark interrupt, the Linux driver
>      transfers up to a full Tx FIFO's worth of characters from the Linux
>      serial transmit buffer [3], without checking the txdata.full flag
>      before transferring multiple characters [4].
>
> This patch set updates QEMU to honor the Tx/Rx watermark thresholds and
> raise interrupts only when the Tx threshold is exceeded or the Rx
> threshold is undercut.
>
> The remaining patches contain minor refactors, including removing an
> outdated comment about the Tx FIFO.
>
> [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
> [2] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifi=
ve.c#L1039
> [3] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifi=
ve.c#L538
> [4] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifi=
ve.c#L291
>
> Frank Chang (4):
>   hw/char: sifive_uart: Raise IRQ according to the Tx/Rx watermark
>     thresholds
>   hw/char: sifive_uart: Avoid pushing Tx FIFO when size is zero
>   hw/char: sifive_uart: Remove outdated comment about Tx FIFO
>   hw/char: sifive_uart: Add newline to error message

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/char/sifive_uart.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> --
> 2.49.0
>
>

