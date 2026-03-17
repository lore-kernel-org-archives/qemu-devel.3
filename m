Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1EF33833
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2RJH-0005qp-5t; Tue, 17 Mar 2026 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2RJD-0005px-Rh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:05:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2RJB-0005bB-8q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:05:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b4fd681c2so169485f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773741951; x=1774346751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bePTC6x9ABx52gcgngpBWxh6je2HUi72HTlKHovIp30=;
 b=Odi8VKdC8gnzGJ5fxQWP0nEOWFr5rWr1HWyW67A6YFw0vAuW74lNbaL9jBCPhAFkXs
 TsV64/Q0sXpZGD3Tq4ddx2s/tKohe3o01b6xYCO2SiaqwK5g2k+VEyGDRjbXMDWiXTUL
 uHQy1JTXo23FdsT8WARWFoI5EiRa3e1gGl7K5ukj/vBXzS9KCfYdGJzAqFvTaR6UaMeU
 Kz8qO26AfqOPQZTOZA6QoyVpDv57eZ0+252ZAGAbfY1RbZ8laa32XYQavYuYfiaxiy/t
 YOxbxYuR49KmVrEyzWs0PUandbPWQsttJiBYXZy7b1zZodgSQkQq6E1IhAhvu1rXXHv4
 /QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741951; x=1774346751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bePTC6x9ABx52gcgngpBWxh6je2HUi72HTlKHovIp30=;
 b=cXNXfrBUc6NU/OnebXeCUQYG9WBJEDgqavO+yCuXHgMXQ1fnES+mN+v2pqElX3WW9g
 Nau3qv9n1MipVK8FVmF1r3JNCICmPIS/alQfgr/Id6Nuh299gEUKSoU8qXXd9G/y3M4K
 ZHmKrUa8+8vyvwv/ttbYdsXTbT/UanZYARTsVoeY8dkAK2m7XCamAkeR2WbYN6d4rr4K
 l53GtJHvDz1kDdQSdZ0bj9Nq2SZXqS1Xf4rh731XsT9G8OhfxL1w7a8lCdRqXV6gkdaH
 Pe8kokBnPx1V8sl026v0iyAS0zmAZGbSylvLIyHLlNPQd0LtHo0eqkcv5Sae9nNQUBjf
 6ZvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyyTvLb9SexvAQRvX6iwQVeyhkoGSC6sCFbhHJAQZEKrtOoZVQFbahH4fWBAS/CAMwWOqdRsy9ocrX@nongnu.org
X-Gm-Message-State: AOJu0YwZ3Gl00W1TIEQW8t8jwooh8Foujb/KwZkzwIkinN/qdYGsGUWW
 8BL/cZME28ByLLLsTa4r0cnlVfcuWAjkM4SRXbffqwMTy/wl8JlTQuEcQpy6i8KQ0aM=
X-Gm-Gg: ATEYQzzQC1UEtdvcMBthCvRi4AfBbBeka8Htue39LoRDIOUFsELHIK9NKo6OUoDkBOq
 sWKcT6JrhkT3xMhUWPeatEnLhymCMl3YuThf7BnP8r32mUZcgqQl7XT+EHaO5FFLXb8rBdeWbUQ
 yqoP6dXYoIZTNiBF+H0Xtgzo+ZzEZH/7TL8+geDYwzErp9+zH1DburJPaXOm9gdcBwyl6US4RXS
 T+Cn08UUh1hTDsYqRNrt5o1OChqvadJVsbU6b0Z7uwNBH+s9Si9xCQ7aZoap+ayGeNXvsPrcD2W
 YVnv1LQZnC8svhCwU8ItCCVXRU5R3AZHdmjHq71WEz868uXaY5XZEPXaMu+Vo5XAjGluLXjAbkt
 vpCKwxZ54GvVKxQ6u1DMhYwYEAkHk8wpuY1MVdqm/IfMlB76b74KmeLjW//Fs1optDdpnPkMPlY
 D4+kvKUMge5LxcUNXAViW/2XDQ1rlx24Dm9NQyMHbWzzTtTnTrMC+IaX7ARlMCtSu+dM2aOFzKR
 RH/
X-Received: by 2002:a05:6000:2313:b0:43b:436d:782a with SMTP id
 ffacd0b85a97d-43b436d7b2cmr12883138f8f.5.1773741950609; 
 Tue, 17 Mar 2026 03:05:50 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b3d427457sm27902744f8f.3.2026.03.17.03.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 03:05:48 -0700 (PDT)
Message-ID: <abfb425a-50b3-4807-b600-6977b8d1f2fe@linaro.org>
Date: Tue, 17 Mar 2026 11:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
 <35544128-3c7f-48b2-a67f-9253cf8f5df0@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <35544128-3c7f-48b2-a67f-9253cf8f5df0@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Frédéric,

On 15/3/26 19:55, Frédéric Pétrot wrote:
> Hi Phil,
> 
>    my understanding is that rv128 makes no sense with rv32, and
>    the user is not expected to run qemu-system-riscv32 with
>    the -cpu=x-rv128 (it triggers an "unable to find CPU model
>    'x-rv128'" error).
>    The rv128 code just relies on XLEN being 128, and assumes
>    (implicitely I admit) running on a 64-bit host machine, so
>    with tl = 64.
>    The code is absolutely erroneous when tl = 32, agreed.
>    The thing is that, as we want to get rid of the
>    TARGET_RISCV64/TARGET_RISCV32 defines, the rv128 specific
>    code still must compile whatever tl, so that qemu can be built.
>    However, it should never be executed if tl = 32.
>    Typically, the patches I sent earlier this year to deal
>    with lq/sq endianness fit into that 'compile only' category
>    for rv32.

I'd really like to include your patch which fixes the endianness
issue I reported, but unfortunately as reported it doesn't even
build for rv32 builds:

https://lore.kernel.org/qemu-devel/ad717d8c-a6b9-4dd8-a4bd-fdd6d1d756a5@linaro.org/

Which is why I'm trying to restrict RV128 on rv32 binary so
we can apply your other patch.

Anyway, Daniel suggestions to use 'get_xl(ctx) == MXL_RV32'
instead of this ugly TARGET_RISCV32 #ifdef'ry is certainly
the way to go (which is why I posted this as RFC).

> 
>    Thanks,
>    Frédéric
> 
> On 3/15/26 17:59, Philippe Mathieu-Daudé wrote:
>> One half of 128-bit registers code is not reachable for CPUs
>> running in 32-bit mode, while the other half is completely
>> broken (handled as a pair of 32-bit registers).
>> Better restrict this code on 32-bit builds until RV128 is
>> properly implemented.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> More than 1y having issue with the 128-bit code path and
>> the single binary effort. Fortunately while I dunno how to
>> test 128-bit I could with 32/64 bits.
>> ---
>>   target/riscv/cpu.h                          |  2 ++
>>   target/riscv/machine.c                      |  4 +++
>>   target/riscv/monitor.c                      |  4 +++
>>   target/riscv/translate.c                    | 31 +++++++++++++++++++--
>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  2 ++
>>   5 files changed, 41 insertions(+), 2 deletions(-)


