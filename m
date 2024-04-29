Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3EEC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OiT-0002Qk-Mt; Mon, 29 Apr 2024 06:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OiR-0002Q3-2V
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:58:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OiP-0006f7-Dn
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:58:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41bca450fa3so14750335e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388312; x=1714993112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wa/IljHspj28kBwzqqjo3eNv2pivwJ/fIFPqlSCw4FM=;
 b=h5DImpx5hh94O1ZVWVq/Y6Ffhmvl2oYPumMgG1RV+ouvTFNdFXNiDqnzWnMnzs97Kc
 6uWu0kLjc+QUd0vTV/9sgBTduirSdOyxHWq0QFtwmDD9acJyqbc485YofX6UIcupnqSe
 FHhJa9gI9/iX61gbb3KAXdd/LWUYDNFRMLleVLTfi40BuUv3PeFFiqkonQ+zAQoyR0MF
 Bu4y+qakvMRVcACymqNLVY2kLrZI8SbFLGPC2ogYJS0GHk4tJo17BY3nb1CCXm8ZcAfJ
 OA0jtG91AAjoRralcb6Sp0e6/zXyZC9yc7SsqDdj8HpslWR1bAEXb7dB7FgcgMKEtg/I
 z1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388312; x=1714993112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wa/IljHspj28kBwzqqjo3eNv2pivwJ/fIFPqlSCw4FM=;
 b=OIlBzA/TUxzIrgmcYELXHpDnEXT9F7dkVZbRM49dVN6ehJVnTI2SFpn6CQhQif4Bb/
 0avHOIXwmiKjCw2vjR1aFotZ2r77tyjOjqV0u+IpekTCFzip/rjs6HRTzGx7yFZBUfwh
 TWq6RQZCAEZi6EZifSf9YMKiq9Ex2CziJik2hbRRrQv7hBzv2sjGkx+xUrQe64Tj20xL
 gFHB4ufHBfT8mGAv1w5nkRvBQu/syZIZH6HL12Js0iS70tHQWroYhlUbD0L/+gjMCB4J
 rMXRWMjalX3CzOim815LM2Z0UuGi0fI+hb6CcZ+WsW1MOlw8ySjfMN94xh4V1/qV7K5d
 8yMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjE7jPhA7QhRRNfriaUXE1fXNuJIJ/f7+fhACBwPUHo1zzwxt+9Vi64U4gMr7/mDx7XYP4pwjTTJqkJuN83rUowz50my4=
X-Gm-Message-State: AOJu0Yxc4KB05pjjCx+CLWokee90iFhWNUsbOJQuvzeE9g7cmLwuqB+4
 wWtCuaBRLFDi6pW/D3RszSi0PrwvElfOruh3doaaj5iisglhoyvIMQ5ZmM64rx0=
X-Google-Smtp-Source: AGHT+IGj8fXYuut5oVVYLKrNQJujzm5bRzU/B+iVsQif30dgmPiETaGhry7tTSBbwEwVOUPsOB31Gg==
X-Received: by 2002:a05:6000:110f:b0:34c:77bc:6c51 with SMTP id
 z15-20020a056000110f00b0034c77bc6c51mr5594095wrw.1.1714388311917; 
 Mon, 29 Apr 2024 03:58:31 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a5d5084000000b0034c6077c625sm8072165wrt.29.2024.04.29.03.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:58:31 -0700 (PDT)
Message-ID: <d98feb5e-8dcf-41c8-a0a2-a0246f6649fe@linaro.org>
Date: Mon, 29 Apr 2024 12:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] plugins: Move function pointer in
 qemu_plugin_dyn_cb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
 <20240424230224.941028-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424230224.941028-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/4/24 01:02, Richard Henderson wrote:
> The out-of-line function pointer is mutually exclusive
> with inline expansion, so move it into the union.
> Wrap the pointer in a structure named 'regular' to match
> PLUGIN_CB_REGULAR.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 4 +++-
>   accel/tcg/plugin-gen.c | 4 ++--
>   plugins/core.c         | 8 ++++----
>   3 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


