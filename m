Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B3CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o8D-0006rY-VA; Tue, 30 Apr 2024 10:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1o86-0006qP-6z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:06:47 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1o84-0003xj-N2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:06:45 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51d20472133so4168195e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714486002; x=1715090802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wll30t4lzfyIs9DXRAnPNddBWsjy7BQfhDRLiul3yl0=;
 b=Yn8OdjBoM8/bqsH+clL8h1PPu3iPSDNRiGRYL6egcuJuWpHmhNZA3prrKde8uWtxX0
 2BVkoTMm3ZcKwSBsBY13MVRW+gxu24zgsBNZPd/0GCbBZ8TRpCm+c17IPmnlDusZbiVn
 jn2n5RZnoqaxVirULtxWMUFEwRzNq8nqbwljdRnqlyq/y5WJ9NBIbtbwLVgS6Oe9YAe3
 QAOVs6mtdfaZZbS7IdDdUspr+QCttgPLGVCZiya8ZxbyOXt7TIm2DreA12zFfW9p0jh0
 19QQWNxWLS0WTABGOReDKZXuYHEV7B1xkqNdnKiNcttyJte/zpyRORSWbjaAN02cJz3m
 lJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714486002; x=1715090802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wll30t4lzfyIs9DXRAnPNddBWsjy7BQfhDRLiul3yl0=;
 b=LFfpAxw7T1QSHo3su83w6NeeNY3mjOAq7zBk5fjQ0xgXkfaOxLSJPfMdsw+5DX1m/D
 STZKVUcDQiqvBZFVKVH4QbzSz6d5bX3GVZcyhn3XchFPKeDAqc1GiK4RAg8vASzheksR
 BEftFx3vefhEWvxtRpglI+Az2iSOAoU7xdDUzlOjJVd6KmgMBOLjjcPrBloymH1ZfvQ1
 3iJcwlxX1UI7XTgRL2LMIh7GvFLpunOPaiZdVwD3jT4Af/9B3qnhX6/L3HszqpuvviFq
 4baqgCEB3HGyOKtjT3f6jwQy1bmYZOAqQDtrUrBQnE/H2asjcoMn7/aYiOV50hOCl0tH
 MSKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyMGUpvwrDJOuKQzghU3pG0a3xrXJ8z3d/uv4Tr56J8nXEQ1y4rkpdagCpVmPQDzdy+2dg6LBaEGQRGOZ00dRw3C20UOQ=
X-Gm-Message-State: AOJu0Yx+FbgMnea3WOVBX60Sk/nVa2dst8PIVd02C4CewdGzN0sYSb7o
 H0o51Gtub9SKM69AKunXmqnv0eXdxQr4s63M24jwKAdujuY/aI39+cIR4ct8zZ1MTygpx2ZdjIo
 q
X-Google-Smtp-Source: AGHT+IGTwVaXVfJnDID989+CZWFIri4kiqv4Q4nFbMhputwcXD5OUTDuhM7MFtWkBOXXCnQW26/wgg==
X-Received: by 2002:ac2:5586:0:b0:51a:cb81:8f77 with SMTP id
 v6-20020ac25586000000b0051acb818f77mr8492191lfg.16.1714486002301; 
 Tue, 30 Apr 2024 07:06:42 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 h1-20020a5d6881000000b0034615862c64sm32153392wru.110.2024.04.30.07.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 07:06:41 -0700 (PDT)
Message-ID: <865b2cea-e345-4552-8b71-b8d505c8bb68@linaro.org>
Date: Tue, 30 Apr 2024 16:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool
 for whether to halt
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430140035.3889879-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/4/24 16:00, Peter Maydell wrote:
> The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
> when the CPU is halted, so that a target CPU emulation can do
> anything target-specific it needs to do.  (At the moment we only use
> this on i386.)
> 
> The current specification of the method doesn't allow the target
> specific code to do something different if the CPU is about to come
> out of the halt state, because cpu_handle_halt() only determines this
> after the method has returned.  (If the method called cpu_has_work()
> itself this would introduce a potential race if an interrupt arrived
> between the target's method implementation checking and
> cpu_handle_halt() repeating the check.)
> 
> Change the definition of the method so that it returns a bool to
> tell cpu_handle_halt() whether to stay in halt or not.
> 
> We will want this for the Arm target, where FEAT_WFxT wants to do
> some work only for the case where the CPU is in halt but about to
> leave it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h       | 11 +++++++++--
>   target/i386/tcg/helper-tcg.h        |  2 +-
>   accel/tcg/cpu-exec.c                |  7 +++++--
>   target/i386/tcg/sysemu/seg_helper.c |  3 ++-
>   4 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



