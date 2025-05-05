Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9647C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBtJu-0007nc-EG; Mon, 05 May 2025 06:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtJr-0007nC-J3
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:45:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtJp-0003jx-On
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:45:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso36990255e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746441904; x=1747046704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G/Cs1RSBUq2rji5ltplqN53a1rlV5nJ16F1SyWjYlF0=;
 b=wiJfyGWWyL1Fg/9NQY3C8ujogP6odRYvA6/lf7mBs/q511rKLf9lmQS4sBA5CHmKky
 ajdpLL0SXqSJPjeX7BRpfs3Z5WnYdx43uqPolSGT4d+pR/ish95trxsUiJ9FlO/Nqzwr
 2z5m4FRlCEzrQR3JGhtTJGSZKu4/fvRvdbxgbaXbBByR0VB8yq4E8dROlM4wbtTnZ3aY
 Gthg+EQOqRgWDMm+/+KAxRmCY18SnW4RoVmi9+U81hzQd1ms2rHssoltdbh8TPtxiK8J
 UtY3jn3qorW8YBrYcqss5OvzReSPbRXgHQmjDLkg+CQNKZ4cCZw043YjmwNxWARi5dQD
 odCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746441904; x=1747046704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/Cs1RSBUq2rji5ltplqN53a1rlV5nJ16F1SyWjYlF0=;
 b=Z12oNlI9jstfSGLEqYIec8sLwlgdhvB44kvzAhVLj30dqVf3/obTLW/LJwiM/Ih/rn
 Ah4c5Q8VDk0ejQEtIJdgsF04c9SXOuwf2cSz7kGN5U4ev9JCLcjE1Bbl7YxWknejxY9a
 TxMT+wVhjcuAVuRJgZlpmlgUjHoxqmX4CSW/rEatEPWJNVG0GnLCLn7b+UdTIzd2ETv2
 iDY6AOyu+/Pq8VkpQOIW40Ze/SNZ1Fvn+TIYvi+Fkam9rysTPG2B/lzBYG3exwBt2CMI
 TUffDLH+7u0O9Mv5K2cimeHCih4rwkB7E+ziym8IkPKYwBw0Z2MMqY0hL+qxZ6dPHcUE
 glcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF5lwhbI8MRE3X8gLkx+jowGkBqQqEy0ORHvQFDnga/oxFOKXEaqTgqiO3xkqjlnjUrz/oJezrfi3K@nongnu.org
X-Gm-Message-State: AOJu0YxbDrqdMBZ3TAwQm6uBul3S0Z8lvDPvggTIGIMfLmFlgZMutnnS
 ztpDx4GWZLGHQVcugF7X37L6IX275CpiMofcPrutLlLxpav+o3FWIzJxEhReChc=
X-Gm-Gg: ASbGncvdF3TNunEusegzJFEzW7a2ffkRiXnGOdCGkPj/zBCUJeC6Foa1vthYSeW2v67
 7QAfb72X0PZyc+KSF6blJqI17YVV3Ytdwy8blWpWDHg9KkBDMZmEp41eJq1jqomJY8yuLIlFcXI
 wAzQ1GxqGx1Ke1fpY7q6dAI1T4kzM5MGM2ht5DRmz6VWBaTYU/pA1qfYtpeCF+tls++9xdC3LyT
 srrDIBGLFzrWixfZrCdcx2gjFHc4RMToxTUtj3lHolP1Yz5qX6Xdpt2jFlZxR0xxIL02omqHMvJ
 6EyCgMjzEh2gF7D5OFOPvdCZobDzsMdYXWTaoENI06lP8V0EVq9xQcCDhenPQcoEpSkZGZCEWrV
 7jam7TMN3DBtp5X97QfAHm22w+MNgze5Q+A==
X-Google-Smtp-Source: AGHT+IFtgkvljn/LkdGPid9VuERQ3zMCyCG7gCBmTMCWKhbiDFjLcP/CnujP0cpUmTX1PJ7YhzH3jg==
X-Received: by 2002:a05:600c:1e1c:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-441c47d3b12mr68549295e9.0.1746441904183; 
 Mon, 05 May 2025 03:45:04 -0700 (PDT)
Received: from [10.194.152.213] (219.red-95-127-56.dynamicip.rima-tde.net.
 [95.127.56.219]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7a46sm9856690f8f.44.2025.05.05.03.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:45:03 -0700 (PDT)
Message-ID: <dc27e3f6-ceac-4e05-9652-28634d4fe73c@linaro.org>
Date: Mon, 5 May 2025 12:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/48] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250505015223.3895275-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/5/25 03:51, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> CPUARMState::pc is of type uint64_t.

Richard made a comment on this description:
https://lore.kernel.org/qemu-devel/655c920b-8204-456f-91a3-85129c5e3b06@linaro.org/

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/internals.h   | 6 +++---
>   target/arm/hyp_gdbstub.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)


