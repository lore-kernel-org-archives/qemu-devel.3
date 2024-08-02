Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZseb-00068r-To; Fri, 02 Aug 2024 09:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZseZ-00060i-Pg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:49:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZseY-0006lU-9p
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:49:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso74063555ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722606544; x=1723211344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cx5MImjkMFdcursP+Dp57CG25LkG3YmoRo2gpYK7SK8=;
 b=FNEPWUoprK3wmhOVKJQZmn8AUgVhgL2UY/M7DLgV1lpJd40I2pERYBnl6xQwioo6B8
 bwZJWe7on9OC/EkmTB4N+C8s5PecHfLswdwdpFF/zpkj4xRDoSoBb36kInIQYCeHo7Tu
 lj8X/Fbbt+F9XvB2as84FAFBAq2GViRBNbjOkBAxhca7cTY4nMcJR8kveItlyUXcx0Z+
 B8QYbKqLzGoUSw37aiDhvsG6EwlPsDrArB+wVKwItcEfvrmJUekPUxDIvpy6xIisiRRQ
 gpvwGeOQiILRniHk0+oQezloSEeeV2xih9B67gotIXAo1WLX4e6kIE95lWuCMOagYgms
 a/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722606544; x=1723211344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cx5MImjkMFdcursP+Dp57CG25LkG3YmoRo2gpYK7SK8=;
 b=FviYY1m3ZzJVpxMpZJ2vkC8rLDoxORl7naXS59DhA0qHj5ko1r0Y2ideWb5J/ILW9T
 308nAWOY83gOmQZkU+RVAgBs3yRxP8b6OYKLllZlnrBmyAU3qXiNIqq31QtJIIqPYrZ/
 fm0IBLL2e6YSij+GSsFhDlce5D40q9WKBlJmTDrOFJE6xrZLIQAU5/OY3Do53xdmMe1t
 TlAPd3E+Alm2pNEwviNnOeWtofUGdAidn8TAbsymePUCY668d5Qj5Keyk2akhy+CwlFY
 rmXqisZiaYp3KSBaj9De6pp3mWH8+mAs0Vowie8AhnkUW04Ht9hKYopjYBeUqCnKPgdF
 WdOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUc2H/gPmbm1fsjqcxE3+XYhHjdw0FUsOMazFtMHoeQA3z4y2zuS5BiQiN0tBx4Ydc+/j5QOFL1rZoVYsFjPH65BKTLuA=
X-Gm-Message-State: AOJu0Yx6nnIWZPzSf59ZD9Ii7/9cl2WNRV1hrVauQ61p5Z+DJnA8aky4
 BD13Bivjo66SAiTCbjldK1Z29HZYka/8m7WplW0pItrgdwd2SQWxG/dR2ZTkua38efxHY5HWqN4
 tymLNxg==
X-Google-Smtp-Source: AGHT+IFQdLOFhTo2lKfQaRnb7/jYL89IAV0poy5pK9GDdxs/JY3XX7tE3IyNwz2vCjxEwldd9eSfRg==
X-Received: by 2002:a17:903:41d2:b0:1fd:9d0c:9996 with SMTP id
 d9443c01a7336-1ff572d4738mr48258945ad.35.1722606544315; 
 Fri, 02 Aug 2024 06:49:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b65a5sm17109055ad.303.2024.08.02.06.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:49:03 -0700 (PDT)
Message-ID: <f3c4da84-76ab-43ca-9192-c2d822392470@linaro.org>
Date: Fri, 2 Aug 2024 23:48:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] bsd-user: Implement set_mcontext and
 get_ucontext_sigreturn for RISCV
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-18-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-18-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> Added implementations for 'set_mcontext' and 'get_ucontext_sigreturn'
> functions for RISC-V architecture,
> Both functions ensure that the CPU state and user context are properly
> managed.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/riscv/signal.c | 54 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

