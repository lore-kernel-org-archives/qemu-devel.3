Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C41EC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMGw-0002Kg-Ut; Wed, 12 Mar 2025 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMGo-0002Ju-27
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:37:14 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMGi-0004CP-9m
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:37:13 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e6343c68b8fso4803871276.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741786623; x=1742391423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVvS7Bd9Vp5uMxehPTEyvwcCx9JGsMx5utQtDpt9ZS8=;
 b=ya+D430cCUpERxwYM6DBV4fl8eH+jHo7vKaEnp0i6K2YdEKsM0wPK5etQ31RnlJPDm
 g7HrJr9Dm8QciptlzzGpTI+qBN4rRJjbsLiNzWYvMeIw5ryJ05xtSpDkqxo7Eag0be5h
 UYUxTFCmqjy7P1Hjb6D3GPGdPRJCufGKJFGlP4ubDUQ7IJbQ50cPZeWJlWtxgi8dyjST
 NJMWaHHK4o+WW6BDr9JMyswqoE0kyKFROoJq0rPFRUE6wkAiXCaAJTRb4nERNHRRfjhR
 kOze6Nc2gEDUVq/BRen2ob3VoH0834w33qAE9XX2yBtDSf81W0d+JYcfEIRAfEJHef7B
 nF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741786623; x=1742391423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVvS7Bd9Vp5uMxehPTEyvwcCx9JGsMx5utQtDpt9ZS8=;
 b=SOz4p035HC1VwrLbDjVWgqes8g7/3xctYXRe9DsW+rIhLm3AITrGD4YE7jzUdjiTBj
 W7vBylV+il9OifWpYYaNMoHSJOix6zNavN/H6QWFZE+7FEAiseO7Vg/z8nyaF9oMYXu1
 HNw/fxQrWOBoK+vb+gxa90+vfW+gM41vz7tVYPFdhpc25ewqKOW/lA33NnNieISkujyz
 v97mNEQBYsf4mAoCFKb0+8jLrmaVMS9jfBe7X3nGeFe0kIQJypcOJYvX3CeXa2c5H1gs
 F5GKTishG1eImTf1fkMxVbu1Xmo+LLhBmt5UBDBQpYLXHEHJS13CbObolhWFItqNim4A
 9oyw==
X-Gm-Message-State: AOJu0YzNT03PB9IBhj4CJx+63W7+qy62dmC1Kw0hmtImmHMv2tw+2XJS
 Pb6MXvcO74msAPWSFJWfGLyhCW9ppw+MP5HFBGPzDo5QlQ2s4X1ndHgaXuDYROSxXkrjs1FGnBh
 796+Kc6MHToCI9J7IGYZ7/O1tD/7dpDrG73AeKljsBXxRbEU5
X-Gm-Gg: ASbGncsTlu6hlzS04eT7evMJ0qUXjJ4fGBpQk0zXrK5Wg8+YtklOl7Jh6sqBQix3lFc
 2LZHx74lXQz20V5VjVx1WVp2QiwoBNain+6whx2f+NF325X0pzHBcsqmG7gaHvkU8dqw+79ZYkX
 tRCsb5NHmj3KKdTF+faU48rL0I9nk=
X-Google-Smtp-Source: AGHT+IFLyWHVz5SBk3NWX+Cz1n7b/aIJyWXyhDbSZRN7xKvbxdWRwOefaDR+N4OIxqricTuzE6j1uuPeKjM3NICUeG0=
X-Received: by 2002:a05:6902:2381:b0:e5d:fecf:9ac8 with SMTP id
 3f1490d57ef6-e635c146f80mr28765253276.17.1741786622542; Wed, 12 Mar 2025
 06:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250311153717.206129-1-pbonzini@redhat.com>
In-Reply-To: <20250311153717.206129-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 13:36:50 +0000
X-Gm-Features: AQ5f1JoizDnCx-EBiv8bpAPz7Iao8hP8qvTc30snaxWibgvVjACa_4Xifb5SRwY
Message-ID: <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/char/pl011: Warn when using disabled receiver"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Tue, 11 Mar 2025 at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The guest does not control whether characters are sent on the UART.
> Sending them before the guest happens to boot will now result in a
> "guest error" log entry that is only because of timing, even if the
> guest _would_ later setup the receiver correctly.
>
> This reverts commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df, apart
> from adding the comment.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/pl011.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 23a9db8c57c..efca8baecd7 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -85,7 +85,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Ch=
ardev *chr)
>  #define CR_OUT1     (1 << 12)
>  #define CR_RTS      (1 << 11)
>  #define CR_DTR      (1 << 10)
> -#define CR_RXE      (1 << 9)
>  #define CR_TXE      (1 << 8)
>  #define CR_LBE      (1 << 7)
>  #define CR_UARTEN   (1 << 0)
> @@ -490,16 +489,9 @@ static int pl011_can_receive(void *opaque)
>      unsigned fifo_depth =3D pl011_get_fifo_depth(s);
>      unsigned fifo_available =3D fifo_depth - s->read_count;
>
> -    if (!(s->cr & CR_UARTEN)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "PL011 receiving data on disabled UART\n");
> -    }
> -    if (!(s->cr & CR_RXE)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "PL011 receiving data on disabled RX UART\n");
> -    }
> +    /* Should check enable and return 0? */

We decided deliberately not to check the enable and return 0
here, as described in the commit message of abf2b6a028670bd:
we think there's too likely to be existing works-on-QEMU code
out there that doesn't ever set the enable bits.

Otherwise, yes, agreed with the revert.

thanks
-- PMM

