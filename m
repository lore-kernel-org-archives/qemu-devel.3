Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVu5a-0006cw-8j; Mon, 22 Jul 2024 10:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu5V-0006R2-7a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:32:29 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu5T-00066u-JN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:32:28 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ef2ed592f6so13339281fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658746; x=1722263546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oiaCfjshe58+J8gYFfIHHnHyJqFDL/IqBecOq6O6qg=;
 b=pVAfKhl8T/krWm/NlYuwMb06Q9qbTj73kunemZEAT0dGlea3CSt1A9foslsGm0tpbo
 LMxDrnpz6GnPfxkINgpsunbcTjv9O/MDA0YpfYhtifSCu6MX1dL2oGWuyK/9AW7WyB4c
 mGeHnOnm1x2MuRTiuoAKDNOrWnyOoJsQWIyt3hd1C0OkNtumE0if0RCmsbx09h2VxVaC
 uPSd/f2XRIy5mgn7xaEn/QmdwPd+GxhySKYQeHsJ8LY6onrVe+JWB5oM3+pR6xfOC2z8
 VfruiAFB6bW95vmB+CH0VNLqfBGdN9VYLY/KZxG5k0DDHtumBWB3fv5HCDKsad2vSo4x
 MV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658746; x=1722263546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9oiaCfjshe58+J8gYFfIHHnHyJqFDL/IqBecOq6O6qg=;
 b=QNu+EZcTC/Bd1rqLCRRBmUPCIf8DisN+XhzCup9RBMjMoLfCfScyeYAYQyhlOLr1Ep
 6cE1L2tQiNHYzI+XYSEtvR2XUXWjjx/pB7KkU1REhsyC0g0VWYg6Oiy9MqlnWMN4KOb2
 KZoxb8qkV899JQuXK8F18g/Ryp+/B0j8AO4ecAOHh8DWusE2s7vegTQ6UXnR3klR85/P
 355Z5aBDXGi2NUubQxNAEEhZytYLzS1A4PNGunIyC1yfe90OosM/Gc8vJfQ20xFIWqvh
 AMo/NnwNIcL4P11GOgzG7e3SGaksF+AK49p/sGtCCIgk7BZ8xFTwlPdpF7XhqxvzQzWv
 Kccw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRG+M3NdFHB0GVVz08dC2mkcSNUd6FdSfHIxcFowPSYtofmgPgW/EhSYu6a5ORCmQAnSCYxd5sAG39C2WX2SbNUBLvnR8=
X-Gm-Message-State: AOJu0YzQFHoTHBW4/24w16oHh/hyULuYrH2epzUPE5A9ervcehGRUp37
 56OARH9gqbdJSV2BNgIMz8Isy1sC22WUhhzdHq2///PpYmQFa47BjGQy5EwvJ94=
X-Google-Smtp-Source: AGHT+IGc2Q7dyNhC0WLE7knltYRYpKVJ3TFV/y3kr9e40xhvuQleqAhfkQL66yVnhV69Z5HKCuV1Cw==
X-Received: by 2002:a2e:9586:0:b0:2ef:24a9:a75d with SMTP id
 38308e7fff4ca-2ef24a9a985mr39232171fa.14.1721658745716; 
 Mon, 22 Jul 2024 07:32:25 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69073d5sm130290335e9.25.2024.07.22.07.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:32:25 -0700 (PDT)
Message-ID: <466f4899-0a07-4599-8b0d-07c4a8c759da@linaro.org>
Date: Mon, 22 Jul 2024 16:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] crypto: drop gnutls debug logging support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722131611.2820041-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 22/7/24 15:16, Daniel P. Berrangé wrote:
> GNUTLS already supports dynamically enabling its logging at runtime by
> setting the env var 'GNUTLS_DEBUG_LEVEL=10', so there is no need to
> re-invent this logic in QEMU in a way that requires a re-compile.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/init.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/crypto/init.c b/crypto/init.c
> index fb7f1bff10..2d6dfa3091 100644
> --- a/crypto/init.c
> +++ b/crypto/init.c
> @@ -34,13 +34,6 @@
>   
>   #include "crypto/random.h"
>   
> -/* #define DEBUG_GNUTLS */

Maybe mention GNUTLS_DEBUG_LEVEL=10 here or in header? Otherwise

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


