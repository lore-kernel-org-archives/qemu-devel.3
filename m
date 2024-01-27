Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A40C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 10:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTfeI-0003Cw-0J; Sat, 27 Jan 2024 05:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTfeG-0003Cn-KH
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 05:10:52 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTfeE-0002i5-PB
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 05:10:52 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso1198376a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706350249; x=1706955049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smAQyh5KeAyQpHUpTNuQBMSLoQsX9zU+kXG/fhq3u4M=;
 b=LAMIj6GAcPYOoBvLvRQOMdAzop2PftPI+WsiuTIaLnx2go23ao/TxFqGDQDairuTLx
 gwZOFEXrNo4lhfZt2sMyC6bVQxCJYca7dkkKktUaU/CqlhIhIB0WDyiGz5WuPmDDRZ8G
 a+Xs97+sOBuB/ldArx04G1QnbYPeg45DyfOF9kC4Pw2Ha3wt0EsjS4RnmXr01KxDr/09
 +aRD07JEvAvFrBjim14Z9EcpnY4DvC1z1aTJYPWHXCZRM9WB74+hj5ZJCma3ILxALfJL
 l9fXiLpnPGbOzU6jlcShOQ/y8xb7j9Ec2Wm8FZ11kjSX9R2cerJCYogpgJae53iOL4VL
 MX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706350249; x=1706955049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smAQyh5KeAyQpHUpTNuQBMSLoQsX9zU+kXG/fhq3u4M=;
 b=wGII/1t1kxkIQD6N8zjG3CuQipahuJ0JHtvJokd8Z6LJU9H+SOq89jz46l5kCCANjn
 Z0/pLHUSGcDeoWjiAj4ATpzy+EW5cP/4PoCOhPzFc49bTdRAEsKBo67KZSzZIHLch3AK
 ZUjxf3/05QMPBJ0vaebvSLdXZMsx+ZEkRHyMEj/EH+yol7xG+XaVPVqE3NKwd6xabQ0M
 BEHGNRSZhtme2a8qwa/+OqDgako+Gl5ujUFXUEJEcevfxtnqarhW+ZyheUMLgge4dUUD
 lEak2SHVB50XVCNkmoabXXWQxDFrnXauBVUvM7+/kcx6uB70UyFI246Q1eGm6m+c/6en
 0Taw==
X-Gm-Message-State: AOJu0YyQGKy6IW30ZXCUY6SUVEnOfWKXrMlhZymE4j7IFg95cLM5KKr6
 kIpwn/vASdvtyywz6cmeS+Ou9fLwaqoLvRF+osuEKyWeymdp7XuAmEqwmTYD9jiATVeqNWFUuO8
 PEYbzSA==
X-Google-Smtp-Source: AGHT+IEinWeB8f0hsMoG5Tr6HLORH4xBsgEXZmb22fTOUEg4L7X5mh6hcAF41J62Gk0SlGivLmyyaw==
X-Received: by 2002:a17:90a:de14:b0:290:e59c:aeb6 with SMTP id
 m20-20020a17090ade1400b00290e59caeb6mr981287pjv.74.1706350249041; 
 Sat, 27 Jan 2024 02:10:49 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a17090a938300b00290ae3bf8d7sm4565574pjo.21.2024.01.27.02.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 02:10:48 -0800 (PST)
Message-ID: <eca671a2-5331-459c-96a8-567339c3644f@linaro.org>
Date: Sat, 27 Jan 2024 20:10:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/34] target: Uninline cpu_mmu_index()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-13-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-13-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Uninlines the target-defined cpu_mmu_index() function by moving its
> definition to target/*/cpu.c.  This allows for compiling memory access
> functions in accel/tcg/cputlb.c without having to know target specifics.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---

Queued, thanks.

r~

