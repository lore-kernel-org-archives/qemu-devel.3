Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24CFC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpT2-00078c-I1; Thu, 29 Feb 2024 18:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpT1-00075H-2k
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:05:31 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpSx-00074q-MK
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:05:30 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e432514155so728127a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709247926; x=1709852726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVG6G/jUwC5ZGCxbB2nYaoKt15Hm73i6FrQGjWZf71Q=;
 b=xha83Qe2PvKi9Rfvtba1JEQC5j59u4RFXaQX6pXV85rh6a1RduFC0pdLBlPuSY0ZyF
 5SVxwp7+gi8M/H2JupQkVhOCIyb1WfUzfj9tY8gV7xvbF41au5jaIMO3YvP8NP2qc4rJ
 DE3FISmUJD5dcyb3lUuNTr7zV6qtDgGQnE8WtYQXkLM3Ybqs3gCzM5OasQ3MSPG+Ci13
 yrVUagUCB/2aS8KsZUqjcOO0wGL6MpzmT2jRbFh50EYCGkzImegqnTUwSsvXt81Cnt9w
 iFL54yI2dIGFWdeh5GTjJBEPvdKoYzErZtbpQdS0CvxiCYAg9dykznXeM2UBXGHWI0UC
 ODRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709247926; x=1709852726;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVG6G/jUwC5ZGCxbB2nYaoKt15Hm73i6FrQGjWZf71Q=;
 b=N6TYSx2jRdrXq8CLA8xyABdlsabEnfDENlacJHzsJWX2A6vLtDWTEfy20PZF02GSgJ
 8ge+etqn8zkHnlDFjxt0r1Nbwkc03cR4maNbPC9c1c98svzwV/9j+YJ5Zmg6Q2P90Uwg
 jc8IP5eIUmRQiDF+o/msoztOI1jCTsXXVv46eiDoN0qQAfkPzXihKz2jtfL1+d5lpsMF
 /2pdsIE3s2noJKxf4p7wmS+1vpNGX/E9+5zEgS8lYceYPbEOxruMsOTcqN5loWrCiGGK
 HIUpT7LYR0g/V5I//S+0S5fa9ABLwPX6RM/FCNps28Poz1BVY3J4smXjUfNbPjM51dCq
 UpZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJC/ssdKDf7K2HgUcW/Mm1SZERIE9CM08rRS9+4T7XqEz3Jwh9DfOrl9pYoiEvvrk1QNqSZdi80YCx4TBfdtSB/DFhggI=
X-Gm-Message-State: AOJu0Yw1YIL0AM7cSkEuBQoHJ/gydbwAWh52qfWIaEMwDJD2rJAJ79d7
 smIjuoApW5Gf50pSk6wN64YQFdyrxljQfHUW35bIJSN28O2A2g4UIdCmzNKrNxE=
X-Google-Smtp-Source: AGHT+IHDtAGTgQxfLRRpGZqDMKDqxQ03dkLktuiYjbzDoqfmIT7dS5PtD0+CKM7eUD4UDgNq8nwtEQ==
X-Received: by 2002:a05:6830:1db7:b0:6e4:8caa:6b13 with SMTP id
 z23-20020a0568301db700b006e48caa6b13mr130716oti.4.1709247926584; 
 Thu, 29 Feb 2024 15:05:26 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 i37-20020a635865000000b005dc5289c4edsm1817304pgm.64.2024.02.29.15.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:05:26 -0800 (PST)
Message-ID: <886af10e-2534-4d97-a705-573bf95793be@linaro.org>
Date: Thu, 29 Feb 2024 13:05:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/22] target/arm: Handle IS/FS in ISR_EL1 for NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-9-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
>       if (hcr_el2 & HCR_FMO) {
>           if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
>               ret |= CPSR_F;
> +
> +            if (env->cp15.hcrx_el2 & HCRX_VFNMI) {
> +                ret |= ISR_FS;
> +            }

VFIO can be raised one of two ways: from the GIC and from HCR_EL2.VF.
But superpriority can only be added with HCRX_EL2.VFNMI.

You need to verify that HCR_EL2.VF is set before checking VFNMI.


r~

