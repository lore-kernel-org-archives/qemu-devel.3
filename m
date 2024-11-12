Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7BCD42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvPK-00020N-FI; Tue, 12 Nov 2024 13:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvPC-0001oN-Cv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:14:23 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvPA-0002Ae-T2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:14:22 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso56385325ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435259; x=1732040059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6PywBD/Fr0P6tN4i55wogc5cLse9fY5T8ZfgSvr0ws=;
 b=ySqhkTj7Aqb+Jx6ORrUaqVWR/tIZgIwCFrRsnOZ/L+Nq9mguqtd8Aax1mZ7vrldJ4R
 FlgpC7vUeOuXIcdSxCm1PteYKY6KSJYiMp5DKMi00gQSSty9pGrrFU242OrpHyLjHJFy
 Vm+M/RH2cxSKgcHP4O/k1qm2Amzd5DwWoAQvAY3skLmsUJXjlZdZYCa4C+ootlqoTY7f
 akTLikGx41PUUJhiYPmntEXOIcm9mrS9S8oFaT3H8yLwCaTTJTcmqlrCCs5Av4eIMs56
 MIBNMT1rDvpvvBiT9wY+YAx9yzTwaB9sBz6nEAPOPwPcdDbMqsNNYFFtmXUj33juEFeY
 oGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435259; x=1732040059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6PywBD/Fr0P6tN4i55wogc5cLse9fY5T8ZfgSvr0ws=;
 b=oX/6cj4ku8WyQtIqCWMO2Ed/waTBJ3swfofdhX57bqomIHFbhHyH7VOW8Ty4+h2NZ7
 OcGYePmd9VhCh5zHKS//3Qk6Q9tbvJ1PafJdTuxSA7ax5caDO38LZNW42gntNT3sVQcV
 /eM9b2ptOgvFCYcLcTLaJrUz//piaNajN6G9S84gMxuy/2RoSRL1J7qDxvcpQYsOAsPx
 Ve1siVWJaVE/it09QzunlQpkc3Ao9BwKJ6JUogG+Ht1co4wkKDSGgowmz6pw8PDvYFfr
 BeHGOoVeeIuTtnM2+/Sp+EtgKwb7XjaPGaixENCR6NLkV8u2V7hoMoXrWPefULhOxs5I
 dSbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmvIWT47BfqYso9qbcwLquGxHVWinggcekPkU8DT7A+Jhtoe0mbtF+c9u8MsvgrEpAMZgSU3jFZKf@nongnu.org
X-Gm-Message-State: AOJu0Yw4u7vti7nmDoo0/ekecplL3FM4RZNsys3rTHOAIk1s+rBFsf8F
 k4TNrIu6gDuj9iHnbqhQHHJoTZoUTRTTSQOLoBS1f/0bengzpQXi1xEK1aVYBpg=
X-Google-Smtp-Source: AGHT+IF/n1L0xncygsagip7rvwozWxfw9/zGKy2j9JkjWXYoZZhJJjRTFcGzXq3mko4NPz2JB4pV8w==
X-Received: by 2002:a17:902:ce92:b0:20c:f648:e3a7 with SMTP id
 d9443c01a7336-21183e40826mr240944595ad.50.1731435259433; 
 Tue, 12 Nov 2024 10:14:19 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e42053sm96956515ad.138.2024.11.12.10.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 10:14:19 -0800 (PST)
Message-ID: <f5e4946a-7050-4df4-b509-0a868736d7ca@linaro.org>
Date: Tue, 12 Nov 2024 10:14:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/mips: Introduce decode tree bindings for
 microMIPS ISA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112172022.88348-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/12/24 09:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<f4bug@amsat.org>
> 
> Introduce the microMIPS decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h               |  2 ++
>   target/mips/tcg/micromips16.decode        |  9 +++++++++
>   target/mips/tcg/micromips32.decode        |  9 +++++++++
>   target/mips/tcg/micromips_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/micromips_translate.c.inc |  6 ++++++
>   target/mips/tcg/meson.build               |  3 +++
>   6 files changed, 43 insertions(+)
>   create mode 100644 target/mips/tcg/micromips16.decode
>   create mode 100644 target/mips/tcg/micromips32.decode
>   create mode 100644 target/mips/tcg/micromips_translate.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

