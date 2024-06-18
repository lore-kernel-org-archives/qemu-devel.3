Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50811C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQSG-0002KZ-SV; Tue, 18 Jun 2024 00:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQSE-0002Dm-LZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:28:22 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQSC-0006lK-Ir
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:28:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70423e8e6c9so4422522b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684898; x=1719289698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RMEcXXJwpH0FZdhl4fZwsAq3leQJi74Ue87R92D+m48=;
 b=cGYAndgYjblZnmrXx0tQkl32crw7iANtjlTarT175pTiaDrRX9TuAiBr4wKPrccuuL
 YnHQK9JrctHBIZ7/fXfMKOc7kv7qa789A4uKPUPAtA+n6KGoXD0tuj5JGUZFVMrNUXNV
 XmWwo5bgnWTJu15YeVD4HG0556y6XwKJeEWRxIRlGP5dZgpb11zqW5JnYqSlcwTSD23c
 u4OEw1oJCZV5oFaRLVOFOQ7u3WbJUjmOo/xeaAchqxoEGkQeY+ERn+0UqlWmvVGJUSgH
 4XSgiBKkwbNRXiKqf2Rei53jH2zwSVYloJ5SyMtc84bcI8179YIprp6v2R3QlXEQxagK
 UWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684898; x=1719289698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMEcXXJwpH0FZdhl4fZwsAq3leQJi74Ue87R92D+m48=;
 b=hEw4c+aWPq+zE4hCtOapbZHgXyM2wglYns4w9BVrwvduZSW6sIb527q9zvSxczDA0C
 NxYUxVtefByeR4QZMuj47IHgJrQCmH5JJYDg9vxXHrnctFESiO9t9ox7TVXQhIhoknpR
 GhEGB7cVnu4sY8HY5smyxeXtmR3O5D7qPmqJEqX/Rm+7VxgM9ck+yRmEv/O8axw5/Y4g
 9Ut0eF3MqumJIHpJmwvUWTf0+/W1N+faGqRml0xw4Fv0xknZ0gaoTi78XyePyOEIqNwt
 OhWrShQd/tQSRsTTBILSzFtiWw+V2oAD6g4ABf1rjEOkVQMm0Wt5iXqtpYXh60RV+V0T
 F7xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJQwbYjexEDOsJLrlUxpoQQ9/sj6KDXqJsif4bwoacqC+ICXDuh0d/2jK7zW2pP+gNmIzc0Dj8L53W/UuqHgkUYvnQ/aY=
X-Gm-Message-State: AOJu0Yx0dwPRIFfJtD3mSqr/6kOuwZ1nFmXe6oUSQygMbHQ1DKDbCSqc
 rWucN0YNUYYy+5l6vyCoopnFoVvK74hXAs9JtB48KPEJ6jhW9l3maHjexSNVljY=
X-Google-Smtp-Source: AGHT+IGCsdT+MqtbVa7CRuRHds5MymifbREWQ+B0kmT6hajBj4vlDtSSKatZNraweF2GJLijyPgM7w==
X-Received: by 2002:a05:6a21:99a0:b0:1b7:cc4e:eb6 with SMTP id
 adf61e73a8af0-1bae7f624f0mr12245944637.8.1718684898172; 
 Mon, 17 Jun 2024 21:28:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4fcac51c6sm5560808a91.30.2024.06.17.21.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:28:17 -0700 (PDT)
Message-ID: <b599c247-7a71-41fb-8833-8693e1951310@linaro.org>
Date: Mon, 17 Jun 2024 21:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] AArch64 specific CPU for bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-5-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-5-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Function to set and recieve thread-local-storage value
> from tpidr_el0 register
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_cpu.c | 34 ++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_cpu.c
> 
> diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/target_arch_cpu.c
> new file mode 100644
> index 0000000000..70ef651827
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_cpu.c
> @@ -0,0 +1,34 @@
> +/*
> + * ARM AArch64 specific CPU for bsd-user
> + *
> + * Copyright (c) 2015 Stacey Son
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
> +#include "qemu/osdep.h"
> +
> +#include "target_arch.h"
> +
> +/* See cpu_set_user_tls() in arm64/arm64/vm_machdep.c */
> +void target_cpu_set_tls(CPUARMState *env, target_ulong newtls)
> +{
> +
> +    env->cp15.tpidr_el[0] = newtls;

Extra newline.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

