Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84970C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OpW-0006CO-KL; Mon, 29 Apr 2024 07:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OpV-0006Bz-1j
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:05:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OpT-00009u-5E
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:05:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ebso18834655e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388749; x=1714993549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuqJRofQyvaLUS5i5mJc/WGMsA6s4HEG5CGE52OYVEg=;
 b=ksLJBA+VruCisYLa4tGqQEwRKjDiWsq7BFjjBUp+pLgdNLmz4X6TiJrkskY+F0B8eh
 F1rg6qwLziq6rA07JAF47hGk2PJRG9UlQ7aqY0/tjMi0EREtxysMfCkcXjLYNOm4yoT+
 WRzisodEmzTkdehm3ZHWsnsckl6vn2YvdZAlGwSH9tHhu17zoCPSOEu2S/Uedk3nZaVC
 Bat6W0TVqmc87VRXCTPJLo32hy2BKNOS8salrOIhxFgZVdMIJHCQ9VwoGnNZlHIaklgw
 jrvmlLqmkHVfHodDhH0ICF0Drm7gDHNMNACrZRbuFFOYbTY0cugkcQr4Y63E+2Jcnz1F
 f4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388749; x=1714993549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JuqJRofQyvaLUS5i5mJc/WGMsA6s4HEG5CGE52OYVEg=;
 b=BXFqrrzhIML7Lp/9L11/iwXwMRxGslBltmxUkpVyMSNv4v4LseoTdfMWfSgraMhAFd
 l00H3w7oSjnKTzxNlGUE7usr0by5YD7jsR+XkUH/EF1KRXmosvioKwQ7sZ3eLsAipNmF
 CYIhMOcnzY30OKMjgxc8G+lT4Plt5fzzmwchpFGSP9c16EI/3RiRTvHIivScDSza3WZB
 jlAGN16hjeUCjd0s/b3e6TpcyImshmznRYHQNyF9AYE+LSDB3IYo8r0iYCy0ne8bT41i
 HMdMVqKy3rUdg6JqbCd6rcLmEf1zFB4zhmo59LphWBlLtfIX7KehcLA7R1DrAuyALIF1
 Q1eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdXO+vB1XQSnfeOYjgW4tfvZXNVTIrgsU3zQl2D4hBOQGWw+ANIYN+H7lU7y+7XSrzBfgfw+s4/PEoOHQR3/dRipxIIpo=
X-Gm-Message-State: AOJu0Yx/9b9sLJ+UvZRLYDdBOFsyHTh6wZaZHhQAKhxWBoDf4qhYrvre
 6O5MlOe2h8ZvqmN/+BWtawIf8mEzWkFB71ijuRbKi2JNDqtknIjw1n14Uaiq3Fd+j8E4tkKY8jG
 ujhk=
X-Google-Smtp-Source: AGHT+IF9NLy3i6hlAlcbnnp5PC9z0iANGEQd1feNGV944ZRnve/EL+sYyo0T2x9ad8uiD/H30AJ84w==
X-Received: by 2002:a05:6000:18af:b0:349:f8a1:cd6a with SMTP id
 b15-20020a05600018af00b00349f8a1cd6amr7903956wri.16.1714388749205; 
 Mon, 29 Apr 2024 04:05:49 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a5d434c000000b0034ad657deccsm22134439wrr.71.2024.04.29.04.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:05:48 -0700 (PDT)
Message-ID: <fd399325-0d57-47c6-ae75-dc5a4f06740c@linaro.org>
Date: Mon, 29 Apr 2024 13:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/4/24 00:57, Richard Henderson wrote:
> Because the three alternatives are monotonic, we don't
> need to keep a couple of bitmasks, just identify the
> strongest alternative at startup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 56 ++++++++++++++++++---------------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


