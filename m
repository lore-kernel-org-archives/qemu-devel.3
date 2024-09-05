Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B4CD5BAE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smB1m-00052u-5m; Thu, 05 Sep 2024 07:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB1l-000524-Bh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:51:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB1j-0001w6-Pt
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:51:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bb885f97eso10217555e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537110; x=1726141910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g1RPH4G/jecz5xS6t1MJvinb0vzJwHEK/hgmd7/HqFI=;
 b=jGwQzRFy5/ndF9EcFBMnRlVXOKLCnuGqRh1bH3CJ8Dz6LfrQlzhJ4ugBkR0WRRWJUT
 mkEjoBQ/rw7R/0E9uUIimUKSLW6auwVvn1g13AP46NGeNcdYsN3EluuwlHozeQuK+YXw
 y0HlKGo57W4PcgBpUiIYQjQ2AyzPFhzZDUgImmTa86+vP0M3+QhPvaRDFuLqs8+tuYre
 gX+zXigJ8sRuRcIVnsP9cLadg1V2Vq9T5SxksBPPNSJNFwRfQQPgSGT6KWDt9C5mylKy
 mfHPBe/gvxgLiNlQOX4mbOVEp1L1mchPyX3RjO/W/NquKRagmvui8j20yMr6c4v5+aM1
 lS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537110; x=1726141910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g1RPH4G/jecz5xS6t1MJvinb0vzJwHEK/hgmd7/HqFI=;
 b=uxt+XtPPFXLGh1NT6Z1266E8ouQ0WLnhuhaHaWd1uU/2qR/j1/FrTc106KUe3FiMrC
 fUNdjaebZcIVpLFlCk9Y45IYaPkW45GL/u3BDNcp+7KB14q5LaXxAO/dg5DOBABt+ALo
 39qi+tp6hmoTw4xmrgWtTcUvQd1tKCM4AbDPD79/faPOdy3Jnpz83mOIAuhS8WaBjmD6
 SV3bF4N/9UFfKXPC52P+vfKEK7bAkeRboYNF05obJLuejle/5JQI/iCifuPx/ZupxUPh
 C+/fRUefuZZEC84IPmH1voGcPEGA8ZKp5XZYwFTaOTBi8ENn7kdWsvyIwPFS1ByDXHO+
 GVqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMRGZcb9uN+kPR8IuAMkwEQk/7hXqCJlYIEoLDXCwwH4rUgmuuZDACqkeTUm6VQh7241tE6K0LrPq7@nongnu.org
X-Gm-Message-State: AOJu0YxIYUIB0iqrqixkP0vGRCMICdBSxsE/BiyUWvW7YWTjqmEPiZPs
 WLVP8NLMZ4/1i1sc0F+ypxKffJU7i+o4IISh2DW5xlkB5MGXBL2uw1sY2i6s4/0hiEeeZzN+/YS
 Bt9w=
X-Google-Smtp-Source: AGHT+IGQ+aEWbV5NtpydZupddDjyS/pdH1ZqvZ5Ae3h7iIBrGB9ykiUu4UfXGiGOiazr2rGJ2Xlbsw==
X-Received: by 2002:a5d:4601:0:b0:374:bf6b:101c with SMTP id
 ffacd0b85a97d-3779999f893mr3152625f8f.7.1725537110008; 
 Thu, 05 Sep 2024 04:51:50 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639643esm272244215e9.1.2024.09.05.04.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:51:49 -0700 (PDT)
Message-ID: <97d6e91a-d0ba-4fe9-915c-891c6175e073@linaro.org>
Date: Thu, 5 Sep 2024 13:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 10/53] hw/arm: Remove 'mainstone' machine
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-11-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-11-peter.maydell@linaro.org>
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

On 3/9/24 18:07, Peter Maydell wrote:
> The 'mainstone' machine has been deprecated since 9.0, and
> so we can remove it for the 9.2 release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   2 -
>   docs/system/arm/mainstone.rst           |  25 ----
>   docs/system/target-arm.rst              |   1 -
>   configs/devices/arm-softmmu/default.mak |   1 -
>   hw/arm/mainstone.c                      | 175 ------------------------
>   hw/arm/Kconfig                          |   8 --
>   hw/arm/meson.build                      |   1 -
>   7 files changed, 213 deletions(-)
>   delete mode 100644 docs/system/arm/mainstone.rst
>   delete mode 100644 hw/arm/mainstone.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


