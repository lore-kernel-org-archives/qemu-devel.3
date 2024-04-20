Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D5BC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 17:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryE8G-0001sP-1D; Sat, 20 Apr 2024 13:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryE8E-0001sF-MY
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 13:04:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryE8C-0007zp-RE
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 13:04:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso2547678b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713632643; x=1714237443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSGt2ooL1w4W2QhlCyeVTHpcwzkIpREoZK+rqZrZ1Og=;
 b=AiDc03NzZQzpxqFXMZ1cC5FYUJEhYLBXpEtVf/iNLvlpxDJAj+5S7HJ/uC33as2Gjx
 9nJhgc5fIFegZRGWLlMqD3WGcpVB9a6Izu8IE2dxC3Z8i7TmtvQ+jU3pWUe7WVDnMOEB
 MqYW+P2MRm+unpzLc14hdevGWotNJlT09z4cIHUmf5JjVqVGuVo9+j/OT4hO+pPCmYVD
 1nj31X3nD2SJOiUUYd+Y0R1SyLeybxBNKINXt0HqXS/ofNf/7htUuDySojzB9P6k5E1k
 9uYbTlMdbFIw3cRTWwKe9myBfP5IQKXunLTyx6Lh4e0hAUfr36qz0jTzL1HMT9yU1lf3
 NdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713632643; x=1714237443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSGt2ooL1w4W2QhlCyeVTHpcwzkIpREoZK+rqZrZ1Og=;
 b=v84vWzDkGMAKuzHB2DPDwm3zUIVuR84S+1j66O4iUEWpMhf4XqxDG6TuSvVF+LKn8F
 8TOnpL5+05KFX+nVHLSnOwnDseiePe07qrWcldDqn7Lru5AG1cMlo64bfT2n9XlIyI8V
 VU3zjFJu6I24FpDEHIhFneXlUo7jk5rENj+wGlmPVFKwUc3E8vTa1HDa9OCJPPZO/vy1
 IGh1JY96FSQLm7T2LBKMUDFsBMpDkx98jx+0y7K3F1Krqwcdl/qQ/8HZ2+djxJjivm6N
 mLXrgZeMhTgUA42VMEv3LI83pF1BsICMiT/1wjsAXmioyrJc88DAgeOLqgqpi/OMxUV3
 dNTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiR793IQLdX4MjiOguRYXhW8wRDvvuRe6ju8YXE14ScQ5yGCOsuZvBNawBM0ZEnA9SGucHRXZNwHks05DfaltW62sDO7Y=
X-Gm-Message-State: AOJu0YzyInd3H3kMEKeCS/j3Y+xnidC7giXSCelRLkxvW0PDLFhLfFyj
 zuBrpBG1Y1K2t0upDwCaduIYXIylNFIUD1JRLy1SLOw3+cKgrZw9mLyHx1XNuS0=
X-Google-Smtp-Source: AGHT+IF+S1vwvCBZpH+2zM1yg+nt33UP0pJykQSe+vDdMpMYlAr4/VAGnkapK9D8kdNxWG4ILvUI/Q==
X-Received: by 2002:a05:6a20:f3a8:b0:1ad:6fb:780d with SMTP id
 qr40-20020a056a20f3a800b001ad06fb780dmr182789pzb.51.1713632643120; 
 Sat, 20 Apr 2024 10:04:03 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 bt19-20020a17090af01300b002a2b06cbe46sm4938930pjb.22.2024.04.20.10.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 10:04:02 -0700 (PDT)
Message-ID: <55569871-49f0-405c-ab19-45cec6b63c63@linaro.org>
Date: Sat, 20 Apr 2024 10:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Default to 1GHz cntfrq for 'max' and new
 CPUs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <20240419184608.2675213-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419184608.2675213-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/19/24 11:46, Peter Maydell wrote:
> In previous versions of the Arm architecture, the frequency of the
> generic timers as reported in CNTFRQ_EL0 could be any IMPDEF value,
> and for QEMU we picked 62.5MHz, giving a timer tick period of 16ns.
> In Armv8.6, the architecture standardized this frequency to 1GHz.
> 
> Because there is no ID register feature field that indicates whether
> a CPU is v8.6 or that it ought to have this counter frequency, we
> implement this by changing our default CNTFRQ value for all CPUs,
> with exceptions for backwards compatibility:
> 
>   * CPU types which we already implement will retain the old
>     default value. None of these are v8.6 CPUs, so this is
>     architecturally OK.
>   * CPUs used in versioned machine types with a version of 9.0
>     or earlier will retain the old default value.
> 
> The upshot is that the only CPU type that changes is 'max'; but any
> new type we add in future (whether v8.6 or not) will also get the new
> 1GHz default.
> 
> It remains the case that the machine model can override the default
> value via the 'cntfrq' QOM property (regardless of the CPU type).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h       | 11 +++++++++++
>   target/arm/internals.h | 12 ++++++++++--
>   hw/core/machine.c      |  4 +++-
>   target/arm/cpu.c       | 28 ++++++++++++++++++++++------
>   target/arm/cpu64.c     |  2 ++
>   target/arm/tcg/cpu32.c |  4 ++++
>   target/arm/tcg/cpu64.c | 18 ++++++++++++++++++
>   7 files changed, 70 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

