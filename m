Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B102FF4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuxzi-0004qN-2Q; Tue, 24 Feb 2026 14:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuxzY-0004pl-Sd
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:22:46 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuxzX-00074A-D9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:22:44 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so2583528b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771960962; x=1772565762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4kUcOWVAIl3IqUKaunzAVpfcCafFwNv+CwIyGS9m44=;
 b=ILkK93KMrhgYls20MzyRSoybxjkTHKP0vZxPhH+R5VAziD/9RT344ULUS1rtfSpNED
 SS/PZx2cwjfMk+nWgRiPwSzCZZqdpJNH8oW1J3BoVbETQqhHdW+1Zn8OUESzXiLeaQPD
 KdkwnNXnV1BNgVMbAGkBaXooqQ/7FkJl5hacgc9HpFNVpFzxxkEm5ysM9kqsywlSJGtN
 hmwxfcwSmOrarda3enM8L7BLxns1QEw3SnPaY9spg2+GQvW1zyoFFmQpCp0oJGFnLX36
 FUZ2zPkTOQnZnm3CO62yQRAgCvRzOe3fTj7PBhASpSPaaOa/1plZznFI2Qh8hqcCaxG4
 d8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771960962; x=1772565762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4kUcOWVAIl3IqUKaunzAVpfcCafFwNv+CwIyGS9m44=;
 b=PyzukMIQ50F/1w0MNvV8owEJlAZDdiF5s4NdWMuxDe2dfdWgZKF81pdZnx9d7Y18AN
 tXvOBPgeUv9Ot30KU2lpLmOHAOi8OM650wy4xxjIfr5SR2MIUtMbUPQdxpzIigukxWMX
 81sYJGpe32BdP4faYEluMZl4AdfAAQnYmwPV3w61yLCKkHX06AVvavUlem4xtgnpWP6t
 H4wQEXA3yTk93OrL/pRBbf6YbQl1DfClrHiloLhPfVxl+sVfQ4gRe/C9nRAxowomEroJ
 ZZJoaGxTMaCm1TiVse1tXhgFHKEvxb50meLGlIuEV/MYnXlVtVeTZMr5SoG9W8wB3sAc
 C1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVPkPzAdrTs9bp0xJTDPEj09qLvmuPNB3/JJrGj0XR7fGVE+Si6zLnflc/gsqqW7Ymp/yyKokStarD@nongnu.org
X-Gm-Message-State: AOJu0YxiSveUc5ILs0l7G0neXXVXMGlU00mKY2CaICoT6678R72+K09t
 E99QMiHADI1ppjvPFARGr5AL0ZA9zGEjunE1zTaNnxiG1O6VglRNfHZZD6HbY7GYEYw=
X-Gm-Gg: ATEYQzzeETtLlQH4Mpav1UKzWbtT4R/jCgNGfzUaPGwEbf2RK00de4raAyvlSizBETL
 XcBQnBLR862i1qmYrcT5yJoV+kS6eAsidvU/Dmq/2i9fhCLT6a9fZa0RJGeY/gn/1/e1nB9Zo6a
 cGnKZ/fI57tzq+YXhafgSfNg9eZk/1ms/yh9RPdLUfpzbP0GEtdv/GuNn2YqY6k/w75j74g8DKk
 cFHC6N/CKkhn71q132PWXEJU16dpK3+MHIB6ER8OPCSd2rgEr7HWChcruon8pQiK8gYsjl1xrBQ
 0H3WiEtOo9jUNcJWZGNVHeTaLtwMgTu3Q1/3jNSRLkD4tNgXPtDOUesShAPnkeCxG9aiQAhqQYU
 9NGCqUUciAu/wQXXzCaFyk55fqIS/bTQkbwFN6oJ5n+9DeEtt/gXY67OW7giWfiYUubCv91FIr1
 EdUffl4GUovS4BLVW/yWvd5EhtCntfpjfpOrRFPe0F0dWCmBNZgFpRkJOk3Jkv0BWRgbEA
X-Received: by 2002:a05:6a00:1acd:b0:81f:9907:e503 with SMTP id
 d2e1a72fcca58-826da9070fbmr9950953b3a.16.1771960961781; 
 Tue, 24 Feb 2026 11:22:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd8cbb02sm11890643b3a.57.2026.02.24.11.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:22:41 -0800 (PST)
Message-ID: <e40d079e-90fc-49b7-bfbd-b8460e7e16f2@linaro.org>
Date: Tue, 24 Feb 2026 11:22:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] meson: Include various directories providing stubs
 before libqemuutil
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224182017.99865-2-philmd@linaro.org>
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

On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> Stubs are provided by libqemuutil. We want to use the generic meson
> machinery to provide stubs once, instead of per sub-directories. Move
> the 'subdir' calls earlier so when these directories are processed
> they can add units to the global stub_ss[] source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


