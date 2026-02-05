Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692EECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5vY-0008RM-Bl; Thu, 05 Feb 2026 15:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo5vU-0008Nd-AC
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:26:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo5vR-0008KK-S9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:26:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so15551845e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770323164; x=1770927964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZHTPC/z1QwHyl2j3Rvfd16gOheOeCMUMTGGnNYOW2Cw=;
 b=vqjbBJOfOtc0igCDBhU9nWGhv2WO/vd8S9Go6v8WLX6/V5AUxlQSo7Yy7NhoDCUqm4
 nDt+23ZJ8Aoj2x3Ady6xB3eUDU34ihK+V7joNBw2MR2GMYDfIZcHd8NmeOOLTYH/oE49
 75Lxz/uRR7VwYAsRKMwPaq4yyjCKdS9m4K/FDTP9B3A2TL3xm4vMvDVKLJyLWU+kNc+i
 S0ZJfTcJPUt7Vbp81cYVNq9+kccAXqzw1HRGOShEsqqWcfyL0wkmf6I+oc9c+rQJnekh
 4erLCFAkCMoXvPU4MFls2jCFcWm3U4DqfP3Og5eYhJSBxH43Lck4WXYGGTmrleAHpY3/
 mkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770323164; x=1770927964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHTPC/z1QwHyl2j3Rvfd16gOheOeCMUMTGGnNYOW2Cw=;
 b=sVzjZ/PKHSO87SFlhW6M34nEWtIxTByLcrKoai8uiaua0+KnhQzNYpwlk2cndZjctM
 lFv54BGYDIEPfcjnaly8UzbB0BYkFz5wqyYkTEqz/NDZ9m+8q1UlLKrp4lqUnGXdactz
 tHQFGmCwYf4Gbjl0KSU4bqWNeqg7bob6qFAXMmlmqcf2dZw+YF8Ya7W5Zc3tYhzS4jQc
 RPo6asED/yASLNJFRcA0Qb1zNAnvKuZqAV2fY32uqdVv+wKEbc0cmIdZx0DEZYoDKlFQ
 ObgHE6hoDcLF1kLX9pKVbxNy7q5VJmuvhj5+2OH3A7XwSHijivXQ2jRieeMNqDfvSw/4
 sphA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsyFxm41pe0QjJ1FQhwgCGlPnP+5WRaGb5+Oj2ypOYLUgFWXcS44D9uHmFj1OsI1Scvtr0bPDIhDxH@nongnu.org
X-Gm-Message-State: AOJu0Yz7kF7ar+q3Z+Rhj0qbxvQyIKpVQT6EZSgyrnwniX8Sr5MfxIXY
 ZLrx3fg86H1QhcK9qHK7zsG3q0hWtRcwnRZEMTa6pD3/2Hp51yl0Y4QHX6SgCJLCdWQ=
X-Gm-Gg: AZuq6aI/rl9JvaDB+R7McB8u0/wGW3u+ULPe0Gnb0KY7rkXECgeGN2IvXemVZx4yFlf
 EDpaGaS7JGapAkRrj0j3mb8w0qkXkxqJlTcPmJADBEYJAiBUW5x+owl/d6H/TGdr28iv5hWzPKm
 dvLZ3keKvl+vxnWKB++2J1P7qtHnM39g+LVemLaMtYbo4edpdGWz/KXT77mixbChGokIVwM3brA
 7SJFe7cDf7//aMcpSvwLg1ea5hp45qG8VVtCyGR9hPM3pQ9pl57dRzHhmEk2GQWwkj3J7ngjjTk
 rKPNl1E2RF64qlWmF3DFe/z7NCmEK4ULU6K4YWjjqYAg0HMWpFUHaSMpg3xsKT64eEl8zZBIz4p
 l9ieqWBruTSNo5yrnzEcVrwvJrh7qUg+rjHN6fCoPlmg79N0HJpPgmK5TzQzuJEwsNorR1IL/HU
 kmjJ1KHk/vW19wZZzlLGrPX0laAfcRnIvSsKG9k2bvcox2AyMvrohLDA==
X-Received: by 2002:a05:600c:3509:b0:47a:975b:e3e6 with SMTP id
 5b1f17b1804b1-48320216069mr8074415e9.18.1770323163643; 
 Thu, 05 Feb 2026 12:26:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629756bc3sm531025f8f.39.2026.02.05.12.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:26:02 -0800 (PST)
Message-ID: <48c59f79-c169-4298-8fdc-1c859a5e1373@linaro.org>
Date: Thu, 5 Feb 2026 21:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv64/test_boston.py: fix intermitent test timeout
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 djordje.todorovic@htecgroup.com, thuth@redhat.com
References: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/1/26 18:45, Daniel Henrique Barboza wrote:
> The recently added Boston MIPS board selftest times out consistently in a
> machine running 'make check-functional' with -j 16:
> 
> 18/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
>        TIMEOUT        120.09s   killed by signal 15 SIGTERM
> 
> The reason is quite boring: it is testing too much stuff.
> 
> Note that functional tests aren't supposed to be used as stress tests,
> e.g. it doesn't have to test every single corner case that might hit the
> board. It is supposed to catch most common user ooopsies. A timeout, in
> this context, is most likely to be considered something abnormal slowing
> down the emulation, not a lack of CPU horsepower to run all the tests
> before timeout.
> 
> Some of the tests claim to test odd CPU SMP numbers to either "ensures
> proper core distribution across clusters" or "validating proper handling
> of larger asymmetric SMP configurations". But there's no SMP/NUMA check
> made anywhere after boot, so in the end we're just testing whether the
> board is able to boot with 7/35 CPUs. As far as these tests are concerned
> we could have a completely broken, but bootable, SMP topology with 7/35
> CPUS, and we're oblivious about it.

Good justification. Otherwise I'd have suggested the @skipSlowTest()
decorator.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Remove the 7 and 35 SMP tests, keeping the minimal CPUs (2) and maximum
> (64) tests. With these changes we're now able to run the test with a
> good TIMEOUT margin:
> 
> 17/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
>        OK              61.28s   3 subtests passed
> 
> Fixes: e71111e26b ("test/functional: Add test for boston-aia board")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   tests/functional/riscv64/test_boston.py | 19 -------------------
>   1 file changed, 19 deletions(-)


