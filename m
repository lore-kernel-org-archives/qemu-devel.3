Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D6CC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrnX-00040W-TN; Fri, 02 Aug 2024 08:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrnV-0003zH-Tc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:54:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrnU-0002oF-7Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:54:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so5858353b3a.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722603254; x=1723208054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOLOgx/kwuWel4Re7Q1EVUmqAQb+PdupA9VqkrfiziU=;
 b=naHh+O4uv6OyrlABgZCh8P2dNP4hiCL1M2z2nbq3+xEvAbskwhvHSR9DyO0m2Vdf/n
 xr391kcXEDH7LWsUVq0I0e6WkjNGsZNJlO8ZsBxtzUT39/4uImoSxbOyGwtKNkq4aI8S
 mRifnEiw/cLOPjr/5tR4xdmug+XkrLCcEDzxl/EFNkrUGYrwbrE8Da+Uhry1OTomKsGy
 sPi6CIWCQlFeai7/8HaHF6ozHeA8Gj9pYTwc6eb2xDUk132erWnim2HOdIT7AqTEl35e
 3BgSxTQJ9XtGAP7ORzoUv/xlYckdgNG5iPlF0lJaP5WF0f8zJRF36oumiG8GeX3w8uDj
 eYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722603254; x=1723208054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SOLOgx/kwuWel4Re7Q1EVUmqAQb+PdupA9VqkrfiziU=;
 b=NxbO6FY3ztgILRwN46z72Ojz67ukAsBGTuTLBIyAoNPfdOEl7a5CX+IEjoTze4GzdE
 tq/kCwaieJsCKn58DujfDAPpgBQwjwjLhd8PT54713H8+LAqnf02tw9RKERajCk79k1E
 GS7mVgT60JqBch3MutL1FhPE3VuGoLfytoUaLpK0h9qOgbvdSCA6wZ6mvdDOJjWJVVyp
 H8GLKReSTUxhQu9KkLPH0tA8Lcyq0Sy2QkfrkYM47fj2dCwqpXh+fK6Z4s+VhsJ8CxWY
 7zxaOs0PUB2LhK5pQ7Qk+hIYTWHMBIYyBlEWDAIh3P2A804Agsn9A9lzlymd916+IpSm
 5pNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIHOjTBBY/vs9DyTvhsmLNbV8PMIgIpdVHHsOI+1Coa0bxIxtAWLX8XKxON3q3lOaFct+z4KCv9Ebi@nongnu.org
X-Gm-Message-State: AOJu0Yzunsg5rBN4aMCHoSAQxzJUVQkwNHm5/C1vT3+ZdQci9CH1vGl8
 XjzH/vIeHxC1afsEN5ZSsvZ3363ZHOTyMFRKn6a/iU56HTvOyZ2RLUB8kxUNc9Y=
X-Google-Smtp-Source: AGHT+IH16IHjJJmNjV2CQyzVkMuZf4YykBR7MdpgSy7IO+TCgEq+jPFRqJRqbapseiOnnsBpMAk80w==
X-Received: by 2002:a05:6a00:a16:b0:70d:3354:a190 with SMTP id
 d2e1a72fcca58-7106d046b59mr4388194b3a.27.1722603254177; 
 Fri, 02 Aug 2024 05:54:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b763372823sm1321630a12.22.2024.08.02.05.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 05:54:13 -0700 (PDT)
Message-ID: <104a63e5-b663-4a2d-be42-565b88701920@linaro.org>
Date: Fri, 2 Aug 2024 22:54:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-3-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-3-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Implemented the RISC-V CPU execution loop, including handling various
> exceptions and system calls. The loop continuously executes CPU
> instructions,processes exceptions, and handles system calls by invoking
> FreeBSD syscall handlers.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke<jrtc27@jrtc27.com>
> Co-authored-by: Kyle Evans<kevans@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

