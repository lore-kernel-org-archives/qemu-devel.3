Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23942CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 04:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Gj1-00050D-LS; Wed, 24 Sep 2025 00:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Gir-0004zJ-Q4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:03:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Gim-0001LS-N0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:03:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so5817382f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758686588; x=1759291388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QGctKIHVWhra1SN7ty393fx2eXvL8dHbcAzcFxQqhM=;
 b=zwrzNt/YsE+HNG0UwOrwUFNyMYEdCUCEgqDT0knImfOlzOFaMrLJBQUMxZQr5Tf27q
 RkCPeqiaEA6S5uU1d/X2kLk3AwI9eP2FDwXjX5ul4VovTyIg8DakeneYZT3zfNgZVehp
 iZPZ8eTP0Tp7nGdI1o/0H0/eZ3RUCmnDmcPTx3UAgFUasoWu8heN5HelH9XaWqDdxbHy
 JMenb7W7aEJt70tp6y6kPKdvrEp1hMNqiDaz0sI62NRoGcDzNyZWMaD8vyMz/GjNkCkR
 idErWmYfYCu7vXWZPhI1Tcijx5UBPJ0o7Ajf8IGGZqZNz+63LWNQwJ2QjhM+IJEuYyIM
 A6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758686588; x=1759291388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5QGctKIHVWhra1SN7ty393fx2eXvL8dHbcAzcFxQqhM=;
 b=hrDS0tRHOaA162z/ya1gl+Oc0iqw1bdF6r2GowVl2Y90pL3DkINGBWBuI1crsZGIjS
 pGqqyH/keEpGtNmoFHaShfq12tCAQU8PVL6GT3+BRiENsEpZH/cqZzQFx73OsYjW16d5
 vlcGV82NqvspjNGTAco8PsE5wZ3b/OXy9m5FmCDelePVzKyA1wa7RNPfTCjlqr8JjV/U
 xm9ePE2WnLt9ZJAcGVVl8/4Y3y0Dyv52bh/McXK0G4T1+n+oED/iP8K8SM8O6POynIKp
 ytls5YXSMOu5RvX0oy5jMOpS2lj9C1DrdQeOiEoHREnOB0+okbkLUzo0/ATbm5Hm2pU5
 gnLA==
X-Gm-Message-State: AOJu0YzLwkxw8oPoaUPuu8sXLvbNdPTZto0Tgb83n3aerv67MjDeCljy
 zuEeq5y7cGoLOFWHIq5Areai1H70v7Hv4/lZzWBsy2WikSV7aye3WcWZAq9KJOtCfSs=
X-Gm-Gg: ASbGncsICz2nEOAFEJd/woxlBJHNKTiDGc1YACBesOfZTHDlh9iJ0WazQj0gAv0PBw1
 /pCP4x8tRYgbFcMYoP83eEr7RYWP3vagEMqG2ahBlB1oECqQU4N0PmZt8eV60X2qtkdHJR3EPno
 +25Ci4Wsf+HZK3bh2KiWeXKiOyRV86W1udT10F8ydBDO2qm6xnvVead/xT79y7DyxTjKqjRF9hJ
 xRPJs4Ohof+V2jeMUBJDBhN1pHY1CSYabdmGH+NAC8CoO7pzYB4+WtzNbRsp3x0oHIr/L7DX55J
 B80MiTDZZIvxwUCnIpoZe6Jm7JfK0cFiSYWUuaOtrdA4zutEBfMjZn4G7s4LclcH6S/JQ1mCqUL
 iolXIwuahDCiUsaqbJMDfwQR3X/1rcEci2kVp9S/zBlU+w00aEgnBExGXCA36w+o82w==
X-Google-Smtp-Source: AGHT+IGuM/8bN+bSoU36irWwiqvmsLWVSOTz37jsELLMh2+XrN/g73x6H5wjiZEcGsh3uaVvFoN5ZQ==
X-Received: by 2002:a05:6000:200e:b0:3eb:df84:60f with SMTP id
 ffacd0b85a97d-405cb7bb881mr4117908f8f.48.1758686588459; 
 Tue, 23 Sep 2025 21:03:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbf1d35sm28223843f8f.55.2025.09.23.21.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 21:03:07 -0700 (PDT)
Message-ID: <c0fc38df-9c52-406f-8d8b-f2496b4e410f@linaro.org>
Date: Wed, 24 Sep 2025 06:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix folding of vector bitsel
To: WANG Rui <wangrui@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu@hev.cc
References: <20250919124901.2756538-1-wangrui@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250919124901.2756538-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 19/9/25 14:49, WANG Rui wrote:
> It looks like a typo.

Likely from the TCG_TARGET_HAS_andc_vec case.

> When the false value (C) is the constant -1, the
> correct fold should be: R = B | ~A
> 
> Reproducer (LoongArch64 assembly):
> 
>       .text
>       .globl  _start
>   _start:
>       vldi    $vr1, 3073
>       vldi    $vr2, 1023
>       vbitsel.v       $vr0, $vr2, $vr1, $vr2
>       vpickve2gr.d    $a1, $vr0, 1
>       xori    $a0, $a1, 1
>       li.w    $a7, 93
>       syscall 0
> 
> Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
> Link: https://github.com/llvm/llvm-project/issues/159610
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   tcg/optimize.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3638ab9fea..f69702b26e 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
>               return fold_and(ctx, op);
>           }
>           if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
> +            TCGArg ta = op->args[2];
>               op->opc = INDEX_op_orc_vec;
>               op->args[2] = op->args[1];
> -            op->args[1] = op->args[3];
> +            op->args[1] = ta;
>               return fold_orc(ctx, op);
>           }
>       }
Looks correct, but I don't understand the swap. Can't we justkeep the 
same argument order for an ORC opcode? I'd have done:

-- >8 --
@@ -1569,8 +1569,6 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp 
*op)
          }
          if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
              op->opc = INDEX_op_orc_vec;
-            op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
              return fold_orc(ctx, op);
          }
      }
---

