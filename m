Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3DE9D827
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XVn-0006MI-CC; Sun, 05 Apr 2026 20:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XVk-0006Iw-Ne
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:08:12 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XVi-0008Aj-6r
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:08:12 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso2115168a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434087; x=1776038887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EyGle2zkMmGdFGWwyS7Xm5SKqqfH07+bwElrhXDlczM=;
 b=LvLf+NLLcmzdMmk0fhbuIhX5DDj3TCD4L6t6jzuXIi8tBl0/33bOmHdxXfpFOYtzkp
 qA3J49qmDOVtoIo4IoAwTwNZOpo5koH+/WzrVMAIk/lc0FCeHEkJQgjhQLgV7wGVwNwm
 MbcnLlP9+uf6TBTad2NjHEg7XnmOzSqtaW0jROtuShAHtkyj09miS06QaynV6XmE4mlr
 eIZ+T2uNkk/m6k6Eet2GRTAjJycvwAWrYPEUMqsQnpTVgP+pwlkHuCcl+QBHrsU1UYW1
 gI+61dTSdZ6WP0/DQP7DaD2N/IFKZ6k3opgrv5d3fR+on4QUNEAsFn7EYNqOOfJiUytC
 jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434087; x=1776038887;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyGle2zkMmGdFGWwyS7Xm5SKqqfH07+bwElrhXDlczM=;
 b=SdhwJBwxcyGAobk7R02XfyLIhktTt3D3uIwUZVKlQGVRfDKwiKjckAHCZGAHnMq3KR
 TTOgCR+M7OYSEWjUfAEln6eHNHemtb7HUh8K3QF082IA21cEFCCqUrI8EG0SpLE98ro7
 LAyN2m6DVfdlwxS9pjTGtk4cxqO7jsH0fzXilvkHJTOSLYC+64+DB8zAr/2PBABXhjRI
 7UOhyLePumB6Q2qA7zk2OxInaZjPXMW/dy+KW2zhvCV9ovecr3l4n5OWIcufF6IiDaoP
 XmtlfWKI6HVFk2O10lReZ15XEOvqHY2eGZDWs4B+dced6qHaidojUy0hd4BmLxUK1J+O
 Q7qw==
X-Gm-Message-State: AOJu0YzNYIw/I3mH1DFAIO23ABV6K9/2vmC0ci0q3ec98wHQcc/rfmIp
 ilBeAXLestAFeMmPGc9GAxa30URZMVRWSms67FymVqelGXgW7tjGydjVnkxqL3mQnvBxS51fLwO
 JWzUa
X-Gm-Gg: AeBDievVRl1jQ26bIgpIo3/Ym+b7WUWXCqJn7DpoUtgMh89mBEauOzE4cnrpXoDphC6
 S89yijmR3/v3qVqHcowHbS7dPk8R6/6RgiJNWPD2zOwxsraqhp1utPBQTkaD0tdGWzXuoI3YfAB
 FGLYCRtgwCPokoUceGao2XETK81tFih+d/Gnx9WPOQ7ERa9xaESclTRjMS+f7+Ts5JNnZrQu3Bm
 tZvJ6XJb7ZctqRwd9/C3ysqcYtofHj0PGjeLGqPsjaYvPjVvhjK9np8IIrNzB9G7EvFAm0o3RYA
 OluosyXGEGubLAt01M3bWejhhQhUjw5mUr6TA4GASi3LV13oJZAiJNtDolwsgSxD8D7B1vE1vzk
 rpX8k4HDCYFW4O62d8IdpKaC8q7qr2/szW6JWh+mb/WTvVr40ab7ZKT3/E8PWr9XdIxRtTPERYN
 uSHfiF6do1WIAGzLrK79rQBMGCL1qFFujSLZ8C3eRpYUPusTKqBbjzhrFyvyrlWxkurHU=
X-Received: by 2002:a17:90b:1fcc:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-35de689500dmr10640099a91.10.1775434086993; 
 Sun, 05 Apr 2026 17:08:06 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd367c142sm11925052a91.11.2026.04.05.17.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:08:06 -0700 (PDT)
Message-ID: <ae8d0499-f52e-43c7-8f98-aa74fd92e6d3@linaro.org>
Date: Mon, 6 Apr 2026 10:08:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/35] target/arm: make whpx use syndrome helpers for
 decode
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Rather than open coding a bunch of shifts and masks we can use the
> syndrome definitions. While we are at it assert it really is a
> EC_DATAABORT.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/whpx/whpx-all.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 513551bec1b..f5646e7127e 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
>   {
>       uint64_t syndrome = ctx->Syndrome;
>   
> -    bool isv = syndrome & ARM_EL_ISV;
> -    bool iswrite = (syndrome >> 6) & 1;
> -    bool sse = (syndrome >> 21) & 1;
> -    uint32_t sas = (syndrome >> 22) & 3;
> +    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
> +    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
> +    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
> +    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
>       uint32_t len = 1 << sas;
> -    uint32_t srt = (syndrome >> 16) & 0x1f;
> -    uint32_t cm = (syndrome >> 8) & 0x1;
> +    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
> +    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
>       uint64_t val = 0;
>   
> +    assert(syn_get_ec(syndrome) == EC_DATAABORT);
>       assert(!cm);
>       assert(isv);
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

