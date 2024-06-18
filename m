Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F28FC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhnf-0001MR-4k; Tue, 18 Jun 2024 18:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhnd-0001M6-IR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:59:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhnc-00032j-3p
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:59:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f6559668e1so48420065ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718751574; x=1719356374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRnAC/XlLLwM3K/rBqx/EfC7ZcFF1T3Kef1kH3AqPPQ=;
 b=R2Mx4pCCRinteh2HNq0kRhzI/28O9J8f5mSMTJuej9H1M4jlcU3XnAzGyaf0aVig8E
 ENlA57PKIP+kXxL/lhD6aaaWO/mFkF1eRrbq4un9pJaAp8G+rnfK4sDYw2h031U3UJJ6
 PnGAZM8QjUSJuQAK9d37K5jsaWCt8LCLNPYpNypf9JiMUZ5DthSAicpphwDE7+k6QYeV
 R8UtgMdSyHLgLeS+fCAM0jjztdN2HW6GlQOrFxePATfcIiKPeeQCawwp2GXtL0OLlNs/
 3hd16EoatP0ueVNz1PhQ8VBvccoPNLTAw3Ri5l0QE6S3swJifmkY/pGtfEj8QC6tBrZd
 FylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718751574; x=1719356374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gRnAC/XlLLwM3K/rBqx/EfC7ZcFF1T3Kef1kH3AqPPQ=;
 b=WeAXmrlLNs8GaBtBnXU3Y19WG90GfE36jhUTtBRQ80OErFn6Xxq4AXTVQT4dJzF3Ws
 ZxRQQKfMNXcn6LJYwBWfES+qAU5+t3b+MpUufdtp7ddSp4bbslzFdnnu4ETWI8unz12P
 ErgbPeFqie5litRagXoUTmLmjhehR08obeAsW8qVxJjn7/8oCAiSpbhJ5OJZHdWISacf
 6O7utORkpFf383xWsn+GuMseknbw1pgYzJdK/TfpANXyBawo/wu9OV9uT/159wopT/TB
 4EBvkp6YWicAmolhlmj/84ZcrjZmCYQTZkwM8q5V/Cnj+aNwOkF1pmBjxn7WXlfRmPQV
 kIkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAseGYlYrrhkxD+4lwPCVaAdaqi6zSlvkMSPY06ujxDVm77vWNuFgNq48qolOxjyuDVp/+upkYcvbcesO/a0ru1rgqezw=
X-Gm-Message-State: AOJu0Yy48FMeCBA42Xc2o9wcvi6wzrWMXlZ66+GiiiNBc/XcLW4H951h
 OG+ygCy+eijsw6v4nyhLb+hvl0u8z90Og63h7X0EUZGh9sILcjdPKva8VcP9SS4=
X-Google-Smtp-Source: AGHT+IGyqQ9ozE5imqUYkWIunvzYLu3DGc+um+Dle5iqzHgOAZUK74NZtg1sHGscsmD/c9KrnSTBfw==
X-Received: by 2002:a17:903:234a:b0:1f7:1d9d:f97f with SMTP id
 d9443c01a7336-1f9aa3bc760mr12033005ad.9.1718751574330; 
 Tue, 18 Jun 2024 15:59:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f5ad14sm102834735ad.303.2024.06.18.15.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:59:33 -0700 (PDT)
Message-ID: <d5f66c67-8a2b-4a68-8a96-ef0e4ffb49f7@linaro.org>
Date: Tue, 18 Jun 2024 15:59:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] exec: Make the MemOp enum cast explicit
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224528.878425-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618224528.878425-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/18/24 15:45, Roman Kiryanov wrote:
> to use the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: I785f2e65d192287f1f964d2840131b653755648c
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/exec/memop.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 06417ff361..f881fe7af4 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -161,7 +161,7 @@ static inline MemOp size_memop(unsigned size)
>       /* Power of 2 up to 8.  */
>       assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
>   #endif
> -    return ctz32(size);
> +    return (MemOp)ctz32(size);
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


