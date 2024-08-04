Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0B5C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiqu-0003lw-1A; Sun, 04 Aug 2024 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saiqt-0003iX-72
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:33:19 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saiqr-0001uG-KU
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:33:18 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5e97b8a22so4398563eaf.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722807196; x=1723411996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1K4phBWbaF1qsRF5ejzMFBQ/4lkSFFFkQfg9eiyN7bI=;
 b=jTGtUZwVJVe45+5t5nzmwchHNWodSGQYJiAm5w/Q1XxM/Pjo3K62wZ3rjluKqBxP3+
 cY+0Mow0S1JcYkCFWJ8cx7DQ+a2ZNZxMaxbcBZDaOjBW0Em+b9Rh5BIj/CMr9Kz1Bprz
 pbRK1+iPEMk6Ee1IX+iApYuC4on5t6QjqlA124uA5evdmlT8T5YCVYwecmZaFoBBvuRp
 KPiMPrFnq8GdeuYNABmWYfSzoe98SlwIeB1NkB3hQtoMe55W56/JzslNCvxBrizCTsW+
 ie8Eg2hgW8cj8NZCWegKg7pWeMilalt6tdlbVQUgK2/PvPRKeJ4rJ6Ubj7+xeYZQ6vTZ
 nt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722807196; x=1723411996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1K4phBWbaF1qsRF5ejzMFBQ/4lkSFFFkQfg9eiyN7bI=;
 b=CXooKDZ9ahCaZPOvOxzS+Gf/ewwL706hl9VclsqTPfYjV6/KVuUy70iWBMXR+En0yC
 UU6OO74T7PznZ040EqCmVKF0pv/WoNOFfwc+HxMnZjIJNDlip/iLqgEtlx/aLAIL4IOm
 tBG0g3RKsF2wkxmExxD7o/u2n65mYG/my/KUsHwjjLh65K9UTUVtdAG9PV8Wpw3fWU8p
 sZCXuMIfWSTYpARBIeX7y8knok38p3Ylo3ZujLqq+N8+9A96gpxVY/GS7jlHh9i5g0Q5
 2nt0KIoPZS+ntypnw7qwqczR4YryDfnXz6n9nEhr9h7s6s5GnVEY3uD5QWGI2BZiZ8Z2
 eyUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhtnfuxTAp6DYpHJgEJdBnkXi10NUgJRHilGeemICgTOrIeixaCeDXf1WxcAA+AJ1mzPS5IBXgWek8sYM57u9AbgaGfYU=
X-Gm-Message-State: AOJu0YxQHf3RlfC2eqIh0tRmMWcD/xDDNcAfD2OiJdofaydre4OvijHw
 jYFblWKsQr/xx1VEtpyg8LHr4ykWsi6sN+5FwoGvWK3R/c+Whs9yawPKwd7m1cjRoEXmqm8+hmT
 CETkVIw==
X-Google-Smtp-Source: AGHT+IE6+OdEf28ebVy3QaCcRYzR3JGPFaBp5xXoMHhzixCjlzA9t/wfem3naRAvNMB6ILpVwndnwA==
X-Received: by 2002:a05:6871:7813:b0:260:3fb2:b724 with SMTP id
 586e51a60fabf-26891f26d4cmr12046358fac.46.1722807196223; 
 Sun, 04 Aug 2024 14:33:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdff10sm4298721b3a.113.2024.08.04.14.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:33:15 -0700 (PDT)
Message-ID: <f7e6ee67-b367-4809-b852-97b2696f132a@linaro.org>
Date: Mon, 5 Aug 2024 07:33:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] bsd-user: target_mprotect: use helper
 host_page_size local
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-16-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-16-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Use helper variable for host_page_size. Linux-user uses a similar helper
> to make the code smaller after the multi-page-size migration.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

