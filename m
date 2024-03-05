Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B2C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcYZ-0006lT-GQ; Tue, 05 Mar 2024 16:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcYX-0006kH-Tq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:42:38 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcYV-0004eF-Df
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:42:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc75972f25so51800515ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709674954; x=1710279754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pq0Xsw5R07A+g7p1jetVznUTr7HaY1sC1RGtr3wuN00=;
 b=Nmjme4xmaYdmUTYB4OVakktFNZ9qAXoCSJEUr0szuu0ikDwJBzFjqAJdlD/HEGiWjL
 Y4m+oLbbJEtCgTjBU4Z6PpeaiL/xrea+b2I2cL+Q/3/tvkBjLHtFqRN2SyqNEkVLSrDT
 JHzTEj4DVyJeFnK/YOtgyNgXPm40RBtZQc9eY1c6JNBtdqDwwhlrnHD609BYgl0Dtbvi
 +Ti5Oqsss/f4/+Z+HvHeONMF3aGxtJICdme03Txn/KmevHX6bquInxe/u5FzoiSIJ0NQ
 S7n+DXDNTGxIIatuvfZOFk1ki3PRe9cBCgFT/JCqBfWix0R/0WYyBReV80XqXZejplxa
 CLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709674954; x=1710279754;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pq0Xsw5R07A+g7p1jetVznUTr7HaY1sC1RGtr3wuN00=;
 b=o1+77glRQ1RySmRPBe1IVP/JLuAOpf504YuVFaA+jM9fmHzHdvqEldlivvBphVM5Ah
 ky50A+R2pJtkSwjySMJcn9SUhQUYBGF/Pjj4vsWRcxX9Kcn70J0ZGsudN2ALbSTJXyRu
 CD0rDf4LZtIUZ57rdzLxiiOgCMDzaL5Xl1nkm9nMB+sXCMuVmCiFCE8KSobhBBR5eDbY
 5OSKwCnWhJErEOBgTqKww2vyOBxWQ0t7bmzYUlGYNLWAUashCdVw5MZYm3XiARS9crC1
 Onq18oRjgEautywEtAtValIod9H+1SehKCvHsyrVgoyTNBUUQwIlrdh3qiMUqksJmlZq
 LiXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHiCxbphHykM0SzgAyEghzft0kmQ2V8JcmxDRIZIjg5XgBdldkede9XCqCGQTTRZhmrmm7Wcs3AVxzW/LVKFOXlZE9aQE=
X-Gm-Message-State: AOJu0YxrgiC22VNqwCZDaDtj0uBdpLRaXFhQxhnIZEYq20nW+ILzuAjc
 5eBnZdk7riJOYBGm8lEo/grVV+h5MCAXYOrnx9oCLLZrLx+oN+CGlPGN0lrThSk=
X-Google-Smtp-Source: AGHT+IGauUf8N7qlaUj3JyH7R0p+1ot/Z39FlgvXlVPe4ciqivSrlw8sl2rFBgY9hB3cU8f/BosqpA==
X-Received: by 2002:a17:903:192:b0:1db:4746:5fdd with SMTP id
 z18-20020a170903019200b001db47465fddmr4113864plg.43.1709674953981; 
 Tue, 05 Mar 2024 13:42:33 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 n4-20020a170902968400b001db8145a1a2sm11074557plp.274.2024.03.05.13.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:42:33 -0800 (PST)
Message-ID: <532d9634-ac02-4cb5-86a0-c09d723cd65b@linaro.org>
Date: Tue, 5 Mar 2024 11:42:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 08/23] target/arm: Handle IS/FS in ISR_EL1 for NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-9-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/4/24 21:03, Jinjie Ruan via wrote:
> Add IS and FS bit in ISR_EL1 and handle the read. With CPU_INTERRUPT_NMI or
> CPU_INTERRUPT_VNMI, both CPSR_I and ISR_IS must be set. With
> CPU_INTERRUPT_VFIQ and HCRX_EL2.VFNMI set, both CPSR_F and ISR_FS must be set.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v6:
> - Verify that HCR_EL2.VF is set before checking VFNMI.
> v4；
> - Also handle VNMI.
> v3:
> - CPU_INTERRUPT_NMI do not set FIQ, so remove it.
> - With CPU_INTERRUPT_NMI, both CPSR_I and ISR_IS must be set.
> ---
>   target/arm/cpu.h    |  2 ++
>   target/arm/helper.c | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

