Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2EBC27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF6yB-00085h-Rh; Thu, 06 Jun 2024 02:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF6yA-00085K-Qc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:51:30 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF6y5-0007er-22
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:51:30 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so70097166b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717656682; x=1718261482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nf5Z4LuzzgCuA8JEV3quJmOqCVEQgj6BhEDBY4tT/2o=;
 b=PWQP3xhjzjKEgtxns/OFaKIVE0efaFJKErO4arcaDlOnAau6mf3dPOBxubfG9ZKaxT
 mkI6tdPEvMxOPWxIy/7Z7kJQKWPNtqgeQ8fwamkiODrLo1qpKYblQ89HQyJcJIRd8Clv
 OOZtpznpKnvqzp7PbN/jFaCsyrSx7P0iTlGSCl9dd1sEq7yqpwabWSQpz3AILMJTVGzD
 ZAj4psTVxONHiokEIu9FM6wAK5qp2DYYsIC42CmX5QtIHqc5kVzgCaIlaAkX6pMc8zHX
 1rWIpw87y6jC68KrrnRbR1Q5wpyyi6lGePnOrXzBW5nrkysxlIxzLb7KPvaqfKtFbPxl
 sNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717656682; x=1718261482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf5Z4LuzzgCuA8JEV3quJmOqCVEQgj6BhEDBY4tT/2o=;
 b=grW8kBmstMpK/FhO1Vvx/Sz2L2z2jlIYV6bv8ZINaiXfz2i+xkN44ULaZq47t+WCsr
 ec8gsCteD5fUFKRg2lUvaCbHoQbWswO7JofnoB+PUdbeX5L5a9TBFx3L/rQKSuAdX1Eq
 dkb2dkoOSW/7ODUlmyouSkTaij78JRYB5sSaWPZ2jSTyfnSA9v5dOcT2dZM/GvqUF10A
 155Dqazjged8hLe4gGzMH6ObMuc6gRkeD3F5r/DM31lIwe1Ug4JanNQe5pFtdH5zysRC
 qSZRb2ymvkYedHLfgLBDI4CnOqUvLaUaNo/GCwUsKd4npiXipatzeAX1284lWGEYOvHe
 Ntzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN6zaxLjdreRb0q0KwknT/l8qiu9+ctn2P5pN8hhzvTBk6vI8Z/LZY+plNo+kwhz0ns9X+XVQr1fuh5HbLEYuaw+9N0AA=
X-Gm-Message-State: AOJu0Yx1JUlWGpSvLvxi7rbJyFsqilrqLUkvRxE4U74oS1VIHCfAY0ID
 9huJaeRUaKIsn5fxEuS2MPtpggmd2ijV4bB2SpyP3EVH8KMc0wyAX16CeWt5xsM=
X-Google-Smtp-Source: AGHT+IEeeVDtok/4hX392vfsLCuBP3o2vRxAgkDPJ/ddOY1mgXXgXTUaIucEy4JG4peTBfClcpER0A==
X-Received: by 2002:a17:906:f0ce:b0:a68:f8b9:ffa3 with SMTP id
 a640c23a62f3a-a699f681a9dmr316258466b.46.1717656682036; 
 Wed, 05 Jun 2024 23:51:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ec823sm50692666b.101.2024.06.05.23.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 23:51:21 -0700 (PDT)
Message-ID: <11ab799d-2670-4a2c-884e-688589845e83@linaro.org>
Date: Thu, 6 Jun 2024 08:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/i386: Split out gdb-internal.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alex.bennee@linaro.org
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606032926.83599-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 6/6/24 05:29, Richard Henderson wrote:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/gdb-internal.h | 65 ++++++++++++++++++++++++++++++++++++++
>   target/i386/gdbstub.c      |  1 +
>   2 files changed, 66 insertions(+)
>   create mode 100644 target/i386/gdb-internal.h
> 
> diff --git a/target/i386/gdb-internal.h b/target/i386/gdb-internal.h
> new file mode 100644
> index 0000000000..7cf4c1a656
> --- /dev/null
> +++ b/target/i386/gdb-internal.h
> @@ -0,0 +1,65 @@
> +/*
> + * x86 gdb server stub
> + *
> + * Copyright (c) 2003-2005 Fabrice Bellard
> + * Copyright (c) 2013 SUSE LINUX Products GmbH
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
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
> +#ifndef I386_GDB_INTERNAL_H
> +#define I386_GDB_INTERNAL_H
> +
> +/*
> + * Keep these in sync with assignment to
> + * gdb_num_core_regs in target/i386/cpu.c
> + * and with the machine description
> + */
> +
> +/*
> + * SEG: 6 segments, plus fs_base, gs_base, kernel_gs_base
> + */
> +
> +/*
> + * general regs ----->  8 or 16
> + */
> +#define IDX_NB_IP       1
> +#define IDX_NB_FLAGS    1
> +#define IDX_NB_SEG      (6 + 3)
> +#define IDX_NB_CTL      6
> +#define IDX_NB_FP       16
> +/*
> + * fpu regs ----------> 8 or 16
> + */
> +#define IDX_NB_MXCSR    1
> +/*
> + *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
> + */
> +
> +#define IDX_IP_REG      CPU_NB_REGS
> +#define IDX_FLAGS_REG   (IDX_IP_REG + IDX_NB_IP)
> +#define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
> +#define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
> +#define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
> +#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
> +#define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
> +
> +#define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
> +#define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
> +#define IDX_CTL_CR3_REG     (IDX_CTL_REGS + 2)
> +#define IDX_CTL_CR4_REG     (IDX_CTL_REGS + 3)
> +#define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
> +#define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
> +
> +#endif
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index 4acf485879..96b4382a5d 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "gdbstub/helpers.h"
> +#include "gdb-internal.h"
>   
>   #ifdef TARGET_X86_64
>   static const int gpr_map[16] = {

Shouldn't we remove the definitions from the source to
complete the "split"?

