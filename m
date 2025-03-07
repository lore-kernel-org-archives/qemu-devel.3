Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30FC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqekU-0000Y5-3L; Fri, 07 Mar 2025 15:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqekS-0000Vq-4S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqekQ-0004ky-CT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so14066565e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381005; x=1741985805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYmb7QD/baHmzIh4UjdaMdQDVuT+bDgfSsNtQGMxdOQ=;
 b=nqhVasrRoUQ/UsLDAtigT9+d5Y3IxD2u07yEJTbiPeCNXA/kveFkI4rHrCnZ6F13gy
 5ic8zQB+XSdTP70S+Fwdc3wcztXoUJi4e9aRO1y/dSm9c0v+wiYFiR7hJrCKzmF3dwJJ
 n4c1Y6hYY4WSU8GzIknczNDROXrNQHyia36lRnMXMSpJh2y5YiEUPAeXB/dzBQ9TKoyD
 eZzFC+48K2J5l6yaAoVy6vuCctsKW0rQwtB9L92em6/AVbNcNMn+5A40nTeHOVss3ju8
 930O1PyHUqjOBzXY+6PpVXCOe2SjjG99sqVtSayBg1JmFtgxex3y/8Ix5CrPI+Lj8ien
 uOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381005; x=1741985805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYmb7QD/baHmzIh4UjdaMdQDVuT+bDgfSsNtQGMxdOQ=;
 b=u6LO+nPwfYOTFlSFFXDdoEFB5OK4tSl8UD+dG1Rto4JD69IRJMXI9Afb6k3csvTrRl
 pSPNtSz1MOTgzzgBMXXgnS0IPTHONEl3QbxgwCmJBMRWM7J3iTJR6mBi6t13CXtbc1J2
 ilWYB+MO1+N7OunYj8sTC3jK/uIbzqNa1AKBwOt1OIs4GxjVsPIkHh6gBCgwCEO92bU2
 2ZFQs1VZRl6b+NFXx3awHBWlV7MYB5ir4D4I7KTTcHaR7IAJNMbQgM9HX6j2A9y3WmIB
 glKYuwxSVcEDmcEwAEyeg4T+mMcGCOjoU2OjdXo+QJhmzast8ayVXLMiViKohRpDJVbl
 8b4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoKZ8fAm7w3liTZQyitOI5FtU7tHUi3+w2usA0Mrv4n0whn39EAISlS/46e+ooDhbex5cQs1/4xkon@nongnu.org
X-Gm-Message-State: AOJu0YzHK31ThucBDVNwXrvbo4E5zw5N66zoMRXYEUR2sqnbH0l4vHxI
 KGXrk7OcaVFMgx6XLJu3jLr1hvJbK72mqKFz2z+SbjQwS7QxnHjUGkzT2cSkBTg=
X-Gm-Gg: ASbGncvtO44qMkpCz6EFn4TdMGxZ8fFhKTU+SvjfCfYc7qslu1kTcEfLVloulZh1pit
 MufUb+I1Mg/FECjJKbFE9Mt9jh3HvHTdKsH7LhafqfbFdbaGvLyTNnEdBhexpshRHkG30+pPzJJ
 3Wk7Z2jggR4WNnOy3RStiZfbG+xrFGub/OxYDoSGkMSu8RFUuJkx9AFVCzlIeG7MKqigLtZH4UB
 8p8kQBa9OdQVbwVzq/m5Ba8rqirSUbvH55QTywlmq4araflgJp8K7PR/TNInPouuH+IP+HUcj7l
 g2OFHQOnh5pxZDP+rJy1BjSoYet84qzc4Mmcxz+1unZAd1pw+DWPIv/SgWpsNqpEuScESMqJcTs
 XOeL0NwfXS7Vr
X-Google-Smtp-Source: AGHT+IFhARMjA9i8ahOKmVDivdHXzngn0JUxaGhcVWhPJIbs9KAbK3fApFsmdd+EPEtEgWHIvyEhPw==
X-Received: by 2002:a05:600c:a15:b0:43b:c824:97fa with SMTP id
 5b1f17b1804b1-43ce4dd6711mr5969265e9.14.1741381004841; 
 Fri, 07 Mar 2025 12:56:44 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm6548214f8f.59.2025.03.07.12.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:56:43 -0800 (PST)
Message-ID: <0e40276f-c9e6-47e1-b70b-5a8b5f8fb30b@linaro.org>
Date: Fri, 7 Mar 2025 21:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] hw/hyperv/syndbg: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kvm@vger.kernel.org, richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
 <20250307193712.261415-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307193712.261415-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 7/3/25 20:37, Pierrick Bouvier wrote:
> Replace TARGET_PAGE.* by runtime calls
> We assume that page size is 4KB only, to dimension buffer size for
> receiving message.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/syndbg.c    | 10 +++++++---
>   hw/hyperv/meson.build |  2 +-
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
> index d3e39170772..0ec71d9bfb8 100644
> --- a/hw/hyperv/syndbg.c
> +++ b/hw/hyperv/syndbg.c
> @@ -14,7 +14,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/loader.h"
> -#include "cpu.h"
> +#include "exec/target_page.h"
>   #include "hw/hyperv/hyperv.h"
>   #include "hw/hyperv/vmbus-bridge.h"
>   #include "hw/hyperv/hyperv-proto.h"
> @@ -183,12 +183,14 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
>       return true;
>   }
>   
> +#define MSG_BUFSZ 4096

(4 * KiB) is more readable, but, as a matter of style, I won't
object if you insist.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


