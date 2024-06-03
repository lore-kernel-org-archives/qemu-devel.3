Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B2AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDBE-0006F2-OR; Mon, 03 Jun 2024 15:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBD-0006El-2U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBB-0003uG-5b
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b594deeso34492375ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442231; x=1718047031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YDSSBqDCraSGUJ+ZSkl7XrMmtYC5IC+2b1zBpcTnwYo=;
 b=RahS2F+FTCkS0UCq1hKwtuLCDBTZURMpg5iyyIPYTqhwye/cl/z/WPVn+NS6HoODyT
 VAqBX1oQy1CBEx7BziJsGrVhxqCYoMQorQa7johRlFKqch9aUWPsZueGnJ3TCjagAMhs
 SQgcf3GwvUfi28FYbuneINgvP/9SQozEIabrFvmcMtPzjZibwWZzxue+EsfEA5PSJNdK
 TPds2NhNer113ulue+ZJhclqsp2YXZwKrVTWjGY6h+jO51tp1LcoOzxsPm8lVMb3zHkE
 ZbXs8KylGgD7/itJ/jh3XkxfAn49qe7AjGGnJkYZCRAvznMr5AsG8L2M+QTlCt7eIn3N
 0gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442231; x=1718047031;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDSSBqDCraSGUJ+ZSkl7XrMmtYC5IC+2b1zBpcTnwYo=;
 b=rFmN+TG5OJqSmuKGhEbFvAXdKV2xXS977Oo4GN0IZeE+2eoLbAKWXsXwHQPW5G9Uts
 6W+aQm8vILNI+SqzE+FeNAv0xxrGc5Yt3hIuwMBjhMHNeDmcN8MwVveZgKdR46J0DfQt
 uXsiDwRqRYNsNnPdVC7NIek2C08F6oMGB387G81TRlaOgIAqoJQOhHHr7UuVkXP7WfdV
 7umCqwdivcxVFUxcGdsUmFMND9xVV+AICOpqDkg1u4GXsthu1oQW0T6vL+yhu01dXKXj
 jeLuPFHUeVFZ6D+CnGK4DcoW8EBO9HS1wfqBd4l5QFArn+Eet7egk5U2BzRa0ZfzDnFK
 wDVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe6en64JQLm/MoF+G3peHaFRnuvrGKXHLPC3g00Ejv48Cy2htPNt71JmZUU/BCMkA/lJUyKK/Gqxt1OPCVG3/DQyMf/JU=
X-Gm-Message-State: AOJu0Yz2jke4vLXkOjeSG5SGGc3/BHu6etPxM7T+vH46KBZeOXjLkrsb
 EDpqBYJcMS59pIyCYKLal1LCnbAUz+BL54FS/7t03BCjo9xbymvP0GjNQkpi8UU=
X-Google-Smtp-Source: AGHT+IGOHqC0GWfpfED4xA/1F2+Mvaek4dj0YSdt4z+I6G2BTMEooAuXIhVDAsrBJUmEsG9Jp5YjrQ==
X-Received: by 2002:a17:903:2385:b0:1f6:502d:ca88 with SMTP id
 d9443c01a7336-1f6502dcb84mr87185385ad.49.1717442231094; 
 Mon, 03 Jun 2024 12:17:11 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dd4fsm68188035ad.45.2024.06.03.12.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:17:10 -0700 (PDT)
Message-ID: <a854d60a-b504-4e40-b610-da428798df4e@linaro.org>
Date: Mon, 3 Jun 2024 12:17:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/27] disas/microblaze: Print registers directly with
 PRIreg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
