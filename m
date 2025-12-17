Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A0AD637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfIe-0005OH-Cp; Tue, 16 Dec 2025 19:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfId-0005O7-Fv
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:21:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfIc-0004ye-0s
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:21:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a09757004cso43308405ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765930908; x=1766535708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2GIOzOoBZ1Va/IuzVoib1McNVP5UO32jaLALQMCLwxM=;
 b=I9hw4tnXmr5V3GY1AhVeb/ZHRdOoQuz5KbhRDgf1XPzP0ujZml3xLF3GSZrHU3ahBo
 q+inQL5nosYFqiRYVeHuuf2/LhwA+kFEp8xBaBOqKRZfNBPNQawOu9YBcTYH+hQhrum3
 ekTxCJQGmDJBg5/AGvMDQOHDzIi048tSErKsnatfquh5agGbBlJddPlNuoxBoJUpg6Cb
 0LDfp6Kf7g4ZkqVJVRAmdINdOmVG4FdP9RGPs9XdGX/jCOWK7FJ8eK8ohsbpA8y/WX2L
 /lgZORSE1UezqqfwgFenPZ4NTNmioTbfQR4HplpBI79UW6uCPeaeweeSDbvGXdr1Qk9V
 a0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930908; x=1766535708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GIOzOoBZ1Va/IuzVoib1McNVP5UO32jaLALQMCLwxM=;
 b=bCFGIpMS75uLsSt9i1Bv+edTKfzyIeMXk8bb9VLegFoAUOI2YXxgFW/4fvVO1dVF9e
 7y1lZu22vU5GbtpiLLyZiJ406bq1AN06sNczBc97+LJSBNsdfGFi8nYZtuqD6brC/V6G
 ZX0jwB+kTJvlnrh6Hk4Of8tSOPDBIQrjdgEfbATh+dhQn+YUX3klvGvfSoDO/1s9Jokf
 ZaaKoD9tIguUOnDuZ7g76/vV2IP2wLyOKGGIN67YrNlVsXd64Jz15nridhvhBPMBGRzU
 LxDuMJ6DXEZfTZ6yR0M0DcFDG/OwKzav1GdqSLf/JVik2LVld7SusMvgsTgEGWHiieUu
 3iUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcGG4pB6bEPFPlGhq9FJhVDDx5sS6hXHeRZI6gCF1bc8UPuWLcxr98ttEqo03LooQJ8Sfm4fm0JhhR@nongnu.org
X-Gm-Message-State: AOJu0Yzsk26YwyyO0wDsrE1Ub9C67Z3uXL02YclM03IRI45dM54Hy9np
 OZ7e9HvlcsPgqb4ynWBaQLmM0HIvjlFWhPbLdT09D/oOJfmcOfZgi8Pbw6T08DDfIBxy7MEdum8
 xmCcS6umwHw==
X-Gm-Gg: AY/fxX42h8C3Nz8blopifcjrmskGgk+hvTDxpDJGFAUTdmvRkntfuVFh11u2KDmbcia
 b8V/iM2bC7tYiLQOTdt5SHcWBW0d8URFt12QZcxfFTdCCWuXYcwmfYZLExME71dKfVL1df0XqME
 oh64D7zE5c+IImuFJ8H2cjoVM8TO02RujqlAW2BYr2e23P7K6mXNPYIda9czRfCqddvaCAuC1CF
 3a4VH0gFMIdcYl0pFkMVqqCIRcyVWbRFlN0DmQ8rYB0GNPWgKmIvLLRYGl/eQZTd8Bj26Op1lB6
 +peTBlTfgC3r4C8rQ0fHqJUj1X9EpWv9PE5Q/1G0rQ/sj6AMimVqSpJdcrsnU/aGK7641wvcGl2
 4G/vfNhpVfnxA5ePGO/5Ue6XNk7a2j/o4vY/iORtO+Q5VEtH0ZtTdE3p7AYRsPFnU8y+hkWzE2S
 YimMlpGU8UJunPtrsgPy7DI6h+ChV1CjTb8CIZt69GCihFVeSuUO9IP+E=
X-Google-Smtp-Source: AGHT+IFryM5LUelzvVsGaNjweQeswdh5Mx6fd6Vc69KPB5LoVFNDF2bPcEiJIuSSk8BjCLHzlFw7IQ==
X-Received: by 2002:a17:902:cf03:b0:2a0:bb05:df4f with SMTP id
 d9443c01a7336-2a0bb05e314mr101855995ad.44.1765930908411; 
 Tue, 16 Dec 2025 16:21:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29f173823dbsm150257455ad.12.2025.12.16.16.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:21:48 -0800 (PST)
Message-ID: <d378bbcc-7f23-492e-8580-d0910d3ae80a@linaro.org>
Date: Tue, 16 Dec 2025 16:21:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/riscv: Add macros and globals for simplifying
 machine definitions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-2-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-2-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Adds macros and global interfaces for defining machines available only
> in qemu-system-riscv32, qemu-system-riscv64, or both.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/machines-qom.h | 26 ++++++++++++++++++++++++++
>   target/riscv/machine.c          | 17 +++++++++++++++++
>   2 files changed, 43 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

