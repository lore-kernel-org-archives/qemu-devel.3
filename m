Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2EBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cdC-0008Cp-Bp; Wed, 08 May 2024 04:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cd9-0008A8-Bq
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:26:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cd6-00079J-Oc
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:26:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59ece5e18bso442420066b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715156783; x=1715761583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzRXoUwxh4wkhYay+Snd3nbpb+LJezX0f1ITgy4dTOQ=;
 b=C4zlT1TZ/5HvL8CahmKBpir4AtbKRCkcidxR0rNco5uHx8Z+9EcFNl+7ypbCdPOUP5
 i59lKcItKEv3DovyXqJR0qTVVbf1otI9WQhLzF2G9srDJOvT0+eEzZcPzO182OLbNqp0
 oh0V8b3ohIuxeOx/V1sNmb+MSIafgUTTqZuVz+mmfvJ0ocxCBtfeM96zQ49Wz8GBIebU
 yAewTk7LGfm9iO6pBFk4DxPR4bH5GIpNZh2wVjh69alKldP0qhEB5oZJ8iTCd1xIfseK
 E23Dda8eavmeoN1i5+lHO5n9L7EK2rxKYU046Jm28+eAUlD2CDIsVNEzWhxfQIWGcZxM
 zYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156783; x=1715761583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzRXoUwxh4wkhYay+Snd3nbpb+LJezX0f1ITgy4dTOQ=;
 b=nrKBcm7LC4Uo0iUQGX9exNcxM8lJpowCqLL0NazI1shdaxRon4ngruZHc9NUfdhTmj
 YPA7OLju7Iz+YZV9A0UXLR7DwWRimcm3+d2ejMFxzUJZKIfNuDL3BFPYl3uZDcbAARo/
 Rv5QVIjkHcVXLcRwm/GmgBLisnrgcKvv+Y3g8H+tsN06UwHpk7VblOgSaGMwRWmukj28
 h9wmjJN1XC/mZHbGs54egJASTb90dAoHX3ocr2rZmFGN+jPC7UaepVYmvFhKgtT/as9h
 mn3hFlOb9pobA31HQauC9zPQ2HOfP5UJanPDcj0FE9MAPeVXCksmzcmWhYWsgJFDdPhK
 6VDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC2K62BeTKHcw5mlq2liqXonNH+6d6juSouS3F2D7nAeZgafjJuztzTv6bbTMKOvs8mYfYPNArticSGMFxSuwkS7r5OPI=
X-Gm-Message-State: AOJu0YzdwB/4g40ZblBlxGjqyfPBH5PqboB6QbgWusNNyndO3I5ZS+CH
 dI2f8SXBJOg+F7UW5v4ElvLXs3jZWf50nEyukYzfmROIyzHDQYxAsWmD1/33sC8=
X-Google-Smtp-Source: AGHT+IF6pbh+w0wXUSOo6/J51reyV31XHGDY9DWZqkL94kRGufaXza+fY9W4tQdrvjbGJkX6ZXbA4A==
X-Received: by 2002:a17:907:5c4:b0:a59:bdb7:73ec with SMTP id
 a640c23a62f3a-a59fb9dbd54mr207331566b.72.1715156782913; 
 Wed, 08 May 2024 01:26:22 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 r19-20020a170906c29300b00a59c6859824sm4010137ejz.143.2024.05.08.01.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:26:22 -0700 (PDT)
Message-ID: <d01f4b13-ba38-4050-99de-9db557eb7bc2@linaro.org>
Date: Wed, 8 May 2024 10:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/gpio: Handle clock migration in STM32L4x5 gpios
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
 <20240507185854.34572-3-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507185854.34572-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/5/24 20:55, Inès Varhol wrote:
> STM32L4x5 GPIO wasn't migrating its clock.
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/gpio/stm32l4x5_gpio.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


