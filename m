Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C34F94CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFGyV-0000EE-K4; Tue, 21 Apr 2026 15:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFGyS-0000DK-PB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:41:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFGyR-0000b7-4w
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:41:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso22054345e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776800487; x=1777405287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=siqrA+3zFz0FdYyARyhz1mbWzzYIo7Zg+3onsrsqSnI=;
 b=tPRM5VgKMqms6bBNgRJuv8NJlay/f4oMbKb+mLx/vEWZyGzfynfKRCZ+lJFV6tffCE
 74niiq5joDhZNlJ8nZOvtgKdIXG+rj2lTWaeRXjR33dVgG/iJ00FMx6ogdAVxvaGh3Ee
 Jh2sWc59o7tXXlhM9EHPMxx7/zzbNzwyIpAtu30e9etF2cPRbZ7PO/YSjPCVUmeoti7s
 7l/gbfFwH4ufdB5t8Nn/jfVR+Jvww2fWUirKg1DtjHT5PyKfqJ9vapfZ5q1PKOkkYo9Y
 y2/P7YkTCT5MfMj+BoF6RSjGEUcChe3fu6hZ/lP0ooz2DwvoLQoLpDRSfzJqsR3SQgVH
 kQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776800487; x=1777405287;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=siqrA+3zFz0FdYyARyhz1mbWzzYIo7Zg+3onsrsqSnI=;
 b=j/TjeWjF9YBd9SD+BXql+fUZiwKAFoP09BHh8YPmgqoUmrZJcU+JvZoW9uftiRahxi
 L8MPKIr1mv9wWcqTBqTMHdlyp3MjscNy3vgogW7QI75CZC/z0xryoTdT+E3SLKVvNMyX
 KLK4WCcw+u/InNz1LePoS/KYVXPJSDSVvZhblYJdadQQAMwuF+c2sLhFLW7v6UldjsZ3
 zdYUv/5N6olroNq7SdXrgjaYzoE+5DKtHQNRN+TJftksQTIjwTEQrDL7Du3NPy3b8Sry
 Dh2ONEg1U5uo3uerXpGy5aA1RlH6D+j9boS4neUn/uJYQKnxUCUrXAlvWYpzAS8Hy1M/
 o9QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97cmlFpk5PojODTrFGG2r4D2UqQibSxMCHYcgWPnRtHquKH5fPt4U9LPUcvi/Vj3lLYcZxBYR5GfRD@nongnu.org
X-Gm-Message-State: AOJu0YxEI90jJfd5OR4h1Jeh1hi1JeBWq76jM570hJ9MWQ78YQMjJvsJ
 T/dpPOT3T2EE7rTpoKMdyWvyV/y9UxiQwtv0wLEJ0druAtLfJHnKHH95U5WKPDuBSCA=
X-Gm-Gg: AeBDieslLB4pVfOmsrpRz0lEn1t3m+Q6IwESmvct3Hgrbe0TWYzqY4oO2Zfwn2JVA8U
 CKKCySVJU2LttYNZ5quI2PRNftV1fRoB3tLopq+bcifUJU8C+n3Plqj0fvMraJDr230mjKgLQGA
 5zo0Xo7o/aOGQ0nwMfiGN9t6ax97u8Ip/9ePyxZNmyH3bkBlfiiKVK+n4q1E5dYi0/OwhjHoGKS
 4BNshTHaoykl0qDY2n9CjjJH8QCUPlnXuu0GXjcSIZW7c+9EQ+OvfFpyrWcuD49yfsjl6/icBKq
 8y1vxwAbFUVOzrLI/s6XgbrvWKpHQdyHLFYzPWptpDhJY9BKmEQKsr7pLIH+bR08creajlkCib5
 TAHoB9qh4g/i4uYISN1w89v9gnJrEq5w1n+oFEZzwSVwlZJzgs88jqIGzyeZJ/ay4NYxKgfpPFM
 0MzST0ZjS4mFd0YK5jLThciFA4Qs4qYvLO6XHN1KBbPEnbN0tyFFBQIio08QonKRcYY8qJMDBEZ
 +OgFb00KrDljeE=
X-Received: by 2002:a05:600c:8883:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48a582167c7mr32871435e9.8.1776800487389; 
 Tue, 21 Apr 2026 12:41:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm150646595e9.7.2026.04.21.12.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 12:41:26 -0700 (PDT)
Message-ID: <7b4ad6ff-36f4-44e9-8e1b-0e10d4ecdae8@linaro.org>
Date: Tue, 21 Apr 2026 21:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] whpx: i386, arm: do partition reset on boot CPU reset
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260421140750.25178-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421140750.25178-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21/4/26 16:07, Mohamed Mediouni wrote:
> WHvResetPartition resets partition state, and is not supported on Windows 10.
> 
> On Arm, it's supposed to be used for reboots.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-accel-ops.c     |  1 +
>   accel/whpx/whpx-common.c        | 12 ++++++++++++
>   include/accel/accel-cpu-ops.h   |  7 +++++++
>   include/system/cpus.h           |  3 +++
>   include/system/whpx-accel-ops.h |  2 ++
>   system/cpus.c                   |  7 +++++++
>   system/runstate.c               |  3 +++
>   target/arm/whpx/whpx-all.c      |  2 --
>   8 files changed, 35 insertions(+), 2 deletions(-)


> diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
> index 9c07a903ea..32348d3470 100644
> --- a/include/accel/accel-cpu-ops.h
> +++ b/include/accel/accel-cpu-ops.h
> @@ -42,6 +42,13 @@ struct AccelOpsClass {
>       void (*kick_vcpu_thread)(CPUState *cpu);
>       bool (*cpu_thread_is_idle)(CPUState *cpu);
>   
> +    /**
> +     * vm_reset
> +     *
> +     * Request to reset the VM to the hardware accelerator.
> +     */
> +    void (*vm_reset)(void);
> +
>       /**
>        * synchronize_post_reset:
>        * synchronize_post_init:

AccelOpsClass is per vCPU, AccelClass is per accel/VM.

