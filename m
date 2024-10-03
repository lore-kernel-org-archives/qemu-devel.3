Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599CCF34B9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9Z-0006R2-MZ; Thu, 03 Oct 2024 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9X-0006Pi-8F
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9U-0003Rh-BK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so10435815e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970843; x=1728575643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBITSJDqEpI1h+gfmHH74Tl6nxhef0yH1QKQqXa5NwI=;
 b=kSUY0/Ho9yWyfBPN/5ieMfCweqHgbNQJq5GCmtBrL5N+jGEf0HHRRCxvzwEnjEeVzD
 1E+DjLsXhS7AqaHqXNbZs6hUPKXXwDycrZZCBLntWegmpIVWR68TA3n87hkfuKqUxstW
 TWViuq73vHJ8IIrM22ia/Muq0RyRCVtJHeoIzGgDQjD+rfayd/2s5oYIyEj6pw9sGzt7
 Zcfq37L+rSFgL6wG75dVzTbRk4JbKXQqLHJCXwYVLcHfi0I+pPloac2qkAQ/VzAokI2W
 ciROc+8Xxz0XLkbdnH49sImjw0NTOeQhf3NLkjGGvSOIFKjzpO463K6wK8/NbprZBDxg
 gaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970843; x=1728575643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBITSJDqEpI1h+gfmHH74Tl6nxhef0yH1QKQqXa5NwI=;
 b=prF0WiFYa+EQ8cAmApnOXelNIq5Z/5Ca3LmGCI8tRwQREk0SHmiL4+prinw3BVX775
 dp9Z96WmNhhhGpR+Zplq419lBX0wIU23uF9gvsdZqlfk+E98kXzFEHSqricUD7CPN4mN
 kcOR7yFCOKNsz12QK3nQteWnqvSLn+ArrkwapFf5Ql1IPwONFfuGcomOQq4p1AwnFSTN
 utURIijGIGLI+qrxid0YMN46/XRwiNSBk1pgz4Tmj0Z3kyP5ibQJQUCfyTErF+njCyG8
 qzU/hw7pVAZ8VQiT9GGDlzYscBv3Yk1jF5sVokvrCK98PypWe7kjAXZha4nNVF0VqatS
 yRSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/5GRuMnFzaeUce1pPHmKTiKd/WEgd9ZoKc9IcqTd40Y2TtDP+Tyf1VvJTEWyaCq7wM8lHmbuIIGo@nongnu.org
X-Gm-Message-State: AOJu0YwRgD60izxm59ZwsyeknuBNZt3vnmFWaXJ5nHj4fNc5JZ01Fy6R
 R8A87ZtBU/BNaJlvJ5GjjHsOo8/BrqtkAYemo5q2tML3oyuThuhsU7/87Svehoo=
X-Google-Smtp-Source: AGHT+IFxEOqz/21Iw2BHlA9EvC9stXPnGZ/SVnnb2ODdk208uxRABo48bpZt0rGtvwAjvUm9Y8KJYA==
X-Received: by 2002:a05:600c:310c:b0:42b:af1c:66e with SMTP id
 5b1f17b1804b1-42f777b6d0bmr56888285e9.9.1727970842832; 
 Thu, 03 Oct 2024 08:54:02 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:54:02 -0700 (PDT)
Message-ID: <eff57418-917b-431b-ad2a-4db76de7bdfd@linaro.org>
Date: Thu, 3 Oct 2024 17:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/block: Remove ecc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
 <20241003140010.1653808-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003140010.1653808-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/10/24 16:00, Peter Maydell wrote:
> The ecc.c code was used only by the PXA2xx and OMAP2 SoC devices,
> which we have removed, so it is now completely unused.
> 
> Note that hw/misc/eccmemctl.c does not in fact use any of the
> code frome ecc.c, so that KConfig dependency was incorrect.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/block/flash.h | 11 -----
>   hw/block/ecc.c           | 91 ----------------------------------------
>   hw/arm/Kconfig           |  1 -
>   hw/block/Kconfig         |  3 --
>   hw/block/meson.build     |  1 -
>   hw/misc/Kconfig          |  1 -
>   6 files changed, 108 deletions(-)
>   delete mode 100644 hw/block/ecc.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


