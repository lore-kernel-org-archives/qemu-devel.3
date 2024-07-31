Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFA5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 04:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ0yx-0001Vr-3A; Wed, 31 Jul 2024 00:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0yv-0001S4-46
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:30:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0yt-0002fQ-Bh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:30:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc6a017abdso33291905ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 21:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722400230; x=1723005030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Vgj52BVi6qVu96pEEIeLMUaHgITRS2jBEUGy0TdGOA=;
 b=RjhWaz4IcDwp3zgluDTNenZPYE0uMYXyebN5jdisvpJfNfvaOeOqmS/0EWWTC9lO9c
 mFZTVfzjgnKHr2roFYhMrkxg6gHiGGNZgzfel7eFcHQK5KCJ0fZi0dOq07Ro3SdYBT2R
 BmPJplvUhtagNzmVlYJtNIIsmj/LS1ns2OYO6zyInRFvDqF1VcFN11k7cedWw5XKzK/T
 OfHzmrjmbLhpUpTSU66ttnddui2i5FF2tsfGc+RWEFcvQ/844JoJnpQZ/oRtCSvwvoFO
 5oJzFun9rh0mL0tbzs7oZPFtqVr1Ky8oDngUFrQmhwIEQ9LSmFvbockptEBzNWn8QEFs
 tmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722400230; x=1723005030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vgj52BVi6qVu96pEEIeLMUaHgITRS2jBEUGy0TdGOA=;
 b=TxdmwQP2865U7DCa7glJrQFKdXBZnE8UEs8cDDKiaWrTI1v0w4tEBC4azOsZcXnuTg
 leue6KXNsExOymTOdq56I57BBNDamWWNJQXqGZFCv5aicdw2aVcIGo6psAiqntVrMGep
 rCnhpKubQbRd1G0JowVpP4zOrm2tpB2/atSp/V1rQcK9ejhrCOsfGocJWB9cMoD9ayXA
 jvSnJdqtrqNjfRk+axGGXcsalAr+s1wj/8ko/a+5W1Ls4vN954+LMnZlEuzSYXPoi4Gn
 C8efbpG8RZMleUN8FX/c18Q72xSd0H02yhngxm6kio4OvYpLwhUe4T+qQgScB2X+OyKP
 iPCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Ab3YElOR4bpVTynuXTX0EozNytmmGejZtfxYfTc1922mGnLqJ/+nzHn9c23t32hQ/hXCF9NdlRKtZZvsyWtTbr5FW3Q=
X-Gm-Message-State: AOJu0Yxz/PFotD6ERK+4d5KXSJ/rqRtrNbwXOOf4HiOxwVf7q8U8tQ0V
 FY2jGa9lQ16BFasQVtqPIzZEquNK3LqIJzI8MdNrZy2zuQf8umqR+4Y0BW1gArE=
X-Google-Smtp-Source: AGHT+IE3MUCFZyCPlZOGAQCZDuhPI9JaUaxgPbUpiHv4XgwqObm2nO08k2whc5/A4xaUFHCPHZ/nEQ==
X-Received: by 2002:a17:903:110c:b0:1fc:4f9b:6055 with SMTP id
 d9443c01a7336-1ff047de3f4mr128330505ad.1.1722400229653; 
 Tue, 30 Jul 2024 21:30:29 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cfe776sm110678525ad.92.2024.07.30.21.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 21:30:29 -0700 (PDT)
Message-ID: <1cc4744e-4002-46f4-949e-c81a465ee060@linaro.org>
Date: Wed, 31 Jul 2024 14:30:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 2/5] hw/sd/sdcard: Do not abort when reading DAT
 lines on invalid cmd state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
 <20240730092138.32443-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730092138.32443-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/24 19:21, Philippe Mathieu-Daudé wrote:
> Guest should not try to read the DAT lines from invalid
> command state. If it still insists to do so, return a
> dummy value.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: e2dec2eab0 ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
> Reported-by: Zheyu Ma<zheyuma97@gmail.com>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2454
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

