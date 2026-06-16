Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F0CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXzG-0006Zj-24; Tue, 16 Jun 2026 13:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXz8-0006Wa-Rq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:54:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXz7-0002Ik-7X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:54:02 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8584e80d59so1959166a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781632440; x=1782237240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bp065EV9jrFRDViY8AOrKPsHonytwMythX8zzCfZTsU=;
 b=hn7FsCIQcr3JBUBa7RAsK3cHcjry4uE+/wXqDrXSZDFdWq00HNza4xA0ZRtSfufwW7
 5of/wAQmudKyUHkA3KI0WULdhEbEnIWsTxIE5PFECL4p8AvOK3bIN0jtlIGBKNtWxlr/
 5cNZN026JpQzH3yy20U8duah5z/hV5kgltGLob5AM5BOZDort5wdz6apT2Jfkk7gloO7
 qvj/bHdS7P/7FF1eMWsU/UKMWCPGBApbxNKvfQEg0FRuIyHLfF9hN0/61/9Z3JZdQ+YE
 JpbAt9lUSCAuUYQOmqt1VWevkXMfKRvGXi70H5zxMU2iY8S+lWG6J7yfxNYLGmo/jAT+
 VtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632440; x=1782237240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bp065EV9jrFRDViY8AOrKPsHonytwMythX8zzCfZTsU=;
 b=WkeNOveyVBx6OfxaROrg4xyz7kfg1wimEuQ0PEI6VshMYliHBKSSvwgs5B1+Xg0cjF
 diQrzSgj3Dt9zv+7qhikMGSWkg8IAkMuLHvdiGPobUNvSrL6hh6M+I4kYos39hfLPfut
 xoCHTTHil2nbjSS575AUNLyqkuL4aDV5dPQ3/DTqLp9uO+/id649kvrSgwCzMrdR/v2t
 IfLN5gYoYBZrlCwC0o4EDy8Owv3KxvrqU1JiOT+4VEyF5YZ2/sjLvziJghqNX/8J5Nih
 qIvDljxhzivRWDvFPhpkqNu9/aM2deG+HdB3bI4+0odlaKYlemt2NQ1Nyj8uSD0+ynxr
 X1jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FF1VPvd3RscD2OREP5Kqv1y0RKpZLVN/3s2X/hz6MfT5IxhcV+0vhoqhh6SOlzrr1doFbYpqjDwuQ@nongnu.org
X-Gm-Message-State: AOJu0YwLbjLWEe5HaJ9iPFtFEmEWv1m8wx2AMqgfoK71DUQnfRPqUVev
 Jdsp6kie3BSVU7z+n1w0IljIY4GhDNKoBx72BO1uedMWw7BF4fx6mZvTZb6igbCxWWI=
X-Gm-Gg: Acq92OEoulHzK3ggZqds+ju/n3ttJH4y6ENrAk3dfgsXlLf3R2s4FOrgh5ugAT1Nr9R
 MkkQywE/mU0YeT7iIlc+Qj/3de3x7pIjDlhpC4Bwy7CHOuva1/3saNvqev5bDxjNw3mEty6DTeR
 zavFiL8A2dGFEPtOpasFx0AZrfz3ZKBosWgwE+INXpW7aeBR+BgvIRdSGfG4tOaFiWL50qwW8Ss
 IRWNiAGcY5d5besWDVz7ZvzaWskDECiAq/UvMnYbbttG71Tu3PoieIn2BqnmmA8nWXuaDqaJ77J
 dNUaMYS2l6UyLdnn4KaDfgfZzwowd8lOjU+VrY8vKiEK0QRcLqEnDWXl5FYqseEqiO+nCCyTS76
 k83XVoTFfweyll5/vY5DyoDdoYJM/5Ad+3Yv0uEeBTR6hPhXyi94dEU6A8SYL+UH/j06HGdG2ih
 fXkRCx+C+l4hVYcKYVWyStxBfIhLS3TwVlUO5WTZ8pgN/fZ2MmQzzD+4YZ826/nFR7gd26
X-Received: by 2002:a05:6a21:3989:b0:3a2:d838:bfca with SMTP id
 adf61e73a8af0-3b8bc376017mr277907637.3.1781632439566; 
 Tue, 16 Jun 2026 10:53:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8664586b3csm12124834a12.14.2026.06.16.10.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:53:58 -0700 (PDT)
Message-ID: <889ac42b-4031-4bcf-a818-48448a98b7dc@linaro.org>
Date: Tue, 16 Jun 2026 10:53:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/or1k: Have exception_helper.c absorb
 exception.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153432.92939-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 08:34, Philippe Mathieu-Daudé wrote:
> OpenRISC is only available with TCG. No need to keep
> raise_exception() in a distinct file unit, merge it
> with exception_helper.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/or1k/exception.h        |  2 +-
>   target/or1k/exception.c        | 30 ------------------------------
>   target/or1k/exception_helper.c | 13 +++++++++++--
>   target/or1k/meson.build        |  1 -
>   4 files changed, 12 insertions(+), 34 deletions(-)
>   delete mode 100644 target/or1k/exception.c
> 
> diff --git a/target/or1k/exception.h b/target/or1k/exception.h
> index f62fc314c1f..654ac9e515d 100644
> --- a/target/or1k/exception.h
> +++ b/target/or1k/exception.h
> @@ -20,7 +20,7 @@
>   #ifndef TARGET_OPENRISC_EXCEPTION_H
>   #define TARGET_OPENRISC_EXCEPTION_H
>   
> -#include "cpu.h"
> +#include "target/or1k/cpu-qom.h"

Why are you adding full paths here?

> +++ b/target/or1k/exception_helper.c
> @@ -18,9 +18,18 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exception.h"
> +
> +#include "target/or1k/cpu.h"
> +#include "target/or1k/exception.h"

And here there seems to be no need of adjusting the includes at all.


r~

