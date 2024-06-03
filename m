Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268B7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sED8c-0003tx-AF; Mon, 03 Jun 2024 15:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED8a-0003tk-BE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:14:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED8X-0003EG-JB
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:14:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso30267345ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442067; x=1718046867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5YCgr/N7uIf9rlqaqycSe69Vn+OrUrLyVNf6T1lZnMk=;
 b=zVQOXG5zQXKcGFRPVRVjE6tdGT2i+mWMGznqsrXClPXX6Ri90YCBQ2Kegq7AlxWJHY
 Er3A9FBQfxKwIzdC/ZVcxFXKsfzT4PT/1UxZBmfmCjO7WRDZPWwK1x+iChheZznVnM7H
 Sg3SdqebbzCdR1GMqmnDMcLt1z1gkq3xkhKCSASCcwR8mB4n7VISAvMv5R5+aKdAXkMU
 5S7g3HmCRg0CUuo8qWjfXdOM11TYdkQXxQoe9ma809dl1aPfLJ8TbId0EvMFz4mfLOoP
 TnnM2UYXmA3NQEVsYNZWw43h9nwHGbgFbH677cW0Wfbq19xjx21Ucv9rDx4bvMwmcvql
 z+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442067; x=1718046867;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YCgr/N7uIf9rlqaqycSe69Vn+OrUrLyVNf6T1lZnMk=;
 b=v6zCcZ69aZsQJuDAy9/H0RiUXxCMUcUybsu3H+yFwaUOAKfIeg0UFTenyFLfIIFnp9
 MFwtRMPWWocWjG0F9dqQ43zuPLDRAgSYveLx6rZRqLMrokIHWS/okjKKbmaOOkWQ4/uW
 kAXjIsNfBwduvQSxbI4JdRXXn7LyCfVLsFrKftTxQDBl7GE9YvNMFswEDv7D+QzDntHQ
 ymj38/XaBOgCrZEf1C8TvHSxbSndmrjYB4NRQF70C3aeN38T0aDWi+9mLStSIzvYU2AT
 Z8lamCdVHMUro4r1Amiu0QyAsxQxfob7dbcaJrQtGgySsJ1hrIq7IfIEdFeA06Kk+j53
 1I1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Nm/QFDo63tloRNRDR8TyNtfgUSH00nxSUJhYiMZsVkE/Q1WpQroAsEMPH5pmqHSqE+hdKG5lpvsMN8EkjpkBJSaUDjw=
X-Gm-Message-State: AOJu0Yzh8GQ1n5dm+nJG6AV7qydUv37zwx0Jrln/63WNGnv7VBkaAtE7
 Ex25+jbO0C3mAd4kUGjlBY4gJhl8Y0Ba1lhcDKeoyTxzQEid2yymxaXoiDAYlPI=
X-Google-Smtp-Source: AGHT+IEKRgQE7jzdU2pmazhyW1rhpCCIt5SGMW9XzqT4WKCk1zrZiLAXYfu6nuaCPSDYqJ+rlEi2zA==
X-Received: by 2002:a17:903:2303:b0:1f6:7b40:984c with SMTP id
 d9443c01a7336-1f67b40be58mr46219155ad.22.1717442067101; 
 Mon, 03 Jun 2024 12:14:27 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632338baasm68732925ad.43.2024.06.03.12.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:14:26 -0700 (PDT)
