Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9ACC54E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZDG-00044h-Rq; Fri, 23 Feb 2024 12:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYxZ-0001rU-Bv
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:03:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYxX-0005Lq-89
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:03:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso720692f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707813; x=1709312613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKThRkOT4hcn8BPguJXY9z300E6tjibkEWgpEM/kf/4=;
 b=Ir21Yq556mvd2uvEtc0/Uoliu5TfybA7buKB1le6d97vOQmaeUs5+ZjzlzFWqbcfKq
 Xs8U9aR8j3YOGudrqT9YuNXAbluYTKX8yBiq8PrW+KkhAiOdRmH+35kPbn6Gospr0rP1
 pZ4GNNkdTaF+6pAblCvaiOemSeyKR9TuzKVPIsooBj1yyCesaAE4qL6g396juwLxOxDa
 lZJ/MKYd16xTjgeLScwODSVk+m1GBkDVvwQ1lD9hLw1Te3oK34O1c5rW9oIsv/9fUN9h
 uc0zUBDYB5Z+Nl81Zp2DNRO3/wnS2vChmVjs8rQNh7DrsQ0oQ46oVZLd5JvI2nSsQGPY
 WEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707813; x=1709312613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CKThRkOT4hcn8BPguJXY9z300E6tjibkEWgpEM/kf/4=;
 b=nMFs+qKGjC9wV3MrBdqYR6QvUxWGfJlop4siMNtipdrKoUDJiflQHpwyT3EIDnAsZh
 /qmE+jpUthSRpbWUnS2az/4wMzlc1RN1P822P46770AYtyteA18FOazjduEM3Q20Nd+E
 s8R15POR9r5ilahVMlUNPqWy1OFusn3qkXyLLNr8tei300Xz+BZv1TryCqtxi3DoEj4e
 Iur0W9aKFaKbzEcCr0IB9iOxFwlP2yo3r/GuQWZ24hweV/5KY4+pvZSs1i85Ux3xtvd8
 7syxdY8VwUfnmSEwn/NWU5CZWR2Lq3A1T+GHrsyY+rLaxUAR2chXOTtW5M4QTJQIMWS9
 FrcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoav5mspda6dMNyMZ45EeZQzVduxefrCU8jJq7om9Bwg8zVfD/BvVCa7M49twkRxdyyFghpVNZTkkodMCU6jrd0L6UsBQ=
X-Gm-Message-State: AOJu0Yw1ttw66CVXKhpsB7iHbIngBQcEo+K/xXTVJeb+n4iBFuqDbNbT
 fAALcwtOtlb1FXFoefer4jxsok1srEPv+sMYsZlWeB/lrs6RAAy3Nsiw5DVuCC8=
X-Google-Smtp-Source: AGHT+IFWf5AtnByh3dazW9Xp/f178CW+NZ80wvnoOFfdhLQwNfmm7PthIlK25aZqQirfkIcrtkoR9Q==
X-Received: by 2002:a05:6000:154c:b0:33d:4dbd:d05e with SMTP id
 12-20020a056000154c00b0033d4dbdd05emr404567wry.22.1708707813436; 
 Fri, 23 Feb 2024 09:03:33 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 cm7-20020a5d5f47000000b0033d6fe3f6absm3549758wrb.62.2024.02.23.09.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:03:33 -0800 (PST)
Message-ID: <ddbe482d-fec6-4d4c-8618-e868f77475d4@linaro.org>
Date: Fri, 23 Feb 2024 18:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] usb: remove usb_bus_find
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-9-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 23/2/24 13:44, Paolo Bonzini wrote:
> Inline the sole remaining use, which is for the -usbdevice command line.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/usb.h |  1 -
>   hw/usb/bus.c     | 15 +--------------
>   2 files changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


