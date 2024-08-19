Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB6AC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfsj4-0003jM-SK; Sun, 18 Aug 2024 23:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsiv-0003iO-HJ
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:06:30 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsir-000469-58
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:06:22 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2700d796019so1940438fac.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 20:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724036778; x=1724641578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pY3WF3cBxkttRkA4MqKkBLzs8nnJcmwu8y+eo46XdM4=;
 b=EHSfLhD3erqSdXU7uSxzI0SjQiYIf0b8NtDJyXDzwWAQMnYoxu1ugpEIEiY2eBsqhQ
 LRyYc0g3eGP3SEmCXVCSKHcEi/71ZPPcNOHVX7iwC2Ie1giGuy1okHudCgFOMY9KNbGv
 ODyzAe38Be7YG5wZFje+H+mnQjItiGzvOVjz1P16M2OAQf0Hehjhgxx/DQDvvmypoKeZ
 +xHjJg/scyPgjz9JgNbEymGpNeHS5ZPzrGvMnA89qlApNg/OKjqfhRKEuQxhaeXgthej
 Qw+RJ1jSKgUa6VweaHut2yxx7uUa8ioGieJih7/hwIrFuLonMkHQ73yUIvt95E0Xe00c
 /syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724036778; x=1724641578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pY3WF3cBxkttRkA4MqKkBLzs8nnJcmwu8y+eo46XdM4=;
 b=usJ2EhjgYOAYYDNf1ZpV98RkSE8+XT3dT9sPYU5c8EHLvZ4Nvs4xhv6E7eJRUuFuGY
 UoOn72MUJRbOROChb0u9X4WXOgBq8Fm8psog7TjVrS6Ta8iBs5lvHVgVIDCSXt3q/I7p
 716w+obyXt8inO/CPOnpe/hwWOJqWFtpC92jHowbZaZVZ4ARuY0KrI3WDVDGT4ZpY/5m
 gupyrHAM5impVdcKQ5RwHfSkNEUBjqzmOljxdzuDF6lXuOtjeSJwZ3+TW9Kkk6phfTSp
 L94Nvp6+yev4AIrJMpQX3EklLZRJ3W01m1dpNxRWnwWH9tvf0oMVNiWI8GxSfZIjxur0
 ZiVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVihywus8iEpoWhOMDr56nnUZ3Vu1vPGRN56f3DLwv5/m1FYCflcAA/N9c46B0n8KgbwySnMzMFqUYFNGBwdvFWleHFR9I=
X-Gm-Message-State: AOJu0Yyu2TxTwnEOJcNd257qL6SgAYk5eiRpGwdTqhHyydUEzQC8jSyu
 cgBkOVcFEqcP/carAkLdbW+CfKhKZH8L9lqLTpH8arwMry+SkU26gf1OSU7PeaY=
X-Google-Smtp-Source: AGHT+IHwyth4UQvdUBmtdSgYpOD3le8XnY2VfSw7beoV8yMhhT8vG/gr3ltj6XRL3BsRBPZ1I2XUAQ==
X-Received: by 2002:a05:6870:798e:b0:270:1352:6c10 with SMTP id
 586e51a60fabf-2701c522c95mr8978891fac.37.1724036778162; 
 Sun, 18 Aug 2024 20:06:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1e694sm5814611b3a.167.2024.08.18.20.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 20:06:17 -0700 (PDT)
Message-ID: <b092112a-7247-4778-a61a-f589a48dc49d@linaro.org>
Date: Mon, 19 Aug 2024 13:06:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] bsd-user: Add RISC-V signal trampoline setup
 function
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
 <20240816170949.238511-8-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816170949.238511-8-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 8/17/24 03:09, Ajeet Singh wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Implemented the `setup_sigtramp` function for setting up the signal
> trampoline code in the RISC-V architecture.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/riscv/target_arch_sigtramp.h | 46 +++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
> 
> diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
> new file mode 100644
> index 0000000000..39c878db22
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_sigtramp.h
> @@ -0,0 +1,46 @@
> +/*
> + * RISC-V sigcode
> + *
> + * Copyright (c) 2019 Mark Corbin
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TARGET_ARCH_SIGTRAMP_H
> +#define TARGET_ARCH_SIGTRAMP_H
> +
> +/* Compare with sigcode() in riscv/riscv/locore.S */
> +static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
> +        unsigned sys_sigreturn)
> +{
> +    int i;
> +    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
> +
> +    uint32_t sigtramp_code[] = {
> +    /* 1 */ 0x00010513,                         /* mv a0, sp */
> +    /* 2 */ 0x00050513 + (sigf_uc << 20),       /* addi a0, a0, sigf_uc */
> +    /* 3 */ 0x00000293 + (sys_sigreturn << 20), /* li t0, sys_sigreturn */
> +    /* 4 */ 0x00000073,                         /* ecall */
> +    /* 5 */ 0x00000293 + (sys_exit << 20),      /* li t0, sys_exit */
> +    /* 6 */ 0x00000073,                         /* ecall */
> +    /* 7 */ 0xFF1FF06F                          /* b -16 */
> +    };
> +
> +    for (i = 0; i < 7; i++) {
> +        tswap32s(&sigtramp_code[i]);
> +    }

Use

     static const uint32_t sigtramp_code[] = {
         const_le32(...),
     };


r~

> +
> +    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
> +}
> +#endif /* TARGET_ARCH_SIGTRAMP_H */


