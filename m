Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C2EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0eu-0004d0-Le; Tue, 28 May 2024 13:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0er-0004bd-7i
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:30:45 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0ep-0003Pk-Dw
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:30:44 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-681a49e6e86so720348a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716917441; x=1717522241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ddoEk8SCUGeJcFxzW+97wHAXgv6KKxC6gZU+3qXMuSA=;
 b=i9+AKViHTi/a/iS04hB/6+1WyNz59ZVvALfvF/qCxBbHVeMfDs/ebmqLleu5c7gRad
 Mu44gwJsLkwJE+YtGLdFHZGzpE62EJPBk/zVhFf6KmC5ClUp36hwfk8p07W3XLQ52vjN
 CkJ1HtFvNeFSgYVdEQaaKguQGvrUnSyKetNfGeC4c81p846/w6NvzphLKTuGPGOtKBdw
 1MalWz08qPFMF9qG8zzegBX86JhLQ9jNmYFmFT0+ACvxgaif12CwZEDnpyyw67io4NWm
 uW6bPGG8ZZea0FPf3h+RY7oafGiqX7Z8NCVlEyZ88yGJw+lneS5w38h8F3X+OmUhzJq5
 a13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716917441; x=1717522241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddoEk8SCUGeJcFxzW+97wHAXgv6KKxC6gZU+3qXMuSA=;
 b=BFvt6UwDqAvMdQSH0ElrDQTUcY40XlQgzt12tYLy+lgSzjQextzIIk7y8KBrHKvhYu
 w+WTGpeMvVhCWYNhWn/Rij5tXR2zgGDmSzQ9b3cAX9fHQLrXpDdTD2nnW5obTMxhp6pD
 syMVC2jxHKltQ3Dlnpe5S8dAT/rmSif8QHmXAFb3t6W9ZZQ8o9p9PLYvhnDco845943B
 dXxnEwFcvFi05FoDUNR4+tkXyPHmfPgRmGWg9958w/g2IBFDq/n+/1R3SX0t14bW4pp7
 SZTa+VKS9mxkWUSp7HzpMBArQtFK0wRYmA0vP1pyg+jdT6F2yAIr0o9ZJtyB6Bm5WoGE
 T+SQ==
X-Gm-Message-State: AOJu0YwKisguQWiKtofPY/tDJz9FtMPb+G/79O9dl3DmuJF/FBB9X22V
 JzUvg6Fn0gf1V47ZzEa6QdEjVdj16F+E5jZTugIzCnpoclM6gf8lSkbYHysIsTSdZav5TxmUXpO
 d
X-Google-Smtp-Source: AGHT+IH8acP9wVaB2jRKu1xS1EA46dQclNNqk763PU+DLyVHN5umShmr3l/zHwFiPEJAC6rsVq5DnA==
X-Received: by 2002:a17:90a:688e:b0:2bf:9ed7:a7a2 with SMTP id
 98e67ed59e1d1-2bf9ed7aab8mr7805931a91.23.1716917441315; 
 Tue, 28 May 2024 10:30:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c00f389824sm1765562a91.1.2024.05.28.10.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:30:40 -0700 (PDT)
Message-ID: <0d61e5a8-84ab-4379-b58e-364d929293bc@linaro.org>
Date: Tue, 28 May 2024 10:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/67] target/arm: Convert SRSHL and URSHL (register)
 to gvec
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-45-richard.henderson@linaro.org>
 <CAFEAcA-4xMXjVZFGbDjefNabHn2MW=4jFaYD79iq5oV4qyXafA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-4xMXjVZFGbDjefNabHn2MW=4jFaYD79iq5oV4qyXafA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/28/24 08:51, Peter Maydell wrote:
> On Sat, 25 May 2024 at 00:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/helper.h             | 10 +++++++++
>>   target/arm/tcg/translate.h      |  4 ++++
>>   target/arm/tcg/neon-dp.decode   | 10 ++-------
>>   target/arm/tcg/gengvec.c        | 22 +++++++++++++++++++
>>   target/arm/tcg/neon_helper.c    | 38 ++++++++++++++++++++++++++++++++-
>>   target/arm/tcg/translate-a64.c  | 17 ++++++---------
>>   target/arm/tcg/translate-neon.c |  6 ++----
>>   7 files changed, 84 insertions(+), 23 deletions(-)
> 
> 
>>   uint32_t HELPER(glue(neon_,name))(CPUARMState *env, uint32_t arg1, uint32_t arg2) \
>>   NEON_VOP_BODY(vtype, n)
>>
>> +#define NEON_GVEC_VOP2(name, vtype) \
>> +void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
>> +{                                                               \
>> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
>> +    vtype *d = vd, *n = vn, *m = vm;                            \
>> +    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
>> +        NEON_FN(d[i], n[i], m[i]);                              \
> 
> Does this need H macros for the bigendian case ? It looks
> like we use it for smaller-than-64-bit element cases.

The same operation happens in each lane, and order of evaluation does not matter.  So, no 
H macros needed.


r~


