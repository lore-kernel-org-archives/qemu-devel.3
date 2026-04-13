Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2582F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQs8-0008Uk-Ol; Mon, 13 Apr 2026 19:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQs6-0008Ua-F1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:39:14 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQs4-0008Lk-R6
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:39:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so4392611a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776123551; x=1776728351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E9cAXorbTLmeYg0+b+TAfzxI8ATRi7d7uXTITRVUKOw=;
 b=LIQbPs85yi3SB3h2hwi9LjPf7XQwb3wHpW6i+RnjtumJNCyfSL1FBEzTtRB7PiDb7i
 1oRADiMweeQrktJROBCbCJ4zylCSYcAmQqpmH0GRRfc2RXdZi37s5ZaDI2mrH/fjvlUy
 UkKBvq4pmBtqSrwU7WuXNSHkna5CDCJG2bx93E/R2M/CGt4qowbXxmQ0XESwk/JSSR0p
 fdQ5Wq1LgeGTa/52g/W4Qa9Ic/QemkAPdKyDzW4t8p4F+pClcWgHHkK+S5BZhyr0C/xI
 Lluhb1TH7XqVCyCQLGSvOtziSz91XFjGyRkzmVw6PqodSDweYVDeHaMi9aPTt9srPPs+
 /BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123551; x=1776728351;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E9cAXorbTLmeYg0+b+TAfzxI8ATRi7d7uXTITRVUKOw=;
 b=Q6FjdA8CRu3olzNHpaMyfH+xbK9LaNFxDVtgIOkifCBJzhnrjYABbtlZ3Db5w+ynWM
 VCrehx8Bb9QQQ5MV/pMe96RBs/GqDiRaSKaFY7s+j0Ye7aoGUScx3LW2mSaMOFEcKXxc
 NPHC5BvehourJVPUJUquwl6j5o/ZQsBvexNfzTo1i5H0+xI6S0TxpGGJt6KCbE/3qWHa
 W6eJZFxhqBJ0tdlnK8DBFMDxBuIqG3e+AbTxpXLPAny4LxJa4D3OAJ4cUgTfbYABsolC
 3fUmdw55+rkEZIscS1wfRFO16vLMKzl1HlNABxX6xlkL2sk4lGspNlishxnYSs6LxFUA
 ZAHg==
X-Gm-Message-State: AOJu0Yy1nOD5GMWuTXpHN3pnUHrVZ5UMIEax7EoAzXpRazF2YX7iprmr
 17EKvQn5k1y0nfnzvI1EILwmw7u3OBXj6l+ImCznsMV3FINOPX9ueHVRkshN9uVdb36cGXkCuC6
 nK9r/lV0=
X-Gm-Gg: AeBDiev1QQ2zxuvSnK7I3I24WVLhosm14OZADl6my90VOxppVabE72vAaeXVX0RseO9
 TWumXad3BrC0ZhhPvKFo586WgYGD95x2Xz9VeYifl0/j83IOTNV4dCfnwTPoKX02cYTXoNQjNjU
 AvmuhoP3biD274it4XIabtdGMsEtKXnPIDM7PxVLabT3sZBY7ZXm+T3bBkaA2vEQzmkxWMZnU3s
 uneJ4j5Zt7oZoTV/YTKfA72rm2GBLtiy6Mr2haLEjbWLQRypeGvnJhKGGH9146bwJPzGomQ11Sr
 LojVmSpAO1dYskGFh/+0bosXq3OZnOecwXVuOmfq73h58qekYD2R2HqurD2JdDmJquHZdmygRyO
 /fgZIWbVPpwXTC23JmYUOwgnBkjtBkVGK07wrUIp16KDENZq7GDMzystk6gogbASos3th/b31WQ
 VzH0+g0lYlz1kqB7zDYo7mv9XFEXvaxTnZHWL/wtfuyf4j0ZPXaFvK3CDdvHgqFJAiMeC64BmnR
 EwJhGPqgvvPog==
X-Received: by 2002:a17:903:5cd:b0:2b2:42f8:1a45 with SMTP id
 d9443c01a7336-2b2d5a8ebc5mr103521985ad.39.1776123550886; 
 Mon, 13 Apr 2026 16:39:10 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f0a39fsm124478165ad.48.2026.04.13.16.39.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:39:10 -0700 (PDT)
Message-ID: <30c82617-699f-4d26-a24b-0d231892a682@linaro.org>
Date: Tue, 14 Apr 2026 09:39:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/arm: Explode MO_TExx -> MO_TE | MO_xx
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/arm); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/m_helper.c   |  6 +--
>   target/arm/tcg/mve_helper.c | 79 ++++++++++++++++++++-----------------
>   2 files changed, 45 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

