Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3247FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZn7M-0002na-F2; Fri, 02 Aug 2024 03:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn7K-0002h0-Pm
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn7J-0000fc-A6
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so2041113b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722585264; x=1723190064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRHGM08j7OaFvE2S1F1Wg6mDJ6BlAKH+FpuZcGF8WMg=;
 b=EQiXlEe29WS2sJBUWZ5DasFWYtQ18gS+VTbTKEG9EXvi+/0m7E5Qi+jG77x8H8GdgH
 enFkE95wZWyDJnQ7ELqf7W6E1U3cXsw6btEwkPZZeZZbjxAgZvtEWD6DNnI5Km6DSxC/
 szbnpmTZrp0t7YudLdwxm8pjRIWnnJ81iW+MenrDX5ABFa11Azx+xqtKFNuZ68p0Sazo
 YzJOcaJrrp8qX4tCiUd2bLs5LZfr4FH8jeOckHu2qqovN0YjEjFgmawD7SPk5KZ3Fobj
 a3HLGyDbLt2CoX0K8nuKTiARs0dKip7iu8X/9sEtUOqkCLyEfK5YnjuZ0RUDBTidbKiN
 NO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722585264; x=1723190064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRHGM08j7OaFvE2S1F1Wg6mDJ6BlAKH+FpuZcGF8WMg=;
 b=D7hX23d8pLkAP8KcEaiVVEvglkLtpbE8SWlzGxgOcMWbw31dZ/LlcQZUSLhvNObFJA
 HIsPtkTc55fhci7KjqwI88Wr7lRza3f4+8OOBGAammY9ymLf+TXT97t4ddEWUdL4bzLC
 RvGKI4cvCknjZJt0rLxV6CY3EsjIfb9yJYeGw2sRKxLZeru2vIO466jBfOGt5k/K9End
 OU2WjL8ny1BRX6tKI/OnJK1y6bAO4d3VzD+YSjPZVgTt3UmcczmZY2m3tQNfvB/FCm8I
 8kjslL+1Gu7TcIWAnYbSp8ZIwN4fNX803cl0zTlP16nZtmIW+YRfugPt8O5NeVn7tPOD
 PW8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6RP6rIYcYUaMen4NwynazxWLrw0Re/KSXMCEbasIYtAqtD+c+ofcPBlNoYqsjTudWXdvWfYAAwGHITTzNbz07Erklyg0=
X-Gm-Message-State: AOJu0Yyp46Q0VxHvKqQbJ+/DZM0uaXqhQQ4nWWKAxlU7G6ZrNTnf7g7E
 0bKJOuU+6JOSv1Hf4Cw04EY/iocjMruFeH8gq00YFGsMhi6TsJoufPjpLcFIn04=
X-Google-Smtp-Source: AGHT+IFuQat7nWdj5G2fVTWbTEr2K7wVuu+7Jg/yyRlVAtVcUNe5lzMRfMXNtjRT+IGdum21fAcOOg==
X-Received: by 2002:a05:6a00:4f84:b0:70d:2438:db48 with SMTP id
 d2e1a72fcca58-71065f55e70mr5666722b3a.15.1722585263730; 
 Fri, 02 Aug 2024 00:54:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec54457sm891485b3a.86.2024.08.02.00.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:54:23 -0700 (PDT)
Message-ID: <b8f126b8-feb9-415f-8bf6-6ad874f38f48@linaro.org>
Date: Fri, 2 Aug 2024 17:54:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802072417.659-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/2/24 17:24, LIU Zhiwei wrote:
> Zama16b loads and stores of no more than MXLEN bits defined in the F, D, and Q
> extensions.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index 0ac42c3223..49682292b8 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -47,7 +47,11 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    /*
> +     * Zama16b applies to loads and stores of no more than MXLEN bits defined
> +     * in the F, D, and Q extensions.
> +     */
> +    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
>   
> @@ -67,7 +71,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

