Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88BEC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZwPz-0000bV-VX; Thu, 10 Jul 2025 14:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvz7-0002aP-12
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:27:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvz5-0007Cf-BE
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:27:04 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40af40aee93so827608b6e.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752172022; x=1752776822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VAmddi9tcRiVQ6AlBdUI0ONKfduCV4XsdW2uOn5XAhA=;
 b=yPGguaKDLIbIFPjBeV+bb8VgB3lE+goXd8T2kxVTKamFWzSwf44qTyYN98o17nIECK
 HzMt9c16doi6eFAoy/+A6qUgdOXCG6erEDi8n1zSWKESL1TA7HRBMKw8BELASbZUeSxu
 LUSS6YSxgAvTKFCceg4nVtf1u48KVr+IrSX/29e68Ad7wxda6hqmieYWKZqPDzefoRlw
 hIRtwEnp0Li87UzU0W+uwEnbRXwEDMSR1alBHnnAn3UlrDRpRO91qWiTnIc5aUJELr4T
 8KLtkzjWs7PvPE33DR1ivI3yWxXA1o8JnY5Ufp8EwEoOWlihv+4KNa8R+L63Tlx7/T7L
 L6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752172022; x=1752776822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VAmddi9tcRiVQ6AlBdUI0ONKfduCV4XsdW2uOn5XAhA=;
 b=Y7tJzL2XOPd5MALsQayeav8x8zfmHQz8xsrtyg8VA3GWyXodUF3Vnq6gc/kLe13+P5
 ZTIhVs7gRbPkuLRuzY9m9jtfD6hVGlf+tTJCp3aBIHyD0A2zGyVRRzmSDWDXUAW4FZgh
 tN8kDdh46lEcZfwa6XUIAEp6MIvWz5aEbpKPRXuVXg17uoS+shqtywUG+RgaKfn7nEzA
 Z6vsmsuy4YDIrISLRt4LXMbsvIJsUGqxQKNWpRnMrByvmHbYlMfIPStV+Zq/AGtRYDbv
 t+OmpQ6qcCHN1y7wFDSaoLMD2N0kAgihz06jgJbBAjOF6VGfKXvcMmi23s1HVxtCcXPH
 JjQA==
X-Gm-Message-State: AOJu0Yz1TaL/OBtAQ7P7zWFQBEbpts8zLQx0JzErriQYUBatD3o9hZ1n
 fflYkZHx1b9l995g+b1z/2LsJMNLbQuo4GLgUKOFiW4mM6HNyguO7XtlIFCHqRhaH7uOptT6Mhc
 9TedtxWA=
X-Gm-Gg: ASbGncvV/EiS8iJahDxdhfJ2tkzmAHl47HMZThQ9hVs3Pwv176W2I94qgcol8E7qcY2
 YTle3KL1TI6loxRWXt91wy+gIO2/s8HLaHmYIZFlAIOk5pq5HW6CvGWLJFhhU6JZRp07k8K9FnV
 MM4Lgr918Zaoxid+TMSnzCK3cn6FVys8ln3pHqMpnLGfqihdjZew6m51/YywJbhk6fdoYI1wa+f
 OP/iLIeJJxojNQqwemGrTFpH9UsxJNIO6r1eYPzheNdOSAmlZtmi1vKJhl+2qD9Uj2aX+YRxPvL
 9/zpvPcxJVjaJ4JqvW6cGExuevpEwutYE9xZIHtgNlkgM7o+ajnsoLKx5h4wtxpY+I623HnC29h
 vLSo=
X-Google-Smtp-Source: AGHT+IGYdiDSavujQSWKRbM/78s+Cc5CDjNU/+QgJgtyZF55GNs7ljvgoXHcrS+FDjXYbEdew4tzmA==
X-Received: by 2002:a05:6808:2111:b0:408:fef8:9c6d with SMTP id
 5614622812f47-41511815470mr470734b6e.19.1752172021846; 
 Thu, 10 Jul 2025 11:27:01 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bcd28a1sm290316b6e.32.2025.07.10.11.27.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 11:27:01 -0700 (PDT)
Message-ID: <c6b2eb00-11e7-4e5b-850c-1210c66ae65d@linaro.org>
Date: Thu, 10 Jul 2025 12:26:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/mips/o32: Drop sa_restorer functionality
To: qemu-devel@nongnu.org
References: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 7/9/25 14:57, Thomas Weißschuh wrote:
> The Linux kernel dropped support for sa_restorer on O32 MIPS in the
> release 2.5.48 because it was unused. See the comment in
> arch/mips/include/uapi/asm/signal.h.
> 
> Applications using the kernels UAPI headers will not reserve enough
> space for qemu-user to copy the sigaction.sa_restorer field to.
> Unrelated data may be overwritten.
> 
> Align qemu-user with the kernel by also dropping sa_restorer support.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   linux-user/mips/target_signal.h | 1 -
>   linux-user/syscall_defs.h       | 4 ----
>   2 files changed, 5 deletions(-)

Queued, thanks.


r~

