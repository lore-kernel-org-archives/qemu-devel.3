Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B2C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJWA-0007mk-U1; Tue, 23 Jan 2024 11:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJW9-0007lt-0v
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:20:53 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJW6-0008Hy-Ib
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:20:52 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6dd7b525cd6so582144b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706026849; x=1706631649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pn04OMQMlQSwCcJHQ5cMYbx+ikgt1jnLNW8k0MO7c6Q=;
 b=j+aHKRwffFpOQAfHvlbXiGaV1BtvWI8ZcPpxY0csknZ8je8lQH5QubvpXLMWTATQ5m
 P8y+ydHoNuK/PvOtqoqymElwTjRmiZsubckv/ZwRjlvAZ03MIHbSoPwvSMPxOYn/QJ3K
 AXApttKdmgIZdiS5QRyeVf602l8pmPKz3Jj9pAFG9ZTSxrvZ3sZ4KFJX/Hukm4ut2reB
 qQXQeAaPGE2gcliZmT9CFU0FhY2k3Ft8D2cW+3w7+Eh5DhPA/DGmsZB58EeJm8GY0itV
 +OXPkSUXrNRluW7WOuVDJ1hb9Db+BeMzzK+SJhLGxk0OhfJB1mOX+6GwVxxTJGamwu4v
 OUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026849; x=1706631649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pn04OMQMlQSwCcJHQ5cMYbx+ikgt1jnLNW8k0MO7c6Q=;
 b=qv3vrTo0te8abNR54qEwps68Od8niHcY7loUNT/Ek/fwUBVQHhj5qy0844EYAZNFnJ
 s6F/69cErtXmjtHpbgYcAuG/8cEW5NfEYB6R05T19w0JN7dXxvQLgPV/dUNkjzHP6EUM
 2l/F8nGEunUCfnXKej7qcUTJq4WoLTP8MBIRYh4o61AGB9TV02PUib1yoIoIe72gBH10
 WozMs4vui4iJLPo2OT6nB+nUF1o+nSCUAW5GwcOqMfMrpNwX6XWtSdT8c0vz4HXCJk5W
 45QDGVyk0AQb7XRT/Mx4sGsrAEtr3+HBhDbD3pNsgZ4KHdDeP6epJ8kRGd18Yu7RJIOA
 mx2Q==
X-Gm-Message-State: AOJu0YzC1HWOX7igvzb+CvbDAadlxeZSvJikfBFZt8NkrE9r5Xq9RP/J
 8rqfSDcmHc+3Gzzm25/0UT4U7WahJdBx52NKOdTocueYfI8konmm+6wHEjw1kGg=
X-Google-Smtp-Source: AGHT+IG8pbBfLTH66a18ZX3+Gj45d+NBy9vK6I8DrG67uUiea0AfWj3UIFFUPMAIpWm5d6U+a8e8XQ==
X-Received: by 2002:aa7:9902:0:b0:6db:e731:5ecb with SMTP id
 z2-20020aa79902000000b006dbe7315ecbmr2546935pff.11.1706026849119; 
 Tue, 23 Jan 2024 08:20:49 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:94f0:22fe:dda1:1842?
 (2001-44b8-2176-c800-94f0-22fe-dda1-1842.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:94f0:22fe:dda1:1842])
 by smtp.gmail.com with ESMTPSA id
 r28-20020a635d1c000000b005c67a388836sm10226073pgb.62.2024.01.23.08.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:20:48 -0800 (PST)
Message-ID: <2fda5397-0fbf-4d07-8674-3ad7a1d8c209@linaro.org>
Date: Wed, 24 Jan 2024 02:20:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix incorrect aa64_tidcp1 feature check
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240123160333.958841-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123160333.958841-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/24/24 02:03, Peter Maydell wrote:
> A typo in the implementation of isar_feature_aa64_tidcp1() means we
> were checking the field in the wrong ID register, so we might have
> provided the feature on CPUs that don't have it and not provided
> it on CPUs that should have it. Correct this bug.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 9cd0c0dec97be9 "target/arm: Implement FEAT_TIDCP1"
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2120
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

