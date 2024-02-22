Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE3EC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCIU-0001IY-87; Thu, 22 Feb 2024 11:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCIQ-0001IB-CK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:51:42 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCIM-00048J-9l
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:51:40 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-512a85806fcso2209024e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708620694; x=1709225494; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cFFYtuPwYCq2JiDP3cBy13W/EZu61xl46ow5liJzf18=;
 b=gyA97oKePznyqVfnsT8MK41+X4TnJZC+c8XpgEUv5BmR8ycuFWPdgZ0283nJCJ/C2o
 w/XpyrEHGfCq3zXYkrqSCeP438w7m0PKckBI71UHLYJSf8xiOsDxG4mfmefwvdfS1MD1
 EaLVyqeyftNlpTM0hM5Bb+uYdiI80bZ7myt+ZgsY0B7GOKped0oXoemUgsBGjRb1d5Sp
 C6Yqi5bSMubEYwBLJqOQGsTlWLTdjFzmaPmXn4XkAur723mbNIyyY41jHMzHxB+brkjM
 gR/S0TfWd5AOgxMhmEL0XkeyXjpDV4AVZpve09wKrlb+4VvbCUFOZgzHBgimzR672chx
 LsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620694; x=1709225494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFFYtuPwYCq2JiDP3cBy13W/EZu61xl46ow5liJzf18=;
 b=WrnhtUOK4YIJUHYL5hSzt39GuZ2RlTH/jm6hF5oQEYWwDyTMOS+UW89HUhkxOjv6as
 O3g7Xhjg8zX+kwMDijvEwny5ysTnh/ePCc7wfXzC4AbOnWeGy4wtB7XzmueSEKNq0NQc
 qWSfqMmFNLhpCMJVJemPt/UmHSh85K4DygGGG0b/RzrcZGMCIZbqTaob24UZyCMv7H4u
 rEtqYQCegHm78g/Xaa8acUBmC23MKJZteEbAak0egahbzV/9EjY2u/yoQHR1lGNHIoKH
 +Adg1bfl3IyFpI5MFMKeWfIrOw2A9qAQveJK/Hdo6di5ltKGysp4OnFLgy3ysPkxVJUq
 rlAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlXeQ/M1r/2UJg4dGJVcorVhVrqXOc+wtgc44eVCeFNyqmS87g652bXoSyTLoEcvtTQ58w4XZUHQIXc47tL/BKADYIqQY=
X-Gm-Message-State: AOJu0YwNqYQ0YwCz+m8eWh+wv+7ylg4e1C29YYbTfhtxkP9keqOWGbY8
 6lMjwSxFURk3UoYfma5hQ/6RPwUUJTmWhssqkPDns/fMc0ckZTIWVJsNLOiqvCEnZLhs2+46Ntg
 RHLMwAhscSxaFqbv8aYMdV4LS/60rB4Y5RJ2DUw==
X-Google-Smtp-Source: AGHT+IEo0Jd6cBpK0MnQNsB8XAbJZL9SUOZuww5K/VsDmcDNnD0a7z+qKDK7lBtPVlt+3UFYViU9BrRpVx3xurnnDgA=
X-Received: by 2002:a05:6512:4806:b0:512:b4fc:ff6f with SMTP id
 eo6-20020a056512480600b00512b4fcff6fmr7245726lfb.24.1708620694332; Thu, 22
 Feb 2024 08:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-5-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-5-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:51:23 +0000
Message-ID: <CAFEAcA9D+ALpQhr2_Bd0XTSn=ZOXGKWuipNzFANCzKgv89oceA@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] ui/cocoa: Call console_select() with the BQL
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> console_select() can be called anytime so explicitly take the BQL.

I think you mean "displayConsole" here ?

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 17f290987563..81de8d92669b 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1391,7 +1391,9 @@ - (void)zoomToFit:(id) sender
>  /* Displays the console on the screen */
>  - (void)displayConsole:(id)sender
>  {
> -    console_select([sender tag]);
> +    with_bql(^{
> +        console_select([sender tag]);
> +    });
>  }
>
>  /* Pause the guest */

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

