Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F41AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3jI-0007zB-Dw; Mon, 22 Jul 2024 20:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3jG-0007yg-Pu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:50:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3jE-0005zF-4d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:50:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso592365ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721695804; x=1722300604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Tm2iu+teRUVcESrcxiZgJIagKWYNSm7UF9/YY/CUlQ=;
 b=h0B/kBglN1w7FrUcwKGCIQkbBAkj+Ei7zIOu6q5ENhcYLI9ZGjQLrzcqBKDwZAB3Ne
 jXn06ZRPs3Pkl1iQvIAwSb+qDIEcsYgUSvHNp6puqLLO4nnon7wyMImTPy6b9Z1kaIKf
 bYfazgcjHe7uGksXCgVCSRCUNwG5DoBf4D1XxIiw3+vgJvgEXQOPfmrA2f5OLWi3CQfe
 unNogfrpOcaoigb1ZIDPS4AerdqTJVATqxxALf/G1KvdKz44uCWkT0f5aTY1J+/iI3jl
 US7mqxO8ADCTMJi0lObALtWwc/8FGfOVvIgN3L1owi4Tk5iFH+yPDWMv+MtU6pNEcIlv
 W2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721695804; x=1722300604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Tm2iu+teRUVcESrcxiZgJIagKWYNSm7UF9/YY/CUlQ=;
 b=tiL9vxep9wB03jpVXmAC4kStFpoX1Rg3OImXN8ipdefawcQm7nUTvuGxlKbU3/IrE0
 FherLoxA01b4Ojp8/v5PUhNdiZe+OJatY5nZfpSzAWofF1mocNJJb5bol4mhvq1ula+K
 ei28b8E4Gj/E3hXUK/AIl5ac9zJqb9vfucKAW9SIdwJO/Dm5NlbIH6CjyMQaK5nnEByE
 QF2YPRSYdbFlkOpkFvTEH1/DkCVEo1S+XWHiJ+LbFt9oM5n47QtqAl1HFWCkozAieyZN
 V8jrnL75exRmXKCEw25n7xZgNB7YK0Lb8MQIaOrlfq8oo6+trx+LGnFdppt0zxqAcQkO
 YC2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGr93b5yPxlpoK+oQxfcEjZP8ALXZ4ZJzQLS9+FR8Z3F+ebs27pTbnJJSg9om+4yB6Hau4ZZ0WKQZLfSGjzTBQidHBi0=
X-Gm-Message-State: AOJu0YwiCZ2Sbvp9CfL7dlE2f5sTFEKv/nSbi/SmsiFpWVOTnn0BHXHZ
 Qb1+vsic+0J9fJu2F3HLkPD/xfti3SzLRITfsM/rxEG+GBuYw1cpNmIGbhiWXSg=
X-Google-Smtp-Source: AGHT+IHthahbzJfgbd+j06E0jiFljpmnp0WIe2Afx0Eput9aLvb3lIR8D3iCIWKLOV2kDPsSPLKyiQ==
X-Received: by 2002:a17:903:228f:b0:1fb:98db:ad5f with SMTP id
 d9443c01a7336-1fd745339b1mr93125285ad.5.1721695803592; 
 Mon, 22 Jul 2024 17:50:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f3181ffsm61735115ad.155.2024.07.22.17.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 17:50:03 -0700 (PDT)
Message-ID: <abef9f20-b5be-44ca-8bd6-a1184ac53b25@linaro.org>
Date: Tue, 23 Jul 2024 10:49:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Alistair Francis <alistair23@gmail.com>,
 Atish Kumar Patra <atishp@rivosinc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
 <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
 <CAKmqyKM_gcuNvR=2Rff29C5EAFTNiyz3XNTH5H4wt9W5JbmO+w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKmqyKM_gcuNvR=2Rff29C5EAFTNiyz3XNTH5H4wt9W5JbmO+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/23/24 10:43, Alistair Francis wrote:
>>> #define get_field(reg, mask) (((reg) & \
>>>                   (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
>>>
>>> Notice that part of this expression is "(mask) << 1". So Coverity complains
>>> that we took a constant value and shifted it right off the top.
>>>
>>> I think this is probably a false positive, but why is target/riscv
>>> using its own ad-hoc macros for extracting bitfields? We have
>>> a standard set of extract/deposit macros in bitops.h, and not
>>
>> Thanks for pointing those out. I checked the get_field usage from the
>> beginning of riscv support 6 years back.
>> There are tons of users of get_field in a bunch of riscv sources. I
>> guess it was just added once and everybody kept using it
>> without switching to generic functions.
> 
> I think you are right about that

I think this macro comes from spike, and it was copied in with a bunch of other basic isa 
defines at the start of the qemu port.


r~

