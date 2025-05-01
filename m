Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D015C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANTc-00082o-VB; Thu, 01 May 2025 02:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANTV-0007mU-Py
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:32:51 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANTT-0000eX-Ic
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:32:49 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30a452d3b38so152382a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081165; x=1746685965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACiySttJAK0f1/tsZzEWZpYXvD+u71k1Ex4TVh9oB3c=;
 b=xF0X1z56Dngnhwbv1AXnZ7kkjPjLs8RNgm19YVVZWoYFecCUpEjMvgcmg8Zm7Csqkp
 catFhFWiGyC2+de2bB7M1/diTGpjHlSUM4uPJlXRw3w9ltp654oevqxFOTPzb+1a7NKW
 RstZKtCNccfuaNDMNhF17F6EpBoQjm1D3YYl9QnwwfnOXMm3S0EG4ngx3CdrNVZPKm2+
 0cYuS51oXKgmJU/eKGYFcVoxxneYYAPoAa5bn0WYtW0oLLf/EaPRh5US9V+qHb/JGhkF
 +1UqAHo/cBkRvUUJI8O969WaOCLjwVdhEugUFVfSIjcOlsa1gvOKOB5MS18HNX6l2a+L
 DDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081165; x=1746685965;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ACiySttJAK0f1/tsZzEWZpYXvD+u71k1Ex4TVh9oB3c=;
 b=hyXVCqXC+2EBA0g8Bt61ym+Z5vtgs1G/RNBCsHzSlfJFG8D1xgACfjW4xwVmZanxri
 S5b22rasWDV7D8IQgsGQX9FqtW19zpFZ65wckEC7c/nehVKDKHk0s/rP/p7vvRCK5ZVV
 NOB8kExL1FoIGBlA0vXp6ROXbHY5i6XsWks/wovL6pRO0vTM94WqZKLGSGeHKjrhq2Fz
 oLXd0vT9SLvHWcY6aao8XOsw1h/O5YHVzOyB8KlZn7onprFWLvJ+/sPmEY50SyTVQu57
 ARTrBsQVsQf0DfaYnSqylf30anrhXG4c3JJIQTJib9ClegMQISX0iTpfHp+3lw/LbOa2
 U2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLTAGSQA/wq3uLbPclTTsHoQ/+b5gMq+SUu7oqZaBQ16cAkxScy6agn0MBOuJc/7qJkFM3Xx0+8x7m@nongnu.org
X-Gm-Message-State: AOJu0Yxfq+CUuj1LXsSDgXR91uoIlo9J4Kr3FEm4IrWmMFlwlMvOucSq
 1DM2syhn+dtcE+BGgfZCON1dXBDGJaqPwDgWc86KBvLj4hf2gNiGtdkPf1Lt+aUETMc9dinpjup
 h
X-Gm-Gg: ASbGncvTAJkadTLNRKHHzLZ+PSeIAwG7UdQkfuTAnvP83pX/UDoBYi3E83DgDaz+Zzo
 gZo7rkk8RgxO+Fu3Zqwiv0aQVcYgL/b43J62IclioWW8kC7v5AHyWK84oiOwedK3AM9ievMl3Wr
 7afY0upEqFOHwDOfLVLDD03fYxWPFOD155yEpcksv4EAD1Cjpb+OOc6Cle1OExbR1lafNbNH29Q
 YXh3+60Ihq7rOfesEhdad2PeXuhklyiXYQZ/CBQtDVIRljiWkaT/C+IGGCgdGFUmcoUaeCtdRXp
 pmXoNFjF6oHMeLOgiuY8YbmUlmINGjBaR291Sfi7Zr4tFY71joBS2A==
X-Google-Smtp-Source: AGHT+IGiC4QJwfg6wmZrkS8BtUeAYj/3RI6B1+Vcm4y7AjHm0rXJAVIn2ilLZIOTLS/EeiFq6wv9Rg==
X-Received: by 2002:a17:90b:57ef:b0:305:5f25:fcf8 with SMTP id
 98e67ed59e1d1-30a4318152emr1946757a91.5.1746081165335; 
 Wed, 30 Apr 2025 23:32:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4764219fsm77456a91.42.2025.04.30.23.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:32:44 -0700 (PDT)
Message-ID: <1efca05c-2c9d-4bb9-9868-a7aca6b6d9ac@linaro.org>
Date: Wed, 30 Apr 2025 23:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] accel/tcg: Build translate-all.c twice
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430230631.2571291-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> Remove lots and lots of unused headers.
>

That was a loooot indeed.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 32 --------------------------------
>   accel/tcg/meson.build     |  2 +-
>   2 files changed, 1 insertion(+), 33 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


