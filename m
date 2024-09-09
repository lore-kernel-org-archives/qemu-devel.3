Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75459ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniSE-0003kV-Ph; Mon, 09 Sep 2024 13:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniSB-0003TP-5R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:45:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniS9-0007rO-MO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:45:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32971cso5622401a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903928; x=1726508728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FoMJ3clP4pcYGuRSrv+LpDsQep1nizNMp9QeNGBNkkw=;
 b=lYM6H7ebHpzwL3GBU2KA/gzVC6ShnYQo117ZnOfbiiF6v+CMg7QuIvvSXZSjqeU4io
 NML8iIJgOktquaGLgPahd+FJbzY9LzLI00vcPcgO/nYjiygJBqCra8BGsQ54tbW/p1uP
 IhJKIC3p28kmu2RUjkd9klHZt8pLYWhqgTOWCgvh0EFEpKcPxJx04LyUcdpWi8j6wWBx
 ARYUB8OqW3PXsKlkGwpRgXVimsy3zvDZmHXZuEBZbw+RLaBCYlpglnkKasgpEDtqJrDC
 sss7bVan+VHEsf2DmcadAO7LjV1zjPoEAqg0qGoBHS6jRbLiAtIG+gvgKeQSaeKBNZIi
 tXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903928; x=1726508728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoMJ3clP4pcYGuRSrv+LpDsQep1nizNMp9QeNGBNkkw=;
 b=BLoErESaLRg6ZG06h4z/T2Ajn3s/YrNF3bGuSZSerrxuSHu4b/B5V3c2tmxuH8sPEx
 Jx++STuZhaVS8bOVA6pe1HmpbSZqniiUKlD2j/ESSUpaTYLydxGDA4rgnw67mvVvGW5Z
 SOCAfBOy2IONnFKKACkdXIxC50WaUaLlqHhIKQwyHXDVl8VDOb+mw7LXtbB3QP4yim0y
 Y6ADDJkwq07HSLQbo2cn/GMj968ylAK6IO9GcL+rWI0hGJCf1wB+IjnGTHxvcYAOBXGR
 cQh1K+nAim8ivFHpROu5/kiGGYRIA+yk8cwAHIsYBUmpEemgLds3PFAiWVu/sJbx0upw
 V6hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhNOfxC5vIAY8LnwAAK2lfoTqiEFwvOXTfJF/zgqLC0co+PznIm8GD4A4FPONkfEeAeUww2mfBkmR@nongnu.org
X-Gm-Message-State: AOJu0YwpWJ7TadIunnAT71swTnUpKuI/69q3ABQiCGdbllnHdMvDNjnt
 QSKWRNBo6FHJL9cbF8AZ1TQBwVnuxK05GR4Hn/wbI5gCQHZlOV7w0QpJsRzdvg0=
X-Google-Smtp-Source: AGHT+IHjetM7wywAlAjL26Jy94KcIAbgPJ83SYIYkXVu6T8m558f1djPHxrFhmEzl7xxq6dhPjmj/w==
X-Received: by 2002:a17:907:86a8:b0:a8d:555f:eeda with SMTP id
 a640c23a62f3a-a8d555fff37mr362356366b.8.1725903927967; 
 Mon, 09 Sep 2024 10:45:27 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2582d490sm375761266b.14.2024.09.09.10.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:45:27 -0700 (PDT)
Message-ID: <53d590b9-7bd4-4145-9ee0-88f4e7b4e230@linaro.org>
Date: Mon, 9 Sep 2024 19:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 17/53] hw/input: Remove pxa2xx_keypad
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-18-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Remove the pxa2xx-specific pxa2xx_keypad device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/pxa.h     |  12 --
>   hw/input/pxa2xx_keypad.c | 331 ---------------------------------------
>   hw/input/meson.build     |   1 -
>   3 files changed, 344 deletions(-)
>   delete mode 100644 hw/input/pxa2xx_keypad.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


