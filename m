Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D505BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaJD-0001fV-Uq; Sun, 21 Apr 2024 12:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaJC-0001cs-AZ
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:44:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaJ9-0001gJ-KB
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:44:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ed32341906so3490453b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717890; x=1714322690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nyzp97ki1grnNxngMCvV07B0rG8wrW4X+oI9mWIoUg0=;
 b=lyvEx5F64Z1OO/GTFZwy0AO7/9NJpXy7xlIEOGa+TXCV/5POI9+A+ti7z1sYMojch0
 tTsbLtWKd4MC58sY/iiCBerGaBblPweeGNreEEUra12s004Oitx8nZCsXgXJ5RHJoEXW
 4zfgE8rln6MtPP5+LfzPTpW6rAlK1oxlVE09yRwh0DMkhqsapfVH2mxT8ZeLXy4gtxhT
 0zrKW2MFXid62L+9wlf8/sztdqsiXFBJqoatOAAxI5iFYXLvR9ugNSAMPBEG6J9LwB4m
 uQA9rnF8uxxUgd+m/vLTetPSCnblhBkFLvwlTdy2XXfY2zTHOkeyOAaC88LVqc4fDgeM
 7aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717890; x=1714322690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nyzp97ki1grnNxngMCvV07B0rG8wrW4X+oI9mWIoUg0=;
 b=rljOAuQmEzNXOiY7eLx5FQlHipRNyTFVNZYThoi2uChsTbKdhhtUsv+rYFSWXJqqbB
 Iy7VGbUNyyrcpX459g8wvjDR00/fIwB9l6I1m1XHX/p7lngVA1xSNnoLV96Z7qiyJVZQ
 i4CzMV18W6n4ZIYd/brBnpI6I25rLuHU2tLzsv4vCmuIUVr5ZTCYy50NJhMLXG90Y5dN
 PlRnLuWNUNFnPoT7cBImqw/6lLItLlU8oXsdnvDD98FVNklZBQ6UWyAwvqcXt3AVMDjq
 UVbEsK93jHoaX2t5gXLoFcoyHhqvcwi72mIG36kK96FZkMCWK3UX2Q3jmoxKLeJESFnu
 CFWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZGxQL5Kg/d20rWphjFcyLx0ujK8CojuUl3WPOi6IlqvsqRgXDNblgO6KPnl6pnkOO8DHWIICHLF6nmjtsgMX/kAMawWA=
X-Gm-Message-State: AOJu0Yx1HoHQtlanu9A9W02MNGQ0LfUE482UveoMPE2QYKEwyEyAP4nF
 sDbGToNW9PnuR71QcyMPNUNbv3wKQx4QpSYwgjV4MMEw0O6r/X+seyOEc3rBEDM=
X-Google-Smtp-Source: AGHT+IEW0S90e+aa9Rokk8Nr+asc0MSx8g2O+FJc6mVvrp7msO29LBb8PrSeUtP+nkxwtnmiTnWQVw==
X-Received: by 2002:a05:6a00:4f87:b0:6ee:1737:1e43 with SMTP id
 ld7-20020a056a004f8700b006ee17371e43mr10271763pfb.17.1713717889952; 
 Sun, 21 Apr 2024 09:44:49 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 x37-20020a056a000be500b006edcceffcb0sm6348703pfu.161.2024.04.21.09.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:44:49 -0700 (PDT)
Message-ID: <76d68cab-7b28-43bf-89a6-bb39a7fdb131@linaro.org>
Date: Sun, 21 Apr 2024 09:44:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] exec: Include missing 'qemu/log-for-trace.h' header
 in 'exec/log.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> "exec/log.h" accesses the qemu_loglevel variable,
> which is declared in "qemu/log-for-trace.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/log.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/log.h b/include/exec/log.h
> index 4a7375a45f..e0ff778a10 100644
> --- a/include/exec/log.h
> +++ b/include/exec/log.h
> @@ -2,6 +2,7 @@
>   #define QEMU_EXEC_LOG_H
>   
>   #include "qemu/log.h"
> +#include "qemu/log-for-trace.h"
>   #include "hw/core/cpu.h"
>   #include "disas/disas.h"
>   

I disagree: qemu/log.h is the main file; log-for-trace.h was split out for other usage. 
That shouldn't mean that log-for-trace.h needs to be spread around.


r~

