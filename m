Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A987D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 11:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV6QZ-00024s-Bm; Mon, 15 Dec 2025 06:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vV6QY-00024k-KL
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 06:07:42 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vV6QW-0002JM-Ot
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 06:07:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1128753f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 03:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765796859; x=1766401659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qj3xtYNVbvliRPqpQD1lKyL0QG8KRTz9eKr79f1GPX0=;
 b=YNRaoTtAeq5GqCRWC7gfRyVtB7u1tOGN41QH8JocA/4MdkwNl9T4gz3ewnmyOD1/V5
 Dknuc2oeomNvpci6Fi3nR3Lmx6mijRU8f8ysdi9lThzgKcdk10AAk+XjVRD7UDTeN2bv
 RoKaiCNUeQ3cBeCT/mpw+fThefq5XPZYtSjOA2FSsI8UDdwtPr9rtZ/6DcGcaxMXMng7
 qrwUwIsx+fO004r52epY95ZcD4MrO0TZeJVOkWiwuy9KVfBsUySz9hklIaIwoBMUPrO/
 tt/7HWQshHh5oWmWy+8bnIe3bVL0tIjjScjW/dKvNthhE/4rtRRo7ChTW5q26pnbDRRy
 irIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765796859; x=1766401659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qj3xtYNVbvliRPqpQD1lKyL0QG8KRTz9eKr79f1GPX0=;
 b=QU2YzbWYD19NMgZnClOcQVwEOOBSDquHify3ukjQFgNOrjwOk6htOZLFZSQotzQE+8
 xXfGno2SayB8kX2bR6VO+qw8nmaXf+eDZWVPCEJ1H4LEsPQKP2HqCG/h/UeonmZc4tcz
 q3VB0K99zKwrEd8N07qWHRuYogNfWGeRMm4fONumAJf2KzDqk1XVfSpqdv+IS0CCnL8D
 z2iZLu+o5jh8xd5WIYx3cWDI5CPniEARS/zEujhfIW+7JLoW7ZsLQbpbNDoEcO1plQqr
 YeREydVn0VBf3tG7FNPPACxmcWomtj5RG6fKEesB8t52N5qgxeQSwg9XDdkQV83TkS9D
 rGAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCxnIqlGar1tRP7T7/CmRuwZxWwi9c6EOEOgdoktBr9x3np5hkhs7unaw1swf3DFOL81LQipE7Evd4@nongnu.org
X-Gm-Message-State: AOJu0YxQXmoM1WRmU/vCeRghL3tfdGn3QCob514YrQ6pJ4MxF8SMpEmI
 t9yS0rPahnWMsvHkH1FKv1uUyPpSwdDlnvWQBuNDi1lbFyi2O0Zc9PqDYDIyn1jKfOc=
X-Gm-Gg: AY/fxX4+qxm8mA0tazYQeo/GVYaeyxTYcYWdU90+JwzMn+jJ0an4ZtplY+YjGcct07s
 nRGUMfgRwsxefEquLavCi497Ueg/jaRYOM0GW4iSOlZItN640vNy3kV4Sry3jsMFafr6yEGAXyA
 0aZEnDL0nSPgrU/c4JduqCk2DEtkTTGh9qvmOkpHWMIhEUXNZX0ilTk0DwoCAgRfdSgczSIPEZB
 0pqGsW1SVIMED2OYUR0v9nMltt+d8vI2f1Z88NrMYf0ZPwzT2t9GR74XqWd9UUXdXYVrIeXBJAY
 HDQ/TNyiYrXRTtIsy1yQoRwp9p6iFp6Ci9k96v+sP/878EoVgL8xRMrVO+rlhnMYGtERSkpHeAN
 vXMAuZQF87iiE4VYceafViPod0dgiUByaxpJTlwPSR1Xqr/0cEVQMH+X+usxhZ3MGwgGZ2z5Bl3
 FC4cG25K62dGf2ib6jV2ywjSf5HyWx+ZBcUGdlNDCDIqOAi8NTBzJKJw==
X-Google-Smtp-Source: AGHT+IGLWHWlznlrUxcHketU3XmvYI24VoIelUTPM+z4A/O7CGC1fYsEpebGYtrkMYkoljF1mUn5uw==
X-Received: by 2002:a5d:5847:0:b0:431:266:d142 with SMTP id
 ffacd0b85a97d-4310266d72amr822908f8f.26.1765796858602; 
 Mon, 15 Dec 2025 03:07:38 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f38d01d6sm13857525f8f.8.2025.12.15.03.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 03:07:37 -0800 (PST)
Message-ID: <52d1084b-40c5-4641-aec3-bf2b888d183f@linaro.org>
Date: Mon, 15 Dec 2025 12:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] monitor: Fix const qualifier build errors with
 recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251215101937.281722-1-clg@redhat.com>
 <20251215101937.281722-4-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251215101937.281722-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/12/25 11:19, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strchr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../monitor/hmp.c:589:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    589 |     p = strchr(type, ':');
>        |       ^
> 
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   monitor/hmp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


