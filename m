Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E8FC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 05:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue5w8-0003YY-Dz; Tue, 22 Jul 2025 01:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ue5vy-0003RX-Ep
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 01:53:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ue5vt-0007Wt-Ab
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 01:52:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so2445333f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753163575; x=1753768375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4alBfDXtH0Yd3e2TM3R3sXaqbkUqWpnXF3Fc/WNWPUk=;
 b=KWHOfOSKOk59y/LDnGJCT/qcSZk0JmruwKDZ+MysTD2o/60UA6A4/rB6RELTrHFYe6
 ISQgvnCvkMgqSqMBOTLZcZc7RPHUCEEZcn0X6L+q9ENf/ztj84RcHaoV1F8FiwCIlYgV
 6KPD8YyWbrOBXMKZFaCnGTHsMf5iAgfmTDyZRYcK1iSd9xVCcV71vXV3syEyeIA7y+xR
 mTFZngZZJ2Sc+kjtDC6qiZO2/GIyMSDRpw6PdcStxVn0L4a8TQDZKNoTTUjegcy5LkW5
 EAHTDZ2C+HUUlIbJWIdtNmtFxYIcTWRbPxChnq3KofvgjuOEBGvpEZ8LxX4OxBPnQsnv
 URBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753163575; x=1753768375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4alBfDXtH0Yd3e2TM3R3sXaqbkUqWpnXF3Fc/WNWPUk=;
 b=FsZBPq8m22xl1JyLN2S8vokBdwewayUAtRVn0Cal2lwFZcZN0pdhp2C34QT5xnVcT9
 4F/sG5wfPxRCHuz3rD6l24FrTQIsNMnz44lyslye9LuwkBFGF07G6VGCuxukIGmquKMY
 c/0n3oROr7mYATl8VplxDxFOeSmIx9IlhLRGvj/xVx5QSsjzNyXNt1M7yzHkD8596+jz
 13ICf8ncG60vCr3hhc7DGwCVHP553xu17yYV/9iWLbBCnY+VoXLfuvotfVHESZ0vb9Wd
 nyYYO9lEXUylGLXRNVSzKLU/QdjaLuZrxDJTnfvUFj0ccuPO31FYWrT1UoHbmcHpLa2Z
 1TSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWodvdMo7MK8hSRdDsMS7pqixv97y+a9XE27fCIdFG1XGIo8gqB8kK7bMHVioqpOVPfyW+z10DxyysA@nongnu.org
X-Gm-Message-State: AOJu0YwpafWpK70SpCR5BDRnlFiZC0AT9HuajfscfRVxv4iFX3A6eeSq
 ZUMXxZew4GYPfSiqnpLpY85Wf2xan+MRkresZgksUvSkLhKAbGL1lTcaFsOpel1QI9I=
X-Gm-Gg: ASbGnctzntLId4K/kDspapipGmuy+D99H8mjJYKflv+3aEI9LuifuA0Z1Tqnd6eKHZ6
 wOJ8FmaE/OT6gtDgUQCqHY0/Fh8Q687t8/ZbsyWjfLXkEqklSUHaqZG+be/EUu6y7ApbjlBBp6d
 8ZEiVhTWOYmUDWPRe2AjOL1IjrK9oPqWz3z0ruJD6OeplQNgIATDWq2NVJgJr10FNxQYocnDSvW
 tLu96AyZyEoGyjuvqqXFQ26Mcv6Uc15mV2xO0zrRS+KtXe0FQHGi2N1V8vLYKqrObOOsIx0j/8l
 hWrEzWtrnaCVBa/t8DKNc2Q2o3MebvhUdTaYY96/P0iJ7T6YzvIZMdpgmI3VX3JcCacZAYV0h9Y
 wK0GBhdfpOlguaBva00NMX1KwuuhPXKCk+wgj+ZBE20ZnCU9Yfyg7N5QgMawb0FndvqZ1DWQ=
X-Google-Smtp-Source: AGHT+IFMTmv9F8j0Gb0Yk5kQzB78XXeRj7VoRJ6RtUW4u5puHppiYvQ0kBLMOm8eInDzyBo1gOWH/g==
X-Received: by 2002:a05:6000:40de:b0:3b6:1e6:c9fb with SMTP id
 ffacd0b85a97d-3b60e4c510dmr21008799f8f.11.1753163575242; 
 Mon, 21 Jul 2025 22:52:55 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c9e2sm12651343f8f.89.2025.07.21.22.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 22:52:54 -0700 (PDT)
Message-ID: <6b86402d-6a3d-45cd-b680-a83fe5818945@linaro.org>
Date: Tue, 22 Jul 2025 07:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: hvf: add timer frequency note
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250721152902.38671-1-mohamed@unpredictable.fr>
 <20250721152902.38671-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250721152902.38671-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Mohamed,

On 21/7/25 17:29, Mohamed Mediouni wrote:
> On Apple M3 and later, the timer frequency within apps and VM guests are different from each other.

Also M1/M2, so all Apple Silicon chipsets IMO.

This might be the issue I fixed here:
https://lore.kernel.org/qemu-devel/20250620130709.31073-18-philmd@linaro.org/

> 
> Note that app binaries compiled with older SDKs continue to retain a non-1 GHz timer frequency on Apple M3/M4.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index c9cfcdc08b..4331a3386a 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1018,6 +1018,13 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>       int i;
>   
>       env->aarch64 = true;
> +    /*
> +     * TODO: This does not correspond to the exposed generic
> +     * timer frequency to the guest on Apple M3/M4.
> +     * This is due to a scaled 1GHz counter being exposed
> +     * to applications built with newer SDKs when running
> +     * on that silicon, while VMs get an unscaled counter.
> +     */
>       asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));


