Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E46C19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 16:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s02EO-0002BA-EI; Thu, 25 Apr 2024 12:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s02EN-0002Aw-1n
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:45:55 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s02EK-0003Hp-MZ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:45:54 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c749bfd46cso657188b6e.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714063550; x=1714668350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxkjBxjcDrvn78vb5NAb1Jf6uZlQ94jHChOFWOVa6cc=;
 b=HF4cJDB4RbIldXvE7tfrMJRg2wB46sHaPsS5hc6zyJ7hHlFdGGeiCw9zLUDXWorYUt
 B6vu0vTbHgmUy6XlXChBcu/sfGR7e+oOBDbGw6jX1GuTMJ1/PAGLtqoW3L3AUgFcJ4Pd
 a0jPqWjj0ZLGFnocdBl2T6QJady6CeLQVH6rv8YyRsvsVaRCBzURIfuozTKraz5sBiEM
 tgDWeoq9or9yIVgOgKuk0+O5U2YtjmW5S1FpkXc33rSli4dYm4klZIsfo6Dq1jFnVDVM
 71Jq1lk4M5xqAU9rv7Ppre1MQeoW79TiTxRWah4LUQ5atAnhvDiNqTzLEVdpiGNZFIV+
 xz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714063550; x=1714668350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxkjBxjcDrvn78vb5NAb1Jf6uZlQ94jHChOFWOVa6cc=;
 b=AVPMcXXlqBF6FohX9Sd4czk//bslOJuGPsBPPE869Vnc2PXywnkLFOKFxc5o7pzTi2
 YdBHFQ0C9mb0WsbGdggKyFVwwGtvbptGrYilZ+9SeKUIK745rwY5w64zCCpnkQCPCdGf
 RDW8u9G7XVmhJc+Z/EYk0PT+Ff5UPMQ1LCPzFwCzj2Uq9OP+dFcHDjy33d8B0ln6TQDC
 QY4M1QRwRCegsviA9sMV/4MfGoy5BNV4SlpeDrEJPmoKeN15Owt38bXe1k9xVOGQ/cKF
 JPDimJIOsRi/c9iWpuHqaBB4mJhX9zrm+pstPe9iYPYoOxiWVs2DXDILjf8Bk8P8UV0o
 zjtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdXM086+X1gYPMJgZ5y95Hc52aonELRKOJiX4WFnXkT1ktz5AFtpEHFNRIo17e/cLJyB5prdS5MMKPSpvMBHltCr6eSKI=
X-Gm-Message-State: AOJu0YyWkJNyPacke10rERPg7j9DvFNr6llF/t4AS+VxkgjaWSQI4oGe
 tlbhYImiPTOVmBl+7L9LEfi67WwzkAlBQg0cG5xglMg4XQSHo4QPh2HJfUNt8D0=
X-Google-Smtp-Source: AGHT+IE1LQ10usrahQMJT+CXeIjCYxNLilMoX7onS32Z9dO03TIv6o+jJAIHQqP3/YsdXVr6U7jUEQ==
X-Received: by 2002:aca:1206:0:b0:3c7:314a:2ee with SMTP id
 6-20020aca1206000000b003c7314a02eemr228663ois.42.1714063550444; 
 Thu, 25 Apr 2024 09:45:50 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d?
 ([2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d])
 by smtp.gmail.com with ESMTPSA id
 dd6-20020a056808604600b003c715075338sm2270797oib.19.2024.04.25.09.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 09:45:50 -0700 (PDT)
Message-ID: <b4cabe11-08eb-40aa-996f-d5ee6efd7e9f@linaro.org>
Date: Thu, 25 Apr 2024 09:45:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/37] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 4/25/24 03:39, Peter Maydell wrote:
> Hi; here's the first arm pullreq for 9.1.
> 
> This includes the reset method function signature change, so it has
> some chance of compile failures due to merge conflicts if some other
> pullreq added a device reset method and that pullreq got applied
> before this one.  If so, the changes needed to fix those up can be
> created by running the spatch rune described in the commit message of
> the "hw, target: Add ResetType argument to hold and exit phase
> methods" commit.
> 
> thanks
> -- PMM
> 
> The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:
> 
>    Merge tag 'pull-tcg-20240424' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-04-24 15:51:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240425
> 
> for you to fetch changes up to 214652da123e3821657a64691ee556281e9f6238:
> 
>    tests/qtest: Add tests for the STM32L4x5 USART (2024-04-25 10:21:59 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Implement FEAT_NMI and NMI support in the GICv3
>   * hw/dma: avoid apparent overflow in soc_dma_set_request
>   * linux-user/flatload.c: Remove unused bFLT shared-library and ZFLAT code
>   * Add ResetType argument to Resettable hold and exit phase methods
>   * Add RESET_TYPE_SNAPSHOT_LOAD ResetType
>   * Implement STM32L4x5 USART

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


