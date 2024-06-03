Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A3C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDCn-0007zP-UI; Mon, 03 Jun 2024 15:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDCl-0007z1-Tf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:18:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDCk-00043S-5q
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:18:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70276322ad8so336731b3a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442328; x=1718047128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=27qdUYCHQFKaGhjhGbFvYF5MWE8U+uU+ch+nxLcwjfE=;
 b=irvwt47D+O0x7HaL0ytJHmFtBWhiJOeDvt+2karQg1Jrb73JpFr1gSBXL3seXucIqv
 /GCHOCNiv27FGklphHx2txN3DAH6NVdl3eqiY0wvu7AxfpR/eCHktSqr1IaEMy6/zZJ+
 WpYnafcLND3Gcob6R2AGGI7Y6DIk55lUTsG8W0kmZV/rLKgXSHC+moPvnSQk4xwvcqEU
 MQD/7nDutvfIEsP8PlWHp5uph2PV4pBGD0Z4PpI6YKA46gr807Yx1oqRVXMSuvqPYZFO
 4TkQjofCY7hs9ZmJEgeYeX5IcADhhHHSS+ukKStFb7uoRHsepikjRtkB4enz7bsGfdnq
 t/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442329; x=1718047129;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=27qdUYCHQFKaGhjhGbFvYF5MWE8U+uU+ch+nxLcwjfE=;
 b=DqQvBwFbu1kjGiahYSz+SYmOOHlBsHPllnONIAIaqs1+js6TsztaeTlGAd6C9Vdxc6
 GlYIhooWy+DDVSVWaoFHSdDNhrYC1d8AhWTYXSU6VQF0FrJGulwsZZW7ZUsYYy1wNbu1
 QmNWD0vhCgP0pF5AIOl0z+on1QzH2MZBfgcrAn/ZeoeJjf5464JWcCZA7qV1Miji6qUh
 j3hAHeJYntko3deYYTVpH00qiC//Zz9SQX0zko8Vgc1bSR//bnhcU0/GV4Xmjckm0Md7
 Pz9/9ym8hiHYujq1pju/IUQOPZgpYLXyRjOULrqEVAk6pWuXQU1ajBI8Jf7cixpopqR7
 fOsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0jS9x4jWOHm3obIG2/xLT2x9fXoXHpDqXountsh4CzMjjjjqIJZIobiKbkfkeggdgIyDQ9IA2RxGVRWQh5jEoAdVEI+M=
X-Gm-Message-State: AOJu0Ywd+iA9q9u4zoxml87MTuX/S3mNTd22Ch7OVKratB1XzwpX5REC
 XaNWK1DdZEp43pCLpgMQun3jKbhrx/S7k9lBS7DpOVfL/QQojLJBEXpn+T7F/plPizHaCahs8FG
 z
X-Google-Smtp-Source: AGHT+IFJSPdaOS3ZLVvmp5EYQCpwGEjTaY9laOlaorTcrpSfG+t0zA5v3I6ZyOyeeb36PodtWlwxFw==
X-Received: by 2002:a05:6a21:6d9e:b0:1b2:8c50:f10e with SMTP id
 adf61e73a8af0-1b28c50f55dmr5035963637.38.1717442328607; 
 Mon, 03 Jun 2024 12:18:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c69e0sm5854398b3a.26.2024.06.03.12.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:18:48 -0700 (PDT)
Message-ID: <7194f714-9681-4161-922f-700e3ecfda27@linaro.org>
Date: Mon, 3 Jun 2024 12:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/27] disas/microblaze: Print registers directly with
 PRIrfsl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/12/24 00:33, Richard Henderson wrote:
> Use a printf format instead of sprintf into a buffer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/microblaze.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 390f98c0a3..24febfdea9 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -564,7 +564,6 @@ static const struct op_code_struct {
>   
>   /* prefix for register names */
>   #define register_prefix "r"
> -static const char fsl_register_prefix[] = "rfsl";
>   static const char pvr_register_prefix[] = "rpvr";
>   
>   
> @@ -580,11 +579,13 @@ static const char pvr_register_prefix[] = "rpvr";
>   #include "disas/dis-asm.h"
>   
>   #define PRIreg    register_prefix "%ld"
> +#define PRIrfsl   register_prefix "fsl%ld"
>   #define PRIimm    "%d"
>   
>   #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
>   #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
>   #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
> +#define get_field_rfsl(instr)    (instr & RFSL_MASK)
>   #define get_field_imm(instr)     ((int16_t)instr)
>   #define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
>   #define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
> @@ -592,19 +593,6 @@ static const char pvr_register_prefix[] = "rpvr";
>   #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
>   #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
>   
> -/* Local function prototypes. */
> -
> -static char * get_field_rfsl (long instr);
> -
> -static char *
> -get_field_rfsl (long instr)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
> -           (short)((instr & RFSL_MASK) >> IMM_LOW));
> -  return(strdup(tmpstr));
> -}
> -
>   /*
>     char *
>     get_field_special (instr)
> @@ -803,11 +791,11 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        get_field_imm5(inst));
>           break;
>       case INST_TYPE_RD_RFSL:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
>                        op->name, get_field_rd(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_R1_RFSL:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
>                        op->name, get_field_r1(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_RD_SPECIAL:
> @@ -879,7 +867,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        op->name, get_field_rd(inst));
>           break;
>       case INST_TYPE_RFSL:
> -        fprintf_func(stream, "%s\t%s",
> +        fprintf_func(stream, "%s\t" PRIrfsl,
>                        op->name, get_field_rfsl(inst));
>           break;
>       default:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

