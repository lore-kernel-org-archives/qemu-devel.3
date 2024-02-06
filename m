Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BBBC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXObs-0004tS-K7; Tue, 06 Feb 2024 11:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXObX-0004TA-T5
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:47:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXObV-0006VU-7o
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:47:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so9551345e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707238043; x=1707842843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAJ961dJtrxbbJA4zkQDOv8vFdNh6a8Iooz5/cijkzQ=;
 b=uHNiB+eQYCTtFTPoZFR2TaX5G+N/h3f0UwRr/Oth+IDyOeFjMuf696LBfKMDIeH03K
 5LN5bdi7CHqgjRUCgo1ctgHApi7d1fW0l7IE3hJLLnF7MOVxDIiDG5PAt4glepnEdYQ0
 PzbCnvfPyBsUnuQSGbfv4Tj9HVo+pUUhaijVoHIAuwDjC1sDXCpN4cpLWVgvYNFtiRzv
 HEa0oBjpb618Nr7s2tFdDvRtXx0s23qr7USdF17l/P5S0VZe8VZ7TovO7BFoO/oSrIkf
 E97biRYVkoJCDwOdrq7qBHWZtkMzayBgg3T2jUOKOuclEAh9tklq8azS8tNVfxmw113q
 VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707238043; x=1707842843;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAJ961dJtrxbbJA4zkQDOv8vFdNh6a8Iooz5/cijkzQ=;
 b=JrEkB7XYIIjZgdEzmAn4LmrhY2N25Pay2t3V2et9JZP/9ovHLoa6Dr61WC1kylUu0b
 kJmvBcBDOp2k6lnYtTVAAJ0oddZRITeHLwtnX7A/SVgMDQRdiBNAslCbC2fy87kT7uhY
 0hPfZT6YjzJrwSnl8vbslBYs9WtrgbVRdXb2m7K4m2cL9H9CF3RZLG/TfuaGoY+EWDKK
 9sigoRa2d8UdFBaDP0vT68vBHyVfhI+b4zKsFXjnbObutsPAgHREC6t8Gjc5x/lGIjA7
 v++aKQdJsEirOTgBEHExKMLFISs+efV3q3GG0xOV94fnH1fHfZbIaW6HN8gUCTxnbbdv
 EwQQ==
X-Gm-Message-State: AOJu0YyXEiap8bMaGr9qwqIdON0DD3kN3Kdn+3roSGMUUR9IRVSu3TSK
 EzIS+g+DwJs3v8aFaScliGPdVqf2R/9e6KcH4hWZIi9/hAvtjl153slkqs+sDDs=
X-Google-Smtp-Source: AGHT+IH769ZdqqWs00fmc/vUULe+9rSofRBbMINUOGTnfWfCHZR9f+V01LoheaknWTkSgGxP1AP32g==
X-Received: by 2002:a7b:c055:0:b0:40f:ddc8:f283 with SMTP id
 u21-20020a7bc055000000b0040fddc8f283mr2969231wmc.38.1707238043687; 
 Tue, 06 Feb 2024 08:47:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfYfox8QWuy3UbaNr3FtLatFOIIgKUQQwwFHr6b2Dg9lTv+0tePV61urHq5hxCY6hGl6qGWsbWeQa6S6BTi/lWkpKWEgRi1rYVqM9YkjnkFWMDoSp86qpZosk=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c501000b0040ffdfac914sm72436wmr.10.2024.02.06.08.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:47:23 -0800 (PST)
Message-ID: <c8da546d-a5d1-46db-a66d-9a18bb993a18@linaro.org>
Date: Tue, 6 Feb 2024 17:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] hw/arm/mps3r: Add GPIO, watchdog, dual-timer, I2C
 devices
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> Add the GPIO, watchdog, dual-timer and I2C devices to the mps3-an536
> board.  These are all simple devices that just need to be created and
> wired up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/mps3r.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)


> +    for (int i = 0; i < ARRAY_SIZE(mms->i2c); i++) {

> +        if (i != 2 && i != 3) {

Maybe easier to read as:

           if (i < 2 || i > 3) {

> +            /*
> +             * internal-only bus: mark it full to avoid user-created
> +             * i2c devices being plugged into it.
> +             */
> +            qbus_mark_full(qdev_get_child_bus(DEVICE(&mms->i2c[i]), "i2c"));

TIL qbus_mark_full! Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        }
> +    }

