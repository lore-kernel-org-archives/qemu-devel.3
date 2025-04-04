Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104D0C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ggq-0001Fy-Fy; Fri, 04 Apr 2025 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ggp-0001Fd-6W
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:02:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ggn-0003EW-He
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:02:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so20254415e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743771748; x=1744376548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3mMtZvEujpV8jbEo2+n35IFUXmUmSOdjMBHOI9PDcM=;
 b=wcTtykxYoRqx+oROUfzbea9qBanFHm5DClI/lDuwQDshM/73g54AkemYgqJOFqcIui
 x/VsvSga6I7lGn+bg/wI5ySS4uqqh7lREMZch9zjCRVSozzdYU7hez1KTDD13Eg108Q2
 fpr8AqhmD0awj7AVP5L9r7uerTi8U+f0fCYxi7T91Jl0A7AUxhrVPTNiPNNfndvfVHgK
 qg7dLpCBNUqdAQqdthjplp7TSJ5ysUglm96iPHd/lZjtrajD7qWrgcRWRL+gWwCQE6af
 6w/LAnWAVLrDejk1eXlyQ7y2a5Oner3snE96Tx9Bwzi5zP3dil2/Q7GSvFeQhSxJ5YCM
 Yzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771748; x=1744376548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3mMtZvEujpV8jbEo2+n35IFUXmUmSOdjMBHOI9PDcM=;
 b=wgD8wfKe98O4WP7RocRu2VdKthxr3WP2TpTWHdMIacJRap4zKBkJJUmtuHX+8nx0Yb
 fsnw97Zxz403aMreWARx2hcP2PMbc2x1/xIROKEy5D3OhVIUAf+C47CAM/hM8Jr9MMet
 KSQRp45O8+VADk7Z1MTgkg3amEdNUt4Nuvtd1TJaNO9nZllmcyP2ztMST+GyjS5sl+Bi
 PCch5+culO9DkSoxWf6AoM8shMWuEUwmRuyqvNsZKHcyOs4fp3AqVUF0HiaER0ckDn2r
 lkgmOVtTPRnRA72Vdlb8mWTseQyb1BQhKnId39sOJo1hkljJ04Kijgtjlx8+ttfTllsK
 42Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9JNQjLgVKl12zVthx0MAoRyvwIWtLdRHQL8vObxsofUtcZ9XzZh4HDcxgcd53ZcECRCMIu0+xKLwy@nongnu.org
X-Gm-Message-State: AOJu0YwtH1E31rzCXYxc065whMs2x2gh0IKf/WHFL0oEwKeUc9yLR62N
 XY0CAyNTcThzsDrJiysBuIRiQOm5gMM5bJ0OhG5Q63h3puVJXoHbkzSf05T6eQ8=
X-Gm-Gg: ASbGnctBM72+Oe6h4tx1NLLeCL3Ii2BEM3vs5szMGpevWufn0T3clWeFWsC78PTW4HD
 t0jNHpEGirKh1pwSvig9lzPj0djQRMAdifJJ6sv/K6/kts0nPShFjSiV4efi8OhDtqsGTM8UbgO
 ZXgsAJFQhODgi+WTTKXwnGLUWy6lg1/XRxKRG75lPBQ5A8EwQlWNewyS0ZnB0zh5KXbsv2SwbLg
 nK8XVVsD/fJ5uLZLn3rndLeUCkhuCGSocuW4fAIAGAUsu7qrl06vrBxtCjwnhC+7/xLiwWPzw6d
 sVACec3rzhZrCg8rdsqz6pROQ3uIAyv9Sfedm+3thxucagfBz73B4m+HAcW8ehft2X4w1XhXemT
 +Drv89fGlvZTS
X-Google-Smtp-Source: AGHT+IH9n3Iy0Wp5ZHUKR3EUy1ogA2T5m8z0QcWKQ6AKaRy6xmzuDVTo77zadHHTGcz85OJgEZXZPQ==
X-Received: by 2002:a05:600c:a0a:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43ecf842bd2mr26031565e9.6.1743771747686; 
 Fri, 04 Apr 2025 06:02:27 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020da17sm4343104f8f.64.2025.04.04.06.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:02:27 -0700 (PDT)
Message-ID: <b2a68065-a685-45d6-b33d-1f86f1d7c52d@linaro.org>
Date: Fri, 4 Apr 2025 15:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] plugins/loader: fix deadlock when
 resetting/uninstalling a plugin
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
 <20250404032027.430575-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250404032027.430575-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 4/4/25 05:20, Pierrick Bouvier wrote:
> Reported and fixed by Dmitry Kurakin.
> 

Fixes: 54cb65d8588 ("plugin: add core code")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2901
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2901
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


