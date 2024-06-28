Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7547C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNE3Z-00074e-Ep; Fri, 28 Jun 2024 12:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE3X-00072Y-7I
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:02:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE3V-0003Mq-Bx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:02:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fa75f53f42so4395865ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719590552; x=1720195352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PcscZ4C0HsYscMyQSfmVuPsZtBmqdTuyKlPKREymHEY=;
 b=nTWHuHxVYIjlPIi4qKnxaa8XRuQ6eNjjLfpMSLSU2lFuBmrXE6QraXCo+PU0fkMdgj
 LNC+Yc6OciUO1xLAWBlnWJrrx+GqWU+itkgKnZ1Lw9M/2ETYxUYlYdmNkKwnLm5cm8oz
 KykN04QY7CYrYjLytFKJt/Vv33Q4tJSVA5+bTL6DeoKCZ+dCF4YvkwU6JOwfYj6X1YRj
 9lun9LeVBliqx6WZM/dWg6aGzVfqszl8iG7OdaC9pO9ik/bAVjHN0+dKwa+lQ9vvsNop
 weMOJY5Ng2LSEGmAHT2QGXnusQqAJM+jrV6aIlbey11bovWTCuEtx96dapIyBVIRovD4
 hXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719590552; x=1720195352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PcscZ4C0HsYscMyQSfmVuPsZtBmqdTuyKlPKREymHEY=;
 b=ApYb8GE6gUMbRwQR6YFriIHYNSNhoyCYJnTO/WNjlp0qp8i+6AeRE0r4JwTyBAOSkl
 fCOJBi+lO8XuD+NnfbtjRyi9KAzBODTef8yN3JO01kAj7/NEBYNjOlX/7EZy7v76+cjS
 VHWoO7Xu4UAUE+xt/2sxKbrW0DCl/HStu6T7Mao4Dnj0WFK/8WMA68lfzWe2+9PpRWAF
 pqpSsjjh6W6OZhDssvzKUw0koefik3BK1dCzGkGeS5YhXOesWa25NDlF/HYV+76tTd2l
 REoemiHg9Ex/SXwuF/JdAwQKhyqCJBzAgUM2iCR8msYxhBEw0YjqA40bgEQSckPL5WJB
 PmPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf9FmxFgNVbywI7ZEWMwcOJUw4jc4W1pZ/TUIPipxH7nOufFJcOHHx5JydOndQDD5ax9XV5z6//fyooe3iEQLoHtvwzS8=
X-Gm-Message-State: AOJu0Yw0j1VKPyvLogk2WF8ICbSeiU7pW24ipe39jNGl8RgedfJHPSne
 1lQcN1KWQYzAOGfHnQFjd4yj3l2BhXxF1MUKAOzNCFOZbecLCT4/BCjkCUd3RtBr9dUrBomTWpF
 f
X-Google-Smtp-Source: AGHT+IHljVR6MnSBsN8KykA123Tbmcwwp92YWNgbob8xMxm5eRjtCSKRSc4CpT3vAtWqoyk5p2Yr9w==
X-Received: by 2002:a17:902:f685:b0:1f6:ed89:6bca with SMTP id
 d9443c01a7336-1fa23fb2970mr171922935ad.39.1719590551580; 
 Fri, 28 Jun 2024 09:02:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15b892bsm16902395ad.303.2024.06.28.09.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:02:31 -0700 (PDT)
Message-ID: <6f45f5c1-787d-4ca2-b93a-170b1eaa673d@linaro.org>
Date: Fri, 28 Jun 2024 09:02:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/arm: Implement store_cpu_field_low32() macro
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> We already have a load_cpu_field_low32() to load the low half of a
> 64-bit CPU struct field to a TCGv_i32; however we haven't yet needed
> the store equivalent.  We'll want that in the next patch, so
> implement it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a32.h | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

