Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C2ACD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHoI-0002It-6M; Fri, 08 May 2026 05:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHoF-0002EB-Aq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:47:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHoE-00073V-0P
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:47:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso17040475e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233668; x=1778838468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpo4cDnyuPoGYBLwYfrBWlRl5zSdAjP/VPI5tqHIgMs=;
 b=IqZ4Rq3XJhycpINiK2MaMghgJHbPpAuot0lE0qAiM/exZrG/9JKqI0Pa1UfsHUg9ID
 Zvukglx/0jqKhhkRjZcs/jjl4cGRLC3Vdb5UO7MVZaeu97pOGfTdVZZ/2AnDERTF9z0R
 f91SbJJR7XxDVmCXf2AW1eGGQ4eXnHHaHO+sgsOig0/hYPeGmUu5xI7hE8VpYsbl4Eaw
 WrzOBZXqkC+qe0U2HAPgEi8Id1hqM6vGEKV8OLAEJAah2ONvSFWZKHr9qeL1OuEaP9n5
 vTBPPakwX/uSbQ8Q9ALY+Q53ACpXs6bgT4yDB3lZsycXYmpesKXY/2TSAOm+xH+f3njo
 O1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233668; x=1778838468;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpo4cDnyuPoGYBLwYfrBWlRl5zSdAjP/VPI5tqHIgMs=;
 b=Np++D2rGHSdImIDw0njWdwC+qw3JonuI1zaw36oUf3l+yPj5XlHxDOWslK+cdaePGS
 1aMq+0Apg94f4cRnitPWhmzLIyc5XD/ICBcoyhCGO/zS7V2Yc9fscy+RLuIAFvmNFZTZ
 Se6IbmnmFKKWvCNt+Vurj58rodH2KK5J6uqBzApdJ1huHnGdIL0UuBQRQ5Hnj2H1ixgO
 /SFkpUwVVWGv0gRmYv59xFODS8z11ypCRnDZf0SovVkskWntr8OxRKsHOgsUMeJECihw
 VeOQ5+7x13ZrL5cOwIA9vMTkc9YKqn3H/FuPCdNLI7qHHOmJVMIOWryGpbs1qIkv2u0B
 IoIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oaW9ICYpkZ/89sclTxOJ4NZxDN4MAuUvCjDyURhgY9pjlU6i5tgUKATZlxjf8WFekY8U4hF5lTIpU@nongnu.org
X-Gm-Message-State: AOJu0YymhOpHUT43lXAJDU8JvPHtrDzRi1Xbc08gdadtiG+hV0NC6REy
 475nu8qOTe3XaXA+PTOM54xvMCoWtbBHJNPo0e+v0ALixW3OxIEdglzp372+CS1HSuI=
X-Gm-Gg: AeBDiesfk8iimpo0+g8dZ+cT1qgr/w6qyhHIbdTfJbOqewLQAPkjUDaou6SmMhTXTsO
 yjKrptsDrmLX2OTyaY/nSdwA5z/ACA97mFn08dlrAdSzQdtyxue65aCanvTQ1m7N+4Lld4G0K2X
 La6nvenG8FLIuGfndy9YxvMfFyHLI6IsU1jP4L81Tnn4qdUP5bxe89isRnRm6gtQZsH1FA2JGtv
 yN+oPN4+q1Z3Gu/ZTjbprEdeDHkpKoMNqAh6ldrs94fPs2z+lalzBK1jRJsjLh57gyq9eu9wJQ5
 PXIQ2cMN687ONnQwXqO/VmBN3LDwc/pWLB+7tJZkmBcXN9vPXLP/VjY7FceeeSw14bWO04lD70C
 7L9iBk1WAD8bQng08viqzMaGlrRQ/ZZ4s1PEpGbNzLvuSLZ+q8jG6ly5BLJKZE0NtW4WmQaK4qZ
 dAiRXEnLSXX7oFyekn7dA6PwbMed2ygfuSGJIEW2kS7zGs+j2r1PAL9mKMpnY/hYyujzTJ/ii/+
 vg=
X-Received: by 2002:a05:600c:a404:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-48e51f3e0f8mr169107355e9.22.1778233668459; 
 Fri, 08 May 2026 02:47:48 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68f43d1fsm31746245e9.10.2026.05.08.02.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:47:47 -0700 (PDT)
Message-ID: <de252007-fc39-422a-b0b8-3d39fc247710@linaro.org>
Date: Fri, 8 May 2026 11:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] fpu: Use of {get, set}_floatx80_rounding_precision
 everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c              |  10 +-
>   target/i386/tcg/fpu_helper.c |  37 ++++---
>   target/m68k/softfloat.c      | 208 ++++++++++++++++++-----------------
>   tests/fp/fp-test.c           |   2 +-
>   4 files changed, 130 insertions(+), 127 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

