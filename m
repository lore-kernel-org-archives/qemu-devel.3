Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772F6C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WTL-0007MO-Ns; Mon, 29 Apr 2024 15:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1WTE-0007CD-F9
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:24 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1WT6-00050O-HJ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:24 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ad8919ba0cso4327520a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714418115; x=1715022915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PInqMUssm7xsdkXxJZoggcuaxOXoIN9ylDqag/HnPA=;
 b=Ua4AnPpbb0i6qpz68Bz/p6Bt1XpIXInzTbmtiIdhDqDH1wgkGb9StrOWLXLgm7Q/FO
 eGHpLwP2rTJBhAf6SAVWqawtBWqHbCj9dhRvOkv1tidNRjQvwCVGXRIwXfl5vGM+saSv
 o/n+qOlIsQ+MvtfADArSPL5T4vxoGcxoH/RNyV9JTboAPz2zLie/X4V75O15laR81xVe
 DYgccQUGINYrHYd+PfMsm85o99/6qYjlCrKFnA4GRprwRfxBbl0RmiV+FIvsqkTuaDke
 p91YLU9X15Ij41XYL294kLGqbN/hnXzLjlzREXWp8GADEOZqmaL6gogAEAARe3zwptVh
 01QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714418115; x=1715022915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2PInqMUssm7xsdkXxJZoggcuaxOXoIN9ylDqag/HnPA=;
 b=nGyhM85d0+kTRUdNjgyOvh/Q9FWvNxN0xVYkYIj2COTxdpK0LjGLQ/GAHmWItE+YiB
 Bm8NZxU/qPGuDEFmXU1bh9wXONuZXKNSr8ZUJRrnd0E1/KMxo9OtOCLyTReAneiFX2cu
 M0VMN5OFS5sBhj7inpjaGSj7kJmTJuXW+2occ0HLAfoShkxvItX5kDO70gFEycXC0Y3h
 xAt1YJwlgtmUY2JlLbvIC9bXGQf5lOeqBo1jQtdDjv7E6WFaKp94HQPn6q4gKeDoCaXD
 SYV7UY6btNU9nvGvGumOGvDSNlP7sMGNgUFXNyzuHYYimrEk0LRC6t9VmZXqR4InwzgC
 nt9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC3nTclLNxZU2fbksGU55k7hjB/9k+LkyufleMRQpL4daAKGlgjETs/UE1DvA7J7THtQ+c4UxBfyEQTAcWhykQ0FKg/cc=
X-Gm-Message-State: AOJu0YxM8WPDSnxg7w1xvH7NamUTdUgDGHNrtASus3dcwS128Ee5UbeF
 uxApFj1oICS6QQzV7ge3A0urWwb71Hpvt9MMwqC8eubtxknebfYA83yiS6YM8eJJSBl2GJv+1W3
 d
X-Google-Smtp-Source: AGHT+IFIT6nyPpsSbQMpiHiFrL9zptqfhLkenK0d1hZJa5sABJ9xRRYZQjyVCDXtukN2ZHe+ctM3dw==
X-Received: by 2002:a17:90b:3e83:b0:2b0:712:e3e5 with SMTP id
 rj3-20020a17090b3e8300b002b00712e3e5mr466093pjb.43.1714418114813; 
 Mon, 29 Apr 2024 12:15:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 sd3-20020a17090b514300b002af05d7e60bsm10233734pjb.18.2024.04.29.12.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 12:15:14 -0700 (PDT)
Message-ID: <278ec9e5-6100-4140-89ac-73a7d3c6b3ea@linaro.org>
Date: Mon, 29 Apr 2024 12:15:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] accel/tcg: Move @tb_jmp_cache from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> @tb_jmp_cache is specific to TCG accelerator, move it to
> its AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tb-jmp-cache.h  | 4 ++--
>   accel/tcg/vcpu-state.h    | 2 ++
>   include/hw/core/cpu.h     | 2 --
>   include/qemu/typedefs.h   | 1 -
>   accel/tcg/cpu-exec.c      | 7 +++----
>   accel/tcg/cputlb.c        | 2 +-
>   accel/tcg/tb-maint.c      | 2 +-
>   accel/tcg/translate-all.c | 5 +++--
>   8 files changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

