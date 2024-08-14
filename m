Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED8C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 03:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se4Ns-000599-81; Tue, 13 Aug 2024 23:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se4Np-00057x-8S
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:09:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se4Nk-0006dw-SF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:09:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so5514569b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723604943; x=1724209743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KU6YiLda3Tgcl/m0KjBFLT+iqzm71eWqQibs2172rNM=;
 b=ZimyZB8w3QiXDjKqMF3pDgABR+uTvAB2wJT76pOrGNn8jT5QccOZbcyrrezDNfmvE1
 zvRl/HbMnwx5VI8++Gl2RXMtnnlpSZO6tS+4ssxKZ8QE2zJYW8ViXeaKAhEeGLAQn7Pi
 FeHINiflKU8eBSkRV2RcBIdYxXsXN14XL+PRzxE/zeOuGT9H+pqEAs+DVDWcbjiTjRq9
 QdEAq+J4lj9gXpuwZ3wJZnvdronFJuga/3gCieqM1IrNl0epkJBOLZHTJgmfn8Qa7bh/
 Jw6xBspuQcr7PARBDgEctZBPj0jCOZTrKNLw9/f/uRta4T5/0bUuTgbmW82LAEW0Bk3n
 8hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723604943; x=1724209743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KU6YiLda3Tgcl/m0KjBFLT+iqzm71eWqQibs2172rNM=;
 b=fHE3pYodHE+pUHaSVsFykuHcztC4OCgpROJa552rH4s2OMx/9BSafnIoveO+kS9vxi
 QvVHTgmHgJq2S/8HLib5/KnUk8XFSoVmqGZH/w6U7caC7AaSTRLn+RajjdjmWY6vPJ/8
 CmVYMSZqvHIHBfGWfbr1hk/tDzNqRaAqfk4KycJic4iqKPxIU5adsWBwCISkxJIRKSWm
 09jQ+/B4h+uvC9E1r1br8wI7vraFIaFsILLzrsdEPpfc2ChAxUKKLA7oPhGJsfeHJvYR
 mHJhIpX7AxsXvE60fV4PDBeS5ngNwyhoeevqTW7RBcYw9mbjsf82C95KTCIjUDQZyu7o
 eabQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPlx0UnVy3V6HPB9M34U7qJp6gZBrn3Wsu8uTzaXqgygEAP0Vynk7XGToMmHaGjPaTW/ZppTGqjq5FlsDRW4Q/5wH3pCM=
X-Gm-Message-State: AOJu0Yw3BuQbK2a0j893QFNcLVdC3aSYd3I/VhVZuP/Qs/dSI/9jNMBr
 VcKybEwwc/YPW4KX3XO2S+AvEW8idMJ2wXI7g7ZFbUDE8a+XM5/CMqwVSKQ3MNBOamRlETUt/uN
 UXcI=
X-Google-Smtp-Source: AGHT+IHbqsJyFYLcrCjwrKlZpseROrnPnPcUpSNXkwsaIovBMdS9uFEM07TwNsRyfBTUVp32VODX4g==
X-Received: by 2002:a05:6a20:6f9c:b0:1c3:b1b3:75cf with SMTP id
 adf61e73a8af0-1c8eae7c3femr2159824637.14.1723604942713; 
 Tue, 13 Aug 2024 20:09:02 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7f9e23sm369369a91.30.2024.08.13.20.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 20:09:02 -0700 (PDT)
Message-ID: <e4fe4bc8-6e00-4311-ba0d-14029b78f5e4@linaro.org>
Date: Wed, 14 Aug 2024 13:08:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] tcg: Fix register allocation constraints
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-4-zhiwei_liu@linux.alibaba.com>
 <2efe353a-4700-4632-b919-e43cb039c2c0@linaro.org>
 <1e61235e-1cb8-4bc1-9983-6e8dc0c3b406@linux.alibaba.com>
 <149df4e8-f51c-4925-8c65-e8e10fed85a3@linaro.org>
 <5f1f74de-3403-4371-97eb-f376e65b7ae5@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5f1f74de-3403-4371-97eb-f376e65b7ae5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/14/24 12:27, LIU Zhiwei wrote:
> 
> On 2024/8/14 10:04, Richard Henderson wrote:
>> On 8/14/24 10:58, LIU Zhiwei wrote:
>>> Thus if we want to use all registers of vectors, we have to add a dynamic constraint on 
>>> register allocation based on IR types.
>>
>> My comment vs patch 4 is that you can't do that, at least not without large changes to TCG.
>>
>> In addition, I said that the register pressure on vector regs is not high enough to 
>> justify such changes.  There is, so far, little benefit in having more than 4 or 5 
>> vector registers, much less 32.  Thus 7 (lmul 4, omitting v0) is sufficient.
> 
> At least on QEMU, SVE can support 2048 bit vector length with 'sve-default-vector- 
> length=256'.  Software optimized with SVE, such as X264 can benefit with long SVE length 
> in less dynamic A64 instructions.
> 
> We want to expose all host vector ability. Thus the largest TCG_TYPE_V256 is not enough, 
> as 128-bit RVV can give 8*128=1024 width operation. We have expand TCG_TYPE_V512/1024/2048 
> types(not in this patch set, but intend to upstream later).
> With large TCG_TYPE_V1024/2048, we get better performance on RISC-V board with much less 
> translated RISC-V vector instructions. We can give a more detailed experiment result if 
> needed.
> 
> However, we will only have 3 vector register when support TCG_TYPE_V1024.  And even less 
> for TCG_TYPE_V2048.  Current approach will give more vectors TCG_TYPE_V128 even with 
> support TCG_TYPE_V1024, which will relax some guest NEON register pressure.

Then you will have to teach TCG about one operand consuming and clobbering N hard 
registers, so that you get the spills and fills done correctly.

But you haven't done that in this patch set, so will currently generate incorrect code.

I think you should make longer vector operations a longer term project, and start with 
something simpler.


r~

