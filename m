Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34477C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDEk-0000MG-QT; Mon, 03 Jun 2024 15:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDEi-0000Lr-TD
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:20:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEDEg-0005Lr-Gu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:20:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7025f4f4572so1223211b3a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442448; x=1718047248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5XzSpdFe0GTE1TlTapWSZ2i2AzEfAwXUgBDkLBFQFpg=;
 b=u7VgSX1/1b7v/2W1OI2a6nMBJiAA1JYs3/1LBCBomH5IXJlxfQgr8OUzFXSEmFFR5t
 QzsQ3Zx+wvCJ87i4kmfe6fGSSu+TTz3c8BHFMpv16NNELeKzC+2EGS4cNIxQDwH07iXe
 nLsMOA2J5xxWgnBvRB13P266GCmGgPy0X9RfDcFtsip2l6LoCmJ/khK4Y/xu2ktzBzk2
 89Lllp/kDV7nkC037WGm/mFIuRHgP/an4lDZjaKF6jXI92olBor2ybqdojfc8vpjJjGS
 eOhFrn2FV2kX6RMIVqpV2pr43wwIWY+V+2uN3G5hgL+aQvXRZHtRo+cLA6gPlg6HL97+
 LX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442448; x=1718047248;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XzSpdFe0GTE1TlTapWSZ2i2AzEfAwXUgBDkLBFQFpg=;
 b=Btm6IDnD9c0d1HmmLG4VGH46U0XBGGf4OyqENjT4FrA6Nw/+9N9rw4Hli9lUmqbi5E
 W3pPZr5ZYvnHXA6Mu62u1CdEi+BBzsRXE0sqaCpJML3JFGJb6w5iJVrmbavuuR3eTP+d
 zTganrS7oTEux50zQOMIbA1bUfUjY7C4itUXmJxAMML1pazCPT+/8Zkd0ZxzI65HHyUr
 nGYVtV5mFgSvkJW1hCoHaUHBKILt5Cmm5Gy7/VtaVHbKTSvzyMr8BIuNf6Dw1k1CgREF
 6kezOGb8ktiVE+qpjbQxVWO6IpqKJxCdW9zjTO6Jw8NbnVgOo9IicA1rj0mIszwy242A
 IyFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC/Af7Fe2cVl6jhYMd76VDtbtg1+r++ukyCw82CEysJP+K4mGEHHOuGvFWvb0Di9S6aW7M35iQEbldNUGHbVNAH5HgpYk=
X-Gm-Message-State: AOJu0Yy3UZ3N5D801SnUYmvWqNkfIPwt1ChZu2sYKGvRuboi2hsIzh2Q
 5ryOGse7Md6RVP3Ot7rvBiWfNQxeOWGKNEBr9XmWkNBITF1zDbQFjM8JicNzJ2UVbG+r7rbRtKN
 s
X-Google-Smtp-Source: AGHT+IFgjoqUc5WcksayAnWb4JpgDETZobcGv5WdpWeKWTWAhsURFnDlYkmMvydJFuwL1F7TeL2EqQ==
X-Received: by 2002:a05:6a20:e607:b0:1b0:20e9:d215 with SMTP id
 adf61e73a8af0-1b2a2bfc5f5mr808796637.14.1717442448552; 
 Mon, 03 Jun 2024 12:20:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c354b945a8sm5669748a12.23.2024.06.03.12.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:20:48 -0700 (PDT)
