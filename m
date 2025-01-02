Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E2CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNUi-0007Ky-N6; Thu, 02 Jan 2025 10:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTNUe-0007Jv-9J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:52:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTNUc-0004mF-2h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735833132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=arTDeOUBowmmiQHJXDXrgbLZIFlARASgXGT2zN/xSkk=;
 b=KrowugtmTZB2JLAi8DIqwrvREuLQWzWyJOwklIPIawZY6hNPXjKy4xK0bASGnjzgnMMIGY
 aIkvZ6R6cK+V+F7uz37v3cG88ud6ijKECO+t4FcgLKwtyzuaJ5hBRZHpte9RSbpgAfOsQE
 UhjmcJ1/K9+Qpf6x86m7diA2Dkruvnk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-KsO1IBdZNjSmnmJVT-raog-1; Thu, 02 Jan 2025 10:52:10 -0500
X-MC-Unique: KsO1IBdZNjSmnmJVT-raog-1
X-Mimecast-MFC-AGG-ID: KsO1IBdZNjSmnmJVT-raog
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso63916245e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735833129; x=1736437929;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arTDeOUBowmmiQHJXDXrgbLZIFlARASgXGT2zN/xSkk=;
 b=MODQygdpLIB4G/0jn7yWK0zMlcG+TSc0VfVq8Hs0SNJ0PzPfsHZaWTgUzqUFHHp1fI
 k1GCODU5LWndj8XymG0dZ4yJkFsw+VN4Kzn2/VrZ/C+iOv3gGmdMlEhK8KcdmX108plo
 MQrmhgZ3+PifS+BDZDBWoSXxijMJQWliZl+Y6bJ2keWzumfb4d2xCkYz5L/lznMX0OhQ
 JlNEDu3oa6Y5jht6UeMswaDrcsIOCKCcLZz/V3iSBgajVxMG6g99wBafZxbhIsc+3e3i
 ke8JrPTVIhNjI9a6MYOeZ9S9b46JFI7BlL9Ys7k+BYZQa0J6tIM/K9CkDF6S2r9JXh6A
 V8Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdSrTfXYTHoMDDpVWHMZlnue12f5eCI+yyTCerI3ah9ECQpaUuSIqByvv1g95SiGguPVsUfWFLsc43@nongnu.org
X-Gm-Message-State: AOJu0YzVMGUvfxk0mD7UzUSRb4bGL7InGTegSd0v2yxtOqp5FpJqYJ+U
 8kH1ellWlxf4g5ATY+hSzxZxJp1wC73cd7x//CiYIonoro/JgupuxunCBhKAj8SzksNBbflT4Bz
 Q0F7LnVsLON2IoC1hQDGP956jUolRKo17RJr+loHQvCA08CufzoxM
X-Gm-Gg: ASbGncvp9Ij3OJJ8LgNNxdKvMx35pW5tT2ovUMbm8TgIpTvFse5wr813biMuZx0qEIJ
 5/DaDA67HQoQQAa8rBeZWljXrHwM0NxmQtuip0Ya9+BtoUlfFc2XIo9bOlv/0uAW9fBQNwRpYNR
 Kj3lENeizM1yHdMIm5lL/Gd5zqA3LA+GnwZVejy2f3fvQxCTw/lBm583CKwtRTgZAHFCgetD5Kt
 eTzxjQaebS/H2dE3CLkxK/pUwAB7dWCFErHLoN9gBj41AlS7kN2/hhBlCOnns34f1y0AZ3A1z4Y
 nRC0eYVR+OyF
X-Received: by 2002:a05:6000:1f82:b0:381:f443:21d3 with SMTP id
 ffacd0b85a97d-38a223fee7fmr30856691f8f.57.1735833129408; 
 Thu, 02 Jan 2025 07:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAZIbob/pJAv2P0DUQdhAg6THc/Gyerb7c1BpUjbcaGqErWRYmD5FFcx4B+FQLg3Tx2G99bQ==
X-Received: by 2002:a05:6000:1f82:b0:381:f443:21d3 with SMTP id
 ffacd0b85a97d-38a223fee7fmr30856683f8f.57.1735833129088; 
 Thu, 02 Jan 2025 07:52:09 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847214sm38335478f8f.46.2025.01.02.07.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:52:08 -0800 (PST)
Message-ID: <f3644b7f-ef19-4b9b-b8a3-b1e2622b8027@redhat.com>
Date: Thu, 2 Jan 2025 16:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250102152513.61065-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250102152513.61065-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 02/01/2025 16.25, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> AMSAT closed its email service [*] so my personal email
> address is now defunct. Remove it to avoid bouncing emails.
> 
> [*] https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-tricore-cross.docker | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 479b4d6ebab..7e00e870ceb 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -11,8 +11,6 @@
>   #
>   FROM docker.io/library/debian:11-slim
>   
> -MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Thomas Huth <thuth@redhat.com>


