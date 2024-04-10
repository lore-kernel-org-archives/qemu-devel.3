Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC0CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSPW-0002jk-D7; Wed, 10 Apr 2024 03:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruSPP-0002Am-QZ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:30:15 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruSPN-0005In-SH
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:30:15 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5176f217b7bso464001e87.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712734212; x=1713339012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6a0AyuBt9tF0vgU4LfHtvzWxQ3dEICuSYekuHcUWePo=;
 b=IhvMZLW7q6yU7sjJdA1hgDDgSivsQLL5qKAkANcPmLKK2b2GF1z0UvN4s6p8udsFWb
 SOMZKrv5CSuPv5+SYGXdWDsqhHc2iexIpy/NL345H9jo/pzjmE+DBjkqtYTyQ81aHI9c
 xiwhLQTbT5wfNXMCO9QBHXQgMKrNiEvzql5S0q8ZN7yEQSf3GAPsVn2Z9hNlWQ+2t/bY
 vnKvGSsu+IXp2W5VFzIUAqhI2ecm17lti3N5KXO7KrSuYjZW3sz56pnlA8veuPvDHp37
 cM3Z76Db8kfouX2irWEd8PVdIH3XTZCIaLLi2df1qRGKg5gd8ZHB2JnV1Vmr0kRg6ghG
 V8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712734212; x=1713339012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6a0AyuBt9tF0vgU4LfHtvzWxQ3dEICuSYekuHcUWePo=;
 b=m0YwYnz2QKIcDlzs2wHvot9MFzFSIbmGNnmBa6rk4+X7/B2HMSJ98+FnKEoiJWXSFQ
 PKvhuN1dUfFCuL8wcyROKSWrdwtvZMkO7zlnzzAUBasFZa04FUuwMOnxzpsqL7yyMjEl
 Gj/AXfeo9TTcOYwq2hyOdgiM18kcuqWukn9AINIspzMAhrtk2bJHq1UAHIpf+kAb1pdS
 JsvZ6D0UbVe89R1p3dOVMkKtHa8FlgBVLlV94s57NLdjTP83NadtnvbEqTxPNWLJZFuw
 O3iydWrUDFJ3/l50F0l+Zgw3HMs9KdG/hvCBWDFzeNllw7FXhCDfZ59+bX5hApm8jn05
 s9Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvKmrxyxwMdrPSrp/rgH75lhORLWVn8dU3xz+W8Z3GlZNvLj9FO2nXIinyg1tsweqosB2BmJ+HMDIKg1eTgJvvn19zefE=
X-Gm-Message-State: AOJu0YzUo35zBGxMP5E5A5tOQz/yJCr1JG6A6VtBRlJ5rZOfonxtZH9v
 YRsCUZVfjNQo+UDmx2AOMVLHdb63Tq3N3DNi1Gk35WbJ2XdSFQmIGqW7gMrYC6g=
X-Google-Smtp-Source: AGHT+IEqGC82B21+coPmwyfx/iGeKv5U6UnMNApgYzyLYp2wOJUWsmXaKEjvCI6zYhnygJiKnxuqDg==
X-Received: by 2002:a19:ee18:0:b0:515:9c73:e29a with SMTP id
 g24-20020a19ee18000000b005159c73e29amr1194483lfb.66.1712734211727; 
 Wed, 10 Apr 2024 00:30:11 -0700 (PDT)
Received: from [192.168.69.100] (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 pj27-20020a170906d79b00b00a4da28f42f1sm6714142ejb.177.2024.04.10.00.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 00:30:11 -0700 (PDT)
Message-ID: <6e459ba8-9cac-4774-8b6c-fdd87130a7fa@linaro.org>
Date: Wed, 10 Apr 2024 09:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-devel@nongnu.org
References: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 28/2/24 09:06, Sriram Yagnaraman wrote:
> Due to company policies, I have changed my mail address. Updating
> MAINTAINERS and .mailmap to show my latest mail address.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)

Thanks, patch queued.


