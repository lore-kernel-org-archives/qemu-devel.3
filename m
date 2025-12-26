Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1F7E8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZAKz-0000KP-NJ; Fri, 26 Dec 2025 11:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAKs-0000Jl-5Q
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:06:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAKp-00063v-QI
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:06:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so58151485e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766765194; x=1767369994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vs90tTTJdTlsWe41sAk45OicWSeJtlmkun2CDmBausE=;
 b=i4N+IaHF2GESXC27TXz77ak75r/+hp+F3dVpwyyt+9xKge/uwuNsPfi26VVqB9uH2p
 Y20hAIH7hZtbKNMIUeEgU7cYnB0NGZNDzxJlGO2W80isHJG1ndknRpN/Jnu5tS6dI2wG
 +iTwDfmPnoOt4QLLsf7QmARlll30bqIA2VsrM1bg97/V+y/iHWGudlVGMc7DAsBMeR7I
 dwoqXJPMSsgy8hPJKTiF27aHuaqvEnvRXa+3EzFTK5+t9aJzXXmtt3owUCehc/HzzAKD
 kPOp5yiUtyYHRSycG0tkCTIzyhYRRZnxkeK7eqIbQ4aZbnJAiTEmfImBJvPkjPCr7xM7
 5wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766765194; x=1767369994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vs90tTTJdTlsWe41sAk45OicWSeJtlmkun2CDmBausE=;
 b=Fg6hwoae3N3ECRLBWCBcy53Ql1+Wvr7zJBQuVVPj6z5g6qO59l3Ya2ffK8s7eZVPc9
 ySQZKsLwhhZEMES1TunAdBS4C5Wnl9sfjYi1QD8ot9+11v8g/lOt7Ke8iwMo+5ABUS1A
 PbEqjE4yd24cQ/JGr8M+b5u9aLv7J/0WFj3mHjGLiG5jRxBqJ4zGRsLyPN938SsGAHQ4
 VJK9UreWNHKLQ6N6E+2GZVDQ1jdNI0Si44vq9WJkYaxIJktkiBmSXvB5AlHgsOEdv0P0
 Me85T7imWQp/D/F9q1vlqAbiEnSDXXsnxqO24V7JA//W1sG/idwrBp09N/Mn2Okufaoy
 +knQ==
X-Gm-Message-State: AOJu0YxaQOJp/tk+fq74ddF7gJjBfjP1uWl31JWUazscSVgOXaXFDaWd
 RMbFnziSxDwkKynRiqjJMOSlNHOqv0dxGLf3B6bNPVSgE68/HMaGBaWnpGoCveidTv4=
X-Gm-Gg: AY/fxX5sNpLo34x7KNl3z9pr8pJ5edYeR3kNPrOBf+Oped98FfAnCLuqC+cU8VL+XpV
 tUWAeoy0LDu9JFlSKdzFnu2DrlsVxd0/WvURt4lPXjg1qlT5KpTyQ+nGADiXxMszCE/bZcEzKOS
 zLIUULpIg3UP8iUGb4Mby+PJrc+Ij8d8YbBFd99gY6hVugvgP3S+/wBpiZnkQzdJDdsawynIIYn
 zxBzPU+aLBJSmUo7GDdVo15ZnTd3mnYp+NzrOmJnRogkcBe45DENHfAWEn470pi59ANiWprxrIL
 2JNA7gFyMXLPpu+qlyr1/4sBEdr+puozlBw59b6WukULPGE2XH36UcBUXf+iXb7k0rcrky3CGdb
 1P/oNPxE5eL67tGvy3JIhI7C2XfAhx7XOhcqBv2gs8w2brKyDDgrwHRresR+tk3bxZMzpNf6Ed+
 31ZZXtyqVClBuX2MiZQFf3Y1375fGWmMNxAw9MVZw92J8iN/BQdceAacGftPha/A==
X-Google-Smtp-Source: AGHT+IFkTfk/GkgULO3ETukn3mAoTsezRNgCmZv2V9sR0sWlNyswNah3q/ZqpbXXqOqPmr/tAuyL+w==
X-Received: by 2002:a05:600c:1c29:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47d1959d4bamr292620445e9.34.1766765193817; 
 Fri, 26 Dec 2025 08:06:33 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm459187135e9.7.2025.12.26.08.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 08:06:33 -0800 (PST)
