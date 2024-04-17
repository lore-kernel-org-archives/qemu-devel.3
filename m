Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF2BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAjq-0004PR-Mc; Wed, 17 Apr 2024 15:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAjp-0004PJ-DS
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:14:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAjn-0004Es-Qd
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:14:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ecf406551aso116016b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381270; x=1713986070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r8iKJf8rN8MltrwJEEg5p/s2DIH4HZTL5M8dI3gwPvo=;
 b=eygWgyAn/T1kw7sq3B7fHHauCOrc1zjTipyHl1zZ+M/C2KclLT+ZVVisDI7Tv23Jm6
 nEGIxhZuelB9OWAJCqzNLlvbOL84vIiMlQ0p0n11TmF1F92kfPzcLmQaArRh2cN2rbX2
 NrpDNi6GbpAczhBC4k2k5mKiM3pzysXq3qQxOgEEqsp5gSKXqbNmQCDayGLf3SQ4c4zC
 Gq3yw1ap7138M8zt66ComK8Y5clCanAIW6npDhw/a+Y518wr7kknSDIjrTDStKmPTMZP
 r3vFbemfHiYaNITpChcPgRKgkp02i73OcnjI5cbot+oMKOgCMFyRcw8flMjOkimW8NWn
 Uihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381270; x=1713986070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8iKJf8rN8MltrwJEEg5p/s2DIH4HZTL5M8dI3gwPvo=;
 b=dMSdJuaaL0JRoZY1xnj/ugSol6afRhYqGiu8+Nr3IpriTieKzx/jbjJRCdqtNF6VYQ
 VK5FHVtYsSMzo26IEGomOwEKzOSxiJCYlVyI329ldJF6AUY/a4+Mbfiv0A8easiviqiY
 t+nXWh3DWnReO7rYjxNTJUbWt6QSaSf+MEZVFK7CXMML8nQF3OO/nDkW9ECOGbMXkEeV
 YyIabkvL1euWjx0g8BKEt7q7BZGlVG0R5wv3vlc9oeX0iEsYOJDC4vsvFHKbJgeuKIvy
 Pwalj2p+uBj3dpZ3KLTG75Tje+FOuvidUcC5A6bUDyeKYlb4VIehPI6vkEYhNKgVttpF
 NVvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6iKg1Ayp6YywJFypYJXbTam5Y212Flks37iG09w+OH+EJWx4h2EflGinecJncKHSywC3AwSDnZi2iYzuS/bnkWESMKeM=
X-Gm-Message-State: AOJu0YyIbWl2vPxASXt/ijUT3a6m3BDcQrL4ABOsrQHH0Jp3WYsA1a6C
 8GoDI98wRZeS2zRpUoHfpCaj5oR2MhuUCGubFTpQlj6982PnWZbtGLzJKcDKeII=
X-Google-Smtp-Source: AGHT+IEIxcd7dsSn2y/wzH3Aif1G2ILmCp2fSvdc64zDT4rcpVxlOeLvDzS2FUlI96XGnh3AOIqJYA==
X-Received: by 2002:a05:6a21:99b:b0:1a3:3c5f:2ebd with SMTP id
 li27-20020a056a21099b00b001a33c5f2ebdmr578415pzb.59.1713381270066; 
 Wed, 17 Apr 2024 12:14:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a056a0014d600b006e6c0895b95sm7259pfu.7.2024.04.17.12.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:14:29 -0700 (PDT)
Message-ID: <48f21287-d741-4936-9395-88356260c93b@linaro.org>
Date: Wed, 17 Apr 2024 12:14:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] semihosting/uaccess: Avoid including 'cpu.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
> "semihosting/uaccess.h" only requires declarations
> from "exec/cpu-defs.h". Avoid including the huge "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231211212003.21686-6-philmd@linaro.org>
> ---
>   include/semihosting/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
> index 3963eafc3e..6c8835fbcb 100644
> --- a/include/semihosting/uaccess.h
> +++ b/include/semihosting/uaccess.h
> @@ -14,7 +14,7 @@
>   #error Cannot include semihosting/uaccess.h from user emulation
>   #endif
>   
> -#include "cpu.h"
> +#include "exec/cpu-defs.h"
>   
>   #define get_user_u64(val, addr)                                         \
>       ({ uint64_t val_ = 0;                                               \


Does this actually need anything besides exec/tswap.h?


r~

