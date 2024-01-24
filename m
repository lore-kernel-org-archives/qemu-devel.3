Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31BEC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTkm-0007UJ-F0; Tue, 23 Jan 2024 22:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTkb-0007Lb-RZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:16:31 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTkZ-0002Pd-CH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:16:28 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bd6581bc62so3496077b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706066184; x=1706670984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1JMK90EbsLGbOpn7I4bCZkAKxG5c6vLd7xTxwuWHR4=;
 b=fXEp877rg7uR5gg5fJSgwUtDG4+zGKHdM2oX2oDLYGo+BHWIdJtsbZvj5BCtJYQHxM
 3xyiYpnpDbV8D8ZRbB51Yc4xHHvd64bzvTfMMUkQUfvhkASxGB0r4w6y14KKXJax0Gs0
 8r4K8YBT/ssMh8jFOVazxxrI9gV11EArCAdPuRDl36FGlNxDjSU778Q0IYUBfRXKIirk
 Eea1tqU3BzElfVAICm6nCMhCNIvlNd5YmfyoTNWeJm+RvMzE/LmfLS55t9C6JDjTcvlP
 0UTjMz2OykFMpO5cp6r6cw+xMbWp1QPV1DSBDd0002JXsRWQG6SykIG6rx5Dt2M6sBAz
 kBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706066184; x=1706670984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1JMK90EbsLGbOpn7I4bCZkAKxG5c6vLd7xTxwuWHR4=;
 b=ohgAkRuB/R2yiaA7V7MqmYLNcP1ATOYcJmbzMbFTvzmSMViztFNmyULJtQaI/lKxN4
 AnhHapplnkVsKDJ6PUYkwtJYVAwN4LAMQ4W+yxwoQO0Utyf2IsWll5pf+AORwKGplUs4
 tPA/qflsPZr6tSw1F1fgDWPeDbEOuCKZEO4uOPlI2MFWDLzH6j2u5pH4mmyrq6y5sCxr
 ivtLiLoA/zlnIZJnEY0at4PUW2MsmRjKbjHn0Zn7nnZeTd2v+8suw6CAwAirKWnudpyR
 vDA6sZVPg+tJzFAzIQ1/sl95YDkCsKAgNf/+W5FvclocdjdOz+uZerxE80xAp2Qyjrny
 dtfg==
X-Gm-Message-State: AOJu0YxHvzaYVbwWlrL9Y3mUOA+CyUnaoT9eBq+WGe9PEvtm3e0dFn1K
 bvybkxU29cFSwKehqyIcCHm735RZtLQn13jwS1pP6iHesysWEybW58bP0NlZBVY=
X-Google-Smtp-Source: AGHT+IHkjM0RO+c013nQTK95cz7pjqDAPxdVDbvsMTNLzPF31dgZlXeYhRc+iiP9OiRNh1qmvpKlkA==
X-Received: by 2002:a05:6808:3023:b0:3bd:bc6c:645c with SMTP id
 ay35-20020a056808302300b003bdbc6c645cmr1011356oib.24.1706066184111; 
 Tue, 23 Jan 2024 19:16:24 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 lc14-20020a056a004f4e00b006db00cb78a8sm12927500pfb.179.2024.01.23.19.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:16:23 -0800 (PST)
Message-ID: <25e2c5e3-d720-4ff8-a7aa-7d80e55ee3f5@linaro.org>
Date: Wed, 24 Jan 2024 13:16:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 32/34] accel/tcg: Make tcg-runtime.c target independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-33-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-33-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Only depends on cpu.h.

Likewise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tcg-runtime.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 9fa539ad3d..fd78a10fe2 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -23,7 +23,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
> -#include "cpu.h"
> +#include "qemu/atomic.h"
>   #include "exec/helper-proto-common.h"
>   #include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"


