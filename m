Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEFEC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcXF-0005za-FE; Tue, 05 Mar 2024 16:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcXD-0005xi-1i
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:41:15 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcXB-0004ZN-Bd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:41:14 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso55965725ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709674871; x=1710279671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ihNVgW41v527yiX4XLXfYOFmPJQT2nrCVR5N/Whf8M0=;
 b=Jd229FK/UDUMKLijM/s1wpCRM6QV2iwNDIQQTsBomE5mE9Pacw55CzFzxNYDvP7gGl
 Nda5qTdeLhVqiHDK7NBp+kmpOR9whPUS7Iv6ehEH88xQAQbyoZZMcs/KaQWgienfE3Zk
 RHAL0A9y5v8nZZ0rlVJNvxnc/Fp3KorxtOz1xtbghAopq1pkEvAV+Z5WD9+M7+WR4r7b
 QCqubrC6unVUfXBSUthpdkKs6VT8J21zMH7MTIcnA50y9Si8Qd9F9PTmGjHMcAjTe+Ye
 a1othpiALsYxpLZ83oUObpciPN2epUgEZIfJkwvL4UpzMqW3Tq1VE0eNvxusO6q7TyfT
 QS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709674871; x=1710279671;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ihNVgW41v527yiX4XLXfYOFmPJQT2nrCVR5N/Whf8M0=;
 b=uTkuPfVlIVKu+/+A/Vs5oSHTcUo5H/a5QMU9dLktMO2mDLX4WY0ri1TgJnwDz7G4U6
 8An2nIVsWmtW2+rXEtcrS/vRm7NVQcOlF+2o+HJuOjIoJFm3Q4ydUVQVRS+PrlVlIZE7
 pIC6G8JgPV9hJQoWQ0ghjqdkO53L1xqfql8efNepM230szPjiDAH3Y4wjaElcXDFfqqi
 E6qTAQgslz9N6shc0Pt628XHImefbbFP2w4Sx6bvNciZoSZafZobwsG00nHGG/vFhHnh
 94/036NLi7VZlVfHzJfwL2jAEKleTrhonJd8Z1d3MsCNrhQeoZFfZo/9Dg55f20i/ST0
 6dWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaTtGJzq9dUp4gd7AuY40jBS2lcvIdZ8koNRR4JkWchYvKask9SjtfQx1a/SjzKwgNabkOIwGdFI2jloOQQOgOV9rlg6c=
X-Gm-Message-State: AOJu0YxvoTL4g63uStQnxPIJfn0t2jq/yysGpjHbR07y2zcM8cVOlABx
 0wvaW8Iiv1CKMynFddQeVaeVMgQJ4EY7N5rYlWpGZcQwkzMOsL48MNyfs67jh6dO3v6uJYB3As5
 h
X-Google-Smtp-Source: AGHT+IH29/0k4mAYtI7DYbp6Z2SDoA9R9TaQ4w8fUbA/r194IxxDgw0v1Li4aYPVsBajX+mqn9CROw==
X-Received: by 2002:a17:902:d58c:b0:1dc:d116:1a3a with SMTP id
 k12-20020a170902d58c00b001dcd1161a3amr3644720plh.62.1709674871560; 
 Tue, 05 Mar 2024 13:41:11 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 n4-20020a170902968400b001db8145a1a2sm11074557plp.274.2024.03.05.13.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:41:10 -0800 (PST)
Message-ID: <2f181e8a-2dc4-48cf-b304-2a961512897b@linaro.org>
Date: Tue, 5 Mar 2024 11:41:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 06/23] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-7-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
> This only implements the external delivery method via the GICv3.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v6:
> - env->cp15.hcr_el2 -> arm_hcr_el2_eff().
> - env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
> - Not include VF && VFNMI in CPU_INTERRUPT_VNMI.
> v4:
> - Accept NMI unconditionally for arm_cpu_has_work() but add comment.
> - Change from & to && for EXCP_IRQ or EXCP_FIQ.
> - Refator nmi mask in arm_excp_unmasked().
> - Also handle VNMI in arm_cpu_exec_interrupt() and arm_cpu_set_irq().
> - Rename virtual to Virtual.
> v3:
> - Not include CPU_INTERRUPT_NMI when FEAT_NMI not enabled
> - Add ARM_CPU_VNMI.
> - Refator nmi mask in arm_excp_unmasked().
> - Test SCTLR_ELx.NMI for ALLINT mask for NMI.
> ---
>   target/arm/cpu-qom.h   |  4 +-
>   target/arm/cpu.c       | 85 +++++++++++++++++++++++++++++++++++++++---
>   target/arm/cpu.h       |  4 ++
>   target/arm/helper.c    |  2 +
>   target/arm/internals.h |  9 +++++
>   5 files changed, 97 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

