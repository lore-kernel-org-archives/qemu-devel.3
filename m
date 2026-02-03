Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626CBE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnINI-0005vw-1c; Tue, 03 Feb 2026 10:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnING-0005um-Sm
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnINE-0004cw-El
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so55351195e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770132684; x=1770737484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNqnOygkfZMheB8Tow4KNZighzjSNMZh2KGjaC3zKYU=;
 b=bnkcme7vxOt1FE3bt0ijl3xkNPma8jOky/RXP0FGNAX77AKIRMDAqMsR920sXGHv4L
 255/I0W2Rwu+SUUlzW02nwonbvNXVr77vQJzR/FLSbPa5MXMsg+DVx3eP975qptnbbBo
 72NMg/rwCkDrBCQy7ADF5oqHuqHgIPyGQfwkNOSZRwFQh+bmNd3ZPnkTgFp5p7FqbABO
 lJiFnoZVY633FJBkmOSRLAhcHVk+EsxHr4qBB6AogpqjQa5Y8G6XkukwCFZZxemld0EY
 H77T2vm6UY7sWfJbrTMZ4cL4WnYDoVjMPaUR3LfqebjKOCa1VzYRgvX1aloeydiSSJEy
 Uccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770132684; x=1770737484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNqnOygkfZMheB8Tow4KNZighzjSNMZh2KGjaC3zKYU=;
 b=VnKI0Cj6wFp9Vs6ytgbGQnejWDR35jY/EJXjlXsPcygx/libIGz8+MC+/s41VWeS6n
 ok74VZrH5VNR5gU8t3wWDGAVTs/tvlnSI/s5DSygKQqcHUezooSPYn4taZbLVQyjlJjT
 I3o2e4u76PVlsvhnffa5gHh7DiatWj6LOg1/gzWznaUiFkCsN/go5xvAJ5KXmS/o5s/Z
 amgUq3KKXc+JvuvIXW2Kr7nEIg7TqqE/gulx4DzdX3MMgr5/HSeTebb6O1fgXcoQAIgG
 oKA71jzuCjvz3OEl7GtR0Gbw2XOP6pYC8gFRQymPkzEMQxdqVKxbHBRmvUEmkHVb61Vx
 VPZg==
X-Gm-Message-State: AOJu0Yw4vs9L1OL24DW+4VMLvk6fC/sTBU++wxTElf/Aa0rtjEje5EAp
 gCfWwZgClkttZQQ5iiB85UARrf109xOTr8xX9JS4BAF1SgLpM1TYY38kILxDecfeNMHeUrSl50t
 Rc3zkFA8=
X-Gm-Gg: AZuq6aKq7tdV4AuyhYdFlMWanOw+84OR1q57xmFMdP3M1W6KpWH9c5Nrn3IJ4m4fKVS
 bIbcTVv9WU0DiHiocf1zXIrf0QQX08V4PSZNPs4ZzniPzI1HD4Fr9dZDmt6wcblpVUudK4JCKfI
 U8YSBF34EK62eSeC9Ti6foQTyGC88Bxt6Db+eiTVFwImrvCxRB4Go0q0sVMnhM9cu4/c9gILK98
 NWNp/tRxd+LAn0wqW9SdGXWthsNCBRtrsXmcys9fcBR4y7dOBLuW3RRO6IlX/n9Rl2S5oknCNID
 FwXVhq/MTaYR9af8PvyTIuuD0wRkDo3QrI82Noaeb0g3dPbxSv85tczvvTv2zvRvVUbpb0z0PqM
 kzmcGoeDtPhHRM55H2nMGsbUYPsmarO6JIE9gQ9s1QRuva/1bHGt0KxgN7OkvJVa+tLjgK+yGlG
 YVWl1jG8lqfSvD2yxlTJMl3XJZy8nkFijTuw+enXFnfWWh/3kmB2dhLw==
X-Received: by 2002:a05:600c:848a:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-4830e968f26mr322975e9.22.1770132684513; 
 Tue, 03 Feb 2026 07:31:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e297119bsm119316355e9.17.2026.02.03.07.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:31:23 -0800 (PST)
Message-ID: <0f2cc86a-0cde-4b06-b73e-604c46256b8a@linaro.org>
Date: Tue, 3 Feb 2026 16:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Inline cpu_ld[lq]_code() calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260202214317.99090-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260202214317.99090-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/2/26 22:43, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ldl_code() and cpu_ldq_code()
> wrappers, inline them.
> 
> Since RISC-V instructions are always stored in little-endian order
> (see "Volume I: RISC-V Unprivileged ISA" document, chapter
> 'Instruction Encoding Spaces and Prefixes': "instruction fetch
> in RISC-V is little-endian"), replace MO_TE -> MO_LE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/translate.c  | 3 ++-
>   target/riscv/zce_helper.c | 8 ++++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)

Patch queued, thanks.

