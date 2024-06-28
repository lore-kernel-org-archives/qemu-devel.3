Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2BFC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDfF-0003fv-9j; Fri, 28 Jun 2024 11:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNDfD-0003fH-Pb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:37:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNDfB-0006sP-Sc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:37:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso617024b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719589044; x=1720193844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tg3evtMHreUWC/hLtIETtK1YBLYxxHqH7Qa/1i0yT2Q=;
 b=aPyRJrPmreBRudTSoNUmIyuD7pJj5p00qiM21TqEK9jS/by4y39dv55NNMZVVwTOmd
 ywR0gdifiht7/bhLsp3MiuusfEPNuklOy3xACO8tWpswUe4C4VzXbKc2CjS55G2mfDSg
 oZRNzn1auWKeiflt32oKJ6/3Y9JP5ycCBHs01a6ixpRgAY49n3dqZvbEP2rhIP0DlzL4
 l2tmPfDISMU50mhpxN3cZ7Q/m0Fh46kRMrL/9u9oxbOCc0YRplHe8cF1z4A4qrTmnhVO
 bAlP5cFMvBUbJFktg1W2jxbhWxEkOXZfsh4C9aHNQ21DolYpYidf2dQS9cgmA53Ji7rJ
 t6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719589044; x=1720193844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tg3evtMHreUWC/hLtIETtK1YBLYxxHqH7Qa/1i0yT2Q=;
 b=p31ui2wDxHIEbaRYExnaNpOSXVk62AmmrN32w3zj9+I07IOqXRyc3N7N6F5O8039W7
 CNCRTrfhWckz1472y/LHP+QVxd23IvJmg9SAY47Fi4+YT2VA3RNvfOVqiNLCKm85Puh3
 xm8Bzx3dnbbK9Nop3W56ifoP05YWJgAKtaf2vntVjpVmpUbbeMSeHaO+RY1Jj7twC0v2
 PU6uk2bBBx0PEsRFBLphrSMmzps5Z9hU89t9o05m0scHafh0ynyLlRdfC5BLp01wTWUl
 1T+LifJli53HALUNBVn78bkzR6g8+gG+62bCa0NjxvmM8zngH57AitnP0spaLevouZEe
 1rKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX11OrCICfLrxcW+TQejsxl4zeATb6/23zAkwpKchoFqumaSJgHcQ74Dm9F0ZhMqrMcttIvX25/GInJBoC2+Kad1Ds0Pnw=
X-Gm-Message-State: AOJu0YxS+IW8rY6z+XW7s/ljZBBsuy3ogojOyVPYuxf5/KLwZF3az+XD
 FvDzNvkh1xuTs70mxVTobcp9KqNZazOWBnhtiq+mY3rIG8621J285eH4qnZEF0Zn86Dx/xaM3Wc
 A
X-Google-Smtp-Source: AGHT+IHbykY281d9LBgEN6Mj01U8vgqFmzRxqdQOlBVtGGw9LikyrIAqQmpuR7UJ8TANEqJ4S1tEKg==
X-Received: by 2002:a05:6a20:158e:b0:1bc:e978:8bf2 with SMTP id
 adf61e73a8af0-1bcf7eae9f3mr19144860637.23.1719589044032; 
 Fri, 28 Jun 2024 08:37:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10e392asm16765105ad.78.2024.06.28.08.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 08:37:23 -0700 (PDT)
Message-ID: <61656f78-4f96-4212-b37e-3c77c937a3ea@linaro.org>
Date: Fri, 28 Jun 2024 08:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/arm: Make vfp_get_fpscr() call vfp_get_{fpcr, 
 fpsr}
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> In AArch32, the floating point control and status bits are all in a
> single register, FPSCR.  In AArch64, these were split into separate
> FPCR and FPSR registers, but the bit layouts remained the same, with
> no overlaps, so that you could construct an FPSCR value by ORing FPCR
> and FPSR, or equivalently could produce FPSR and FPCR by masking an
> FPSCR value.  For QEMU's implementation, we opted to use masking to
> produce FPSR and FPCR, because we started with an AArch32
> implementation of FPSCR.
> 
> The addition of the (AArch64-only) FEAT_AFP adds new bits to the FPCR
> which overlap with some bits in the FPSR.  This means we'll no longer
> be able to consider the FPSCR-encoded value as the primary one, but
> instead need to treat FPSR/FPCR as the primary encoding and construct
> the FPSCR from those.  (This remains possible because the FEAT_AFP
> bits in FPCR don't appear in the FPSCR.)
> 
> As the first step in this refactoring, make vfp_get_fpscr() call
> vfp_get_fpcr() and vfp_get_fpsr(), instead of the other way around.
> 
> Note that vfp_get_fpcsr_from_host() returns only bits in the FPSR
> (for the cumulative fp exception bits), so we can simply rename
> it without needing to add a new function for getting FPCR bits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h        | 24 +++++++++++++++---------
>   target/arm/vfp_helper.c | 34 ++++++++++++++++++++++------------
>   2 files changed, 37 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

