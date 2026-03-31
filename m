Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A373109B461
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yff-0003kZ-1J; Tue, 31 Mar 2026 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yfb-0003gU-KX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:58:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YfZ-0001jR-MW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:58:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486ff201041so56069855e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774961888; x=1775566688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWvq8XE7pF/sq3LoE+8mqpDtZwCHVdfI2uoam17xhjE=;
 b=bq1MAINzM33csGfLpkzlWrV2MLSHqbgIEEttegufffri3aej06z2KN3vHCvav79xSq
 E00uwkrlQBGoJ6FhNGkorBUMjS2roHpP9cunJ6zo0c0jP/s9IfV6nOMZo06mXZROdSRF
 pTlMs6vhVVuCKhwmua2hChqlB+KWqKZL0Wi9j2nVPhrsEh+/P6jOnr5vEqT3NhMI07gC
 FM0GCWyMZhXKgse5D4FsJU2OWS7SWh7hCQl1NI/9UkhZbRw9F5SLgcTJjPJTZaM8BWu9
 ajY1veE9+0BDHdEaiDS8Cs7VgFkq+TiE2514qStHrXFsdr4NS2KO+p1elUSxliI05Ibv
 RzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774961888; x=1775566688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qWvq8XE7pF/sq3LoE+8mqpDtZwCHVdfI2uoam17xhjE=;
 b=UIoQIlvfC/yQU2oY2ts2Me6YlJHwl5p8F0n8rLxlYdTRRqKOnB67Qu+lP0dzPHMAXd
 UXAW+r2yXNVbitQbn7tYvtGwGx8lQ6QJ0nJTesf18jchPs4Ts+HAAmvhrLv3vZyScBFI
 KDeYKGJuaqNpqpbbdSv7TxEcj5pQ62fF2aewI+0n/fxJEBrX7A9iWP1q/sRrColQ20+4
 1JdyiL9KsJPR/X2aZrl0/C9FGam/Ec46xOfUiJ6eItWJsTXFKrLBrLgXG+8Zwv4A9eDN
 kR8jBM/38cQEmQMkwSCtd6M8PXt2zgIwU2wQvFNFz2i1deu0c4r05CrWvrwUm0BbsCFD
 +qWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVrw9wDRgyF7ndjW6h+/CRU4wqbZkQUh1DWItHBYl1NwpyCGmrD9ZIIH+PllwUCOHbB3tM7WCVchVT@nongnu.org
X-Gm-Message-State: AOJu0YygPO96S7jmhDW00A/6DJdM5xvVDl6wyWXHLTOl40d/DhX5/+/1
 UIzFCTbrloVr1VlouOU8JzwfwxigTG+3/bi4I/hmCajKSLGoGFU5aS+CVjF0W06Tick=
X-Gm-Gg: ATEYQzwG5AnkAmWbFZyCYDpfH+SnTBSdO3nppbtkfBTragdFN+wiZCXDt2fbBSp8jTh
 PPvWvMBUk8a1Slqb6DQoSvUYhcRAC8jGMh6SntdIEzlpr8jye+ZDwzbjiugODJPBAbo3tdT44DL
 SewhkHWXunQHg3+diFEGkqWUTimZ3TY3XTuh46FZ+yczdXN2jE8gsEYpY4TL4z9xIwY+WVgsx4m
 H5mB5V98hFi+hwwNKNNzD4rEKhKjC8shz0b42BlH28yduQtWlO4Pkg6EmdbvG8OG3TViZ40Knid
 EyE6+f5hzIIC5pJuevfqGXLnuw5gY5guIQIYvbL1AL1NTYtXl4nc+7/SFfMrZDthKu2/R6VMI/C
 WAokF8bFE+4+Hfae/ds1rA0r1yo8Vevwg7AfeY7PXGvkZviSeGnxbzpeQb1VQr3VSTPEyYGSJim
 7/dkfUsA2HWQML51AHfPBkWHei6HapL5SlUua2oT0jWhE7SmG0TfeYV/iLXUxGYU0=
X-Received: by 2002:a05:600c:3505:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-48727c7c6e0mr245889065e9.0.1774961887951; 
 Tue, 31 Mar 2026 05:58:07 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm49648135e9.2.2026.03.31.05.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 05:58:07 -0700 (PDT)
Message-ID: <524da3fe-1dec-46d7-a225-1d02beb2d3c9@linaro.org>
Date: Tue, 31 Mar 2026 14:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: save CP0 timer in vmstate
Content-Language: en-US
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260329113732.482619-1-vikingtc4@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260329113732.482619-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/3/26 13:37, Trieu Huynh wrote:
> The MIPS R4K CP0 timer (env->timer) is not included in vmstate_mips_cpu,
> so after loadvm the QEMUTimer has no scheduled expiry. This causes
> qemu_poll_ns() to block indefinitely and the guest to freeze until an
> external I/O event (e.g. a keypress) wakes the main loop.
> 
> Fix by adding an optional vmstate subsection for the timer, following
> the same pattern used by ARM (gt_timer), RISC-V (env.stimer), SPARC
> (qtimer), and OpenRISC (timer).
> 
> The .needed callback returns false when env->timer is NULL (KVM mode),
> keeping the subsection optional for backwards compatibility with
> existing snapshots.
> 
> nit: when trying to reproduce of this bug requires savevm to work on
> MIPS Malta. That is currently broken by a separate crash in
> vmsd_can_compress() introduced by commit 7aa563630b ("pc: Start with
> modern CPU hotplug interface by default"), which is being tracked and
> fixed independently [1], [2]. This fix is independent of that crash and
> touches no shared code.
> 
> [1] https://lore.kernel.org/qemu-devel/20260316194759.22672-1-farosas@suse.de/
> [2] https://lore.kernel.org/qemu-devel/87341zsvmc.fsf@suse.de/
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1987
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   target/mips/system/machine.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued via hw-misc tree (removing the nit), thanks.

