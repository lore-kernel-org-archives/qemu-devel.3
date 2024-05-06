Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A93C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41e2-00087x-Fg; Mon, 06 May 2024 12:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41dt-00085I-QV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:56:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41dp-00049P-3z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:56:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f489e64eb3so397168b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715014598; x=1715619398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8+IifnlyU5VUGYCojfrw1mYyh3if4pQ8Rw5XMkyJfI=;
 b=U0RGScw6bzwCGFnG4632y81+Sj2PsgfY8WdIg1vJ32ILow0AyDpAqGdWsvdYt7yEgB
 HrfE9G4Qhp57c3b+XBQX/XrOlCqP1TjgFHAQvgQ2GqeFEXlj4bL2VzS18e1ufVVImBce
 uA7cLviPijVUT8ZfPSQoV22WsRyD1h5gZ7cyrYXP/x7XgHJDI50Ry0Ai+SzGtokVra8j
 nSmXy7EddYZftnlrLzcLqQWvnSt3LbHjjygxjjIhxfIC3C7WXMNCfC9Gfis6gvOaREEA
 dJcQQa7zTJfNjeBOvmE2pOMwyDwKdskeykBIwnajLR+nY4z/et1Fz5mcqq/bW6spJKsL
 Whiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715014598; x=1715619398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8+IifnlyU5VUGYCojfrw1mYyh3if4pQ8Rw5XMkyJfI=;
 b=SFuH5nElNAlBTLV6NGRvAkREmj+WSu2149lcUVnVZG7BICfK2twaP9OGurk9VL6IWD
 Wx6nVBRGOn7tBbGAONNRKMMDlAuZ4mKQg/Qxte+VxK0ewZk5KeKvc9Kxiph3Ol3vTA4U
 sDd+OCfjWTvLOlZoF9ki5OGvfcVxhJLE8YqhrbFn5fHCwXgi59xmq8mBNnMnida3d2YE
 pnZUUOnmt87XKugZCAinyw6N9gWdakctNuKtoOvFMZT4VhtBLbu04OJgJnesfRx7CeC7
 N0iLrSUh8yzANJBGpJ0KHWpWcPFQpSaqDO4H79WRpXcnSQXnoYLoV1ePjB0VbCyn9wnQ
 PjCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJsS2AA+maEUk64Au9y2DZsP2RJLfs/j6awZHx2sZRlcb/SstARixGpU/cXxRfqrFJR68s0BX+llPxLYvxXAvb+0LOIs=
X-Gm-Message-State: AOJu0YyeXSEhNiWFzUjbC5fSOAnhUd1bqn+V60vDUSki+Qn6z1yZHZdC
 vdicxOzkTv3LUBYKLE3NhW+v4xiVc6Ci8WIYzPHcO2eEP5pFHeHWaGxA76l6ueI=
X-Google-Smtp-Source: AGHT+IEF068QobYnit7b2Z/xD6rsul/JHQ+Sz5qe7EIRxOliWkOsKsNTatr3EORUcnge/+QycSj4IQ==
X-Received: by 2002:a05:6a00:805:b0:6f4:4723:98b3 with SMTP id
 m5-20020a056a00080500b006f4472398b3mr12190421pfk.13.1715014597479; 
 Mon, 06 May 2024 09:56:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm7939573pfb.193.2024.05.06.09.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:56:37 -0700 (PDT)
Message-ID: <f41c96d4-7fc0-4c95-94cf-9f5cc76f2b09@linaro.org>
Date: Mon, 6 May 2024 09:56:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] target/i386: move C0-FF opcodes to new decoder
 (except for x87)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-18-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> The shift instructions are rewritten instead of reusing code from the old
> decoder.  Rotates use CC_OP_ADCOX more extensively and generally rely
> more on the optimizer, so that the code generators are shared between
> the immediate-count and variable-count cases.
> 
> In particular, this makes gen_RCL and gen_RCR pretty efficient for the
> count == 1 case, which becomes (apart from a few extra movs) something like:
> 
>    (compute_cc_all if needed)
>    // save old value for OF calculation
>    mov     cc_src2, T0
>    // the bulk of RCL is just this!
>    deposit T0, cc_src, T0, 1, TARGET_LONG_BITS - 1
>    // compute carry
>    shr     cc_dst, cc_src2, length - 1
>    and     cc_dst, cc_dst, 1
>    // compute overflow
>    xor     cc_src2, cc_src2, T0
>    extract cc_src2, cc_src2, length - 1, 1
> 
> 32-bit MUL and IMUL are also slightly more efficient on 64-bit hosts.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |    1 +
>   target/i386/tcg/translate.c      |   23 +-
>   target/i386/tcg/decode-new.c.inc |  142 +++++
>   target/i386/tcg/emit.c.inc       | 1014 +++++++++++++++++++++++++++++-
>   4 files changed, 1169 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

