Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298F1C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDBw-00070J-L7; Mon, 03 Jun 2024 15:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBp-0006xQ-2k
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBm-0003xb-VI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:52 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso3758347a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442269; x=1718047069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=27qdUYCHQFKaGhjhGbFvYF5MWE8U+uU+ch+nxLcwjfE=;
 b=o+MuTft+Prp83rjxgOHkzonMkzdIBVubuD6UARwBg5IyLiyC2+18Ha0Oni7X3NkNf0
 f5A7aTpEk5sK+TQBVUtXvH354CqfYBYo7EGDd2M5XoFMpqgmb/btUo2K7icIOVJ6bPzr
 jtbGYak7fBAEWL/+b38FUKk85ixPwKNagDr5NRLKS+LvXj2/luE+dc/j3wO64gAqDG05
 7TRqo6JjSMN5o+6NdywqXIUlrHIOBvPqw8chhRpkvs+NF3O7Bwry1/UDFyLIPbYWuk6t
 WWpH8Ev8DP37x75QjQlvGnmvv8HWFXtKIqj+CI1C3fDZdcNZC5NrMP/2chthU2l6cpmN
 M84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442269; x=1718047069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=27qdUYCHQFKaGhjhGbFvYF5MWE8U+uU+ch+nxLcwjfE=;
 b=IfVSqa41TGLq2wwj/6iyI61+2kRPtD0kVCTE1wob4clcrthCA6JPjIy2Kyq6Ugu9sm
 SerYei/mU/ComNIrTM4vwXWsGmFBNpWVXislm9ATEvNhy3+fcRGVlW1Ta0ewCKdPdryJ
 pN/IruRHwYXPR1L6rvjTj525hSP0fRU5Axf4Y7vQpvNC7LfhgBg9IYNWqBJz7HvXpeno
 SH3Sq6Qz3NljdfebusEhtfUinIsSWp4OGu/ltKESCHXEE89oeB+4jRGsqr1svi5OEnhe
 k7QFqKQbASWPLEkSCSxRRy0XfMxDuqePjWOfZMDujaNCdOdfWya5g8XCTTlLqQUHYhi+
 J59A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtGVMLjLLYOCb7Hd6jW1r2qupEpwnB1I7RuIoo6nOXjefmeHebEasvbU3WjesVXmmOkRmvurAi4OJFmhVSyAaSBmYyX/c=
X-Gm-Message-State: AOJu0Yxb80lB5Ke8nGIX8JxFE6/iLyZIQJVculPaxajuA+HQ12bu/Xgz
 Fv848VqvM+w9Dyzhr2M4l6Uj05U4/2kRpQxyaBGkQCkEJTp8qUe/BfIGHElZ49A=
X-Google-Smtp-Source: AGHT+IELFyLf4j3BzSwIr/eGfKfqZ5lUMA7lJlOfQsluHVSFc3uAFFnXoLO3LfGyj8djpzJWRtn55Q==
X-Received: by 2002:a17:90a:b788:b0:2c1:424c:1759 with SMTP id
 98e67ed59e1d1-2c1dc5bf275mr9906781a91.36.1717442269473; 
 Mon, 03 Jun 2024 12:17:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c6482dc7sm6793620a91.44.2024.06.03.12.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:17:49 -0700 (PDT)
Message-ID: <d3763a0c-272b-4ea5-a998-692ae931618b@linaro.org>
Date: Mon, 3 Jun 2024 12:17:48 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

