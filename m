Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DFBC54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 22:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcufC-0006sq-V2; Wed, 21 Feb 2024 17:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuf7-0006my-7r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:01:58 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuf5-0001rO-IM
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:01:56 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so825984a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708552914; x=1709157714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vGjcaAMS/pFVOd9tMCi7xcan6TPFOQeGQN8PZL/jkI4=;
 b=MPuc5T44mugmpyuLUfywj+3+Xvweazrebz1+AxNc1b3t/Fs6wVTATyyEj+6vLff0m2
 1s4GMlVAUKqBUE6m6ZVzIUtMRLPBXJSIjBR4GCyndW+r1olQmR3qGkzGdlGdxiCOOXyJ
 NqWbox6GK2vRxW1XvIkqNcp9LlP29NKpR4jCW59tMffFX5Ykdpg8qbfEncbQoaR4XInA
 2hIvRtIY3kLeQg4SH1knOQYW40kR7Tcvf9BhpX6h3AtKAskL3972wveweVEKFLgaD35u
 aMMm8VRM5ODIxsyj++y7ITgq4uP9cDY76XniE27bI7iOsNUzj7jx+uH/buSwMvMCxw5p
 E+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708552914; x=1709157714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGjcaAMS/pFVOd9tMCi7xcan6TPFOQeGQN8PZL/jkI4=;
 b=LJY2mJTyqzkE9RHH5zgwmc8Pn7FsQqHRsc7ObEiJasbeK/xPhNmFqh9ZFygbl2Xb2T
 FygOSZEdBlhb2aQHecFwCKuPg5JXPIK8+37VLbdZ8QpNZV5FCJFoVkvrljnh58hhIJo/
 jz1AxGbn5Xv1vt02yv0znFbG+rLpBLY1Y7+TOTx5B87o3UzWKvlg2zWts14zZtpL3Ar5
 T9RRaCyDTEPq2lcN9M2pA1QIBuUleCAU7J4HRf0VV1oke7cpT1+RHICxNiLd2DGIfk2R
 4tcdLLrE5iEdocSNlO8eDLIf6Lo0LuycQks/y1tM24xMdJz2WlBrhtbo9D0u4J2NO0si
 1L/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX37FKfv0jbxWSMgXAcmx2YQVfLMugRhry7xTBPlo29ofrLQDspKBY+chUI1YxBwgxSp/8WL1TIPsvZQntLh08YreLqPN0=
X-Gm-Message-State: AOJu0YxBXa33MZ4bMbxVnOYz6ZNtPhF+1EQQL52JdIbnhK5HCTmKFGnz
 h6eRATQa++n4N6pN2aTmWUw9IeElEJW8F1W5GM1DFsW6mTZ0zx0P1fVa6QQdWzk=
X-Google-Smtp-Source: AGHT+IH0xEABO/kYvw+bZRxGmT4ERDROjwx6WboIqTQCGrgkjaJb/+wPTtkkF4JDtIKBJBSYovVzcg==
X-Received: by 2002:a05:6a21:1585:b0:1a0:8c9c:acfa with SMTP id
 nr5-20020a056a21158500b001a08c9cacfamr15036113pzb.34.1708552914302; 
 Wed, 21 Feb 2024 14:01:54 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c18-20020a056a00009200b006dff3ca9e26sm9382389pfj.102.2024.02.21.14.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 14:01:53 -0800 (PST)
Message-ID: <a28c9132-d5d9-405c-aa4e-bc208b364ed3@linaro.org>
Date: Wed, 21 Feb 2024 12:01:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] target/riscv: remove 'cpu_vl' global
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-6-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221213140.365232-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 2/21/24 11:31, Daniel Henrique Barboza wrote:
> At this moment the global is used only in do_vsetvl(). Do a direct env
> load in do_vsetvl() to read 'vl' and remove the global.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
>   target/riscv/translate.c                | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

