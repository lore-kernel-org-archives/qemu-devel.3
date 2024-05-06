Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DCCC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s413h-0007id-5J; Mon, 06 May 2024 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s413f-0007gP-75
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:19:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s413d-00038U-O9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:19:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so5308575ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715012356; x=1715617156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0BqRt0OSlJ7EtoqIKGWpD8yF4GNrBM7MU/oTAVui8tY=;
 b=kW4ZKfk6X/75e7bCCCiKn7Ywaj3jaIQkiepqCamx9ub0A0XGbRAeaP72Ulj/AIFuXP
 o2I1v9bWdxJbWCatS9Y8DA7H3lL5nu+NtYfpijsu2WZyqgeyBsUIsiurstU3jsQD9cBU
 SzDYo6WKvk/aVIBsLFcUCG15uHoQnWWgAeENIcdKQ0WdyuBs18zXSjbBdoECLwoOjqhR
 Pk1N2K64Leyb5iI/y4yr+AAQvkcq/Rp+/HPedGNvBswCQhsWTNHrX0rkA7Wl428fQLv+
 m+xt7Je5JSOmCwU5JungShmSsF5/NL/gKb9JhJKPsKZt0kId6aj27ZDOwtTits/ByYCc
 NHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715012356; x=1715617156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0BqRt0OSlJ7EtoqIKGWpD8yF4GNrBM7MU/oTAVui8tY=;
 b=B+AyqWvl6b+UzB4Y9ZcxD8hy8Zkja3SdbfNjvlE86OxhaHGpofUATX6wJfidLsWrxP
 khQ3OdNL5e306T5fL3tB5WKZnxg2IADSJ+iUhNMoMhulrwnnzsID2yqSAk7BNs5TPbpp
 vCUWWmOxB/fxUqPPdaR8ZmK/XnSkT4iOEHS3m7mzFh54zSh1B8rKPhf7k/FsAtfqNCya
 kXRwZrf+8LdoDQZQaOAQeWb1ohwBlCWIexZYn1VaejIXVkNRKlcESHTFLRY3OvBqNror
 TDCmAeChWnIUuOhDXEPNwhWtGV+nxTjxkAg47/hGS5OVG970512M9TfkVjBlEbeqBbum
 P3Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKmbKw15FAVn+fbPbhjFz9757JSwEt+scqSonw+Fd7NravM4YUgeolj6QKNcWtEJv8aNHlGd4T6r6OwdC6+ezXyTZIpts=
X-Gm-Message-State: AOJu0YwI4gxjCfYaTDM29AD3RRFcqYSMps2FVVfBsgDMwRRuNJKo+CPS
 pvJXpw0Zi5dRzPEStsjK18+W1CeS5CzI/dFLnUlz8EFvYI8oRh4FSxxKIzUcJA5fe3ApyLDBVY7
 q
X-Google-Smtp-Source: AGHT+IH73HFzIf5Zf+iuzy7SMFljiJCyTfjXKxMKttaKLYlEg8oafZyReEwe66U5pYyEYCL5Jfrr0A==
X-Received: by 2002:a17:902:e747:b0:1e3:e380:8724 with SMTP id
 p7-20020a170902e74700b001e3e3808724mr14746828plf.48.1715012356199; 
 Mon, 06 May 2024 09:19:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 jz13-20020a170903430d00b001e2a3014541sm8457151plb.190.2024.05.06.09.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:19:15 -0700 (PDT)
Message-ID: <217224cd-b212-4152-a731-b3df75fb55eb@linaro.org>
Date: Mon, 6 May 2024 09:19:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] target/i386: clarify the "reg" argument of
 functions returning CCPrepare
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

