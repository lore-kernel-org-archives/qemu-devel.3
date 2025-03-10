Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC9AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgwN-0004l0-Nz; Mon, 10 Mar 2025 13:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwM-0004kc-5C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:29:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwK-0003Oa-9L
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:29:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22185cddbffso99011555ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627759; x=1742232559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7d99carhwoM0Kf5FF0BGMnVsObDupDpe16i1j63Ua40=;
 b=Rq1nYjmLKvIISI6xMJ3//K69KDYA3vUEngSX6y48ASuU4nCdutt/SCM/fwxGV5HktL
 aABesG0zpZhEkkBrsHcc5NMupAi5ErRXthhdLIzjaZf4ITBBMMvEnD7NN3k3EmqWuKTA
 +vxcOUnxZCzVUDYbEJ4IqKIGBtfZeBFw3g9wpYUdtRsbOmq6TIhkqXVJkU3yQKLJre/o
 Q0jJ+eFeXy9XqcwvcW2rHxkHPrOtEOcnTS58S0Cd4/1A1mU35mgDv7OVfRYEvn4xoKTX
 c71DOn1VXmYxgH/D8c9jGQx6pnndQAIe5HUS15LavWYSUom6zJaA46ARvp7tc8Wauwc6
 Hgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627759; x=1742232559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7d99carhwoM0Kf5FF0BGMnVsObDupDpe16i1j63Ua40=;
 b=vyPqD+gk+i1Pf/pMDsMhaOjwS6wySuCQFShXNN6yIG5pLr5NwlmnmxDxkFS1a9XW1x
 hjGDLoFaHAQ+G9T/PnG6ppkwdRiMgLutBIfpv1pU0rzvZMRIMdvQoDmhvkAdD9z4DBOd
 y2NW/vBvERIuO+y1xNUxE4//OfRkTnv/lcNKir0D7GS58vqacYdUQENMF5wkVZn4OyIZ
 1AE8apWCvNn05BCyQb1LPFMNx8RtDHnRsolfETAlBRuJXKlM9xC7EHsECnnWCS1OFRn6
 38ZZcZFikiYBinb8Fc+xuqd6VffF+0k7+ezCfvZvdmp+tG+LFO99zz9YZe/1W4xEBgk2
 QOWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqsEqxMfvV8TUzHT5+kqLBKClokLytXm7nakyGSubkCT8uAGfn/eIV+Ks7DLZbbT75xPWPo53ei5R5@nongnu.org
X-Gm-Message-State: AOJu0YzSrZH3SpVKRvJd1ftLjlg37WUNXoUWFPYi778yIhzWxNaS28Yg
 nz0Koyn8AxEFvUTYYESsNa0MJWFVp0cnZV5pPex2hKwa3lW/a0m3pNNmKSGtx8E=
X-Gm-Gg: ASbGnctYCzXlsM7v4lkM6aQyGXfdCVvO3kWzOgGma0zdnbSfLXdTKJbMOkrYz2NNLh3
 zmjOHDnfPZUjWfxQ98DH6RrVqFoeo9Id6EVnDC9uVftdmYe+/gn9iSftGejfNPxZR+bXKdCkkUh
 H9YCQ/WCor5+AaK3F1YGvy0utXgGiv8T6ZItCxuA/dxr92VBVdR9wn44iBLedzgYQUm3UzZf7tr
 8kdC32+IQ+TSCWyHYZFyWTIsY/InAKERquQtmR4VOFi54zCyxNRJXRv7itPC7CgbFjqLNqRcpm5
 iLSrs9KpkDoTDMIPCrmHE1HVRXICxf6VdVsFgVO4oR3dCLQvnbLERUXul88iPwMtKcKu2DO4WzX
 jyX68+q+/
X-Google-Smtp-Source: AGHT+IFoMWuePQaGDkthGbCBiT8oHtsSx76+fVsR/dkxESvx6G6v6Au0pOiki39EG1S6lgg7pN15Xg==
X-Received: by 2002:a05:6a00:1394:b0:736:5813:8c46 with SMTP id
 d2e1a72fcca58-736ec6b29b0mr446070b3a.8.1741627758923; 
 Mon, 10 Mar 2025 10:29:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736aacb3200sm7207486b3a.131.2025.03.10.10.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:29:18 -0700 (PDT)
Message-ID: <1ff0380c-5a6b-4aa3-b59b-a75cf4fa4565@linaro.org>
Date: Mon, 10 Mar 2025 10:29:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] exec/exec-all: remove dependency on cpu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/exec-all.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index dd5c40f2233..19b0eda44a7 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -20,7 +20,6 @@
>   #ifndef EXEC_ALL_H
>   #define EXEC_ALL_H
>   
> -#include "cpu.h"
>   #if defined(CONFIG_USER_ONLY)
>   #include "exec/cpu_ldst.h"
>   #endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

