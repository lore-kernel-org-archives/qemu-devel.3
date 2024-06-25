Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47665C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6ud-0007gv-TC; Tue, 25 Jun 2024 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM6uc-0007gl-DV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:12:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM6ua-0002pR-QU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:12:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70661cd46d2so2953414b3a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719324763; x=1719929563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+RNMAbtANiIRYJCvrL8R/4Y7B9hRoZmNinW/FyqDbM=;
 b=kMG06606kxVx6iqUjTRg4dvS36IVpxnqeTQlrICreIdAmCScuQ/vClbp2tG6TZ2LUK
 kHtcaNZSPqfFxCUeVzsKRWPECf1mrxzDeFDtSPU0SnDmXaDR/gLEHkLYnTkvIizwGJRh
 09tAyWNUR4Efh9Y2wLT4XwAXQV7ZBL6HovSDO2o4uH2AxbbQ7+xStvXKkK54jrCg2IpE
 PpUTCXtV8Tun7g5XjD3T5MX4vxy/wo+Z76P1az9K2/IShsIRniensTNLbv+i+h02WVK3
 A9zTfeJf81TK7IWPe2xVsCqz9kBVmxwMT4p6z/lPUnnJF2RDad3brBhV8I5xtx/aiAl2
 JU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324763; x=1719929563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+RNMAbtANiIRYJCvrL8R/4Y7B9hRoZmNinW/FyqDbM=;
 b=OTdQd63haAfh2TSE0Hm0CXjpytiIb0TZKNmqgHqV2uG4VimWiYGhYpNW+5GGDAI1oc
 jwnmBaxOPzNlt9nHEqRC5+Msm8X1XXtOyDT5u/fqWWonLbpdfwaQT5/2Uix+MznaMILG
 XZQa8HFKIQ9wZdJlsJkQyZhJSRkCtAvI/hpBC2xsebLlvK89gZGg9E/W1xYU+/dNdD7r
 gSP5F0P1MxR9IHw+P4FeBgLWyx1S8qV2OBjLSsrm3Qq/erov/G3RUe+4b2PX7IG7yqwm
 tetntuk605V6jd9xjl3yM31C6665mL6h1vSIUVhaBGSMziZzu0y7ery8Il5jJizHTlIR
 ZEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2GN7ww/BgxNkB3hQR1QHSYk7VvQKjKcuUxdhiaEXpQ+H34qS9mZuBSJT2jlPKzEF2XqQ6kFDxIreaVz9U/bgck/xeuMY=
X-Gm-Message-State: AOJu0Yzxpj1kwUmc/lcD9WliUudmhjkzlNW6TObPaC4bqkR1TQvfN7K3
 ZBu7DpsiFt5iU32becM31uf9FF7g62IwrTiABAfyTRX9jbRJsce81lSvx0piNaE=
X-Google-Smtp-Source: AGHT+IExc48k5GJhrPs/ST9y9cL6slxuokwmNKXIIUrXeX7w4jcw6FRCCPmAj1S0olYiILTUgnLv0A==
X-Received: by 2002:a05:6a20:bb1b:b0:1b5:69cd:87e with SMTP id
 adf61e73a8af0-1bcf449d789mr6649615637.21.1719324762990; 
 Tue, 25 Jun 2024 07:12:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065129bd8asm8151709b3a.154.2024.06.25.07.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 07:12:42 -0700 (PDT)
Message-ID: <6eab13de-2ad5-42c0-bfd7-801012b0c685@linaro.org>
Date: Tue, 25 Jun 2024 07:12:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help improve 32-bit testing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Dov Murik <dovmurik@linux.ibm.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
References: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
 <40e4c21a-1f64-445e-a385-a9f4ccec0b0d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <40e4c21a-1f64-445e-a385-a9f4ccec0b0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/25/24 00:57, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 25/6/24 01:33, Richard Henderson wrote:
>> Hiya,
>>
>> I've just discovered a 32-bit build issue that is probably 3 weeks old.
> 
> How and what did you notice?

https://lore.kernel.org/qemu-devel/91f19b8d-387a-47cd-b7cc-19cdf4442473@linaro.org/

With no arguments to configure on a debian bookworm i686 install.


r~

