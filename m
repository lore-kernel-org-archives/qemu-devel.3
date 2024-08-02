Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE0EC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZn7q-0005FG-J3; Fri, 02 Aug 2024 03:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn7o-00055T-VY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn7n-0000qJ-7v
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc569440e1so70422625ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722585294; x=1723190094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aJIhHfo6pnRjvR4HN1VJkUCbHIKUemyeHIy65ssiiu8=;
 b=AwzWfWZlzZMowiuBDmti2EoZi8T6gz0v2SGwyJwcmdnIbiPYwSCeFILadHVODWLUYC
 U9vv76NaeRsJRkn0FqkfydLC3sxxPTwqTORZr8jbW0KKr+eK7EFdKE9FVv92c4P+8V93
 OFot/YZsiXXZtt1jWljNSp4nq61YKrtJhbJfFT0y7Hm3oV2OnK2EV6InU2UJe3LS7xwd
 3O7RzkBkLKix9yEr5wnTberpXldyTWpWI4s7ji0zViWLbHKG9M6SonsoyQ9SnsYjA5k3
 fcoqWgZ90PNKvZFa+sFLKjvDSJuDUxQjQFZFYV281SBp2P/dpd4El8x7lqx+j9lGpGQf
 DjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722585294; x=1723190094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJIhHfo6pnRjvR4HN1VJkUCbHIKUemyeHIy65ssiiu8=;
 b=FAfyt0NPyuGrU3zneXnBYgNIdVwQwbawnGyhkW9cUBWbm8EejY37be7OkXIAFbGOu3
 CM4nH5gSlH1d+1kNYk6XTVz5CB9rzf+xl1Vn/xaIwgVfHv2EhzcVj/m5MBA79+YdeiT1
 d3ma4RXpQvLhxnVpK4iz7b9f+1AKTFhcAq/hfnmnwwXf8V+kvNM+GydgK1OtkzBSC3Og
 8HTn2EMaFZqscPHeWSvxkHgR8fYK/aSsfXum0Yx86yBa2p/2dFJt77bTX47BKkEhnK/a
 y0jS9PaA3IEBNYV7tl3TAO4bEwL+0H4LBYwyAgDqbQzrI4IYO88QCh+gkUIZY76Hjxer
 XU+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEub62Aj26e6mqskpItYz5kg5MWoPSmRO/UTUdEwszKWS4yaZWW0NvuV+OCKhrHdYqAOTRjq1WtYwCG1pF3Q8WmKD/d/w=
X-Gm-Message-State: AOJu0YzV9/sJION4v9pgM1FU1jMnrwxyLSjkyx8o9I8aSudcMWGYJDRK
 51K2o9hX3QoNFfcRIEeS6XrYolmxv1YuBscqx/afq076KFBKKrGqj6aaPZKL3b0=
X-Google-Smtp-Source: AGHT+IE9TkovIsbohvUcUrvQMVqKHcVbCLcJH9vlVlvbp/OTOzuio2BSwDRLn8MEn3iX0khGc3vDtQ==
X-Received: by 2002:a17:902:d2c6:b0:1fd:88d2:4804 with SMTP id
 d9443c01a7336-1ff572ce524mr29201345ad.34.1722585293499; 
 Fri, 02 Aug 2024 00:54:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f53435sm11074645ad.64.2024.08.02.00.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:54:53 -0700 (PDT)
Message-ID: <e6be2cbe-daf5-40fb-9870-928c86599317@linaro.org>
Date: Fri, 2 Aug 2024 17:54:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/riscv: Relax fld alignment requirement
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/2/24 17:24, LIU Zhiwei wrote:
> According to the risc-v specification:
> "FLD and FSD are only guaranteed to execute atomically if the effective
> address is naturally aligned and XLEN≥64."
> 
> We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
> not violate the rules. But it will hide some problems. So relax it to
> MO_ATOM_NONE.
> 
> Signed-off-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