>   disas/microblaze.c | 54 ++++++++++++++++++++--------------------------
>   1 file changed, 23 insertions(+), 31 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index a537ac65dd..c12968f3b9 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -563,7 +563,7 @@ static const struct op_code_struct {
>   };
>   
>   /* prefix for register names */
> -static const char register_prefix[] = "r";
> +#define register_prefix "r"
>   static const char fsl_register_prefix[] = "rfsl";
>   static const char pvr_register_prefix[] = "rpvr";
>   
> @@ -579,15 +579,16 @@ static const char pvr_register_prefix[] = "rpvr";
>   
>   #include "disas/dis-asm.h"
>   
> -#define get_field_rd(instr) get_field(instr, RD_MASK, RD_LOW)
> -#define get_field_r1(instr) get_field(instr, RA_MASK, RA_LOW)
> -#define get_field_r2(instr) get_field(instr, RB_MASK, RB_LOW)
> +#define PRIreg    register_prefix "%ld"
> +
> +#define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
> +#define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
> +#define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
>   #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
>   #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
>   
>   /* Local function prototypes. */
>   
> -static char * get_field (long instr, long mask, unsigned short low);
>   static char * get_field_imm (long instr);
>   static char * get_field_imm5 (long instr);
>   static char * get_field_rfsl (long instr);
> @@ -596,15 +597,6 @@ static char * get_field_imm15 (long instr);
>   static char * get_field_unsigned_imm (long instr);
>   #endif
>   
> -static char *
> -get_field (long instr, long mask, unsigned short low)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
> -           (int)((instr & mask) >> low));
> -  return(strdup(tmpstr));
> -}
> -
>   static char *
>   get_field_imm (long instr)
>   {
> @@ -832,12 +824,12 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>   
>       switch (op->inst_type) {
>       case INST_TYPE_RD_R1_R2:
> -        fprintf_func(stream, "%s\t%s, %s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIreg,
>                        op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_R1_IMM:
> -        fprintf_func(stream, "%s\t%s, %s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm(inst));
>           if (get_int_field_r1(inst) == 0) {
> @@ -845,36 +837,36 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_R1_IMM5:
> -        fprintf_func(stream, "%s\t%s, %s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm5(inst));
>           break;
>       case INST_TYPE_RD_RFSL:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_R1_RFSL:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_r1(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_RD_SPECIAL:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_special(inst, op));
>           break;
>       case INST_TYPE_SPECIAL_R1:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t%s, " PRIreg,
>                        op->name, get_field_special(inst, op), get_field_r1(inst));
>           break;
>       case INST_TYPE_RD_R1:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
>                        op->name, get_field_rd(inst), get_field_r1(inst));
>           break;
>       case INST_TYPE_R1_R2:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
>                        op->name, get_field_r1(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_R1_IMM:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_r1(inst), get_field_imm(inst));
>           /*
>            * The non-pc relative instructions are returns,
> @@ -885,7 +877,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_IMM:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_imm(inst));
>           print_immval_addr(info, immfound, immval, inst,
>                             op->inst_offset_type == INST_PC_OFFSET
> @@ -901,28 +893,28 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_R2:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
>                        op->name, get_field_rd(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_R2:
> -        fprintf_func(stream, "%s\t%s",
> +        fprintf_func(stream, "%s\t" PRIreg,
>                        op->name, get_field_r2(inst));
>           break;
>       case INST_TYPE_R1:
> -        fprintf_func(stream, "%s\t%s",
> +        fprintf_func(stream, "%s\t" PRIreg,
>                        op->name, get_field_r1(inst));
>           break;
>       case INST_TYPE_RD_R1_SPECIAL:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
>                        op->name, get_field_rd(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_IMM15:
> -        fprintf_func(stream, "%s\t%s, %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", %s",
>                        op->name, get_field_rd(inst), get_field_imm15(inst));
>           break;
>           /* For tuqula instruction */
>       case INST_TYPE_RD:
> -        fprintf_func(stream, "%s\t%s",
> +        fprintf_func(stream, "%s\t" PRIreg,
>                        op->name, get_field_rd(inst));
>           break;
>       case INST_TYPE_RFSL:

I like PRIreg definition :)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