Message-ID: <ad717d8c-a6b9-4dd8-a4bd-fdd6d1d756a5@linaro.org>
Date: Fri, 26 Dec 2025 17:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] trans_rvi.c.inc: Make lq and sq use 128-bit ld/st
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20251216212423.2586121-1-frederic.petrot@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251216212423.2586121-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Frédéric,

On 16/12/25 22:24, Frédéric Pétrot wrote:
> The lq and sq helpers for the experimental rv128 architecture currently
> use direct (and erroneous) memory accesses.
> Replace these direct accesses with the standard tcg_gen_qemu_{ld,st}_i128
> TCG helpers that handle endianness issues.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 54b9b4f241..ea5a961464 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -388,10 +388,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>               tcg_gen_movi_tl(desth, 0);
>           }
>       } else {
> -        /* assume little-endian memory access for now */
> -        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
> +        TCGv_i128 t16 = tcg_temp_new_i128();
> +
> +        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
> +        if (mo_endian(ctx) == MO_LE) {
> +            tcg_gen_extr_i128_i64(destl, desth, t16);
> +        } else {
> +            tcg_gen_extr_i128_i64(desth, destl, t16);
> +        }
>       }
>   
>       gen_set_gpr128(ctx, a->rd, destl, desth);
> @@ -494,10 +498,14 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>       if ((memop & MO_SIZE) <= MO_64) {
>           tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
>       } else {
> -        /* little-endian memory access assumed for now */
> -        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
> +        TCGv_i128 t16 = tcg_temp_new_i128();
> +
> +        if (mo_endian(ctx) == MO_LE) {
> +            tcg_gen_concat_i64_i128(t16, src2l, src2h);
> +        } else {
> +            tcg_gen_concat_i64_i128(t16, src2h, src2l);
> +        }
> +        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
>       }
>       return true;
>   }

Errors when building qemu-system-riscv32:

[3/5] Compiling C object 
libqemu-riscv32-softmmu.a.p/target_riscv_translate.c.o
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:395:35: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   395 |             tcg_gen_extr_i128_i64(destl, desth, t16);
       |                                   ^~~~~
include/tcg/tcg-op-common.h:309:37: note: passing argument to parameter 
'lo' here
   309 | void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 
arg);
       |                                     ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:395:42: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   395 |             tcg_gen_extr_i128_i64(destl, desth, t16);
       |                                          ^~~~~
include/tcg/tcg-op-common.h:309:50: note: passing argument to parameter 
'hi' here
   309 | void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 
arg);
       |                                                  ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:397:35: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   397 |             tcg_gen_extr_i128_i64(desth, destl, t16);
       |                                   ^~~~~
include/tcg/tcg-op-common.h:309:37: note: passing argument to parameter 
'lo' here
   309 | void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 
arg);
       |                                     ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:397:42: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   397 |             tcg_gen_extr_i128_i64(desth, destl, t16);
       |                                          ^~~~~
include/tcg/tcg-op-common.h:309:50: note: passing argument to parameter 
'hi' here
   309 | void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 
arg);
       |                                                  ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:504:42: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   504 |             tcg_gen_concat_i64_i128(t16, src2l, src2h);
       |                                          ^~~~~
include/tcg/tcg-op-common.h:310:54: note: passing argument to parameter 
'lo' here
   310 | void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, 
TCGv_i64 hi);
       |                                                      ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:504:49: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   504 |             tcg_gen_concat_i64_i128(t16, src2l, src2h);
       |                                                 ^~~~~
include/tcg/tcg-op-common.h:310:67: note: passing argument to parameter 
'hi' here
   310 | void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, 
TCGv_i64 hi);
       |                                                                   ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:506:42: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   506 |             tcg_gen_concat_i64_i128(t16, src2h, src2l);
       |                                          ^~~~~
include/tcg/tcg-op-common.h:310:54: note: passing argument to parameter 
'lo' here
   310 | void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, 
TCGv_i64 hi);
       |                                                      ^
In file included from ../../target/riscv/translate.c:1192:
../../target/riscv/insn_trans/trans_rvi.c.inc:506:49: error: 
incompatible pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to 
parameter of type 'TCGv_i64' (aka 'struct TCGv_i64_d *') 
[-Werror,-Wincompatible-pointer-types]
   506 |             tcg_gen_concat_i64_i128(t16, src2h, src2l);
       |                                                 ^~~~~
include/tcg/tcg-op-common.h:310:67: note: passing argument to parameter 
'hi' here
   310 | void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, 
TCGv_i64 hi);
       |                                                                   ^
8 errors generated.
FAILED: [code=1] libqemu-riscv32-softmmu.a.p/target_riscv_translate.c.o


