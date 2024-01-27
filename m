Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A501AC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 05:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTauE-00005G-07; Sat, 27 Jan 2024 00:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTauB-0008Ve-FK
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:06:59 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTau8-0003mx-TO
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:06:58 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bd562d17dcso789224b6e.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 21:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706332015; x=1706936815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1nJtLF0cT25q/gKi4XZWH3z/BW/zLAEPFHOyGYOPht0=;
 b=CBwKjbTrcdoGFFP6RKfkwR1TR6KwL2QpMxK1QIv7dMr/VENAy9WMF3gr+DaKDexJea
 tYVkmqmVcMC3AiH3C4tTahO3diXHYHeYcAiF7nUhWA5kaJriDmQaPsUGV51cVzuuqAJ4
 rL6Ejmmj4+Bo+1cERYl5ny1HwNwnu0WyJN/LRSJlvQvAl6oISVTJqfChbbiruv5QxE84
 37/icmm39QefiDdz0hvNpqPq5GojDZrR9QzZZqVX6qI9cX5D7CfiBp1TJC737a3B2GvV
 KOWrUM7hEZYLcMPcxgTGsIEKdxzi9Hf4c24S4n+t0hq7KJz8Nr00ynwvGVqjz9F7ooWX
 FCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706332015; x=1706936815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1nJtLF0cT25q/gKi4XZWH3z/BW/zLAEPFHOyGYOPht0=;
 b=VLF9UlgO1noey42c82/edHDwAAtl3Z57s7xmx0NnZNlppkKYQNTA6nO47n60FYh0qG
 PLzBV32Yodr7dhm+VdIKIM2tliNlymIUsIZBw0gGDnRF5CzcMpHu9/E+hoC3y7M2u0gP
 /sTsmbm5bqnZKj5KY1TiJpwwDZSQxFUwMEnnGs3RH379UZt+vIjjYCUj5K3Ln7b2n3EV
 9JlS+NMfGDEcwEo5g77Mw16JYTUrLgmqQlq18Z+5sSfEBR/FaZwzeJe8WYm473n6sekx
 Q/mccn+mq66jsu2TNljaEtxzYs5s7HXlI4bnabizCXBVB/ueLAEZ44nFVYjQZuH0FuPf
 XO6w==
X-Gm-Message-State: AOJu0YwO2lUOgehXUInJHiXItmsNV1N56xT3lEpCbGIp/5HuCz3ayGZ5
 xPLBFNZ940v+vx6xZamld66weIhxIRnXO9tAewcx/pmT7nZbr5JUhDa/6ydokag=
X-Google-Smtp-Source: AGHT+IEzlKzdpYCfL5ewhOStpIO8bg8IUnbWYW69U16rzQ4lB3gLy8H7y5EJKXW5ISpFrvYhRZrI3A==
X-Received: by 2002:a05:6808:13c6:b0:3bd:dd6a:b02 with SMTP id
 d6-20020a05680813c600b003bddd6a0b02mr1348587oiw.48.1706332015508; 
 Fri, 26 Jan 2024 21:06:55 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa78683000000b006ddc14c416dsm1974542pfo.95.2024.01.26.21.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 21:06:55 -0800 (PST)
Message-ID: <08cf813f-f4c7-4b81-9de8-a8058e03e1a8@linaro.org>
Date: Sat, 27 Jan 2024 15:06:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] acpi: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125163408.1595135-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 1/26/24 02:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git acpi include/hw/*/*acpi.h hw/*/*acpi.c
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/nvram/fw_cfg_acpi.h  | 1 -
>   include/hw/virtio/virtio-acpi.h | 1 -
>   hw/nvram/fw_cfg-acpi.c          | 1 +
>   hw/virtio/virtio-acpi.c         | 1 +
>   4 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

