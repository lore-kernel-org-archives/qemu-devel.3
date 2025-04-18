Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291E1C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5iQY-0001xJ-2A; Fri, 18 Apr 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iQT-0001wl-Ha
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:54:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iQR-0004yp-UT
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:54:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so1056295f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744970062; x=1745574862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Fed5CCqVC1uchETrSglEjAsY710qHYDpL/0FpAk3OY=;
 b=MtcUGig/+OPp0Jw6+dE0UtAa5NkkKl0iKXZ+aog6IokF9Q47WMEbdkGo++LP0Dwp8y
 iDyP3fEZUNDLW1mitg2xSxx9dh6mKuK2VmH+EUrl8sVBsQp1QaRo8/5OpEd4vu0rH5qi
 HUupTQ8LchNrrpY/dg562ckEcfOTWaYd54Vd8yYnJgOh9k4YIbOwfsvrgWRo65ZC2Un6
 nHyHmrMBab4D/8Rb8HyPvahjRzUtBbKP/AO+UU6dLmRRjx+liao2WrUZZou0HqKUHeja
 WQxDFRrdqaklfINiJ3qg1a4QC2fjMb2r1t3Enoe9LVWXcjwdRizC5qlIOsf2QNTg7F/9
 +www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744970062; x=1745574862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Fed5CCqVC1uchETrSglEjAsY710qHYDpL/0FpAk3OY=;
 b=oxYYHwcbRw9RT3EplTuFAIUJ6kDtRptFlHqp4D/AKuGIUFyoWz6xJkGvY9ei4qnp3O
 vEyb9HrEFB5k8cFX8NEL1gLkgKQW6zbxJwvv5EMoYZY7OfYhr4p0qEOdnFSiwwVnyXkE
 HMrMXyixDEud5nrRn2y7ii2J/ZhHl1n0gFvWCeDIR9228abafBx6rUDdjUj3Luti/OV7
 xkPkS+T1oqx02D5nJ0g+rlFmm7epJzjqMLeAHkGWbqBZFPZ0oPVRzGBb5/ZB44GjwAAP
 3S5mWI3pqa8IN34ZNzVbJgV7VVSyQgClK/hI9gYmjqXurS2j8VETCtjD2MHCTlFWvxd2
 Dfjw==
X-Gm-Message-State: AOJu0YzwDuJGDo0WdxuAalxjei1zlnJrC8u5SrcF056MIOIUUrR8dePy
 vFqYPylyL8wYkYk4FVcKfy1WwUYjGjIhcXkrlRkgzRClDGdL3zvDqOYBvqrplBM=
X-Gm-Gg: ASbGnct9jOwALfydMfbMZkMZ/GeWuUSjOZH/Hm1t1eeq1ktaT3Y3uRfGSEMf9HmiYPn
 VzGP4RWVnqeKkZsGhQ65whElgZxUc/DzWmsJ4B/Qa4w+vuBwA2Q9Q4vwUvv+deEagyxz5xAKG/S
 JKRuueE6GKHp9dxhVxk7ooWhPtT09rNEfeVOhVUkMRe1hdlD2FqMvDh/yGdR3tVtt9kvInf+BlD
 xcxxfPic4YjIfdPBvYfb1v82hcNEn1P/8RVcrTg99Ba+7ttQIsuittJhKS9OqK5lla76kqLL9v6
 XsvqNagAjXtScOAGQs+1yrvkmcNMs3ToazhcXgqtQR/tJCwcNyl6LlC6/icddngAv9fJckp43HT
 4fx/KQFKTKpS3SX6+XE8=
X-Google-Smtp-Source: AGHT+IEx5nOZSpmYtfWuc3dv83tBBmnvEcrXWY7Lwob10430tnM8nvFUlhfQhA5lcDsGd235cosI8g==
X-Received: by 2002:a05:6000:459e:b0:39c:1258:2dc7 with SMTP id
 ffacd0b85a97d-39efbaf1ed8mr1146204f8f.56.1744970062562; 
 Fri, 18 Apr 2025 02:54:22 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e0183sm15736545e9.37.2025.04.18.02.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 02:54:22 -0700 (PDT)
Message-ID: <602dee62-1b01-4f17-9a61-158aacf1cf38@linaro.org>
Date: Fri, 18 Apr 2025 11:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] target/loongarch: Add CRC feature flag and use it
 to gate CRC instructions
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>, qemu@hev.cc
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-2-wangrui@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250418082103.447780-2-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18/4/25 10:21, WANG Rui wrote:
> This patch replaces the obsolete IOCSR_BRD bit with CRC in cpucfg1[25],
> in both LA464 and LA132 CPU initialization functions. The corresponding
> field macro in `cpu.h` is updated to reflect this change.
> 
> Additionally, the availability macro `avail_CRC()` is introduced in
> `translate.h` to check the CRC feature flag.
> 
> All CRC-related instruction translations are updated to be gated by
> the new CRC feature flag instead of hardcoded CPU features.
> 
> This ensures correctness and configurability when enabling CRC
> instructions based on hardware capabilities.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/cpu.c                           |  4 ++--
>   target/loongarch/cpu.h                           |  2 +-
>   .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
>   target/loongarch/translate.h                     |  1 +
>   4 files changed, 12 insertions(+), 11 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


