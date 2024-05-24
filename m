Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86359C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWVq-0006U8-M6; Fri, 24 May 2024 11:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWVo-0006TE-If
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:07:16 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWVm-0002WA-W8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:07:16 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681907af4e7so809293a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716563233; x=1717168033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKaGsM2D5wrEwKzfRI4yuKdgrTC8194YagWxYfnVHRY=;
 b=cu3CkafoWV5a/KAbE39HuDeHBfg2CyXahdcsyEYfrwh6GV/aeSuyGOsw76PmnQQnxc
 F9Y/01NMX7IOxbfFvEh7RYbPd/npbS0N0zPC6BenwHhhICZmSr10agRJsNRgajbMJ38+
 CA2AYookU6vdZWnNgfliPR+GKmj5Ge3DfjFF42DiXzEJZNdbm4hjS/onA879clyLo4pa
 PCJUbf6bCiV9R5cIc+JeDZFYHe1akCVJXo9RWsoy81pEjx/nhwvmfDuOU8EQWRLv0oba
 RTVlzQH0q7SPQgGNGFVUvaESdNXvaiz6WXPvt+uNfy11FnbLiH5xxzEStqnl0bsbnXAQ
 LU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563233; x=1717168033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKaGsM2D5wrEwKzfRI4yuKdgrTC8194YagWxYfnVHRY=;
 b=BhpIXuN2KVJj/EbmR9IkUBJ5POPFEBhJnlsnnUqLBnmnW5sfTV6lh1pmRhtAiAxRab
 rxhPpRgYoEF8eDBL2EFZy3pVEo3IYmvyHJQeoaJdBUz91k2ULpCDU9V9Z3LSqpM5iASs
 9M4+veIo0hfDvVZwBot54QLpyJfj5SegaHG1x3stZelnec/EBL22pW0PUXl2PsgLLbNa
 Nct3GDduTJUyI2XB6eVJqP/qjMm7LofzMzlhTOJj0PxwRFSNMtuMMDPgFC2YN7j62BGH
 kBTN4tkJxLO8liyCkQPfnz9yOsP/72eqJWjdgAEd8nzRPpevCZ2gv1AxHFoVOoCUHUAE
 Xr5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPMCtqVOoo5eDSqhzyfuR9xnAAAjpwMjkOmFMdRQw0M+RyfwkADsTdZgEYo/3v2iydTFEW1JzvtMAPQppANVqgAZ8fmqI=
X-Gm-Message-State: AOJu0Yw6GgDEfwMBr8+9w/PPwo2i5OoZAEFyYYKg0myK9qavKgJ/MysM
 GQcoVIXGB4IlTYPmPfr1DuOlDtd7D4yg0LPiYpMtJDZdkyaRm9pODk8scltMKb9n6UANejQR8d6
 9
X-Google-Smtp-Source: AGHT+IE9CpYctvXeNTWBYLoF47FVizu4AIdCZtvwxaLHMyw9lI9rKHpcgNq/Bqkv1NXuAcsD/xu06A==
X-Received: by 2002:a17:90a:ce13:b0:2b6:c651:68b with SMTP id
 98e67ed59e1d1-2bf5ea3c274mr2304545a91.12.1716563233059; 
 Fri, 24 May 2024 08:07:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f09194sm3384890a91.28.2024.05.24.08.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:07:12 -0700 (PDT)
Message-ID: <bfe91c46-e37d-4650-8d2f-7745b535754e@linaro.org>
Date: Fri, 24 May 2024 08:07:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] target/i386: set CC_OP in helpers if they want
 CC_OP_EFLAGS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-17-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Mark cc_op as clean and do not spill it at the end of the translation block.
> Technically this is a tiny bit less efficient, but:
> 
> * it results in translations that are a tiny bit smaller
> 
> * for most of these instructions, it is not unlikely that they are close to
> the end of the basic block, in which case the spilling of cc_op would be
> there anyway
> 
> * even in other cases, the cost is probably dwarfed by that of computing flags.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/ops_sse.h        |  8 ++++++++
>   target/i386/tcg/fpu_helper.c |  2 ++
>   target/i386/tcg/int_helper.c | 13 +++++++++----
>   target/i386/tcg/seg_helper.c | 16 ++++++++--------
>   target/i386/tcg/translate.c  | 12 ++++++------
>   target/i386/tcg/emit.c.inc   | 22 +++++++++++-----------
>   6 files changed, 44 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

A helper to set both CC_SRC and CC_OP = EFLAGS might be nice, as well as beginning to 
remove the CC_* macros, and thus the implicit use of @env.


r~

