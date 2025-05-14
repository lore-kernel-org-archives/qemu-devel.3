Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30951C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7KD-0006vY-HK; Wed, 14 May 2025 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7KA-0006tM-Or
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:18:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7K5-0004hH-G6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:18:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so3827315e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747210718; x=1747815518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TSd9zCPFpm9xCB2kRVM1sXd7mZ4FOuxpIOIZe1xh1bs=;
 b=YK56yLCxckAgmzXZ5+RntEs3fV1T7PqlAygpur0KeMdb5rSsSyCLv0YwHJNA0cyiiY
 D4lGVhfSFtt0RYsOo+WHLNc8f4agjZMpT5LAwvlPJJmQmcknNYdxHRiF1sNfV46OFG/I
 8uf/EoSdgpL6auP0NRIy5ddNjwUkIJ5+DPqpNScPE0F7e3cNacUuY3EneL0zXDZ5DTZ/
 gyv6l8KEhV3LEKRzTU8ekKoLOmx8vyNhaOfGNdpUgI3BxfkXqnOgFtkhy8YkT0rPDmv3
 BlVVJqEmPJAWKHlRMHgUHVa73twTd6IIhoeVPZ1UPCP27gx2SUqCZ50fJCOaPjsSkxsa
 ss8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747210718; x=1747815518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TSd9zCPFpm9xCB2kRVM1sXd7mZ4FOuxpIOIZe1xh1bs=;
 b=S8NYZV5SVz3T5ZJnNv52/LtCHmFjH1eNgvSnN2a5ewoHtw4063pF8jzdY90YlLcDlO
 ga35qgCouadEjCWXvSSHyvpROQTPPhZVxa0NDtD1815YNQuF7T50iJH916dFNcHolsvW
 7bBL4VTK9k3g6EGXUFfcGM8O25HOUwbG0e9TXKOH6IX+qOFzLzC9ygdPFLcgxeH9Hdql
 JYJ2RXZcR7/LUwguCchEfFxOMJSn3Vl/fwKlprnyIqcJVU+z712pqtU3MovJIKbZiXcl
 PdKVQhJ186PgssWOLmupDlLpnSkGE0Tk9v75/unhYZgWKB9rTBx3/ovcpoaqoWqAumJM
 oI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv7QNFfwQ/vqYvskrlsb0QoMdfKbC3AuJswe23C6QvD5UGYVoL/iKF9Lzpc3iKqBuZ9FuKKyWNE61b@nongnu.org
X-Gm-Message-State: AOJu0YyH35VVMd6wEvXqIo0iEGGOirMadtoBvuZSnYTTngXA3d8rS2KC
 M95LReGSyeHLnYkrUfChklUEh2wf9JQPegBdlRVJkO0nrTD9Itfh0igElE8MrhQ=
X-Gm-Gg: ASbGnctJEZmk87+D45z+xI3xgD7rchxDeiozx1ecJ0dl1tR9mbldcyiiKa6lcJlAjwl
 b7wAKw9Q3yIFyS9iSbx3BEQBMCXd2RFK5aWXL0m9qexzpJXinmDhpXQFm7tiZh15FYmm5EwajCG
 z5kpEZlciRhh2Xyu0KtNi0eJ7kAvqXb5MxIwmy5l5jIerudn8BqpsZ/8nejTxtpVagZApL/bOcq
 I+uyUrRC22RikfNHyO346b4RJhdv9oz/kbJnN6VwssBO+suMJLinvOKLdcP95obSNQNv1A4/AXm
 /deCrS2XoSdwtgpgY/NIP2KYB4g/SBj+HfKkccg1nGT6raa67GgEXxf+6Kdbci6MazGHt9caQU+
 Vws5dsW563t4gC4/9
X-Google-Smtp-Source: AGHT+IECyAAZq2FFWogvLnu9qcVnNjQwot7cxGTPLLdYpGuy3kThkOZBrQOcBBt+M4jhMzAbyiPzmA==
X-Received: by 2002:a5d:62d0:0:b0:3a3:4220:1bb0 with SMTP id
 ffacd0b85a97d-3a342201bd8mr4357468f8f.18.1747210718595; 
 Wed, 14 May 2025 01:18:38 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5d6sm18613745f8f.83.2025.05.14.01.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:18:38 -0700 (PDT)
Message-ID: <05b1a81f-9eb4-4066-8a0d-8c13a9a34332@linaro.org>
Date: Wed, 14 May 2025 09:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/arm/tcg-stubs: compile file once (system)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250513173928.77376-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index b404fa54863..e568dfb706a 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -48,7 +48,7 @@ subdir('hvf')
>   if 'CONFIG_TCG' in config_all_accel
>      subdir('tcg')
>   else
> -    arm_ss.add(files('tcg-stubs.c'))
> +    arm_common_system_ss.add(files('tcg-stubs.c'))
>   endif
>   
>   target_arch += {'arm': arm_ss}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

