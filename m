Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB11C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUhpC-0007gk-Ag; Fri, 19 Jul 2024 03:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUhpA-0007fW-NA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:14:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUhp9-0004Jh-5z
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:14:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-368440b073bso366741f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721373275; x=1721978075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q94KaaPd+AG6VtEhQmybQC3quzrJQbJCHNqATWTTd4w=;
 b=oH3C3f2qoSi1gwu7YnkoIDAYnF9MNFHjke0vy7OFAWir24lVqkax4vJQhcTZ0ki3hi
 O96j5kt4I9gq8/kZLM4SYdkCpQN1iaPOF7jaGI5Yd74hmvAJFZ7fnHtCzFkgIwK8Dth/
 BUT2g8Dd3Q6tkkzUHjKFY3DAZWy46pbCQuYYNAEsGOBbB4NKx5g6qBhKzdveBaiHf4/h
 mRAORbyKoY22NtRKFNYJnH7LtntiS3vuMukzXS1TuBQJdqgEc/f9HOZExXBKTEjbh1WA
 kFruqC0HJF5+p69dgWVxSB5WCZZDZHa8CIX87r78Fe1R01nKx3n2g2QddNmMPPmVSWRL
 hMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721373275; x=1721978075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q94KaaPd+AG6VtEhQmybQC3quzrJQbJCHNqATWTTd4w=;
 b=vSLlD2NrWT2JoGKkNSPZRdTLuyb6bjmTl4ycaqmZ0Q58VlGyMdx/BFHNiN1VJclFNm
 CLQ3zieW3ysdIyzkjddOJzAEdNwG3orgn39ozydj78wI4OSv812fJpLJjCOofvP6vEnR
 gVRFXHUDvbgJ+nFic1nYyFPzqdCx8RA4FTbgh1vO4TSirQAs58SusLqoCotfB8ZhRNmO
 xBTUmVM2rAq6x5SRxxQwwzVoNASs8SjAZI0+NAhvyPFaQRNuDEqw5XHb5D68S5GxyMiv
 jd2Z3E1m5G7iWqMezo5DVo6wEtZLNJTxYz21i24lbiT9hJhyKu20vTDZZLZxM2IalUB3
 uDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIKZfxTe4YrOGyc0Fvug8E7esn3bvtn3wIMI9LM1FyJcgIuim53bZVKtwYTPtQYLDDgEXqvgS5fw6zrKV8WHamP7RKlHI=
X-Gm-Message-State: AOJu0YzRVFnwDyXARZjlhi7TVvpIjgLgcaTb2rLHGY2Pj1CIdtXXngN9
 sZJHRmaz0ID9b0lZhpocccCvGqNlIU5ioJt/Bi9gS4aloy19UrrCrWe9TTp376A=
X-Google-Smtp-Source: AGHT+IGvZD6HcwpgTrFUcBdDdkSFOBBtRjw87wSiF2QAh2sItyBMXpRNXanwqBVV2xp5rZVsngLTlg==
X-Received: by 2002:a5d:64a7:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-36873f1810fmr1250644f8f.21.1721373275263; 
 Fri, 19 Jul 2024 00:14:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed7c3sm777377f8f.111.2024.07.19.00.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 00:14:34 -0700 (PDT)
Message-ID: <a278f3d5-28d6-4e73-94aa-1b1c53d3e26a@linaro.org>
Date: Fri, 19 Jul 2024 09:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/aarch64: Fix test-mte.py
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org, alex.bennee@linaro.org
References: <20240719004143.1319260-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719004143.1319260-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 19/7/24 02:41, Richard Henderson wrote:
> Python 3.12 warns:
> 
>    TEST    gdbstub MTE support on aarch64
> /home/rth/qemu/src/tests/tcg/aarch64/gdbstub/test-mte.py:21: SyntaxWarning: invalid escape sequence '\('
>    PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
> 
> Double up the \ to pass one through to the pattern.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/gdbstub/test-mte.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


