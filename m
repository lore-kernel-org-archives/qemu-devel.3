Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72529C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQcR-0006K1-1X; Tue, 18 Jun 2024 00:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQcP-0006JR-45
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:38:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQcN-0008LK-8h
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:38:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6b0a40721so36937285ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718685529; x=1719290329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPN0ph7m5e6R1JV+YtGu+2sr5toqRHu9oqDV00vQqVU=;
 b=gVPuGY/K7agNcMa/GCVTn90fw6t0D2jTTJcih/otoybOGJztPrAJGw4hJ8PzRT7LHf
 UlQtRYYaMUmaSqRHtWx3obYnGEK/lbt4Yku0WmxUw0GkjQzGrZ0bgJgTwmDWzSfx88qW
 o0LUmoDKZHRBC01usATF5q5jBfY2AjfdsL2juLikKssdmwwaQ28CQSIsASjDY5rJCjxk
 K1q/0oQulqJ6IV+Krj5WLLMFsiEuEccIw30iMTb3sQOrJjGuYY9HZVgJIuBCrIxBmNhK
 g0HZg2KegY97/AwpO+CVjSePvAB/n6Axc0Ue2ATuWoFsFEsSmwdtH8kjfisTxMIHDy+U
 iNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718685529; x=1719290329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oPN0ph7m5e6R1JV+YtGu+2sr5toqRHu9oqDV00vQqVU=;
 b=fWKgyczPxa7/xzieGz2Mydbm6ApDPB+CcLT1VQUsbD+Wxfuz8pOg16BSdDCkaa55qJ
 5duMyzwMKldw2JazxATQYQqQ+rxxEyd9btv+raU+Y0Im95jTEWJSehZRcu4k9mou7Ebm
 LLSxr7IU0nv9CD450rS0PGwrOjV8NpnG52YSguz3HxTO15CRy0O1WlMdpTX6nMMFlEuR
 roKcaMYPjpNM/zGo2yuB0ITsakfe1u/JO+QK9ju2C40IA2StSDJLSjEB0m37g2d0tmbW
 RMkRw5oOVlo7BcI1i1Cl4S+gUBAWV/fa7naEybUMT5fiitd3x7Qs/7ZetX+6b4D/e9JZ
 cKPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsKhEzED0fbF3lpDKDfJoCrKPfwU9g/Nsm+JIIAHUcnSE9NExarjMHD+vZcQ2E/qIz8eH7f3yP6SAfsEUGdre5tzcdPZ4=
X-Gm-Message-State: AOJu0YzY55hnDqMK3DkVSpwbO6hSv2ofqKZN386Ua+No9jHvDrRQrF6u
 1fBhM0ftZ6+SMMVpikcxLbtTLK7gJO05W6gnOOYU+JO+DfOOkMKb6dRawSDJpKU=
X-Google-Smtp-Source: AGHT+IF1buyRlxkyTusNdcs+MzSIKR2sDtx/+r3w6TYyLIXcjQF58emnlrBeBegPO/T5jSx8flIuNQ==
X-Received: by 2002:a17:902:8b8c:b0:1f6:81f9:cf34 with SMTP id
 d9443c01a7336-1f8627e5672mr79945595ad.34.1718685529482; 
 Mon, 17 Jun 2024 21:38:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee847bsm88210125ad.168.2024.06.17.21.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:38:49 -0700 (PDT)
Message-ID: <14d1f374-48df-4771-8da6-a979b4f299f4@linaro.org>
Date: Mon, 17 Jun 2024 21:38:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] Add ARM AArch64 TLS Management Prototypes for
 BSD-User
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-8-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-8-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> Prototypes for setting and getting TLS( thread local storage)
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch.h
> 
> diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
> new file mode 100644
> index 0000000000..27f47de8eb
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch.h
> @@ -0,0 +1,28 @@
> +/*
> + * ARM AArch64 specific prototypes for bsd-user
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
> +#ifndef TARGET_ARCH_H
> +#define TARGET_ARCH_H
> +
> +#include "qemu.h"
> +
> +void target_cpu_set_tls(CPUARMState *env, target_ulong newtls);
> +target_ulong target_cpu_get_tls(CPUARMState *env);
> +
> +#endif /* TARGET_ARCH_H */

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I suggest that these declarations use CPUArchState, and be made common for all targets.

r~

