Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2C0C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqQW-00035p-8A; Mon, 08 Jul 2024 11:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqQU-00035K-MI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:37:14 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqQT-0001Kn-6O
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:37:14 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso2969415a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720453032; x=1721057832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MAFIySr/6ifcfVkzRdNJpopzwxbmdSq22xk3AL2kIs=;
 b=grggitXeiOoJ6rqbb8bYeK4rvPtDW7WuFXKoGT5evZPfWU7WLkN+MbxkGvnfRzXyvQ
 FYELhrP9p7b8Omi6nw9sMFo55BHHHs/J2cYs3Cqd01mAP8M2czfZKEHo/+1O6gP7cPtA
 weJQObDKDmDjmMtvWtovN+7XDYQ5o9lkD8pN/oEoW9g0jn0VefUiHjLsgOAfQnFFPbAx
 tTZPjLiL6FD5zpdM59fsMcfdU10tOuY/q1hYffDNf5L4MhF0DmtWH8F84RDCNIgOZMHA
 M9PSJT97JwMf4EYS/1bDLy2X0RHOnakdqAkyJ9Tl8I9jga+KkHIaszdZbqhulzFOANBm
 wWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453032; x=1721057832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MAFIySr/6ifcfVkzRdNJpopzwxbmdSq22xk3AL2kIs=;
 b=W4g3UJbIlVQis1EVy2emIq7qThT1arKLqyJXiQE+09119KhnozDLYiuAVtFpP2PEq9
 Orq8ieTdycY0zlZtsFDJf7KeU5ZwDbFaIP3x5Nj+MVxo1Ot+6ymhbS5CNo4/LCcSNdcJ
 kkUZC/xBbX044j+/FBSU936Y7M7K4nwEyiBnDmNNcLqB9Y2a0pLjLEkYCxTazH98cTqK
 r/sW36RagKlxFoTjJyOn/ulZLsfZxV5roXzn25TgoTU9W+wqK74+I3yWI49qQz/bA1eS
 g8z7HftrcSPGHJhD8+GL6ELW4AW2AW7MmiPnsYyP6SPePwUgw6ajxnbZYKXLc5om0zIz
 /H4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNGIFjPfHyPg7PmPrJoZgQyzGjwgHGH63gcGOc6UpY2ti6uNnmdr3Kgnq5CI2KFqJsGH/itoN1TNAjcjLsYTpUNKfCSU4=
X-Gm-Message-State: AOJu0Yy94uWT2VWVPTdqZ+/oKWzuM9IEXrgKVUZnK33TLwNLjAiYA5X/
 7aoGaxbekpCo+Yfhm8qt/umlF0LpTCTu2oa/1ejmm2g4aoSYClOcKzQkfF+spmn3L/D4bgmR14Q
 FWDY=
X-Google-Smtp-Source: AGHT+IEFMCXI6+dZqlA19aq6G5XqPRQhslj015kZPezjNl9LVOhSz758D6KR8tITMlvJeeB5y749uw==
X-Received: by 2002:a05:6a20:3c94:b0:1c2:8b95:de13 with SMTP id
 adf61e73a8af0-1c28b95e2e8mr2906700637.6.1720453031650; 
 Mon, 08 Jul 2024 08:37:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b202d78c7sm4427568b3a.217.2024.07.08.08.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 08:37:11 -0700 (PDT)
Message-ID: <a3e6cd8b-068d-465b-a95c-45e55c2c289d@linaro.org>
Date: Mon, 8 Jul 2024 08:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] target/riscv: Add Zilsd and Zcmlsd extension support
To: ~liuxu <liuxu@nucleisys.com>, qemu-devel@nongnu.org
References: <171997728731.22972.8946294105229314138-0@git.sr.ht>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <171997728731.22972.8946294105229314138-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 7/2/24 01:10, ~liuxu wrote:
> +static bool gen_load_ld(DisasContext *ctx, arg_lb *a, MemOp memop, int flag)
> +{
> +    REQUIRE_ZCMLSD(ctx);
> +    REQUIRE_32BIT(ctx);
> +
> +    if (flag&&a->rd==0){
> +        return false;
> +    }
> +
> +    TCGv dest_low= dest_gpr(ctx, a->rd);
> +    TCGv addr = get_address(ctx, a->rs1, a->imm);
> +    tcg_gen_qemu_ld_tl(dest_low, addr, ctx->mem_idx, memop);
> +
> +    TCGv dest_high= dest_gpr(ctx, a->rd+1);
> +    tcg_gen_addi_tl(addr, addr, 32);
> +    tcg_gen_qemu_ld_tl(dest_high, addr, ctx->mem_idx, memop);
> +
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd+1, dest_high);
> +
> +    return true;
> +}

You need to impliment this as one 64-bit load and split the data afterward with 
tcg_gen_extr_i64_tl().  That will also fix the incorrect increment that Alistair noted.


r~

