Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F5FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZry0-0007Q3-RA; Fri, 02 Aug 2024 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrxy-0007PJ-KM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:05:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrxw-00067X-FM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:05:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so23515135ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722603902; x=1723208702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eMQNgnbvCM3lcXL3HGipQCBp9R/cVt/VR9xXBPoHsoM=;
 b=MuUxJm2sACzBqFvVnVOjvlMW0nIa1vK+8rLEdxcsztWTK1oNHJWaK7uJz/ETwSK18a
 yoHNGVmMr47z6sy23udOMXwowo4jC/p/kN6yDGt8nbWhLvYlV2D2ECw0cOGOcfgOpysP
 F1W+pFc28Z/LL1a/1h+8mvK11Vgc5jkpYkYYaIUX4wlkCL76Y7cSvIJqQP18m7jSTzWn
 /tMHWAPIdytyvgsXO1B5saHyGGOq9df2Oi5/OL25AalTMSCQwDFpOnkYlBW25xNkcAGk
 3j4uXVQk+0Wp4KfUIWpWYLd/oHg8HhCw6xHHpxbjJ5W7wTAMRO3SAXoWvxo1j1yfDuhl
 LEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722603902; x=1723208702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eMQNgnbvCM3lcXL3HGipQCBp9R/cVt/VR9xXBPoHsoM=;
 b=oO5+M3Vjaz4JbdkhRmni0WgbL/37jeVNjWWGDboQxBly6iZM+YV8E0yfyePfe/KGmS
 rwQkc8FbJtl/xsH4R29FFfpIqKFexI1rD2vipC4azs53e5pVYdcdlc36tx096CNoq1Ya
 wdxdKh9XIddgXfIG6SVmZ7NBCOvtg1bvOIi9yR5Kmt1bQEg47dfMKMWBHrlOvF6XGeP+
 yqZbEPE6hNT7+0R5dQpcclNnEA+6jC0uNo0D8Qdj0A/4ntupLYkJ41VUXiIQLRRjbhmZ
 S5+dL6hi1VNGRczuwQBhLivMQaJ26rK72wwakP83aLhTNSVk+8SaW0TqFsLvcnzuNtvo
 U7OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVecWH5LgeD5RgdDsjjql3NwLszmvCzUfDRI4J0g70XkhXhkBMQj9L6CBbx1+gDcY1piTmP/loZLk7j+z0qftgedovDOcc=
X-Gm-Message-State: AOJu0YwzUW7Pc6XjsouR5pH0mqlqJ64aHZTGCvTfFUK3vkSxoH9f3nvU
 wipzlOUJXSar81+8T5Kl/vkUBu2u9ci1O83uhNuFM8qw8souTeI+wyzvvqQHVYs=
X-Google-Smtp-Source: AGHT+IFBs6xn4UAHNtr183+bWM8zVVqnFyvByAWk7Zme4WC1i7vdomXJtCtBv7JLJeDEW+6qDDX5NQ==
X-Received: by 2002:a17:902:c948:b0:1ff:39d7:a1c4 with SMTP id
 d9443c01a7336-1ff52492189mr89744035ad.25.1722603902224; 
 Fri, 02 Aug 2024 06:05:02 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59058d67sm16603005ad.169.2024.08.02.06.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:05:01 -0700 (PDT)
Message-ID: <52c62385-fdac-41ab-9117-093e11a2c72e@linaro.org>
Date: Fri, 2 Aug 2024 23:04:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] bsd-user: Add prototype for RISC-V TLS register
 setup
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-6-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-6-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin <mark.corbin@embecsom.com>
> 
> Included the prototype for the 'target_cpu_set_tls' function in the
> 'target_arch.h' header file. This function is responsible for setting
> the Thread Local Storage (TLS) register for RISC-V architecture.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch.h
> 
> diff --git a/bsd-user/riscv/target_arch.h b/bsd-user/riscv/target_arch.h
> new file mode 100644
> index 0000000000..26ce07f343
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch.h
> @@ -0,0 +1,27 @@
> +/*
> + * RISC-V specific prototypes
> + *
> + * Copyright (c) 2019 Mark Corbin <mark.corbin@embecsom.com>
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
> +void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls);
> +
> +#endif /* TARGET_ARCH_H */

Really should be merged with the previous patch, which implements this function.  But,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

