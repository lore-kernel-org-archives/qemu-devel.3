Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E228C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 21:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raj0k-0007BZ-DB; Thu, 15 Feb 2024 16:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raj0e-00079B-33
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:11:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raj0a-0007oQ-Cj
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:11:07 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so10043185ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708031462; x=1708636262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JYmpcyqCqUnt2TBHINI9CdgpeAWXDAQR91/RjVgwq5c=;
 b=KZKkoaALaFmvF1YOMlX7fqti6tWXQxi6Gajmu/PW51thvyeBkBepABMr65SAvZ0AKD
 VZyI9KrCYJqMDkNyFe6o+TlYN5v5Gg0W4M01uF9wD8PZVjQv53REGQ7NC003SXDAgvy/
 cz3e/Si3LuTXl/EUnVsJAJKdLsFekLE135uKZtPfqmaGpWLlzwW//3gKilzX74hIxTrF
 TVkHQUsATDdT1yPG2JITviavubSrP8cpcjnoUr7RwlWykuiS/Fhxt+bW3A9KXlSNQzto
 BtjtfV8EiNHvIzjnF62YcFBZ1wuxtSp4nia6NPypR5jGK3UgLybizXrx/ul5KjV7zHHf
 PyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708031462; x=1708636262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYmpcyqCqUnt2TBHINI9CdgpeAWXDAQR91/RjVgwq5c=;
 b=LdwLrHQTxblGPuQQ1tuOrfL/xnrTg9chj5nrlRmRhMYU3j73ByROO+G4zQ9pSh2QuW
 hRhZbf38MsCCgo3jO7CayrZSmA3MYQDwnBamNz/dNDXZx7WbCun7BkbeLEc6vnOG6o1D
 9wogKymJ9r9/F1ggLT3qwfoFqIyPqdm8iDJyOgkTjkHe13RivgZ6PTZlLkFRmPUJhhy0
 vZPuTQr+JatZqqw9iWDBjov8bbosJBOllsLqmR05lugHPuizUe36NTocP8IWzUvdKGQi
 mt5h7NeLdiNGwVN+LvrjnJVzAoDyBxjMPCioe1Vx2HzrJPwN4N+Lk2zjCFMKVC1vQhDv
 HIrw==
X-Gm-Message-State: AOJu0Yyqi6dk78bGsEm/2DYnQOmr87EI/9IHnzK1/4wLtaDGnQALkLp5
 lx/4YiKy8IIe8EXz2o5dOe9twsfARqqdtkX8RRnHlWL+85JL/ZW90vH4fNm8qbWsT9tm0eREN7F
 i
X-Google-Smtp-Source: AGHT+IEXqHnqqHg78VZmepJF61ouiUJEadvbSjKDPq7CRjylhfkugHzpuQwiTzbbtDt45k4W+I1Pjg==
X-Received: by 2002:a17:902:d48e:b0:1da:1ea9:9a41 with SMTP id
 c14-20020a170902d48e00b001da1ea99a41mr4735957plg.12.1708031462571; 
 Thu, 15 Feb 2024 13:11:02 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902c10600b001db2b8b2da7sm1683441pli.122.2024.02.15.13.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 13:11:02 -0800 (PST)
Message-ID: <5e15fe47-94ce-4d25-a517-d766e70ac853@linaro.org>
Date: Thu, 15 Feb 2024 11:10:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-10-richard.henderson@linaro.org>
 <1f038576-5121-e84c-8196-ae5f9ca3a75b@ispras.ru>
 <6499be56-2002-44b3-9c53-1a1ec2fde53f@linaro.org>
 <1e4d5081-d86b-84f5-20f7-8e48044b751a@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1e4d5081-d86b-84f5-20f7-8e48044b751a@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/15/24 08:46, Alexander Monakov wrote:
> Right, so we can pick the cheapest reduction method, and if I'm reading
> Neoverse-N1 SOG right, SHRN is marginally cheaper than ADDV (latency 2
> instead of 3), and it should be generally preferable on other cores, no?

Fair.

> For that matter, cannot UQXTN (unsigned saturating extract narrow) be
> used in place of CMEQ+ADDV here?

Interesting.  I hadn't thought about using saturation to preserve non-zeroness like that.

Using 1 4-cycle insn instead of 2 2-cycle insns is interesting as well.  I suppose, since 
it's at the end of the dependency chain, the fact that it is restricted to the V1 pipe 
matters not at all.


r~

