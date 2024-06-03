Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C9C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sED8v-0003xr-BW; Mon, 03 Jun 2024 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED8t-0003xN-5D
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:14:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED8q-0003Fp-Ok
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:14:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7024791a950so2174700b3a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442087; x=1718046887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x4CcstOZGMAMdefBZzK9RbI4SnSdg2NAu678nm5AX/I=;
 b=nijlS9ElqUB8jN7m4H5ONS+2GLj8r5sKs3jlbUPUDUre5JGwmoghlwqwcObhYuMp6A
 VKUar9N9dmp8IrO/5zdng6l88Kr+xQ5FEC1HaPaAGF1UX9dQhIo9Mr0+xsboZmMk0i5Q
 KzUzT2rmCVS2rqe05TwQU8K82ixt7Y3v0rlwG2hTnYSsUL4QUnbf02JpLGIRNBNUeGQm
 85VQb0L2CMdJjYjzlxNZlKiIqG/rN+7qtPD9F0Bq2NDM92xwsWF8+Mnt45UOEvZfVfld
 Bm0BQnAd9YySfse54HpfqvB0ROXMSBI2ANxmtlQ3dB8Ly11t0onZKLSHYuuKE+HwUZYr
 c4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442087; x=1718046887;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4CcstOZGMAMdefBZzK9RbI4SnSdg2NAu678nm5AX/I=;
 b=ovqecHowp7lV4XeS139GNZ2qv/yQzunlry9RnJrquyN8QjzOgb9ePyhjHFKhMRHnnc
 3qoevyYeTHzxfxTSrY9HHguYC9d7X8PlrECclJPbTrix9+s3JnBDdmbD5cMyr9bDwAIu
 mOEW47zdHUQvz9Q0awPJgw9vWsnbXuwJ/8MW0odFtb4kBLfsWrb+zTYR/jSZHWCx01vr
 TnKel2Nr5a0qO3cVZ5rFVSENOGzdrSz6Xcw+1qkm/qS0Jlfopd6ajOr3Gqs+LMyvq7Iq
 gSdHVQykbnOX/J3aM9Ncvd3pM4w7X/C5FgIngJdas8NGVDdw3X7UbmN6qaXnzuEy7X0y
 FscQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxqgVsOTEpvLQm8juvBT6aYgrAmpDjpAsPUdGWzNED9rzDtpBlSFXNYYOMU+3Fug4FAkrMCAADtKW7/LZEd2Lxx/k58QU=
X-Gm-Message-State: AOJu0YzWxFwXvtwTk4xSohsIIFSlXXUjUmlZdUT9TOpny02vP1pWHcRA
 s+AMY00bCboMj+2avZNHe/OU49Tewpv7WvqtJV7zvkmWgo9gUK9SF0Igl200qqnKNad7Hmtdy5e
 K
X-Google-Smtp-Source: AGHT+IFEWmbZd74t3WkUNWTNc4f0gzyGDFxtFdyUweG+h0DPtVzH+/Qgs0+qYpWscP5nswo233tHKw==
X-Received: by 2002:a05:6a20:8418:b0:1a7:590e:279e with SMTP id
 adf61e73a8af0-1b2a2b84011mr818533637.5.1717442086566; 
 Mon, 03 Jun 2024 12:14:46 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c7b8bsm6027335b3a.17.2024.06.03.12.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:14:46 -0700 (PDT)
