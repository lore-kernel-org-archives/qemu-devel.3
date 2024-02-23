Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3AFC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbH6-0007xi-0V; Fri, 23 Feb 2024 14:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdauZ-0005XL-UV
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:08:44 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdauU-0004ct-Oe
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:08:43 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e48eef8be5so905200b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 11:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708715317; x=1709320117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDf7e7svQP9L1qovMccgNijnaASO0kpPckZo2GDKiME=;
 b=WkesYiNWmQZmUot0ObTyYkFHKNICoQP3Yrrmh9QsTF7kS9ivRgDNI0TlzlmQT8zOMD
 CvuDLZoW8yZByNsEY7Nk2siJJm5AnJUZf0VfrRRfKptF0kTXfu+VEfufQvPY8v0rgwnY
 +cnyFCdWTyTjdnGNSWB4fqiFz/QgDl75MTcQStmpBOXKpiD0ky6LDH0akdUgGXcKuUPG
 7tc9ScvBwIkgMvowzKks6F/lsMJRX0Qltx06R579O+ZbN/bHVS5lxHglo4t6TRfVH1I9
 Bje6I3hXZcr98zJFd+pl6Db+LyvJs4N7ypXwY/L5e1dDPJFzAlPizDUnSvrLx8kWCWaf
 mPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708715317; x=1709320117;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDf7e7svQP9L1qovMccgNijnaASO0kpPckZo2GDKiME=;
 b=UEli2zpLsBUoeXK2M5Onzdj1/IYPqVLbnH1uI0I79kzRe9tX7XHxrer5QiXZwUfsAb
 Fx01JY4afaTZuei/Z9UMToogYGNRS/VQ7+SyEIIXWn/HRL0MiJhps95//Za/FDzJJrAL
 oRGwiBVGIvdzxjzPPWxcJ7i0loCxQUOLEOn4YD+fqJbeZpL7VMPNVFuwscIolrE30r66
 4tPS58ZOBsG+Ejzvw1BjLCxvlVPmrgvsm23JkEwVLITOWMaZfAxKQrYr4mTuXifGcAG9
 6arqUtsq1PcHW8IWIe+aGjkeuiNiLpdWBRoNUIc47rGZ9n8YFaFPVcEUQ1g1ZUSa1wiv
 Gd/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQkKpT5e0Ddw5QA59yktvKXiQANxe0QAYjdx2DhPOseQsh1UzWQWhghUTCCcdgeeRam3opILLLTX8Efi5gxSp4Zp2VGGo=
X-Gm-Message-State: AOJu0YxGpvl56mTIgEgqrVhjzuekWMTRCm8PAXvOmHP7ZWav+Vm5dhTg
 uq9/YtLSxDhLlYs8tXCGrq/Km9WlPfm4Cu5A0uXQVugWvEINNGUgYEiAFkm90Oo=
X-Google-Smtp-Source: AGHT+IF2QDvoL6pYnkHWvLBeOyyjnnaNSelhIKv4KGtfoQXr52/cyuqHYONJIebV5P76AZYeuigBgA==
X-Received: by 2002:a05:6a00:234e:b0:6e4:6163:7e05 with SMTP id
 j14-20020a056a00234e00b006e461637e05mr814717pfj.6.1708715316973; 
 Fri, 23 Feb 2024 11:08:36 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y4-20020a056a00190400b006e1463c18f8sm13142887pfi.37.2024.02.23.11.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 11:08:36 -0800 (PST)
Message-ID: <69e42fda-e279-4e4f-82bd-95588cee3081@linaro.org>
Date: Fri, 23 Feb 2024 09:08:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/21] target/arm: Support MSR access to ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-6-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> +static CPAccessResult aa64_allint_access(CPUARMState *env,
> +                                         const ARMCPRegInfo *ri, bool isread)
> +{
> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
> +        (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {

No need to test arm_is_el2_enabled explicitly, as that is done by arm_hcrx_el2_eff.
The bit test with TALLINT will fail if el2 is disabled.


r~

