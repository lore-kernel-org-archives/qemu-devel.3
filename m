Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C83C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXG8-0006Nf-1O; Mon, 10 Feb 2025 12:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thXG5-0006NH-4O
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:07:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thXG3-00046Z-5O
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:07:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso75679005ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739207261; x=1739812061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=es/buT9jK7sjcUKyx3iWTrVdUIyDmiwIom5uEP1+hL4=;
 b=od9QfmClvhoaGckFsi6okYBjnXI3Cg1ICTBhsuhKXB2/6vsrltLyk8aFNHUVQ3qoPj
 AldIzrN4KE0U2t+nYXymQa4wKSER2Rl2pEUYHeFgDZZPLi6IzzyYzzAwLh6VfbWmzmH7
 H4XBjhszBSWuBkcHcxy+B06xm5kydUag/mmryGtl/5pPLYKBslSVCYLDOZXo+zCJvyQl
 VAuPNag0eNumxRG1k9v4yuW8S9oZcDIcZvcHCWa1WsXvu5gCgrEiXvS8j94El4Jk+7xt
 LcJjEjBaqjVm97ao/hUf0Sja9gPliO0jM8hcPX1u1NnjYArPS/9jhO3sMJY+Vbwa5IQq
 rMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207261; x=1739812061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=es/buT9jK7sjcUKyx3iWTrVdUIyDmiwIom5uEP1+hL4=;
 b=g0g0ofCEvGC44uZGBj1KR6mEoeQ8AhAz+7X0SStDxIj9PbUq+wnhsDJqoRdgIaCOOU
 Kw+VLj364+5kc1sC6P9iQWm+v5wH8eHiPOyjTkjEq87Uu6rhL1y4epCOD4RO4xwU/cjL
 vW4gBarxPEbB4i8xtVgqTLpaEMYrNtf/RvJvYYuT3AoLAWhJZO9QSucp6YZ5UPIq9yhL
 BGeco9NWkDSOm0vzEQaGfgWarCkJYuSDcugjFMzbcjHmCUQoyrKRBqJy48xYIAEPNmEX
 DKZjaoICOwZZ6Bn6A486Ahu/ajAxYTkxZaVRLLMOtwHzxFEPyGSsVp5Xq9UlFEJOFBrw
 MsEg==
X-Gm-Message-State: AOJu0YwmL/Hd/8EMmLrVCCphev7rvzww+w+/R/TycXfeiVzR9zN+E4tR
 dKZXkMJWY7UqUiIJnyARXNg8dFuZ+ROXyspGuGAP4IrvxZr9zApQdLV2SUsuIHMdsEtxmTzGKRH
 n
X-Gm-Gg: ASbGnctQcuRtoY7quakQ4j/Ktez61/PYqIll99cP9YeVUXHRKw01tEz21nPD2Pqyrxk
 +dY3/nhsCZoDS6MobEfbwI+qngxwxIsJaa3Ob9W/2l0Tg+KOv4T5G+wPraHkKvFmqH7QlxI9AEO
 da5bQB2rl+r1RO6ijROsL6bWoaPkCx3o9sJvvQ8QqKb9kWS3wzJo21ijILnqHpZJA9UXvvBEo9M
 phPHxWPn7kPGvV2Pdl3/Q2x2U595KeVbRuQWH4baoikQfb3DUb/+oX8SG5XkGK2QkNaq7gLasy7
 u817aGy4sNiDLOW51drLdpGaRfILrAd1fniPYtjHhspA8Hi9p3tSFT4=
X-Google-Smtp-Source: AGHT+IE/BowXWSlkpOrunTGggsDEjc7bY5XUEc6VWKl9Ot0lV7FUttxFLw1MCqsgNMJyQZpeDzOn5Q==
X-Received: by 2002:a05:6a00:4883:b0:730:75b1:721b with SMTP id
 d2e1a72fcca58-73075b17628mr11266118b3a.18.1739207261250; 
 Mon, 10 Feb 2025 09:07:41 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73096da6e0bsm1431981b3a.28.2025.02.10.09.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:07:40 -0800 (PST)
Message-ID: <095019a6-04ea-4463-be79-89286719df61@linaro.org>
Date: Mon, 10 Feb 2025 09:07:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev: Remove pointless NULL check in
 qdev_device_add_from_qdict
To: qemu-devel@nongnu.org
References: <20250210121045.38908-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210121045.38908-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/10/25 04:10, Philippe Mathieu-Daudé wrote:
> Coverity reported a unnecessary NULL check:
> 
>    qemu/system/qdev-monitor.c: 720 in qdev_device_add_from_qdict()
>    683     /* create device */
>    684     dev = qdev_new(driver);
>    ...
>    719     err_del_dev:
>    >>>     CID 1590192:  Null pointer dereferences  (REVERSE_INULL)
>    >>>     Null-checking "dev" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
>    720         if (dev) {
>    721             object_unparent(OBJECT(dev));
>    722             object_unref(OBJECT(dev));
>    723         }
>    724         return NULL;
>    725     }
> 
> Indeed, unlike qdev_try_new() which can return NULL,
> qdev_new() always returns a heap pointer (or aborts).
> 
> Remove the unnecessary assignment and check.
> 
> Fixes: f3a85056569 ("qdev/qbus: add hidden device support")
> Resolves: Coverity CID 1590192 (Null pointer dereferences)
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/qdev-monitor.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

