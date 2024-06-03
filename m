Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479F0C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDBc-0006NT-IN; Mon, 03 Jun 2024 15:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBa-0006Mv-3O
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDBY-0003we-9F
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:17:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so35690705ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442255; x=1718047055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rtsgNad0cGay/QF+7+nFzmagTOiSzpl6v3oUQknGl+E=;
 b=c2K09FrJK6H+viLDmMXEUCDzKUjtXD4lWVBkzNEjtM7z+PVIYku5M0EMAdgVH6UoUH
 sruWX28MJmYioL6KK9QvWgQFhdukLRyl23ooFB6f5pLZbgTN+Wg5aDP+uuD+iohDPNbK
 WiikDFvs8UNTWl5tNF/3BV6tn0O26h5NYBo0tF8LaVsNJMVLbLYnVbMtESpKxpJ/gVza
 dC5mAlwk1dRPYbdTYKlS9kOYp4HszqudPULr4vte9RB+bvHlcxcJXEBxPXbMwjFDlDZG
 ViSJ2++ph1/O91C2JyC1mqoT2yspR2kMc8b+pLbVEQdFLMtTP2jQ3kSV1oUQIDhAw99H
 26fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442255; x=1718047055;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rtsgNad0cGay/QF+7+nFzmagTOiSzpl6v3oUQknGl+E=;
 b=reTax12Xo+iARWuIOZbz2Q0kRmy0i7C0/2h1yIy1cuT8ELzyyJhsjSCDZyCdgpoQu+
 jBwXibkos0yemo36rc4R+IfWTz99M8AwkIYoMWrley83EcU7NNRjAImywnuHeZnyiluw
 UoKsTAyU9QIzUFY073BjFTNoNKtJKyXmw+bNnNa0PU7DS/i+3tufUwkM7ZZZQi0xHunK
 qrFd2/5gEGmr+SfO2TWmoY+F50YOZjmh32xjAL/z9fDGP96vPz8/3zt6Xm6ofm2CBSlh
 anQhPEcqym9ehSxW3dDCw61UPd250nflcEmKo2FaU3M+rRXW3nlUGjDDylr63dQCFktf
 HJUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvywn/DQ20xf+3grp2axgZBf4kKJq2nGwae2YEpYITBgT2l6aTh8Pe0Gg7CWBBTvjFfiFE2NBGyveh+Ko/fwWWc8Nz+vs=
X-Gm-Message-State: AOJu0Yx45ZcZ7zbqYg7PowHVxTvOwdrUnbG3Cg7+zbqH6bS+SXzJMDmX
 KrBSkGKYJ5/Gr1bM5tgWr0iM9dweie5IicOLPcX5tdqYBMMRgRr7+9oX+9VUkJqlueTjuBZlirW
 j
X-Google-Smtp-Source: AGHT+IGwZLJTQMaJ5osrcAgZ5L+uIIHVneVmcpjo56NDdTSFAbwvXCzK5YgmT1ZB9j+HliaEX3/wWg==
X-Received: by 2002:a17:903:2304:b0:1f4:ad4f:6fbe with SMTP id
 d9443c01a7336-1f637005bf7mr105563025ad.22.1717442254502; 
 Mon, 03 Jun 2024 12:17:34 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f66c986632sm31629185ad.168.2024.06.03.12.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:17:34 -0700 (PDT)
Message-ID: <fdfb927a-012a-4c8f-98c0-01fe3d58ae4e@linaro.org>
Date: Mon, 3 Jun 2024 12:17:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/27] disas/microblaze: Print immediates directly with
 PRIimm
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
>   disas/microblaze.c | 61 +++++++++-------------------------------------
>   1 file changed, 11 insertions(+), 50 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index c12968f3b9..390f98c0a3 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -580,40 +580,21 @@ static const char pvr_register_prefix[] = "rpvr";
>   #include "disas/dis-asm.h"
>   
>   #define PRIreg    register_prefix "%ld"
> +#define PRIimm    "%d"
>   
>   #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
>   #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
>   #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
> +#define get_field_imm(instr)     ((int16_t)instr)
> +#define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
> +#define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
> +
>   #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
>   #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
>   
>   /* Local function prototypes. */
>   
> -static char * get_field_imm (long instr);
> -static char * get_field_imm5 (long instr);
>   static char * get_field_rfsl (long instr);
> -static char * get_field_imm15 (long instr);
> -#if 0
> -static char * get_field_unsigned_imm (long instr);
> -#endif
> -
> -static char *
> -get_field_imm (long instr)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%d",
> -           (short)((instr & IMM_MASK) >> IMM_LOW));
> -  return(strdup(tmpstr));
> -}
> -
> -static char *
> -get_field_imm5 (long instr)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%d",
> -           (short)((instr & IMM5_MASK) >> IMM_LOW));
> -  return(strdup(tmpstr));
> -}
>   
>   static char *
>   get_field_rfsl (long instr)
> @@ -624,26 +605,6 @@ get_field_rfsl (long instr)
>     return(strdup(tmpstr));
>   }
>   
> -static char *
> -get_field_imm15 (long instr)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%d",
> -           (short)((instr & IMM15_MASK) >> IMM_LOW));
> -  return(strdup(tmpstr));
> -}
> -
> -#if 0
> -static char *
> -get_field_unsigned_imm (long instr)
> -{
> -  char tmpstr[25];
> -  snprintf(tmpstr, sizeof(tmpstr), "%d",
> -           (int)((instr & IMM_MASK) >> IMM_LOW));
> -  return(strdup(tmpstr));
> -}
> -#endif
> -
>   /*
>     char *
>     get_field_special (instr)
> @@ -829,7 +790,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_R1_IMM:
> -        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
>                        op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm(inst));
>           if (get_int_field_r1(inst) == 0) {
> @@ -837,7 +798,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_R1_IMM5:
> -        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
>                        op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm5(inst));
>           break;
> @@ -866,7 +827,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        op->name, get_field_r1(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_R1_IMM:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
>                        op->name, get_field_r1(inst), get_field_imm(inst));
>           /*
>            * The non-pc relative instructions are returns,
> @@ -877,14 +838,14 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_IMM:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
>                        op->name, get_field_rd(inst), get_field_imm(inst));
>           print_immval_addr(info, immfound, immval, inst,
>                             op->inst_offset_type == INST_PC_OFFSET
>                             ? memaddr : 0);
>           break;
>       case INST_TYPE_IMM:
> -        fprintf_func(stream, "%s\t%s",
> +        fprintf_func(stream, "%s\t" PRIimm,
>                        op->name, get_field_imm(inst));
>           if (op->instr != imm) {
>               print_immval_addr(info, immfound, immval, inst,
> @@ -909,7 +870,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        op->name, get_field_rd(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_IMM15:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> +        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
>                        op->name, get_field_rd(inst), get_field_imm15(inst));
>           break;
>           /* For tuqula instruction */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

