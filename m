Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEECECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniYb-00058O-62; Mon, 09 Sep 2024 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniYX-0004uC-Ld
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:52:07 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniYS-0008RW-Ca
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:52:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso4574613a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904319; x=1726509119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=valE2ooTflmcoTlMFRDa9BC5mo6aZUfVEoFZJsfXN5c=;
 b=sYgDzmRxNrGzxD2/NSMfK6lzsw43UhKWzIDpjp8euEXIDu7Y6jkAYR6mdimW8dnCfr
 iYEL/vQ81GZBPuHlzNRrqpXzS4KvYtLhMEViu0H+mvL3KsYhllXAzfujfDLREsG4nNqL
 slxfq/ySN2vTXg46wz7Wg81ON2Y1Nsfvgwa3CmQe+dgPKjZ9VNhEFVQ/wx6GVDhs7K0/
 Xn/enFEcnp0nJdwoUQiLQGbFwgR1c1O5HiVSODHQTszP9o35CHIno2uLEdkSKzOcgGwh
 nJvz5pZrwarZ02PxLz+N0c+na01GDZMkoILSQsHhJEBNePkX+QIMcuDVDUg7WcaOcjP6
 fHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904319; x=1726509119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=valE2ooTflmcoTlMFRDa9BC5mo6aZUfVEoFZJsfXN5c=;
 b=i629q/b3+ziLKbxisFZO+bgXE2TmNvDjKApa2xkAC8RcOrNJEOIDV86X85t2GWmeIQ
 vb7zv8mDyWz5F0Sxat/c9cYlweuEZu54LSvNbcSbYDpH5tgqwWnd+lcTHtp77eAZe648
 UbFqvt4LWgFIVyOk1WeI74ZZch6Aoqu8dnbojgvO7DRWAFsgj6SutGn1RZ1NIplyvpRF
 DS8nD61pcpItn8n+gcx844yLjA1D68HrQHw5lH6Th0rYHuNnnwqkeNiGYVUAFqVIMCiB
 YQjETG/CWSKOTW8ABh7LNKRuOF1jZCi8WIUHyCEYaKD5nLOCVCrPib+xyMF/eAk9tS5s
 gphg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8/pjU/1wTQID3I7sxqYqOlAhWtfQ3L5XQVc9jaIaOjBgAE7elvJAyObllAIRTsNmPzpHYzLCg4LnY@nongnu.org
X-Gm-Message-State: AOJu0YyTTptrobTbdYsLL7iPIfZifUA1uIbKucx8KWDszKyhqGQKUM2R
 gw7P1/9FoAV8iY+T5NsaSw54l8bbbdD9Qk2Xr09A9wnWWcNjnmgdD37qMPi8Yy2M9dPbUX/WJaP
 R
X-Google-Smtp-Source: AGHT+IG/1cQ1pTzMlowWLpOzpLHN+zfuIYKosEOchbFM6JY645wV3v9EX6W4Ne7mXUHI4CWSa7OJrQ==
X-Received: by 2002:a17:907:6d0b:b0:a8d:25d3:65e4 with SMTP id
 a640c23a62f3a-a8d25d3ef49mr607626366b.36.1725904318491; 
 Mon, 09 Sep 2024 10:51:58 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c74286sm370505866b.123.2024.09.09.10.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:51:58 -0700 (PDT)
Message-ID: <671feaa9-06cc-414c-a8d9-c8275a304e98@linaro.org>
Date: Mon, 9 Sep 2024 19:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 37/53] hw/arm: Remove omap2.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-38-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-38-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The users of the OMAP2 SoC emulation have been removed, so we can
> delete omap2.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |    8 -
>   hw/arm/omap2.c        | 2715 -----------------------------------------
>   hw/arm/meson.build    |    1 -
>   3 files changed, 2724 deletions(-)
>   delete mode 100644 hw/arm/omap2.c

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

