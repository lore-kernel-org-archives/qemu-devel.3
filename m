Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB253C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uQe-0000Re-B6; Fri, 03 May 2024 11:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uQZ-0000LG-My
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:02:24 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uQW-0004m8-CC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:02:23 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51f0b6b682fso2615311e87.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748537; x=1715353337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qgiVUmTPVQHfbTGLEwOem1XtYi2gfj0XcjeGdV05HN8=;
 b=ZvRCGBsNXMEQYY8dA1VsMDKhHrf1SNIDkQ3r4zJ+LalUxloCZCJ6lWEeM5CnePjAAQ
 RmBi5dQbfoiAPnBWeK/iXJqZP0fNHeHczYq4HGnjjTiH3wCdhvmTJcSX3F5NlnQy984T
 n6vyQuZokxPrhjccSW7znD8H7zhA0lPKjsFJFX26aZ7sddFNFFTzfjAwyJWji07CcV/9
 aM2QTB917eDoVKBuRUSzayQGkCXNZmTO/DJfX6RZZddSN7Ncfb4qZwg41KqwMYx+9sxT
 xDHpeqiMul5vudCeIxHm6rzGEeBQ5Yq8ei+ZmV3YTh3Vs3rp8rlpqul4mnmYu+xKRXxf
 qWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748537; x=1715353337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgiVUmTPVQHfbTGLEwOem1XtYi2gfj0XcjeGdV05HN8=;
 b=TL8MkW6KFaBos3RpTkWFVLZZUHxjxHPMjfyDGYHg0wCOCLzJiYm0I7C94PmnKlY/2p
 8t6vUYZhMfFSP+hE52/7Aik6iz5AjWV5a7qsPA6N6aPCKHZC2AOy/Mui6ZYuIs5WfELx
 0R0ZgnZpX1uDSC8aF/bYG4OP9tSYF0PA9LxgppqFCTkci8/QUy84N12xgMEyf+YM62Se
 GxFL3X58P1GbrTryQT9XN6l7+HA+KaPqe3+1W8Mz2vmDTD9gGQI8GO3NG4ej6yoPb+g5
 P+AqMDEcHZ0/rcob6Z/gAj4Zhi9YrrEQV9J3GvhgyjsmAJz2eiGiEHD9G8MCMBbVyLW2
 BeGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYJYcxiPgFC5sCiK5INUwcs9sVijIufCUidpWi/HaMmAdj+m5sNAa2TAPM3vl9ZE3eXPxfw7v9kvARDPE67HfhsxdaDL4=
X-Gm-Message-State: AOJu0YwBw0CPPR6aul8wREyWrc4AfDANIv72g8/ntUer4kM44J62UgLI
 /HQPt7y7R84/L/oaCtpwpDRE0Iy8S0YdZy9QZ6Skdlw1ZfJ8GD1lzUTjixCRSr3RwZPFj3Q5cG8
 X
X-Google-Smtp-Source: AGHT+IHe0JOaHrzi3p1LoIuBAh975ddgv6kLGFSl4kRBllOrgLgIpwnSjxRXklsCtJrCpyGDcpw8HQ==
X-Received: by 2002:a05:6512:3f01:b0:518:bd38:1ed3 with SMTP id
 y1-20020a0565123f0100b00518bd381ed3mr3018814lfa.53.1714748537241; 
 Fri, 03 May 2024 08:02:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b00418f99170f2sm5883265wmg.32.2024.05.03.08.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:02:16 -0700 (PDT)
Message-ID: <80624ade-8d79-4811-b536-7a6f001f8428@linaro.org>
Date: Fri, 3 May 2024 17:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/tcg: Introduce CF_BP_PAGE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
 <20240424170908.759043-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424170908.759043-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 24/4/24 19:09, Richard Henderson wrote:
> Record the fact that we've found a breakpoint on the page
> in which a TranslationBlock is running.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translation-block.h | 1 +
>   accel/tcg/cpu-exec.c             | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


