Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A48FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnPJ-0002Lo-CS; Tue, 16 Apr 2024 14:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnPH-0002LP-Rs
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:19:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnPF-0006k6-ND
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:19:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so3809902b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713291584; x=1713896384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2odyEPYb0dluu1bEYvaxRiwdXOkoNYTG6BbOmky59E=;
 b=lSUrCNltAaoPZg6YLaJYNo5lfco2ehrex6etnUyILjR0ujU6ZMw7WyDFSMCL8n3yj5
 dbNvgBjgX9cD19Lz1H7Dzz3D2OmNAMakJcVd7LvIxne0fopDwynoB3SFab5B26uqCw6X
 Ic8c83KKSM3SyY3pCAtFpZxTMiGlec/8MwMVbHYkslgGVICYB0w1g6UexhyNsdlXEbd+
 l544m6Wdc4uOBoZCyXrH65fYCLFKfsPk+auHugIUQgAThqGFdBgIey3AkDS7fVNENsjk
 R5zU8hEGqw7nTDX+bEJWe1gVuceLSokf8kVqK7c38x1/LG9WjLYBaFhKUZegyw30nthD
 YMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713291584; x=1713896384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2odyEPYb0dluu1bEYvaxRiwdXOkoNYTG6BbOmky59E=;
 b=htsEjMnr6D1yDiBxM5ucsYxH4eUigufD8fYB0/MpjFUXhOsCGLlz6KrZOzzNxVRL9D
 /MpEv5pRCpPjfquIgPGyahWb22Yvw7GE3LMxgZVVCiOUbb3PV6EuJoHcC9k4HTsI/dgu
 7ulVoBAuZALBy3HJhmpWfGGhdR8UPuEeRNChHYEnB9Xv06tUZFwECPI07Gh4lVBP3wap
 TpFc/CuyPQXWA2CCpQ8+ci5Y33pSoeHnvXq3n4CV8Jc5HoJdqb/KalUvnczg5gEIXHVp
 01MFxyD628uJR9KCcuKa1gSHrLPcb4MBE0SHI+05SOicS5HxsKIYUAfEA2AQECSFxaAM
 5cnw==
X-Gm-Message-State: AOJu0YwrW5FXPpkZBDooePy2tYcaj/DYXBaiAEUfZMO/VCO6cmkI6I3A
 wsfxpSb/3YHLV/aOGB/d2mCQYZOZQpA6+PJLu9CDRUnVQIH4QByK5SDsTH3Zn80=
X-Google-Smtp-Source: AGHT+IEpo4eEdLPbs62TmdV3ZvfXf4xDfQppexfNd/XwRGqS/qvjferTtw/d9JVXdzLVoSE2j5WrYA==
X-Received: by 2002:a05:6a00:1312:b0:6ea:d7b6:f4b4 with SMTP id
 j18-20020a056a00131200b006ead7b6f4b4mr14147663pfu.21.1713291584213; 
 Tue, 16 Apr 2024 11:19:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fa30-20020a056a002d1e00b006ed0f719a5fsm9182226pfb.81.2024.04.16.11.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 11:19:43 -0700 (PDT)
Message-ID: <45204f85-3eb9-40f4-9f2a-3a3f0e75929e@linaro.org>
Date: Tue, 16 Apr 2024 11:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/ppc: Move divw[u, e, eu] instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 	 divw[u, e, eu][o][.] 	: XO-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |  4 +--
>   target/ppc/insn32.decode                   |  5 ++++
>   target/ppc/int_helper.c                    |  4 +--
>   target/ppc/translate.c                     | 31 ----------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 24 +++++++++++++++++
>   5 files changed, 33 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

