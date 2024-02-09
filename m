Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BFCC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYSvA-0004TG-RX; Fri, 09 Feb 2024 10:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSv3-0004Su-Dv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:36:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSv1-0000QS-Sf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:36:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4101fc00832so9201495e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707492958; x=1708097758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FH6p1b0OrgiAK8rwF3pW3h0nu82Os9utefj0Zmd68Mg=;
 b=bcVb7k1CVvGJBV1Fw9SM5tS3XhiVdrkg09VhKypUSTV2JJIJXOqq3cSf+C1lYWmzkW
 NRWD9P4aRkmL2hNSASEtjN0ruwXEuRPK8gn5hk5My5d1jx1A5vpSIhe9Ra8YqrUalfIT
 b1dSobjN0jvNZHULD/rvg9UARlVt/xY17f48UCEu0Xnu7ARVSq+WlxDNTeW2JMM6RHV8
 ANXR5EUm7qsVl/BD0+2CJQcG0XGPcbTevyZHVfiQdXyYRCON5ufoyU8kuRKD5+YWSZHT
 fiihQRLwgHF2ol0EP3VpcE9MAOwKMT/XHY6LtBxIubfTpglQlb1P4Iri5ImXxwvGxift
 2z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707492958; x=1708097758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FH6p1b0OrgiAK8rwF3pW3h0nu82Os9utefj0Zmd68Mg=;
 b=ifg6vY4jU67MvHMdJMcED8O1lFe1P5BDY/Xk6J4h4SGd/MlQI/sKIhIQIZ+0KR4Xn3
 0YpPV5ha4P94US1n+b/c0vCXt0ljJs7F6v9fPSS4Dp3U5PGCw/+aeN7sFAf1unWVZ8jn
 Qf+hOGVeZWtIZhGIU4CW3bUsMPMyUPhJB+04A5WvvSfq92OarRnxMLnHxWbWMalDSJqJ
 6wX6xT1VdPjEqbt4rrqcf8+yZsWK78pZbM66EdCraVdOA/fGsLxWYy9r9oJKWgZFeVOc
 4YI0gOBQOX1N8VC+/KLKlTH5aAcKYojDYqufh9dicS/bMoQjfZt5sEjwriIYa53RA78K
 0B+A==
X-Gm-Message-State: AOJu0Yx5VAB+pTMg1ZLDg0zhUsqrCShSAc5Zin3TveKex9Pye7ByKtJs
 PEkLIjFCOsNTAux3Wyv+smbP3b9OeLFMt6mJ/STX0Cr4kPXbJb4y3yMuOArTwOi0EE6NIAc6Sq2
 9
X-Google-Smtp-Source: AGHT+IEfPWgN4ECicFM+WYxuRwFkaUcS3TTxL+hkSykqNbG/s/Jld1ULaVEWb5Mrns7jFWollgsy1Q==
X-Received: by 2002:a05:600c:510b:b0:40f:ddb8:c854 with SMTP id
 o11-20020a05600c510b00b0040fddb8c854mr1697332wms.28.1707492957963; 
 Fri, 09 Feb 2024 07:35:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c204f00b0041044e130bfsm946512wmg.33.2024.02.09.07.35.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 07:35:57 -0800 (PST)
Message-ID: <21adc235-068b-4375-b78e-db992a378d06@linaro.org>
Date: Fri, 9 Feb 2024 16:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] target: New binary to prototype heterogeneous
 machines
To: qemu-devel@nongnu.org
References: <20240209152945.25727-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240209152945.25727-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/2/24 16:29, Philippe Mathieu-Daudé wrote:

> This binary will be use to rework QEMU startup code,
> paving the way toward dynamic machines. It might also
> allow experimenting with multiple TCG target frontends
> and possibly prototyping concurrent HW/SW accelerations.

> v1: https://lore.kernel.org/qemu-devel/20220215002658.60678-1-f4bug@amsat.org/

Supersedes: <20220215002658.60678-1-f4bug@amsat.org>


