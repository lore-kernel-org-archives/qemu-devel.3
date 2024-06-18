Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12311C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhNC-0005So-V3; Tue, 18 Jun 2024 18:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhNB-0005SV-BA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:32:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhN9-0006v8-5C
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:32:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70625e8860cso722559b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749933; x=1719354733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebFR0EQK15YeYjqEKFMG5Pat6JojLVQceu8k+zrV330=;
 b=kp30Q+88FDxKTO+leKh+9mMHzLvbfD3Vuxmtyq+WjHtiIMtljX5ZH6tAZgskOZjO2Q
 480rsaDWxhGR4wJIkCmbwqlM6VWLbGo14rU5Urt1rdJ34L7hIDpoScC9tDo3Gh4rNjLf
 Yk6z1INUPr2JUdwxKrQg8PmdsUB4WjB6qga2gp+FEJ5ILplEHA35NAKxOnZSg0YG07Jl
 ydu6CdoR9yNThrmSqAgWQ5NednZBrjs4LpaH6OF8NtbphnvltbslsYDU1CQb7IDvbzS5
 UXo4AVSGRI6imfUfd5BZI62NICHU398BVlwxfn0JdsKcVK5fvayKezEH80lQ9Tu2OwTB
 Tfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749933; x=1719354733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebFR0EQK15YeYjqEKFMG5Pat6JojLVQceu8k+zrV330=;
 b=sF0v/MwZE+17txSZzttqVryPtm4rPvBVnUlNWwMkTih/qmm9/RgyNwOiM37CG49Qeo
 R3BAaXUJGx906v2m1HU9HSyCKc6228cHRQTUQ5Txi+KqLOwdr7h1F1BOXD3AF0/MFqYh
 MmNhjKRJ5/Bf4sVXRpKzOdU6+gYRI1IW1N+ARwn8oVBXSjYxuRVWiJizKrPCel3HGFUl
 Cj38JEoGTeSM9O5114fWyTyxHESvntxaIWhVz07BHtm06IyHm8DttUY8vXOnXnqvPu1+
 xiazqnM4a2AK7AQt4EskunOeqjgx6U5B492xzNQkwuiO6jDu+wqA48RVzYXXVv5Rbh/5
 OW3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGqAdBf6gnLwuxM6/1pojbSR20wrBvZFuSfBNSQ9aoSz0ZYejIcXdMdCRak3JMiJuKpO9n+KvuHLyDk1eefiOm4AGuUfs=
X-Gm-Message-State: AOJu0Yw/uMdH6dOMeV8vUWkwfVeaaxRzLp62S9T1hcW4MkEoBmtDWROQ
 R53t33hibrnnvj/k2A39kYHiGv5PtMzAQMHfe17YyGJdTQuezcCs0/BTftv6D/s=
X-Google-Smtp-Source: AGHT+IFtZwA9VF5oqmz2MDbo48rAkrW6dhewyihX3nsHwGPY7F5FttYlyzuBpvJA8sLInEFC6khLnQ==
X-Received: by 2002:a05:6a21:6d87:b0:1b7:689:2db0 with SMTP id
 adf61e73a8af0-1bcbb60f6dfmr1001729637.56.1718749931528; 
 Tue, 18 Jun 2024 15:32:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4265esm9427547b3a.116.2024.06.18.15.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:32:11 -0700 (PDT)
Message-ID: <8241879d-e16e-400b-be02-a3c161679bcd@linaro.org>
Date: Tue, 18 Jun 2024 15:32:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] Add ARM AArch64 sigcode setup function for bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-18-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-18-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> signal trampoline function initializes a sequence of instructions
> to handle signal returns and exits, and copies this code to the target offset.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_sigtramp.h | 48 +++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h
> 
> diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch64/target_arch_sigtramp.h
> new file mode 100644
> index 0000000000..8cdd33b621
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_sigtramp.h
> @@ -0,0 +1,48 @@
> +/*
> + * ARM AArch64 sigcode for bsd-user
> + *
> + * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
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
> +/* Compare to ENTRY(sigcode) in arm64/arm64/locore.S */
> +static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
> +        unsigned sys_sigreturn)
> +{
> +    int i;
> +    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
> +
> +    uint32_t sigtramp_code[] = {
> +    /* 1 */ 0x910003e0,                 /* mov x0, sp */
> +    /* 2 */ 0x91000000 + (sigf_uc << 10), /* add x0, x0, #SIGF_UC */
> +    /* 3 */ 0xd2800000 + (sys_sigreturn << 5) + 0x8, /* mov x8, #SYS_sigreturn */
> +    /* 4 */ 0xd4000001,                 /* svc #0 */
> +    /* 5 */ 0xd2800028 + (sys_exit << 5) + 0x8, /* mov x8, #SYS_exit */
> +    /* 6 */ 0xd4000001,                 /* svc #0 */
> +    /* 7 */ 0x17fffffc,                 /* b -4 */
> +    /* 8 */ sys_sigreturn,
> +    /* 9 */ sys_exit
> +    };
> +
> +    for (i = 0; i < 9; i++) {
> +        tswap32s(&sigtramp_code[i]);
> +    }

You can use const_le32() to initialize sigtramp_code[], at which point it can be static const.

I'll note that bsd-user/arm/ could be improved the same way.  In addition, the g_assert in 
arm/ can be QEMU_BUILD_BUG_ON instead, to be caught at compile-time.


r~

