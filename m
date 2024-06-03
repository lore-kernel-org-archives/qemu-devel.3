Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD21C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sED9V-0004BU-Rt; Mon, 03 Jun 2024 15:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED9T-00048A-Gg
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:15:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED9R-0003Xw-Hp
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:15:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f480624d0fso35355725ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717442123; x=1718046923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6YDACc4QZcL8nJXIdI2WNbHSj/DZwrU/s5TxNvHLHA=;
 b=zs49BzNs7hF171KnnKQPdObqUniAmSNgT7Zy+QuZmOmlQAUx40nMpxp5+T36fC3Xou
 NXukUBXqSABurLg8/HZs4st2/DJf6gONp9bj8IPqMMmxp2+HsNCNpiW73ewucl49cFr8
 btFFteZrMonfzixJOxQXKZiw830VDuYPc7wc/AX43wXk7cagudAf4xgu/3FbY4xOOiBe
 6sWbzzg9vm6mIhZ0CTiQIPllpIGW3RWgTPi0JdTbBzXCUBoLKRwwN+zmsijhje9pcEu1
 DuUVOSL703NFXf/4Frx6tOb+rneCahD3vcY9z9+ZUtRYXMpQBjSiaZODNZWXWnVbvO3s
 npRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717442123; x=1718046923;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6YDACc4QZcL8nJXIdI2WNbHSj/DZwrU/s5TxNvHLHA=;
 b=Y/cU2XJcDeNDVwawHDn4+vflCaox8gPrHCRFskw+naVRkt/MRWAGRktLVY7J9q4voX
 ueNKgdxi9Cbw58aEi6+SxeyKrXDmsMHDVYdikeUwWF0EQ0rmISvQxWS2N1RkJrNtfo58
 8mPKMAmH8xTzhsNRlASiuspBGBQC5r9FHB5p2d4lwitc4KKDdBKIBQoj8HoABbugboQY
 /dYkUlLT8PeN28FlTzx9LpkwD7a5muToZE3HOo5l16VeL/S+/kIkyLnuwvx2REqlCJJf
 9zUyrTJPqpzPwpOSsYHu5apag4QahGIS/guLAZsbsVZdp9x16qY7XgWA5n95ikxKEvk2
 sVRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXycTBm2Z4NoWoe0SEfdwVOYDHZzivGZeExB7AoCY+RZZc3YnUCUnt1TdC8/IojVtRGJSVnOqEBURWUH6oz4SU+VvZFNpY=
X-Gm-Message-State: AOJu0Yxu3nvPNYMQz5X5iesvwO/xO85N8UFmkfajGvZAd8ExjlQFJLa3
 QPQ9MSt2YzFgPkClgl295AW/YI65cEoKCJRsO2Ld/7/eNVQm7bRW+wHCh1Avgu42adbLBwuGF6F
 6
X-Google-Smtp-Source: AGHT+IEZMoqTzqlZvl6gOD1I7foqi9WLLey4IGtD3W3dGcmvBaP9/oZi0Nyqi2blF4Edaoesq3J+Lw==
X-Received: by 2002:a17:903:2289:b0:1f4:a3a1:a7e9 with SMTP id
 d9443c01a7336-1f63701f13cmr116822345ad.24.1717442123028; 
 Mon, 03 Jun 2024 12:15:23 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323ebaebsm68784645ad.195.2024.06.03.12.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:15:22 -0700 (PDT)
Message-ID: <18067150-5660-4e1c-a5d3-8b9c8e318038@linaro.org>
Date: Mon, 3 Jun 2024 12:15:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/27] disas/microblaze: Merge op->name output into
 each fprintf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
