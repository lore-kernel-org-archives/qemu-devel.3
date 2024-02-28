Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA7BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQpN-0001Fr-8w; Wed, 28 Feb 2024 15:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQpL-0001FV-UO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:46:55 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQpH-0006FJ-7V
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:46:55 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so120570a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709153210; x=1709758010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TPxX/CUHl7rtq5FN36qC1/v31dE3yPDzQam09K7oiq4=;
 b=s4KMfwg0zmjsdmY/Uw/qVvRG9vcnEqGh9ltkqPIYPoCzGh87AL+q6EZgPSBmWqPmN/
 +EbAn3Fy9L+OK3b8JkJIbi5xSDxbNpuqclaImJPHAvXTvVN+r17tlYJOasvrw7Ms+Jdy
 s9VKpX7JEjZ3rnF7hhh5ZBXYOq4bUW6ehkDk9naUZdOQS/kOMAFx2P6Po5Kz9wbXRA8Y
 u/kKQQQ+poVbvVe/Y+Q8fHgqLp21LqI1slfnzO9A0/6tQMeRLlBosUv0uBmSTN74ggd+
 M3DFYJ5TAzdCZ6fJeaOpSsGaTAwStuIvR/Z2uDVRx2iQtH3E5NDuDWgPtWYXBaOqXL3A
 JRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709153210; x=1709758010;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPxX/CUHl7rtq5FN36qC1/v31dE3yPDzQam09K7oiq4=;
 b=PUCNjezuXwouuPb0hArxIZqtx0uhfb2uEm7lvb62DA48MGsGiJKMNDRBUoPAXlgNvv
 C7kkiflyuxmMXjf3XBK1MRNK4oADFBu0oBtJmI33wGXeTTBEbV8Ieoej40K8MmDnI+f7
 B8bjNaBAP32QXzjDKAIpsbN9fPn+afTFmHYNZrp20ZrlystPtRzvK4KhO3zUjKWYrB0m
 bViiC3j2tzsNZtHDjyl4rUWQ7u517PRu/fyLdfosDf3gbgmqZ6iz2dZs4gHPdwDJWL+1
 vPRymos97hhFgmI2/Tj5B8bqhEnxw1lopYzOud1RO70LTlGPn/IZvsjjxPX748kxYYt9
 acIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhdjR7+Qg0Xvv9qmoDEYxrwwtXNAbiGTlUS3y2RmdJiTV2GWqfKHDUOEsxhQB6LTvJ5gRv66gZmX5FO0VpPNCoxQVjkBQ=
X-Gm-Message-State: AOJu0YwVYtK014PK2hG3BcCzdwkkDd4merTNT6AXSrQw69XPlumnzu0L
 F3uqgrocotAO7MxAzbROKFC5qslKmh0TKkSA18/8QWNDcCOTxfCyCG8mQTABttE=
X-Google-Smtp-Source: AGHT+IE4Wph5kFVjho2hWKEJuRWD4AXAfcXTuJKgT4+inNFwOo1IqLwFbReFWTYz4nAV+i1StrFTag==
X-Received: by 2002:a17:90a:d184:b0:29a:be15:9c90 with SMTP id
 fu4-20020a17090ad18400b0029abe159c90mr316304pjb.34.1709153209786; 
 Wed, 28 Feb 2024 12:46:49 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 st3-20020a17090b1fc300b00299ef19177dsm2168045pjb.8.2024.02.28.12.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 12:46:49 -0800 (PST)
Message-ID: <e8af9c95-0d63-4c2e-82ed-f129ba79774e@linaro.org>
Date: Wed, 28 Feb 2024 10:46:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 05/22] target/arm: Support MSR access to ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
 <20240228092946.1768728-6-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228092946.1768728-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 2/27/24 23:29, Jinjie Ruan via wrote:
> Support ALLINT msr access as follow:
> 	mrs <xt>, ALLINT	// read allint
> 	msr ALLINT, <xt>	// write allint with imm
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v4:
> - Remove arm_is_el2_enabled() check in allint_check().
> - Change to env->pstate instead of env->allint.
> v3:
> - Remove EL0 check in aa64_allint_access() which alreay checks in .access
>    PL1_RW.
> - Use arm_hcrx_el2_eff() in aa64_allint_access() instead of env->cp15.hcrx_el2.
> - Make ALLINT msr access function controlled by aa64_nmi.
> ---
>   target/arm/helper.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

