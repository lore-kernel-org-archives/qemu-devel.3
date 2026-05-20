Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49029CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfF0-0004Pc-Ow; Wed, 20 May 2026 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfEe-00046p-1d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:37:17 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfEb-0006Jb-Ft
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:37:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso2522685a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779277028; x=1779881828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zT7qQ3F5b6WThctKIowR17uMnW4XiRhf7jNk1LE2oW4=;
 b=VtsEBWvoNxSZmK+wJAyem6Bu48bG+7hpGiquupMXG/rc0SxDqgEuM2Cej6riRpy7HH
 uKNm3DFPm5UpFVRqRLRAxNnYCz6FDDxpg0U3iR6bLWaLBiML6KUjEzsu5uRLSs5QmMzP
 Md9OrN2RPc8WYjCbhR1wwIUfpkRDCLs6xxHgo+mFZgQV6E5gUVROwgDjjop1oBoWOSNi
 ft4S/bmFyVpFGUmIALOVff6vBgLw2mw3sQ/+bRE6CsaJP3FXvFhfnQecU3lazEe96d9t
 YkHMdVshUkQ26gamVIPWDmq1tb8BReqgAEvUvjDO1OZfcQmGRnEzs8Bj0n465EKAppki
 LBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779277028; x=1779881828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zT7qQ3F5b6WThctKIowR17uMnW4XiRhf7jNk1LE2oW4=;
 b=o6RpTz076iCAR94K3QHsMaTt/UVyOmuvD3GfEnbz6YsRwPIrzuCaCO+/dotcfEnjsw
 rgceCSbKtOzrTxu/CQA8qdKIGqYSAIKrfQnpnVJAL6h8G5Y7FmiY4DD+d4AfhXjdlXM9
 /qQXot+eBQuyXGoDNLPx0rJxGRKdzdjiwxGFE37E+byUlkaz7c90wQ2Di6vHyeK/xDoQ
 5aL4AT5mSmGsb4k/gjO8dCDklKSMoorDMpyIwZZqnbXmk1WiNwhNwLxYy+YyAdq4LbYt
 ajMWRVoeq6KrzEvTciaewmFswsqK1XhK75VQLN289IGXmw8AxumCoLyjfRt8eN6Tkt8e
 z+oQ==
X-Gm-Message-State: AOJu0YxPLxgF4ZCQL8V6qgvFm41Efs+lOLCLA6moEP0+7Soljw2yvpXu
 HfDENDD0V2GWuZiPT4AvnWwOK004fThmXe1AFf/a+obAo9j+PvQr9+Pv01Ug/4nPdAit7nUCZxC
 if3D8pWc=
X-Gm-Gg: Acq92OFyS8FYwBfgzwLBYhaCxWWHEB+Bmu7zxgtHbq/mZkx0Fd7uvWs1Vfp9o3dezqp
 gKjt8GzdclCTa8iOa+D2HJ4UuDW5IMSCmqnfS3MzZb/c0zT5veRV+xJLgjkeMmB7t4tMXPUrC0d
 mBP1cUyJus6wMjKnDFFPhSZXB4GOBX79G+MvaWAx4onmtuAw07EVxRGx660HoJA2yfVe8w+OLSq
 R/mSUoe7mWRwXJMY+zqWNTQaC+/QeJ3pa+mzM0D3HDJ9OQITWobj1ccRYkhwYg3mE4afsRw8sHR
 8JMCZur4cttkk1/JaMvphXldWkMKevkoTK7Urqh0vf1K2pDOJRy0u8qBjK0I6VimDZKmqZqHloD
 L/SSxfIVJtrbRTF3G+Uxs1nCuoA1x5YFaTumtzOtoQeTt1DZNceivPWr68yNsQHEd78mCYH34ml
 v60i5iTJIR0o1OmftmPujoWtYC577bdb/oDWt5OWJaJuh++bAjN9UZqYRO2DCzy+HF8H7FlCU=
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48fe539198fmr329320175e9.13.1779273065464; 
 Wed, 20 May 2026 03:31:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4900c16c744sm223531975e9.3.2026.05.20.03.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:31:04 -0700 (PDT)
Message-ID: <383afec5-c9f1-4f9b-9b08-e2c5f30c48f9@linaro.org>
Date: Wed, 20 May 2026 12:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/24] target/mips: add Octeon QMAC instructions
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-24-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 20/5/26 12:18, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane from
> rs by rt<15:0> and accumulate the Q31 product into the Octeon HI/LO
> accumulator state.
> 
> QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
> 32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Add min32/max32 in trans_QMACS()]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  4 ++
>   target/mips/tcg/octeon_translate.c | 62 ++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

