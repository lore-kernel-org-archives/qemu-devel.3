Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0253D26D9E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKAq-00053T-60; Fri, 09 Jan 2026 16:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKAn-000535-OE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:33 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKAm-000477-7F
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:33 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso2122924a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994651; x=1768599451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bgkUQxpkDz10WUvBa1peS0lOOfFe8HjOvf0xQdvsaSs=;
 b=DdZofA9OnKJ4rOjbLQQfxgGXYmJZ/ZDLHePp5D7xJa+0gWHPJ0KBdzpAnY4dyQH/lJ
 GylRZkLLmSl9PGtXf3szKDf2QhKa/ZdOcC/eVbVvEjYKis2MZWOv5orr+9L6v8AZ7aWQ
 vAQfrZXEH0AgiaDOQMEUmzPmaE2tJFCAAqmnSwwc/wlFQPje6ohK+S9/L9CeVe3hpjRk
 qDQW3sHhx/KQTZuF91HBkqX4TwX//G1HRGnN7XHY/Qh7+i23h8yHKbiBLpx+/Fmja0/i
 94zPl6Nu7UhNFerxUeo+x5Mo7C6urnzlmWVXqzfmNxeHKwWpUf1CWwP4YGexb3jGIjjV
 ToEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994651; x=1768599451;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bgkUQxpkDz10WUvBa1peS0lOOfFe8HjOvf0xQdvsaSs=;
 b=eFH/uTnw0ljCqUaKsk75vVo6o5ZB/v5v495ykQXs6OQqhcGU7d1HEld/e3x6e64RDA
 +7DfU0sH/7oKJ8MXws72oY/q2kP7KFXf70cQiU+JWOMSKc03Lg/Wm4UrakhfnTv73WtW
 3rHLv/5pzbsahSknEU32fFFEgarL/48ifLK3l0z1YgSzzECQ3VFH89GMg0XgjgvdD4qA
 1TVorTvXcTi0zVr8PT1vzml0esV21ARd9konTZU41ACEyUS7/x4xW20tEPxUinGWbeVk
 pwO7D6jezOKOJbezAAnX3IiFtxVmkL2oHFni6fGG/XX+onAM5GqU2408uK20NjgUAEa8
 RgxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6kfCSyRlCvkDxButkbuW6hgkXoDkjxFeFgdrdVIENBpvTSW1IkuFcSVXm77S9c+CsyOIXxzV3230@nongnu.org
X-Gm-Message-State: AOJu0Yz8/sbeU3N1tOrGFNsnkiGbLU/103eZVrPJnluPU4FecUDxP33U
 6jLWAzbxICuPOdmOSJFo3dZTfTKtEhGmpmHNao5g5fm7eauDyd1G2FYUywTpmPwCECE=
X-Gm-Gg: AY/fxX6dqfHKwiQHHW8KipmHQX1ZV8D/NEhIWeOvn3tpMe+GpKNP8Z0dOrhfs0nwGFn
 VyyZ+jEiwE1TKFJEbd20VpVTWLY2M2ySGejI3Av9hujAv7r3ZwkKueweooCv7lUnm5w+MketY9h
 wTuZCXsHtNbOF6sP0uQhI5MzZI2TRtTRlHTVY8Fhds9SN1bZDtm9VbLLVs/TZJxb+W7Ve84dLDr
 rMxDGc7rWcx5MnHfTKoDCnSRNZRUqJC3W0gyRXBzN31qbjFZEARLFyGazOn5fyby26PUt76vbE6
 zK/arNjvUeOOW2koWgVv6syi7vgh2ceR1DLgLaOmgSwP0RufJFPp1CO+LsMKOZoHtZwPTJ55EYo
 akzKKCNjGvRdyrQne3KP3RhfLUS5cTuTQ0kdOg5wsTJlwZ1Okz/CSy6uyYBYgZWoXLL490Zr1kx
 D4NOeE7ZYkjyXKh4JweH51my2IOA==
X-Google-Smtp-Source: AGHT+IF2GzRQyZ6kc4rOHWytGAhawyxa8XGpzJmzBSuPfxAIw1lwIZdsd4WCi4NIp852QHhFwxn5qA==
X-Received: by 2002:a17:90b:5287:b0:340:bde5:c9e3 with SMTP id
 98e67ed59e1d1-34f68c91773mr10469385a91.23.1767994650749; 
 Fri, 09 Jan 2026 13:37:30 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b10a44asm3212050a91.5.2026.01.09.13.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:37:30 -0800 (PST)
Message-ID: <5dcd234d-6bf4-4202-b375-44a211f0341e@linaro.org>
Date: Sat, 10 Jan 2026 08:37:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/29] target/arm/tcg/cpu-v7m.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 144a8cd9474..08ac5ec9906 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -49,7 +49,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>     'sve_helper.c',
>   ))
>   
> -arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
> +arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>   arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>   
>   arm_common_ss.add(zlib)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

