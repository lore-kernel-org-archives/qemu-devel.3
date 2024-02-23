Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE0AC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdby4-0003xC-0F; Fri, 23 Feb 2024 15:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbgo-0000gU-2j
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:58:34 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbgk-0001CG-Sd
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:58:33 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so466038a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 11:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708718308; x=1709323108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfOUAy1mh5dsDQ4iDIJnm3V+EpuC9KpvDAEDhgMgZYc=;
 b=XB2VpLDOWVoFHUf60usdZZPZxTbNf36AOhITfNiLKKz8pG5rqNunVN22ZX8rQfmZ84
 Wx6it62B5WYY/EkpqLN4JnijwxW1Q6krwlDFjilNgZln3CMKQ777ys1bHKtBsL0fDHpl
 /Of5JPklT3OoJ2DT2H98UNTIRWxb7wT1Q/WmhJtqjzHIiw3zuCvwPaHXYRA+abSSmG0v
 GZBEKHetOPWME9gYuLtHvi2MC1ISLZ9mI2txU87FFs463kWZYp3RuqqQrKbYn++TyFZL
 JFAYnRV3DrhoOV0lOxhjcG7A3fPW8meDDG4E27gE/j0BQwShVuzXGONE5zOvwiUPiAKM
 aK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708718308; x=1709323108;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfOUAy1mh5dsDQ4iDIJnm3V+EpuC9KpvDAEDhgMgZYc=;
 b=DGOiFpUKq4Eu7rQmslotPDFNKvwgAUukHd1Y5kB7HY4ScSTQwt4+k3ebBVlPOVkRs8
 XezwOVto7PdKJQ9CWQZSU9D78srY7cVxsUzLgfuvXdCRFVu3xtcCCcPFkArWVFgTuJAM
 kds2Pci4mb8IduQoVayFPmfIvd/aFL6JsY4cDewJWN0sqUY/Zrr0MWfDe1d/+YPkVtvw
 91TK4jF4XSy8p01jyWX8YrxcRWK1iJu3iKddHm7beb4kzVGEBz099xe/rttGeEgbfk4F
 F0OpEeDYjye9d9s33Zoq+2sJc6iOPznxxlIJIRiqVZGeD6DORsiXbeb8K2PbbKm3K37e
 KLgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcRfkqHz5eCWxeGk7sQ4YhKfrZOfVMngLrI6HZ1/L8VDp4dGKlOrdPR8WOE0kCHn39WlyJQxgTKMLgoBvGIl2oQIpI6eo=
X-Gm-Message-State: AOJu0Yz9Z++OHjIkHSLFPoAvqLjhjmXsfr4wCLdqokYF+xSCu5OgGa+L
 ySJ4tkcL+vn1JE+VRLNqxrxEfp6NzzhP4TUahMyqheCL4FdwCudUGXCsKM70XVk=
X-Google-Smtp-Source: AGHT+IHCqHET36lnO+8/9bDZBRBLNzQbaG1YpVxeFAm4cpla0YxqRs1PjndYHaXjtUXvcv9XktuoEA==
X-Received: by 2002:a17:90b:4c49:b0:29a:9316:6f4f with SMTP id
 np9-20020a17090b4c4900b0029a93166f4fmr908513pjb.23.1708718308326; 
 Fri, 23 Feb 2024 11:58:28 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 oe4-20020a17090b394400b0029724370ea9sm1907224pjb.47.2024.02.23.11.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 11:58:27 -0800 (PST)
Message-ID: <1ea2e320-9ca0-4efb-94f0-3f9aa6f585ea@linaro.org>
Date: Fri, 23 Feb 2024 09:58:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/21] target/arm: Add support for NMI in
 arm_phys_excp_target_el()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-8-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
> with superpriority is always IRQ, never FIQ, so handle NMI same as IRQ in
> arm_phys_excp_target_el().
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v3:
> - Remove nmi_is_irq flag in CPUARMState.
> - Handle NMI same as IRQ in arm_phys_excp_target_el()
> ---
>   target/arm/helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

