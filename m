Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C10C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKT6-0000T6-Ez; Thu, 07 Mar 2024 15:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKT4-0000SM-2G
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:35:54 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKT2-0000gk-FF
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:35:53 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso1072686a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709843750; x=1710448550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B1xRIk5BydSMw4y65RbXpbzjW1PRxD7HM3lQohgOcU0=;
 b=qew+g29N9MSobwlzmVcYxgtZGvTX5ReR+kQ1mFvwb0LBmWM+etYf3HcrPvZfVW3VNz
 91C2RDN8Y3f7W6U85yV66f/Mmd0tJ02rEWGUEtIC5NNlR/Ojm/bRsxPBZ2USd7knkidN
 mpuYLNsQF3QVnBmLluxYmF3vyqHu2i7L3a+UXxC+6Sd+GUuh2Io2dISMfTpjoMFmKpKD
 efnoctB4M5RR8V54uM+7mM17DlTqsmC6dqu07x5/YczAjxkFcgVYDIPo6sn+4kuHSBh5
 bKqIaJuVL0feR45wHghr7uYgZv11JX+is0vETwBr5asc70NcAgEPenG2UXWrQJSMHgMN
 EV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709843750; x=1710448550;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B1xRIk5BydSMw4y65RbXpbzjW1PRxD7HM3lQohgOcU0=;
 b=PHzXmPeUKR4bkmmNgujJ1Sq9KZIW6yk7+Epu1i7B4ts66FcxIlE8L34XrqF2Ad5ZkD
 KlkRLtnEFSfgLzHbcEQBniHHnISqkDGVeZIIEa4xzhNSdKYkjgLBaCfsxe/yda0VFxS6
 RIOZilyp8YqI8b79kuYyMjnv2IcvjM1Pt1iuSnAaavMz5ueTLfhP8zXL229Fb4gn1Fnb
 2y08/XJcVYEICUNyQqorJcinLNoK/InzTtw7qqxgU2UmW/vJkemy47ta+URb5HAM62di
 MB9EWccE1/rgJmvNvnxflykzfGkCEgAS47Y4FRbWHX5YUXmB4NRDxgqpXDmb+6rIpUfT
 vyHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqvGDzpzrSFoCRm/eeLs1pReJGROGPjVnbwPcd94HBtpQ2kjD0hfXEHN6Jo8zhemAOfDr/8vVjquL+uGuI1z1BrAS5NWE=
X-Gm-Message-State: AOJu0Yywc+soe+vC1uWRAJfNa2BOMgi9hPWdKVMh9TMYueIjqzABXrqI
 ePu3xxi0gAmnrcNTLaaoHR4KIKYeVo5TSEd3dUBM1gqOrLcw2Z+e5jYAvyeWwp4=
X-Google-Smtp-Source: AGHT+IHXXU/2zQeGTFdYoYccSityFE3rJlB+WHObz6mlX5chl7PF2RTJmYaFnLCamqDZsocsWX/yoQ==
X-Received: by 2002:a17:902:6809:b0:1dd:5556:9543 with SMTP id
 h9-20020a170902680900b001dd55569543mr2350972plk.30.1709843750396; 
 Thu, 07 Mar 2024 12:35:50 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170903230300b001db7d3276fbsm15006824plh.27.2024.03.07.12.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:35:50 -0800 (PST)
Message-ID: <dc9f673a-3f5a-4703-b171-b8599bdec22e@linaro.org>
Date: Thu, 7 Mar 2024 10:35:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
 <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
 <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
In-Reply-To: <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

>>> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
>>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>>> -                decoders[i].decode_func(ctx, opcode32)) {
>>> +        for (size_t i = 0; i < decoder_table_size; ++i) {
>>> +            if (ctx->decoder[i](ctx, opcode32)) {
>>>                   return;

By the way, you're adding layers of pointer chasing, so I suspect you'll find all of this 
is a wash or worse, performance-wise.

Indeed, since some of the predicates are trivial, going the other way might help: allow 
everything to be inlined:

     if (decode_insn32(...)) {
         return;
     }
     if (has_xthead_p(...) && decode_xthead(...)) {
         return;
     }
     ...

Even if there are 10 entries here, so what?  All of the code has to be compiled into QEMU. 
  You're not going to somehow add truly dynamic code that you've loaded from a module.

You could perhaps streamline predicates such as has_xthead_p to not test 11 variables by 
adding an artificial "ext_xthead_any" configuration entry that is the sum of all of those.


r~

