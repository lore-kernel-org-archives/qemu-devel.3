Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA8C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 22:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUa9U-0005bW-A5; Mon, 29 Jan 2024 17:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUa9N-0005aw-6r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:30:45 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUa9L-0002vJ-M3
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:30:44 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ddcfda697cso2560522b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 14:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706567442; x=1707172242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mAQxx5u61oREC8Oev2Xs+jBwT0C6mWWIvZdJgUBZXXU=;
 b=cYJ9IER+MkydQ3/G6+rHlY7NTnuWe6IrzABdu1RLjfirDjQ+3KgC1pzOZKtnNA/25M
 mX6La4ZzaNgKo9LTjUZl9IZrdAf51cF2iBKqzj2Cs9LwCb29+dLw1wudJW1c52mblFGi
 Qpdh4Qu13U1BCw8ePpxsZBrBVoK1l9/RFqZLqgd1FoWjqb3EftgAkOhtdSi5wJPhf1nT
 diXq7yEYSHETRz3x64xCwYfMy4Gf/orZMhCw5eHzOl8K0zBfC5DX68KBCSFrh0O6JepK
 FaNHh6j+HS9xphQwaPld058PHBy0BhLqp1eqKlDFNApg4dtjcfaUQqTnXkdnwEmzJBLy
 9I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706567442; x=1707172242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mAQxx5u61oREC8Oev2Xs+jBwT0C6mWWIvZdJgUBZXXU=;
 b=KlPyCeK6ydLQnBcLr0FEu5/Tz6T+Fp7mFABqAHaNBqZQ+j9cZsOb54YZXsiTgDX0zN
 528l1aYjw5qawmuzAhZTznePMRr+IaH5Sih/d8s1pL3/QGmHKn6RAuaDN0PgwG4a4gj5
 088nLdWaMpXa+A4LeNW5Z6fw8BTJwxXHaFTsyJ0xHHuSOD/HkDYueLa9qOS31aZA0+pe
 DYOwR84knLzIwSMfpj77VPVUYy+TqXdBSl5B43OzvDjz9XjYkb4tkwsMNRF2KRw5xWkQ
 PfZfeBcrNBvZ6igIvacFqdaX+a9b4Q70G0slDDDEZ4H9jhK/tEATVt7OsE9inohjYrdr
 U7Kw==
X-Gm-Message-State: AOJu0YzO7vUjL6B9nt5jqg1qNCPZTlTb31l6knmCr0A9hd0ueDVWyZYP
 qmOl/HbAnxfjlnoGbXzKvK1vULaG//87+m8piOyjAbNtDBA/kMk1bBBPyK4pDFU=
X-Google-Smtp-Source: AGHT+IEdXa1/3fWCVaOQnW3+O2f+yROhEHhpH/QV2QISf0CGIo5ldpGlbsX3n90fVNr5/9F1PBD1+Q==
X-Received: by 2002:a05:6a20:491e:b0:19c:8447:1c41 with SMTP id
 ft30-20020a056a20491e00b0019c84471c41mr5906593pzb.44.1706567442083; 
 Mon, 29 Jan 2024 14:30:42 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 jj9-20020a170903048900b001d8c9f23518sm3368963plb.206.2024.01.29.14.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 14:30:41 -0800 (PST)
Message-ID: <ca943aff-5485-4d18-97ce-6daf24d95ca0@linaro.org>
Date: Tue, 30 Jan 2024 08:30:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usb: inline device creation functions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129133751.1106716-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 1/29/24 23:37, Paolo Bonzini wrote:
> Allow boards to use the device creation functions even if USB itself
> is not available; of course the functions will fail inexorably, but
> this can be okay if the calls are conditional on the existence of
> some USB host controller device.  This is for example the case for
> hw/mips/loongson3_virt.c.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/hw/usb.h | 26 +++++++++++++++++++++++---
>   hw/usb/bus.c     | 23 -----------------------
>   2 files changed, 23 insertions(+), 26 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

