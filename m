Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F1C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 16:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Mt8-0005US-2W; Sat, 18 May 2024 12:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Mt5-0005UE-Ja
 for qemu-devel@nongnu.org; Sat, 18 May 2024 12:26:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s8Mt2-00076E-MB
 for qemu-devel@nongnu.org; Sat, 18 May 2024 12:26:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso40721545ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716049578; x=1716654378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+9UPou2AN2Fv/+eWqMKIowE+zb44A6eT1n5SmEDY8qg=;
 b=liOGr6etwsnQgXsZ5ErqXy8w4/t2A/iqaxpKnJ5+y7D6/fEPpXodSXHAvFQVApZHmo
 J4HQa7+sPRFDFqU0LdkMDoQTHWEUgETHUS3H1PnAl5WPc8yndXlCCwEpkUUd4sRThZpL
 eBAE1MouJTtEhsdbd1Rm0xK8vxcqWBpGfF5bS2jArSUjsP5tpyA4xwaONHPAlPwxgdxv
 d0of4RuN60UDy0HUNN8Z4P1T7z2tIZ7I6yV/xEecp6lQxnyBKvBbojlRZULtEMjofDQO
 HNxFXgBQxb0drLua6PJq7Ug/4oLCzXpxCLQ+WnkWm6EIn+yBFkFXSuwCVM4FW4iO3dvB
 M3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716049578; x=1716654378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9UPou2AN2Fv/+eWqMKIowE+zb44A6eT1n5SmEDY8qg=;
 b=WBLTFFfSsOd5C+Zr4kezxl2uzIGouFxZNSlf5ud5XuyHb6YQ3oeAzNsTTL118s9blZ
 lVXeIiGSK2qIODwYaCUkPCJ36Rsa4yB6Tac0WqocIvH4l1jid0IJQaUTWegLpe5iTaSb
 AbYw7aadygPV3igOCLUZl6H3n3RUPWbVTQnq+AQzk7k9Mwgm8DL0xZx/qRx5vFmYZWXS
 7URUzQ8NLeIRmPOth78xmZIMuGfHvMhnLZeV/hhnRdKOwYtLRTMs9zIG2nXb4IPVEx3Y
 uBWCwIvj7xqvXUWMyICgwgXpsGn6kIVjDi3Wz+biImoehBaF3aRZTxG24AO2q2YIz/de
 t4YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxwNlrnno9tsTIZT0mFyj8OUqoRf9+y2EXWIFl2v7Fa9xfQstQ+VKLa6nXJbJ849roak5Dhc3Xo7UjOAxVuSNbFml+c/k=
X-Gm-Message-State: AOJu0YyLDvHl0T4KVaZB9Ox8bH4qi8E/4t+dTOMyLOUsmxSk+KmQKBpQ
 +AK5Ud2uGAgJc7ToEIAlYkBysfVQaMrk2+KzbM43tUZ2DtMccAdJe1ZuVs+F1sQ=
X-Google-Smtp-Source: AGHT+IF5VohPVpt1/QFZMT4wrwSuILW2R85+jtc3CKFnA6AifS+pg5wWI6yLzH4aS3qcpYo5x4TTIg==
X-Received: by 2002:a17:902:7284:b0:1e3:c419:35c2 with SMTP id
 d9443c01a7336-1ef43e233bemr228243425ad.34.1716049577955; 
 Sat, 18 May 2024 09:26:17 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f09648bf4esm63789795ad.272.2024.05.18.09.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 09:26:17 -0700 (PDT)
Message-ID: <719c8281-bf86-4be8-88c5-43b1eb0e91de@ventanamicro.com>
Date: Sat, 18 May 2024 13:26:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dias/riscv: Decode all of the pmpcfg and pmpaddr CSRs
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 bin.meng@windriver.com, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, palmer@dabbelt.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, eric_devolder@yahoo.com
References: <20240514051615.330979-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240514051615.330979-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

^ typo in the commit subject: 'disas/riscv: ...'

On 5/14/24 02:16, Alistair Francis wrote:
> Previously we only listed a single pmpcfg CSR and the first 16 pmpaddr
> CSRs. This patch fixes this to list all 16 pmpcfg and all 64 pmpaddr
> CSRs are part of the dissassembly.

I think the correct here is 'disassembly'.

