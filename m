Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A8C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2Cb-00004y-Lz; Fri, 15 Mar 2024 03:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2CY-0008QZ-CN
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:42:03 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2CV-00082Y-9Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:42:02 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e67b5d6dd8so209611a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710488514; x=1711093314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PJw0CT3HJxC/JpAYV7HeBsnYp2hKKeEy0fQ9cCIs4mw=;
 b=LpagDnzGnqrZb1dv9j77ZjF9DzYSlVRhkTm170ge5J5N7oKNsDA8vlIN2UCHumG1p9
 bbGfB5UTo1fQTQMjGyxRyDDw3HZN29mkdIkw+QKHHTzYDFfDNGeZQ4slWf0GPcjCh6Ay
 XaAa/FFjQpU1sQyBN5iwUm/sDlaIRdKneRQPOe4h1c8Gdyo+FJrhsomuinmRC0GkZcbb
 aLYm1sT/EEX7818FQymGGi8UsMcOUWgAAL9CaVNc4PTppUlo3/6OXboe3MC9doP5/nZ6
 pnLSRKgB8htkRy+lm6d3tbYmboryJl/8Gc2GWJ5vnaV9fRlYqEfp2klPnFhdIROiKGSn
 hpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710488514; x=1711093314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJw0CT3HJxC/JpAYV7HeBsnYp2hKKeEy0fQ9cCIs4mw=;
 b=Q4AJr0vFt7rDCz8EBKfmFrYByQO4hMwQ6ytA9zilVUMTNBTR2Vl2Jd7qpf4ZFaV6HX
 qL8thG5kAe31bRIjqZ/5vDprArTmA3K3WS/k/gbSWRg7gc4BOe6iY0JFdqqnr4L1+kDt
 Bnr09ovM7m8nAmUlDwi2fZrldq002P3REzAIZibe3Ei/+tyasVNpb4bJkRR1p1NyZFAk
 ZoP5L/f0gCnpH4gJ4KM0VQWpUUrUo9iERpOSjveQUnY2l8Suu1HekfsiRU2kd/Wep0wW
 6FaXCYBrisgLs3AH/9vQWQSFesHbmXuaK9p58Dsle+8cCskrREkslPm2DseD2FOA7g3v
 T3Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdkR8Z9BWH9DcoR+0Bz/Y3BJym52SRSlIu4KACUqsELH56SCrUQP4mAtS/ctm96Iz/+4rxdmMckTQ4GKWzp07ZnJ3AcY8=
X-Gm-Message-State: AOJu0YxDVWwmWtFQQXmAjUuvJ7HrDAJtCD3jhdcdMbbEi2P+aYCheBHZ
 Hcixlfn5FGkNaXGjjw7qUGRCMd2uZZHGJNMYvSuvtuZPbZBiziwpn12XmM/dxno=
X-Google-Smtp-Source: AGHT+IFAgyEJQfsyAtxtAnDEGOXlmjK2aLcr+UI9vPHtP8JsLt9upRaRg3wZ3qadzv7BZr1Hoou/7Q==
X-Received: by 2002:a05:6830:16d0:b0:6e5:3dc6:d84a with SMTP id
 l16-20020a05683016d000b006e53dc6d84amr4800287otr.24.1710488514628; 
 Fri, 15 Mar 2024 00:41:54 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z8-20020a63c048000000b005c6e8fa9f24sm1926558pgi.49.2024.03.15.00.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 00:41:54 -0700 (PDT)
Message-ID: <b4d4bd8c-57ad-4bd7-9d57-d6dc90b13fda@linaro.org>
Date: Thu, 14 Mar 2024 21:41:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 04/10] target/riscv: always clear vstart in
 whole vec move insns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-5-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240314175704.478276-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 3/14/24 07:56, Daniel Henrique Barboza wrote:
> These insns have 2 paths: we'll either have vstart already cleared if
> vstart_eq_zero or we'll do a brcond to check if vstart >= maxsz to call
> the 'vmvr_v' helper. The helper will clear vstart if it executes until
> the end, or if vstart >= vl.
> 
> For starters, the check itself is wrong: we're checking vstart >= maxsz,
> when in fact we should use vstart in bytes, or 'startb' like 'vmvr_v' is
> calling, to do the comparison. But even after fixing the comparison we'll
> still need to clear vstart in the end, which isn't happening too.
> 
> We want to make the helpers responsible to manage vstart, including
> these corner cases, precisely to avoid these situations:
> 
> - remove the wrong vstart >= maxsz cond from the translation;
> - add a 'startb >= maxsz' cond in 'vmvr_v', and clear vstart if that
>    happens.
> 
> This way we're now sure that vstart is being cleared in the end of the
> execution, regardless of the path taken.
> 
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
>   target/riscv/vector_helper.c            | 5 +++++
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