Message-ID: <80ef32c3-9a8f-45c0-8c3b-4709c67f771d@linaro.org>
Date: Mon, 3 Jun 2024 12:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/27] disas/microblaze: Split get_field_special
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
> Extract the raw special index and a function to lookup a name.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/microblaze.c | 142 +++++++++++++++++++--------------------------
>   1 file changed, 61 insertions(+), 81 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 24febfdea9..197327fae4 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -564,8 +564,6 @@ static const struct op_code_struct {
>   
>   /* prefix for register names */
>   #define register_prefix "r"
> -static const char pvr_register_prefix[] = "rpvr";
> -
>   
>   /* #defines for valid immediate range */
>   #define MIN_IMM  ((int) 0x80000000)
> @@ -580,6 +578,7 @@ static const char pvr_register_prefix[] = "rpvr";
>   
>   #define PRIreg    register_prefix "%ld"
>   #define PRIrfsl   register_prefix "fsl%ld"
> +#define PRIpvr    register_prefix "pvr%d"
>   #define PRIimm    "%d"
>   
>   #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
> @@ -593,83 +592,48 @@ static const char pvr_register_prefix[] = "rpvr";
>   #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
>   #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
>   
> -/*
> -  char *
> -  get_field_special (instr)
> -  long instr;
> -  {
> -  char tmpstr[25];
> -
> -  snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix,
> -          (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
> -
> -  return(strdup(tmpstr));
> -  }
> -*/
> -
> -static char *
> -get_field_special(long instr, const struct op_code_struct *op)
> +static int get_field_special(long instr, const struct op_code_struct *op)
>   {
> -   char tmpstr[25];
> -   char spr[6];
> +    return ((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask;
> +}
>   
> -   switch ( (((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) ) {
> -
> -   case REG_MSR_MASK :
> -      strcpy(spr, "msr");
> -      break;
> -   case REG_PC_MASK :
> -      strcpy(spr, "pc");
> -      break;
> -   case REG_EAR_MASK :
> -      strcpy(spr, "ear");
> -      break;
> -   case REG_ESR_MASK :
> -      strcpy(spr, "esr");
> -      break;
> -   case REG_FSR_MASK :
> -      strcpy(spr, "fsr");
> -      break;
> -   case REG_BTR_MASK :
> -      strcpy(spr, "btr");
> -      break;
> -   case REG_EDR_MASK :
> -      strcpy(spr, "edr");
> -      break;
> -   case REG_PID_MASK :
> -      strcpy(spr, "pid");
> -      break;
> -   case REG_ZPR_MASK :
> -      strcpy(spr, "zpr");
> -      break;
> -   case REG_TLBX_MASK :
> -      strcpy(spr, "tlbx");
> -      break;
> -   case REG_TLBLO_MASK :
> -      strcpy(spr, "tlblo");
> -      break;
> -   case REG_TLBHI_MASK :
> -      strcpy(spr, "tlbhi");
> -      break;
> -   case REG_TLBSX_MASK :
> -      strcpy(spr, "tlbsx");
> -      break;
> -   default :
> -     {
> -       if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
> -          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
> -                 (unsigned short)(((instr & IMM_MASK) >> IMM_LOW) ^
> -                                  op->immval_mask) ^ REG_PVR_MASK);
> -	 return(strdup(tmpstr));
> -       } else {
> -	 strcpy(spr, "pc");
> -       }
> -     }
> -     break;
> -   }
> -
> -   snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix, spr);
> -   return(strdup(tmpstr));
> +/* Returns NULL for PVR registers, which should be rendered differently. */
> +static const char *get_special_name(int special)
> +{
> +    switch (special) {
> +    case REG_MSR_MASK:
> +        return register_prefix "msr";
> +    case REG_PC_MASK:
> +        return register_prefix "pc";
> +    case REG_EAR_MASK:
> +        return register_prefix "ear";
> +    case REG_ESR_MASK:
> +        return register_prefix "esr";
> +    case REG_FSR_MASK:
> +        return register_prefix "fsr";
> +    case REG_BTR_MASK:
> +        return register_prefix "btr";
> +    case REG_EDR_MASK:
> +        return register_prefix "edr";
> +    case REG_PID_MASK:
> +        return register_prefix "pid";
> +    case REG_ZPR_MASK:
> +        return register_prefix "zpr";
> +    case REG_TLBX_MASK:
> +        return register_prefix "tlbx";
> +    case REG_TLBLO_MASK:
> +        return register_prefix "tlblo";
> +    case REG_TLBHI_MASK:
> +        return register_prefix "tlbhi";
> +    case REG_TLBSX_MASK:
> +        return register_prefix "tlbsx";
> +    default:
> +        if ((special & 0xE000) == REG_PVR_MASK) {
> +            /* pvr register */
> +            return NULL;
> +        }
> +        return register_prefix "pc";
> +    }
>   }
>   
>   static unsigned long
> @@ -739,6 +703,8 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>       static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
>       static int prev_insn_vma = -1;  /*init the prev insn vma */
>       int curr_insn_vma = info->buffer_vma;
> +    int special;
> +    const char *special_name;
>   
>       info->bytes_per_chunk = 4;
>   
> @@ -799,12 +765,26 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>                        op->name, get_field_r1(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_RD_SPECIAL:
> -        fprintf_func(stream, "%s\t" PRIreg ", %s",
> -                     op->name, get_field_rd(inst), get_field_special(inst, op));
> +        special = get_field_special(inst, op);
> +        special_name = get_special_name(special);
> +        if (special_name) {
> +            fprintf_func(stream, "%s\t" PRIreg ", %s",
> +                         op->name, get_field_rd(inst), special_name);
> +        } else {
> +            fprintf_func(stream, "%s\t" PRIreg ", " PRIpvr,
> +                         op->name, get_field_rd(inst), special ^ REG_PVR_MASK);
> +        }
>           break;
>       case INST_TYPE_SPECIAL_R1:
> -        fprintf_func(stream, "%s\t%s, " PRIreg,
> -                     op->name, get_field_special(inst, op), get_field_r1(inst));
> +        special = get_field_special(inst, op);
> +        special_name = get_special_name(special);
> +        if (special_name) {
> +            fprintf_func(stream, "%s\t%s, " PRIreg,
> +                         op->name, special_name, get_field_r1(inst));
> +        } else {
> +            fprintf_func(stream, "%s\t" PRIpvr ", " PRIreg,
> +                         op->name, special ^ REG_PVR_MASK, get_field_r1(inst));
> +        }
>           break;
>       case INST_TYPE_RD_R1:
>           fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

