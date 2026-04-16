Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72C1F8DFC3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU4z-0000ja-1G; Thu, 16 Apr 2026 17:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU4o-0000ep-WB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:16:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU4n-0004lB-75
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:16:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so1962801f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776374199; x=1776978999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Er4w/0iMVv/SFCVz225iiqrzvn0M6xuD0u2nXzoUkOw=;
 b=Zq/rT75feg4X+UP4yEd00hqY6AjnFpx5qHHrBxiLAkSSKwuXhajj/qwT4q8uw4KYfV
 Mn1pT23LzK9ULc9uUlyEo+xZOPCTzEOt3G6pQFfr/ug/RsdTm6BFPBUb4Pk2jCnykUmG
 c1LIR35dM3Q+lxUNqgv9N+/Xj5WvbDYdotcTYJTEBAdsdoNwTqWwfNgMwLWbGa8J3Wgm
 MyGpeZa2hbtxDbK7fXivdHutANF2OMQWMkRjjc5/NIqL6y3T5ao4n3fwD60u5lTCSIL9
 T3xt9RmVoQllYFk0SvJG/Ia/6bMuS+HKWrpc1w30NrJpMuksS9OgUNvyMCQ3KtGxCNsI
 QMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776374199; x=1776978999;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Er4w/0iMVv/SFCVz225iiqrzvn0M6xuD0u2nXzoUkOw=;
 b=tXXmjUDrQzZ5F+j3V7pE9WRY44zp2hdo/0g1Q4aCkCbdq6AF3bR3WLDI+cBl8+91BL
 IyBYfkSK2i6B24qoFctXkF7YRifCidqjX6RyZHBQvlVDrVI9Zo+lgjS5gpDHrQp4NFoJ
 paiDWSsyKPM7/lvzMhyvZ03lJqvQfusYa5STdKutYH5X5kF5AAnd+s4u14upSCkty+qk
 fXA82l1rjDDQ9gOw6SEibulkZz1qDGx2C0+CtJ0nrekA5yfU26YrQ0zmEamOl8F5zsNY
 VXKQlMeThYQVEMOtFzsEW8c1h+f8J1oOmuUMSmh7gr2R10ay3ZF2yClt9H2GjEbxMgIv
 0rYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8An9KHLcLR8WFTrCVubsbSuTEbjfR8/dBa87YiSMnff2eRssh4Q3DX9g6p4jh9XXcYwupFYCA4FK2v@nongnu.org
X-Gm-Message-State: AOJu0YwwsEyJ8UBTfhAf0CiQy3JKeUrI+jl090rn/9T1aajSX/QQfBbL
 exJQAczr7nF5TGsQA36J7ED+QJ7CGVuYqGmCg0ikDP2J/zrrrJoDP5GGEoAb+IwmJ0u4ZEEh72M
 preIpuDc=
X-Gm-Gg: AeBDiev9WahKRBVk2NhnkbE4ZCE3KT56o5ghkT+BNPqxZ8IlkqEsweoe9HE4BJTNQTm
 iea7XzM5nA8YHgEMvdhxZ8saEqnK3n2l+40eL6ZhRw7nRCAtPrwW81AGdtec4NFOTvkXGVJsmyV
 T4CPd/JVwTk9AjHXqL1obv+q1SYiBBR+OulWOuwX8yOw+ABEH7MesrKxJ+iQPgCQ83nEYc6Zapy
 qnnaoKFK3cfvJUeoLhW6cCxoDj//wRPJWsWkZIEaNQUy7EM0yhlw1W1CY7w3xgRWxP6ahrALbav
 K7nBVcVIcYsfH1VgqkJpO1iDGEDT3DbDXRBPwrYoHeRt32Q5yHsKbd/JF286r+5cMWF/QuqGOpd
 hP4a1zCIbyIqHhZmi+d/03K36zWc8uOV21eZTbhLQWXuA7qM5fOgjqidomHw4zILkeYPj11v/Ar
 b7GfdQatMJMIoIpenUq+n52Ro68oqbsMzYoWhj52MfHtZycK2DySuvuPYP+eKYScutQMYKD5i8G
 OsIxdmacPf3GII=
X-Received: by 2002:a05:6000:40df:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-43fe3dc812fmr206367f8f.17.1776374199192; 
 Thu, 16 Apr 2026 14:16:39 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5fe1sm16798505f8f.22.2026.04.16.14.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:16:38 -0700 (PDT)
Message-ID: <ce10edc4-5af7-4519-97d1-854b4756c7e4@linaro.org>
Date: Thu, 16 Apr 2026 23:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 16/4/26 23:03, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 64 ++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v68n_1024.h.inc    | 65 +++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
>   create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
>   create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


