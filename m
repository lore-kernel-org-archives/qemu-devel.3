Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C78AC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccYQ-00059L-Nu; Tue, 20 Feb 2024 21:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rccYO-00057S-Cq
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:41:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rccYL-0004cX-65
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:41:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so45537595ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708483302; x=1709088102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mu4szxNVj3C4TbtX2td3ZzbZLPaQ++2cCYJyyvAsxHY=;
 b=ARDtBzjNnsWMe1gW5uslbEzq4LIj++fDxfh8iXVmrw5bK2SZILGtCK6EGjjhDDuxU3
 waCNIFl1ptq8AQtPcLmSF7bjJx8qjbX4FES+Vu+MQ2vTmKujKmfEYSBlWVpILm0Vb3qw
 PTYwdtXqkVhRnjW4BUqMbG6Ai+yugaxpUhIbFPCmDYu6RN9FRhcVUioVvL1JcJXg5ruT
 M+Jpjb4X4cYoaxE6vCnHAkPoqrRyzSF9JnySJypWdJWPTV6Yn9XNy2NJtjAPfYQXi/6z
 H+4/WSc9g/rMnSwdTayFj8gsS5qYwl+YqANYyuC8l9AI8jx0TCEmVU3lP3CT6qhlRVgI
 FJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708483302; x=1709088102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mu4szxNVj3C4TbtX2td3ZzbZLPaQ++2cCYJyyvAsxHY=;
 b=OZ8vYO7S99peNBy05H049+s1VFMbxNkUa9O3yz2+KZRrswO5UP1wrkAMLTmp/xjPlY
 9AOa4SrAeyjx9sVChYxtCfa3uVhxigN1VBgc+UlgakED/BqZL+8n1sG9ZZJtJ/1TGu6W
 Mhhge4XBYdhbVhpY4UbrnP9pCG1rTc/NbXqYdDMzXbh3fUIQTxLrsmamXs9M1B/DSr+s
 L2c8bEqGHbkHJ3LLdHVq7gJ8it+HdyFYtnYoe1YcMxFrWP8O8H4C2nQkeBqvGJaD+AG2
 jFf5uAWZrlL1RzPbdFZhkVNzTx6qRDVsoNeKQVzGZmCmjmJulNieTxWlJBtWuOKt3aPW
 cGkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWub6hfM9V9qgqYAXseHLezQmK+GN1M67sbFJdHFfc63AsAmpvonLMaXk0limPCg0KH+LwoMo36a+Ala4OIGcc9m4ecSN8=
X-Gm-Message-State: AOJu0YxZTMr6T9iaMHT/TBPLYX7s5yl7zzhO3RmZoCO8jvv5i6uRzgbh
 rib7gZ6g8M6MC3thj14bmCmqV99sSBps7nQv+Xqub2ZiRPNn2GWCzbIjcMH5AaA=
X-Google-Smtp-Source: AGHT+IG6yjwLUrj8rBED0JiKysvUX1BCDGwybHJ5sgLgIuA66cIeoz4yJLJjv2zgEGInSWqxdFat5w==
X-Received: by 2002:a17:902:bb93:b0:1db:6dfc:5c56 with SMTP id
 m19-20020a170902bb9300b001db6dfc5c56mr17897070pls.30.1708483302343; 
 Tue, 20 Feb 2024 18:41:42 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l4-20020a170902d04400b001d949e663d5sm6979058pll.31.2024.02.20.18.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 18:41:41 -0800 (PST)
Message-ID: <47c3cb02-9a1c-4ac0-a815-3a3cdcaa9fab@linaro.org>
Date: Tue, 20 Feb 2024 16:41:37 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] target/riscv/translate.c: remove 'cpu_vstart'
 global
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240221022252.252872-1-dbarboza@ventanamicro.com>
 <20240221022252.252872-5-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221022252.252872-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/20/24 16:22, Daniel Henrique Barboza wrote:
> The global is unused after recent changes.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Does this leave exactly one use of cpu_vl, in do_vsetvl()?
If so, it would be worth removing that too, replacing the single use with an explicit load 
from env.


r~

