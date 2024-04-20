Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8CDC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryDB4-00063V-JY; Sat, 20 Apr 2024 12:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDB2-00061M-OL
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:02:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDB0-00071u-CP
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:02:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso2523687b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713628973; x=1714233773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BoLqovIXCbHb2a5suK0j+Byhloar9ib+IoAnUpwn3T4=;
 b=jSxPGrfjpkkW+3HpPhGunf4QhgAVox31L3HdQNhSPz8yVoqtQP0vUkjPFieBCIDhOY
 Q1gy0KYht+XTVt8/mqfrGmV5VgfV/hHjKQPpEecOFsRtGQsZ3l4xvt0LoLolg4rpx1d9
 OCnZhkGbd4rGmJ0R4Wzwb8dQA3jG10q8aZp4usgifJ5ws8MY2a7I4WRUvm/0opLjfnNG
 DV7Y4C+xDGs+prbngBBN63uVCMXVsrIZdoMfAyB7nuHf1RZIw+JVzh9XbHBT/cdg583g
 PHAg1Ms5a4xMrarbfoWdVSymzjA77c/K/H1tCd+VtofCe/0AdLtb59hRJJMGHHLBV8uz
 mzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713628973; x=1714233773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BoLqovIXCbHb2a5suK0j+Byhloar9ib+IoAnUpwn3T4=;
 b=cn2PePBie1lFZ6fLXs/b6gVmnmFK6yRJDnWgyx+f6rDm6JnmwbRQw1I7pfjdvT6f9u
 oMl/OdJpa7sUcEZ7y2bRb6phoplPNgO32op532uz5Kpw2BRo/6DTQc8HbgMB/s54gEBy
 rXpB2CPTSalJYefnyFS8QdCSjBN5s9MfzJ2TsjGDTtPBjy9nukcDrGfJBlhwbL3ipDHh
 5Zd3qFeGOuoEQF2igNxDssFvTCVYdPzGVIuXoyjzFGNkFch0PHbt52Ve+RM0Mp88jgqi
 H8OJIIHlDtMb7OamAkiXPSaOEq8JG7c8poBNWLAss8ty7PXcb0YybmmoDfOUAd0fc38x
 sPZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsVgpy1J0pF6ewZw4kwUYXE6w5ytcKXkq1Wkx6sO1Y8/CI0pHhj623BAQbyV3A6xk9NJ5jTVcnXo08R807ZXXFc3jI0ig=
X-Gm-Message-State: AOJu0YwFlWV28nTYMexRsu/RrpJu55CLLFyVMc5tNB4oBQqUAiCRNMTM
 tn8+Dfu6okHKKHS+jeYPvvnTmHJU4YX7Oh9FZRmAPoPyvPQMx7SNWkzCUq9XJX4=
X-Google-Smtp-Source: AGHT+IHSA0BNzMTqDegyYFzJd9vF7Ag4vBVrCxEwrCtchtZTsOrZeoooOiGO6jrqIEDrNkQA9TpXCg==
X-Received: by 2002:a05:6a00:4b0f:b0:6ed:4203:bdd2 with SMTP id
 kq15-20020a056a004b0f00b006ed4203bdd2mr6926404pfb.9.1713628972818; 
 Sat, 20 Apr 2024 09:02:52 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 4-20020a056a00070400b006eab9ef5d4esm5031192pfl.50.2024.04.20.09.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 09:02:52 -0700 (PDT)
Message-ID: <abbc49c7-3ba4-4a7b-a707-b777bf2782c7@linaro.org>
Date: Sat, 20 Apr 2024 09:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use get_address() to get address with
 Zicbom extensions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <cmuellner@linux.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Zhiwei Jiang <jiangzw@tecorigin.com>
References: <20240419110514.69697-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419110514.69697-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/19/24 04:05, Philippe Mathieu-Daudé wrote:
> We need to use get_address() to get an address from cpu_gpr[],
> since $zero is "special" (NULL).
> 
> Fixes: e05da09b7c ("target/riscv: implement Zicbom extension")
> Reported-by: Zhiwei Jiang (姜智伟)<jiangzw@tecorigin.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

