Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949D5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 04:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se5TO-0006Dn-Tx; Wed, 14 Aug 2024 00:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se5TN-0006Cp-Qb
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 00:18:57 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se5TM-0008Jd-8W
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 00:18:57 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-260e12aac26so3703062fac.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 21:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723609135; x=1724213935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0jwA7wHQJ9pJYC15nv0PwhDXiXWxo0hz4/8ccyt612s=;
 b=o+7fOvapJYSNgQe7yae5vRiHGqPpLML/wnWNZFrP1zRpztTOVcT97A3TUmP/MovKwE
 No8sV4FlDpq6wh4crZbRsJ4Q3OqLTugYg0/Yx5RQoMvn9jGmsc3jBRsjSb7LwQBlVKRq
 YCLXWODeR8N1heJ+pinqbep/hqug2ZisXBOfKWYdwI1GZWkwXDZYm+5qPPlZumg4oazt
 GoDtsFWDcdLv/crTJfg4M7gCYeQTwdvfrqcsQMwETA8BpWk46k7VWcjyN6Zyw5nOl8kD
 rsQGjXZ4SJRetNHsuotW3OIrsCGU70noBZoRZxroOvLWXEij1NrYmzc0XPDGItGb7z7I
 XsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723609135; x=1724213935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jwA7wHQJ9pJYC15nv0PwhDXiXWxo0hz4/8ccyt612s=;
 b=MXV1n7smR5H68wxGoN7ZwMcHveSNfdOBKEspouackjIyMPa6JxMDG7f/BKzHMq94SZ
 VFlU1YPak5m7A26klyKy5gbmp48VF3+EE1PqFSamhLeBzWPzFuxU411vrA3xt00rwF6I
 XKR5HqZ0DYm1Re46wSWXSZz1o02GRN+TGWLG/MtJHMD/4FnbUEZLc2R9dFlA9SETEhOQ
 9gOL5LMoaTJe7dOF+YpYA99/FfOU03ErRES/6e5xXhz7EXkFGhcNa3m7QJA67GsUDEq5
 ClwS5SBuwS34JkDjJWTb/fWTs5CZ/rZBvQTBIlDET35ThLhhy1oSx0Amdot+sDTEbg+V
 0MKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxYTFx5TeeH8qntJ/q2frCIFcjQ9sP0rjG9etM9Fj6JVfBowjdI7aLVFnzTVIXe8mrEe4zmJSyMV2ouXBLRcEDxyc51MM=
X-Gm-Message-State: AOJu0YxflSOKtkdKGezrxAXf8/lBTh6AJpGWqetgG92vOalTleWluQMV
 DbgJ0kVg3e32JoDf+dSe7YTj+LA6c2m+z9kqa3u+jCjLezk9B1UsSU23gAsWKds=
X-Google-Smtp-Source: AGHT+IE9qaIB40FUfKysmpY4ZmTQEasGCqQgdDyJKFVwBL7bC5eZbG1HljRDyNngKiFaAelYGQIkGg==
X-Received: by 2002:a05:6870:709b:b0:25e:29e7:14c8 with SMTP id
 586e51a60fabf-26fe5c7ad48mr1837200fac.42.1723609134677; 
 Tue, 13 Aug 2024 21:18:54 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43ccdsm6485325b3a.138.2024.08.13.21.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 21:18:54 -0700 (PDT)
Message-ID: <447a4be7-ffb7-4409-8703-a29e14bb7352@linaro.org>
Date: Wed, 14 Aug 2024 14:18:47 +1000
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
 <e4fe4bc8-6e00-4311-ba0d-14029b78f5e4@linaro.org>
 <05df4315-b212-4d57-ac45-37a3034f73d2@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <05df4315-b212-4d57-ac45-37a3034f73d2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 8/14/24 13:30, LIU Zhiwei wrote:
> 
> On 2024/8/14 11:08, Richard Henderson wrote:
>> On 8/14/24 12:27, LIU Zhiwei wrote:
>>>
>>> On 2024/8/14 10:04, Richard Henderson wrote:
>>>> On 8/14/24 10:58, LIU Zhiwei wrote:
>>>>> Thus if we want to use all registers of vectors, we have to add a dynamic constraint 
>>>>> on register allocation based on IR types.
>>>>
>>>> My comment vs patch 4 is that you can't do that, at least not without large changes to 
>>>> TCG.
>>>>
>>>> In addition, I said that the register pressure on vector regs is not high enough to 
>>>> justify such changes.  There is, so far, little benefit in having more than 4 or 5 
>>>> vector registers, much less 32. Thus 7 (lmul 4, omitting v0) is sufficient.
>>>
>>> At least on QEMU, SVE can support 2048 bit vector length with 'sve-default-vector- 
>>> length=256'.  Software optimized with SVE, such as X264 can benefit with long SVE 
>>> length in less dynamic A64 instructions.
>>>
>>> We want to expose all host vector ability. Thus the largest TCG_TYPE_V256 is not 
>>> enough, as 128-bit RVV can give 8*128=1024 width operation. We have expand 
>>> TCG_TYPE_V512/1024/2048 types(not in this patch set, but intend to upstream later).
>>> With large TCG_TYPE_V1024/2048, we get better performance on RISC-V board with much 
>>> less translated RISC-V vector instructions. We can give a more detailed experiment 
>>> result if needed.
>>>
>>> However, we will only have 3 vector register when support TCG_TYPE_V1024.  And even 
>>> less for TCG_TYPE_V2048.  Current approach will give more vectors TCG_TYPE_V128 even 
>>> with support TCG_TYPE_V1024, which will relax some guest NEON register pressure.
>>
>> Then you will have to teach TCG about one operand consuming and clobbering N hard 
>> registers, so that you get the spills and fills done correctly.
> I think we have done this in patch 6.

No, you have not.

There are no modifications to tcg_reg_alloc, and there are no additional calls to 
tcg_reg_free, which is where spills are generated. There would also need to be changes on 
the fill side, temp_load.


>> I think you should make longer vector operations a longer term project, 
> 
> Does longer vector operations implementation deserves to upstream? We can contribute it 
> sooner as it is ready.

Sure.


r~