> In the common case, issue one single fprintf.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/microblaze.c | 80 +++++++++++++++++++++++-----------------------
>   1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index c729c76585..a537ac65dd 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -830,54 +830,52 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           return 4;
>       }
>   
> -    fprintf_func (stream, "%s", op->name);
> -
>       switch (op->inst_type) {
>       case INST_TYPE_RD_R1_R2:
> -        fprintf_func(stream, "\t%s, %s, %s",
> -                     get_field_rd(inst), get_field_r1(inst),
> +        fprintf_func(stream, "%s\t%s, %s, %s",
> +                     op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_R1_IMM:
> -        fprintf_func(stream, "\t%s, %s, %s",
> -                     get_field_rd(inst), get_field_r1(inst),
> +        fprintf_func(stream, "%s\t%s, %s, %s",
> +                     op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm(inst));
>           if (get_int_field_r1(inst) == 0) {
>               print_immval_addr(info, immfound, immval, inst, 0);
>           }
>           break;
>       case INST_TYPE_RD_R1_IMM5:
> -        fprintf_func(stream, "\t%s, %s, %s",
> -                     get_field_rd(inst), get_field_r1(inst),
> +        fprintf_func(stream, "%s\t%s, %s, %s",
> +                     op->name, get_field_rd(inst), get_field_r1(inst),
>                        get_field_imm5(inst));
>           break;
>       case INST_TYPE_RD_RFSL:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_rfsl(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_R1_RFSL:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_r1(inst), get_field_rfsl(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_r1(inst), get_field_rfsl(inst));
>           break;
>       case INST_TYPE_RD_SPECIAL:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_special(inst, op));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_special(inst, op));
>           break;
>       case INST_TYPE_SPECIAL_R1:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_special(inst, op), get_field_r1(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_special(inst, op), get_field_r1(inst));
>           break;
>       case INST_TYPE_RD_R1:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_r1(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_r1(inst));
>           break;
>       case INST_TYPE_R1_R2:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_r1(inst), get_field_r2(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_r1(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_R1_IMM:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_r1(inst), get_field_imm(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_r1(inst), get_field_imm(inst));
>           /*
>            * The non-pc relative instructions are returns,
>            * which shouldn't have a label printed.
> @@ -887,14 +885,15 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_IMM:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_imm(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_imm(inst));
>           print_immval_addr(info, immfound, immval, inst,
>                             op->inst_offset_type == INST_PC_OFFSET
>                             ? memaddr : 0);
>           break;
>       case INST_TYPE_IMM:
> -        fprintf_func(stream, "\t%s", get_field_imm(inst));
> +        fprintf_func(stream, "%s\t%s",
> +                     op->name, get_field_imm(inst));
>           if (op->instr != imm) {
>               print_immval_addr(info, immfound, immval, inst,
>                                 op->inst_offset_type == INST_PC_OFFSET
> @@ -902,37 +901,38 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
>           }
>           break;
>       case INST_TYPE_RD_R2:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_r2(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_R2:
> -        fprintf_func(stream, "\t%s",
> -                     get_field_r2(inst));
> +        fprintf_func(stream, "%s\t%s",
> +                     op->name, get_field_r2(inst));
>           break;
>       case INST_TYPE_R1:
> -        fprintf_func(stream, "\t%s",
> -                     get_field_r1(inst));
> +        fprintf_func(stream, "%s\t%s",
> +                     op->name, get_field_r1(inst));
>           break;
>       case INST_TYPE_RD_R1_SPECIAL:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_r2(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_r2(inst));
>           break;
>       case INST_TYPE_RD_IMM15:
> -        fprintf_func(stream, "\t%s, %s",
> -                     get_field_rd(inst), get_field_imm15(inst));
> +        fprintf_func(stream, "%s\t%s, %s",
> +                     op->name, get_field_rd(inst), get_field_imm15(inst));
>           break;
>           /* For tuqula instruction */
>       case INST_TYPE_RD:
> -        fprintf_func(stream, "\t%s",
> -                     get_field_rd(inst));
> +        fprintf_func(stream, "%s\t%s",
> +                     op->name, get_field_rd(inst));
>           break;
>       case INST_TYPE_RFSL:
> -        fprintf_func(stream, "\t%s",
> -                     get_field_rfsl(inst));
> +        fprintf_func(stream, "%s\t%s",
> +                     op->name, get_field_rfsl(inst));
>           break;
>       default:
>           /* if the disassembler lags the instruction set */
> -        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
> +        fprintf_func(stream, "%s\tundecoded operands, inst is 0x%04lx",
> +                     op->name, inst);
>           break;
>       }
>       return 4;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

