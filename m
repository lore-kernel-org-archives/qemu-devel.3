Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F10C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIfX-0002yk-5h; Mon, 15 Jul 2024 06:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIfV-0002q4-Ks
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:10:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIfI-0002ng-IQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:10:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso28372065e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038239; x=1721643039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=86fNGiERpIq7oZQvKBWxfScMLn2QFS51FEn9dJqSkCw=;
 b=gaPA5yHkg2KC6WPvvA2rhNqmNNU6Z0wSXwCeOgAix72u4/sMDNJ2YMmgcUVwdv069Z
 udeKzaOYYApLpB42I3NDDDfj8vfjSfaP8M0DnBgTCqht/SqFWp/XLsovlzu/8A7Z4lRA
 jNPW2QgM5KEduA5nfHLzqWBwtKN9u0B9TfRu6ZLSTw0w41y1xQ9KO9AiMVqerNv+M0Eb
 9MK6UggYeWpLI40uEUhGxlkaU0gBJzUdUzzjKihA1226veZ0znEeh+WK+Zc4rTAX6rxQ
 H29IzMzUvrRBjps4Ld2FRJ4fgQnoKu2Mw2T3Ku8loyPQZF8GC6Df1+gJYrWq0D0SeFj3
 1KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038239; x=1721643039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86fNGiERpIq7oZQvKBWxfScMLn2QFS51FEn9dJqSkCw=;
 b=LtAvcpserZgojfQqWPfuaZb1Q4bZpfKUTpdmmEqXY1k41pmKiuWPYrlyIeMsZAni7O
 qas/6HTJVHd0OaA1gBRV+OZ+6Nho1f8HxbWBRVBG6QbTTcCycE//ik1pywsg/0Jty1h5
 7J7CuDvdPiG9F/DQdnohCmKvh5u+ngCv2nWOUMEH52ZHeXJJlo7AvLJWiY/rLQoRo/Wh
 dKExcdRIiKCABFt+A3EoIAmiqGBC/ffk+MZC7Go3mFqfwsgZkUwN9o3BTXdM8+8r3V2S
 ryeyWTWYmn0oF0Sr1Kcaym7qWVTcq8jTtQ9r8SegFb/BcYEYJaz4FkILmFkX0BoZAVlj
 xnyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIBafXO/Ja3BKpA9rvZCqvqh9mImPXGo533rBfLNT2X741KUHkW1R1asqfrqbjubYOa2Q/6EGafZWeql1tIhOzmE/pQr4=
X-Gm-Message-State: AOJu0YyQsei2nRJ8m3PhxrMaUzA2fWEvNYpBipIT0bdwOcAJUxpNkVb3
 LcyJzP7/eOyOK7OOqiuNb95o+Pjul8Bi248taYSsTvudk4Gedz/r51jhNlIovvA=
X-Google-Smtp-Source: AGHT+IGihOESCCtU8uN8NCQ/V/MdgTZNrYEsDfYRV8smLnXoluPXcouwdRgDFAr/jqmgI+hS++PVJg==
X-Received: by 2002:a05:600c:5354:b0:425:649b:60e8 with SMTP id
 5b1f17b1804b1-426707e31b9mr120523815e9.18.1721038238694; 
 Mon, 15 Jul 2024 03:10:38 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef44a9sm80097935e9.40.2024.07.15.03.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 03:10:38 -0700 (PDT)
Message-ID: <876557e7-674b-4cab-9c85-3e24180316da@linaro.org>
Date: Mon, 15 Jul 2024 12:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/isa/vt82c686: Turn "intr" irq into a named gpio
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240704205854.18537-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240704205854.18537-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/7/24 22:58, Bernhard Beschow wrote:
> Makes the code more comprehensible, matches the datasheet and the piix4 device
> model.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/isa/vt82c686.c   | 2 +-
>   hw/mips/fuloong2e.c | 2 +-
>   hw/ppc/amigaone.c   | 4 ++--
>   hw/ppc/pegasos2.c   | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


