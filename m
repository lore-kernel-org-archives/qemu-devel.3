Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD40AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 07:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6mHp-0006fC-VN; Tue, 14 May 2024 03:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6mHo-0006ex-V9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:09:21 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6mHd-0003kx-8m
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:09:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5a4bc9578cso676380766b.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715670546; x=1716275346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4+lWxFs2wtlX24WEMZeLIwE8PA1PCRV32w5dXu998A8=;
 b=uR8p43RsZwZDMEDmjxJ9XC6YMhUgdhuuOown/bRBO8m5/TZKhy0ihWMIX4QfkiXN+G
 ZZC7ntgptoSDCrBSW3Dg7RwchPTzY8cF8HPSvELXZB/VcnoJR6n7NTDom5yRehfoJQ7Q
 IrNDkEZJnwdHZZxw51U8W+oD0KYBDSXVy5uEhMIPcGobWA00h/s9IREo9Z2O5+ogjfm8
 cWQsCLoKLB0Y0bvhXuCLcDWjATw1oq4SaLoprzkaxwMPO/J0OF4YJ7ivCpOM2w4tuG7l
 kTR865wu85kHiV/2/EhZfBBArUKEjpf6c1PIFqvwIHgMNdENTtZ55fa2tN4b0aVaf+yl
 S3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715670546; x=1716275346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4+lWxFs2wtlX24WEMZeLIwE8PA1PCRV32w5dXu998A8=;
 b=rV6feD1gQm0szG/0zWi+QQqcVWfuTNDL2+P0yT3xRVyy5ot4V3nrhdsvggJ9i6HIE4
 OhVhYbsguEBLeLHNH70OJVfSInXtmJca68R0zTOLm+m2XoH/B6qJz+pLBYYE9GIOl9VQ
 LHBohnmqxlwqPr84SogOlmRewnE4nZZSs0SqKAx8Ci+0LM1OazZjGIbV0IYY/lcg46GF
 Mtcvv6v/r4J+8z1684et20EqpZ0AnlQ+R18gtbBrzsEnh3kqzM+AdrZk0T8jeAgPXWYD
 /r4Z0cKP9EQeVvQ4NwFQXuYXACVuBfOWl6FzPMfgSvy20TtAnwaF2oa06KEbFcj0a5Qe
 51Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmM06P8l4H23o4NWKJQuJEOD96NE5MB1qWny6Oy+IBUklPV4YVzd00hA27zjYMQMtyO30l4+sogDTPKjAYzlpaJl8Udwc=
X-Gm-Message-State: AOJu0YyEaJNTD/VRFGTthxAcpbzGFquVld55e9GOCrqtQ/1aNjqVCpi1
 nPyBbTbWK/vvaKyzkdd3DsopaCMwNOKeBXbrRLOFcTBJKjvfMDfWyRQtPlIv+bw=
X-Google-Smtp-Source: AGHT+IFzE2tpwm0M5pqRJSGBmM+Mzi3oohh3wfIfiQ80AuN01NDSv9G/9uPsqF2rCf4okKedIps58A==
X-Received: by 2002:a17:906:3512:b0:a59:a282:5dbd with SMTP id
 a640c23a62f3a-a5a2d676474mr1121873666b.66.1715670545834; 
 Tue, 14 May 2024 00:09:05 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7fdasm684484966b.128.2024.05.14.00.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 00:09:05 -0700 (PDT)
Message-ID: <862d4e3a-a470-4157-bdce-e2037f7f44d6@linaro.org>
Date: Tue, 14 May 2024 09:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
To: Alistair Francis <alistair23@gmail.com>, qemu-riscv@nongnu.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 bin.meng@windriver.com, dbarboza@ventanamicro.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, fabian.thomas@cispa.de,
 Bin Meng <bmeng.cn@gmail.com>
References: <20240514023910.301766-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240514023910.301766-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/14/24 04:39, Alistair Francis wrote:
> When running the instruction
> 
> ```
>      cbo.flush 0(x0)
> ```
> 
> QEMU would segfault.
> 
> The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
> allocated.
> 
> In order to fix this let's use the existing get_address()
> helper. This also has the benefit of performing pointer mask
> calculations on the address specified in rs1.
> 
> The pointer masking specificiation specifically states:
> 
> """
> Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
> """
> 
> So this is the correct behaviour and we previously have been incorrectly
> not masking the address.
> 
> Signed-off-by: Alistair Francis<alistair.francis@wdc.com>
> Reported-by: Fabian Thomas<fabian.thomas@cispa.de>
> Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
> ---
>   target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

