Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A7E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwfh-0004Ck-SN; Thu, 26 Dec 2024 17:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwfe-00047W-Kv
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:49:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwfZ-0004q4-6o
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:49:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso43772675e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253367; x=1735858167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9ShI2YHF42ob5+9ZOaTMqjyPvB2mBMZNGLhlpNYVHI=;
 b=PTXc1+I5noBkgDCkVjxW85AkJIpuZWOs5cRBwPtRGD/y4vEXgH+ZQ7f6kLObJbpZjU
 L6y3B8tTjFgbc0S7AzfvHBy4Ytvwq/20LnjowrzA2QUQHloLuv5/mhO2LYhjyqxxt+Cc
 Hbq5n4A9UHUnppIPv5xqDJ1q4uprts+yJo4xyycUXZ3uM5Z8xa+F4rcJ/Yhu46dwHbL6
 qe8iquHdDKwpboT4Ggcjh/+Sj4/+z3mq/tPkFfsTXUX/ri3TY4thzbzV0zWJDE3vI/Rl
 vW1Aiz5wwp90CcDrhVIN+anvehYdywqR0ZdqghELDU3hvoDddAlFEf/7zYzDXlYs7VPv
 WSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253367; x=1735858167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9ShI2YHF42ob5+9ZOaTMqjyPvB2mBMZNGLhlpNYVHI=;
 b=QVvbx33hWEZ2i0uX/EjHyRdp5rV31jh4aPnIv1xFdlyuZIBm3q4BtAgnhnLxzOvUh1
 6qBTwgEMp/9Ptcal2tEDsw9cTgbnzA8+XwIy8nOE3pl1E45YFmAZjfNeG4QT0/5An4kF
 IipgWjYcJhLf2wSr+60MrJi2C00S0fEZfAb6uc2OFGgLKVXhBO4EJPaIJdjeuTzRiEk9
 UXFYgK/QQ+7VDuWOuBPjXkzheuYGmpAt4/aPcIkChl13ND6s4yVmtCC8Kb4vU75ESUVE
 oVwu+Ph+L42hPqJMsieqXiTEph8zyyuDdJDTvCFXX5Ew+BwZ/xHn8Fe7YxYfqhqPKwkJ
 9U8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPwbk5Dd5GG9HyemyVVdfcOrNsrB68bP8XGwZeS8cVa/K9/Izr7hglZoXPiVpEj3S8ki4T5kRc37Fs@nongnu.org
X-Gm-Message-State: AOJu0YyT8WuWnE+x1jE2RdL0JPoUCY0pbzYnnQfxrZ51daVYfj7f3vHV
 SqBNIfGdyTXkw77IBYIC5+VBvZCnAXQ9G6FeRzcqsQrJfsax++3O4rxQVxk5T/J1wALMqzoUREG
 QF5M=
X-Gm-Gg: ASbGnctK13kamDlX5Wzhxwi5PIo8e///JbwCFTNsc8xnCyhn6CSKjoNKDmj6SAAUEnN
 SZA0c5wJoR/xKvEiLckbcyfN17xcpoAeMP3Ggts0MdFZaYQ65/QBrNsVUy3BeBaW+1mCfMmknde
 VfpXUrQIObkBSxhuWNvFkxeO4kuxBJFO4MTQLhLG+4WHvDOKJXco8xWnT8P83L938LttNXJ1dwz
 9PVfa55tKGpj50aapE7oqoVc1IFrCQNbXlUcrN8zD7M6r/sVnQwTa7AHWNryShzFdhyDZPBMCcj
 LjTZccwj6Jl9pFq+wPGwzQ==
X-Google-Smtp-Source: AGHT+IHsb4OuQKpgzawbCUM6jx2INolhKQWzvsghk9oT+LvNtYcLbFxIKX7gMgfJpAfJufPBE0Lo/w==
X-Received: by 2002:a05:600c:3ba1:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-436685488bfmr216679635e9.3.1735253367510; 
 Thu, 26 Dec 2024 14:49:27 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013ecsm280100365e9.16.2024.12.26.14.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:49:27 -0800 (PST)
Message-ID: <d24de12e-f4ae-481c-8eb0-16aff4780ab4@linaro.org>
Date: Thu, 26 Dec 2024 23:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/23] target/loongarch: Fix some modifiers for log
 formatting
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-8-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-8-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> target_ulong -> TARGET_FMT_ld
> vaddr -> VADDR_PRIx
> uint32_t -> PRIx32
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
>   target/loongarch/tcg/tlb_helper.c                  | 2 +-
>   target/loongarch/tcg/translate.c                   | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


