Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1ECC02181
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 02:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tamuW-0002ux-4g; Wed, 22 Jan 2025 21:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tamuU-0002un-28
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 21:25:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tamuS-0003GO-Ae
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 21:25:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216634dd574so4026195ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737599130; x=1738203930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6vG+00OgWp3gTMT4UTYNksqwpjIvzI3+ODoAIEOxn9M=;
 b=Rm6ei9PDApU4H5C2enD91kMGPNbYGoOz1lSAaCrDEss+BzsCH2ILiJU551L+I8O/Iw
 /mfSIbZt66cuOUghUHZjLw/+VBTpnDkPDfenKayVgaTtWgd/uoUaajRhFafFtj+KDzth
 wYb86n49wDLGBDojED5FQk1C6kal8gv+BzUNkelQqRrewp3XNW3sJjGp93mxVm/pjgLg
 NuNsWgkyUyyiISRP9BOUD9BGvPNSI5V/jILw0jKqJfWvRgsSZF8V3qds6IfkoO4YUThE
 /sdWV366CfOxkI/d87Dd4x3hhK6Vf1x3VqpuzRypVLRKYBOlDos3BhZXUu7ll4nuvaUk
 mjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737599130; x=1738203930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vG+00OgWp3gTMT4UTYNksqwpjIvzI3+ODoAIEOxn9M=;
 b=Q5wsXtStaD7osNhCF/EegioZApbbWF4qQvNrIYp20gtQvu3tPGSGxbCd84+E+ApTd2
 u5xKYsSKQYNu/5A/RxFn3hvcAnNvQsk7IoOk3qTSeJ5UdVeuvO9sM8XDXmuvFEn8IN5l
 QnW6poA+OhB9D6yBEWWL4zOPAXM+j+aMRUXOs5H8c5ehcZTCUvzgN0paT0LNuOMLOzSM
 K2kSrhmkssAh9ynx3Hl2JXHF7xc8EpI9aX0UAPc/WpGyaMicRU30XxTtRBJFRDu4Cffi
 tFR6yxRH6Jj8F8VgeNfbqutHdiDu+uMO74zUOjFurkDUk/sd0DNZT1JhKLVi/NtAtQHG
 mLCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWyRFVrVo9lYvYbWQZo6WdQFik3+jhzaXsTiKWk2GtsxgDuCXg29aBtxJWVqngGZUp54xmkhtCoOyV@nongnu.org
X-Gm-Message-State: AOJu0YyIdYcD6IHBiVbDX5IB5fKJ/V8tfWzKaszOKhEaEM/txKQl4ctU
 mQ+labpFxaKKzpIJSYnAU0FteQS8VJWXnu8NIdPAiGvxAsQSozv7ZeEjrmUh//4=
X-Gm-Gg: ASbGnct2r0xao87119r2ZvpAEt7+STKN64M/92Og1oAN5xCjJhcL7uYLxCMu9XkMb3H
 2NwIRwIB7jMsBwlYRGP+bTljF0T9uX8jg+SGo4ZtJI+cZ4O3WpYmvlQTQ3n+4YrvFXsEKK3edkQ
 4tzLEuGiY3muOJa8ZdRkewbCP294QP5+NolDMEYOneMPEuQkXwP6iPXaM0UdVQgyvJcTUO7S2zz
 k0MHBZrLAzJbnrDBypY5LVSp/3V+rwbIpRat4HVyvcTN9KKnwDmgjoG0oONgdwscwqiJIKDZzr6
 a/1RT/i3BJy94ZbuYmZY0Z5Zwxm0b0tKsB8tAyaBtvysNng=
X-Google-Smtp-Source: AGHT+IGKVpYSYsDhjDB1WY/xIs/9+8+EkTM7lXK5HlxtvaJFqFRAcfMs/TfQvqHgcPxMiXyFn89F/g==
X-Received: by 2002:a17:902:e74b:b0:218:a4ea:a786 with SMTP id
 d9443c01a7336-21c35607c4emr378966725ad.53.1737599130331; 
 Wed, 22 Jan 2025 18:25:30 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea2e94sm102210415ad.28.2025.01.22.18.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 18:25:29 -0800 (PST)
Message-ID: <d05ee63a-db22-4560-b0c3-457ecf6d19db@linaro.org>
Date: Wed, 22 Jan 2025 18:25:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: extract common bits of gen_repz/gen_repz_nz
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250122095018.2471009-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250122095018.2471009-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/22/25 01:50, Paolo Bonzini wrote:
> Now that everything has been cleaned up, look at DF and prefixes
> in a single function, and call that one from gen_repz and gen_repz_nz.
> 
> Based-on:<20241215090613.89588-1-pbonzini@redhat.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	This was requested in the review of "target/i386: optimize string operations"
> 
>   target/i386/tcg/translate.c | 34 ++++++++++++++--------------------
>   1 file changed, 14 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

