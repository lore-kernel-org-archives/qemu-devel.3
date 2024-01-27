Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C901CC47DDF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 05:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTarj-0005ol-2E; Sat, 27 Jan 2024 00:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTarg-0005oT-QS
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:04:24 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTarf-0003Lo-CW
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:04:24 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so699982b6e.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 21:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331862; x=1706936662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZaMkWrgpzeebIMc7w3GwomgZgJ4WFwmNf/T9o4k8kr0=;
 b=nLF87W2NjN6eN7VbxhdOsJjOjur4t9Q+44EtoebRjNTsRfBtfBEOyg+v0OGjsScHhq
 tgZzTR6rg0mPX0fmVyPSqYC6c/YFCmCbWdWrFtkBv99CtyHXRdGUsviePojSODEPLhVy
 YT1Aplecs6tDfgEeu4YDDTa5REOz0tfAemECBfM6RkuQKkAduERVVNNRsWKTEZbKrfJE
 osmFqyavC9nQ6st6fJdqgDc+aWt4kiOVi/U9vZ7zFhIjSvJkTd6tm4QQxpbSkHoBcrR7
 kIHnkaVR36wXlr0vYPst3J3gtVklOrHCoxZeufRrdzICCoRbyo+YFC4CQn7O7dlRFoKd
 ciYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331862; x=1706936662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaMkWrgpzeebIMc7w3GwomgZgJ4WFwmNf/T9o4k8kr0=;
 b=DAlXQuRMa7MQuSBdBXjYYrRbmp0MMeHuKRnPlyzQF0sChR7n/J1spwuI9KNtwIrheY
 Mb/Z0RDZqX/Q9iqWN8ixsj5+1TkQBetDmjD+X3k78iQcIb305/zbjpbxtfs5v1PBM6tf
 BbR6EIg+RDDp323QCCyKQmvZwFTB51f9Tt8PQbJMMoCnXK2VUB8cD84Qpmw7L5lJN3GD
 scmzixuL4ymO8swi5V6BItM9Kn3c9SjHpbtPm+K/FA4vUuRkR6OkfIK2uA7zw5EA8UUL
 tYmmjZR5ZkR5/F5jdxHBSgOs19qUFdha/PMFPw3hidv9dar3aebCeaQ18A6zlZ3UiL8V
 6OrA==
X-Gm-Message-State: AOJu0YwrHNfqVUYs4FjfmnuhpUDItO5rAbUxPp/FLMhMA5QXmAt/9nq2
 40q9CTDmqcQgrOkiUcAG0Pi2xw2qmPjNVEVrj3bk7SK2GL/dtzeBmZ+RydYxemY=
X-Google-Smtp-Source: AGHT+IFBoVRL+QPEPawwVQFzkXMpjqCgDcCZAYd0+R1fVv8RHn0CQP5PcQso8d1k3MkoPbXToJjrpg==
X-Received: by 2002:a05:6808:200b:b0:3bd:e660:d52c with SMTP id
 q11-20020a056808200b00b003bde660d52cmr1290183oiw.11.1706331862222; 
 Fri, 26 Jan 2024 21:04:22 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa78683000000b006ddc14c416dsm1974542pfo.95.2024.01.26.21.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 21:04:21 -0800 (PST)
Message-ID: <1d4ac732-4304-46be-a96c-247c5b3384de@linaro.org>
Date: Sat, 27 Jan 2024 15:04:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hyperv: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125163408.1595135-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 1/26/24 02:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git hyperv hw/hyperv/*.[ch]
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/hyperv/hv-balloon-internal.h           | 1 -
>   hw/hyperv/hv-balloon-our_range_memslots.h | 1 -
>   hw/hyperv/hv-balloon-page_range_tree.h    | 1 -
>   hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
>   hw/hyperv/hv-balloon-page_range_tree.c    | 1 +
>   hw/hyperv/hv-balloon.c                    | 1 +
>   6 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

