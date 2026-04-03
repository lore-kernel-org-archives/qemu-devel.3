Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231ECE88D66
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m07-0008Ek-Jz; Fri, 03 Apr 2026 17:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m06-0008Eb-RZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:24:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m05-00047q-BT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:24:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b258576d8cso14146765ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251459; x=1775856259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3IlhFJf1V7EyXurfpVi6WHEJ6UYmbEh2rjfNVJMVwU=;
 b=MywZNCfkwRYp4kXFOUNPw6yZIp7n06U2xNakjXO3vFbkuFPDrO7a1gmVs81gdCe1Gd
 y0dwP7BwGjpNJSV6N7q+ibh2fcKx/aoNu6ZMmuMeBrInKfeADOQSRH0fM0V0DDqSlXY8
 jO/KzZjC7oi06CCyzs/p1IuodVA+igLk8pYFA1vSXH9nGPuo84aF/AbiyJ4dlGhqYvTW
 /S2D2jBpRtmEmmyAOJ5xdVLoIPrqtokjwak7tZrQz8GOdH8zLdW7AT+eVY7Y1nsnki2m
 GsE2746LQ/qzBPclaQAMMzF0kmduDW9blvw7hI3wgwPN0UT+br+7xgZ/puIpb4D5NRas
 9uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251459; x=1775856259;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3IlhFJf1V7EyXurfpVi6WHEJ6UYmbEh2rjfNVJMVwU=;
 b=TNvDC64YOPnbCqFmE4lGZyTTPpIBQlTKJotQ8VYq2KkDb65xD2x8asSALk3i2Cxgzv
 mGKlwXT+ANeT14+av13nlkYA8JhDISgwOly31YS0+BUj1nfDEoyhOTQ6B8Ed8pc7aUqv
 b/9KHf11qeOLB4+dyT//1lU2knHJLEdX11TUSdqrgRhmfaxpDwqN3oEnTC1rlfa+nxmK
 3pPZAXfyma/7+9VP7pRDiSa2RNNzpvxloL2yk7OLPwciz+pGTfYpngaV25dFdUEejW8D
 CYhjsiWf2K3YRcC/SfzbinvIZB7RqUzaIT72Uqxn2KlXAvCahRZFXGtE+RhQ/IDSWy16
 JUqQ==
X-Gm-Message-State: AOJu0YzlhHGJibZlsos/sVd4gqdq4MZNEOsmcbHYBBU9OeV+zgu0A444
 YPrYy4TdKHfoVDTYnhdhr8Y2LF06UIjOIrXNiAivjJgxaJZwPXYzCMHOKy4TNMuWll7jEcxQlYt
 WJ+hq3d8=
X-Gm-Gg: AeBDiesisED7g40UPTcmnLhwsALTTOZ9xTU6FRpKKLrDy4EYFQx8BgYkpfTOsAGR1y7
 WsO8mrsMzTBER83V410ofEZE1jNy71Fezo/YKRyAHHYoq0N8/p6y92ep7X2IqnRlsSAxL8cx50j
 /2/EMwrtx7PMjrLQAWvu7+myP0pTdzHOtTxNLo9reOMcxslOFpHoXg6mFK3NG2hgRJkhOpcOIIo
 oFHHfj1s6LbzxUrbA1RQWw4Sru1963eSCRxLcPBNpoBOJaJ2pgGzLFcO6Jhyjydl3daII92NZ1q
 kISzHciMMgQhGZksDtzTu29M7NQ/b73unQHmoX6ExLAIrgUNRWQFRBuZ0Corh5zqsXYg4pmE31u
 8UnfP9HCXSdSI4BY4lFtT4NIL2DNwY7BsyplPHZNeXYK56qtPL2dNePXi5Jay9V2gB7u0Ia4//Y
 NRg6jGuTCHv0h5BKWv8Z2mB8K3JpBRtOzqh20IgYPJ/WKUZ6t5U2N2jokBKD57xReRugE=
X-Received: by 2002:a17:902:ea0b:b0:2b2:5da8:14be with SMTP id
 d9443c01a7336-2b28190a213mr40308785ad.41.1775251459331; 
 Fri, 03 Apr 2026 14:24:19 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd9fsm65008895ad.75.2026.04.03.14.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:24:18 -0700 (PDT)
Message-ID: <88bc6948-6709-4b0f-bf10-150bb07668ee@linaro.org>
Date: Sat, 4 Apr 2026 07:24:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 1/8] accel/kvm: Include missing 'exec/vaddr.h'
 header
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
> kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
> structure but forgot to include the header defining it. Do it
> now in order to avoid when refactoring unrelated headers:
> 
>    include/system/kvm.h:404:5: error: unknown type name 'vaddr'
>      404 |     vaddr pc;
>          |     ^~~~~
>    include/system/kvm.h:405:5: error: unknown type name 'vaddr'
>      405 |     vaddr saved_insn;
>          |     ^~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/kvm.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda3..12f7fc8fb58 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -17,6 +17,7 @@
>   #define QEMU_KVM_H
>   
>   #include "exec/memattrs.h"
> +#include "exec/vaddr.h"
>   #include "qemu/accel.h"
>   #include "qom/object.h"
>   


