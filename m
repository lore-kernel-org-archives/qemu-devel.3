Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE02C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR25w-0007zo-Ov; Mon, 16 Jun 2025 01:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR25t-0007yr-Pb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:09:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR25r-0003PH-Ul
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:09:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so29183415e9.0
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750050554; x=1750655354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y377tA3TJ8POVFAfNSK5I0mnXGUtCQSLClGcjp1KFA0=;
 b=BfDJ44iJqiwVPy5ns9JTZ/aQI+tv4J195GzEU90fI0X10oEIyJ3PUqyzZiWhoXtPC7
 LYuwKiY3avEk27+sGuZ4WyEP5/3xZJQmqa6Y31xu8fbhcfyK6sntIRAD3XvxhalkF5HK
 BcR6FS5zbLqhGUKDYN7JerNX0yrBvq8gUR4YR6lzGDJ1Z6Tp2I9AYdNL2gD5U/jOOek0
 rsygShndXCONHXJWFUcklolSbYCas7cot0/qTj2R+pCxZ4bT234gh67qUEREWOWKerdv
 jZRugvhDnoMmPWE5HQep+Dflz3TjmWrF6h8uZuuDBDaxYqbNwvKfdPscTpMNAxOZue5Y
 Ka/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750050554; x=1750655354;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y377tA3TJ8POVFAfNSK5I0mnXGUtCQSLClGcjp1KFA0=;
 b=rRzG7wRt07CRz5UPzlhv1pOjzJaSL/Z0S/K8Yl/4YGwAUEnCSkt6BWb6Lyq+dROKfi
 8kPKJwI31++QR/ct24LJVysdVsidciP/Mi5e0i9AG4KXFCRBbD/ew4Pc7onY0at0YqFo
 XgEunV2psD7UomgfXtscR76m9hG2Q63QPxFEiV/hroOzAN0D3dET59RG/55um27R/kPG
 b7dq3jOBz1f2mwpcumLRHIN7rXLWECH1f828dOLNgj+cdLC9qTx5/a6T+7Qk+HvOlgio
 aMClCtl0eM036TDCqU9vCncz+8hZWTuOL/qJTyND+a97LHHhI7eKmE347yKpp+98JyDy
 qsmw==
X-Gm-Message-State: AOJu0YzZ19jT9F7IIybyX4UomPE/eeQO3vVuzSCIUNiGppucYDuExdyq
 TNLcaE2mdelWbujhE5q+Wo1RMH4/d56f2n9fymY7f0F+Dd5riGfFMbBn1UKX4LcRk1m1pEcPH4y
 tcxQmhXE=
X-Gm-Gg: ASbGncsDfx8yIx/7jl8NpiaSLcFpNMxrQzNZ6NAnHevZCLrgbj/RdlLHFF8ZjSm34Pw
 vO0qomCnMGgPRsarldFFINQdzvZRzoFW8XKbwLoCfULIlqPhN5l48zAopo2uxGphw3+6O+q3GN1
 zoKDzcfcaOfFGn45Xe/II+lJefjVeJaBUzDnB2Eg2AMk4ttRZZ3Nc/ozNJxbp0xCNWXaoJe8cBw
 cNtlVo5km1rJd7pNRtuQEkO/Q0ihg3mdg/JhRdHdOgQVI/5UpsDCTcceqSrU4GogZEPpj4NXjHt
 SIPrPEgJDjMGdFbNGrIYYEbI+qiOj8OiuowViNA4Q1l9tqr7mZ8Pg0sFxBShzxWhSdQVCn19dhh
 +JNlIObuYv5HwQLwIFRi8ZKzeqZVecA==
X-Google-Smtp-Source: AGHT+IEo0NCT/0ErN0Fw7tEwjIya+X4aNfXq4/mT0IXG+jiZAU3HrBmP1fdC6UoLNiB2nqSt/588bA==
X-Received: by 2002:a05:6000:4b03:b0:3a4:eac6:e320 with SMTP id
 ffacd0b85a97d-3a5723993bfmr6276243f8f.3.1750050554125; 
 Sun, 15 Jun 2025 22:09:14 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b70d77sm9993803f8f.94.2025.06.15.22.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:09:13 -0700 (PDT)
Message-ID: <7d1ddf7e-b16c-4820-958c-0d03bf8479d1@linaro.org>
Date: Mon, 16 Jun 2025 07:09:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU emulating ARM Neoverse N1 unexpectectly emulates `retaa`
To: root@wjsota.com, qemu-discuss@nongnu.org
References: <1235E663-AD2F-499E-8CF9-16E54A1C01DD@wjsota.com>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1235E663-AD2F-499E-8CF9-16E54A1C01DD@wjsota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Solomon,

Cc'ing the qemu-arm@ list.

On 14/6/25 06:51, root@wjsota.com wrote:
> Hi!
> 
> Is `qemu-aarch64 -cpu neoverse-n1` supposed to emulate the `retaa` instruction?
> 
> I have a binary called `main_pac` compiled from https://learn.arm.com/learning-paths/servers-and-cloud-computing/pac/example/ .
> 
> The compiling command is `aarch64-linux-gnu-gcc -march=armv8.5-a -fPIC -pedantic -Wall -Wextra -ggdb3 -O0 -mbranch-protection=standard -fno-stack-protector -fPIE -static main.c -o main_pac`. The binary includes the `paciasp` and `retaa` instructions associated with ARM PAC.
> 
> ```
> (gdb) disas main
> Dump of assembler code for function main:
>     0x0000000000400858 <+0>:	paciasp
>     0x000000000040085c <+4>:	stp	x29, x30, [sp, #-32]!
>     […]
>     0x0000000000400898 <+64>:	ldp	x29, x30, [sp], #32
>     0x000000000040089c <+68>:	retaa
> End of assembler dump.
> (gdb) quit
> ```
> 
> When emulated using `qemu-aarch64 -cpu neoverse-n1` , the program completes without issues.
> ```
> user@dell-op7020:~/learning/arm_learning_path_pac$ qemu-aarch64 -cpu neoverse-n1 main_pac test
> Hello World!
> user@dell-op7020:~/learning/arm_learning_path_pac$
> ```
> 
> This is the case for two versions I tested:
> - v9.2.1 (Debian 1:9.2.1+ds-1ubuntu5)
> - v10.0.50 (v10.0.0-1610-gd9ce74873a)
> 
> 
> The expected behavior is for an Illegal Instruction exception to occur. Citing the Arm A-profile A64 Instruction Set Architect Version 2025-03, the `retaa` instruction should return an Undefined Instruction error when the PAC feature is not implemented.
> ```
> if !IsFeatureImplemented(FEAT_PAuth) then EndOfDecode(Decode_UNDEF);
> ```
> 
> The same binary was run on AWS’s t4g.nano running Neoverse N1. It got the illegal instruction exception, as expected
> ```
> Core was generated by `./main_pac test'.
> Program terminated with signal SIGILL, Illegal instruction.
> #0  0x00000000004007d4 in func1 (s=0xffffe2446636 "test") at main.c:9
> 9 }
> (gdb) x/i $pc
> => 0x4007d4 <func1+36>: retaa
> (gdb) quit
> ```
> 
> Is the emulation of Neoverse N1 behavior correct?
> 
> Thank you
> Cheers,
> Solomon


