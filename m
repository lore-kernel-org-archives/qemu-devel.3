Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BED26D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJx4-0004kx-5M; Fri, 09 Jan 2026 16:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJwr-0004k6-V6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:23:10 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJwq-0000RR-BE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:23:09 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c24f4dfb7so2578613a91.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993787; x=1768598587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7OnBzU9ZXN/YRo5rwAxYIf8wKTaZfmBk56QO+2TYvoI=;
 b=mKH3dc2lgT0/3jtFuZHuwxjnXYMa3E7FWA6iUS6qud91+NdfEkqvy8g3NlzNV0nUVp
 pMsr3tVkSXSxqLbjY2//wR6d2ibvysIHXBJcgcQrjJrI8nu+k9YPFZNRIjVPBWlfeDXC
 ZPZAXYwVrR2X1JmSSKhxosMUq9R7bcAPKROoybEjKymHOa6z1soV4HUEKZVDfQYulqbk
 05yDCPpSzRqFf8Q3aqiK+SZDnNzpdkwweHt6xqRgoe07k3sn9+ybOY4hUhEKv8R8OWEY
 CvwWvfEcADLH1L3vOXvsLE0CYKrKc7wHymOm689r44P2Vs6q/uRMSNLsT6SqTlHBKuBI
 jFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993787; x=1768598587;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7OnBzU9ZXN/YRo5rwAxYIf8wKTaZfmBk56QO+2TYvoI=;
 b=rLLww3p6t1yLZZtKO+U+/e27z+zmnPSiatB9kKgaWdVrtPAq+WK+jKcD+U7T1570TC
 9TV8sgi0/u9vS5jTzs0ZxFkmApNnPg09qhSolY7po3q7Wy6+6oStKpYMYRgtoC426iZj
 suBaRXA9nhQijQbx6no5Aa2k5L0FlvAA+5aAunr7vBEGNYsjWbQTB4g8q6dULZszXRiM
 ddXF60thNHl8M7HxZGY4GyDsfVdf2EPzfprhEj/1PmHyfjGXUgoc9QLownNpI3SSGNU/
 34k5yudLCcxe+U0WDDIld5GrXFjAAh9B+lcsfGLD/uXWP2ISlZSeQ0GAeNzws+obGrFx
 0ZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEa/wO9ZwEcifjPyqbSwaHWbG0Hpn5oYhOom/O7BSan0sKsUxkKTVtKBkz+In7CPz1tse24mt2YQl0@nongnu.org
X-Gm-Message-State: AOJu0Yxj2y5wNo9eSKYCs+XYes2D3ur8M6ryHOgJTk+o6wOwdEHkUINl
 5CkC/6XQDzz/TDf4APOM9hOfOzMAJbbf0ZWnclsfp/mEJ4dsEus3yZzvZkY/ctnSs2PfAfcQrzR
 04xBMi/A=
X-Gm-Gg: AY/fxX5qbTUscM9IsHh8BAVNLTnDc3FJJWF+w4yyYbPv1Ioq2Zzn/yi+G/Zek0gtXM8
 EImf8IxQMRIy1rURc1Y/3SI/3CtU6mod+jzyj3aS0c6s6OKwhKeGzaEtTnOp3La3oQagLY1kJon
 PG92Xwk3d5yuKewFs44A+e2gJFBrXxWrxUx+z9to3oJ8Yb38dVKS8w6dETDz6YqtXNYoTDa4csO
 Rq3VlwI3DUK39G2q01iCOVLPNjshA2/mDoiHtcZ0skrKemZmnZSDXXCw+vby/CUq3/IlCN7P2aC
 v1WPPVMdxQK7sN10WhPAhAbExuXvWCi8pIIXMSXu9OorbjvnN641PVlk2yfR6kbjrL8PAzEwT3I
 bfBEFI/lh0x5AHLJs5ioxU4dv/eSiT5q2cYMkOND2/YUCXCcLirIUu/F43WytNdlvDtdrfSTSbE
 sJw6dRCh5QxEuif5jbZz4NUAD5yQ==
X-Google-Smtp-Source: AGHT+IECd4aZKezI0qKhJfsf9ovg0fUQQzY8Q8F9bSlp0Hnv1t74wCb/A6YumXmqNrmqrBubjx6IIQ==
X-Received: by 2002:a17:90b:574d:b0:32e:7c34:70cf with SMTP id
 98e67ed59e1d1-34f68cf020fmr9251699a91.36.1767993786760; 
 Fri, 09 Jan 2026 13:23:06 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81df6b3bd16sm2996323b3a.25.2026.01.09.13.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:23:06 -0800 (PST)
Message-ID: <bcad5451-4779-4914-9b8f-e63bfe5a2b26@linaro.org>
Date: Sat, 10 Jan 2026 08:22:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] include/exec/helper-{gen, proto}.h: add conditional
 HAS_HELPER64 define
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> It allows to include helper for 64 bits variants selectively, by
> including helper-{gen, proto}.h and defining HAS_HELPER64.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/helper-gen.h   | 6 ++++++
>   include/exec/helper-proto.h | 6 ++++++
>   2 files changed, 12 insertions(+)

I guess I'll need to read further to find out what you want,
but you shouldn't need this.

I've built these headers for multiple inclusion, so that the HELPER_H manipulation can be 
done by the target.  You shouldn't need to modify the generic headers.


r~

> 
> diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
> index f7ec1556997..c96e13b835a 100644
> --- a/include/exec/helper-gen.h
> +++ b/include/exec/helper-gen.h
> @@ -13,4 +13,10 @@
>   #include "exec/helper-gen.h.inc"
>   #undef  HELPER_H
>   
> +#ifdef HAS_HELPER64
> +#define HELPER_H "helper64.h"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H
> +#endif
> +
>   #endif /* HELPER_GEN_H */
> diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
> index 6935cb4f16f..002460722e3 100644
> --- a/include/exec/helper-proto.h
> +++ b/include/exec/helper-proto.h
> @@ -13,4 +13,10 @@
>   #include "exec/helper-proto.h.inc"
>   #undef  HELPER_H
>   
> +#ifdef HAS_HELPER64
> +#define HELPER_H "helper64.h"
> +#include "exec/helper-proto.h.inc"
> +#undef  HELPER_H
> +#endif
> +
>   #endif /* HELPER_PROTO_H */


