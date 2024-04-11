Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA44CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutzM-00013r-KH; Thu, 11 Apr 2024 08:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rutzL-000131-9U; Thu, 11 Apr 2024 08:57:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rutzI-00085Z-Vy; Thu, 11 Apr 2024 08:57:10 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso10951200a12.3; 
 Thu, 11 Apr 2024 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712840226; x=1713445026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU9ZF9Nxg1/Hb9s4OTIFtHw6ic9sRAJoGHsHWFb2SeI=;
 b=e4Q4jaGu9vzdwMaj7uHzKffvwDC7XvLPJ9LRE+oPIj0cWWUc2ZKftlXuIDCdoSYMK/
 HKb3G0LZhRvVTgIFwRIt43YXZyUmqZwqZZWh8anQW9mtrqWqy38DKIUAViWCaEyE8TgM
 U9F0R5lo8vbNLsvs2IGAd9mRZqyUFDYN5SWOZ74vyCxTITl7Q9YHsVXQu/K0AohOxxlS
 DM46ASAaSYfzxw53Lf7fe0ecnGmCd+hIdR6d7bgXqh+iHG7Ait5qTja2RplBJm3xLKxp
 ca4VFTrA5MSCFjmvhp7+Ppyek/AsPDv0awcTS6eCKmh5Gwac7A9EIsE1fWJIiYiSjy8J
 N9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712840226; x=1713445026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU9ZF9Nxg1/Hb9s4OTIFtHw6ic9sRAJoGHsHWFb2SeI=;
 b=lo29uy7LGtj57Qu/pBzZsxf/MFKH6AEvuicmhBZJCMUhRSsPPQBMAYXH4SlYqAwE+G
 Bunas8lQpyNu44MNJDT988QdNLuC6fREZDSLvvHhF47HMGj/7hb4f28Wm9Oj7gbHUvgW
 g+wIWo6u8/V8HOwqiC8Zpg3g2DmFI+6jH/buUVb/n4TtolOh2OqDCVI+7BoDNJgi3tM4
 TcbymO7oiVdykxSC/Lqa8jHNANcodBvTR6DP0i0O5DWYeqB2mG2e7aX1ZV8q7sNhIJ9O
 kxWHZGh6RmLea4vGMqfdDbgun02GuM7sD03KnVGOnPJ9owIMEB2Ac5l1BmvVTe49g0Lr
 yh8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeFVSR5K+RgOvFAfpDe+IHph5tCgXX9LDHRY/5qbmrbvaVVwmowf3vW7kUpVsTFM/Veait4equ2RLBMByZO2UEvz4xY4zBXKteHbvMVKhZAeOxu45qTc0vXZs=
X-Gm-Message-State: AOJu0YwGrHDriQop4p/lkFh8jFI0sYpf+XSBT9bV6rBsqh9q1e1SBDOZ
 JDr4qx8IZNHhlGx4Gvgt2SEJjzrAXLArICNSMm7nsVQ+4mQ0dTb3DKDs0+YUsHOQ6N4xCOjSsg9
 ZPTUqjnA/p/ZWs0m5hYMxkCgIVEM=
X-Google-Smtp-Source: AGHT+IESpQTdegef+JuvlebZsqrI9sj1rDjV0jIp94ov14oNCrWnzfv/t8n7lXnSFU+3vYtEm4LsMCDKa9jXB0N+CR4=
X-Received: by 2002:a50:d7c4:0:b0:56d:b687:5a45 with SMTP id
 m4-20020a50d7c4000000b0056db6875a45mr3846499edj.1.1712840225521; Thu, 11 Apr
 2024 05:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-3-philmd@linaro.org>
In-Reply-To: <20240411104340.6617-3-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Apr 2024 14:56:53 +0200
Message-ID: <CAJy5ezoBzyRJSwqyxGnBqm968ef4zjBaPVdbBKeS+tVn8SY4rQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] disas/microblaze: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 11, 2024 at 12:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  disas/microblaze.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 0b89b9c4fa..49a4c0fd40 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -600,7 +600,8 @@ static char *
>  get_field (long instr, long mask, unsigned short low)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%s%d", register_prefix, (int)((instr & mask) >> low))=
;
> +  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
> +           (int)((instr & mask) >> low));
>    return(strdup(tmpstr));
>  }
>
> @@ -608,7 +609,8 @@ static char *
>  get_field_imm (long instr)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%d", (short)((instr & IMM_MASK) >> IMM_LOW));
> +  snprintf(tmpstr, sizeof(tmpstr), "%d",
> +           (short)((instr & IMM_MASK) >> IMM_LOW));
>    return(strdup(tmpstr));
>  }
>
> @@ -616,7 +618,8 @@ static char *
>  get_field_imm5 (long instr)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%d", (short)((instr & IMM5_MASK) >> IMM_LOW));
> +  snprintf(tmpstr, sizeof(tmpstr), "%d",
> +           (short)((instr & IMM5_MASK) >> IMM_LOW));
>    return(strdup(tmpstr));
>  }
>
> @@ -624,7 +627,8 @@ static char *
>  get_field_rfsl (long instr)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%s%d", fsl_register_prefix, (short)((instr & RFSL_MAS=
K) >> IMM_LOW));
> +  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
> +           (short)((instr & RFSL_MASK) >> IMM_LOW));
>    return(strdup(tmpstr));
>  }
>
> @@ -632,7 +636,8 @@ static char *
>  get_field_imm15 (long instr)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%d", (short)((instr & IMM15_MASK) >> IMM_LOW));
> +  snprintf(tmpstr, sizeof(tmpstr), "%d",
> +           (short)((instr & IMM15_MASK) >> IMM_LOW));
>    return(strdup(tmpstr));
>  }
>
> @@ -641,7 +646,8 @@ static char *
>  get_field_unsigned_imm (long instr)
>  {
>    char tmpstr[25];
> -  sprintf(tmpstr, "%d", (int)((instr & IMM_MASK) >> IMM_LOW));
> +  snprintf(tmpstr, sizeof(tmpstr), "%d",
> +           (int)((instr & IMM_MASK) >> IMM_LOW));
>    return(strdup(tmpstr));
>  }
>  #endif
> @@ -653,7 +659,8 @@ get_field_unsigned_imm (long instr)
>    {
>    char tmpstr[25];
>
> -  sprintf(tmpstr, "%s%s", register_prefix, (((instr & IMM_MASK) >> IMM_L=
OW) & REG_MSR_MASK) =3D=3D 0 ? "pc" : "msr");
> +  snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix,
> +          (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) =3D=3D 0 ? "p=
c" : "msr");
>
>    return(strdup(tmpstr));
>    }
> @@ -709,7 +716,7 @@ get_field_special(long instr, const struct op_code_st=
ruct *op)
>     default :
>       {
>         if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE00=
0) =3D=3D REG_PVR_MASK) {
> -         sprintf(tmpstr, "%s%u", pvr_register_prefix,
> +          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
>                   (unsigned short)(((instr & IMM_MASK) >> IMM_LOW) ^
>                                    op->immval_mask) ^ REG_PVR_MASK);
>          return(strdup(tmpstr));
> @@ -720,7 +727,7 @@ get_field_special(long instr, const struct op_code_st=
ruct *op)
>       break;
>     }
>
> -   sprintf(tmpstr, "%s%s", register_prefix, spr);
> +   snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix, spr);
>     return(strdup(tmpstr));
>  }
>
> --
> 2.41.0
>

