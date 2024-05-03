Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE273C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oXz-0007iV-7D; Fri, 03 May 2024 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oXp-0007d8-43
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:45:30 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oXh-0006NG-2a
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:45:28 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so64312021fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725913; x=1715330713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wCzUNW6nPsC+GyKFqTYIq0UyaATMEh6qxKMWeiyM1v8=;
 b=A3Gw2DC5iG4xIYWiUA6hYouiFqHeOU/X3CvRf4ed9WF9fuMAw51RzD6jyPXPnT48/T
 Km2f6PmoNB9+SpEkSAMR/ARtZv/TV23uhiRn9P11byG9qFM1ZUEZxPIN5qwZ0H9LXgNl
 Po1SWHt4IFqEA0zTqdaJsJ89rFh6bGw9siH7O0VcVfdR9cIiCnsamGsjjIiuB6/4WPkz
 lPoLcrmc/7kpfHJ5tPEitNTDFZSiV9TrAQEj5slImQT7IVqh/4dinhi1zvyPN0QgY1Sm
 EmJTf8KaQ9Rup4aFeTCqFwPe1zlw5u2AKoJVcVRkTJsXmKjUXYadTlnjqQeH3FPgMSGG
 GDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725913; x=1715330713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCzUNW6nPsC+GyKFqTYIq0UyaATMEh6qxKMWeiyM1v8=;
 b=TgSeARg7KUNBRYzqQ4jk+v9xLeXZO42N33ey1olDRFPcgW+dEDckxOZ/E55FDCCjzt
 5PmrvTLFmP5wFVfQaGZ1c3+AzWIQy1Ml/SleyWOEsOrCMs6Ra9t/qaIZWyajlBZkKRG9
 cr0Jn/UYUDYVUX0UZ4FDcsUST/d3lKPXDkI0Wd3fKzpVdf3isFeQ7Yv7Nd4mCMFy2n12
 6yCPqu1sIotHGqAcjxtbjjO0YgrB4DJR48hNkVfA2QlaPpT3ml0O6z01x11FcY7NTMLj
 aPz4IT8b+wDNDJdZ2ggf0E9QPB6iIy8kAcRfwRoLwxSkaPI3sgvhqmaj01YO1l8PFH0M
 nH6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ExFwRhqkUTdjwOcw3ePABApdH2aPZgslPJXVxrovIAfSkBeb+jlt6C27xEunLid1HQK3Vp43y0eIiT7zwKGzj9JyRsM=
X-Gm-Message-State: AOJu0YwLKX1HiPSdvD4Bb5t7RybXCGj46n7LeU35o0xlWHPyY/KnYOa5
 zLfJ6h8nFx7uCwoAqXCa8Hp1woAviRgiKgQAnacRD39svWTaLQA9Gb+c4cwDVGY=
X-Google-Smtp-Source: AGHT+IFbHjz2BIbIu5u3pqDXL8bI4yWm1r88MlIxmcLimIDp57ut+yQBJ5VJKfWt6d6wkkaJylub9w==
X-Received: by 2002:a05:651c:2045:b0:2dd:3803:e1da with SMTP id
 t5-20020a05651c204500b002dd3803e1damr1636475ljo.12.1714725912768; 
 Fri, 03 May 2024 01:45:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b0041c542636bcsm8536088wmq.44.2024.05.03.01.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:45:12 -0700 (PDT)
Message-ID: <094e9261-7a8a-40a1-818b-bc6f3e2e11e4@linaro.org>
Date: Fri, 3 May 2024 10:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] qemu-option: remove QemuOpt from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-6-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> QemuOpt is basically an internal data structure.  It has no business
> being defined except if you need functions from include/qemu/option.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/option.h   | 2 ++
>   include/qemu/typedefs.h | 1 -
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


