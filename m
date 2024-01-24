Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49736C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 00:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQpv-0007bm-1b; Tue, 23 Jan 2024 19:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQpt-0007be-5f
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:09:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQpr-0007mp-KI
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 19:09:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d70a986c4aso21890835ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706054981; x=1706659781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CiGgcsIOkZ/yTS/6mH9nvv6FROrkbPwN/TqluapyvGg=;
 b=e9EMXlZo1jGAQAO49kQqzEAYNn6d5bv9nbBgGORpY6o65WwBZwn3uf/t7Q6rLhvf0Z
 lgK7YB3T57ZUt9DBU34tRVl383pKZOuSxOetYUrbLs8W1Outs3FtkpngZQkSs1Z3I4ca
 Qxs1CmM8XdL5+xDakEWdQ3w7TQ8tJhOMjVsymirOEejbZRa56tWPOuFzs8dixTSS5bPj
 goNzZ01hg8CaNWJYOCCVg0i6zsJR/ltzCM7vbKZ4p6Qv1Lrmx+vGoaF9jbtVSDsy0Csb
 0sEJrR6YI0NVPuoILRZyn9H9dW24P6xypuwERburdcIx3n4WnOwTxVWXcIj/+sOZtjlT
 mhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706054981; x=1706659781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CiGgcsIOkZ/yTS/6mH9nvv6FROrkbPwN/TqluapyvGg=;
 b=DtMebiN0CcUN3KQYKsI13OClEzK+6Jc6h0OvzjzlKdYDOlVhjKkpGjkBZEIkWlhYYp
 mgqbYMUtHtQA12DB62b399vGbR4I18xFLVTj1gMdWTLe4shPC4jQqEPx0S8GBoJrVtSw
 LKtNUIv7uh73csTI2NwgK+Ul8nacu8kMFtQrXeUJvK1BANPZbovRy7dvWQYy0azszPFA
 LP0kPLMBGheTASZvVPQQcCLJYvTTBo1R6f42MtQdKV2VsGVWIWbWzPFem2/1qQNcqP+f
 8aWHM9CJ6Y5zbVBPsXI9qMS4cKHQMh+SwXDCJOTYwso29yKok4UKwYhJIwqInCs6DMIP
 Cy4Q==
X-Gm-Message-State: AOJu0YwiSvpZC2CSVxK8D6BIPP5xYqkHfhs82zxQVzsSV56vAbHk6ZC0
 aYafdF5t7Bydjyl4pchVuU14AcpA7MyHDkktu6MFltdzxpEOMRchCQ33Waj/Du8=
X-Google-Smtp-Source: AGHT+IFwX5K4nESfQS17YDcM8fHLpEYnFVTZAEPxCI7HtazGwPI0ri4gsQJLZEj+AnJaROsbw4uz+A==
X-Received: by 2002:a17:902:d2c4:b0:1d6:e986:615e with SMTP id
 n4-20020a170902d2c400b001d6e986615emr22747plc.28.1706054980742; 
 Tue, 23 Jan 2024 16:09:40 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902b78900b001d7207fa2a7sm7431742pls.152.2024.01.23.16.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 16:09:40 -0800 (PST)
Message-ID: <11d58624-3a8a-4550-88d5-eb7264369a00@linaro.org>
Date: Wed, 24 Jan 2024 10:09:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/34] exec: [CPUTLB] Move TLB_*/tlb_*() to common
 header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-16-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-16-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> TLB_* macros and tlb_*() functions are target independent, move to cpu-common.h.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-all.h    | 81 --------------------------------------
>   include/exec/cpu-common.h | 83 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 83 insertions(+), 81 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

