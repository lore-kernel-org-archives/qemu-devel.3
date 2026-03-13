Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A062107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15PH-0006Hz-LC; Fri, 13 Mar 2026 12:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15PE-0006Hq-JU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:30:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15PC-0000YM-PC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:30:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82a15b44c3cso770126b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419429; x=1774024229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U5XTcr6C6kYho9JLrSuMEcMQ7U617qBoRUEGLpstt0k=;
 b=S51QkjmxXJYLPBraAnN3O3XlrnPAV4z6k6g1l71JQqdcYKMl38duQPpUpyBgfMYEon
 7cQ9n6uifP9KITTeisfP/w4K1DVmKZ7xApzOXa8+slUJpBEp3rBM+2m4Lc1id8ZPuhmw
 xDC9wpbvVb8e1J/F8N4rQ6GxF6N8ZHQIu0OfvH8vDkOQqOq1n3ehY/CXqpmidsyg1Z5F
 V2aqPf8pKRrWHg9fum8OvjKMgnkngjRgZyUfW5zIKyit1q7lCNlfFZsfEcfXeIuoWxr8
 7gQ4NR7DqhQCCO//koZ25JSeJeq3q2Y+TG7Y7uQ8zQjo0fVXEnqq4ZGbPPnSr4fgk3Ng
 GBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419429; x=1774024229;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5XTcr6C6kYho9JLrSuMEcMQ7U617qBoRUEGLpstt0k=;
 b=i6u+kFVmiDmgp4dj/20zvPIaq0OmluBReop1zKvVTI/elGbwYnzT5bisYKqB59Fa9s
 O237osi3Sp0eUuWgiaFukQi0ZOj1yQOVhh3G0va6QCsoSXcrH66xsQhkLotAjm+mReaj
 3HIXxxGRv2vRvQz9QIl9NL3aat50gQFN4QRZzzYGA46i9Wulmq9/D+r27h92+AXJ8rWZ
 qOdDSe7qROLcSZEAvGmdu4XRyuratGLl56A65vjo0+bndv+Viop0J/rcGmu1n51tS2ES
 Yl/5pf1dt0ZkSFGKlTygMi6tGXPr/GNiwdx7kxTCLmuQhGc5RVVyE+jaOmv2kl+Jmuhu
 onpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtbFugY3/VCapNIqA4RFbpyOqDXzrHXtW+0ZRiqlFC8LbSGkhBrvUvYx1tizz7aZCMqgwcfB5oZIjA@nongnu.org
X-Gm-Message-State: AOJu0YxmjtAteTl6UoZW4vbAdq8XIlJOYUIoUAmvWNwQBdUVFyas6rDB
 7Bfm7561+QJc4WI9AAoYFHsB7lA1LpE07/oZR7uA71p5EGw9GK+srFnDvsLdsaLRC0g=
X-Gm-Gg: ATEYQzxagypF4dSqX1NDLmbgreGBoETot/KbmKmhBfkD8LvbH/nJsBBTSgdv/yN6guA
 8yEjGaVez/s2xzFGsY1zUr2ma7QVVYH/rPA67+PJrnRUAG8g/YO9LVxeGbI0SpcGWtoS5Tbjzyk
 OwDeH+qxoEpT6+NA36YgqZhOuTInu46KC/1R59SKLV5TBiM/GxVPGxMcXtk674ElMNACwvjUDJi
 3DNHHrS/l0m39DK4EnSA6aLGDrs/kyeaND05sgkk3UJMUdd2ptufWNudCNgZaGOav2EOb/yXltn
 UKHnxwZKgShJTqexU44cOVmoU9JpjyAcjlg2ahHD7tojp0rlsPWggexF3nRtBVQLSAsORZIgklZ
 CDCLLNsgP26SULE1vsYontJMpNnW3m5NwCEYOUW4JKwDIGxuJJN5NV7qe3DtFBgC+UGemqzSOZD
 m9w0es1ztqJkKA85g1/jM2cNNHLx7AQEotXVk2Yz03+x7/GwKcxqT4393h5cpicLpAbZgq
X-Received: by 2002:a05:6a00:1388:b0:829:7ee0:1a44 with SMTP id
 d2e1a72fcca58-82a197046dfmr3655095b3a.4.1773419428929; 
 Fri, 13 Mar 2026 09:30:28 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a07340518sm6530581b3a.34.2026.03.13.09.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:30:28 -0700 (PDT)
Message-ID: <5379fd5d-1980-4a06-842b-443541907d95@linaro.org>
Date: Fri, 13 Mar 2026 09:30:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/38] target/xtensa: Restrict inclusion of
 'exec/cpu-defs.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Not all files including "target/xtensa/cpu.h" require the
> "exec/cpu-defs.h": only 'cpu.c'. Restrict to it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/xtensa/cpu.h | 1 -
>   target/xtensa/cpu.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

