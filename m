Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3305CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2Dj-0004ey-1A; Thu, 06 Nov 2025 10:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vH2Dh-0004eK-1n
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:48:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vH2Df-000771-Gx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:48:16 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-641018845beso1770629a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762444093; x=1763048893; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXIEWeMkepcz8wHGMCwaPQIWSj8kSf13l4VllygB0Yw=;
 b=lRjExJ+gynuLLwujaXbhg04GYsJAYZ+M7WToASA27zfrth/q+JcaQ+LF1I2QMdqVGY
 ycZJosxInTOt2TnwqJ9E3vb1DXEp29lW+BlPawtVTkHvvpQn1VyAScRq+TNKQ7jkwVVJ
 cQUefQNkKhTbvSnv7qRYbKDSbLkjBPclxrpysJkpvbzHuDBcHtg0LsFd9KDbfjn58A5Z
 g3HgtmzQquzov+hgSkJI9i1B+MtWqsMfF0dt04gCJ23A2TexonIPkijwkZPxUPcZ1h4k
 hqjBh5vP37Engcx3bKQbdx5nzQY9ucEL0/Agq687IH2bzQ/j+wdiyDmR0JrovrAH31mf
 ljGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444093; x=1763048893;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eXIEWeMkepcz8wHGMCwaPQIWSj8kSf13l4VllygB0Yw=;
 b=bBFhbwMGCSFvOeWSOpiuI2kXWr/aoOMvU4xBcjFxtLdH50KtBVNDjStX5ltIIiuDNs
 lygLq2l0zAkhmd2OeMhlBPR3saViW2mxNLa0e3LA+M4mreJbUyxZ9XCE/EfzKXvbY71E
 3/ql8raQdZrnHjTIHfZw/ZGtSeb8hAtLOMKdZ1SDNmOKkjXEc95xuToFTphB0Q6skLmc
 xe/l33oYL8OgVdmO0ZE/0Rhehqxxdo3NHpYsd1BQ1JAc7fZQXAykoncK1dHokvdasMTD
 aId7Wt64utixnePvkXlXEoiCin1SS4qRnvzOi9lBnkEkxw5KyaK2mt6aApuKfQsZG+uw
 nMKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7hC1rEOjPyjvqaJ+ryZe1LW9mnoj9YIMOeGNu4YhA0C6G/vPQUUmTNYu72/YGKw4VHjCqrBFZeRm@nongnu.org
X-Gm-Message-State: AOJu0YyKSjCWArvcwBs7+pBqw+vjd3xdoZkVLKZ5aHLlWmcdz8jaPnK0
 TqJhtgipVHpzW0yIxNWr1a7j1cvO28ZIJqXPrUGS+QaxhDXNRrFyMpz77r6z7dgcVkI=
X-Gm-Gg: ASbGnct77haca+uTPWTZxzEjh7rtQfXvpQ1/S81GskYcJ3+x4Giy84CzbK4Yd/dwNty
 ytmBnn+Qslr4hQp9m0BaIKGIUUZPwfeOCo7rvBXHpbHTGUW/mBlMxaS9ES36vnWzc5G7GuNTU0L
 W6QSsdBXgKjo9PaSOIMNlAM+DDLGKZRmLyFuuS2CXhe55+TK5HkVmlLzSpa0ncXQqvzOMZqwBzb
 eaWY4CniHIKJX/D/g03vHfxarKLrhgrmx4TSq81qM9BDql1unXoP+LjFZf/8XjIhv9/TZrhdHLO
 qdHYyZx+OrSLki4AnylqPRSWlZDvZSJfI8RCOHMnd9kvBCB15LECIUmGBS+zG9FgVj9L+U6Jj3U
 EqFNxw17un56y1GsEKhD0yUMhTiFSdOwxO2VF/J/a0kacC+dS1ueE1kLZVSSjbYp7H3lEFcI50J
 Ao08omMqVjRWRoJYWZQC30PPe6aS/YKJCh2g==