Message-ID: <521297e9-e93a-4c6d-827f-45c62e814ec0@linaro.org>
Date: Mon, 3 Jun 2024 12:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/27] target/microblaze: Re-indent
 print_insn_microblaze
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/microblaze.c | 263 ++++++++++++++++++++++++---------------------
>   1 file changed, 141 insertions(+), 122 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 3473c94164..c729c76585 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -787,134 +787,153 @@ static void print_immval_addr(struct disassemble_info *info, bool immfound,
>   }
>   
>   int
> -print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
> +print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>   {
> -  fprintf_function    fprintf_func = info->fprintf_func;
> -  void *              stream = info->stream;
> -  unsigned long       inst, prev_inst;
> -  const struct op_code_struct *op, *pop;
> -  int                 immval = 0;
> -  bfd_boolean         immfound = FALSE;
> -  static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
> -  static int     prev_insn_vma = -1;  /*init the prev insn vma */
> -  int            curr_insn_vma = info->buffer_vma;
> +    fprintf_function fprintf_func = info->fprintf_func;
> +    void *stream = info->stream;
> +    unsigned long inst, prev_inst;
> +    const struct op_code_struct *op, *pop;
> +    int immval = 0;
> +    bool immfound = false;
> +    static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
> +    static int prev_insn_vma = -1;  /*init the prev insn vma */
> +    int curr_insn_vma = info->buffer_vma;
>   
> -  info->bytes_per_chunk = 4;
> +    info->bytes_per_chunk = 4;
>   
> -  inst = read_insn_microblaze (memaddr, info, &op);
> -  if (inst == 0) {
> -    return -1;
> -  }
> +    inst = read_insn_microblaze (memaddr, info, &op);
> +    if (inst == 0) {
> +        return -1;
> +    }
>     
> -  if (prev_insn_vma == curr_insn_vma) {
> -  if (memaddr-(info->bytes_per_chunk) == prev_insn_addr) {
> -    prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
> -    if (prev_inst == 0)
> -      return -1;
> -    if (pop->instr == imm) {
> -      immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
> -      immfound = TRUE;
> +    if (prev_insn_vma == curr_insn_vma) {
> +        if (memaddr - info->bytes_per_chunk == prev_insn_addr) {
> +            prev_inst = read_insn_microblaze (prev_insn_addr, info, &pop);
> +            if (prev_inst == 0)
> +                return -1;
> +            if (pop->instr == imm) {
> +                immval = (get_int_field_imm(prev_inst) << 16) & 0xffff0000;
> +                immfound = TRUE;
> +            }
> +            else {
> +                immval = 0;
> +                immfound = FALSE;
> +            }
> +        }
>       }
> -    else {
> -      immval = 0;
> -      immfound = FALSE;
> -    }
> -  }
> -  }
> -  /* make curr insn as prev insn */
> -  prev_insn_addr = memaddr;
> -  prev_insn_vma = curr_insn_vma;
> +    /* make curr insn as prev insn */
> +    prev_insn_addr = memaddr;
> +    prev_insn_vma = curr_insn_vma;
>   
> -  if (op->name == 0) {
> -    fprintf_func (stream, ".short 0x%04lx", inst);
> -  }
> -  else
> -    {
> -      fprintf_func (stream, "%s", op->name);
> +    if (op->name == 0) {
> +        fprintf_func (stream, ".short 0x%04lx", inst);
> +        return 4;
> +    }
> +
> +    fprintf_func (stream, "%s", op->name);
>         
> -      switch (op->inst_type)
> -	{
> -  case INST_TYPE_RD_R1_R2:
> -     fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_r2(inst));
> -     break;
> -        case INST_TYPE_RD_R1_IMM:
> -	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
> -	  if (get_int_field_r1(inst) == 0) {
> -              print_immval_addr(info, immfound, immval, inst, 0);
> -	  }
> -	  break;
> -	case INST_TYPE_RD_R1_IMM5:
> -	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm5(inst));
> -	  break;
> -	case INST_TYPE_RD_RFSL:
> -	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_rfsl(inst));
> -	  break;
> -	case INST_TYPE_R1_RFSL:
> -	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_rfsl(inst));
> -	  break;
> -	case INST_TYPE_RD_SPECIAL:
> -	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_special(inst, op));
> -	  break;
> -	case INST_TYPE_SPECIAL_R1:
> -	  fprintf_func(stream, "\t%s, %s", get_field_special(inst, op), get_field_r1(inst));
> -	  break;
> -	case INST_TYPE_RD_R1:
> -	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r1(inst));
> -	  break;
> -	case INST_TYPE_R1_R2:
> -	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_r2(inst));
> -	  break;
> -	case INST_TYPE_R1_IMM:
> -	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
> -	  /* The non-pc relative instructions are returns, which shouldn't
> -	     have a label printed */
> -	  if (op->inst_offset_type == INST_PC_OFFSET) {
> -              print_immval_addr(info, immfound, immval, inst, memaddr);
> -	  }
> -	  break;
> -        case INST_TYPE_RD_IMM:
> -	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
> -          print_immval_addr(info, immfound, immval, inst,
> -                            op->inst_offset_type == INST_PC_OFFSET
> -                            ? memaddr : 0);
> -	  break;
> -        case INST_TYPE_IMM:
> -	  fprintf_func(stream, "\t%s", get_field_imm(inst));
> -	  if (op->instr != imm) {
> -              print_immval_addr(info, immfound, immval, inst,
> -                                op->inst_offset_type == INST_PC_OFFSET
> -                                ? memaddr : 0);
> -	  }
> -	  break;
> -        case INST_TYPE_RD_R2:
> -	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
> -	  break;
> -  case INST_TYPE_R2:
> -     fprintf_func(stream, "\t%s", get_field_r2(inst));
> -     break;
> -  case INST_TYPE_R1:
> -     fprintf_func(stream, "\t%s", get_field_r1(inst));
> -     break;
> -  case INST_TYPE_RD_R1_SPECIAL:
> -     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_r2(inst));
> -     break;
> -  case INST_TYPE_RD_IMM15:
> -     fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm15(inst));
> -     break;
> -     /* For tuqula instruction */
> -  case INST_TYPE_RD:
> -     fprintf_func(stream, "\t%s", get_field_rd(inst));
> -     break;
> -  case INST_TYPE_RFSL:
> -     fprintf_func(stream, "\t%s", get_field_rfsl(inst));
> -     break;
> -  default:
> -	  /* if the disassembler lags the instruction set */
> -	  fprintf_func (stream, "\tundecoded operands, inst is 0x%04lx", inst);
> -	  break;
> -	}
> +    switch (op->inst_type) {
> +    case INST_TYPE_RD_R1_R2:
> +        fprintf_func(stream, "\t%s, %s, %s",
> +                     get_field_rd(inst), get_field_r1(inst),
> +                     get_field_r2(inst));
> +        break;
> +    case INST_TYPE_RD_R1_IMM:
> +        fprintf_func(stream, "\t%s, %s, %s",
> +                     get_field_rd(inst), get_field_r1(inst),
> +                     get_field_imm(inst));
> +        if (get_int_field_r1(inst) == 0) {
> +            print_immval_addr(info, immfound, immval, inst, 0);
> +        }
> +        break;
> +    case INST_TYPE_RD_R1_IMM5:
> +        fprintf_func(stream, "\t%s, %s, %s",
> +                     get_field_rd(inst), get_field_r1(inst),
> +                     get_field_imm5(inst));
> +        break;
> +    case INST_TYPE_RD_RFSL:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_rfsl(inst));
> +        break;
> +    case INST_TYPE_R1_RFSL:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_r1(inst), get_field_rfsl(inst));
> +        break;
> +    case INST_TYPE_RD_SPECIAL:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_special(inst, op));
> +        break;
> +    case INST_TYPE_SPECIAL_R1:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_special(inst, op), get_field_r1(inst));
> +        break;
> +    case INST_TYPE_RD_R1:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_r1(inst));
> +        break;
> +    case INST_TYPE_R1_R2:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_r1(inst), get_field_r2(inst));
> +        break;
> +    case INST_TYPE_R1_IMM:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_r1(inst), get_field_imm(inst));
> +        /*
> +         * The non-pc relative instructions are returns,
> +         * which shouldn't have a label printed.
> +         */
> +        if (op->inst_offset_type == INST_PC_OFFSET) {
> +            print_immval_addr(info, immfound, immval, inst, memaddr);
> +        }
> +        break;
> +    case INST_TYPE_RD_IMM:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_imm(inst));
> +        print_immval_addr(info, immfound, immval, inst,
> +                          op->inst_offset_type == INST_PC_OFFSET
> +                          ? memaddr : 0);
> +        break;
> +    case INST_TYPE_IMM:
> +        fprintf_func(stream, "\t%s", get_field_imm(inst));
> +        if (op->instr != imm) {
> +            print_immval_addr(info, immfound, immval, inst,
> +                              op->inst_offset_type == INST_PC_OFFSET
> +                              ? memaddr : 0);
> +        }
> +        break;
> +    case INST_TYPE_RD_R2:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_r2(inst));
> +        break;
> +    case INST_TYPE_R2:
> +        fprintf_func(stream, "\t%s",
> +                     get_field_r2(inst));
> +        break;
> +    case INST_TYPE_R1:
> +        fprintf_func(stream, "\t%s",
> +                     get_field_r1(inst));
> +        break;
> +    case INST_TYPE_RD_R1_SPECIAL:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_r2(inst));
> +        break;
> +    case INST_TYPE_RD_IMM15:
> +        fprintf_func(stream, "\t%s, %s",
> +                     get_field_rd(inst), get_field_imm15(inst));
> +        break;
> +        /* For tuqula instruction */
> +    case INST_TYPE_RD:
> +        fprintf_func(stream, "\t%s",
> +                     get_field_rd(inst));
> +        break;
> +    case INST_TYPE_RFSL:
> +        fprintf_func(stream, "\t%s",
> +                     get_field_rfsl(inst));
> +        break;
> +    default:
> +        /* if the disassembler lags the instruction set */
> +        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
> +        break;
>       }
> -
> -  /* Say how many bytes we consumed? */
> -  return 4;
> +    return 4;
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

