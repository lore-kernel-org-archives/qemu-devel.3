Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E2BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19R0-0004IT-CJ; Sun, 28 Apr 2024 14:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Qu-0004Ge-Jl
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:39:29 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Qs-0003J5-MX
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:39:27 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ee2be5b765so23029a34.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714329565; x=1714934365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UXrZx8l37XrDvTRG5as9Y56AnAfhlh0GJvX1ogTdvsc=;
 b=GmOEcfAN+rg6teLL29kk1mDsusHzifZ/rgfFFic2t0d+QgPikoDwLR3MIwiNZtnLQF
 yTzNrKjHOJj+xxIHc/rAuRZjz8rhgf5XHcgkvK0wKsCuQirroSR0hQboXeHBwj6lW8TE
 titp3tPRBLOgIF/EVT1DwR4op0z/optXL3osUyc2o0GnWH4Sagjd/Qrj0TlDenUsIfXC
 +sab/gzyBe8GvuWyXADDd0gvXk/sr8SXmbeFu1/VhQKFiQOMxXV7sFk6YY51b1R3xYNN
 YZRdH0w+oyw5lVaDTARtMgLo95zU3qXQPEUMsYfRhI+u3l8dhcf8HRB9UcH6X5I1wudE
 8/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714329565; x=1714934365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UXrZx8l37XrDvTRG5as9Y56AnAfhlh0GJvX1ogTdvsc=;
 b=e0+pRZC1OMZmx5FbaEncQGNiaGrdSfYbsPTWJ5OMkpihg31YnPnqDI1LngUUvdHf4F
 rmqVp0HXI4I+PI4gBGFPVFS+NWu2W89UvDBa/kBZXtHCkn1qXJipcXXehPmZEeZLZEm7
 zITAJLAtb3delitPtnrG+aoZronJT0sqclvWmE3HkE5SmMIiu9QBQ3k9gnhhFpv/QdO6
 lHr/xHdi4WKmTLHljaZxWHaUwYpOHQlAVTEBgo5asmcccmDKxyxSPMfRpzbs3M6YDgLa
 NGuHWvpHKrRwNmCqUgMEVlpmskkLa6+vXNM58v2bRRjp+iJlCY/7mRJrxl22Jxx2CtWA
 YCdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIl2DiKmbOMxC9XX1HsJHrCbsJeGQ6hcErKrp/xOLQe0I2wp6BXe3FRYEKwhMEC8AGx6nrfqdh8WNbO9m6i0C32IAFHaQ=
X-Gm-Message-State: AOJu0Yyroh/Y6jLZJsSBaPt2qpLX9K7U4Nw+28wCrF8Ads7MXEUu/G/x
 xXsNPQ6jJ60GPb/u2QD2uwvhgt/6gyeh0Q/fvzXz7/9SlUt/KXKdportwHhiZf4=
X-Google-Smtp-Source: AGHT+IG4wwQNHhF8IZoV7VO98XXSNPK7sqpAU2E32RpHzPcoM7fHbWQhZcoGdHcSMKzjHWU6boHumw==
X-Received: by 2002:a05:6830:10d1:b0:6ee:2e07:8f72 with SMTP id
 z17-20020a05683010d100b006ee2e078f72mr1292046oto.21.1714329565276; 
 Sun, 28 Apr 2024 11:39:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m191-20020a633fc8000000b005f751c18d0esm17690943pga.86.2024.04.28.11.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:39:24 -0700 (PDT)
Message-ID: <cfb77ff3-8b95-4776-b784-43b0c781ddc6@linaro.org>
Date: Sun, 28 Apr 2024 11:39:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] accel/tcg: Remove pointless initialization of
 cflags_next_tb
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> cflags_next_tb is always re-initialized in the CPU Reset()
> handler in cpu_common_reset_hold(), no need to initialize
> it in cpu_common_initfn().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/cpu-common.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

