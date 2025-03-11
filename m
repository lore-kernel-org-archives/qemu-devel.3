Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09328C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tru0q-0001kc-1o; Tue, 11 Mar 2025 03:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tru0n-0001j4-3A
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:26:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tru0k-0007fE-AQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:26:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so18092825e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741678002; x=1742282802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixQm0MWjxG3W9XU5tOCfvUKz5fda/FdNvvBHZqMnUSI=;
 b=MltIaAoKRydnfUGmAN6i7p1qBdEQyn2IgjUvyquc5pAUuuNcTZcF/NKnSsEMbQI3l6
 6t3m5NHyWgEQjuOaQFvSh1ox/x3WByjvbvBO23wt/bh9Mq4g+AknmND/qQQHrsg2y/hP
 xDhauptNEJm81vz5VZulh4gxaT0QKbwJnrqOLRobkI4NwUOfqMZ8P+S8PNZ4RFAyI+m4
 fAMQvU3ZGznQuIKf04FLRvy7xPmCiW/YRti2bn+PUPjpuqtzBAHySucQoE39WJ+Zz9xk
 xlgAAuj45A9qLy9mZUsj9G/cguFBVayFSjP7K1LrBFCOKjN637D6r8+cUNMZNDWWVqIe
 Xt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678002; x=1742282802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixQm0MWjxG3W9XU5tOCfvUKz5fda/FdNvvBHZqMnUSI=;
 b=FyTWgeambYj4LSVoEYxV/XPNjzUCfKahLxQz/yZR7S22SHYBlp7bN9v6iAO7BeEjgo
 Rul74QO42m7lHsAGrA6OvAaRiBJCadQ0v7B5jussJHEQYOY7Fk7DB2zptb6DYlrDbEMi
 QvdHtGv73KdvhFXMQZfyNpDWd0BPPv7x0hpE4I0TIDlZRn7Xz0X7B1/SHpFVUVBqHXCs
 UEehA3aNBPeR4AcY3J9hFrW0qC227PKspy5DwvlzjWrXqlO+NLqrOibza59YVESzVJYv
 VDwRXCKiHxVgEa9ClQ7VP+/8XJpghDc6WetiAoRnDf9rAEkKp4+aUc8DQhuvY3YHPtuU
 34ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDwtns+xK4RokXLTLgg3RMLdd8QCx98uNfBnwFggONXx+FPAI9uW0Wo1oxPi0n1hGQ9p864gov+3TN@nongnu.org
X-Gm-Message-State: AOJu0Yy4p9KURNsBfgNRxL4IF5ir73tQSWaaV3RWGibKOsSAdrpXaXpy
 rnaJtwG2lOoBfh/IX9AgbC4RUcFMLlfmFO0AaDpTzLR0vX77GURa5vsLwl5v3x8=
X-Gm-Gg: ASbGncv5TQjsl/dNrhWQ25rpx1fkigKixrhz72LfqDtcTiCxhEWy3otGFKzSqMErDSZ
 SlFl5k/1of62YvO8TjFM4HqrPDdaT5uF5pAsb7LfJ5zWNEY9CnlRPKBzSOhfqs1Kps52A0Zkj3L
 jW0H337oc2sOWPb/1ZnZtVozYr89jKAF1Qapwzg1mO+NSAOcDoo0h7BWKy/RnCqmE7n1pH9u0sx
 ae4AtMxv2KGBPOB+gXViSu65I0kFqPKOuKsy56aHpsCy2wnqXIHWTjQXh9BSxJt2UT7e/LfHrkT
 6XjIuvFTf/ju3/y1PgwKez/4GneU4iPhtvX9L8nwdJnWBMJtrZ7QmftUBGND2haFBBSuiujXTB7
 zDJqT36MbCWZC
X-Google-Smtp-Source: AGHT+IHkbKwZ85r50y8SupgnjoEiG0z2vsuYpmQ1kXDuNtR/J+NTZlfd2MeQZu55SLcc8fFLvUwdtQ==
X-Received: by 2002:a05:600c:4f16:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-43cfd72f2ccmr76596325e9.11.1741678002154; 
 Tue, 11 Mar 2025 00:26:42 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d025869e7sm19373395e9.7.2025.03.11.00.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:26:41 -0700 (PDT)
Message-ID: <9f92a783-3826-4a06-9944-0e0ec5faccc9@linaro.org>
Date: Tue, 11 Mar 2025 08:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] exec/memory-internal: remove dependency on cpu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250311040838.3937136-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/3/25 05:08, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Missing the "why" justification we couldn't do that before.

> ---
>   include/exec/memory-internal.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
> index 100c1237ac2..b729f3b25ad 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -20,8 +20,6 @@
>   #ifndef MEMORY_INTERNAL_H
>   #define MEMORY_INTERNAL_H
>   
> -#include "cpu.h"
> -
>   #ifndef CONFIG_USER_ONLY
>   static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
>   {


