Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494AFE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW24l-0001Za-3B; Thu, 09 Jan 2025 18:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW24k-0001ZS-GE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:36:30 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW24i-0004Bv-SK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:36:30 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so863401f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736465787; x=1737070587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtVRnH16gx13GY+bBA39wFX1i9mUcubyRjQKjhFk7Ho=;
 b=y9wv6PT0Q5Ba4qGDxjbbCewqCAcAkgYpkpqZfdbMPRNTE13LnWedTGyOXdrvs7wNwm
 8PKi9rya8/n14dkghIlzOeXxrMoeub/lhCFZuMx3iZkdbaeOt/QUAgGKt54j3Q4FBYP/
 xJYEh3YFWlItPIKF0Yz4GbMa8RMP2v64Z5fKLz5HXQlykyCdPWOckLcKf16plYTaimu/
 UqvcLF4cP0n8l+fkCH/vBdzlINdjmAQ7lXZMS4iFZrQoy52euu8S+ThZi/zGELT14jZN
 wApQD6LW0Kyxh25kzGXDXre4dWvQjTNcDveW9TIGnLn8isE0XUhDvQrFGlStdYeXqCTx
 +AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736465787; x=1737070587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtVRnH16gx13GY+bBA39wFX1i9mUcubyRjQKjhFk7Ho=;
 b=tMWXAZAFiXHqzvXBno97gXjP+4hwj8ZTu0nOZpxiujQHB7aO6d7IwE19rknpm9cTvP
 lNozDG69mcPnOWHt6DuR1+kmJoZ7D3lH5OjvSjlDwkqvMXbHccBpbcQDiWt4ZRNjZKTj
 4mTL1qYkYBxGZB1Mr7T6ozzsHc4ZL8ljN/06t11vwFytdR5izRVI/EyRYcFzcmbGtzxI
 OePNeKgfham2/nwRquHlQveTrGe1jSDetDcv5ah1riWo7d4nrL3gDRwdUlLFRtjv+F8a
 +lqk/dzTj7E6XBR3VeGhAVC4g11BQG1VMvTStJlELK74EQyeH91VyhNgd/pDYb25gQ0O
 B99g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2U8xfuE0LfRWVE0hw0ov06hh0sdxORmOW5v9q40pHH2nltzV8Qe3qTyXFP/s8uCc8oB+50vtJFMi5@nongnu.org
X-Gm-Message-State: AOJu0Yxykg1etDUaSV0ru+TG2DNrnNM/8/6kAvsE7fCXs9QrAx5koHSu
 EeV/ly1zpqlYnO0I0dRVu6XUDZ4UsC+hS5QjXvFxVqXl971FBGXGLnVOiOcOU80=
X-Gm-Gg: ASbGnctijtoHYBlxkbKxeZYohBIaFBetNQxqb7pzQ3dHsJnxTLQHeG8TER+CqSRRkAt
 bjxFa0Qxu5wzy9thN7FmO2qNd2/1ns7B7610Jg7lpQXQi74iHkPyPbtxcfUMWBT7Djj+24M5vwx
 Y6qk1ND6PpsUakXWHq0UZcKjiiry3u8hvV+lmk0zecSzQW6v88qK8eLA1lLWMPOqQjlIu34CAJw
 qC2THfJFfovf/qBO3wZTdDo0UVGh8E8Z3sgIhJH8MUrAvt7HtLPcW47CWf1vuKBG+FLkGRmoalf
 nEJB6N103ZU3okt8biwgvPIneL0=
X-Google-Smtp-Source: AGHT+IGEtB6PtCocvlBbNgc5WgwW1G5ZGY6aRzBez4YIs1JG43KfYYV82qXmcdMZrrcjLde36pOb4A==
X-Received: by 2002:a05:6000:1f81:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38a872ec38fmr7327482f8f.32.1736465787062; 
 Thu, 09 Jan 2025 15:36:27 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8ddddsm65813825e9.0.2025.01.09.15.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:36:26 -0800 (PST)
Message-ID: <99baafff-092c-4a98-ae08-e23882acd729@linaro.org>
Date: Fri, 10 Jan 2025 00:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/81] tcg/riscv64: Fold the ext{8,16,32}[us] cases
 into {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-42-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Accept byte and word extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-has.h | 39 ++++++++++++++++++++++++++++++++++----
>   tcg/riscv/tcg-target.c.inc | 34 +++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


