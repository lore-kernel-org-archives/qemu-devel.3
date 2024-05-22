Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84D3C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ujU-0005oE-Mn; Wed, 22 May 2024 18:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9ujT-0005lI-0d
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:46:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9ujQ-0008MH-TR
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:46:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f4521ad6c0so1831115b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716418007; x=1717022807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oFHaUHex8RsqiMd5terS4Iu1CJQzQl4U0XFNlHN6pJ0=;
 b=LDyvVmqF/qHC7Hk6OolJYR54JHVbeCRRyZFdrsnVY7LWEqYVVz0G+KEkepwEqe+FA+
 AsnET6mIXHwGAfPoXF+3aUPjCz06TfplVxrpGOMbB92jyojSEMtRT+fvhIJJEJgEHYLz
 fF/7fCaU63crYcRHkR4IEuXPiKKPXAIY62pz8PEdNuMTptyXnbc90EeME1oRgdg8jPGa
 TJXP+/u4N9EOXk4BrRgYg+WvLjkuiPjVNqPDKHqOtgoB5p8XIRhKvgdZ4B8E2+65B/QB
 mdp4tfUVIWcarzvm9sVD3/RPqnRmzuVeU5Vd67IjA13PQwRaTJWOPDIXLzt6XafzUcn8
 m4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716418007; x=1717022807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oFHaUHex8RsqiMd5terS4Iu1CJQzQl4U0XFNlHN6pJ0=;
 b=M0aWYett38yrcHBcdBtPe1tq8swKXU7XqRyy99JuUeQr7SWBgWU1hfNV3ayz9dup7s
 3mD0ko3ykLs9/FbxwtWgr5TIP+815kdOWWwHJeTapeG93MGqJRN+DrW2PhQFUR0gveCz
 9fMVm0MZ37+8f41a72UMgwCJNJUlbpnzEMiFnmAv2bJxQlGiUM30zf0sbs13mLUomu7d
 CXbBa/xOvJq3i/orSDCw6mjsFbIHQfMmBZDku+RUAvVxxJOEmoiWqxvJlWlCuqcYXvTx
 68h+jChWUDKknGgBR0SUnEjzESovGGHqxZYIWRRagn9Sb55bsbmgUfumex76SACI4Rz6
 SLrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaN3S87rK20wnwuOPCuFlfb35y6XpoYMmURntOOUmI3XebK4nkjm/CeGthI3d30H0aEdErR74PI7nj4iIqyow96IuUsCs=
X-Gm-Message-State: AOJu0Yz2vztyq2Nu9mKaosdOhwlI39etkSlenP9hMNY1xC+NdF/tTaR/
 ozvM8YSsbR/9To2Yowb5ULwsnm3SWcbz/L5dvv0I6r4615JeVeygaUmApzYNhro=
X-Google-Smtp-Source: AGHT+IHwnYI6aQUN5niq+p3GV22og99nps2TIrvcZsJ9RQS4EcweaFT20v9shYv84TmFYHBVbpQNgA==
X-Received: by 2002:a05:6a00:130b:b0:6f3:f963:505f with SMTP id
 d2e1a72fcca58-6f6d6041560mr3666544b3a.5.1716418007004; 
 Wed, 22 May 2024 15:46:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f67a1b1c17sm12386129b3a.138.2024.05.22.15.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 15:46:46 -0700 (PDT)
Message-ID: <39f33a5d-a9fd-4469-ad6d-ca0fe844f571@linaro.org>
Date: Wed, 22 May 2024 15:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/ppc: Fix PMU instruction counting
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240522040411.90655-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522040411.90655-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/21/24 21:04, Nicholas Piggin wrote:
> The crux of the problem being that dynamic exits from a TB would
> not count instructions previously executed in the TB. I don't
> know how important it is for PMU to count instructions exactly,
> however for instruction replay this can lead to different counts
> for the same execution (e.g., because TBs can be different sized)
> and that blows up reverse debugging.
> 
> I posted something on this out before, but missed a few things
> (most notably faulting memory access). And found that forcing 1
> insn per TB seems to be the only feasible way to do this.
> 
> Sorry to ping you on this again Richard, it's not urgent but
> you're the guru with this stuff and I'm hesitant to change it
> without a better opinion ... Simple band aid for the meanwhile
> could be leave it as is but just disable counting if
> record/replay is in use.

When we unwind, we know how many insns remain in the tb.
With icount, we adjust cpu->neg.icount_decr.u16.low.

My suggestion is to change restore_state_to_opc to pass in either the raw insns_left, or 
the inverse: tb->icount - insns_left.

That'll be a trivial mechanical change for the signature of the hook, first.


r~

