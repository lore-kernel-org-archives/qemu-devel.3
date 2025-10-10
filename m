Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2179CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GYB-000646-3A; Fri, 10 Oct 2025 13:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GY6-00062o-RW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:04:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GY0-0003aw-34
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:04:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so2250147b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115886; x=1760720686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8lwq7ZtoBADRRB+g9ljIF21F8dzO47mVUXDYfUDJhg=;
 b=T2L8WyTarxDOfjvM7KBEwBieczzMT4dW4yi+3B7u9KOeqMF6Lp2kKK6uMziHPj1VIw
 wtwFKnSEUyubBbht6iGhzsEum2zN8/cxjd+GMo/+FakoqtHwjja99QF2R2U1w72xfvcc
 RgX9itE2Y3e78UTY89/LX1vteR2CPLWjmp5FkYLj85nrOKMDc/RoFzetTyG/bfdkh6vv
 0twWJ3/AFWWzIpzPHyFSPqCSFpEafmDyP3AcHDAxIO0eYrv5UY2EwEgB5usRfzOZSI9X
 cp/SZG9Qu6DiGZz4IVkV5r5u8bAOQDhdsxTb5gUvEb2DdfV7AfR14iun9raHU0qGXHoo
 Axfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115886; x=1760720686;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8lwq7ZtoBADRRB+g9ljIF21F8dzO47mVUXDYfUDJhg=;
 b=mQBmVirBjfM0R9jprNw91/Ox5RGKf4aVDhgKL5veJGjaaLRVRoTZXBG418g0UL34iD
 QAq47Omi6WiVtWpjTSvQKCIpySL42xHEfrYV3qStfOK5nFJq3FL0IRBr/KgIpri3ic1W
 6OlA1qndW78JP/Qr5Efo8fJu17SDo9tioazHgNnzf0kJs6bwGu7z2e5nRHJOeXtsGefw
 WJDPwphtk8Zs8oFzy2AP0qzK9lxnV+PpGtPmGZ7xBXolppY0R5Z4adqszCsaw/f0hA66
 0Exs5Y7VP0JmCjt09dlaH5DROCtCxyQalCzdBVsIIGw+w6KfP2hvN4+zy9TGVFq2VscI
 yrEg==
X-Gm-Message-State: AOJu0YwKDa/uZNRTWzDIiJsMuCzs4RxOhVXfRMO0TvfsiYAkGru0A1ts
 L/JJBp6mlscThnuBc1oAQAcQvFom8hD4sNCg0pum+uiLFoO8uJF1kPB/KMRsw3zxuNsEJHXI2vX
 lwuX4V5k=
X-Gm-Gg: ASbGncurOROI13dbJKzSYCT5GdRqJrPiaTyp2PkMa1CzG+8MSYDD2xx6eXERiVlDdJR
 4phUdsOaeMetQghV6Qgeu36cOI9hEZnxlbpOUscn+8vveV8HNN+MZeoK6PLrgNWPaa7TggwB/Ny
 937oYWn4JTvMUBNn9sqIF+GEDXovHGe4k+qVpeK1l0n/TFNBSqqLVcx9+8plcTnOG81taMkK5Oy
 592KY+PdBvnZ+OQPTXFTmzQ18VqfSuIbu5JVzuJF9HvqgbkwNk9ICFejkT3/q8Qr7R2j06yp3S3
 QznQXTVkTAspkDBu/qiaAPxus4MRg5uaDXKdOrfwhYnu0uFfHhhRYElt2rq3sPOX+C+/+Qh+7yQ
 Or2+e7VaamvHCL1AcvigxU18xLx0fKLCqRRa9bNKdTYCDjUg3KQx5v62wKBj2HZ8avLNZEA==
X-Google-Smtp-Source: AGHT+IEYyTybtZmICZ+ZrxBlxuYX19f/qtPF2+WrqyDFBGcsPDvJ/GUu9tpWB1H3kUUPo/CXI5zJxg==
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-33b51162572mr18611422a91.12.1760115885646; 
 Fri, 10 Oct 2025 10:04:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b6264734csm3506396a91.10.2025.10.10.10.04.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:04:45 -0700 (PDT)
Message-ID: <3bc4d3cd-7bae-44e2-ac2d-f98263b0c94b@linaro.org>
Date: Fri, 10 Oct 2025 10:04:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] target/tricore: Declare registers as TCGv_i32
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> CPUTriCoreState register are declared as uint32_t since the
> target introduction in commit 48e06fe0ed8 ("target-tricore:
> Add target stubs and qom-cpu").
> 
> Mechanical replacement of:
> 
>    TCGv -> TCGv_i32
>    tcg_temp_new -> tcg_temp_new_i32
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 80 +++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

