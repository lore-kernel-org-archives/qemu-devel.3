Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286E3C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQHi-0006oD-GC; Thu, 21 Mar 2024 17:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQHg-0006nz-FP
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:49:12 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQHd-0005UA-TE
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:49:12 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-221ffba5c8bso909533fac.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711057748; x=1711662548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OfVAiHK4Sr737BTvGy4cCEBdKO3rrvLQ0euzMW4ZBrE=;
 b=PPpuLRV+Gij2juSu63av9QdQEBsF0Kah29Tr476WGg60mjZ9TMCXLFCYsXxj9YT5sH
 H6kjlV0JWjvAly7UPOaUPwVaLuo6h1MYY5hP0YIfdlwvXtDBvCYJX5h8PA5J223gWEnY
 Stw5D/hNQSXAZ8P2Z7Et+lYgkFSCIhnIxBjxMeV1fKFls9SC79KwYvYfSsX5Jt8nwrgi
 6WQc7KGMgwWaANvS1iIZCJ5R9b+L01bD6wvTJ9t/VuPQEOdmmL99rsZ5wOGrO9DoAb3y
 1MlkA5BlKpml473886P+PELGTycj3wBjDPxsMIDpu+R13Pfrm6gD3J6DxuL3tifS7Xvp
 onNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057748; x=1711662548;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OfVAiHK4Sr737BTvGy4cCEBdKO3rrvLQ0euzMW4ZBrE=;
 b=t4gLeSTH7fHSXRCI/3YQ20sRrSOLFZAnW5SBVEZIDWg4a3VeRXJ0NKEKBpGAWyGs3x
 lnvpwjboVoV2XXZk80CBwxxYnWeBq9//nJdqo0HkadUComJyfmES9Wzkzw5EIqDka57d
 fqZ7bjX0LUUNaF3YgaNp/MiMc5BAsghhMxQHJbUr5BAxQ0MzUUDJyGgPbLUorsp022Sl
 fRFDRtnCUZWg76fEE5MdNeYeFf8KCrsvtTuniQq4rX6w+vEnjlklznvAdjFseqMt9b4J
 JI0DYKWdqt/rgYGXBH/RgHL7s+0qG2u3r9xY7vmlbkUI7bAqibIGaZsQAI712P2vXXQv
 WSDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjz7ERvOau5VL7K409xSvbGSecLLkDk74WgNoZbHemY3cjo4phz2UynH4Yt5mo18dMwHMuZdE5zTy9pUDN41PjNJq1TLg=
X-Gm-Message-State: AOJu0YwAAScNCc5guPClgwiDc7FvB0QpBIKK96/qgupL6jHiqbpXywsu
 /JWVT7x/bGwHbd58GjjM4fzg+ILxC13KMm9vcxjDavWG5EicLtGpT7ovRO7Roik=
X-Google-Smtp-Source: AGHT+IEk+SKEcJS2Gfy2pPoUWz/HqJF24rmwdeNBj9waoJcKERGjFI4+ECbgCs4jtxo4nA+NmEuGAA==
X-Received: by 2002:a05:6870:8a20:b0:229:e2b8:fdd with SMTP id
 p32-20020a0568708a2000b00229e2b80fddmr483073oaq.10.1711057748273; 
 Thu, 21 Mar 2024 14:49:08 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa79f03000000b006e6b7a88e64sm314923pfr.73.2024.03.21.14.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:49:07 -0700 (PDT)
Message-ID: <d48d0c60-e408-48b3-be18-03381d351806@linaro.org>
Date: Thu, 21 Mar 2024 11:49:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 05/21] target/m68k: Replace qemu_printf() by
 monitor_printf() in monitor
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/cpu.h     |   2 +-
>   target/m68k/helper.c  | 126 +++++++++++++++++++++---------------------
>   target/m68k/monitor.c |   4 +-
>   3 files changed, 67 insertions(+), 65 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