X-Google-Smtp-Source: AGHT+IGtxibGHBsNeVJcwGC1l9I/+B0+fVJ3e03QCKZrghyxx0BNtt3wod+slr43JiwJ8NYPA/X+zA==
X-Received: by 2002:a17:907:3da3:b0:b70:7cd8:9098 with SMTP id
 a640c23a62f3a-b72655ee49emr814782266b.61.1762444093373; 
 Thu, 06 Nov 2025 07:48:13 -0800 (PST)
Received: from [172.20.148.161] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289682544sm241617366b.53.2025.11.06.07.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:48:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------hCW7Tf1Yz1wRSbXxvfiSGDBt"
Message-ID: <5ad511f4-eb36-4d49-90a6-fbb1e5f67c6c@linaro.org>
Date: Thu, 6 Nov 2025 16:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix accidental write to TCG constant
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20251106144909.533997-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251106144909.533997-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ed1-x52a.google.com
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

This is a multi-part message in MIME format.
--------------hCW7Tf1Yz1wRSbXxvfiSGDBt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

On 11/6/25 15:49, Richard Henderson wrote:
> Currently an unpredictable movw such as
> 
>    movw pc, 0x123

bah, how did you get this insn.? Are you using any fuzzer? :P


> results in the tinycode
> 
>     and_i32 $0x123,$0x123,$0xfffffffc
>     mov_i32 pc,$0x123
>     exit_tb $0x0
> 
> which is clearly a bug, writing to a constant is incorrect and discards
> the result of the mask.  Fix this by adding a temporary in store_reg().
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> [rth: Avoid an extra temp and extra move.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 5f64fed220..63735d9789 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -303,20 +303,23 @@ TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
>      marked as dead.  */
>   void store_reg(DisasContext *s, int reg, TCGv_i32 var)
>   {
> +    uint32_t mask = 0;
> +
>       if (reg == 15) {
> -        /* In Thumb mode, we must ignore bit 0.
> +        /*
> +         * In Thumb mode, we must ignore bit 0.
>            * In ARM mode, for ARMv4 and ARMv5, it is UNPREDICTABLE if bits [1:0]
>            * are not 0b00, but for ARMv6 and above, we must ignore bits [1:0].
>            * We choose to ignore [1:0] in ARM mode for all architecture versions.
>            */
> -        tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
> +        mask = s->thumb ? 1 : 3;
>           s->base.is_jmp = DISAS_JUMP;
>           s->pc_save = -1;
>       } else if (reg == 13 && arm_dc_feature(s, ARM_FEATURE_M)) {
>           /* For M-profile SP bits [1:0] are always zero */
> -        tcg_gen_andi_i32(var, var, ~3);
> +        mask = 3;
>       }
> -    tcg_gen_mov_i32(cpu_R[reg], var);
> +    tcg_gen_andi_i32(cpu_R[reg], var, ~mask);
>   }

The difference between v1 and v2 is:

v1:
  mov_i32 tmp3,$0x123
  and_i32 tmp3,tmp3,$0xfffffffc
  mov_i32 pc,tmp3

v2 (this version)
and_i32 pc,$0x123,$0xfffffffc


I think we need only a v3 that updates the commit message since we
are not adding a temporary anymore.

Interestingly, I was not able to crash the host when native code
was generated from:

and_i32 $0x123,$0x123,$0xfffffffc

I'm sending the binary I used to test it attached for convenience.

Anyways:

Tested-by: Gustavo Romero <gustavo.romero@linaro.org>

and with the commit message updated:

Reviewed-by: <gustavo.romero@linaro.org>
--------------hCW7Tf1Yz1wRSbXxvfiSGDBt
Content-Type: application/octet-stream; name="movw_pc.bin"
Content-Disposition: attachment; filename="movw_pc.bin"
Content-Transfer-Encoding: base64

I/EA4w==

--------------hCW7Tf1Yz1wRSbXxvfiSGDBt--

