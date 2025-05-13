Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D531C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtov-00038A-Qt; Tue, 13 May 2025 13:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtdo-0001h5-Sw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:42:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtdm-0003Zm-LO
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:42:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so40115135e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158124; x=1747762924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rQ3g7cfW3jvPyWxEbqJvfCwLD4zthzCwcF0/oFX4jZo=;
 b=rR3gTLV37rriQJQ2fWNYsmFBN+G3whtDWtkwH2sC/NmEnsY7gBsGSuzCSMAtw0wZkM
 cwhQ+DWKnFwbs3AM98cG10QpDo6t0L7O+8hrq+VStT27rtUCWDGaarRqTTeACU55fvnr
 6K7Lp/wXCZNvCZ8WVCpQsN8fGDTdM6O7S4QRV38UjUmkuXAedYTzkwfyfj3Uzsqv6sDq
 tC4pd1LXBgcZF6DTT5E8/yV2v9ofKqxSdkon4Gtl/iHi/HaRJGUU1jXrbuw5PZD52g2w
 x/x1IfZjDlQRMTsBuoq071Z3AZTbrspZz/HCdc3dyJDwz7a22VlqnLb+mBckK3A21QZR
 d9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158124; x=1747762924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQ3g7cfW3jvPyWxEbqJvfCwLD4zthzCwcF0/oFX4jZo=;
 b=syWijN7NQ4GtZP4qTTzMSaznfsGU74fGuVT+q5LpqNb9hm1j/pfPieGWnKjkWSoT3H
 evxBHLeBSsciSA9ijCDCJOI97VA1v1qglYjxzK52Qiw2treNmRXyX6jjb02SxmDO/vYX
 m5HvO/51qKM2Ibvsg0Vo0OhdYmLT0UQzjkCIULXzvHj9q8tNrGHRzyUnEglRJPsWYiHN
 5EDVZLHlTcgVlfX1UsKMJhjCIJuRi3lXmIAqUbcEOpoLglxjAOW+Jywd09LJkbuYOASi
 6PhOUBf44pQbqUIDlMs1apkW9Xrnuw6j3jpP6ziGupSuaWmnpgWIJtINkQMp/L8sPBtg
 s5+Q==
X-Gm-Message-State: AOJu0YxldMydPjgJ1xUZk59JxPRZXaFRYCXzGJcI7jf7GbB+0mv7Htns
 rO7R9z8snNNHMfTE/AR1XWretYMOG3FLzgok02pgMBRaZt/MSrnVJ58WvAiZluLysq/nMQqddX2
 p66w=
X-Gm-Gg: ASbGncvUfPns/M1bw/ewzvymw77h9pL2yDycYx41Tmcs1EwNi1ZUWFj7y/aBnJN03nW
 XS0QvbnAvjvDjdtDceiQI8Vj++V7tbuD81SBm7gFvb4uno8+zlJPj5mkYX9QnNtNjSFEdcVhnTM
 4YS1Jz2WOI+dVDT9IkxhTp2+685wEwPNLgf3er/4jRaLrvhBUuY5XfoJ8ioPXbdCqFarSrFWiSw
 jPURwM4bAV+NWfHcdi9bKQbaFLlTGWBANtI5IpFfoicLOl0HQOlmYc8HeUsfEcUc9tUiW+WAlLS
 Wsc76tRrEf4YYW2kOx+yQLHCdj0+bm7/+jloFP27TUCLRWoyHsYY4tylbLjpMNWbOyPirVidJSZ
 M5hRrNxIS5prHZLj/KJEGUEbx1ng0
X-Google-Smtp-Source: AGHT+IGpzjzZpOCWqdSypLhJ8vO0/E26bh7mFz9x2URYu8MBKL4WNxHFcm1DywlhwtriAXmnFRgLQg==
X-Received: by 2002:a05:600c:1553:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-442f20e8186mr2075995e9.13.1747158124605; 
 Tue, 13 May 2025 10:42:04 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d685869csm181759085e9.26.2025.05.13.10.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 10:42:04 -0700 (PDT)
Message-ID: <d05792d0-3164-4504-91b9-1570d668653d@linaro.org>
Date: Tue, 13 May 2025 18:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] target/arm: More header rework around arm_feature()
 & multiprocessing.h
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/5/25 19:39, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (19):
>    target/arm/tcg-stubs: compile file once (system)
>    target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF definition
>    target/arm: Only link with zlib when TCG is enabled

>    target/arm: Always include full path to 'cpu.h'

Missing review: 1-3 & 19

