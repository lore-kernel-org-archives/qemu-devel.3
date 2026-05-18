Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE96CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmU2-00068f-Qc; Sun, 17 May 2026 21:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmTn-0005sg-6K
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:09:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmTk-0007eR-DE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:09:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c80227b1f6cso515778a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066547; x=1779671347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8O5bSxkUzl4v9NSeXopURKR4ajUm+UL0/YrLhSHSUeI=;
 b=l23pCx5T877Q/PlppRt236iPRph5Yed+enbbCEP2VUYEYsK4iGbpOW891YQnOUv+ZQ
 APD8wSfKfPen7EG4XmAExvaJiQZWZEQD7l4F1V3vDgEs6UCt/ZTsarbvSWQwh07Cz2cP
 nIYD2/5tatUawfsxwKsALipNaLNGoXUf5C8IhyoxFYXRDmgdAK8+w9MqZR2x3rwGnq8E
 UUO5nx6C7iqWMR+yMV8cETI89VNRmfej5CMwI55ja7bcMhQTaaKvez6r0/UR4Sa3tant
 sYTzh9VDUOLcZRIKtiNNLC7yIxO+SF20MrRe96ZPFO/YHyLp5cuXDrfY4pI9q+SyLsue
 Ckiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066547; x=1779671347;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8O5bSxkUzl4v9NSeXopURKR4ajUm+UL0/YrLhSHSUeI=;
 b=RIjmBPLLfN9nOUJ53DWXXZ8Epm3aXHqeyFy5qTF0M5UrbqdX8ksqJSBtxSoj/NI4gq
 C3KrDqQAI9XjyeZ02kAnP0PyUme5HIO++ExCd76aOERkbXWUnJO1PsKIJGwd0cdR6/nU
 DljMjwlHgG4SXwa5bkOnoiFz7swt3uurTxhVWvV5/KRYF2Ieh2OGwIBrQp/7h1Efjfxb
 lJ7FbM4oLiIfuX+r9Ey5E413XeBCfb17a0umlI5CLMmhrSTJmLMFTc12IXhhKiyzVN30
 Ax6fWESgxSZRma1PFzzgEFa7bxWZu7mWs45ydISpqHMR34ko2ko7mtBPN9vR2y7M0q0n
 HWSA==
X-Gm-Message-State: AOJu0YydmDE35fWlvvhmPM83uVwCedtCL3+pnYJMh2AZmMZZ56EjVniB
 iUktkHLjuwaRbusWyLaSRnwlwP1PeaoQmBPHcPHcCnXJxkJGMjIQzmW2XYP85xHiIvv1c8O9RFp
 4BxgA
X-Gm-Gg: Acq92OGd4JE7JhzR9bKmE8gzvyy6QWSbrhdXdWkgl2ycn8e9b1Akdn3I8ViqBWv4M53
 q9/GRxOqGo2ih9jYUmBWQmusFSMx43IRBNsnTSpNaHK9fbO+L9DzqrY+lh6fj0F9eewjG7anRan
 d4IJk/Vc+8xNd2IbGLuyAYUmvephWrMXNUFogfUzgFWfp+/MDU2TGcW8xV0OgYTefhDOY1xslC6
 oVw8NTYMHQXHFWaE2Ozr6RjEV7CrX4r3wBlaR2tuZTNa5XrQhjYTqUuW0ZEVsVwvJk4FMBc07/h
 r8+25bkkvBzZdWZDvkjLed67Whs419aXpTN2dC9+HjWm7toV9BBE2j0rzJr0o/2TG4w6RZmc6hs
 3BDoidqwtebtFz14ssRey8n/2mLllftpfB5RxCOlnuYmNCn3hY+lAeSZ5Cvm/pjIZFM8MZpT56i
 7d9B+FyLcguyuuLmc/fxutj6RJvkfwKpwfaN4s
X-Received: by 2002:a05:6a21:3298:b0:3a2:d68d:9e79 with SMTP id
 adf61e73a8af0-3b22ec7cfb4mr14810490637.41.1779066546631; 
 Sun, 17 May 2026 18:09:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb06268asm10927324a12.1.2026.05.17.18.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 18:09:06 -0700 (PDT)
Message-ID: <b810964c-1b11-4e9b-8e55-ad07f8a63065@linaro.org>
Date: Sun, 17 May 2026 18:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 26/35] target/mips: add Octeon LA* atomic instructions
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-26-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-26-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/26 10:37, James Hilliard wrote:
> Implement the Octeon LA* read-modify-write atomic instruction family:
> LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.
> 
> These operations are architecturally distinct from SAA/SAAD and are used
> by existing Octeon user-mode code for atomic counters, bit operations,
> and exchange-style updates.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Keep LA* atomics naturally aligned per Octeon L2 transaction
>      semantics.
>    - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
>      Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
>      (suggested by Richard Henderson)
>    - Group LA* translator wrappers by argument shape instead of adding one
>      wrapper per instruction.  (suggested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Use i64 atomic helpers for both word and doubleword paths and select
>      word sign-extension through MO_SL.  (suggested by Richard Henderson)
> 
> Changes v5 -> v6:
>    - Rename the shared translator helpers to distinguish fetch-add and
>      exchange operations.
> ---
>   target/mips/tcg/octeon.decode      | 17 +++++++++
>   target/mips/tcg/octeon_translate.c | 74 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

