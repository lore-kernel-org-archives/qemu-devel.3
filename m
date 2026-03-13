Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F57107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Wl-0008I5-5J; Fri, 13 Mar 2026 12:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Wj-0008BE-D7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Wh-0001nC-Tj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so12093205ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419894; x=1774024694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fx5QHAc4gOLIGojOyQ4WXRv+/EpMdh9bmmiCzU8i/Bg=;
 b=WK44wSlCuyQDSVW6SAxjrXCpwpyEVL8nIxRkKKNfo66HCh4M3Vyfx8u3eNtbQdrK8q
 KqUWTTkLgMc+Aye8df4Rnwc/75fGTfmL/bIXRI2nS2hBLQZK6RxLcucJRaGIaZSMT0i6
 7bRnywGLVHQEWy2zV8zKDyCy8WzjKVXc8aXxA6ixFiWtMWNT2qQpOnuLCoA0EmmnTAFE
 Ix10oHte6/wCSACy3Ag0+905vVIYxUiFIgXRd3eqZeqd0DgVyDuPhQaboDPVPAqf8Ukm
 qlvd2R2ZOzuFeFCK3RnDqCZHwmmmj21ahfDVkbdZHFUSQC4uYSKUmZqHjfr1jWTYx4Q8
 jtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419894; x=1774024694;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fx5QHAc4gOLIGojOyQ4WXRv+/EpMdh9bmmiCzU8i/Bg=;
 b=m+R03x7+5ZpyIoHp2UGut9/wBfR+I/bcvGbRpEMB4i0ujcp//3f9UpFu+HvvSdq2Rg
 IjeH2mTV0o6gh20j4f8+7oS+9gvpm7eVRZX3uxefBGqXx4TFND9F5tkpb0HAq6zPT/lx
 90vPg//3DoZphZuQfq/4JgJg6aqEGHkzMUCc1VGzufHqaQAiA3pPyaBp4j4YypqMapa2
 t+g2BRu+GlyO3HvZvPF30EiYPj2DGXnfRnjOtAWHVa7H18ZLWlXIoAe4+RKjsmEMyYaz
 bYVvrYSvMDBr8ai/0GKI2BR2g78/Nekur5M48FNxjhG4GTHWVweMOU5oI71BAjOJyjPp
 QSWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwtgylCPqRAoe+WcsACCBr0SaF80ijST9RzNo0ZMiPqC6eAkGvX8UhKGm6SSLqqKg1VfzdjZ+Tn1aS@nongnu.org
X-Gm-Message-State: AOJu0YwLaf5BTb3TXhDOIEv1RdKLe4dhkKATRyItfyE5YaeGAFG6hKoz
 XcA95lR5lERL6xeN/7XMxPz2rXHc1RaJVazdFhxL6ualhlnrtl6L8fwTxffuoCN+BzU=
X-Gm-Gg: ATEYQzw1aZ9DXGrHOaeYf6Ix43hXDXtagOpvqn/3DOvul8uduf2Lw9evJ1ZLRmMmhK8
 aaWl11oOUuZbvwTofexczWkxleFWWE9eV9eRsTVczfpX3TipKWDIB0TSuO+BJ4vt/PTyz8G5kCG
 gg5P4LkSlZ+V1CqCoIvx5wUBbaIanDFr637h4bJX8ZHFk3sYECgAjMKh8pSYgC3WflCn7vGZcxk
 Of7L/4VE9Q3x912LdG1oR3q/rIaQNozsHx8qmjXfpozxddTS1g24FKa03NB0jH1s8zVxFowFK67
 ceWWP/ih7PpUaXKr+4ePgiADEO7PdbqexkGuictfKgCDV6ZanNWHZ5dUSh0fyGHp2zxhIpboe7R
 DL3eQ3Na1bmwT5XTGPSsmJKM0p0WD76QisvM9BVUkDKqwSuJoWF9HvzrsENfI+NC2PfGmDCEcma
 PeoeSnJI2JVJ4J+oaZ6zjHbxzA1l4GAWiiCeU/w9LeoceeML2fitqh/1Jkg+A2hzoTq5IMyMK9F
 qv2SgQ=
X-Received: by 2002:a17:903:22ca:b0:2ae:c983:96d0 with SMTP id
 d9443c01a7336-2aeca95f9d9mr40519175ad.13.1773419894301; 
 Fri, 13 Mar 2026 09:38:14 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece5c0f7asm27655275ad.22.2026.03.13.09.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:38:13 -0700 (PDT)
Message-ID: <51c0f3d9-4f3f-449d-856e-b14eb6f19896@linaro.org>
Date: Fri, 13 Mar 2026 09:38:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/38] target/s390x/tcg: Include missing '*cpu.h'
 headers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "hw/core/cpu.h" header (declaring run_on_cpu_data) and
> "target/s390x/cpu.h" are indirectly included. Include them
> explicitly otherwise we get when refactoring unrelated headers:
> 
>    ../target/s390x/tcg/tcg_s390x.h:17:44: error: unknown type name 'CPUS390XState'; did you mean 'CPUSH4State'?
>       17 | G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
>          |                                            ^~~~~~~~~~~~~
>          |                                            CPUSH4State
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/tcg_s390x.h | 3 +++
>   1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

