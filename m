Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3742C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjDi-0003Nb-86; Fri, 22 Mar 2024 14:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjDf-0003NE-T1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:02:19 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjDa-0004h3-HU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:02:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bf442903aso284108a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711130532; x=1711735332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hwfo9mgfzP6086vlEWZX2HXWEfngeTxbC3n9gzuEQ2Q=;
 b=rcLsR2FdrC7Cu6HcEUq+7N0wYkKs+8ht5mo/qiygGwENFtbwwOg07BBETyEJMONSPW
 P94qf6TcDGZVePzm+Yz1nCM+m1A7zRi7XmCXjKK/qMu6hlHRmowCQUV3QfWhaLQxzXj9
 0qV2HgVwD69VM0S57GsAlTGMc+Z9ncJr2f/aoeCjn4/jXur3UQonMh6syQ8lfDm2ZjTE
 NEClx6SIqphpgR/X/V3lOEh/SzxIir1L0ximfxoUWUDykSSrE99y9W+1xEFYPZDeIx5j
 JBfSgW3RHqbI0aKMdDtCE0VgLaiEUtRCuvZ4vR3dtwSnRM/f7xLQjMjZ+cxDr7bEduDL
 /nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711130532; x=1711735332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hwfo9mgfzP6086vlEWZX2HXWEfngeTxbC3n9gzuEQ2Q=;
 b=g8wz3ZHC9Ic7ymp4yiYdti+KJGbaXKlsFWjs6ZM2xtKX210Z6KBUoK/YLAasd6JeOO
 KFNKwkHSeQjDc/mi15YUkbDIR5iHBFMVoyUrQxrW749pPPkWd/P4YxTdmYp6FnnoPaX5
 lIbmoPjF9tEf9xNxFN+m/HGkVKFvGdWr/pDGjLWRd+rNY385znnB7dA/kPLbeZnkGii9
 4GhCj14k9WhDNIf+6nMXwBuAZqDrUT3zOyvJGwrNv7k2P1Uwod+pxvNQizWewYPHoKDV
 ulN27Ney3OwDijo6PxexIY3yqAvHaBG9ubU9zKTK0vsPep2RJ7w0T/X9Lk7XVd/O+yyi
 32hg==
X-Gm-Message-State: AOJu0Yw2IMDtwS4cWjbWN8m702GDIpDMJ7mywU/Gld8VFP1JSsUwHvbb
 yBofwRbEXUP8nJEcfkJcF4unpYn/CbDHPxdIdh06r+p0+k0I4dNUrK9sJimWe7o8DRV/it+XHrG
 7UHHyuYNWEGhfult+a7jL60S50lWLkW16MaZk2A==
X-Google-Smtp-Source: AGHT+IEtTz0gt8yJnUB5DhxwgtPsigfocK5eA5yXfq/KTplvdV6jzXxUwi/RGoenAXUEBEZLpjzy07HhidyqAP80PEU=
X-Received: by 2002:a50:ab11:0:b0:566:624a:9e3f with SMTP id
 s17-20020a50ab11000000b00566624a9e3fmr2287448edc.3.1711130532131; Fri, 22 Mar
 2024 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
 <20240317103918.44375-4-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240317103918.44375-4-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 18:02:00 +0000
Message-ID: <CAFEAcA901b4OZiy=WVk0ggVQ1TF4mCQgoK8c9gES5uW7NX=0Kw@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/char/stm32l4x5_usart: Add USART, UART, LPUART types
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 17 Mar 2024 at 10:41, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Create different types for the USART, UART and LPUART of the STM32L4x5
> to deduplicate code and enable the implementation of different
> behaviors depending on the type.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/char/stm32l4x5_usart.c         | 113 +++++++++++++++++++-----------
>  include/hw/char/stm32l4x5_usart.h |  21 +++++-
>  2 files changed, 92 insertions(+), 42 deletions(-)
>
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index b56fee5b3a..f58bd56875 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -154,9 +154,9 @@ REG32(RDR, 0x24)
>  REG32(TDR, 0x28)
>      FIELD(TDR, TDR, 0, 8)
>
> -static void stm32l4x5_usart_reset_hold(Object *obj)
> +static void stm32l4x5_usart_base_reset_hold(Object *obj)
>  {
> -    STM32L4X5UsartState *s =3D STM32L4X5_USART(obj);
> +    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);

Could you avoid this kind of "add function/type/etc in
one patch and then rename it in a following patch", please?
Give things the right name from the start.

This probably looks something like "squash this patch into
the previous one" in practice.

thanks
-- PMM

