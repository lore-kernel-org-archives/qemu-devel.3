Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF492CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsB8-0003cj-FD; Mon, 18 May 2026 03:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsAv-0003bl-Od
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:14:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsAs-0001RI-A5
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:14:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso21994855e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779088424; x=1779693224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eF7+8LhB3URDftPZZuw9PrS0HriqWeTEB1QI+xmsvx4=;
 b=WQpJHuIEV27OjConnCvuGL0PofIhKtvqYOlmqOg8L68Bh2C7YMVtIKIEH0WGPvSUN3
 Bzg07vsVbQpmxsXtJ2u8ryme63OvzpDXFTda/ov03+G9W22AjfPTl3AElr8+O1UtQdT2
 r2iuO6aOtM76GQARDERq7IugeIsh5Y6srtKjIqVmziHDG6UtM0L+y6If8bFpr4axPzlr
 NNol2utz5ymEuSWt8/UvtKGuwxYYNRrwOaL6n91GBHXOivuHiBv7qiqQCRe7rZMBrTR+
 DD3IaUispxwlwLvOcQLeD1KvdVfEbe5dQJNyD3vhsL3pDEUsVraparKbsBeDunjw3Stm
 mvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088424; x=1779693224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eF7+8LhB3URDftPZZuw9PrS0HriqWeTEB1QI+xmsvx4=;
 b=U8V8EGYIfeEWwD/s4s3kuqZsXy9vLLyjLbSsP+pXrzkk6KFioo8gnncbq3OI/DZtyc
 /k0Sy3OTjsLS2EcH2ETDK8gua+0jSpDgOIOBD2DdNYhwwXw+nUlAfLob+DkkWCtMEQq7
 hJ2IEEtGP7MYyN4meBXCJpizTHiaqdeyhX1Jx+en9hguGjDt2WUl4r+JtJ1nBOdNTNMH
 UCc5rLwuunFxrpxd4E5HYQRYOFVofEQmUAVkxF+6LNSDN0M81Q5S0R68VXMhd3YTB7xq
 fCWik7qYz6hFvwO+ZBSUJZHHqdokNZkxfHpvA7vLHc629QfgO6RmhEJlBc/UcUBeCfb2
 peMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Xunzvl2SrQKfOEGzT9L5NaCAin8OLqgZK3PP3EoTs0YPwmON5DXqE8Dy4YZeIkYUDRT4NUGpnB4MP@nongnu.org
X-Gm-Message-State: AOJu0YxD5m8e9ouXbfS+SSbVqQhQXwbeLZrhq6J0xTClxKO+IoPYHe3V
 6vPkB5fJO1bYY6F8YvzmRbjeXpo0w51e0Xx5AqCci3sdqsijKOvOIAbiki4c+0MRUao=
X-Gm-Gg: Acq92OE6YXM4xMQ7b7YyPAAd2CXi/CeiZ2XlklbJS9taOG62JYTXcNlLcpeHFuqZSWx
 TLANet9R+xi7Tunl3ropaqqf2oXa4u1tazQDHFNe1aFjGX/vxt17vx751ji/uUibfdXieai4rW9
 YmxR5Tzz7Q+dXaA1EMAgwIQDiXt5rl8VpPKg/VEEH0HwYa+Bl8o3FVwCD7wb+Ynu0tqoOBnyUbv
 g5sJrbSBbz8U4gqWUxrJDI8zL1iif18OvsDypgs8H2vXvfF5X/PLlBLH+YpePQt1HEZLAs151uv
 Yl3u354yJmlu4Fnngh8o1YcRc4FB/QeNl4XYWmkMQQ8LT/LWvowtp0tJFIFMaYRbAhGlsYl61NY
 U7Smxy/zoYU2DWqbU/oukEb1e0dCW9srT911wYQsdJgwBMYxIaNJQRw2ik6PnQxv30Ktt7lso3D
 bPRrK3kl6BltpSJTwPCcoQXLT7icsNhJ7LR4J3WKOy+CBAFF9CkWxkL8OwxBdSRxGr95xFj8k6p
 AdH
X-Received: by 2002:a05:600c:a30a:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-48fe53a4866mr153451335e9.15.1779088423964; 
 Mon, 18 May 2026 00:13:43 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab6aasm250169245e9.2.2026.05.18.00.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:13:41 -0700 (PDT)
Message-ID: <91c8e98a-d900-4ece-9fce-0d193aa763f9@linaro.org>
Date: Mon, 18 May 2026 09:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] target/riscv: Align pmp size to pmp-granularity
Content-Language: en-US
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>
References: <20260518070725.9816-1-jay.chang@sifive.com>
 <20260518070725.9816-2-jay.chang@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260518070725.9816-2-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

On 18/5/26 09:07, Jay Chang wrote:
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it needs to be aligned
> to the PMP granularity.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/pmp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)


> @@ -263,6 +264,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>           break;
>   
>       case PMP_AMATCH_NAPOT:
> +        /* Bits [g-2:0] need to be all one to align pmp granularity */
> +        if (g >= 2) {
> +            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);

deposit64() could be easier to read here.

> +        }
> +
>           pmp_decode_napot(this_addr, &sa, &ea);
>           break;
>   


