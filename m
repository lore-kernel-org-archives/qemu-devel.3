Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34676FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHTB5-0007lZ-Fq; Mon, 27 Apr 2026 17:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wHTAy-0007gF-5A
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:07:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wHTAw-0006mS-AF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:07:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82cf636dac8so4531345b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777324048; x=1777928848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUurxvl4QCwgYKGJoP7JkiD1h1qDJowcmLphJ5AJgLQ=;
 b=LQYFPKgp3qrMU7UoblqhsmP6b0FwZIYA1tHNXpNXKlkNFzuM7a4m67SOGpjaAyROgR
 785nbRoIH9L1V5LcYOZk/oEGDlJrMNNNCDQHALLliD73121O9+KqSvnEcYKkvafaY67Q
 fayFQiXaSuQaUBubm8ecZbgpBNZ96JvjtEGRbukoq/HNFRu73FzCIUxBUBtfYC9gCc4I
 YlSB2+tF10kqOB6igeX9gwCoRLOgSlaeWaH7Erj+KAs5kHK1+EVBO8epBHWQnJJU5QZd
 EhYj07MNdUCo66N6Mf2w9yC6hf6O3nf1MYn5GFBIAgnDPQ0fAhUqRcRz1oevAWcmMU0w
 XwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777324048; x=1777928848;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUurxvl4QCwgYKGJoP7JkiD1h1qDJowcmLphJ5AJgLQ=;
 b=GpYziSVUtePEBZIHW6Nw5eVJ9ztwRjk1rKVrdR5iZpfFCBSs7bUjYdHO3xIHhOTmof
 JVp2OgxbxhzP2LB7VMeyElcvkU4wSlWButXGLxgEhH0cezuwh5zAo1GL/dRE1cderKtj
 7XrGMG6yKddEpbkLqWjFXLR2lqk1SqOly8p9QoW+GIpaefqTsbCLnBE2+gLXykuoZ2np
 oh/HEbwL9UCR1y39+qUvlc4WQKYpXQU6chQhplCOXXz2Dcb8QM0nB75nLB+6H+abyaSK
 eV983PIZko7IciqoPz4oHbfG8EivnwGMl4dvFqk6IQxUeajsG/HEKqimsyHCOmTdcpst
 DBvw==
X-Gm-Message-State: AOJu0Yz0ky63RmRgSt3hkABsTFK+WCg4N6SpTV9dah0LY4yBBQUxYxTs
 Ys50j3GRLOte9Oif6SombvKxqToG9nn55eQLEAmpe85tT8rSs9ZIKVfkbBdHihbKgVn0s+P9/Vw
 Ccb8vdic=
X-Gm-Gg: AeBDieuWZv9seA/iQrlquOW2XZLttsk2DOPlID55FLb3eAyvjIZsx8Gtj6G3aDWft9A
 I+hIJbGpw8FoQ4GShD0ciNlaZQfB6GDorfQn0E7RwR7VA+C6Z2i1dnVlq6egP0DI+oKx9Lg3aeo
 nAh1ez0q43FmX7eVvQhurhR2o9MV26rfjaN9bc5MvVBa4zN45BeDk7yBudgF2OzYry6snRXRcsV
 V10TCwDFDUZmM+NoCkXN+NkLq4bwYUWG9dMyhtoIdqvVxF/TwsJAPBptSb22hvrRmApWUoHQmW2
 lWR9QJUcDDvpfS8lAy+R2tuTEnpqFrO9cy1VsvUHtaAeJ8o35AuDKXQeEYs1yLtIsY8RPZzjAmC
 VrHBvVCuH4nUixA1eZuGxthIIcgyX9XyT6/P8G9IrDt+48efu6CbUoIfMo/uZWmsb6Oste8ESnq
 FnxLKhIeAVnbDFXMAcHZbXQAuIGEo6iCps6jSFhkr1dSWjAziifcib
X-Received: by 2002:a05:6a00:1911:b0:82a:6b97:34ae with SMTP id
 d2e1a72fcca58-834ddbefef5mr130611b3a.32.1777324048144; 
 Mon, 27 Apr 2026 14:07:28 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf31f04sm367708b3a.39.2026.04.27.14.07.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 14:07:27 -0700 (PDT)
Message-ID: <8250b31d-f4e4-451a-8c8b-45aa000d52d5@linaro.org>
Date: Tue, 28 Apr 2026 07:07:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/32] monitor: Remove hmp_info_pic() left-over
 declaration
To: qemu-devel@nongnu.org
References: <20260427080738.77138-1-philmd@linaro.org>
 <20260427080738.77138-33-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260427080738.77138-33-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/27/26 18:07, Philippe Mathieu-Daudé wrote:
> When converting 'info pic' to QMP in commit 795eaa62fa6 ("hw/intc:
> Introduce x-query-interrupt-controllers QMP command"), we forgot
> to remove the hmp_info_pic() declaration. Do it now.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index c8ce8579424..f9b4c4e2982 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -52,7 +52,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
>   void hmp_info_vnc(Monitor *mon, const QDict *qdict);
>   void hmp_info_spice(Monitor *mon, const QDict *qdict);
>   void hmp_info_balloon(Monitor *mon, const QDict *qdict);
> -void hmp_info_pic(Monitor *mon, const QDict *qdict);
>   void hmp_info_pci(Monitor *mon, const QDict *qdict);
>   void hmp_info_tpm(Monitor *mon, const QDict *qdict);
>   void hmp_info_iothreads(Monitor *mon, const QDict *qdict);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

