Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3FC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ThO-0001HR-9V; Fri, 10 May 2024 13:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Th1-00012p-O1
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:06:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tgz-00083Y-2K
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:05:58 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59ce1e8609so575328766b.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715360755; x=1715965555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UYON+MhadshZxOy1zcnJK8Xw7A9SZ3LfMLpmtHNBzr4=;
 b=oiXCLGtTY/cCyMwmdNxx3hJ0tOhiQQfQl7cInvEMkWSJIt3FUl4dSrLKz0qaDcBKni
 2C6ukMO90FBDCKJ5Y1r1Skaq0iXLcTmnPdF3d/AzX3bJ3MGXsrXwv55CRw1ufVlVgCeG
 lwLrkbdB46BIsOP46V63482ITRz59y0NduiE7UftJxKWiQrlyRKuHfOKsUhnbjZ7MFRX
 2hwFJUzpSMIcLjgttSlJAGqHgMMmZOTfJiVni06YYwGplOQGGGs9XsMjDFiA9UurEiHn
 pON1emCoc5HroeU4p5pJC/ORwjhOoooueM1wzBr6HSOoWZ1PtX6xnT9fPVLvgpsubOqK
 5pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715360755; x=1715965555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYON+MhadshZxOy1zcnJK8Xw7A9SZ3LfMLpmtHNBzr4=;
 b=bpu6ENzlTBuziMqukB/SPImsOVoq61rMlrbH/JHB+WHaE6MRc9+tJ9jt9FmuV0XRlw
 AuikJOY5aCSfy6Vpd9wgXwmW3cQ1oFulEgJ30WPMHG+KYWcUDFIdkkybfUB/T2Z0/RfO
 WFiVVzsluUsl8A9MDCoTOhQiIwWsWUS+vVit2oXIJCIWzbE0YB28IObl03zfqKmYtJVL
 GFOWiKxGm7XCRDfpYSxBGbW+Vu75j/ONncRQ07Mi+MEkTEn2sCeCSjiEXqX4GmqzryXk
 lR2hpqyBrd1ykzkKpMr7iys41ZVJNZr+SqT3FJhArGgpLeG9g+45hxUwODnP2atPXWSC
 4svw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHKkhQqx8gEBtJ4Jzn6y/GOvQKnEX2i/B5KoiDoRC39o13D/Z3mmDaLYM4Nr7OqFMJA8nPZMELRnhueK2/O0SM0iYFlh4=
X-Gm-Message-State: AOJu0Yxy3pGH0cZsVs9X/VLRd/9/AKmWGv0RD/QFQVK/GwV6KV2ZLxIi
 Noi0xZTUF/VPZ7AXpR5NydzlCsBX5x9nRWvttFlsSpsGi3O/XPKCr7FYOFtkIDEX9V3GWSOaZ+A
 u
X-Google-Smtp-Source: AGHT+IEiWCbbKyV27k+AfG0o6OTUs01GIrwSoO+zK4t6NqgMBoRw4iEPG07eLfGk+pkXQspbuX/iIA==
X-Received: by 2002:a17:906:31d7:b0:a59:ab0a:a170 with SMTP id
 a640c23a62f3a-a5a2d18a9c2mr278364866b.1.1715360755535; 
 Fri, 10 May 2024 10:05:55 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781ce5dsm202229866b.42.2024.05.10.10.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:05:55 -0700 (PDT)
Message-ID: <45e79595-4df2-4668-8240-6605fd4653b3@linaro.org>
Date: Fri, 10 May 2024 19:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/41] target/sparc: Add feature bits for VIS 3
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> The manual separates VIS 3 and VIS 3B, even though they are both
> present in all extant cpus.  For clarity, let the translator
> match the manual but otherwise leave them on the same feature bit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c       | 4 ++++
>   target/sparc/cpu-feature.h.inc | 1 +
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