Message-ID: <f177e88e-0af1-4ad8-82cc-87c9db85dc99@linaro.org>
Date: Mon, 3 Jun 2024 12:14:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/27] disas/microblaze: Split out print_immval_addr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
> Unify the code blocks that try to print a symbolic address.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/microblaze.c | 89 +++++++++++++++-------------------------------
>   1 file changed, 29 insertions(+), 60 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 49a4c0fd40..3473c94164 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -767,6 +767,24 @@ read_insn_microblaze (bfd_vma memaddr,
>     return inst;
>   }
>   
> +static void print_immval_addr(struct disassemble_info *info, bool immfound,
> +                              int immval, unsigned inst, int addend)
> +{
> +    if (info->print_address_func && info->symbol_at_address_func) {
> +        if (immfound) {
> +            immval |= get_int_field_imm(inst) & 0x0000ffff;
> +        } else {
> +            immval = (int16_t)get_int_field_imm(inst);
> +        }
> +        immval += addend;
> +        if (immval != 0 && info->symbol_at_address_func(immval, info)) {
> +            info->fprintf_func(info->stream, "\t// ");
> +            info->print_address_func (immval, info);
> +        } else if (addend) {
> +            info->fprintf_func(info->stream, "\t// %x", immval);
> +        }
> +    }
> +}
>   
>   int
>   print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
> @@ -821,18 +839,8 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
>        break;
>           case INST_TYPE_RD_R1_IMM:
>   	  fprintf_func(stream, "\t%s, %s, %s", get_field_rd(inst), get_field_r1(inst), get_field_imm(inst));
> -	  if (info->print_address_func && get_int_field_r1(inst) == 0 && info->symbol_at_address_func) {
> -	    if (immfound)
> -	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
> -	    else {
> -	      immval = get_int_field_imm(inst);
> -	      if (immval & 0x8000)
> -		immval |= 0xFFFF0000;
> -	    }
> -	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
> -	      fprintf_func (stream, "\t// ");
> -	      info->print_address_func (immval, info);
> -	    }
> +	  if (get_int_field_r1(inst) == 0) {
> +              print_immval_addr(info, immfound, immval, inst, 0);
>   	  }
>   	  break;
>   	case INST_TYPE_RD_R1_IMM5:
> @@ -860,61 +868,22 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
>   	  fprintf_func(stream, "\t%s, %s", get_field_r1(inst), get_field_imm(inst));
>   	  /* The non-pc relative instructions are returns, which shouldn't
>   	     have a label printed */
> -	  if (info->print_address_func && op->inst_offset_type == INST_PC_OFFSET && info->symbol_at_address_func) {
> -	    if (immfound)
> -	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
> -	    else {
> -	      immval = get_int_field_imm(inst);
> -	      if (immval & 0x8000)
> -		immval |= 0xFFFF0000;
> -	    }
> -	    immval += memaddr;
> -	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
> -	      fprintf_func (stream, "\t// ");
> -	      info->print_address_func (immval, info);
> -	    } else {
> -	      fprintf_func (stream, "\t\t// ");
> -	      fprintf_func (stream, "%x", immval);
> -	    }
> +	  if (op->inst_offset_type == INST_PC_OFFSET) {
> +              print_immval_addr(info, immfound, immval, inst, memaddr);
>   	  }
>   	  break;
>           case INST_TYPE_RD_IMM:
>   	  fprintf_func(stream, "\t%s, %s", get_field_rd(inst), get_field_imm(inst));
> -	  if (info->print_address_func && info->symbol_at_address_func) {
> -	    if (immfound)
> -	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
> -	    else {
> -	      immval = get_int_field_imm(inst);
> -	      if (immval & 0x8000)
> -		immval |= 0xFFFF0000;
> -	    }
> -	    if (op->inst_offset_type == INST_PC_OFFSET)
> -	      immval += (int) memaddr;
> -	    if (info->symbol_at_address_func(immval, info)) {
> -	      fprintf_func (stream, "\t// ");
> -	      info->print_address_func (immval, info);
> -	    }
> -	  }
> +          print_immval_addr(info, immfound, immval, inst,
> +                            op->inst_offset_type == INST_PC_OFFSET
> +                            ? memaddr : 0);
>   	  break;
>           case INST_TYPE_IMM:
>   	  fprintf_func(stream, "\t%s", get_field_imm(inst));
> -	  if (info->print_address_func && info->symbol_at_address_func && op->instr != imm) {
> -	    if (immfound)
> -	      immval |= (get_int_field_imm(inst) & 0x0000ffff);
> -	    else {
> -	      immval = get_int_field_imm(inst);
> -	      if (immval & 0x8000)
> -		immval |= 0xFFFF0000;
> -	    }
> -	    if (op->inst_offset_type == INST_PC_OFFSET)
> -	      immval += (int) memaddr;
> -	    if (immval > 0 && info->symbol_at_address_func(immval, info)) {
> -	      fprintf_func (stream, "\t// ");
> -	      info->print_address_func (immval, info);
> -	    } else if (op->inst_offset_type == INST_PC_OFFSET) {
> -	      fprintf_func (stream, "\t\t// ");
> -	      fprintf_func (stream, "%x", immval);
> -	    }
> +	  if (op->instr != imm) {
> +              print_immval_addr(info, immfound, immval, inst,
> +                                op->inst_offset_type == INST_PC_OFFSET
> +                                ? memaddr : 0);
>   	  }
>   	  break;
>           case INST_TYPE_RD_R2:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

