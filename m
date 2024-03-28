Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C5CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsKy-0002wR-AH; Thu, 28 Mar 2024 12:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsKv-0002vp-9t
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:10:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsKt-0005mA-Lm
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:10:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56bc8cfc19fso1349932a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711642236; x=1712247036; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zXbJUC+4/ewayfZwdMBa0QM6amBki2z9IDumPrJGiQo=;
 b=UFGb7CxLe1jJv1njapIF6i7dpYouFAfS+MXKyN37JH4GhELuet5K0zJ7bZNFQFCJjJ
 pIvKvJLpOkuXxodvKDsML2+8ObwCwdH+qSu92QgGOm9dUquKx+vNcsVoNUqkZqRGNLdH
 Z07NXJN6Zzj6OX6xn3LUnDfuW2qGnLuWhHSk+LmQLKgzqwxSxioEZFBTIxhZnOVA6zXy
 jt4x+gBwlY0CBbk47tNEHDuKyWxcNfLWWmVWJ7O16/bd3hZvg429zf6YaXyZmhYdcuoW
 3LC+feXiJpSlhVDw/yc7Ify1EGuA70SmhIOkZzZMZbZir9ekSoHc3S7PBuVx1Aa1rtvK
 5DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711642236; x=1712247036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zXbJUC+4/ewayfZwdMBa0QM6amBki2z9IDumPrJGiQo=;
 b=GYfV3oaaWgMC3V+O+D5r3wTzOT5p0JaPzk1Loc+QyF/wG2RPLHSFOq9YbIJ3ZV7yEQ
 CXnKLUr5O0kT8fv5UqvByOydMqdTjnt9xqR38HJxe9+PwrlquVOixTfz4WY/f+0e84ao
 k2dfWQL8LOTfBICymxBQr5zHR//jyQ0iJVuidzQyZL5AhjW2hLWfyK54lHzAklb3Kr22
 yeAMP949SGeZqlMEalrSu1TsiDjqb0ncPzbUbPlb31ir6blnsKxqNBPiBodZetHsFIHT
 zk3TqEir/uQGvyOWIhSZMQiLNlUO+cywhDGJdFDZZO8SOuH6KnfSmmU92vq9SiYvWAF/
 5OSg==
X-Gm-Message-State: AOJu0YwnqpspRD9jNJuuFCJ793Z4ORbC0jMpIk8If1TLimQyY7NmdSJ1
 WOuUHXJhGu7LO9Hqcdi2oiJEiGA5V+QLqyh0zdM+KJagOqViSdvQqXFCKvKuoIpfcWy9wHuvn/E
 P7INGBTeFShTMV+o5vYubR+TFFynnQTK+a57hcflcJjVO5KpW
X-Google-Smtp-Source: AGHT+IH8ZSmN26v+UnLAuF68hlfRanF72peANGY/Wq4T5gvwzMJQO4K2uFvR4TMRmBParskxNsTRrzVUst1XnXiNlI8=
X-Received: by 2002:a50:d71a:0:b0:56a:ae8a:acc0 with SMTP id
 t26-20020a50d71a000000b0056aae8aacc0mr2458150edi.21.1711642235679; Thu, 28
 Mar 2024 09:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 16:10:24 +0000
Message-ID: <CAFEAcA-h-ddfyNXaa_swFJVc61cDbR9tg34AC88nqZLgfbzCsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/char: Implement the STM32L4x5 USART,
 UART and LPUART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 24 Mar 2024 at 16:56, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> This patch adds the STM32L4x5 USART
> (Universal Synchronous/Asynchronous Receiver/Transmitter)
> device and is part of a series implementing the
> STM32L4x5 with a few peripherals.
>
> It implements the necessary functionalities to receive/send
> characters over the serial port, which are useful to
> communicate with the program currently running.
>
> Many thanks Peter for your review, I think I addressed almost
> everything.
> I'm just unsure about how to handle the waiting time in the tests.
> I understand your concerns about the unreliability of using the wallclock
> time but I don't understand how using clock_step() would make it
> more reliable. We will always be waiting on something
> that is out of our control (i.e. the OS).
> I increased the delay from 5s to 10min to match the microbit test
> and added a comment (I paraphrased your comment, is that okay ?).

I think I was slightly confused between two things. For
a lot of qtests we do want to use clock_step() and not
have wallclock-based delays, but we can only do that where
the thing we're waiting for is purely simulation time
(i.e. where we triggered a change via a qtest write and
then want to look for the result via a qtest read).
Where we're triggering something via a different OS
pathway (e.g. here where we write to the socket that's
backing the chardev connected to the UART and then look
at the UART registers) we do need a wallclock delay.

I recommend you follow Thomas's suggestions about timeouts
in his comments on patch 6; I'd forgotten we have a
meson timeout now too.

thanks
-- PMM

