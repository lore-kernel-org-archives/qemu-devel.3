Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE29C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thblu-00041p-7B; Mon, 10 Feb 2025 16:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thblr-00041H-Mw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:56:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thblq-0006j7-8u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:56:51 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so718546f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739224607; x=1739829407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJQjl73eRofuwRcg21XrKJ694zjYy+X/+JQ/eJoLN+w=;
 b=qkdZHBIFlERa8Rqxze2EjPpz3+HTNHKmmuARWwd0D+k9ZM/hv4wsnSFmjk3B5IBw0f
 q5K/gbClvAQFwRvis4iy4V3BXsPIIU3kvkkQ5CMVRZktwqHGJ5v5oScBiPDBKXbAlOlO
 wuWgqpvVgcrW9n7gbiTHYmilfrrJxfZpqek2gTGVEOhTwPL3yOy/mQYzGzRe6ozHCzeq
 jC8+k7tJ0GV9PjsLElLpa+WWEszfrPcbE8WnCnfvLMcv0SxBWhG3hz+dQWVZ2yxQ4Yvd
 ilRkliR6tlCcZ+jfnB8gkFotvgJMOaYUdjGyYTpQ/QGrQMIMk/1isUNC/2rDg3QuoOjm
 aYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739224607; x=1739829407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJQjl73eRofuwRcg21XrKJ694zjYy+X/+JQ/eJoLN+w=;
 b=JVtYEkvX/+r8lk+PLFsE5GA4nNqA+mpU5C6kNJoGFQAGGhyYPn9p4n0fYXG4UnLQe+
 cSeBZ9lELpOlUt6GHoHfJGhwI7+xLOKq3AjyP4GUqerxAz5xMylHLQa5y56ZLPPr8WvF
 dCh3JIizA3S4Qi5HcBaSj6k/QFUb+ZFghs/M2gzpLnuzRabztrXG9LF0arXC4qREQ5WN
 5kA83z4BzYxX8izt3vJyrmcP63izMcAcxsb8ATpMFpg30uk0bPeLcj7XFYlaTTz8JLNd
 +DIKygIhWrkUwa91jden9++Lk7k2F2PLkqxMcNMCkufUJ+KptLZ5Nf/JYjzkck0MqDsb
 5dKg==
X-Gm-Message-State: AOJu0YwGfRvfo/LHCnwCHw4F3hZnoz33o8Ps0q2tXbnqpuiX5ZFpjRoa
 0iq6NXwnq/HUUV3zo6uaRdxIgNUsHUSp+D6UyEFqLApuZESJwZd69bzZigxyIjUn/U7L7wkRomR
 4Cuc=
X-Gm-Gg: ASbGnctoBufg6w+aMHG8noOz/8julN50QLNz6GFr7LmDbsEAoKp7t/2ci8F5XEROESw
 YB2EpzBoZ2Timk7bzGxk7HmDGFdJ/hmz3Vl7++9KRIj38k10BNCuPXBoGnHEim190saBgVZnfoU
 odVExyIT2feMMN4v8UTVH8LjScRHIohvtiemh+9jdVxDq2m7Zt4po5X2ZYh/NRLnAa99WGLeiik
 AGxwJqYZVoY7EdwbiOKm225K29BBI+W29qmycgmyMm9Ax6qiO2e8V21vzGFuyCvUy30lj+fNhIC
 uwqvEU/OnndPQRRhqUruNr8l+LpYvfbq+SYs4kU8tmye6njD4leS9Evc5JQkuEtC
X-Google-Smtp-Source: AGHT+IHbpn1JM7uo1XeA+cEtDXCF3d3VewlIQDG/09fUcPiIIt3lxdXjTZYr6kAI4bi1mx6MS6urZQ==
X-Received: by 2002:a05:6000:1fa2:b0:38d:d43c:31b5 with SMTP id
 ffacd0b85a97d-38dd43c356amr8162049f8f.38.1739224607172; 
 Mon, 10 Feb 2025 13:56:47 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394679a3a1sm34143905e9.5.2025.02.10.13.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:56:46 -0800 (PST)
Message-ID: <7c71885f-6e55-4d36-98ef-8b226c238662@linaro.org>
Date: Mon, 10 Feb 2025 22:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] cpus: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/1/25 10:30, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (10):
>    hw/core/generic-loader: Do not open-code cpu_set_pc()
>    gdbstub: Clarify no more than @gdb_num_core_regs can be accessed
>    cpus: Cache CPUClass early in instance_init() handler
>    cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    user: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    gdbstub: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS() macro
>    target/arm: Prefer cached CpuClass over CPU_GET_CLASS() macro

Series queued, thanks.

