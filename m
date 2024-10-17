Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B63FD3C526
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1UZ8-00049K-64; Thu, 17 Oct 2024 13:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1UZ2-0003zW-8z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:45:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1UYz-0002gG-5U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:45:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-208cf673b8dso13315375ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729187126; x=1729791926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFywNcmcgJ43zcWJxMMnwWB3PbNft5Hk5Q8Z5UGMiTY=;
 b=xF0Y7K0W2iZ978UH3LkKGd96fMpKtGsE4Ds/3NN524sBnUoUPAmod5kgI6xXKHEFaJ
 1j/hGCVQaH9sBsqoB8WKjqIxAiBlzvQaPCRAF2UtZggRXDNSkZU8k/BJ8SknJCuXxFvD
 o/ANQ5B6W3IXBz6Iejizf3vGEUaV072asbjJ6ccVZmka/oM5c/xOQbA9l6UoxwiH72/J
 54inqhGGdj879gQuXSomUIT93FiCS8eOZ3yTeDBw5j+ekRkWoSfugHPbCenW41nyENzK
 1GMbSxXTFcyA6VZ0Iyt3OK6z0W8ApPY5AXSf50EiBvmmRoTHJVqiVZ5zcYRnUDc39q9w
 eVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187126; x=1729791926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFywNcmcgJ43zcWJxMMnwWB3PbNft5Hk5Q8Z5UGMiTY=;
 b=etVMECZZw3cynYdjISjQehyGZuc2rFB5POWE1DR2wB1iQoD6615RPoYEkNEbj3/fdf
 IxPbOh29lUtjtqKJoo7nzngDjGJM/ExAQUikHjTi8IMEQScWoXNc5IYiLnQ7bLZHBYJM
 hKTskgR74ehF0aiSSsg/BAuX7UMbl1ezWpieGK2yxrsVw6qbxYBz0GXnHBZn6mNmYLk7
 SuQAYz8SRqlhucZGHkhB1C95aVIjnewq0v3a+5no+RbcgrA/hk05QiCTjIahINscaj/j
 TxAZSw69AA24cTLXrSrxpr+yLX0Iy5R9i4Fcmf7YSRwsQ2ttlwHa5kFeyr8D8rujccuq
 7QhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHkKB2MPt4tjdPY1mW8w6+X26962T1hglpKy1sEqZEOROpcWb9F9F67IX6fYMTULprHL6PAoivPxdS@nongnu.org
X-Gm-Message-State: AOJu0YwIXuG3GZ1MAoMIdifToVUpWOgz7yIENusQ/wYIx+lVbigtxIvY
 FsKPIDMXLj3zYg0cK3OYR2BYrwLWZc8kkugnr16iGQSn60HDdSwPIlomLgRbtmM=
X-Google-Smtp-Source: AGHT+IFyl5lSOwvMsVrqNXpZ00oTzZ1ZeS1ntsSpghFB+UPqHwRlzP8u1RQt4tNXhd2CNJ5PRHnHdg==
X-Received: by 2002:a17:902:d4c2:b0:20c:5a64:9bc6 with SMTP id
 d9443c01a7336-20d27f3fd11mr142530235ad.50.1729187126570; 
 Thu, 17 Oct 2024 10:45:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f9d436sm47180995ad.84.2024.10.17.10.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 10:45:26 -0700 (PDT)
Message-ID: <42ccaafa-888c-45c2-9d60-d2aa66f4c833@linaro.org>
Date: Thu, 17 Oct 2024 10:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't assert in regime_is_user() for E10
 mmuidx values
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241017172331.822587-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017172331.822587-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 10/17/24 10:23, Peter Maydell wrote:
> In regime_is_user() we assert if we're passed an ARMMMUIdx_E10_*
> mmuidx value. This used to make sense because we only used this
> function in ptw.c and would never use it on this kind of stage 1+2
> mmuidx, only for an individual stage 1 or stage 2 mmuidx.
> 
> However, when we implemented FEAT_E0PD we added a callsite in
> aa64_va_parameters(), which means this can now be called for
> stage 1+2 mmuidx values if the guest sets the TCG_ELX.{E0PD0,E0PD1}
> bits to enable use of the feature. This will then result in
> an assertion failure later, for instance on a TLBI operation:
> 
> #6  0x00007ffff6d0e70f in g_assertion_message_expr
>      (domain=0x0, file=0x55555676eeba "../../target/arm/internals.h", line=978, func=0x555556771d48 <__func__.5> "regime_is_user", expr=<optimised out>)
>      at ../../../glib/gtestutils.c:3279
> #7  0x0000555555f286d2 in regime_is_user (env=0x555557f2fe00, mmu_idx=ARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
> #8  0x0000555555f3e31c in aa64_va_parameters (env=0x555557f2fe00, va=18446744073709551615, mmu_idx=ARMMMUIdx_E10_0, data=true, el1_is_aa32=false)
>      at ../../target/arm/helper.c:12048
> #9  0x0000555555f3163b in tlbi_aa64_get_range (env=0x555557f2fe00, mmuidx=ARMMMUIdx_E10_0, value=106721347371041) at ../../target/arm/helper.c:5214
> #10 0x0000555555f317e8 in do_rvae_write (env=0x555557f2fe00, value=106721347371041, idxmap=21, synced=true) at ../../target/arm/helper.c:5260
> #11 0x0000555555f31925 in tlbi_aa64_rvae1is_write (env=0x555557f2fe00, ri=0x555557fbeae0, value=106721347371041) at ../../target/arm/helper.c:5302
> #12 0x0000555556036f8f in helper_set_cp_reg64 (env=0x555557f2fe00, rip=0x555557fbeae0, value=106721347371041) at ../../target/arm/tcg/op_helper.c:965
> 
> Since we do know whether these mmuidx values are for usermode
> or not, we can easily make regime_is_user() handle them:
> ARMMMUIdx_E10_0 is user, and the other two are not.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: e4c93e44ab103f ("target/arm: Implement FEAT_E0PD")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