> 
> Reported-by: Eric DeVolder <eric_devolder@yahoo.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   disas/riscv.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e236c8b5b7..297cfa2f63 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2190,7 +2190,22 @@ static const char *csr_name(int csrno)
>       case 0x0383: return "mibound";
>       case 0x0384: return "mdbase";
>       case 0x0385: return "mdbound";
> -    case 0x03a0: return "pmpcfg3";
> +    case 0x03a0: return "pmpcfg0";

Hmm it seems that the code for 'pmpcfg3' was incorrect from the get go.
Perhaps it's worth adding a:

Fixes: ea10325917 ("RISC-V Disassembler")


Regardless of adding a 'Fixes' tag or not:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>




Thanks,

Daniel

> +    case 0x03a1: return "pmpcfg1";
> +    case 0x03a2: return "pmpcfg2";
> +    case 0x03a3: return "pmpcfg3";
> +    case 0x03a4: return "pmpcfg4";
> +    case 0x03a5: return "pmpcfg5";
> +    case 0x03a6: return "pmpcfg6";
> +    case 0x03a7: return "pmpcfg7";
> +    case 0x03a8: return "pmpcfg8";
> +    case 0x03a9: return "pmpcfg9";
> +    case 0x03aa: return "pmpcfg10";
> +    case 0x03ab: return "pmpcfg11";
> +    case 0x03ac: return "pmpcfg12";
> +    case 0x03ad: return "pmpcfg13";
> +    case 0x03ae: return "pmpcfg14";
> +    case 0x03af: return "pmpcfg15";
>       case 0x03b0: return "pmpaddr0";
>       case 0x03b1: return "pmpaddr1";
>       case 0x03b2: return "pmpaddr2";
> @@ -2207,6 +2222,54 @@ static const char *csr_name(int csrno)
>       case 0x03bd: return "pmpaddr13";
>       case 0x03be: return "pmpaddr14";
>       case 0x03bf: return "pmpaddr15";
> +    case 0x03c0: return "pmpaddr16";
> +    case 0x03c1: return "pmpaddr17";
> +    case 0x03c2: return "pmpaddr18";
> +    case 0x03c3: return "pmpaddr19";
> +    case 0x03c4: return "pmpaddr20";
> +    case 0x03c5: return "pmpaddr21";
> +    case 0x03c6: return "pmpaddr22";
> +    case 0x03c7: return "pmpaddr23";
> +    case 0x03c8: return "pmpaddr24";
> +    case 0x03c9: return "pmpaddr25";
> +    case 0x03ca: return "pmpaddr26";
> +    case 0x03cb: return "pmpaddr27";
> +    case 0x03cc: return "pmpaddr28";
> +    case 0x03cd: return "pmpaddr29";
> +    case 0x03ce: return "pmpaddr30";
> +    case 0x03cf: return "pmpaddr31";
> +    case 0x03d0: return "pmpaddr32";
> +    case 0x03d1: return "pmpaddr33";
> +    case 0x03d2: return "pmpaddr34";
> +    case 0x03d3: return "pmpaddr35";
> +    case 0x03d4: return "pmpaddr36";
> +    case 0x03d5: return "pmpaddr37";
> +    case 0x03d6: return "pmpaddr38";
> +    case 0x03d7: return "pmpaddr39";
> +    case 0x03d8: return "pmpaddr40";
> +    case 0x03d9: return "pmpaddr41";
> +    case 0x03da: return "pmpaddr42";
> +    case 0x03db: return "pmpaddr43";
> +    case 0x03dc: return "pmpaddr44";
> +    case 0x03dd: return "pmpaddr45";
> +    case 0x03de: return "pmpaddr46";
> +    case 0x03df: return "pmpaddr47";
> +    case 0x03e0: return "pmpaddr48";
> +    case 0x03e1: return "pmpaddr49";
> +    case 0x03e2: return "pmpaddr50";
> +    case 0x03e3: return "pmpaddr51";
> +    case 0x03e4: return "pmpaddr52";
> +    case 0x03e5: return "pmpaddr53";
> +    case 0x03e6: return "pmpaddr54";
> +    case 0x03e7: return "pmpaddr55";
> +    case 0x03e8: return "pmpaddr56";
> +    case 0x03e9: return "pmpaddr57";
> +    case 0x03ea: return "pmpaddr58";
> +    case 0x03eb: return "pmpaddr59";
> +    case 0x03ec: return "pmpaddr60";
> +    case 0x03ed: return "pmpaddr61";
> +    case 0x03ee: return "pmpaddr62";
> +    case 0x03ef: return "pmpaddr63";
>       case 0x0780: return "mtohost";
>       case 0x0781: return "mfromhost";
>       case 0x0782: return "mreset";

