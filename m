Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C6C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se3ND-0003lo-Ls; Tue, 13 Aug 2024 22:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se3NA-0003i4-Qt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:04:25 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se3N8-00063A-OL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:04:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7bcf8077742so4410089a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723601060; x=1724205860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CY6BzFhLlJJqWWiDABcCBX3Ss/pqRNMIuNL9bhFq/lo=;
 b=UoEu/Mi8/aNwFhiCaddL+hyZnKcYXgKB+MKYc4Pt12qXY5Zazga9pd+e2tKUVKeGAR
 mqY+3jLQD/NqZMNDsHBKB9ME8OOqXzHY4s8t9b7SYrLqwr6YOdd4PizGlf7jkomZl9j1
 ZVNpnymMZVtSef7ap4uE4kquuR73alnK2a2EzMbiHhz9rhfuvTeb+vhCagL4QblI1keF
 XujrXn009WbyMoFd6VNQzM/wUdaqTKJQ2/OWnLH2830CYePtvbu1uRFK11KJDrYM1/CD
 tlSZB2lYtJag4FTHYh7IaK4tQsd/WOzjsfFNH3WjoB0tBbzY4lEd41FlZyICs5Uqfu6j
 5aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723601060; x=1724205860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CY6BzFhLlJJqWWiDABcCBX3Ss/pqRNMIuNL9bhFq/lo=;
 b=KnTGqzDx9q0SxqUKaS3AIyi2rzLJC42e66kRdHAFiLHEFJVgWNRahipeYswKGOxIDl
 YwrpCKY7TU/6TV3omPB+zlPr8P12GVE0Aya6FDgpHatnRtHm1UFrZproG7H6DLgNBAsX
 fHNT8eIIXqXuFdJH0RvZWNNXcX6p1pRsBByeINkKghcOd013NPaFDBIdq91Ho3cNL1UT
 jwYeHNGJJlJrsmD7BPcZds7cVcNaafcKiWCarPe5p1MJOPGlDmHojDMAMGIwelQaC232
 lxWLworsUrOUoaFc4YsrYenJ1Z8qMNjZsJ6m0F4CFS3EfOi7BkQfIf4K+G0INsyr5/84
 pRmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHYtsy96tBioXgkW37opDNqzRJcH+ueN3FxvHdv4+UTE06Fo3qd+cv1bQzNkMe2OIpZgwamZvFIyInoY7Uhy2xrmiN55U=
X-Gm-Message-State: AOJu0YxL0ZhE5iFvBTsHCvVrwqgEwoG6t+qbbA4NeA9e/WODOyJIglIV
 9eS2RWwjGw+AIpM5UKOsPCLcaWwy4WEK/L+wcXRe9tpdZZoDew3cnwTpIikhWkc=
X-Google-Smtp-Source: AGHT+IE2RSbd/8Jn67j9h7Y+GARv7SXXLjV5hN5go/bAMSzaZNfbMB5zYTZwgCBTmcUyMrd+ZqK9Iw==
X-Received: by 2002:a05:6a20:9f07:b0:1c4:c795:ee6a with SMTP id
 adf61e73a8af0-1c8eae900camr1959634637.28.1723601059970; 
 Tue, 13 Aug 2024 19:04:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a8c454sm6350013b3a.180.2024.08.13.19.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 19:04:19 -0700 (PDT)
Message-ID: <149df4e8-f51c-4925-8c65-e8e10fed85a3@linaro.org>
Date: Wed, 14 Aug 2024 12:04:13 +1000
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
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1e61235e-1cb8-4bc1-9983-6e8dc0c3b406@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/14/24 10:58, LIU Zhiwei wrote:
> Thus if we want to use all registers of vectors, we have to add a dynamic constraint on 
> register allocation based on IR types.

My comment vs patch 4 is that you can't do that, at least not without large changes to TCG.

In addition, I said that the register pressure on vector regs is not high enough to 
justify such changes.  There is, so far, little benefit in having more than 4 or 5 vector 
registers, much less 32.  Thus 7 (lmul 4, omitting v0) is sufficient.


r~

