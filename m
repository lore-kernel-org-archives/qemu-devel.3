Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30843C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2Br-0007ta-H0; Fri, 15 Mar 2024 03:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2Bi-0007t8-HX
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:41:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2Be-0007uZ-RM
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:41:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso876581b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710488465; x=1711093265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3aV8HQ4WjKEMx6NnzvwRldcXujKdgr4tOTbHzt86yk=;
 b=TfvXYwsnWhnwWpx/F6DEBEBN4bN028hECbhQZ0s1qIsL2VB4cFch/Icru9UbwlX9FV
 Dn8ITnh/zDINaIkv6P8p1c+68qsDb83RZj9Vs962nBmpalxOy1tCrDc2XOJzhDfUwV9N
 059ngfJjc4C1veaTHDZmNsiOXVszrRiepiJySeJ26HVxD9wxFRUbFVj1RgBC8zEPcrG4
 s/kP/Rg3MBlmBrlus5uhaZOlaq+t2K3Uy4QtZjkCa3sXr0ZNLKFtRR8VzFqMI7HJgOYW
 SZBDVb7omrEg94De8HdUAgxm7Ub6ggcW2m+tfzzpi/oDP1VU00m3iSRQQ0B2YNTTzEj1
 8wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710488465; x=1711093265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3aV8HQ4WjKEMx6NnzvwRldcXujKdgr4tOTbHzt86yk=;
 b=btQ6b4Y5hxqbkJfD7/niX317D35UIDDEA7J0vTL2G3rAAuFTqRjmdwgn5b4AefHIea
 zqZEUxMO1ZDf0V9PHumgKLt9txH3MgiN59pAwYgKIzYh1Kjv28MaQ72tFaYjqeNExObE
 yjPLMJjOfXo9f8zOUCkRTi8E6AANNNVqRUSzT7GGAyY71i68SVs5DwsuOc82H7/IM0iE
 YpEZ7DWPUoHm4TkiVIPg8UBhMxZEXm0l/b+vayAqHtURkihrSt3peNCMRZFzjfUOzEN1
 igUYr6zffl2lY4PO6aGu2k2uYfngl8zeGluKCkAUtFtQmB7KHRlkBWoli2Aej3djLSU5
 f/rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE73jXQBxgA5Y6zac912BpAgk+5OHxNODdPcsbe7UE5qyUpFMOno6OXvkjQ6E9ySm26Y78nWaXRRnvFesLI+j6iUT6aLA=
X-Gm-Message-State: AOJu0Yw9ayXN/Wbtf7tIAp7T7wbD9othD19CiHhC8CIi3I88pcdM2mZL
 FFadcbwsMXTRQ+3rKv3tKOnFG9aYZTUhN0vYmXum2Qtipbdr/n3SM04rX6z1h18=
X-Google-Smtp-Source: AGHT+IHbGxM0DSSFQtgRxaDjsr0Z2kOgB9bhHRw5r3bWPAQMRUhflaBLcM7f0S/bjWpY1k6Sy+oY6Q==
X-Received: by 2002:a05:6a21:398e:b0:1a3:4bf9:c1ad with SMTP id
 ad14-20020a056a21398e00b001a34bf9c1admr2064429pzc.9.1710488465265; 
 Fri, 15 Mar 2024 00:41:05 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z8-20020a63c048000000b005c6e8fa9f24sm1926558pgi.49.2024.03.15.00.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 00:41:04 -0700 (PDT)
Message-ID: <db4aae50-7dd1-4960-9783-913c5b3a50ab@linaro.org>
Date: Thu, 14 Mar 2024 21:41:01 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix
 'vmvr_v' memcpy endianess
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-4-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240314175704.478276-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/14/24 07:56, Daniel Henrique Barboza wrote:
> vmvr_v isn't handling the case where the host might be big endian and
> the bytes to be copied aren't sequential.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

