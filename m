Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DAFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1Ya-000181-MF; Tue, 28 May 2024 14:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC1YY-00016B-7W
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:28:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC1YT-00037S-3E
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:28:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8eba8f25eso976236b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716920891; x=1717525691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24D/AylI4Ovd0nmyAgowCpokU5ulkH7aJ8RdI9TBq5c=;
 b=EiHNjf3Kr1HSVPIdFVJCQs4fgIt4BaKRCeYwzXTJSj6RDsq3W1PRbhy7dCiU4W9oo0
 whOV/Xey/5UpAYbH0ZZZUpNiSG+cq7OlfphOHgwSR4yXbpu8d0S38dZHaLG4Gx4c9vOD
 y31NwB23GQ68yQeM6GZ1oA+34nAZXZCr5BJlNk9FjxqDXBsvXiCjhK9oi1oA7jTNZgPh
 1CsSZaVxAKTUbXRkBwbC0R82icBTOSlpTuA9U3XIDrEk3KxPo6tiiXt2LGcK9uJjtADq
 pT4T4XDmvYY3xpp6tKsKeoC+HdRjvgssR+jMO50DWLSaccXcf/orF8BLbhhfUH7WMCkn
 YJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716920891; x=1717525691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=24D/AylI4Ovd0nmyAgowCpokU5ulkH7aJ8RdI9TBq5c=;
 b=AuEn0tQRMT/5J0VM87pW8tLudmTgmF6nR+X9HgyW+4jIZ7iG0izf12rBgiz0d2HXnM
 xtZwpPrD8llvn3u0YynQ70MaaPG4w88vKJwET0L4G65jcZMFTBGqKH3sNxDCLVhwOklN
 0vbyiBUi1bphBSUdAj4OMX6AIxuxWhjqSLFz15n5D5eIaRo3QuRqkB6i3TSYBb/1H8Jh
 5zkLYeTaHVzMik2xykXUyrKEpDrgNXSGXOTC5rrHsCJiO5Zey8aG54QFeegVZDmmLeRn
 AChYYpmzxim0nCFzW3tLCZT2Xk/VS7xhHFAWvRZhRYZS5oY/x4RwPM5GQsMPeKgCvun7
 Hb4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoy5uMm3/D5wbBwp4dr/ljWZr6dySdEWbW031DAC9Cin1ncozFXUtmBbNpTKr8MxxasVgrOUzYfD46GSBCKztLGUbudXo=
X-Gm-Message-State: AOJu0Yygd0oL/L2iRppna1Hnnt6pwc3Lh4FB7V2d3zqZ4mS8t3mTI0cI
 gNH4f4HVBn0WHXgpMj/AADt9Zny1gJck5T/OiffVDQReHMYIiWNbj8BT84eKRS0=
X-Google-Smtp-Source: AGHT+IFsJ4DcepCW9pzIAv186EcJPVvoBmyJz+JwiQ2Mc3eNQRWFcckm9klD+lVlAMtj3LtIlfBewg==
X-Received: by 2002:a05:6a00:f90:b0:6f8:d51b:1ccf with SMTP id
 d2e1a72fcca58-6f8f2b49154mr15289219b3a.6.1716920890912; 
 Tue, 28 May 2024 11:28:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe64a4sm6721728b3a.158.2024.05.28.11.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 11:28:10 -0700 (PDT)
Message-ID: <8f0f50c1-da9a-42fe-9877-c61cc49318d7@linaro.org>
Date: Tue, 28 May 2024 11:28:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/42] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/28/24 07:07, Peter Maydell wrote:
> Hi; most of this is the first half of the A64 simd decodetree
> conversion; the rest is a mix of fixes from the last couple of weeks.
> 
> v2 uses patches from the v2 decodetree series to avoid a few
> regressions in some A32 insns.
> 
> (Richard: I'm still planning to review the second half of the
> v2 decodetree series; I just wanted to get the respin of this
> pullreq out today...)
> 
> thanks
> -- PMM
> 
> The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:
> 
>    Merge tag 'pull-error-2024-05-27' ofhttps://repo.or.cz/qemu/armbru  into staging (2024-05-27 06:40:42 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240528
> 
> for you to fetch changes up to f240df3c31b40e4cf1af1f156a88efc1a1df406c:
> 
>    target/arm: Convert disas_simd_3same_logic to decodetree (2024-05-28 14:29:01 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * xlnx_dpdma: fix descriptor endianness bug
>   * hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
>   * hw/arm/npcm7xx: remove setting of mp-affinity
>   * hw/char: Correct STM32L4x5 usart register CR2 field ADD_0 size
>   * hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
>   * hw/input/tsc2005: Fix -Wchar-subscripts warning in tsc2005_txrx()
>   * hw: arm: Remove use of tabs in some source files
>   * docs/system: Remove ADC from raspi documentation
>   * target/arm: Start of the conversion of A64 SIMD to decodetree

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


