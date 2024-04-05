Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0837C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskXg-0006HC-5L; Fri, 05 Apr 2024 10:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskXc-0006Gm-Ho
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:27:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskXa-0006nO-VN
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:27:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so2751928a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712327257; x=1712932057; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Bun2vhsCleh/N6AH9rwv8hGRqgqda8eN6MGMI23yJY=;
 b=O5CBriXvuZKu+YuUfE5Gws917kwOseB0eZfOCz2me1crSsa4VrN4ri1fqrvVHAIOxk
 72MFWxwC/ktDg7DJpeO9+cOb7YxRIgl8PLfv8AMNkOTerYoa1gkvBNKJbabbYwyitZSC
 BSRNsl1fcRwhbeergf8cUINflRPy+8LWpHNFiC3lRrGRF84USJ2D0Nt3qkC8KXlrEzGw
 lGhZG1cmFxIl4/xvyvosfNXmCElBVwToBq7+/InbsQWtPZB2pAKNV6IKqz66l1pExb+U
 G4+EUPyM/1mIgXVBypnObTSMlglJWe7uGcNw5gzOqNg3k0+e3vN01zSQi49YfBLrI0qV
 zkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712327257; x=1712932057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Bun2vhsCleh/N6AH9rwv8hGRqgqda8eN6MGMI23yJY=;
 b=sd1T7H8w+6jLkdKrJWP7TtTo4OtqNopwk0hga19CL44doKIAJBBuZd+ca+WF4lht+2
 N8R7dDk+Adtdo53COQBaK0oP+Uq6Vd+lOhcvu9oerFUe9GdePiQq8rCsFfO1z6dGX9N7
 jtn8pUGzGP26gqzp6mIn3+BpQ4yvH0DBz/MhHrm2s474Hv5o89sGCa2XIAgmz7hRFPY+
 Zux+yylP8zXz6QG2uRc6UWYhojkhQw6nh0CyP5uYC46nQKL65rjNd0LzRh5WSvfNVaaP
 dVNzGGKcD/5ZzwD1Ob3p+ZcHGmEmJjoILC3/zvX+//hnp+IAB730mqmLksua0+896PxF
 NZOw==
X-Gm-Message-State: AOJu0YxMtvgtMGhb8OrAUm6rUzXcy/UMialvOc2cjCR30uG1oKv8xGGu
 dwWQWRB8LtONOy7ndNzbYLassJMI7WA3+UGJVT3x1lAIj2kQ71bqP91Qtz9RKPuG5xShFN7quPv
 3NoImTQXMy+qtQST5tyEGqGs+yKptAVgC6X18Og==
X-Google-Smtp-Source: AGHT+IG2s5jxrmXM1CxKj8o7sN46v6/s0ytWH+FiZ9INDtVAa5IvsgoYuUm59ve9OJZnLp9vy533XwlbOpzMqzx1edU=
X-Received: by 2002:a50:8a81:0:b0:56d:fca8:d209 with SMTP id
 j1-20020a508a81000000b0056dfca8d209mr1184729edj.10.1712327257354; Fri, 05 Apr
 2024 07:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 15:27:26 +0100
Message-ID: <CAFEAcA_xuXMRnmFMs_GzfrDN_kpR+c4C04OcPjxtz+hSB_ga2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/char: Implement the STM32L4x5 USART,
 UART and LPUART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>
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

On Fri, 29 Mar 2024 at 17:44, Arnaud Minier
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

All the patches here are reviewed, so once we reopen
for the 9.1 release (in another two or three weeks) it
should be ready to go in. I'll keep it on my list to apply
once I start collecting 9.1 patchsets.

thanks
-- PMM

