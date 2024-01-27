Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02159C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaKP-00041G-Jn; Fri, 26 Jan 2024 23:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaKN-00040v-Rv
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:29:59 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaKM-00066l-CS
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:29:59 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783045e88a6so119532185a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329797; x=1706934597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbLptFGPqxACsHOGtPreDNvMr4whZ+p/UCgJdnz3PpU=;
 b=QKCHZhp3AKyZRXMvnoZtyoy/u6TNMH1GPZPulEB7X/SSqXSTugV7cejbAlYwsLDcaj
 Q6VZo36eg+CakUl+yDgxV73ZaIQvWbD6HRopMCodSDnah7CV2ZpfL5T8a9dB1HOosQA1
 4ywDBLtnIAb7HaQTpwVdd7O6j9eOU8g1HwmmU+9fmTybR+yIAAnPIEbHzjTWwDhC+cxI
 NQcrJfWHsLo7xUKaLvcxE8EtG5P4NDKC4pdWaRat3b0/4ZkcOCHYg0I5mqUSeHnOvMD/
 NsKxJ7ZJ89DPu6KuOl1Yr8LAzpwcTLt/274A1mZ+Kxbzf8VMHypcEdyz2kuv62yMY48E
 uKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329797; x=1706934597;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbLptFGPqxACsHOGtPreDNvMr4whZ+p/UCgJdnz3PpU=;
 b=RV8BP67jk3cqIsTLv7BiQ4gXpsMSe7knb6fPZPZ33kel1VY/hbmoEhB4CJVEGh2rhq
 ST8of0RJL+vWX/HtsWyKFCxLt1GoU4al26vxUscy2zBH2GZEm6x3+wGYVA8//m5rBjYC
 NmHLKW/JvpRTx5R3wHomx7srfVrqMYy9Ua7cQzpQ3gPTrL+5XkXtysQroHilJCYEe5TT
 DR9bGDkOoiGP0Mk9n5nLlTfYo0Tki0zeMae20kibp/z1CxH2vJY6QQQzxrR1sqS14W7K
 +WyhEyW0ILbnjXwDwSLUO8VtUFpVxY9dJcq1x4VzkEsXKFXeVVLXBEl3v7ShEToGqn7S
 xVMw==
X-Gm-Message-State: AOJu0YyP3CsreiaRaFmsjC087YUcszwzKmRFEeZ9LaPBhh/7XCjd8p2Z
 ABRGN3D0fomgQqomDQE5xdai0C1hVkHaHA+mFc4iTxy8LLUY/Ahz5nqbd/8GKowa5APkNvz7wCU
 6XjA=
X-Google-Smtp-Source: AGHT+IEdq2itzfB672c7ftdkSh1vyqDHcLpAS5QMpaab+qcal/9j0jEh3LNaaAT8/gRDRsk+HChaog==
X-Received: by 2002:a05:620a:909:b0:783:e065:d434 with SMTP id
 v9-20020a05620a090900b00783e065d434mr958602qkv.29.1706329796990; 
 Fri, 26 Jan 2024 20:29:56 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:29:56 -0800 (PST)
Message-ID: <09dddcb6-a273-4e64-b1a7-31976b92a075@linaro.org>
Date: Sat, 27 Jan 2024 14:29:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/23] target/i386/hvf: Use CPUState typedef
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> QEMU coding style recommend using structure typedefs:
> https://www.qemu.org/docs/master/devel/style.html#typedefs
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/hvf/x86.h       | 26 +++++++++++++-------------
>   target/i386/hvf/x86_descr.h | 14 +++++++-------
>   target/i386/hvf/x86_emu.h   |  4 ++--
>   target/i386/hvf/x86_mmu.h   |  6 +++---
>   target/i386/hvf/x86.c       | 26 +++++++++++++-------------
>   target/i386/hvf/x86_descr.c |  8 ++++----
>   target/i386/hvf/x86_mmu.c   | 14 +++++++-------
>   7 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

