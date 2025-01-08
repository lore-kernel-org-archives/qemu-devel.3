Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78155E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeBh-00086R-Uz; Wed, 08 Jan 2025 17:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeBf-00080z-KT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:06:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeBd-0006jq-Qg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:06:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso2396745e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373960; x=1736978760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdL60rQ7dj2G1FNn//dJJcl3QmsieVrSNArpWL7kj9s=;
 b=dHbEyUjQ4ODWjdewyf0QVLCnUuPNtUe2rCxWlVAYPZx43WnKUea8Eba8I28LWZE6hu
 iec67Bn7h0Ty77FsawLsy8XPPyniAaWG7OXPuLuNnog1mHlRyUi44LITPyp9NPzpwsEY
 vrpjLsZsxxUnSxgeZTIaX0+KOhTOsk9zXyEE/g8cUzfbSsRCtSzx5Mwxhe2kxuVF657t
 upmU/EfUl+GzXNyn1k1njbGgiRa8N19oyE9Y12+oHJxyGEKeq/p3sXMWi8WzK8Mp9oME
 ixqApARHlt4em4IMsGzMJHsXab1VF36dGuj+P0KddnXWMazYBwj7iPZYDkEkAZOX3rtg
 xKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373960; x=1736978760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdL60rQ7dj2G1FNn//dJJcl3QmsieVrSNArpWL7kj9s=;
 b=i1+P6dcLs7aXcbNGWBZ0SQOetE9IhXihXzcEYvSaFTxHG/hM/jUPaKU6cR+51pbagu
 u/6F3xbg4rRzf+UPmki13hmtP50OPxdszcvKqkb11hka8w55Zt+Kymxuxng62+wj29+s
 1UMV/ryR13SJ3+Bt1ArRIQxrrv8EoLhVSoxxyk7SrpPBEKBmEx/0gNr1bdtz0mRhgJXr
 z+ajLJIDik1uPa82mmpftXZVmusZTArWEyJtJZm7yiQ+wXOxUZg8UCsMD55lXDnHD0kh
 cjem67v7QXaOzCqoNH+aq2UY2pklGrermrXdw46LVj/xLCH95reD3gfYntQhN/ebc6f8
 EsPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvF5ijSdoxHwXBNJrgbcKR40G8rOXQOnleR5lwaw/dt1Rhm5n+1agHj4NSekSGS6G3jgcmfwkL1ESm@nongnu.org
X-Gm-Message-State: AOJu0Yz6kkhMnotnHdlxtakz+jtB8OjlxanVb1lpZSE8sCt6IsTSQFZH
 j000Ttv4HkYZMOl0o7ZQkZ8eXk91Yl8Ki/yU8m7BBqYk367NrKpuV3soura1IXlnCYZnfov+SBy
 tvuA=
X-Gm-Gg: ASbGncv6zEwQUcaXGXsRIiBXV/uvZZN9y6cdMz07V7Q6gose2CnFnwmpf7M/bzwqDA0
 icTDhsu1tnz6ZJ4GAjutJnFHKSxIMiY2Qyby6BF4uOb7cKC+flgPCJ2U90L07g8bv9tUCo3bq+I
 BFusp+mACIyqCi8PF8c6FQen0ZW/hS9VVnIZFceKZFFJnB4xFjTSPLai+gpxPnMFALl0pBGmf3g
 iMoFx1THF3SLzlRWk02OR9Y5pQySNEJd1OghiUiPhsCvLDwydsTpYs4qjRhoPgfyyfXhNQmtuxB
 UEsUxXkKNgoCEUpBujCzmJ6j
X-Google-Smtp-Source: AGHT+IEf9CpZJHHyUiemwbVL/Yv+WWGceC2saOEVYcRG2BC5B9f6csqdeyday1ymNxmCfDUEuwZr3Q==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-436e2699dfbmr41595465e9.14.1736373959831; 
 Wed, 08 Jan 2025 14:05:59 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89e14sm34262915e9.33.2025.01.08.14.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:05:59 -0800 (PST)
Message-ID: <3d54b9c4-cf0f-4e18-955e-a1ebf0fbfdc8@linaro.org>
Date: Wed, 8 Jan 2025 23:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/81] tcg: Add TCGType argument to tcg_out_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-29-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Pass TCGOp.type to the output function.
> For aarch64 and tci, use this instead of testing TCG_OPF_64BIT.
> For s390x, use this instead of testing INDEX_op_deposit_i64.
> For i386, use this to initialize rexw.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 4 ++--
>   tcg/aarch64/tcg-target.c.inc     | 6 +-----
>   tcg/arm/tcg-target.c.inc         | 2 +-
>   tcg/i386/tcg-target.c.inc        | 9 +++++----
>   tcg/loongarch64/tcg-target.c.inc | 2 +-
>   tcg/mips/tcg-target.c.inc        | 2 +-
>   tcg/ppc/tcg-target.c.inc         | 2 +-
>   tcg/riscv/tcg-target.c.inc       | 2 +-
>   tcg/s390x/tcg-target.c.inc       | 7 +++----
>   tcg/sparc64/tcg-target.c.inc     | 2 +-
>   tcg/tci/tcg-target.c.inc         | 4 ++--
>   11 files changed, 19 insertions(+), 23 deletions(-)


> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 64826c7419..e51269f81d 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2612,12 +2612,12 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>       /* no need to flush icache explicitly */
>   }
>   
> -static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
> -                              const TCGArg args[TCG_MAX_OP_ARGS],
> -                              const int const_args[TCG_MAX_OP_ARGS])
> +static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
> +                       const TCGArg args[TCG_MAX_OP_ARGS],
> +                       const int const_args[TCG_MAX_OP_ARGS])
>   {
>       TCGArg a0, a1, a2;
> -    int c, const_a2, vexop, rexw = 0;
> +    int c, const_a2, vexop, rexw;
>   
>   #if TCG_TARGET_REG_BITS == 64
>   # define OP_32_64(x) \
> @@ -2634,6 +2634,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>       a1 = args[1];
>       a2 = args[2];
>       const_a2 = const_args[2];
> +    rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
>   
>       switch (opc) {
>       case INDEX_op_goto_ptr:

Please squash:

-- >8 --
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e51269f81d4..8d1057cdb39 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2622,7 +2622,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode 
opc, TCGType type,
  #if TCG_TARGET_REG_BITS == 64
  # define OP_32_64(x) \
          case glue(glue(INDEX_op_, x), _i64): \
-            rexw = P_REXW; /* FALLTHRU */    \
          case glue(glue(INDEX_op_, x), _i32)
  #else
  # define OP_32_64(x) \
---

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


