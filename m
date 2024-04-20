Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A2C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 16:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryE2g-0000bn-C7; Sat, 20 Apr 2024 12:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryE2f-0000bS-5E
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:58:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryE2d-0006w7-7Z
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:58:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so3016069b3a.0
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713632297; x=1714237097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B+QLyiCf+uFcHpkr5TTRwntyRa0C9XRuBropwkRW480=;
 b=QgxJztKZAfSogjKkO5EXi6SZdtyj6J8JudS4vV056zW0I+xOtEYsoutL21VATiOyL7
 IpkPNK5pjzBKbjoPQBf5z+LsNfgRhsOsDQ1+lITrbvDVCst6V/fcvk6DkOfdUALPOWgy
 UIBaBF9bZRf7TvqwuPUQo1ZcoMXJTKioniGjCMAU8yAIWugLBTpnuwblv6FDeQ9jxGml
 8sXbPQl40gn2hAk8d4mTpzDJw3zVaBRcpsLObkLtxpdKMMaXdjnzCjHhCoDPiunxfYF8
 YhMZthaMCCTx8O6wdtglC6f1MXY7y18aFcenoIbMJUI9cHlpjXSABZwfiNe02EkE/G4s
 BXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713632297; x=1714237097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+QLyiCf+uFcHpkr5TTRwntyRa0C9XRuBropwkRW480=;
 b=m1Vl63ncjXpO3T14U3hYWNZRAp/bD3tsHExr6zMu3HbZmopgwlEPgeVQEUexa+Pwcm
 e04CJjCJ6HG2nNgGrsA7BWmJTvV3N/VP6W80peGJcjE70Lc2fPHtsJUps3Yt+dbbWEHy
 idoDrXhsjGtr1elCP1GYR+a/IhyPbQkmBwWQddi6G+O6JsqPYWlx0Zqo+PsDV/mw+qpJ
 FA3GVAWCEhDPzPJdXDliMPW+YJ5/URAvaNBH3lHl2U4WD1CncPyrIqqip0uQftGpXdoe
 TqhDEbBNKrqXawKFzWtwOXQQjN6sivMBkO5N0PVoHk8h1mEya77qfneyasoNXUHMxn+H
 pqCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0SKBqwC31htmvQ3B+XoxEYQlv4VpHS2zerDaLVBz9dowSolHgtrKmAxuw0Bs3+BUUdkjtIXo2GyCHeOqYPvSWwGzBl9s=
X-Gm-Message-State: AOJu0YyFaiJeZ+T4SC3CN7QzQ63A45V8srKsANVom/Oe6UG9YzMa15ly
 MizkRtIlE+CAlm5mda5N6DQcOUt/q+fGs1pf66gpMu9VEYpp/+ffyyfiGgh3/As=
X-Google-Smtp-Source: AGHT+IHe3HKmvAsaMnaq6CcWoqhQTaJrur3fXFsXuXyVbO5ahNTvS4jwBwJ7xbGtFjHDeJ2vWMqq0g==
X-Received: by 2002:a05:6a20:3955:b0:1aa:bde:8c78 with SMTP id
 r21-20020a056a20395500b001aa0bde8c78mr7620079pzg.54.1713632297609; 
 Sat, 20 Apr 2024 09:58:17 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a634c11000000b005f0793db2ebsm4947401pga.74.2024.04.20.09.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 09:58:17 -0700 (PDT)
Message-ID: <ceff450b-834b-4bee-a655-79112ecb0e16@linaro.org>
Date: Sat, 20 Apr 2024 09:58:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Refactor default generic timer frequency
 handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <20240419184608.2675213-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419184608.2675213-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/19/24 11:46, Peter Maydell wrote:
> The generic timer frequency is settable by board code via a QOM
> property "cntfrq", but otherwise defaults to 62.5MHz.  The way this
> is done includes some complication resulting from how this was
> originally a fixed value with no QOM property.  Clean it up:
> 
>   * always set cpu->gt_cntfrq_hz to some sensible value, whether
>     the CPU has the generic timer or not, and whether it's system
>     or user-only emulation
>   * this means we can always use gt_cntfrq_hz, and never need
>     the old GTIMER_SCALE define
>   * set the default value in exactly one place, in the realize fn
> 
> The aim here is to pave the way for handling the ARMv8.6 requirement
> that the generic timer frequency is always 1GHz.  We're going to do
> that by having old CPU types keep their legacy-in-QEMU behaviour and
> having the default for any new CPU types be a 1GHz rather han 62.5MHz
> cntfrq, so we want the point where the default is decided to be in
> one place, and in code, not in a DEFINE_PROP_UINT64() initializer.
> 
> This commit should have no behavioural changes.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h |  7 ++++---
>   target/arm/cpu.c       | 31 +++++++++++++++++--------------
>   target/arm/helper.c    | 16 ++++++++--------
>   3 files changed, 29 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

