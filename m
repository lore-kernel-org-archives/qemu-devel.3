Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC9AC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctPl-0003Tj-Se; Fri, 18 Jul 2025 18:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsr4-0003QM-64
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:42:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsr1-0006pg-T4
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:42:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so2186414b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874974; x=1753479774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ufdx4xxhZMofN0dIAo+3KTserIonnoVFQtsNEaBzaCg=;
 b=Y6FqkAbWATUUJTa3UFI3xvaCzxDKgtws7y9ZWH/nE3g69KyvZpWAux69HvvkiJHHUz
 CEg6inKhJ+kf27ZTP7KZlRXJbngJSSinxxZ0MBwX3ogkzbUchDzgOtuGtompjdFbQ2Kr
 WzloXY6/UrINi1s0P+ZqX+sHjlu4Lhb2gkCAK9lLwP+cWLT0tconHLkY4dMp2FSRyc3G
 Tkx1yu9IhNl1rl6iQHS4cazH6znP5AjeFqANifbLX5IShhgvMi6MiyaT1uC07NijqJxx
 7agZRRR282wbwFVMpOaxTeBwaLk+bDpvKSs2fmaFlWgIZ1O5FfG8zx4PoCzE1AZGLnro
 0WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874974; x=1753479774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ufdx4xxhZMofN0dIAo+3KTserIonnoVFQtsNEaBzaCg=;
 b=bG9Ea+Znx2Dhj9hZOB6N77G3bOwZG+IbppjUw0pkYHyER4MXWEgVrAAYhyIzll8xmc
 xp2G1v8Z1tVIqras9bpqmgIgHw0/3F6njWuOtW/tjRJiqwikypHXsyWtdUDG58BK2vvw
 zQ5tnWzmbQNzuGKskuEu1cuqMg2gkicvh0dWelJbdMx2hlB8gKRg9VGrNou5BMUI/xGL
 PLwGAlfTMw6HwPd/BW7sEQDb9/EN8ec935MSAZU5BthFiTQFCoguBY7PmFrreZzduZrI
 WkOVcu7xpijm0KsBFrzj9xtyndFyLiuqvvqgMSig0Cbvs8jq+LFY/55xNi5y8ljlKlkd
 feuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC2TrPek1zNGSWMl56szWMpXiQ2wTh8oNLmSKwKH7XtgtDCsItI7TXCuvrvukugbVeFjit7F+784Hz@nongnu.org
X-Gm-Message-State: AOJu0YzlDt9cP2mTCoUIl0SgOK+jsYcOULzT9Bi9jIZL/yLCHJTVkua2
 IjXPyOlkRWYfVjaHTlPNrPVxQaVsVBY0hIRIy8K/WBNBUIwZ4v4GGeAO1Dd8LMq0GBKBG00mwUB
 Td+Mn
X-Gm-Gg: ASbGncv2rd4IKmmpdckNsYjueKszEgWXs1ynQbQn5AAK3rGSg7cmwoq4m6uAhkxsPb3
 bL+rD01G2lNI3OylN5nhY/gir0VBkeplZl0ySkLx+wm2FiPiU049L56+TUZB2ZcOSXQDJJVWsPe
 W6uusF9R9gGs19mijmKBWAkwnyCbfhLV+9hEHnhCM+qDWVxbX4R4YXlG0udJV+MlCtt9uS6kyMX
 MNEut2EbD6AP6y+26BVbADw2qYAUQ7XU6eMGRBEKYjCoX0klwbj8y+Ba8dxLIZZo+8Me9rFIDXV
 3u2wgPXq3yql8jkwq63pndu6AYTtQ6bCSSCg+ZiUC9t+7QfkT5jRnIOim4q0ZbTAlberTXFZCsf
 ihvv95GJwIf4Z5Y5PPMidwN/eK325eRBXAV3h3XMMUg==
X-Google-Smtp-Source: AGHT+IHNDbxxoZTE+28o/ABoJ51dTPcYV0FCOaJtZKmPadychhrimyPsPK3o0uZSyQXOvFt75rz3uQ==
X-Received: by 2002:a05:6a00:1482:b0:749:bc7:1577 with SMTP id
 d2e1a72fcca58-759ac028ba6mr6470382b3a.9.1752874973866; 
 Fri, 18 Jul 2025 14:42:53 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbd66eecsm1769772b3a.142.2025.07.18.14.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:42:53 -0700 (PDT)
Message-ID: <55901ee6-0df8-488a-8d38-bb88b6da77d7@linaro.org>
Date: Fri, 18 Jul 2025 14:42:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 06/10] target/arm: Add BFMLA, BFMLS (indexed)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/18/25 10:30, Peter Maydell wrote:
> FEAT_SVE_B16B16 adds bfloat16 versions of the FMLA and FMLS insns in
> the SVE floating-point multiply-add (indexed) insn group.  Implement
> these.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve.decode      |  2 ++
>   target/arm/tcg/translate-sve.c | 25 ++++++++++++++++---------
>   2 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

