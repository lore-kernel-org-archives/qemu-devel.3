Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23330C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 22:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZHYU-0004Wd-Mx; Wed, 31 Jul 2024 18:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHYT-0004Sb-B9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:12:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHYQ-0004sR-Hq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:12:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so1023450b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722463937; x=1723068737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GWvR2Jfw2jgkLNBIapIW04dsIj4XUJm+NF/jsDAElwQ=;
 b=oJnRWeIIamcs25lQDkQ+o7gbOxeO0xcouAv9Atf4dRc8yNdjwYRy51N01W3MbsK9nf
 0jwnFBQjJobh0aTlImFH/F6c/sHKkoqMdCIBqGjVQ+DB0FqjiGnHoQ5leGUuoGHQyagX
 mz5rlolro4Wpnx7BH/GKY7gEGEWzJ8G4ASAyFZRUegQcHU2HbXvt95I0v+/TMFaJGynZ
 00k1CFN+1s/ey56w90NdRKzw1h1iVAsif0lToFLKlzZ8yI9uCuwM57cvg6yPNpm7VmVh
 drSij7HGKFbvqqqEbcw2rBQ5K0QYUgPbBEoEwLVrHClVeT0S0DLHBZEv/b4W5ouwYIff
 FB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722463937; x=1723068737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWvR2Jfw2jgkLNBIapIW04dsIj4XUJm+NF/jsDAElwQ=;
 b=gRVBj56zDMF5IkCoYB2T0zCHEeQW2qB4hbC7EN6EsF648YzWpKoEGS2iuzSkKcH/oR
 cB0PTF6v0cX+slLFjJJ3w2S5WjFUg85Ms1csXEV4xbnPXHJaQnivhNNr1DBM4cGFq8mc
 w0ytbQcfRwWeBamauG0usjHLKZpUF/S2bbGz9OOPg2oB3uRbtW3EXhaLy8CJ55adhTU8
 +M9a38Gxy8yhZlfJogOs4yTbfUndomQi8HurbHoJOUYRCZSYju1ELBevNyCcYY9oGo8L
 Gzfwgx42Vy840WDm8pPKVWWA3ujqjF46eWYfBQDyfw73EgjLwu32chySE3U/xVn/qNjF
 InoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVejjZ+/he9YLmCAIBXQQ+59xpoEP8TeIjfOtuxnVY1Dt/RLUTwIkjWdXmbNx/0gnFAzXzP7xMIXgBJVE6uv4euQMeLys8=
X-Gm-Message-State: AOJu0YxHUwkKGwYTTy5Ku6OKHXW14WbNCY2C5PwCmV96Mp0XgIlkrbMC
 0PkwNC/aCIzRF21ex5dsHOtRhSCMbmmnk7QiC1Y9DWpeVpD+e/d/01YbEl527gZ/ymQcrkceDu3
 hL87FkQ==
X-Google-Smtp-Source: AGHT+IHXSxUkQQJ34+UZB26TpmSZrQrGvY2YWKW0tirXnr9NMkeJ3Qyjy5iG0YicA5AvPlnf1WJUAQ==
X-Received: by 2002:a05:6a00:641a:b0:70d:34a1:5ccc with SMTP id
 d2e1a72fcca58-70efe4bee1fmr8825572b3a.13.1722463936833; 
 Wed, 31 Jul 2024 15:12:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead7181d5sm10406228b3a.88.2024.07.31.15.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 15:12:16 -0700 (PDT)
Message-ID: <fa0e81ac-3356-4775-a8a6-395ee5cdfe45@linaro.org>
Date: Thu, 1 Aug 2024 08:12:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Set ctx->opcode for decode_insn32()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240731100953.14950-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731100953.14950-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/31/24 20:07, Ilya Leoshkevich wrote:
> divdu (without a dot) sometimes updates cr0, even though it shouldn't.
> The reason is that gen_op_arith_divd() checks Rc(ctx->opcode), which is
> not initialized. This field is initialized only for instructions that
> go through decode_legacy(), and not decodetree.
> 
> There already was a similar issue fixed in commit 86e6202a57b1
> ("target/ppc: Make divw[u] handler method decodetree compatible.").
> 
> It's not immediately clear what else may access the uninitialized
> ctx->opcode, so instead of playing whack-a-mole and changing the check
> to compute_rc0, simply initialize ctx->opcode.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 99082815f17f ("target/ppc: Add infrastructure for prefixed insns")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Accessing opcode from decodetree should not happen -- divd needs fixing.

But I agree this is a good short-term workaround for the release, so:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


