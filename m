Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD0E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuhf-0002Z6-Gs; Mon, 06 Jan 2025 16:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuha-0002QU-Qg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:31:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuhZ-00045w-9b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:31:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso147719835e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199116; x=1736803916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tb1Bd8HXmHHzfAp89lh6eEYQg6VA4jTTg+8Jt1WZlAI=;
 b=PEk5Pu6oy7YR/DAlY3v5byN9O0ffmWQ4vbEpAGBTJKqTU6TVLC9mulyhE1hluAbfn8
 up7RS5PLcF6i/oQl/GigVPtx4QPUsWu8YDLQ3xTX9jXuhavdS/v7C6/ddZ/EXs7EM4rs
 LI9JUY9O5PpBu7/mJlr9B9Q6O6IZTG8lwKIUlg43Su8vSyWYClwhGpZow9OgZJASudOn
 pYTchWmJowkAD/ZNhvT9Ms0ce55B4VrYJEMYv8OoGvZX5duGau4QiqaMpnqYHfhkcgZU
 Nu2wH+kJ2Xmpr5TwMMVReJsdXfoQvEuxYolhw/XsJueBxn6Gx/jG431Pf9P9Lr+m2Zqa
 R4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199116; x=1736803916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb1Bd8HXmHHzfAp89lh6eEYQg6VA4jTTg+8Jt1WZlAI=;
 b=E1ZQ+U5upPW+tlmnCvvLWPoEOav44zdP8NVtUipdLAAky4sjV33CPq+ZJgYIkM4+Xf
 LDl9Kw2sclpa6t4BKUZei952zdO+S99fXtB1ytbKMeRWk9V2ANzeHYAiih3/0CxPW2CW
 UzlRfWH7da7kmaAPXMqeiwctYQXc2uHp5zAA7L+AUDTIgtFFMpCFekvsHlf7TsozileZ
 CSHENYsWVHLDPua4P2EcvPyIqV/c9DEYwTJYUlWZNg078r4fFOG6f3vhE2QDuaYlw9aE
 yHDD5Wr4IM95FgiabJ/0281lM6MxPsQ9grTO+SDODvCSukHtYy9nBjpp3fb8aKlw4wBY
 6xdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCgfp0ScdLBkGEyC+BF+hvGImAhrUMiNKa3XfQo/umZ7tcAT1zOQCGHeEpQFg83qL8nEobv2zrnPpO@nongnu.org
X-Gm-Message-State: AOJu0Yy0nZYt9hgXzQvwkyfIZrBpcAA277PpMjJT7SgUUj0Bf1MdaqCV
 Rj9p5iSPftKwhsy/okCdEWy1t+PJkOk+GoeJ9kZ6MVWOGfJcmI+Fu5R7fLhChmeSeeviiOHO88L
 ICt4=
X-Gm-Gg: ASbGncvhcq6NECBLDtGlnzj3nFop0CVA3+JRtM8JLtlGo93h8yTMJXugp9WVE2QfCzy
 R9ja23aT4jHRqNNKKDxm0DTfETETooGbWeajYX6BDzx8kyj+jP8Uee/zOfEkbVQpKTG3n2qlB7T
 6ulshVlbbghQvLGGD/pI2AhR1AtPSRZsboX8a0EFWtTPgGcKP+n0SDUJ0YX0rmPoE8Zf4/jiXLn
 Fl/1wmqus/Dn2zc7dHphVNEx2JCVE2Y1JKtopF52LQXvZhwWU1p8WTISDldg+iFNQjOkGIZHvvS
 9q6KaOJOVy9YY6nZR+ctPuNq
X-Google-Smtp-Source: AGHT+IGHYOTi3qWqp/swqeS65SAwGwpHR9arkmw3CGIzpgbmXMWGXH5dZu5zoW0kfTHID0mMEX4iyg==
X-Received: by 2002:a05:600c:35d2:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-43668646335mr508379165e9.19.1736199115861; 
 Mon, 06 Jan 2025 13:31:55 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm575489015e9.10.2025.01.06.13.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:31:55 -0800 (PST)
Message-ID: <d6d58db2-10d5-4a99-90f2-933c966fa8bb@linaro.org>
Date: Mon, 6 Jan 2025 22:31:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/73] target/i386: Remove TCG_TARGET_extract_tl_valid
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> This macro is unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


