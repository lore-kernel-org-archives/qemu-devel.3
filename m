Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B4C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE32F-0004Sc-0s; Mon, 03 Jun 2024 04:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE32D-0004SN-1n
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:27:17 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE32B-0007uo-FW
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:27:16 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eab0bc74cdso6830181fa.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717403232; x=1718008032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jBpkDvR9S2D1MUyxD+Qxkn2FCZLlM7gqNfcwW+P3UrQ=;
 b=iUyE7QB/orS1z5X6PVS2G128/uMr8DvFpkJGnb8dX9hHhmIm2aBVU/huycEO6yV5lU
 RG9vB0m1cqzqRDlCki6669IU8shFQhgzQPOoowMeJCpia/qbzvILUYVqkU3FOzFZHX67
 qDm1m/sGgoYaZHSeCw1O0KJ4ZJ/kl4IpwyIyIXgmOfEXHRWTEmAUhSf5dm8WRZwwdVXE
 OMH3c9bdYCO811zUoqNuDBfM/wY/lfAJrNv/8Hl0tA9yg6Hv6NW6ctFfu0yfp9cITd0c
 OIfkTBfqCHWDKzbTZxWzSpqtpYTkVmvVlO+3oK5qnRch4oyamX/7MvY9hP3jGdSU0TFY
 6FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717403232; x=1718008032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jBpkDvR9S2D1MUyxD+Qxkn2FCZLlM7gqNfcwW+P3UrQ=;
 b=FmM3mp5Od7FKDGFvslJgpfBIoBz/Y7wAs/GJ9uN/LCwP0OIDy8hm9UERGnV4q7RtJU
 08+mET1vqyjxi25hinqWrXNsFltkDEOXY6gnPG2g38rVA7wtIJWRb0Pjg86sfWC7r4Gb
 EDA2jIZ3+NzIWcbj+ne8wFLGQTRMcRuqY3cyNlioovKTpE+IEEiF3ABwr1IHOnB5wVU5
 mmlUnmcQ6yH92/ukjq5HxZEa4t9O213n/qmZBPJXw6X0OWXPhDwR2435wEPC8JrqW+40
 mv9pPisHjEdc9Y49WdICEe3FdIb47Y34m3GZw3Lp/FYXroqV/lZGf9tqkojq2CGBaGjz
 KtHw==
X-Gm-Message-State: AOJu0YzR7v31wx7y1ZWv0Qgh36Sbb5wOOAtTwRAQOUwO91hIqd4EUo5M
 E6Fu/JijELQPMrodgbij/VTKEOySiET50pjmfnwsibFWhUQiFwIGkkQlYjAAZ+PPuGmJogTkijZ
 w
X-Google-Smtp-Source: AGHT+IHl/Fo1pwWqbQ4hDrQdYCUQHvq2EIOV8ibNiJrpnnxzPoe/tRG0//m0hpi1f2cnQ3Mv/OYHzQ==
X-Received: by 2002:ac2:5b1e:0:b0:52b:60ed:3f0d with SMTP id
 2adb3069b0e04-52b896d4882mr5692491e87.60.1717403231860; 
 Mon, 03 Jun 2024 01:27:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04e845bsm8052695f8f.65.2024.06.03.01.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 01:27:11 -0700 (PDT)
Message-ID: <1abce060-99cd-4881-835c-1cedc02e61e2@linaro.org>
Date: Mon, 3 Jun 2024 10:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] semihosting: Restrict to TCG
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20240530145349.41309-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530145349.41309-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 30/5/24 16:53, Philippe Mathieu-Daudé wrote:
> v2: Address Paolo's comment

Missing review: 1 & 2

> Semihosting currently uses the TCG probe_access API,
> so it is pointless to have it in the binary when TCG
> isn't.
> 
> It could be implemented for other accelerators, but
> work need to be done. Meanwhile, do not enable it
> unless TCG is available.
> 
> Philippe Mathieu-Daudé (3):
>    target/mips: Restrict semihosting to TCG
>    target/riscv: Restrict semihosting to TCG
>    semihosting: Restrict to TCG
> 
>   semihosting/Kconfig  | 1 +
>   target/mips/Kconfig  | 2 +-
>   target/riscv/Kconfig | 4 ++--
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 


